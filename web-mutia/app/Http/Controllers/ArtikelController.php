<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Artikel;
use Illuminate\Support\Str;

class ArtikelController extends Controller
{
    // 🔹 HALAMAN PUBLIK (LIST)
    public function index(Request $request)
    {
        $query = Artikel::where('status', 'publish');
        
        if ($request->has('kategori') && !empty($request->kategori)) {
            $query->where('kategori', $request->kategori);
        }
        
        $artikels = $query->orderBy('created_at', 'desc')->paginate(6);
        
        return view('articles', compact('artikels')); // ✅ FIX
    }

    // 🔹 HALAMAN DETAIL
    public function show($slug)
    {
        $artikel = Artikel::where('slug', $slug)->firstOrFail();
        
        $artikel->increment('views');
        
        return view('article-detail', compact('artikel')); // ✅ FIX
    }

    // ================= ADMIN =================

    public function adminIndex()
    {
        $artikels = Artikel::orderBy('created_at', 'desc')->paginate(10);
        return view('admin.artikel.index', compact('artikels'));
    }

    public function create()
    {
        return view('admin.artikel.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'judul' => 'required|min:5|max:200',
            'isi' => 'required',
            'kategori' => 'required',
            'status' => 'required|in:draft,publish',
            'gambar' => 'nullable|image|mimes:jpeg,png,jpg|max:10240',
        ]);

        $gambarPath = null;
        if ($request->hasFile('gambar')) {
            $gambarPath = $request->file('gambar')->store('artikel', 'public');
        }

        Artikel::create([
            'judul' => $request->judul,
            'slug' => Str::slug($request->judul),
            'isi' => $request->isi,
            'gambar' => $gambarPath,
            'kategori' => $request->kategori,
            'status' => $request->status,
            'views' => 0,
        ]);

        return redirect()->route('admin.artikel.index')
                         ->with('success', 'Artikel berhasil ditambahkan!');
    }

    public function edit($id)
    {
        $artikel = Artikel::findOrFail($id);
        return view('admin.artikel.edit', compact('artikel'));
    }

    public function update(Request $request, $id)
    {
        $artikel = Artikel::findOrFail($id);

        $request->validate([
            'judul' => 'required|min:5|max:200',
            'isi' => 'required',
            'kategori' => 'required',
            'status' => 'required|in:draft,publish',
            'gambar' => 'nullable|image|mimes:jpeg,png,jpg|max:10240',
        ]);

        $data = [
            'judul' => $request->judul,
            'isi' => $request->isi,
            'kategori' => $request->kategori,
            'status' => $request->status,
        ];

        if ($artikel->judul != $request->judul) {
            $data['slug'] = Str::slug($request->judul);
        }

        if ($request->hasFile('gambar')) {
            if ($artikel->gambar && file_exists(storage_path('app/public/' . $artikel->gambar))) {
                unlink(storage_path('app/public/' . $artikel->gambar));
            }
            $data['gambar'] = $request->file('gambar')->store('artikel', 'public');
        }

        $artikel->update($data);

        return redirect()->route('admin.artikel.index')
                         ->with('success', 'Artikel berhasil diupdate!');
    }

    public function destroy($id)
    {
        $artikel = Artikel::findOrFail($id);
        
        if ($artikel->gambar && file_exists(storage_path('app/public/' . $artikel->gambar))) {
            unlink(storage_path('app/public/' . $artikel->gambar));
        }
        
        $artikel->delete();

        return redirect()->route('admin.artikel.index')
                         ->with('success', 'Artikel berhasil dihapus!');
    }
}
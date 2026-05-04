@extends('layouts.main')

@section('content')
<section class="container py-5">
    <h2 class="fw-bold mb-4">Edit Artikel</h2>

    <form action="{{ route('admin.artikel.update', $artikel->id) }}" method="POST" enctype="multipart/form-data">
        @csrf
        @method('PUT')

        <div class="mb-3">
            <label>Judul</label>
            <input type="text" name="judul" value="{{ $artikel->judul }}" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Isi</label>
            <textarea name="isi" rows="6" class="form-control" required>{{ $artikel->isi }}</textarea>
        </div>

        <div class="mb-3">
            <label>Kategori</label>
            <input type="text" name="kategori" value="{{ $artikel->kategori }}" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Status</label>
            <select name="status" class="form-control">
                <option value="draft" {{ $artikel->status == 'draft' ? 'selected' : '' }}>Draft</option>
                <option value="publish" {{ $artikel->status == 'publish' ? 'selected' : '' }}>Publish</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Gambar Baru</label>
            <input type="file" name="gambar" class="form-control">
        </div>

        <button class="btn btn-warning">Update</button>
        <a href="{{ route('admin.artikel.index') }}" class="btn btn-secondary">Kembali</a>
    </form>
</section>
@endsection
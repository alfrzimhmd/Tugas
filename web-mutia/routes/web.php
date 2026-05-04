<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArtikelController;

// ==================== HALAMAN STATIS ====================
Route::get('/', function () {
    return view('home');
});

Route::get('/profile', function () {
    $data = [
        "name" => "Muftia Ayu",
        "address" => "Salatiga",
        "email" => "muftiaayu@example.com",
        "univ"=> "UINSAGA"
    ];
    return view('profile', compact('data'));
});

// ==================== BLOG PUBLIK ====================
Route::get('/articles', [ArtikelController::class, 'index'])->name('articles.index');
Route::get('/articles/{slug}', [ArtikelController::class, 'show'])->name('articles.show');

// ==================== ADMIN ====================
Route::prefix('admin')->group(function () {
    Route::get('/artikel', [ArtikelController::class, 'adminIndex'])->name('admin.artikel.index');
    Route::get('/artikel/create', [ArtikelController::class, 'create'])->name('admin.artikel.create');
    Route::post('/artikel', [ArtikelController::class, 'store'])->name('admin.artikel.store');
    Route::get('/artikel/{id}/edit', [ArtikelController::class, 'edit'])->name('admin.artikel.edit');
    Route::put('/artikel/{id}', [ArtikelController::class, 'update'])->name('admin.artikel.update');
    Route::delete('/artikel/{id}', [ArtikelController::class, 'destroy'])->name('admin.artikel.destroy');
});
@extends('layouts.main')

@section('content')
<section class="container py-5">

    <div class="mb-4">
        <a href="/articles" class="btn btn-outline-dark btn-sm">← Kembali</a>
    </div>

    <div class="card shadow-sm border-0">
        <img src="{{ $artikel->gambar_url }}" class="card-img-top">

        <div class="card-body p-4">
            <h2 class="fw-bold mb-3">{{ $artikel->judul }}</h2>

            <p class="text-muted small">
                Kategori: {{ $artikel->kategori }} |
                Views: {{ $artikel->views }}
            </p>

            <hr>

            <p style="line-height: 1.8">
                {{ $artikel->isi }}
            </p>
        </div>
    </div>

</section>
@endsection
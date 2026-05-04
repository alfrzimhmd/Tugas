@extends('layouts.main')

@section('content')
<section class="container py-5">
    <h2 class="text-center fw-bold mb-5">Kumpulan Artikel</h2>

    <div class="row g-4">

        @forelse ($artikels as $item)
        <div class="col-md-4">
            <div class="card border-0 shadow-sm h-100">

                <img src="{{ $item->gambar_url }}" class="card-img-top">

                <div class="card-body d-flex flex-column">
                    <h5 class="fw-bold">{{ $item->judul }}</h5>

                    <p class="text-secondary">
                        {{ \Illuminate\Support\Str::limit($item->isi, 100) }}
                    </p>

                    <a href="/articles/{{ $item->slug }}"
                       class="btn btn-dark mt-auto rounded-pill">
                       Baca Selengkapnya
                    </a>
                </div>
            </div>
        </div>
        @empty
            <p class="text-center">Belum ada artikel.</p>
        @endforelse

    </div>

    <div class="mt-5 d-flex justify-content-center">
        {{ $artikels->links() }}
    </div>
</section>
@endsection
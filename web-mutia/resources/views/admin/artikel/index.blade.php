@extends('layouts.main')

@section('content')
<section class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Dashboard Artikel</h2>
        <a href="{{ route('admin.artikel.create') }}" class="btn btn-dark">
            + Tambah Artikel
        </a>
    </div>

    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Judul</th>
                        <th>Kategori</th>
                        <th>Status</th>
                        <th>Views</th>
                        <th width="150">Aksi</th>
                    </tr>
                </thead>
                <tbody>

                @forelse ($artikels as $item)
                    <tr>
                        <td>{{ $item->judul }}</td>
                        <td>{{ $item->kategori }}</td>
                        <td>
                            <span class="badge bg-{{ $item->status == 'publish' ? 'success' : 'secondary' }}">
                                {{ $item->status }}
                            </span>
                        </td>
                        <td>{{ $item->views }}</td>
                        <td>
                            <a href="{{ route('admin.artikel.edit', $item->id) }}" 
                               class="btn btn-sm btn-warning">Edit</a>

                            <form action="{{ route('admin.artikel.destroy', $item->id) }}" 
                                  method="POST" 
                                  class="d-inline">
                                @csrf
                                @method('DELETE')

                                <button class="btn btn-sm btn-danger"
                                        onclick="return confirm('Yakin hapus?')">
                                    Hapus
                                </button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5" class="text-center">Belum ada artikel</td>
                    </tr>
                @endforelse

                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4">
        {{ $artikels->links() }}
    </div>

</section>
@endsection
From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Fri, 18 Mar 2022 05:28:57 +0000
Subject: [PATCH v2 4/4] makedumpfile: print error when reading with
 unsupported compression
In-Reply-To: <20220314160432.9414-5-prudo@redhat.com>
References: <20220314160432.9414-1-prudo@redhat.com>
 <20220314160432.9414-5-prudo@redhat.com>
Message-ID: <TYYPR01MB6777E6344C250E5C94E94096DD139@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

-----Original Message-----
> Currently makedumpfile only checks if the required compression algorithm
> was enabled during build when compressing a dump but not when reading
> from one. This can lead to situations where, one version of makedumpfile
> creates the dump using a compression algorithm an other version of
> makedumpfile doesn't support. When the second version now tries to, e.g.
> extract the dmesg from the dump it will fail with an error similar to
> 
> 	# makedumpfile --dump-dmesg vmcore dmesg.txt
> 	__vtop4_x86_64: Can't get a valid pgd.
> 	readmem: Can't convert a virtual address(ffffffff92e18284) to physical address.
> 	readmem: type_addr: 0, addr:ffffffff92e18284, size:390
> 	check_release: Can't get the address of system_utsname.
> 
> 	makedumpfile Failed.
> 
> That's because readpage_kdump_compressed{_parallel} does not return
> with an error if the page it is trying to read is compressed with an
> unsupported compression algorithm. Thus readmem copies random data from
> the (uninitialized) cachebuf to its caller and thus causing the error
> above.
> 
> Fix this by checking if the required compression algorithm is supported
> in readpage_kdump_compressed{_parallel} and print a proper error message
> if it isn't.
> 
> Reported-by: Dave Wysochanski <dwysocha@redhat.com>
> Signed-off-by: Philipp Rudo <prudo@redhat.com>
> ---
>  makedumpfile.c | 56 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b7ac999..56f3b6c 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -865,9 +865,14 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +	} else if ((pd.flags & DUMP_DH_COMPRESSED_LZO)) {
>  #ifdef USELZO
> -	} else if (info->flag_lzo_support
> -		   && (pd.flags & DUMP_DH_COMPRESSED_LZO)) {
> +		if (!info->flag_lzo_support) {
> +			ERRMSG("lzo compression unsupported\n");
> +			out = FALSE;

I removed those "out = FALSE;" lines because it's already initialized to FALSE.

Thanks,
Kazu

> +			goto out_error;
> +		}
> +
>  		retlen = info->page_size;
>  		ret = lzo1x_decompress_safe((unsigned char *)buf, pd.size,
>  					    (unsigned char *)bufptr, &retlen,
> @@ -876,9 +881,14 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +#else
> +		ERRMSG("lzo compression unsupported\n");
> +		ERRMSG("Try `make USELZO=on` when building.\n");
> +		out = FALSE;
> +		goto out_error;
>  #endif
> -#ifdef USESNAPPY
>  	} else if ((pd.flags & DUMP_DH_COMPRESSED_SNAPPY)) {
> +#ifdef USESNAPPY
> 
>  		ret = snappy_uncompressed_length(buf, pd.size, (size_t *)&retlen);
>  		if (ret != SNAPPY_OK) {
> @@ -891,14 +901,24 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +#else
> +		ERRMSG("snappy compression unsupported\n");
> +		ERRMSG("Try `make USESNAPPY=on` when building.\n");
> +		out = FALSE;
> +		goto out_error;
>  #endif
> -#ifdef USEZSTD
>  	} else if ((pd.flags & DUMP_DH_COMPRESSED_ZSTD)) {
> +#ifdef USEZSTD
>  		ret = ZSTD_decompress(bufptr, info->page_size, buf, pd.size);
>  		if (ZSTD_isError(ret) || (ret != info->page_size)) {
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +#else
> +		ERRMSG("zstd compression unsupported\n");
> +		ERRMSG("Try `make USEZSTD=on` when building.\n");
> +		out = FALSE;
> +		goto out_error;
>  #endif
>  	}
> 
> @@ -964,9 +984,14 @@ readpage_kdump_compressed_parallel(int fd_memory, unsigned long long paddr,
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +	} else if ((pd.flags & DUMP_DH_COMPRESSED_LZO)) {
>  #ifdef USELZO
> -	} else if (info->flag_lzo_support
> -		   && (pd.flags & DUMP_DH_COMPRESSED_LZO)) {
> +		if (!info->flag_lzo_support) {
> +			ERRMSG("lzo compression unsupported\n");
> +			out = FALSE;
> +			goto out_error;
> +		}
> +
>  		retlen = info->page_size;
>  		ret = lzo1x_decompress_safe((unsigned char *)buf, pd.size,
>  					    (unsigned char *)bufptr, &retlen,
> @@ -975,9 +1000,14 @@ readpage_kdump_compressed_parallel(int fd_memory, unsigned long long paddr,
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +#else
> +		ERRMSG("lzo compression unsupported\n");
> +		ERRMSG("Try `make USELZO=on` when building.\n");
> +		out = FALSE;
> +		goto out_error;
>  #endif
> -#ifdef USESNAPPY
>  	} else if ((pd.flags & DUMP_DH_COMPRESSED_SNAPPY)) {
> +#ifdef USESNAPPY
> 
>  		ret = snappy_uncompressed_length(buf, pd.size, (size_t *)&retlen);
>  		if (ret != SNAPPY_OK) {
> @@ -990,14 +1020,24 @@ readpage_kdump_compressed_parallel(int fd_memory, unsigned long long paddr,
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +#else
> +		ERRMSG("snappy compression unsupported\n");
> +		ERRMSG("Try `make USESNAPPY=on` when building.\n");
> +		out = FALSE;
> +		goto out_error;
>  #endif
> -#ifdef USEZSTD
>  	} else if ((pd.flags & DUMP_DH_COMPRESSED_ZSTD)) {
> +#ifdef USEZSTD
>  		ret = ZSTD_decompress(bufptr, info->page_size, buf, pd.size);
>  		if (ZSTD_isError(ret) || (ret != info->page_size)) {
>  			ERRMSG("Uncompress failed: %d\n", ret);
>  			goto out_error;
>  		}
> +#else
> +		ERRMSG("zstd compression unsupported\n");
> +		ERRMSG("Try `make USEZSTD=on` when building.\n");
> +		out = FALSE;
> +		goto out_error;
>  #endif
>  	}
> 
> --
> 2.35.1


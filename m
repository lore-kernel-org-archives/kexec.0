Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFFUq-0002bE-9x
 for kexec@lists.infradead.org; Fri, 30 Aug 2013 03:35:41 +0000
Date: Fri, 30 Aug 2013 11:34:50 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: reverse -c and -p if using snappy
 compression
Message-ID: <20130830033450.GA12036@dhcp-16-252.nay.redhat.com>
References: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

USESNAPPY is a switch which the snappy support has been built into.
With this flag, it means snappy compression algorithm is available.
Which compression algorithm is taken need be decided by -c/-l/-p. 

If I make a build with USELZO and USESNAPPY, then I want to test
zlib/lzo/snappy separately, then this patch will confuse me very
much. Current action and configuration are enough for me. So it's
better to leave the current action alone.

Baoquan
Thanks

On 08/28/13 at 05:08pm, Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> Reverse the meanings of -c (compression) and -p (snappy compression) if
> USESNAPPY is defined.
> 
> The distro kdump scripts seem to only support -c for compression.
> So make -c mean snappy compression if it is supported.
> 
> Diffed against makedumpfile-1.5.4
> Signed-off-by: Cliff Wickman <cpw@sgi.com>
> ---
>  makedumpfile.c |   10 ++++++++++
>  print_info.c   |   13 +++++++++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> Index: makedumpfile-1.5.4/makedumpfile.c
> ===================================================================
> --- makedumpfile-1.5.4.orig/makedumpfile.c
> +++ makedumpfile-1.5.4/makedumpfile.c
> @@ -8607,7 +8607,12 @@ main(int argc, char *argv[])
>  			info->name_filterconfig = optarg;
>  			break;
>  		case 'c':
> +#ifdef USESNAPPY
> +			/* if snappy is available make it the default */
> +			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
> +#else
>  			info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
> +#endif
>  			break;
>  		case 'D':
>  			flag_debug = TRUE;
> @@ -8656,7 +8661,12 @@ main(int argc, char *argv[])
>  			info->flag_dmesg = 1;
>  			break;
>  		case 'p':
> +#ifdef USESNAPPY
> +			/* is snappy is available only use zlib with -p */
> +			info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
> +#else
>  			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
> +#endif
>  			break;
>  		case 'P':
>  			info->xen_phys_start = strtoul(optarg, NULL, 0);
> Index: makedumpfile-1.5.4/print_info.c
> ===================================================================
> --- makedumpfile-1.5.4.orig/print_info.c
> +++ makedumpfile-1.5.4/print_info.c
> @@ -41,9 +41,9 @@ print_usage(void)
>  #endif
>  	MSG("snappy support:\n");
>  #ifdef USESNAPPY
> -	MSG("  enabled\n");
> +	MSG("  enabled using -c\n");
>  #else
> -	MSG("  disabled ('-p' option will be ignored.)\n");
> +	MSG("  disabled\n");
>  #endif
>  	MSG("\n");
>  	MSG("Usage:\n");
> @@ -90,8 +90,13 @@ print_usage(void)
>  	MSG("\n");
>  	MSG("Available options:\n");
>  	MSG("  [-c|-l|-p]:\n");
> -	MSG("      Compress dump data by each page using zlib for -c option, lzo for -l option\n");
> -	MSG("      or snappy for -p option. A user cannot specify either of these options with\n");
> +#ifdef USESNAPPY
> +	MSG("      Compress dump data by each page using zlib for -p option, lzo for -l option\n");
> +	MSG("      or snappy for -c option. A user cannot specify any of these options with\n");
> +#else
> +	MSG("      Compress dump data by each page using zlib for -c option or lzo for -l option\n");
> +	MSG("      A user cannot specify either of these options with\n");
> +#endif
>  	MSG("      -E option, because the ELF format does not support compressed data.\n");
>  	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
>  	MSG("\n");
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

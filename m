Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPV8-00030A-Pw
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 14:15:38 +0000
Date: Tue, 15 Jan 2019 15:15:28 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC v1] kexec: Prototype for signature verification within Xen
Message-ID: <20190115141528.jxjvnihe6p5rmvvs@verge.net.au>
References: <1547495527-30191-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547495527-30191-1-git-send-email-eric.devolder@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: daniel.kiper@oracle.com, kexec@lists.infradead.org, boris.ostrovsky@oracle.com, xen-devel@lists.xen.org

On Mon, Jan 14, 2019 at 01:52:07PM -0600, Eric DeVolder wrote:
> These changes work in conjunction with the signature
> verification support for Xen I published recently.
> 
> Prior to this change, kexec supported the following
> three modes of operation:
> 
> kexec_load:
> - unverified loading of kernel into Linux (original mode)
> - unverified loading of kernel into Xen
> kexec_file_load (the -s option to kexec):
> - verified loading of kernel into Linux
> 
> With the verified loading of a kernel into Linux, the scope
> of kexec changed drastically as the kernel performs most of
> the work that kexec previously did; the kernel does so so as
> to reduce the risk of compromise.
> 
> For example, the unverified loading of a kernel into Linux
> involves locating memory within the system to load the
> various pieces of data (kernel, initramdisk, command line)
> as well as reserving additional memory such as the first 1MB
> on x86 for legacy reasons as well as something known as
> 'purgatory', a trampoline that checks the integrity of the
> contents of loaded pieces of data, before invoking that
> loaded kernel. The management of purgatory involves
> manipulating an embedded ELF purgatory object file to insert
> a memory hash value, and rewrite a few run-time switches
> based on kexec command line parameters.
> 
> By contrast, the verified loading essentially just passes
> file handles for the kernel, initramdisk, and command line
> pointer, and the kernel takes care of the rest, by
> performing all the work that the unverified kexec load would
> do, but inside the kernel using trusted kernel code.
> 
> This changeset adds a fourth mode to kexec:
> 
> - verified loading of kernel into Xen
> 
> In general, Xen performs the signature verification on the
> loaded kernel, much as Linux does, but that is where the
> similarities end.  In the current Xen implementation, no
> infrastructure is present to support reading from [Linux
> dom0] file handles, or for manipulating ELF objects. As
> such, without Xen support for these actions, Xen relies upon
> kexec to provide these services, which is what this mode
> does.
> 
> To achieve this, this mode of operation essentially vectors
> the verified load for Xen through the non-verified path,
> which performs all the needed actions for kexec to work, but
> then makes an adjustment to pass the entire kernel file, not
> just the loadable portion of the kernel file, to Xen in
> order to provide the proper image for signature
> verification.
> 
> The loading of kexec images for signature verification for
> Xen is indicated with the -s switch, just like for Linux.
> 
> Changes to configure.ac are for detecting whether or not the
> Xen version supports this kexec_file_load hypercall op.
> 
> Changes to kexec-bzImage64.c are for recording what the
> change to the kernel image entry needs to be (the entire
> kernel file, not just the loadable portion), as well as
> vectoring kexec_file_load through kexec_load for Xen.
> 
> Changes to kexec-xen.c are to invoke the new Xen
> kexec_file_load hypercall op, from kexec_load.
> 
> Changes to kexec.c are to vector kexec_file_load for Xen
> throgh kexec_load for Xen, as well as make the correction
> for passing the complete kernel file to Xen.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Thanks Eric,

this looks good to me, aside from one nit below.

> ---
>  configure.ac                        |  8 ++++++++
>  kexec/arch/x86_64/kexec-bzImage64.c | 18 ++++++++++++++++++
>  kexec/kexec-xen.c                   |  7 +++++++
>  kexec/kexec.c                       | 38 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index e05d601..a11787b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -190,6 +190,14 @@ if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
>  		AC_MSG_NOTICE([The kexec_status call is not available]))
>  fi
>  
> +dnl Check for the Xen kexec_status hypercall - reachable from --with-xen=yes|dl
> +if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
> +	AC_CHECK_LIB(xenctrl, xc_kexec_file_load,
> +		AC_DEFINE(HAVE_XEN_KEXEC_FILE_LOAD, 1,
> +			[The Xen kexec_file_load call is available]),
> +		AC_MSG_NOTICE([The Xen kexec_file_load call is not available]))
> +fi
> +
>  dnl ---Sanity checks
>  if test "$CC"      = "no"; then AC_MSG_ERROR([cc not found]); fi
>  if test "$CPP"     = "no"; then AC_MSG_ERROR([cpp not found]); fi
> diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
> index 8edb3e4..98e9d50 100644
> --- a/kexec/arch/x86_64/kexec-bzImage64.c
> +++ b/kexec/arch/x86_64/kexec-bzImage64.c
> @@ -207,6 +207,20 @@ static int do_bzImage64_load(struct kexec_info *info,
>  	align = real_mode->kernel_alignment;
>  	addr = add_buffer(info, kernel + kern16_size, k_size,
>  			  size, align, 0x100000, -1, -1);
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +    if (xen_present() && info->file_mode)
> +    {
> +        /* Record info for post-purgatory hash computation replacement with kernel file */
> +        extern char *original_kernel;
> +        extern off_t original_kernel_len;
> +        extern char *replacement_kernel;
> +        extern off_t replacement_kernel_len;
> +        original_kernel = kernel + kern16_size;
> +        original_kernel_len = k_size;
> +        replacement_kernel = kernel;
> +        replacement_kernel_len = kernel_len;
> +    }
> +#endif
>  	if (addr == ULONG_MAX)
>  		die("can not load bzImage64");
>  	dbgprintf("Loaded 64bit kernel at 0x%lx\n", addr);
> @@ -330,7 +344,11 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
>  	int opt;
>  	int result;
>  
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +	if (info->file_mode && !xen_present())
> +#else
>  	if (info->file_mode)
> +#endif

>  		return bzImage64_load_file(argc, argv, info);
>  
>  	/* See options.h -- add any more there, too. */
> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
> index 1887390..2a59d62 100644
> --- a/kexec/kexec-xen.c
> +++ b/kexec/kexec-xen.c
> @@ -124,8 +124,15 @@ int xen_kexec_load(struct kexec_info *info)
>  		arch = EM_386;
>  #endif
>  
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +    if (info->file_mode)
> +	ret = xc_kexec_file_load(xch, type, arch, (uint64_t)info->entry,
> +			    nr_segments, xen_segs);
> +    else
> +#else
>  	ret = xc_kexec_load(xch, type, arch, (uint64_t)info->entry,
>  			    nr_segments, xen_segs);
> +#endif
>  
>  out:
>  	xc_hypercall_buffer_array_destroy(xch, array);
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 32ae56c..80a4905 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -61,6 +61,13 @@ static unsigned long kexec_flags = 0;
>  /* Flags for kexec file (fd) based syscall */
>  static unsigned long kexec_file_flags = 0;
>  int kexec_debug = 0;
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +static int do_kexec_file_syscall = 0;
> +char *original_kernel = NULL;
> +off_t original_kernel_len = 0;
> +char *replacement_kernel = NULL;
> +off_t replacement_kernel_len = 0;
> +#endif
>  
>  void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
>  {
> @@ -690,6 +697,24 @@ static void update_purgatory(struct kexec_info *info)
>  			   sizeof(region));
>  	elf_rel_set_symbol(&info->rhdr, "sha256_digest", &digest,
>  			   sizeof(digest));
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +    /* Now that purgatory hash computed, replace kernel loadable segment with entire kernel file for Xen to process */
> +    if (xen_present() && info->file_mode)
> +    {

Minor nit: could we use "if (x) {" rather than  having the "{" on a new
line?

> +        if (original_kernel && original_kernel_len)
> +        {
> +	        for(i = 0; i < info->nr_segments; i++) {
> +                if ((info->segment[i].buf == original_kernel) &&
> +                    (info->segment[i].bufsz == original_kernel_len))
> +                {
> +                    info->segment[i].buf = replacement_kernel;
> +                    info->segment[i].bufsz = replacement_kernel_len;
> +                    break;
> +                }
> +            }
> +        }
> +    }
> +#endif
>  }
>  
>  /*
> @@ -710,6 +735,9 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
>  	memset(&info, 0, sizeof(info));
>  	info.kexec_flags = kexec_flags;
>  	info.skip_checks = skip_checks;
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +	info.file_mode = do_kexec_file_syscall;
> +#endif
>  
>  	result = 0;
>  	if (argc - fileind <= 0) {
> @@ -1260,7 +1288,9 @@ int main(int argc, char *argv[])
>  	int do_ifdown = 0, skip_ifdown = 0;
>  	int do_unload = 0;
>  	int do_reuse_initrd = 0;
> +#ifndef HAVE_XEN_KEXEC_FILE_LOAD
>  	int do_kexec_file_syscall = 0;
> +#endif
>  	int do_kexec_fallback = 0;
>  	int skip_checks = 0;
>  	int do_status = 0;
> @@ -1489,7 +1519,11 @@ int main(int argc, char *argv[])
>  			result = k_unload(kexec_flags);
>  	}
>  	if (do_load && (result == 0)) {
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +		if (do_kexec_file_syscall && !xen_present()) {
> +#else
>  		if (do_kexec_file_syscall) {
> +#endif
>  			result = do_kexec_file_load(fileind, argc, argv,
>  						 kexec_file_flags);
>  			if (do_kexec_fallback) switch (result) {
> @@ -1533,7 +1567,11 @@ int main(int argc, char *argv[])
>  					break;
>  			}
>  		}
> +#ifdef HAVE_XEN_KEXEC_FILE_LOAD
> +		if (!do_kexec_file_syscall || xen_present())
> +#else
>  		if (!do_kexec_file_syscall)
> +#endif
>  			result = my_load(type, fileind, argc, argv,
>  						kexec_flags, skip_checks, entry);
>  	}
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebYxF-00029u-Eq
 for kexec@lists.infradead.org; Tue, 16 Jan 2018 21:39:41 +0000
Date: Tue, 16 Jan 2018 22:39:14 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3] kexec-tools: Perform run-time linking of libxenctrl.so
Message-ID: <20180116213914.GP21705@olila.local.net-space.pl>
References: <1515792073-12894-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1515792073-12894-1-git-send-email-eric.devolder@oracle.com>
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
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com, xen-devel@lists.xen.org

On Fri, Jan 12, 2018 at 03:21:13PM -0600, Eric DeVolder wrote:
> When kexec is utilized in a Xen environment, it has an explicit
> run-time dependency on libxenctrl.so. This dependency occurs
> during the configure stage and when building kexec-tools.
>
> When kexec is utilized in a non-Xen environment (either bare
> metal or KVM), the configure and build of kexec-tools omits
> any reference to libxenctrl.so.

[...]

Wow! What a long story! Patch looks quite good. Just a few nitpicks.
If you fix them then you can add Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
to the next version.

> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
> v1: 29nov2017
>  - Daniel Kiper suggested Debian's libxen package of libraries,
>    but I did not find similar package on most other systems.
>
> v2: 14dec2017
>  - Reposted to kexec and xen-devel mailing lists
>
> v3: 12jan2018
>  - Incorporated feedback from Daniel Kiper.
>    Configure changes for --with-xen=dl, style problems corrected.
>    Extensive testing of the new mode.
> ---
>  configure.ac                       | 27 ++++++++++----
>  kexec/Makefile                     |  1 +
>  kexec/arch/i386/crashdump-x86.c    |  4 +--
>  kexec/arch/i386/kexec-x86-common.c |  4 +--
>  kexec/crashdump-xen.c              |  4 +--
>  kexec/kexec-xen.c                  | 41 ++++++++++++++++++++-
>  kexec/kexec-xen.h                  | 73 ++++++++++++++++++++++++++++++++++++++
>  7 files changed, 138 insertions(+), 16 deletions(-)
>  create mode 100644 kexec/kexec-xen.h
>
> diff --git a/configure.ac b/configure.ac
> index 208dc0a..4dab57f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -167,12 +167,27 @@ if test "$with_xen" = yes ; then
>  	AC_CHECK_HEADER(xenctrl.h,
>  		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
>  		AC_MSG_NOTICE([Xen support disabled]))])
> -		if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
> -			AC_CHECK_LIB(xenctrl, xc_kexec_status,
> -				AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
> -					[The kexec_status call is available]),
> -				AC_MSG_NOTICE([The kexec_status call is not available]))
> -		fi
> +fi
> +
> +dnl Link libxenctrl.so at run-time rather than build-time
> +if test "$with_xen" = dl ; then
> +	AC_CHECK_HEADER(dlfcn.h,
> +		[AC_CHECK_LIB(dl, dlopen, ,
> +			AC_MSG_ERROR([Dynamic library linking not available]))],
> +		AC_MSG_ERROR([Dynamic library linking not available]))

I think that this error message should be like this:
  Dynamic library linking header not available

> +	AC_DEFINE(CONFIG_LIBXENCTRL_DL, 1, [Define to 1 to link libxenctrl.so at run-time rather than build-time])
> +	AC_CHECK_HEADER(xenctrl.h,
> +		[AC_CHECK_LIB(xenctrl, xc_kexec_load,
> +		AC_DEFINE(HAVE_LIBXENCTRL, 1, ), # required define, and prevent -lxenctrl
> +		AC_MSG_NOTICE([Xen support disabled]))])
> +fi
> +
> +dnl Check for the Xen kexec_status hypercall - reachable from --with-xen=yes|dl
> +if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
> +	AC_CHECK_LIB(xenctrl, xc_kexec_status,
> +		AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
> +			[The kexec_status call is available]),
> +		AC_MSG_NOTICE([The kexec_status call is not available]))
>  fi
>
>  dnl ---Sanity checks
> diff --git a/kexec/Makefile b/kexec/Makefile
> index 2b4fb3d..8871731 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -36,6 +36,7 @@ dist += kexec/Makefile						\
>  	kexec/kexec-elf-boot.h					\
>  	kexec/kexec-elf.h kexec/kexec-sha256.h			\
>  	kexec/kexec-zlib.h kexec/kexec-lzma.h			\
> +	kexec/kexec-xen.h 								\

Could you fix backslash alignment? Maybe in separate patch. It can be
part of this series.

>  	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
>
>  dist				+= kexec/proc_iomem.c
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 69a063a..a948d9f 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -44,9 +44,7 @@
>  #include "kexec-x86.h"
>  #include "crashdump-x86.h"
>

Please remove this blank line...

> -#ifdef HAVE_LIBXENCTRL
> -#include <xenctrl.h>
> -#endif /* HAVE_LIBXENCTRL */
> +#include "../../kexec-xen.h"
>

...and this... Same things below... This was done to separate
conditional include from unconditional ones. So, blank lines
after your patch are no longer needed.

>  #include "x86-linux-setup.h"
>
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index be03618..b44c8b7 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -40,9 +40,7 @@
>  #include "../../crashdump.h"
>  #include "kexec-x86.h"
>

Ditto...

> -#ifdef HAVE_LIBXENCTRL
> -#include <xenctrl.h>
> -#endif /* HAVE_LIBXENCTRL */
> +#include "../../kexec-xen.h"
>

But leave this one...

>  /* Used below but not present in (older?) xenctrl.h */
>  #ifndef E820_PMEM
> diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
> index 60594f6..2e4cbdc 100644
> --- a/kexec/crashdump-xen.c
> +++ b/kexec/crashdump-xen.c
> @@ -18,9 +18,7 @@
>
>  #include "config.h"
>

Ditto...

> -#ifdef HAVE_LIBXENCTRL
> -#include <xenctrl.h>
> -#endif
> +#include "kexec-xen.h"
>

But leave this one... And same rules below...

>  struct crash_note_info {
>  	unsigned long base;
> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
> index 2b448d3..8ec3398 100644
> --- a/kexec/kexec-xen.c
> +++ b/kexec/kexec-xen.c
> @@ -10,10 +10,49 @@
>  #include "config.h"
>
>  #ifdef HAVE_LIBXENCTRL
> -#include <xenctrl.h>
> +#include "kexec-xen.h"
>
>  #include "crashdump.h"
>
> +#ifdef CONFIG_LIBXENCTRL_DL
> +void *xc_dlhandle;
> +xc_hypercall_buffer_t XC__HYPERCALL_BUFFER_NAME(HYPERCALL_BUFFER_NULL);
> +xc_interface *__xc_interface_open(xentoollog_logger *logger,
> +                                xentoollog_logger *dombuild_logger,
> +                                unsigned open_flags)
> +{
> +    xc_interface *xch = NULL;
> +
> +    if (!xc_dlhandle)
> +        xc_dlhandle = dlopen("libxenctrl.so", RTLD_NOW | RTLD_NODELETE);
> +
> +    if (xc_dlhandle) {
> +        typedef xc_interface *(*func_t)(xentoollog_logger *logger,
> +                                xentoollog_logger *dombuild_logger,
> +                                unsigned open_flags);
> +        func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_open");

I know your opinion about that definitions but I am not happy with them here.
However, if maintainer is OK with them I will not insist on changing that. Just
please add one extra line between definitions above and function call below.

> +        xch = func(logger, dombuild_logger, open_flags);
> +    }
> +
> +    return xch;
> +}
> +
> +int __xc_interface_close(xc_interface *xch)
> +{
> +    int rc = -1;
> +
> +    if (xc_dlhandle) {
> +        typedef int (*func_t)(xc_interface *xch);
> +        func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_close");

Same as above... Please add empty line here...

> +        rc = func(xch);
> +

...and I think that you can drop this one here...

> +        xc_dlhandle = NULL;
> +    }
> +
> +    return rc;
> +}
> +#endif /* CONFIG_LIBXENCTRL_DL */
> +
>  int xen_kexec_load(struct kexec_info *info)
>  {
>  	uint32_t nr_segments = info->nr_segments;
> diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
> new file mode 100644
> index 0000000..50e2b3d
> --- /dev/null
> +++ b/kexec/kexec-xen.h
> @@ -0,0 +1,73 @@
> +#ifndef KEXEC_XEN_H
> +#define KEXEC_XEN_H
> +
> +#ifdef HAVE_LIBXENCTRL

I would add empty line here...

> +#include <xenctrl.h>
> +
> +#ifdef CONFIG_LIBXENCTRL_DL

...and here...

> +#include <dlfcn.h>
> +
> +/* The handle from dlopen(), needed by dlsym(), dlclose() */
> +extern void *xc_dlhandle;
> +
> +/* Wrappers around xc_interface_open/close() to insert dlopen/dlclose() */
> +xc_interface *__xc_interface_open(xentoollog_logger *logger,
> +                                xentoollog_logger *dombuild_logger,
> +                                unsigned open_flags);
> +int __xc_interface_close(xc_interface *xch);
> +
> +/* GCC expression statements for evaluating dlsym() */
> +#define __xc_call(dtype, name, args...) \
> +( \
> +    { dtype value; \
> +    typedef dtype (*func_t)(xc_interface *, ...); \
> +    func_t func = dlsym(xc_dlhandle, #name); \
> +    value = func(args); \
> +    value; } \

Please use one tab instead of spaces here.

> +)
> +#define __xc_data(dtype, name) \
> +( \
> +    { dtype *value = (dtype *)dlsym(xc_dlhandle, #name); \
> +    value; } \

It looks that this code can fit into one line. Could you change that?
And one tab instead of spaces...

> +)
> +
> +/* The wrappers around utilized xenctrl.h functions */
> +#define xc_interface_open(a, b, c)  \
> +    __xc_interface_open(a, b, c)

I would put 2 tabs instead of spaces here and below...

> +#define xc_interface_close(a)       \
> +    __xc_interface_close(a)
> +#define xc_version(args...)         \
> +    __xc_call(int, xc_version, args)
> +#define xc_get_max_cpus(args...)    \
> +    __xc_call(int, xc_get_max_cpus, args)
> +#define xc_get_machine_memory_map(args...)  \
> +    __xc_call(int, xc_get_machine_memory_map, args)
> +#define xc_kexec_get_range(args...) \
> +    __xc_call(int, xc_kexec_get_range, args)
> +#define xc_kexec_load(args...)      \
> +    __xc_call(int, xc_kexec_load, args)
> +#define xc_kexec_unload(args...)    \
> +    __xc_call(int, xc_kexec_unload, args)
> +#define xc_kexec_status(args...)    \
> +    __xc_call(int, xc_kexec_status, args)
> +#define xc_kexec_exec(args...)      \
> +    __xc_call(int, xc_kexec_exec, args)
> +#define xc_hypercall_buffer_array_create(args...)   \
> +    __xc_call(xc_hypercall_buffer_array_t *, xc_hypercall_buffer_array_create, args)
> +#define xc__hypercall_buffer_alloc_pages(args...)   \
> +    __xc_call(void *, xc__hypercall_buffer_alloc_pages, args)
> +#define xc__hypercall_buffer_free_pages(args...)    \
> +    __xc_call(void  , xc__hypercall_buffer_free_pages, args)
> +#define xc__hypercall_buffer_array_alloc(args...)   \
> +    __xc_call(void *, xc__hypercall_buffer_array_alloc, args)
> +#define xc__hypercall_buffer_array_get(args...)     \
> +    __xc_call(void *, xc__hypercall_buffer_array_get, args)
> +#define xc_hypercall_buffer_array_destroy(args...)  \
> +    __xc_call(void *, xc_hypercall_buffer_array_destroy, args)
> +
> +#endif /* CONFIG_LIBXENCTRL_DL */
> +

You can drop this empty line...

> +#endif /* HAVE_LIBXENCTRL */
> +

...and leave this one...

> +#endif /* KEXEC_XEN_H */
> +

...and drop this one...

Thanks,

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

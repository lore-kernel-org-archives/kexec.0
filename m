Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ea76w-0006Q6-Cw
 for kexec@lists.infradead.org; Fri, 12 Jan 2018 21:43:41 +0000
Subject: Re: [PATCH v2] kexec-tools: Perform run-time linking of libxenctrl.so
References: <1513291681-497-1-git-send-email-eric.devolder@oracle.com>
 <20171218134352.GX4531@olila.local.net-space.pl>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <776b1792-89f4-feda-998c-bcca79f28b98@oracle.com>
Date: Fri, 12 Jan 2018 15:37:34 -0600
MIME-Version: 1.0
In-Reply-To: <20171218134352.GX4531@olila.local.net-space.pl>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com, xen-devel@lists.xen.org

Daniel,
Thanks for the feedback, see responses inline below.
I've posted v3 of the patch.
Eric

On 12/18/2017 07:43 AM, Daniel Kiper wrote:
> On Thu, Dec 14, 2017 at 04:48:01PM -0600, Eric DeVolder wrote:
>> When kexec is utilized in a Xen environment, it has an explicit
>> run-time dependency on libxenctrl.so. This dependency occurs
>> during the configure stage and when building kexec-tools.
>>
>> When kexec is utilized in a non-Xen environment (either bare
>> metal or KVM), the configure and build of kexec-tools omits
>> any reference to libxenctrl.so.
>>
>> Thus today it is not currently possible to configure and build
>> a *single* kexec that will work in *both* Xen and non-Xen
>> environments, unless the libxenctrl.so is *always* present.
>>
>> For example, a kexec configured for Xen in a Xen environment:
>>
>>   # ldd build/sbin/kexec
>>          linux-vdso.so.1 =>  (0x00007ffdeba5c000)
>>          libxenctrl.so.4.4 => /usr/lib64/libxenctrl.so.4.4 (0x00000038d8000000)
>>          libz.so.1 => /lib64/libz.so.1 (0x00000038d6c00000)
>>          libc.so.6 => /lib64/libc.so.6 (0x00000038d6000000)
>>          libdl.so.2 => /lib64/libdl.so.2 (0x00000038d6400000)
>>          libpthread.so.0 => /lib64/libpthread.so.0 (0x00000038d6800000)
>>          /lib64/ld-linux-x86-64.so.2 (0x000055e9f8c6c000)
>>   # build/sbin/kexec -v
>>   kexec-tools 2.0.16
>>
>> However, the *same* kexec executable fails in a non-Xen environment:
>>
>>   # copy xen kexec to .
>>   # ldd ./kexec
>>           linux-vdso.so.1 =>  (0x00007fffa9da7000)
>>           libxenctrl.so.4.4 => not found
>>           liblzma.so.0 => /usr/lib64/liblzma.so.0 (0x0000003014e00000)
>>           libz.so.1 => /lib64/libz.so.1 (0x000000300ea00000)
>>           libc.so.6 => /lib64/libc.so.6 (0x000000300de00000)
>>           libpthread.so.0 => /lib64/libpthread.so.0 (0x000000300e200000)
>>           /lib64/ld-linux-x86-64.so.2 (0x0000558cc786c000)
>>   # ./kexec -v
>>   ./kexec: error while loading shared libraries:
>>   libxenctrl.so.4.4: cannot open shared object file: No such file or directory
>>
>> At Oracle we "workaround" this by having two kexec-tools packages,
>> one for Xen and another for non-Xen environments. At Oracle, the
>> desire is to offer a single kexec-tools package that works in either
>> environment. To achieve this, kexec-tools would either have to ship
>> with libxenctrl.so (which we have deemed as unacceptable), or we can
>> make kexec perform run-time linking against libxenctrl.so.
>>
>> This patch is one possible way to alleviate the explicit run-time
>> dependency on libxenctrl.so. This implementation utilizes a set of
>> macros to wrap calls into libxenctrl.so so that the library can
>> instead be dlopen() and obtain the function via dlsym() and then
>> make the call. The advantage of this implementation is that it
>> requires few changes to the existing kexec-tools code. The dis-
>> advantage is that it uses macros to remap libxenctrl functions
>> and do work under the hood.
>>
>> Another possible implementation worth considering is the approach
>> taken by libvmi. Reference the following file:
>>
>> https://github.com/libvmi/libvmi/blob/master/libvmi/driver/xen/libxc_wrapper.h
>>
>> The libxc_wrapper_t structure definition that starts at line ~33
>> has members that are function pointers into libxenctrl.so. This
>> structure is populated once and then later referenced/dereferenced
>> by the callers of libxenctrl.so members. The advantage of this
>> implementation is it is more explicit in managing the use of
>> libxenctrl.so and its versions, but the disadvantage is it would
>> require touching more of the kexec-tools code.
>>
>> The following is a list libxenctrl members utilized by kexec:
>>
>> Functions:
>> xc_interface_open
>> xc_kexec_get_range
>> xc_interface_close
>> xc_kexec_get_range
>> xc_interface_open
>> xc_get_max_cpus
>> xc_kexec_get_range
>> xc_version
>> xc_kexec_exec
>> xc_kexec_status
>> xc_kexec_unload
>> xc_hypercall_buffer_array_create
>> xc__hypercall_buffer_array_alloc
>> xc_hypercall_buffer_array_destroy
>> xc_kexec_load
>> xc_get_machine_memory_map
>>
>> Data:
>> xc__hypercall_buffer_HYPERCALL_BUFFER_NULL
>>
>> These were identified by configuring and building kexec-tools
>> with Xen support, but omitting the -lxenctrl from the LDFLAGS
>> in the Makefile for an x86_64 build.
>>
>> The above libxenctrl members were referenced via these source
>> files.
>>
>> kexec/crashdump-xen.c
>> kexec/kexec-xen.c
>> kexec/arch/i386/kexec-x86-common.c
>> kexec/arch/i386/crashdump-x86.c
>>
>> This patch provides a wrapper around the calls to the above
>> functions in libxenctrl.so. Every libxenctrl call must pass a
>> xc_interface which it obtains from xc_interface_open().
>> So the existing code is already structured in a manner that
>> facilitates graceful dlopen()'ing of the libxenctrl.so and
>> the subsequent dlsym() of the required member.
>>
>> The patch creates a wrapper function around xc_interface_open()
>> and xc_interface_close() to perform the dlopen() and dlclose().
>>
>> For the remaining xc_ functions, this patch defines a macro
>> of the same name which performs the dlsym() and then invokes
>> the function. See the _xc_call() macro for details.
>>
>> There was one data item in libxenctrl.so that presented a
>> unique problem, HYPERCALL_BUFFER_NULL. It was only utilized
>> once, as
>>
>>      set_xen_guest_handle(xen_segs[s].buf.h, HYPERCALL_BUFFER_NULL);
>>
>> I tried a variety of techniques but could not find a general
>> macro-type solution without modifying xenctrl.h. So the
>> solution was to declare a local HYPERCALL_BUFFER_NULL, and
>> this appears to work. I admit I am not familiar with libxenctrl
>> to state if this is a satisfactory workaround, so feedback
>> here welcome. I can state that this allows kexec to load/unload/kexec
>> on Xen and non-Xen environments that I've tested without issue.
>>
>> With this patch applied, kexec-tools can be built with Xen
>> support and yet there is no explicit run-time dependency on
>> libxenctrl.so. Thus it can also be deployed in non-Xen
>> environments where libxenctrl.so is not installed.
>>
>>   # ldd build/sbin/kexec
>>          linux-vdso.so.1 =>  (0x00007fff7dbcd000)
>>          liblzma.so.0 => /usr/lib64/liblzma.so.0 (0x00000038d9000000)
>>          libz.so.1 => /lib64/libz.so.1 (0x00000038d6c00000)
>>          libdl.so.2 => /lib64/libdl.so.2 (0x00000038d6400000)
>>          libc.so.6 => /lib64/libc.so.6 (0x00000038d6000000)
>>          libpthread.so.0 => /lib64/libpthread.so.0 (0x00000038d6800000)
>>          /lib64/ld-linux-x86-64.so.2 (0x0000562dc0c14000)
>>   # build/sbin/kexec -v
>>   kexec-tools 2.0.16
>>
>> Currently this feature is enabled with the following:
>>
>>   ./configure --with-xen-dl --with-xen=no
>>
>> This is a bit clunky. I welcome feedback such as better names
>> and/or usage of --with, as well as if we might make this feature
>> the default.
> 
> I would do it in a bit different way. If somebody specifies --with-xen
> then kexec-tools should build as usual. However, if somebody specifies
> with-xen-dl itself or --with-xen-dl and --with-xen then --with-xen-dl
> should have a precedence.

I have cleaned this up, the previous ---with-xen=no or --with-xen=yes 
are preserved and I added --with-xen=dl for this new "mode".

> 
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>> v1: 29nov2017
>>   - Daniel Kiper suggested Debian's libxen package of libraries,
>>     but I did not find similar package on most other systems.
>>
>> v2: 14dec2017
>>   - Reposted to kexec and xen-devel mailing lists
>> ---
>>   configure.ac                       | 18 ++++++++++++++
>>   kexec/Makefile                     |  1 +
>>   kexec/arch/i386/crashdump-x86.c    |  4 +---
>>   kexec/arch/i386/kexec-x86-common.c |  4 +---
>>   kexec/crashdump-xen.c              |  4 +---
>>   kexec/kexec-xen.c                  | 43 +++++++++++++++++++++++++++++++++-
>>   kexec/kexec-xen.h                  | 48 ++++++++++++++++++++++++++++++++++++++
>>   7 files changed, 112 insertions(+), 10 deletions(-)
>>   create mode 100644 kexec/kexec-xen.h
>>
>> diff --git a/configure.ac b/configure.ac
>> index 208dc0a..4fc8aa0 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -92,6 +92,9 @@ AC_ARG_WITH([lzma], AC_HELP_STRING([--without-lzma],[disable lzma support]),
>>   AC_ARG_WITH([xen], AC_HELP_STRING([--without-xen],
>>   	[disable extended xen support]), [ with_xen="$withval"], [ with_xen=yes ] )
>>
>> +AC_ARG_WITH([xen-dl], AC_HELP_STRING([--without-xen-dl],
>> +	[link libxenctrl.so at run-time rather than build-time]), [ with_xen_dl="$withval"], [ with_xen_dl=no ] )
>> +
>>   AC_ARG_WITH([booke],
>>   		AC_HELP_STRING([--with-booke],[build for booke]),
>>   		AC_DEFINE(CONFIG_BOOKE,1,
>> @@ -174,6 +177,21 @@ if test "$with_xen" = yes ; then
>>   				AC_MSG_NOTICE([The kexec_status call is not available]))
>>   		fi
>>   fi
>> +if test "$with_xen_dl" = yes ; then
>> +	if test "$with_xen" = yes ; then
>> +		AC_MSG_ERROR([Options --with-xen and --with-xen-dl are mutually exclusive])
>> +	fi
>> +	AC_DEFINE(CONFIG_LIBXENCTRL_DL, 1, [Define to 1 to link libxenctrl.so at run-time rather than build-time])
>> +	AC_CHECK_HEADER(dlfcn.h, , AC_MSG_ERROR([Dynamic library linking not available]))
>> +	AC_CHECK_LIB(dl, dlopen, , AC_MSG_ERROR([Dynamic library linking not available]))
> 
> Please call AC_CHECK_LIB() from AC_CHECK_HEADER(). You can find more details
> if you take a look at zlib, lzma and even xenctrl config in configure.ac.

Done. I also made some slight changes to make this more sane and 
maintainable.

> 
>> +	AC_CHECK_HEADER(xenctrl.h,
>> +		AC_DEFINE(HAVE_LIBXENCTRL, 1, [Define to 1 to enable run-time linking of libxenctrl.so]),
>> +		AC_MSG_ERROR([Xen support not available]))
>> +dnl NOTE: Explicitly *NOT* performing AC_CHECK_LIB(xenctrl) as only need the header file to build
>> +	AC_CHECK_HEADER(xenctrl.h,
>> +		AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1, [Define to 1 so kexec_status call is available]),
>> +		AC_MSG_NOTICE([The kexec_status call is not available]))
>> +fi
>>
>>   dnl ---Sanity checks
>>   if test "$CC"      = "no"; then AC_MSG_ERROR([cc not found]); fi
>> diff --git a/kexec/Makefile b/kexec/Makefile
>> index 2b4fb3d..8871731 100644
>> --- a/kexec/Makefile
>> +++ b/kexec/Makefile
>> @@ -36,6 +36,7 @@ dist += kexec/Makefile						\
>>   	kexec/kexec-elf-boot.h					\
>>   	kexec/kexec-elf.h kexec/kexec-sha256.h			\
>>   	kexec/kexec-zlib.h kexec/kexec-lzma.h			\
>> +	kexec/kexec-xen.h 								\
>>   	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
>>
>>   dist				+= kexec/proc_iomem.c
>> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>> index 69a063a..a948d9f 100644
>> --- a/kexec/arch/i386/crashdump-x86.c
>> +++ b/kexec/arch/i386/crashdump-x86.c
>> @@ -44,9 +44,7 @@
>>   #include "kexec-x86.h"
>>   #include "crashdump-x86.h"
>>
>> -#ifdef HAVE_LIBXENCTRL
>> -#include <xenctrl.h>
>> -#endif /* HAVE_LIBXENCTRL */
>> +#include "../../kexec-xen.h"
>>
>>   #include "x86-linux-setup.h"
>>
>> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
>> index be03618..b44c8b7 100644
>> --- a/kexec/arch/i386/kexec-x86-common.c
>> +++ b/kexec/arch/i386/kexec-x86-common.c
>> @@ -40,9 +40,7 @@
>>   #include "../../crashdump.h"
>>   #include "kexec-x86.h"
>>
>> -#ifdef HAVE_LIBXENCTRL
>> -#include <xenctrl.h>
>> -#endif /* HAVE_LIBXENCTRL */
>> +#include "../../kexec-xen.h"
>>
>>   /* Used below but not present in (older?) xenctrl.h */
>>   #ifndef E820_PMEM
>> diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
>> index 60594f6..2e4cbdc 100644
>> --- a/kexec/crashdump-xen.c
>> +++ b/kexec/crashdump-xen.c
>> @@ -18,9 +18,7 @@
>>
>>   #include "config.h"
>>
>> -#ifdef HAVE_LIBXENCTRL
>> -#include <xenctrl.h>
>> -#endif
>> +#include "kexec-xen.h"
>>
>>   struct crash_note_info {
>>   	unsigned long base;
>> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
>> index 2b448d3..2b01fee 100644
>> --- a/kexec/kexec-xen.c
>> +++ b/kexec/kexec-xen.c
>> @@ -10,10 +10,51 @@
>>   #include "config.h"
>>
>>   #ifdef HAVE_LIBXENCTRL
>> -#include <xenctrl.h>
>> +#include "kexec-xen.h"
>>
>>   #include "crashdump.h"
>>
>> +#ifdef CONFIG_LIBXENCTRL_DL
>> +void *xc_dlhandle = NULL;
> 
> Just "void *xc_dlhandle;". Compiler will do work for you.

done

> 
>> +xc_hypercall_buffer_t XC__HYPERCALL_BUFFER_NAME(HYPERCALL_BUFFER_NULL);
> 
> static?

done

> 
>> +xc_interface *_xc_interface_open(xentoollog_logger *logger,
> 
> I would prefer __xc_interface_open() instead of _xc_interface_open()
> (two underscores at the beginning of the function). Same applies to
> the functions/variables below.

done

> 
>> +                                xentoollog_logger *dombuild_logger,
>> +                                unsigned open_flags)
>> +{
>> +    xc_interface *xch = NULL;
> 
> xc_interface *xch;

This I can not do since it results in a compiler warning about use of an 
uninitialized variable.

> 
>> +    if (NULL == xc_dlhandle)
> 
> if (!xc_dlhandle)

done

> 
>> +        xc_dlhandle = dlopen("libxenctrl.so", RTLD_NOW | RTLD_NODELETE);
> 
> if (!xc_dlhandle)
>    return NULL;
> 
>> +    if (xc_dlhandle) {
> 
> ... then you do not need this condition.

The previous two comments result in a slight functional change to the 
handling of NULL return values in this function that would break it.

> 
>> +        typedef xc_interface *(*func_t)(xentoollog_logger *logger,
>> +                                xentoollog_logger *dombuild_logger,
>> +                                unsigned open_flags);
> 
> Please define type(s) just behind the includes.

I could do this, but do note that this type is only utilized once and is 
for the express purpose of this one function. It seems better to leave 
it in scope, but if that is unacceptable I will move it.

> 
>> +        func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_open");
>> +        xch = func(logger, dombuild_logger, open_flags);
>> +    }
>> +
>> +    return xch;
>> +}
>> +
>> +int _xc_interface_close(xc_interface *xch)
>> +{
>> +    int rc = -1;
>> +
>> +/*
>> +    if (xc_dlhandle) {
>> +*/
>> +        typedef int (*func_t)(xc_interface *xch);
>> +        func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_close");
>> +        rc = func(xch);
>> +/*
> 
> If you are not sure please provide the comment why it is
> commented out or drop these lines entirely.

done; I decided to keep the code.

> 
>> +        xc_dlhandle = NULL;
>> +    }
>> +*/
>> +    return rc;
>> +}
>> +#endif /* CONFIG_LIBXENCTRL_DL */
>> +
>>   int xen_kexec_load(struct kexec_info *info)
>>   {
>>   	uint32_t nr_segments = info->nr_segments;
>> diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
>> new file mode 100644
>> index 0000000..6d2046e
>> --- /dev/null
>> +++ b/kexec/kexec-xen.h
>> @@ -0,0 +1,48 @@
>> +#ifndef KEXEC_XEN_H
>> +#define KEXEC_XEN_H
>> +
>> +#ifdef HAVE_LIBXENCTRL
>> +#include <xenctrl.h>
>> +
>> +#ifdef CONFIG_LIBXENCTRL_DL
>> +#include <dlfcn.h>
>> +
>> +/* The handle from dlopen(), needed by dlsym(), dlclose() */
>> +extern void *xc_dlhandle;
>> +
>> +/* Wrappers around xc_interface_open/close() to insert dlopen/dlclose() */
>> +xc_interface *_xc_interface_open(xentoollog_logger *logger,
>> +                                xentoollog_logger *dombuild_logger,
>> +                                unsigned open_flags);
>> +int _xc_interface_close(xc_interface *xch);
>> +
>> +/* GCC expression statements for evaluating dlsym() */
>> +#define _xc_call(DTYPE, NAME, ARGS...) ({ DTYPE value; typedef DTYPE (*func_t)(xc_interface *, ...); func_t func = dlsym(xc_dlhandle, #NAME); value = func(ARGS); value; } )
> 
> Too long line. Please try to not exceed 80 characters.

done

> 
>> +#define _xc_data(DTYPE, NAME) ({ DTYPE *value = (DTYPE *)dlsym(xc_dlhandle, #NAME); value; } )
> 
> I would export e.g. __xc_dlsym(const char *symbol) which calls
> dlsym(xc_dlhandle, symbol). Then you can make xc_dlhandle static.
> Hmmm... xc_dlhandle -> xc_dl_handle -> xc_dlh or even xdlh?

This I can not do as these are used to create in-scope expression 
evaluation statements with each instance having unique types. At one 
point in time I had explicit wrapper functions for each xc_*() where I 
did as you suggest, but that created alot of new code that was very 
prone to typos and a maintenance burden. The result was this technique...

> 
>> +/* The wrappers around utilized xenctrl.h functions */
>> +#define xc_interface_open(A,B,C)    _xc_interface_open(A,B,C)
> 
> Lack of space after commas... And please use lowercase letters here.

done

> 
>> +#define xc_interface_close(A)       _xc_interface_close(A)
>> +#define xc_version(ARGS...)         _xc_call(int, xc_version, ARGS)
>> +#define xc_get_max_cpus(ARGS...)    _xc_call(int, xc_get_max_cpus, ARGS)
>> +#define xc_get_machine_memory_map(ARGS...)  _xc_call(int, xc_get_machine_memory_map, ARGS)
>> +#define xc_kexec_get_range(ARGS...) _xc_call(int, xc_kexec_get_range, ARGS)
>> +#define xc_kexec_load(ARGS...)      _xc_call(int, xc_kexec_load, ARGS)
>> +#define xc_kexec_unload(ARGS...)    _xc_call(int, xc_kexec_unload, ARGS)
>> +#define xc_kexec_status(ARGS...)    _xc_call(int, xc_kexec_status, ARGS)
>> +#define xc_kexec_exec(ARGS...)      _xc_call(int, xc_kexec_exec, ARGS)
>> +#define xc_hypercall_buffer_array_create(ARGS...)   _xc_call(xc_hypercall_buffer_array_t *, xc_hypercall_buffer_array_create, ARGS)
>> +#define xc__hypercall_buffer_alloc(ARGS...) _xc_call(void *, xc__hypercall_buffer_alloc, ARGS)
>> +#define xc__hypercall_buffer_free(ARGS...)  _xc_call(void  , xc__hypercall_buffer_free, ARGS)
>> +#define xc__hypercall_buffer_alloc_pages(ARGS...)   _xc_call(void *, xc__hypercall_buffer_alloc_pages, ARGS)
>> +#define xc__hypercall_buffer_free_pages(ARGS...)    _xc_call(void  , xc__hypercall_buffer_free_pages, ARGS)
>> +#define xc__hypercall_buffer_array_alloc(ARGS...)   _xc_call(void *, xc__hypercall_buffer_array_alloc, ARGS)
>> +#define xc__hypercall_buffer_array_get(ARGS...)     _xc_call(void *, xc__hypercall_buffer_array_get, ARGS)
>> +#define xc_hypercall_buffer_array_destroy(ARGS...)  _xc_call(void *, xc_hypercall_buffer_array_destroy, ARGS)
> 
> Could you try to make this more readable? Alignment, line wraps
> if needed, etc. And of course too long lines in many places...

done

> 
> Really kexec-tools use all of them?

yes

> 
> Daniel
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

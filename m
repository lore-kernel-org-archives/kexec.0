Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ea6rD-0003mp-9b
 for kexec@lists.infradead.org; Fri, 12 Jan 2018 21:27:27 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v3] kexec-tools: Perform run-time linking of libxenctrl.so
Date: Fri, 12 Jan 2018 15:21:13 -0600
Message-Id: <1515792073-12894-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au, andrew.cooper3@citrix.com, xen-devel@lists.xen.org
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, konrad.wilk@oracle.com

When kexec is utilized in a Xen environment, it has an explicit
run-time dependency on libxenctrl.so. This dependency occurs
during the configure stage and when building kexec-tools.

When kexec is utilized in a non-Xen environment (either bare
metal or KVM), the configure and build of kexec-tools omits
any reference to libxenctrl.so.

Thus today it is not currently possible to configure and build
a *single* kexec that will work in *both* Xen and non-Xen
environments, unless the libxenctrl.so is *always* present.

For example, a kexec configured for Xen in a Xen environment:

 # ldd build/sbin/kexec
        linux-vdso.so.1 =>  (0x00007ffdeba5c000)
        libxenctrl.so.4.4 => /usr/lib64/libxenctrl.so.4.4 (0x00000038d8000000)
        libz.so.1 => /lib64/libz.so.1 (0x00000038d6c00000)
        libc.so.6 => /lib64/libc.so.6 (0x00000038d6000000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00000038d6400000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00000038d6800000)
        /lib64/ld-linux-x86-64.so.2 (0x000055e9f8c6c000)
 # build/sbin/kexec -v
 kexec-tools 2.0.16

However, the *same* kexec executable fails in a non-Xen environment:

 # copy xen kexec to .
 # ldd ./kexec
         linux-vdso.so.1 =>  (0x00007fffa9da7000)
         libxenctrl.so.4.4 => not found
         liblzma.so.0 => /usr/lib64/liblzma.so.0 (0x0000003014e00000)
         libz.so.1 => /lib64/libz.so.1 (0x000000300ea00000)
         libc.so.6 => /lib64/libc.so.6 (0x000000300de00000)
         libpthread.so.0 => /lib64/libpthread.so.0 (0x000000300e200000)
         /lib64/ld-linux-x86-64.so.2 (0x0000558cc786c000)
 # ./kexec -v
 ./kexec: error while loading shared libraries:
 libxenctrl.so.4.4: cannot open shared object file: No such file or directory

At Oracle we "workaround" this by having two kexec-tools packages,
one for Xen and another for non-Xen environments. At Oracle, the
desire is to offer a single kexec-tools package that works in either
environment. To achieve this, kexec-tools would either have to ship
with libxenctrl.so (which we have deemed as unacceptable), or we can
make kexec perform run-time linking against libxenctrl.so.

This patch is one possible way to alleviate the explicit run-time
dependency on libxenctrl.so. This implementation utilizes a set of
macros to wrap calls into libxenctrl.so so that the library can
instead be dlopen() and obtain the function via dlsym() and then
make the call. The advantage of this implementation is that it
requires few changes to the existing kexec-tools code. The dis-
advantage is that it uses macros to remap libxenctrl functions
and do work under the hood.

Another possible implementation worth considering is the approach
taken by libvmi. Reference the following file:

https://github.com/libvmi/libvmi/blob/master/libvmi/driver/xen/libxc_wrapper.h

The libxc_wrapper_t structure definition that starts at line ~33
has members that are function pointers into libxenctrl.so. This
structure is populated once and then later referenced/dereferenced
by the callers of libxenctrl.so members. The advantage of this
implementation is it is more explicit in managing the use of
libxenctrl.so and its versions, but the disadvantage is it would
require touching more of the kexec-tools code.

The following is a list libxenctrl members utilized by kexec:

Functions:
xc_interface_open
xc_kexec_get_range
xc_interface_close
xc_kexec_get_range
xc_interface_open
xc_get_max_cpus
xc_kexec_get_range
xc_version
xc_kexec_exec
xc_kexec_status
xc_kexec_unload
xc_hypercall_buffer_array_create
xc__hypercall_buffer_array_alloc
xc_hypercall_buffer_array_destroy
xc_kexec_load
xc_get_machine_memory_map

Data:
xc__hypercall_buffer_HYPERCALL_BUFFER_NULL

These were identified by configuring and building kexec-tools
with Xen support, but omitting the -lxenctrl from the LDFLAGS
in the Makefile for an x86_64 build.

The above libxenctrl members were referenced via these source
files.

kexec/crashdump-xen.c
kexec/kexec-xen.c
kexec/arch/i386/kexec-x86-common.c
kexec/arch/i386/crashdump-x86.c

This patch provides a wrapper around the calls to the above
functions in libxenctrl.so. Every libxenctrl call must pass a
xc_interface which it obtains from xc_interface_open().
So the existing code is already structured in a manner that
facilitates graceful dlopen()'ing of the libxenctrl.so and
the subsequent dlsym() of the required member.

The patch creates a wrapper function around xc_interface_open()
and xc_interface_close() to perform the dlopen() and dlclose().

For the remaining xc_ functions, this patch defines a macro
of the same name which performs the dlsym() and then invokes
the function. See the __xc_call() macro for details.

There was one data item in libxenctrl.so that presented a
unique problem, HYPERCALL_BUFFER_NULL. It was only utilized
once, as

    set_xen_guest_handle(xen_segs[s].buf.h, HYPERCALL_BUFFER_NULL);

I tried a variety of techniques but could not find a general
macro-type solution without modifying xenctrl.h. So the
solution was to declare a local HYPERCALL_BUFFER_NULL, and
this appears to work. I admit I am not familiar with libxenctrl
to state if this is a satisfactory workaround, so feedback
here welcome. I can state that this allows kexec to load/unload/kexec
on Xen and non-Xen environments that I've tested without issue.

With this patch applied, kexec-tools can be built with Xen
support and yet there is no explicit run-time dependency on
libxenctrl.so. Thus it can also be deployed in non-Xen
environments where libxenctrl.so is not installed.

 # ldd build/sbin/kexec
        linux-vdso.so.1 =>  (0x00007fff7dbcd000)
        liblzma.so.0 => /usr/lib64/liblzma.so.0 (0x00000038d9000000)
        libz.so.1 => /lib64/libz.so.1 (0x00000038d6c00000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00000038d6400000)
        libc.so.6 => /lib64/libc.so.6 (0x00000038d6000000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00000038d6800000)
        /lib64/ld-linux-x86-64.so.2 (0x0000562dc0c14000)
 # build/sbin/kexec -v
 kexec-tools 2.0.16

This feature/ability is enabled with the following:

 ./configure --with-xen=dl

The previous --with-xen=no and --with-xen=yes still work as before.
Not specifying a --with-xen still defaults to --with-xen=yes.

As I've introduced a new build and run-time mode, I've done an
extensive matrix of both build-time and run-time checks of kexec
with this patch applied. The set of build-time scenarios are:

 1: configure --with-xen=no  and Xen support NOT present
 2: configure --with-xen=no  and Xen support IS  present
 3: configure --with-xen=yes and Xen support NOT present
 4: configure --with-xen=yes and Xen support IS  present
 5: configure --with-xen=dl  and Xen support NOT present
 6: configure --with-xen=dl  and Xen support IS  present

Xen support present requires that configure can find both
xenctrl.h and libxenctrl.so.

Then for each of the six scenarios above, the corresponding kexec
binary was tested on a Xen system (Oracle's OVS dom0) and a
non-Xen system (Oracle Linux).

There are two build-time checks: did kexec build, and did
it contain libxenctrl.so? The presence of libxenctrl.so
in kexec was checked via ldd. The results were:

 Scenario | Build | libxenctrl.so | Result
 1        | pass  | no            | pass - see Note 1
 2        | pass  | no            | pass - see Note 1
 3        | pass  | no            | pass - see Note 2
 4        | pass  | yes           | pass - see Note 3
 5        | pass  | no            | pass - see Note 2
 6        | pass  | no            | pass - see Note 4

Note 1: This passes since due to --with-xen=no, there will
be no Xen support in kexec and therefore no libxenctrl.so a
in the kexec.

Note 2: This passes since while --with-xen=yes, the configure
displays a message indicating that Xen support is disabled,
and allows kexec to build (this is the same behavior as prior
to this patch). And since Xen support is disabled, there is
no libxenctrl.so in the kexec.

Note 3: This passes since with --with-xen=yes and configure
locating the xenctrl.h and libxenctrl.so, support for Xen was
built into kexec. Ldd shows an explicit dependency on the library.

Note 4: This passes since with --with-xen=dl and configure
locating the xenctrl.h and libxencrl.so, support for Xen
was built into kexec. However, this uses the new technique
introduced by this patch and, as a result, ldd shows that the
libxenctrl.so is not a explicit run-time dependency for kexec
(rather libdl.so is now an explicit dependency).  This is
precisely the goal of this patch!

The net effect is that there are now three "flavors" of a kexec
binary (prior to this patch there were two): a) kexec with no
support for Xen [scenarios 1, 2, 3, 5], b) kexec with support
for Xen and libxenctrl.so as an explicit dependency [scenario 4],
and c) kexec with support for Xen and libxenctrl.so is NOT an
explicit dependency [scenario 6].

The run-time checks are to take each of the six scenarios above
and run the corresponding kexec binary on both a Xen system and
a non-Xen system. The test for each kexec scenario was:

  % service kdump stop
  % vi /etc/init.d/kdump
  change KEXEC= to /sbin/kexec-[123456]
  % service kdump start
  # If not FAILED, then below
  % service kdump status
  Kdump is operational
  % rm -fr /var/crash/*
  % echo c > /proc/sysrq-trigger
  # after reboot verify vmcore generated
  % ls -al /var/crash/<tab>

The results were:

 Scenario | Xen environment   | non-Xen environment
 1        | fail - see Note 5 | pass
 2        | fail - see Note 5 | pass
 3        | fail - see Note 6 | pass
 4        | pass              | pass
 5        | fail - see Note 6 | pass
 6        | pass              | pass

Note 5: Due to --with-xen=no, kexec lacks support for Xen and will
fail in the Xen environment. This behavior is the same as prior
to this patch.

Note 6: Due to the missing xenctrl.h and libxenctrl.so, kexec was
built without support for Xen, and thus will fail in the Xen
environment. This behavior is the same as prior to this patch.

Note that for scenarios 1, 2, 3 and 5 kexec lacks support for Xen,
thus these versions are expected to "fail" in a Xen environment.
On the flip side, since a non-Xen environment does not need
libxenctrl.so, all six scenarios are expected to "pass" in a
non-Xen environment. The results match these expectations!

And, of course, importantly with this patch applied, it did not
have an adverse impact on kexec build or run-time.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v1: 29nov2017
 - Daniel Kiper suggested Debian's libxen package of libraries,
   but I did not find similar package on most other systems.

v2: 14dec2017
 - Reposted to kexec and xen-devel mailing lists

v3: 12jan2018
 - Incorporated feedback from Daniel Kiper.
   Configure changes for --with-xen=dl, style problems corrected.
   Extensive testing of the new mode.
---
 configure.ac                       | 27 ++++++++++----
 kexec/Makefile                     |  1 +
 kexec/arch/i386/crashdump-x86.c    |  4 +--
 kexec/arch/i386/kexec-x86-common.c |  4 +--
 kexec/crashdump-xen.c              |  4 +--
 kexec/kexec-xen.c                  | 41 ++++++++++++++++++++-
 kexec/kexec-xen.h                  | 73 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 138 insertions(+), 16 deletions(-)
 create mode 100644 kexec/kexec-xen.h

diff --git a/configure.ac b/configure.ac
index 208dc0a..4dab57f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -167,12 +167,27 @@ if test "$with_xen" = yes ; then
 	AC_CHECK_HEADER(xenctrl.h,
 		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
 		AC_MSG_NOTICE([Xen support disabled]))])
-		if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
-			AC_CHECK_LIB(xenctrl, xc_kexec_status,
-				AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
-					[The kexec_status call is available]),
-				AC_MSG_NOTICE([The kexec_status call is not available]))
-		fi
+fi
+
+dnl Link libxenctrl.so at run-time rather than build-time
+if test "$with_xen" = dl ; then
+	AC_CHECK_HEADER(dlfcn.h,
+		[AC_CHECK_LIB(dl, dlopen, ,
+			AC_MSG_ERROR([Dynamic library linking not available]))],
+		AC_MSG_ERROR([Dynamic library linking not available]))
+	AC_DEFINE(CONFIG_LIBXENCTRL_DL, 1, [Define to 1 to link libxenctrl.so at run-time rather than build-time])
+	AC_CHECK_HEADER(xenctrl.h,
+		[AC_CHECK_LIB(xenctrl, xc_kexec_load,
+		AC_DEFINE(HAVE_LIBXENCTRL, 1, ), # required define, and prevent -lxenctrl
+		AC_MSG_NOTICE([Xen support disabled]))])
+fi
+
+dnl Check for the Xen kexec_status hypercall - reachable from --with-xen=yes|dl
+if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
+	AC_CHECK_LIB(xenctrl, xc_kexec_status,
+		AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
+			[The kexec_status call is available]),
+		AC_MSG_NOTICE([The kexec_status call is not available]))
 fi
 
 dnl ---Sanity checks
diff --git a/kexec/Makefile b/kexec/Makefile
index 2b4fb3d..8871731 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -36,6 +36,7 @@ dist += kexec/Makefile						\
 	kexec/kexec-elf-boot.h					\
 	kexec/kexec-elf.h kexec/kexec-sha256.h			\
 	kexec/kexec-zlib.h kexec/kexec-lzma.h			\
+	kexec/kexec-xen.h 								\
 	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
 
 dist				+= kexec/proc_iomem.c
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 69a063a..a948d9f 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -44,9 +44,7 @@
 #include "kexec-x86.h"
 #include "crashdump-x86.h"
 
-#ifdef HAVE_LIBXENCTRL
-#include <xenctrl.h>
-#endif /* HAVE_LIBXENCTRL */
+#include "../../kexec-xen.h"
 
 #include "x86-linux-setup.h"
 
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index be03618..b44c8b7 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -40,9 +40,7 @@
 #include "../../crashdump.h"
 #include "kexec-x86.h"
 
-#ifdef HAVE_LIBXENCTRL
-#include <xenctrl.h>
-#endif /* HAVE_LIBXENCTRL */
+#include "../../kexec-xen.h"
 
 /* Used below but not present in (older?) xenctrl.h */
 #ifndef E820_PMEM
diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index 60594f6..2e4cbdc 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -18,9 +18,7 @@
 
 #include "config.h"
 
-#ifdef HAVE_LIBXENCTRL
-#include <xenctrl.h>
-#endif
+#include "kexec-xen.h"
 
 struct crash_note_info {
 	unsigned long base;
diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 2b448d3..8ec3398 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -10,10 +10,49 @@
 #include "config.h"
 
 #ifdef HAVE_LIBXENCTRL
-#include <xenctrl.h>
+#include "kexec-xen.h"
 
 #include "crashdump.h"
 
+#ifdef CONFIG_LIBXENCTRL_DL
+void *xc_dlhandle;
+xc_hypercall_buffer_t XC__HYPERCALL_BUFFER_NAME(HYPERCALL_BUFFER_NULL);
+xc_interface *__xc_interface_open(xentoollog_logger *logger,
+                                xentoollog_logger *dombuild_logger,
+                                unsigned open_flags)
+{
+    xc_interface *xch = NULL;
+
+    if (!xc_dlhandle)
+        xc_dlhandle = dlopen("libxenctrl.so", RTLD_NOW | RTLD_NODELETE);
+
+    if (xc_dlhandle) {
+        typedef xc_interface *(*func_t)(xentoollog_logger *logger,
+                                xentoollog_logger *dombuild_logger,
+                                unsigned open_flags);
+        func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_open");
+        xch = func(logger, dombuild_logger, open_flags);
+    }
+
+    return xch;
+}
+
+int __xc_interface_close(xc_interface *xch)
+{
+    int rc = -1;
+
+    if (xc_dlhandle) {
+        typedef int (*func_t)(xc_interface *xch);
+        func_t func = (func_t)dlsym(xc_dlhandle, "xc_interface_close");
+        rc = func(xch);
+
+        xc_dlhandle = NULL;
+    }
+
+    return rc;
+}
+#endif /* CONFIG_LIBXENCTRL_DL */
+
 int xen_kexec_load(struct kexec_info *info)
 {
 	uint32_t nr_segments = info->nr_segments;
diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
new file mode 100644
index 0000000..50e2b3d
--- /dev/null
+++ b/kexec/kexec-xen.h
@@ -0,0 +1,73 @@
+#ifndef KEXEC_XEN_H
+#define KEXEC_XEN_H
+
+#ifdef HAVE_LIBXENCTRL
+#include <xenctrl.h>
+
+#ifdef CONFIG_LIBXENCTRL_DL
+#include <dlfcn.h>
+
+/* The handle from dlopen(), needed by dlsym(), dlclose() */
+extern void *xc_dlhandle;
+
+/* Wrappers around xc_interface_open/close() to insert dlopen/dlclose() */
+xc_interface *__xc_interface_open(xentoollog_logger *logger,
+                                xentoollog_logger *dombuild_logger,
+                                unsigned open_flags);
+int __xc_interface_close(xc_interface *xch);
+
+/* GCC expression statements for evaluating dlsym() */
+#define __xc_call(dtype, name, args...) \
+( \
+    { dtype value; \
+    typedef dtype (*func_t)(xc_interface *, ...); \
+    func_t func = dlsym(xc_dlhandle, #name); \
+    value = func(args); \
+    value; } \
+)
+#define __xc_data(dtype, name) \
+( \
+    { dtype *value = (dtype *)dlsym(xc_dlhandle, #name); \
+    value; } \
+)
+
+/* The wrappers around utilized xenctrl.h functions */
+#define xc_interface_open(a, b, c)  \
+    __xc_interface_open(a, b, c)
+#define xc_interface_close(a)       \
+    __xc_interface_close(a)
+#define xc_version(args...)         \
+    __xc_call(int, xc_version, args)
+#define xc_get_max_cpus(args...)    \
+    __xc_call(int, xc_get_max_cpus, args)
+#define xc_get_machine_memory_map(args...)  \
+    __xc_call(int, xc_get_machine_memory_map, args)
+#define xc_kexec_get_range(args...) \
+    __xc_call(int, xc_kexec_get_range, args)
+#define xc_kexec_load(args...)      \
+    __xc_call(int, xc_kexec_load, args)
+#define xc_kexec_unload(args...)    \
+    __xc_call(int, xc_kexec_unload, args)
+#define xc_kexec_status(args...)    \
+    __xc_call(int, xc_kexec_status, args)
+#define xc_kexec_exec(args...)      \
+    __xc_call(int, xc_kexec_exec, args)
+#define xc_hypercall_buffer_array_create(args...)   \
+    __xc_call(xc_hypercall_buffer_array_t *, xc_hypercall_buffer_array_create, args)
+#define xc__hypercall_buffer_alloc_pages(args...)   \
+    __xc_call(void *, xc__hypercall_buffer_alloc_pages, args)
+#define xc__hypercall_buffer_free_pages(args...)    \
+    __xc_call(void  , xc__hypercall_buffer_free_pages, args)
+#define xc__hypercall_buffer_array_alloc(args...)   \
+    __xc_call(void *, xc__hypercall_buffer_array_alloc, args)
+#define xc__hypercall_buffer_array_get(args...)     \
+    __xc_call(void *, xc__hypercall_buffer_array_get, args)
+#define xc_hypercall_buffer_array_destroy(args...)  \
+    __xc_call(void *, xc_hypercall_buffer_array_destroy, args)
+
+#endif /* CONFIG_LIBXENCTRL_DL */
+
+#endif /* HAVE_LIBXENCTRL */
+
+#endif /* KEXEC_XEN_H */
+
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

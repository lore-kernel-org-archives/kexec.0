Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nx6rx-0006MO-R3
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 22:58:43 +0000
Date: Thu, 1 Apr 2010 09:58:19 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/7] powerpc32: pull in libfdt
Message-ID: <20100331225819.GC10909@verge.net.au>
References: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
	<1270023858-26947-4-git-send-email-sebastian@breakpoint.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1270023858-26947-4-git-send-email-sebastian@breakpoint.cc>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

On Wed, Mar 31, 2010 at 10:24:14AM +0200, Sebastian Andrzej Siewior wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This is v1.2.0 of libfdt from the dtc project which is available at
>  git://www.jdl.com/software/dtc.git
> 
> The other files
> - include/page.h
> - include/types.h
> - libfdt-wrapper.c
> - ops.h
> 
> are part of the glue code which is used the powerpc boot wrapper code
> is comming from the Linux kernel v2.6.27-rc6 and has been modified a
> little to fit.

Hi,

I'm seeing some signed vs unsigned comparison warnings in this code.
Here is a stab that I took at fixing them. Do they seem reasonable to you?
If so, we could either merge them into your patch or just apply them
as another patch.

Index: kexec-tools/kexec/arch/ppc/libfdt/fdt.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/libfdt/fdt.c	2010-04-01 09:15:34.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/libfdt/fdt.c	2010-04-01 09:28:56.000000000 +1100
@@ -74,7 +74,7 @@ int fdt_check_header(const void *fdt)
 	return 0;
 }
 
-const void *fdt_offset_ptr(const void *fdt, int offset, int len)
+const void *fdt_offset_ptr(const void *fdt, unsigned offset, unsigned len)
 {
 	const char *p;
 
@@ -189,7 +189,7 @@ const char *_fdt_find_string(const char
 	return NULL;
 }
 
-int fdt_move(const void *fdt, void *buf, int bufsize)
+int fdt_move(const void *fdt, void *buf, unsigned bufsize)
 {
 	FDT_CHECK_HEADER(fdt);
 
Index: kexec-tools/kexec/arch/ppc/libfdt/libfdt.h
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/libfdt/libfdt.h	2010-04-01 09:29:38.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/libfdt/libfdt.h	2010-04-01 09:34:31.000000000 +1100
@@ -122,7 +122,7 @@
 /* Low-level functions (you probably don't need these)                */
 /**********************************************************************/
 
-const void *fdt_offset_ptr(const void *fdt, int offset, int checklen);
+const void *fdt_offset_ptr(const void *fdt, unsigned offset, unsigned checklen);
 static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
 {
 	return (void *)(uintptr_t)fdt_offset_ptr(fdt, offset, checklen);
@@ -206,7 +206,7 @@ int fdt_check_header(const void *fdt);
  *     -FDT_ERR_BADVERSION,
  *     -FDT_ERR_BADSTATE, standard meanings
  */
-int fdt_move(const void *fdt, void *buf, int bufsize);
+int fdt_move(const void *fdt, void *buf, unsigned bufsize);
 
 /**********************************************************************/
 /* Read-only functions                                                */
@@ -781,7 +781,7 @@ int fdt_nop_node(void *fdt, int nodeoffs
 /* Sequential write functions                                         */
 /**********************************************************************/
 
-int fdt_create(void *buf, int bufsize);
+int fdt_create(void *buf, unsigned bufsize);
 int fdt_add_reservemap_entry(void *fdt, uint64_t addr, uint64_t size);
 int fdt_finish_reservemap(void *fdt);
 int fdt_begin_node(void *fdt, const char *name);
@@ -1071,6 +1071,6 @@ int fdt_del_node(void *fdt, int nodeoffs
 /* Debugging / informational functions                                */
 /**********************************************************************/
 
-const char *fdt_strerror(int errval);
+const char *fdt_strerror(unsigned errval);
 
 #endif /* _LIBFDT_H */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

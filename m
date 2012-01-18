Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RnST4-0006so-6q
 for kexec@lists.infradead.org; Wed, 18 Jan 2012 10:10:11 +0000
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 18 Jan 2012 15:40:04 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0IA9iVD4473036
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 15:39:45 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0IA9iMs009203
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 21:09:44 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 2/3][makedumpfile][ppc64] Rename the __powerpc__ macro to
 __powerpc64__ for PPC64
Date: Wed, 18 Jan 2012 15:39:44 +0530
Message-ID: <20120118100921.29422.90156.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
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
To: tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Makedumpfile uses __powerpc__ as the value of ARCH to control the PPC64
specfic definitions. Rename this to __powerpc64__ for a better readability
of the code as the support for ppc32 will be introduced in the later series.
We could use __powerpc32__ for PPC32.

Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
---

 Makefile       |    5 +++--
 makedumpfile.c |    2 +-
 makedumpfile.h |   10 +++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 174a0d9..04e267f 100644
--- a/Makefile
+++ b/Makefile
@@ -24,11 +24,12 @@ endif
 ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
 			       -e s/arm.*/arm/ -e s/sa110/arm/ \
 			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
-			       -e s/ppc64/powerpc/ )
+			       -e s/ppc64/powerpc64/ )
+
 CFLAGS += -D__$(ARCH)__
 CFLAGS_ARCH += -D__$(ARCH)__
 
-ifeq ($(ARCH), powerpc)
+ifeq ($(ARCH), powerpc64)
 CFLAGS += -m64
 CFLAGS_ARCH += -m64
 endif
diff --git a/makedumpfile.c b/makedumpfile.c
index c51fda3..101f8b5 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5691,7 +5691,7 @@ initial_xen(void)
 	off_t offset;
 	unsigned long size;
 
-#ifdef __powerpc__
+#ifdef __powerpc64__
 	MSG("\n");
 	MSG("ppc64 xen is not supported.\n");
 	return FALSE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 4b4a58b..efa325f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -521,7 +521,7 @@ do { \
 
 #endif /* x86_64 */
 
-#ifdef __powerpc__
+#ifdef __powerpc64__
 #define __PAGE_OFFSET		(0xc000000000000000)
 #define KERNELBASE		PAGE_OFFSET
 #define VMALLOCBASE     	(0xD000000000000000)
@@ -658,14 +658,14 @@ unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
 #define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
 #endif /* x86_64 */
 
-#ifdef __powerpc__ /* powerpc */
+#ifdef __powerpc64__ /* powerpc64 */
 int get_machdep_info_ppc64(void);
 unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
 #define get_phys_base()		TRUE
 #define get_machdep_info()	get_machdep_info_ppc64()
 #define get_versiondep_info()	TRUE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
-#endif          /* powerpc */
+#endif          /* powerpc64 */
 
 #ifdef __s390x__ /* s390x */
 int get_machdep_info_s390x(void);
@@ -1332,10 +1332,10 @@ int get_xen_info_ia64(void);
 
 #endif	/* __ia64 */
 
-#ifdef __powerpc__ /* powerpc */
+#ifdef __powerpc64__ /* powerpc64 */
 #define kvtop_xen(X)	FALSE
 #define get_xen_info_arch(X) FALSE
-#endif	/* powerpc */
+#endif	/* powerpc64 */
 
 #ifdef __s390x__ /* s390x */
 #define kvtop_xen(X)	FALSE


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

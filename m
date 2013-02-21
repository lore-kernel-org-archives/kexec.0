Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8aFv-00068s-Ge
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 17:48:29 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 2/8] xen: make GUEST_HANDLE_64() and uint64_aligned_t
 available everywhere
Date: Thu, 21 Feb 2013 17:48:08 +0000
Message-ID: <1361468894-18655-3-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
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
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

GUEST_HANDLE_64() and uint64_aligned_t allow hypercall ABI structures
to be identical (binary compatible) for 32 and 64-bit guests.  They
are currently limited to only being available for use in sysctls and
domctls.  Relax this limit so it may be used by any new structures.

There is a minimal cost for 32-bit guests on 64-but hypervisors as
set_guest_handle() needs to 0 the whole field on GUEST_HANDLE_64()
handles, but this is expected to be less than the overhead of having
to translate compat structures.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/include/public/arch-x86/xen-x86_32.h |    4 +---
 xen/include/public/xen.h                 |   13 ++++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/xen/include/public/arch-x86/xen-x86_32.h b/xen/include/public/arch-x86/xen-x86_32.h
index 906e74a..08fac7a 100644
--- a/xen/include/public/arch-x86/xen-x86_32.h
+++ b/xen/include/public/arch-x86/xen-x86_32.h
@@ -91,8 +91,7 @@
 #define machine_to_phys_mapping ((unsigned long *)MACH2PHYS_VIRT_START)
 #endif
 
-/* 32-/64-bit invariability for control interfaces (domctl/sysctl). */
-#if defined(__XEN__) || defined(__XEN_TOOLS__)
+/* 32-/64-bit invariability. */
 #undef ___DEFINE_XEN_GUEST_HANDLE
 #define ___DEFINE_XEN_GUEST_HANDLE(name, type)                  \
     typedef struct { type *p; }                                 \
@@ -107,7 +106,6 @@
 #define uint64_aligned_t uint64_t __attribute__((aligned(8)))
 #define __XEN_GUEST_HANDLE_64(name) __guest_handle_64_ ## name
 #define XEN_GUEST_HANDLE_64(name) __XEN_GUEST_HANDLE_64(name)
-#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/xen/include/public/xen.h b/xen/include/public/xen.h
index 5593066..c18e7ce 100644
--- a/xen/include/public/xen.h
+++ b/xen/include/public/xen.h
@@ -840,9 +840,14 @@ __DEFINE_XEN_GUEST_HANDLE(uint64, uint64_t);
 
 #endif /* !__ASSEMBLY__ */
 
-/* Default definitions for macros used by domctl/sysctl. */
-#if defined(__XEN__) || defined(__XEN_TOOLS__)
-
+/*
+ * Default definitions for 32/64-bit invariant macros.
+ *
+ * Use these in ABI structures that should be identical for 32 and
+ * 64-bit guests. There is some (very small) overhead in using
+ * XEN_GUEST_HANDLE_64() instead of XEN_GUEST_HANDLE() so avoid for
+ * very hot paths.
+ */
 #ifndef uint64_aligned_t
 #define uint64_aligned_t uint64_t
 #endif
@@ -857,8 +862,6 @@ struct xenctl_cpumap {
 };
 #endif
 
-#endif /* defined(__XEN__) || defined(__XEN_TOOLS__) */
-
 #endif /* __XEN_PUBLIC_XEN_H__ */
 
 /*
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

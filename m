Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QEvop-0007wN-39
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 03:53:39 +0000
From: Amerigo Wang <amwang@redhat.com>
Subject: [Patch] kexec: fix a compiler warning on ppc64
Date: Wed, 27 Apr 2011 11:53:23 +0800
Message-Id: <1303876403-10538-1-git-send-email-amwang@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, WANG Cong <amwang@redhat.com>

I got the following warning when I compiled kexec-tools on ppc64,

In file included from kexec/arch/ppc64/kexec-ppc64.c:32:
kexec/arch/ppc64/../../kexec-syscall.h:118:1: warning: "KEXEC_ARCH_NATIVE" redefined
kexec/arch/ppc64/../../kexec-syscall.h:115:1: warning: this is the location of the previous definition

This is due to that ppc64 defines bot __powerpc64__ and __powerpc__,
this patch fixes that warning.

Signed-off-by: WANG Cong <amwang@redhat.com>
Cc: Simon Horman <horms@verge.net.au>

---
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 03d7abc..b082f40 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -113,9 +113,10 @@ static inline long kexec_reboot(void)
 #endif
 #ifdef __powerpc64__
 #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_PPC64
-#endif
-#ifdef __powerpc__
-#define KEXEC_ARCH_NATIVE	KEXEC_ARCH_PPC
+#else
+ #ifdef __powerpc__
+ #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_PPC
+ #endif
 #endif
 #ifdef __x86_64__
 #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_X86_64

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

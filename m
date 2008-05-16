Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.246])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwuZj-0000MK-Na
	for kexec@lists.infradead.org; Fri, 16 May 2008 07:42:00 +0000
Received: by rv-out-0708.google.com with SMTP id b17so42844rvf.42
	for <kexec@lists.infradead.org>; Fri, 16 May 2008 00:41:58 -0700 (PDT)
Date: Thu, 15 May 2008 22:34:23 -0700
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH] Update KEXEC_ARCH_* constants from Linux kernel headers.
Message-ID: <20080516053423.GA21166@oh.minilop.net>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
I thought I'd need this, but it turned out not to matter. I'm submitting
it anyway because keeping kexec-tools in sync with the kernel kexec
headers seems like a good idea.

 kexec/kexec-syscall.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index d12a11c..2b9345f 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -82,8 +82,11 @@ static inline long kexec_reboot(void)
 #define KEXEC_ARCH_PPC     (20 << 16)
 #define KEXEC_ARCH_PPC64   (21 << 16)
 #define KEXEC_ARCH_IA_64   (50 << 16)
-#define KEXEC_ARCH_S390    (22 << 16)
 #define KEXEC_ARCH_ARM     (40 << 16)
+#define KEXEC_ARCH_S390    (22 << 16)
+#define KEXEC_ARCH_SH      (42 << 16)
+#define KEXEC_ARCH_MIPS_LE (10 << 16)
+#define KEXEC_ARCH_MIPS    ( 8 << 16)
 
 #define KEXEC_MAX_SEGMENTS 16
 
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

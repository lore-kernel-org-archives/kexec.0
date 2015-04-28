Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail1.windriver.com ([147.11.146.13])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yn4za-0002Ks-Sr
 for kexec@lists.infradead.org; Tue, 28 Apr 2015 12:52:03 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t3SCpc5w001439
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <kexec@lists.infradead.org>; Tue, 28 Apr 2015 05:51:39 -0700 (PDT)
From: Kevin Hao <kexin.hao@windriver.com>
Subject: [PATCH] purgatory: Disabling GCC's stack protection
Date: Tue, 28 Apr 2015 20:50:19 +0800
Message-ID: <1430225419-23969-1-git-send-email-kexin.hao@windriver.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

If the GCC's stack protection is enabled by default, the purgatory will
also be built with this option. But it makes no sense to enable this
for the purgatory code, and would cause error when we are trying to
relocate the purgatory codes because symbol like __stack_chk_fail is
unresolved. Instead of disabling this for some archs specifically,
disable it for all the archs.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 purgatory/Makefile            | 3 ++-
 purgatory/arch/ppc64/Makefile | 2 +-
 purgatory/arch/s390/Makefile  | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 19457029e79f..a25b2626be4d 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -47,7 +47,8 @@ purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
 $(PURGATORY): CC=$(TARGET_CC)
 $(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
 		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
-		      -Os -fno-builtin -ffreestanding
+		      -Os -fno-builtin -ffreestanding \
+		      -fno-stack-protector
 
 $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/include \
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 712e2b194bee..31076e91c281 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -9,7 +9,7 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 
-ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float -fno-stack-protector
+ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float
 ppc64_PURGATORY_EXTRA_ASFLAGS += -m64
 ifeq ($(SUBARCH),BE)
 	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
diff --git a/purgatory/arch/s390/Makefile b/purgatory/arch/s390/Makefile
index 09749bd51a7f..c94cc3cec9eb 100644
--- a/purgatory/arch/s390/Makefile
+++ b/purgatory/arch/s390/Makefile
@@ -2,7 +2,6 @@
 # Purgatory s390
 #
 
-s390_PURGATORY_EXTRA_CFLAGS += -fno-stack-protector
 s390_PURGATORY_SRCS += purgatory/arch/s390/console-s390.c
 s390_PURGATORY_SRCS += purgatory/arch/s390/setup-s390.S
 s390_PURGATORY_SRCS += purgatory/arch/s390/purgatory-s390.c
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

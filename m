Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <1371764587.12068.5.camel@smoke>
Subject: [PATCH] arm: Fix out of tree build error
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 20 Jun 2013 14:43:07 -0700
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

Prefix local include paths with $(srcdir)/.

Fixes build errors like these when building for ARM out of the source tree:

  cc1: fatal error: kexec/arch/arm/crashdump-arm.h: No such file or directory

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/arm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 682db78..38137d7 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -4,8 +4,8 @@
 include $(srcdir)/kexec/libfdt/Makefile.libfdt
 
 arm_FS2DT              = kexec/fs2dt.c
-arm_FS2DT_INCLUDE      = -include kexec/arch/arm/crashdump-arm.h \
-                         -include kexec/arch/arm/kexec-arm.h
+arm_FS2DT_INCLUDE      = -include $(srcdir)/kexec/arch/arm/crashdump-arm.h \
+                         -include $(srcdir)/kexec/arch/arm/kexec-arm.h
 
 arm_KEXEC_SRCS=  kexec/arch/arm/kexec-elf-rel-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
-- 
1.8.1.2




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

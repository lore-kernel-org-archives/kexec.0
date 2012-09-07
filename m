Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9ub5-0003w5-6k
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 09:11:38 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [PATCH 1/7] libfdt: Move from kexec/arch/ppc/libfdt/ to kexec/libfdt/
Date: Fri,  7 Sep 2012 10:11:20 +0100
Message-Id: <1347009086-16506-2-git-send-email-matthew.leach@arm.com>
In-Reply-To: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
References: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, will.deacon@arm.com

From: Simon Horman <horms@verge.net.au>

This is in preparation for using the code on ARM as well as PPC.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/ppc/Makefile                       | 10 +++++-----
 kexec/{arch/ppc => }/libfdt/Makefile.libfdt   |  8 ++++----
 kexec/{arch/ppc => }/libfdt/TODO              |  0
 kexec/{arch/ppc => }/libfdt/fdt.c             |  0
 kexec/{arch/ppc => }/libfdt/fdt.h             |  0
 kexec/{arch/ppc => }/libfdt/fdt_ro.c          |  0
 kexec/{arch/ppc => }/libfdt/fdt_rw.c          |  0
 kexec/{arch/ppc => }/libfdt/fdt_strerror.c    |  0
 kexec/{arch/ppc => }/libfdt/fdt_sw.c          |  0
 kexec/{arch/ppc => }/libfdt/fdt_wip.c         |  0
 kexec/{arch/ppc => }/libfdt/libfdt.h          |  0
 kexec/{arch/ppc => }/libfdt/libfdt_env.h      |  0
 kexec/{arch/ppc => }/libfdt/libfdt_internal.h |  0
 13 files changed, 9 insertions(+), 9 deletions(-)
 rename kexec/{arch/ppc => }/libfdt/Makefile.libfdt (60%)
 rename kexec/{arch/ppc => }/libfdt/TODO (100%)
 rename kexec/{arch/ppc => }/libfdt/fdt.c (100%)
 rename kexec/{arch/ppc => }/libfdt/fdt.h (100%)
 rename kexec/{arch/ppc => }/libfdt/fdt_ro.c (100%)
 rename kexec/{arch/ppc => }/libfdt/fdt_rw.c (100%)
 rename kexec/{arch/ppc => }/libfdt/fdt_strerror.c (100%)
 rename kexec/{arch/ppc => }/libfdt/fdt_sw.c (100%)
 rename kexec/{arch/ppc => }/libfdt/fdt_wip.c (100%)
 rename kexec/{arch/ppc => }/libfdt/libfdt.h (100%)
 rename kexec/{arch/ppc => }/libfdt/libfdt_env.h (100%)
 rename kexec/{arch/ppc => }/libfdt/libfdt_internal.h (100%)

diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index e868917..5225a8f 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -1,7 +1,7 @@
 #
 # kexec ppc (linux booting linux)
 #
-include $(srcdir)/kexec/arch/ppc/libfdt/Makefile.libfdt
+include $(srcdir)/kexec/libfdt/Makefile.libfdt
 
 ppc_KEXEC_SRCS =  kexec/arch/ppc/kexec-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-elf-ppc.c
@@ -16,13 +16,13 @@ ppc_KEXEC_SRCS += kexec/arch/ppc/crashdump-powerpc.c
 
 ppc_UIMAGE = kexec/kexec-uImage.c
 
-libfdt_SRCS = kexec/arch/ppc/libfdt-wrapper.c
-libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/arch/ppc/libfdt/%)
+ppc_libfdt_SRCS = kexec/arch/ppc/libfdt-wrapper.c
+libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
 ppc_ARCH_REUSE_INITRD =
 
-CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/libfdt
+CPPFLAGS+=-I$(srcdir)/kexec/libfdt
 
-ppc_KEXEC_SRCS += $(libfdt_SRCS)
+ppc_KEXEC_SRCS += $(libfdt_SRCS) $(ppc_libfdt_SRCS)
 
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
 	kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h	\
diff --git a/kexec/arch/ppc/libfdt/Makefile.libfdt b/kexec/libfdt/Makefile.libfdt
similarity index 60%
rename from kexec/arch/ppc/libfdt/Makefile.libfdt
rename to kexec/libfdt/Makefile.libfdt
index 1d1b295..9a2b4f7 100644
--- a/kexec/arch/ppc/libfdt/Makefile.libfdt
+++ b/kexec/libfdt/Makefile.libfdt
@@ -7,7 +7,7 @@ LIBFDT_INCLUDES = fdt.h libfdt.h
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
 
-dist += kexec/arch/ppc/libfdt/Makefile.libfdt				\
-	kexec/arch/ppc/libfdt/fdt.h kexec/arch/ppc/libfdt/libfdt.h	\
-	kexec/arch/ppc/libfdt/libfdt_env.h				\
-	kexec/arch/ppc/libfdt/libfdt_internal.h
+dist += kexec/libfdt/Makefile.libfdt			\
+	kexec/libfdt/fdt.h kexec/libfdt/libfdt.h	\
+	kexec/libfdt/libfdt_env.h			\
+	kexec/libfdt/libfdt_internal.h
diff --git a/kexec/arch/ppc/libfdt/TODO b/kexec/libfdt/TODO
similarity index 100%
rename from kexec/arch/ppc/libfdt/TODO
rename to kexec/libfdt/TODO
diff --git a/kexec/arch/ppc/libfdt/fdt.c b/kexec/libfdt/fdt.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt.c
rename to kexec/libfdt/fdt.c
diff --git a/kexec/arch/ppc/libfdt/fdt.h b/kexec/libfdt/fdt.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt.h
rename to kexec/libfdt/fdt.h
diff --git a/kexec/arch/ppc/libfdt/fdt_ro.c b/kexec/libfdt/fdt_ro.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_ro.c
rename to kexec/libfdt/fdt_ro.c
diff --git a/kexec/arch/ppc/libfdt/fdt_rw.c b/kexec/libfdt/fdt_rw.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_rw.c
rename to kexec/libfdt/fdt_rw.c
diff --git a/kexec/arch/ppc/libfdt/fdt_strerror.c b/kexec/libfdt/fdt_strerror.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_strerror.c
rename to kexec/libfdt/fdt_strerror.c
diff --git a/kexec/arch/ppc/libfdt/fdt_sw.c b/kexec/libfdt/fdt_sw.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_sw.c
rename to kexec/libfdt/fdt_sw.c
diff --git a/kexec/arch/ppc/libfdt/fdt_wip.c b/kexec/libfdt/fdt_wip.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_wip.c
rename to kexec/libfdt/fdt_wip.c
diff --git a/kexec/arch/ppc/libfdt/libfdt.h b/kexec/libfdt/libfdt.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/libfdt.h
rename to kexec/libfdt/libfdt.h
diff --git a/kexec/arch/ppc/libfdt/libfdt_env.h b/kexec/libfdt/libfdt_env.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/libfdt_env.h
rename to kexec/libfdt/libfdt_env.h
diff --git a/kexec/arch/ppc/libfdt/libfdt_internal.h b/kexec/libfdt/libfdt_internal.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/libfdt_internal.h
rename to kexec/libfdt/libfdt_internal.h
-- 
1.7.12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

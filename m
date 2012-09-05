Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9E1r-00022S-VC
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 11:44:22 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [RFC PATCH 2/4] Move libfdt to a generic location
Date: Wed,  5 Sep 2012 12:44:01 +0100
Message-Id: <1346845443-32242-3-git-send-email-matthew.leach@arm.com>
In-Reply-To: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
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
Cc: Matthew Leach <matthew.leach@arm.com>, will.deacon@arm.com

Move the libfdt library to a more accessible location for other
architectures and update the ppc makefile to reflect these changes.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 kexec/arch/ppc/Makefile                               | 8 ++++----
 {kexec/arch/ppc => util_lib}/libfdt/Makefile.libfdt   | 8 ++++----
 {kexec/arch/ppc => util_lib}/libfdt/TODO              | 0
 {kexec/arch/ppc => util_lib}/libfdt/fdt.c             | 0
 {kexec/arch/ppc => util_lib}/libfdt/fdt.h             | 0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_ro.c          | 0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_rw.c          | 0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_strerror.c    | 0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_sw.c          | 0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_wip.c         | 0
 {kexec/arch/ppc => util_lib}/libfdt/libfdt.h          | 0
 {kexec/arch/ppc => util_lib}/libfdt/libfdt_env.h      | 0
 {kexec/arch/ppc => util_lib}/libfdt/libfdt_internal.h | 0
 13 files changed, 8 insertions(+), 8 deletions(-)
 rename {kexec/arch/ppc => util_lib}/libfdt/Makefile.libfdt (60%)
 rename {kexec/arch/ppc => util_lib}/libfdt/TODO (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt.h (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_ro.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_rw.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_strerror.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_sw.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_wip.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/libfdt.h (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/libfdt_env.h (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/libfdt_internal.h (100%)

diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index e868917..38f4257 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -1,7 +1,7 @@
 #
 # kexec ppc (linux booting linux)
 #
-include $(srcdir)/kexec/arch/ppc/libfdt/Makefile.libfdt
+include $(srcdir)/util_lib/libfdt/Makefile.libfdt
 
 ppc_KEXEC_SRCS =  kexec/arch/ppc/kexec-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-elf-ppc.c
@@ -13,14 +13,14 @@ ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/fixup_dtb.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/fs2dt.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/crashdump-powerpc.c
+ppc_KEXEC_SRCS += kexec/arch/ppc/libfdt-wrapper.c
 
 ppc_UIMAGE = kexec/kexec-uImage.c
 
-libfdt_SRCS = kexec/arch/ppc/libfdt-wrapper.c
-libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/arch/ppc/libfdt/%)
+libfdt_SRCS += $(LIBFDT_SRCS:%=util_lib/libfdt/%)
 ppc_ARCH_REUSE_INITRD =
 
-CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/libfdt
+CPPFLAGS+=-I$(srcdir)/util_lib/libfdt
 
 ppc_KEXEC_SRCS += $(libfdt_SRCS)
 
diff --git a/kexec/arch/ppc/libfdt/Makefile.libfdt b/util_lib/libfdt/Makefile.libfdt
similarity index 60%
rename from kexec/arch/ppc/libfdt/Makefile.libfdt
rename to util_lib/libfdt/Makefile.libfdt
index 1d1b295..f34595e 100644
--- a/kexec/arch/ppc/libfdt/Makefile.libfdt
+++ b/util_lib/libfdt/Makefile.libfdt
@@ -7,7 +7,7 @@ LIBFDT_INCLUDES = fdt.h libfdt.h
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
 
-dist += kexec/arch/ppc/libfdt/Makefile.libfdt				\
-	kexec/arch/ppc/libfdt/fdt.h kexec/arch/ppc/libfdt/libfdt.h	\
-	kexec/arch/ppc/libfdt/libfdt_env.h				\
-	kexec/arch/ppc/libfdt/libfdt_internal.h
+dist += util_lib/libfdt/Makefile.libfdt				\
+	util_lib/libfdt/fdt.h util_lib/libfdt/libfdt.h	\
+	util_lib/libfdt/libfdt_env.h				\
+	util_lib/libfdt/libfdt_internal.h
diff --git a/kexec/arch/ppc/libfdt/TODO b/util_lib/libfdt/TODO
similarity index 100%
rename from kexec/arch/ppc/libfdt/TODO
rename to util_lib/libfdt/TODO
diff --git a/kexec/arch/ppc/libfdt/fdt.c b/util_lib/libfdt/fdt.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt.c
rename to util_lib/libfdt/fdt.c
diff --git a/kexec/arch/ppc/libfdt/fdt.h b/util_lib/libfdt/fdt.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt.h
rename to util_lib/libfdt/fdt.h
diff --git a/kexec/arch/ppc/libfdt/fdt_ro.c b/util_lib/libfdt/fdt_ro.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_ro.c
rename to util_lib/libfdt/fdt_ro.c
diff --git a/kexec/arch/ppc/libfdt/fdt_rw.c b/util_lib/libfdt/fdt_rw.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_rw.c
rename to util_lib/libfdt/fdt_rw.c
diff --git a/kexec/arch/ppc/libfdt/fdt_strerror.c b/util_lib/libfdt/fdt_strerror.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_strerror.c
rename to util_lib/libfdt/fdt_strerror.c
diff --git a/kexec/arch/ppc/libfdt/fdt_sw.c b/util_lib/libfdt/fdt_sw.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_sw.c
rename to util_lib/libfdt/fdt_sw.c
diff --git a/kexec/arch/ppc/libfdt/fdt_wip.c b/util_lib/libfdt/fdt_wip.c
similarity index 100%
rename from kexec/arch/ppc/libfdt/fdt_wip.c
rename to util_lib/libfdt/fdt_wip.c
diff --git a/kexec/arch/ppc/libfdt/libfdt.h b/util_lib/libfdt/libfdt.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/libfdt.h
rename to util_lib/libfdt/libfdt.h
diff --git a/kexec/arch/ppc/libfdt/libfdt_env.h b/util_lib/libfdt/libfdt_env.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/libfdt_env.h
rename to util_lib/libfdt/libfdt_env.h
diff --git a/kexec/arch/ppc/libfdt/libfdt_internal.h b/util_lib/libfdt/libfdt_internal.h
similarity index 100%
rename from kexec/arch/ppc/libfdt/libfdt_internal.h
rename to util_lib/libfdt/libfdt_internal.h
-- 
1.7.12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

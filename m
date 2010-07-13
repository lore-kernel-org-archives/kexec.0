Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OYVhP-0003Cz-Bn
	for kexec@lists.infradead.org; Tue, 13 Jul 2010 02:58:24 +0000
Date: Tue, 13 Jul 2010 11:58:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec for powerpc mpc83xx processors
Message-ID: <20100713025819.GA23313@verge.net.au>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
	<1278948593.9525.3.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1278948593.9525.3.camel@localhost>
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
To: Matthew McClintock <msm@freescale.com>
Cc: krish <radhakrishna.p@gmail.com>, kexec@lists.infradead.org

On Mon, Jul 12, 2010 at 10:29:53AM -0500, Matthew McClintock wrote:
> On Mon, 2010-07-12 at 11:52 +0530, krish wrote:
> > I have changed subject to "mpc83xx" instead "mpc85xx", and continue
> > compile error in this email.
> > I will post new request for "support of kexec for mpc85xx", if
> > required.
> 
> No this is fine, I'm just trying to make sure I understand exactly what
> you are doing.
> 
> > 
> > "Makefile.libfdt" file is not present in the package.
> > 
> > I have used following link to download package.
> > http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.2-rc1.tar.gz 
> 
> It looks like this package is missing stuff. My only advice here is to
> use git instead. I just tested GIT HEAD and the file is included and the
> complication works. Can you give that a shot?

Sorry about that, I have resolved this problem by including the
following change in 2.0.2-rc2.

http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.2-rc2.tar.gz

From 04b22ab9dda7e73064c9b20cf08308473a7b0951 Mon Sep 17 00:00:00 2001
From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 Jul 2010 11:32:16 +0900
Subject: [PATCH] build: Include missing files in tarball

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 include/Makefile                      |    1 +
 kexec/arch/arm/Makefile               |    4 ++--
 kexec/arch/ppc/Makefile               |    5 ++++-
 kexec/arch/ppc/libfdt/Makefile.libfdt |    5 +++++
 kexec/arch/x86_64/Makefile            |    2 +-
 purgatory/arch/ppc64/Makefile         |    1 +
 6 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/Makefile b/include/Makefile
index 12c1030..c26b503 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -1,6 +1,7 @@
 dist += include/Makefile		\
 	include/config.h		\
 	include/config.h.in		\
+	include/kexec-uImage.h		\
 	include/x86/x86-linux.h		\
 	include/x86/mb_info.h		\
 	include/x86/mb_header.h		\
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 7419621..3d07e59 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -10,6 +10,6 @@ arm_KEXEC_SRCS+= kexec/kexec-uImage.c
 
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
 
-dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS)			\
-	kexec/arch/arm/kexec-arm.h					\
+dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
+	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\
 	kexec/arch/arm/include/arch/options.h
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 5988213..d4f04ec 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -23,5 +23,8 @@ CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/libfdt
 ppc_KEXEC_SRCS += $(libfdt_SRCS)
 
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
-	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ppc_asm.h		\
+	kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h	\
+	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ops.h			\
+	kexec/arch/ppc/ppc_asm.h					\
+	kexec/arch/ppc/include/page.h kexec/arch/ppc/include/types.h	\
 	kexec/arch/ppc/include/arch/options.h
diff --git a/kexec/arch/ppc/libfdt/Makefile.libfdt b/kexec/arch/ppc/libfdt/Makefile.libfdt
index 6c42acf..1d1b295 100644
--- a/kexec/arch/ppc/libfdt/Makefile.libfdt
+++ b/kexec/arch/ppc/libfdt/Makefile.libfdt
@@ -6,3 +6,8 @@
 LIBFDT_INCLUDES = fdt.h libfdt.h
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
+
+dist += kexec/arch/ppc/libfdt/Makefile.libfdt				\
+	kexec/arch/ppc/libfdt/fdt.h kexec/arch/ppc/libfdt/libfdt.h	\
+	kexec/arch/ppc/libfdt/libfdt_env.h				\
+	kexec/arch/ppc/libfdt/libfdt_internal.h
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index e6a8d35..0f35a46 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -15,6 +15,6 @@ x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
 
 x86_64_ARCH_INIT = kexec/arch/x86_64/arch_init.c
 
-dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS)			\
+dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS) $(x86_64_ARCH_INIT) \
 	kexec/arch/x86_64/kexec-x86_64.h kexec/arch/x86_64/crashdump-x86_64.h \
 	kexec/arch/x86_64/include/arch/options.h
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 40a9e99..dc9c12e 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -13,4 +13,5 @@ ppc64_PURGATORY_EXTRA_ASFLAGS += -m64 -mcall-aixdesc
 ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
 
 dist += purgatory/arch/ppc64/Makefile $(ppc64_PURGATORY_SRCS)		\
+	purgatory/arch/ppc64/hvCall.h					\
 	purgatory/arch/ppc64/purgatory-ppc64.h
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

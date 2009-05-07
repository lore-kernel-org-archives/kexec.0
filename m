Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C3w-0008Sn-BV
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:38 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 07/14] x86, boot: simplify arch/x86/boot/compressed/Makefile
Date: Thu,  7 May 2009 15:26:55 -0700
Message-Id: <1241735222-6640-8-git-send-email-hpa@linux.intel.com>
In-Reply-To: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

From: H. Peter Anvin <hpa@zytor.com>

Simplify the arch/x86/boot/compressed/Makefile, by using the new
capability of specifying multiple inputs to a compressor, and the
CONFIG_X86_NEED_RELOCS Kconfig symbol.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 arch/x86/boot/compressed/Makefile |   39 +++++-------------------------------
 1 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 0f4b5e2..b35c3bb 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -29,7 +29,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 
 
 targets += vmlinux.bin.all vmlinux.relocs relocs
-hostprogs-$(CONFIG_X86_32) += relocs
+hostprogs-$(CONFIG_X86_NEED_RELOCS) += relocs
 
 quiet_cmd_relocs = RELOCS  $@
       cmd_relocs = $(obj)/relocs $< > $@;$(obj)/relocs --abs-relocs $<
@@ -37,46 +37,19 @@ $(obj)/vmlinux.relocs: vmlinux $(obj)/relocs FORCE
 	$(call if_changed,relocs)
 
 vmlinux.bin.all-y := $(obj)/vmlinux.bin
-vmlinux.bin.all-$(CONFIG_RELOCATABLE) += $(obj)/vmlinux.relocs
-quiet_cmd_relocbin = BUILD   $@
-      cmd_relocbin = cat $(filter-out FORCE,$^) > $@
-$(obj)/vmlinux.bin.all: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,relocbin)
+vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
 
-ifeq ($(CONFIG_X86_32),y)
-
-ifdef CONFIG_RELOCATABLE
-$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin.all FORCE
-	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin.all FORCE
-	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin.all FORCE
-	$(call if_changed,lzma)
-else
-$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,lzma)
-endif
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T
-
-else
-
-$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
+$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
+$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
+$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzma)
 
-LDFLAGS_piggy.o := -r --format binary --oformat elf64-x86-64 -T
-endif
-
 suffix_$(CONFIG_KERNEL_GZIP)  = gz
 suffix_$(CONFIG_KERNEL_BZIP2) = bz2
 suffix_$(CONFIG_KERNEL_LZMA)  = lzma
 
+LDFLAGS_piggy.o := -r --format binary --oformat $(CONFIG_OUTPUT_FORMAT) -T
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix_y) FORCE
 	$(call if_changed,ld)
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

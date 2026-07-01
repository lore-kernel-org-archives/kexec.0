Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF4C43602
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PIZMSvPfVuRMXmdu87cxJx7C/Mfl/bxr49IbGb1G0n4=; b=Uc5MlB1B2WFqpURuRjGBH2qngT
	5wzWnX+9mfsDL6r0ZbxoN54J0UGrrTONlEnLENTA/dFW9cYyCUFxdRqrvS0LiCvXgc8mCsWsSxoJt
	Y86R4zsUJ8/j/i89x1T52iyxNO+DY2ycivFhgCY2u2AhlA81cHkfeQ8U/q+qQ4j0eXvDnYZuUKZ7S
	D/qpTZuhrYvoKeF+iq3dDntCQ0zuKdy6jVmq3ToWChbVuRGTeUJl6hCwDkRx/qzL3i2b6XhIgYj+1
	+K5fx3KFca8nIRoBKLKyI9W1QD6yiKhlCKOXIR//0o6NA99PaAiwTi8Z4F7HWZKqhBDXIYmiZNoBr
	ShNQMzuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wexNO-00000002T6u-0NQy;
	Wed, 01 Jul 2026 16:01:26 +0000
Received: from out-185.mta0.migadu.com ([91.218.175.185])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wexNB-00000002Svr-0INo
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 16:01:23 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782921670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIZMSvPfVuRMXmdu87cxJx7C/Mfl/bxr49IbGb1G0n4=;
	b=Orxi+YsW6oSOntVAqUt4fxrwVfb9eq1JJB94XFdGKdgVpdZqSe0iSqsTLFyvcH2HwGYa3n
	nFH9a7z78UmXfqbIBKC+zDayoUKvEhVTvCQpn8CaF8jQZs/LT5EOTroF7tNXF/W+C3HTpQ
	kjySXGCB85EcCdgw7pWrjWapPhDM0fk=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v4 2/2] LoongArch: kexec: load the command line in its own segment
Date: Wed,  1 Jul 2026 23:59:57 +0800
Message-Id: <20260701155957.534779-3-dongtai.guo@linux.dev>
In-Reply-To: <20260701155957.534779-1-dongtai.guo@linux.dev>
References: <20260701155957.534779-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_090113_761697_4AA7CF33 
X-CRM114-Status: GOOD (  21.84  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: George Guo <guodongtai@kylinos.cn>

The kexec'd kernel receives its command line through register a1, which
machine_kexec_prepare() pointed at the fixed address KEXEC_CMDLINE_ADDR
(0x108000) in the reserved first 2MB.  That address overlaps the
firmware-provided FDT.  QEMU places its machine FDT at physical 0x100000;
dumping the FDT it generates makes the overlap concrete:

  $ qemu-system-loongarch64 -M virt -cpu la464 -m 1G -smp 2 \
        -machine dumpdtb=qemu.dtb
  $ fdtdump qemu.dtb
    // totalsize:       0x100000 (1048576)
    // off_dt_strings:  0xd04
    // size_dt_strings: 0x179

The FDT declares fdt_totalsize = 1MB, so it claims the entire
[0x100000, 0x200000) upper half of the reserved region, even though its
actual content ends at off_dt_strings + size_dt_strings = 0xe7d (~3.6KB).
KEXEC_CMDLINE_ADDR (0x108000 = base + 32KB) therefore sits inside the FDT
region and only survives because it lands in the trailing slack.  A larger
FDT (more CPU or memory nodes) whose content grows past 32KB would be
clobbered when the command line is written, reproducing the silent second
boot that earlier motivated moving the relocation trampoline off 0x100000.

The command line is passed by register, not at a hardcoded location, so it
does not need a fixed address.  Load it into its own kexec segment instead:

 - In file mode, add modified_cmdline as a segment with kexec_add_buffer()
   and store its destination (TO_CACHE(kbuf.mem)) in arch.cmdline_ptr.  The
   buffer is now owned by the image and freed in post_load_cleanup(), which
   also fixes a pre-existing leak of modified_cmdline.

 - In the legacy kexec_load() path, point arch.cmdline_ptr at the
   destination of the user-supplied command line segment instead of copying
   it to the fixed address.

Drop KEXEC_CMDLINE_ADDR.  The kexec core places the segment clear of the
firmware FDT, so the overlap is removed regardless of FDT size.

Tested with tools/testing/selftests/kho/vmtest.sh on LoongArch (file mode,
kexec_file_load): the second kernel comes up with the full command line
("kexec_file console=ttyS0 earlycon kho=on panic=-1") and earlycon, and KHO
restore succeeds.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/include/asm/kexec.h         |  1 +
 arch/loongarch/kernel/machine_kexec.c      | 25 +++++++---------
 arch/loongarch/kernel/machine_kexec_file.c | 33 ++++++++++++++++++++--
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index 6be136e9f0a0..fa4e1798c6af 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -38,6 +38,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 struct kimage_arch {
 	unsigned long efi_boot;
 	unsigned long cmdline_ptr;
+	void *cmdline_buf;	/* file mode: cmdline segment buffer, freed at cleanup */
 	unsigned long systable_ptr;
 };
 
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 7ced6ca2dadb..e4d1cf5f0e12 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -21,8 +21,6 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
-#define KEXEC_CMDLINE_ADDR	TO_CACHE(0x108000UL)
-
 static unsigned long reboot_code_buffer;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
@@ -41,29 +39,26 @@ int machine_kexec_prepare(struct kimage *kimage)
 {
 	int i;
 	char *bootloader = "kexec";
-	void *cmdline_ptr = (void *)KEXEC_CMDLINE_ADDR;
 
 	kimage->arch.efi_boot = fw_arg0;
 	kimage->arch.systable_ptr = fw_arg2;
 
-	if (kimage->file_mode == 1) {
-		/*
-		 * kimage->cmdline_buf will be released in kexec_file_load, so copy
-		 * to the KEXEC_CMDLINE_ADDR safe area.
-		 */
-		memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arch.cmdline_ptr,
-					strlen((char *)kimage->arch.cmdline_ptr) + 1);
-		kimage->arch.cmdline_ptr = (unsigned long)KEXEC_CMDLINE_ADDR;
-	} else {
+	/*
+	 * In file mode load_other_segments() already placed the command line in
+	 * its own segment and stored its address in arch.cmdline_ptr.  For the
+	 * legacy kexec_load() path the command line is supplied in a segment
+	 * whose buffer starts with the bootloader name; point the second kernel
+	 * at that segment's destination instead of copying it to a fixed
+	 * address that can overlap the firmware FDT.
+	 */
+	if (kimage->file_mode != 1) {
 		char head[8];
 
-		/* Find the command line */
 		for (i = 0; i < kimage->nr_segments; i++) {
 			if (copy_from_user(head, kimage->segment[i].buf, strlen(bootloader)))
 				continue;
 			if (!strncmp(bootloader, head, strlen(bootloader))) {
-				if (!copy_from_user(cmdline_ptr, kimage->segment[i].buf, COMMAND_LINE_SIZE))
-					kimage->arch.cmdline_ptr = (unsigned long)cmdline_ptr;
+				kimage->arch.cmdline_ptr = TO_CACHE(kimage->segment[i].mem);
 				break;
 			}
 		}
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..2d6b994f358f 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -32,6 +32,9 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	image->elf_headers = NULL;
 	image->elf_headers_sz = 0;
 
+	kfree(image->arch.cmdline_buf);
+	image->arch.cmdline_buf = NULL;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
@@ -152,6 +155,8 @@ int load_other_segments(struct kimage *image,
 	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
 	if (!modified_cmdline)
 		return -EINVAL;
+	/* Owned by the image from here on; freed in post_load_cleanup(). */
+	image->arch.cmdline_buf = modified_cmdline;
 
 	cmdline_add_loader(&cmdline_tmplen, modified_cmdline);
 	/* Ensure it's null terminated */
@@ -227,13 +232,35 @@ int load_other_segments(struct kimage *image,
 	}
 
 	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
-	cmdline = modified_cmdline;
-	image->arch.cmdline_ptr = (unsigned long)cmdline;
+
+	/*
+	 * Load the command line into its own segment instead of copying it to
+	 * a fixed address in the reserved low memory, which can overlap the
+	 * firmware-provided FDT (e.g. QEMU places a 1MB machine FDT at
+	 * 0x100000).  The second kernel receives this segment's address in
+	 * register a1; see machine_kexec().
+	 */
+	kbuf.buffer = modified_cmdline;
+	kbuf.bufsz = COMMAND_LINE_SIZE;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = COMMAND_LINE_SIZE;
+	kbuf.buf_align = PAGE_SIZE;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = true;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret < 0)
+		goto out_err;
+
+	image->arch.cmdline_ptr = TO_CACHE(kbuf.mem);
+
+	kexec_dprintk("Loaded command line at 0x%lx memsz=0x%x\n",
+		      kbuf.mem, COMMAND_LINE_SIZE);
 
 	return 0;
 
 out_err:
 	image->nr_segments = orig_segments;
-	kfree(modified_cmdline);
+	/* modified_cmdline (image->arch.cmdline_buf) is freed in cleanup. */
 	return ret;
 }
-- 
2.25.1



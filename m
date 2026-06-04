Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F1BCD6E4A
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qk2XO2YZX9Ln1pAdVPnMLvfveYauig7cdWN65Sl46ws=; b=NUPOYMsqKvKBiye2CKYFsUbuaN
	pjjpZ3u52UsLkl9X/bMDWDirIcFfp81o1MdPba+Q1hZomAF6h/PcZbW6it8V9aSBD9xCHh3dceIc0
	vJi4L4ejkrA/RkBqRZF37K+ZxuF5+rjLfHhJ/ThPqaUWIyzpj8YT/tLxNg1JMlX1eKSwBjDq4bJlU
	kxuQvlVtths/xefOAxco5BaQk6Fb6A3foeAuVUGKWbMWUGDhdrgBXerluTjqiRYCbfkQi2TmSGoMY
	Y7XRNnBjPcdxM+fRgTB5paHXC65Sb/bu3nBwrNK4sUA3qlgcSGuF9xwjt/c4bfSyi9TOd4iCWKrlX
	gXedLGHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV6Rq-0000000GeuA-2w21;
	Thu, 04 Jun 2026 11:41:18 +0000
Received: from out-185.mta0.migadu.com ([2001:41d0:1004:224b::b9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV6Rn-0000000GetU-0Mo5
	for kexec@lists.infradead.org;
	Thu, 04 Jun 2026 11:41:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780573271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qk2XO2YZX9Ln1pAdVPnMLvfveYauig7cdWN65Sl46ws=;
	b=jekSMxMNlV3iCVVB/1ug/bBO3WGo78aS1KipNbzed843YMtOz9JLpaG8RA7QBx/6p1mvW+
	Hiw/YxGZQt8IlRhdE+G7JrIhBUSRPz4/VSu0JgUQa2v2onfp/dyCM658KfDnqLxLPwuJ5C
	lf5SJjSbC7Xy0vF71N+Xh3i+ZZ8+pWw=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org
Cc: maobibo@loongson.cn,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v3] LoongArch: kexec: use core control page for relocation trampoline to avoid QEMU FDT conflict
Date: Thu,  4 Jun 2026 19:41:06 +0800
Message-Id: <20260604114106.391502-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_044115_269726_C69E4027 
X-CRM114-Status: GOOD (  17.30  )
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

KEXEC_CONTROL_CODE was hardcoded to TO_CACHE(0x100000).  QEMU places its
machine FDT at physical 0x100000 when booting with '-kernel', so
machine_kexec_prepare() overwrote the FDT with the relocation trampoline.
The kexec'd kernel's fdt_setup() then read trampoline code instead of a
valid FDT, earlycon auto-detection failed, and the second kernel booted
silently with no console output.

The trampoline does not need a fixed address.  It is executed by the
current kernel to relocate and enter the new kernel, and is dead once the
new kernel starts.  Drop KEXEC_CONTROL_CODE and reuse the
control_code_page that the kexec core already allocates (as arm64 and
riscv do).  That page is excluded from the relocation copy and lives
nowhere near 0x100000, so the QEMU FDT is left intact.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
Changes in v3:
- Only the relocation trampoline is moved off the hardcoded address onto
  the core-allocated control_code_page.  v2 also moved the kernel command
  line to a kexec control page, but as Huacai pointed out a control page
  only avoids being clobbered by the relocation copy in the current
  kernel; it is not reserved in the new kernel, which reads the command
  line early in boot.  The command line therefore stays at the existing
  fixed KEXEC_CMDLINE_ADDR in the reserved first 2MB (unchanged).

Changes in v2:
- Instead of moving KEXEC_CONTROL_CODE to a different fixed address, reuse
  the kexec core's control_code_page for the trampoline.

v2: https://lore.kernel.org/all/20260601033820.38805-1-dongtai.guo@linux.dev/
v1: https://lore.kernel.org/all/20260528135828.196953-1-dongtai.guo@linux.dev/

 arch/loongarch/kernel/machine_kexec.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index d7fafda1d541..3527da57234d 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -21,8 +21,14 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
-/* 0x100000 ~ 0x200000 is safe */
-#define KEXEC_CONTROL_CODE	TO_CACHE(0x100000UL)
+/*
+ * The kexec'd kernel reads its command line from this pointer early in
+ * boot, so the command line must live in memory the new kernel will not
+ * reuse.  Keep it at a fixed address in the first 2MB, which both the
+ * current and the kexec'd kernel always keep reserved (see
+ * memblock_reserve(PHYS_OFFSET, 0x200000) in arch/loongarch/kernel/mem.c).
+ * 0x108000 does not overlap QEMU's machine FDT at 0x100000.
+ */
 #define KEXEC_CMDLINE_ADDR	TO_CACHE(0x108000UL)
 
 static unsigned long reboot_code_buffer;
@@ -72,9 +78,14 @@ int machine_kexec_prepare(struct kimage *kimage)
 		}
 	}
 
-	/* kexec/kdump need a safe page to save reboot_code_buffer */
-	kimage->control_code_page = virt_to_page((void *)KEXEC_CONTROL_CODE);
-
+	/*
+	 * kexec/kdump need a safe page to save reboot_code_buffer.  Reuse the
+	 * control_code_page allocated by the kexec core (as arm64 and riscv
+	 * do) instead of a fixed address: the trampoline is only executed by
+	 * the current kernel before entering the new kernel, so it needs no
+	 * fixed or reserved location.  This also stops machine_kexec_prepare()
+	 * from overwriting QEMU's machine FDT at 0x100000.
+	 */
 	reboot_code_buffer = (unsigned long)page_address(kimage->control_code_page);
 	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
 
-- 
2.25.1



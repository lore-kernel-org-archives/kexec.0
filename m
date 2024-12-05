Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE35EE7716D
	for <kexec@archiver.kernel.org>; Thu,  5 Dec 2024 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Igzw2FpuOdN8JV32gGNo6ufcDNCSrfphToQqI27Lv94=; b=NaLEr4CfbrhiK19LF83rgxp25a
	GPvlD/VL6zCrux/EkIUO4WIvaThSLzSiTFlemo7xGmm8tm+NBqCvyVtFf6+X52Zqjn+exC9KQJG7H
	PKTeZwGIFZqVMLDjsuRXQSVdPRqvhHkwr8Sm7RDCoLrCaDzMyAs3ixdwUQ11TR3QHZIIaUpKbm22u
	yPCkRaKjERdHm1UdEdhMkSheO6fxUAcJ7q9uY0Bwl8IlEwHctyWjLmtbwbqOrQOg7FIW7Ylr3+4V9
	+tV1fsepC1/l5RO+r6EQjp4BtCfoIOjERhh2E41ZbzsVx16SN/Q/sTT6GJ+PvDreeLRX9+EgEq95Z
	C+PwPi1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDsv-0000000GYyZ-2tEF;
	Thu, 05 Dec 2024 15:35:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrQ-0000000GYRj-2ceq
	for kexec@bombadil.infradead.org;
	Thu, 05 Dec 2024 15:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Igzw2FpuOdN8JV32gGNo6ufcDNCSrfphToQqI27Lv94=; b=vpca3ChZR+H66rMA0ICD+i7ijP
	w3f6NykSVeRBT8TWVQqWazQ72keUJG9AkYU2r+XFkSD2mWmvFTezdDdkvEnofdvYAdVY6lAiYTwYa
	gsUOYDs/QMEPxcCfjeKEGeu0PySykhINaxjlL6B29HXHqT+xVhh5qwFPL5dMgY9IQ1qk0InG1igup
	lbDchYKI3mGYck5TVmtjeAWrEpZzlRfae5iYg7SF/qC+9xjfJo41D9gO8LhWloYN5QCBZcKge6CnE
	qZYmlD0hNft9oHI77w2V06FN6hZh7iJPNOFQU7I4YDsTRvpD2bsRmib6o/kT0t8ULTbjEbok8My5v
	fpzs2jXw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrM-0000000DDoy-0k9n;
	Thu, 05 Dec 2024 15:33:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyL8-0x1L;
	Thu, 05 Dec 2024 15:33:45 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v5 01/20] x86/kexec: Restore GDT on return from preserve_context kexec
Date: Thu,  5 Dec 2024 15:05:07 +0000
Message-ID: <20241205153343.3275139-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

The restore_processor_state() function explicitly states that "the asm code
that gets us here will have restored a usable GDT". That wasn't true in the
case of returning from a preserve_context kexec. Make it so.

Without this, the kernel was depending on the called function to reload a
GDT which is appropriate for the kernel before returning.

Test program:

 #include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/kexec.h>
 #include <linux/reboot.h>
 #include <sys/reboot.h>
 #include <sys/syscall.h>

int main (void)
{
        struct kexec_segment segment = {};
	unsigned char purgatory[] = {
		0x66, 0xba, 0xf8, 0x03,	// mov $0x3f8, %dx
		0xb0, 0x42,		// mov $0x42, %al
		0xee,			// outb %al, (%dx)
		0xc3,			// ret
	};
	int ret;

	segment.buf = &purgatory;
	segment.bufsz = sizeof(purgatory);
	segment.mem = (void *)0x400000;
	segment.memsz = 0x1000;
	ret = syscall(__NR_kexec_load, 0x400000, 1, &segment, KEXEC_PRESERVE_CONTEXT);
	if (ret) {
		perror("kexec_load");
		exit(1);
	}

	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
	if (ret) {
		perror("kexec reboot");
		exit(1);
	}
	printf("Success\n");
	return 0;
}

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/relocate_kernel_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index e9e88c342f75..1236f25fc8d1 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -242,6 +242,13 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movq	CR0(%r8), %r8
 	movq	%rax, %cr3
 	movq	%r8, %cr0
+
+#ifdef CONFIG_KEXEC_JUMP
+	/* Saved in save_processor_state. */
+	movq    $saved_context, %rax
+	lgdt    saved_context_gdt_desc(%rax)
+#endif
+
 	movq	%rbp, %rax
 
 	popf

base-commit: d0ceea662d459726487030237689835fcc0483e5
-- 
2.47.0



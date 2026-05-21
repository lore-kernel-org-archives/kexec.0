Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CECD4F3D
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 03:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jfo9dgmUcsdzA0J84nZBveNZm5OuqrF660R9IUGehdQ=; b=vWn7G8Mx9eT1kc8HVxibGD5MZN
	0jLGIF9UQkto9gCoxbtDd4WrYXAHx8fDtH1EeVnxxA6yzLC4hySydlBkX/WOoUtYCSW7/0So1RcgX
	9t+ZsUU4CiHZeHyU02oDWGoXWHpStjtQtjyvaAAL2v7gHNzoF8JRH+xiH/+Mfkuknp0RIWA97n2Hr
	icoiGmqBrwyEDQBCCh6nuE+EKVkaG86dv/D4W6nI9gWt0ctPwDGi4IQqsKQY5UzO7wRTHcLQ0X8DK
	iym9MqN1b+mMC+NZ5CDF3jzvJT7XwIPr9AiSsPTCLnTRK2gwUdO3ScnhlMGYxqpWuyusHpdGHuHEm
	L6fcj1Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPuWm-00000006bYL-3NwS;
	Thu, 21 May 2026 03:56:56 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPuWi-00000006bY0-3kYx
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 03:56:55 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gLZNJ1Vzcz51Srr;
	Thu, 21 May 2026 11:56:48 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 64L3ucx5009456;
	Thu, 21 May 2026 11:56:38 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid18;
	Thu, 21 May 2026 11:56:40 +0800 (CST)
X-Zmail-TransId: 2b066a0e82786d5-02160
X-Mailer: Zmail v1.0
Message-ID: <20260521115640238hMJ3vfjHjUAucs3zqox9U@zte.com.cn>
In-Reply-To: <202605211147336599soXOrzLshSGck0QWydIB@zte.com.cn>
References: 202605211147336599soXOrzLshSGck0QWydIB@zte.com.cn
Date: Thu, 21 May 2026 11:56:40 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <luo.haiyang@zte.com.cn>
Cc: <kexec@lists.infradead.org>, <horms@kernel.org>, <zhang.run@zte.com.cn>,
        <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIDMvNF0gUklTQy1WOiB1c2Uga2VybmVsIGltYWdlIHRvIGNyZWF0IGtlcm5lbCB0ZXh0IGVsZiBoZWFkZXI=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64L3ucx5009456
X-TLS: YES
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 21 May 2026 11:56:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0E8280.000/4gLZNJ1Vzcz51Srr
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_205653_253103_A3612A69 
X-CRM114-Status: GOOD (  18.96  )
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

From: Luo Haiyang <luo.haiyang@zte.com.cn>

The kdump service reported the following error:

  No program header covering vaddr 0xffffffff819fa200 found kexec bug?
  saving vmcore-dmesg.txt failed

prb stores the address of printk_rb_dynamic, which resides in the bss segment.
But the PHDR (Program Header) does not contains it. The correct approach is to
use the entire kernel memory range (includs text, rodata, data, bss) to create
the Kernel text Elf header. On RISC-V, we can use the "kernel image" directly,
which can be read from /proc/iomem.

Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
---
 kexec/arch/riscv/crashdump-riscv.c | 10 +++++-----
 kexec/arch/riscv/iomem.h           |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/riscv/crashdump-riscv.c b/kexec/arch/riscv/crashdump-riscv.c
index 6875249..deb9a49 100644
--- a/kexec/arch/riscv/crashdump-riscv.c
+++ b/kexec/arch/riscv/crashdump-riscv.c
@@ -80,16 +80,16 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 				char *str, unsigned long long base,
 				unsigned long long length)
 {
-	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
+	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
 		return mem_regions_alloc_and_add(&crash_mem_ranges,
 						base, length, RANGE_RAM);
-	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
+	} else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
 		return mem_regions_alloc_and_add(&system_mem_ranges,
 						base, length, RANGE_RAM);
-	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
+	} else if (strncmp(str, KERNEL_IMAGE, strlen(KERNEL_IMAGE)) == 0) {
 		elf_info.kern_paddr_start = base;
-	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
-		elf_info.kern_size = base + length - elf_info.kern_paddr_start;
+		elf_info.kern_size = length;
+	}

 	return 0;
 }
diff --git a/kexec/arch/riscv/iomem.h b/kexec/arch/riscv/iomem.h
index 7671e26..86da971 100644
--- a/kexec/arch/riscv/iomem.h
+++ b/kexec/arch/riscv/iomem.h
@@ -4,6 +4,7 @@
 #define SYSTEM_RAM		"System RAM\n"
 #define KERNEL_CODE		"Kernel code\n"
 #define KERNEL_DATA		"Kernel data\n"
+#define KERNEL_IMAGE		"Kernel image\n"
 #define CRASH_KERNEL		"Crash kernel\n"
 #define IOMEM_RESERVED		"Reserved\n"

-- 
2.27.0


罗海洋
操作系统产品部/中心研究院/系统产品_产研平台与直属
中兴通讯股份有限公司
成都市天府大道中段800号中兴大厦A座
M: +86 18215606036
E: luo.haiyang@zte.com.cn
www.zte.com.cn
------------------Original------------------
From: 罗海洋10243395
To: kexec@lists.infradead.org <kexec@lists.infradead.org>;simonhorman <horms@kernel.org>;
Cc: 张润10190954;蔡衢10034260;
Date: 2026年05月21日 11:47
Subject: [PATCH v3 0/4] kexec-tool：bug fix for crashdump load on riscv
From: Luo Haiyang <luo.haiyang@zte.com.cn>

This patchset fixes kexec-tool related to crashdump load on riscv

patch 1: crashload should use all system RAM but crash reserved memory.
patch 2: make the phys_to_virt function return the correct value.
patch 3: vmcore-dmesg accesses the address located in the bss segment,
use kernel image to creat kernel text elf header.
patch 4: due to the kernel image being additionally exported in /proc/iomem,
the kernel memory range is not correctly handled by to_be_excluded.

Changes from v2:
- use kernel image to creat kernel text elf header
- do not exclude kernel memory range
- https://lore.kernel.org/kexec/20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn/T/#md89827a089395745d3bd361889e4f3c490641732

Changes from v1:
- Add patch 2 and patch 3 to fix other bug
- https://lore.kernel.org/kexec/20260513171150519t11GTC14QEEV4EgIurNHM@zte.com.cn/T/#u

Luo Haiyang (4):
RISC-V: fix crashdump load memory ranges
RISCV: Fix incorrect virtual address translation in crashdump load
RISC-V: use kernel image to creat kernel text elf header
RISC-V: kernel image memory rang should not be excluded

kexec/arch/riscv/Makefile          |   2 +
kexec/arch/riscv/crashdump-riscv.c | 218 +++++++++++++++++++----------
kexec/arch/riscv/iomem.h           |   3 +-
kexec/arch/riscv/kexec-riscv.c     |   8 +-
util_lib/elf_info.c                |  41 ++++--
util_lib/include/elf_info.h        |   1 +
6 files changed, 184 insertions(+), 89 deletions(-)

--
2.27.0


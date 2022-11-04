Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCE5C4332F
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OLgLWZ3okS6dYdnlivgsCIMTm/tARDZwXhgGmpDCW3M=; b=EDZY6DzIL6bRIa
	rCA4tJKOUYNMdmqL95xCYmHPQJ0hmRxLieSYHJr4PO59LB9ngXRcClUYVudo7YmvRqcoczHXDtWed
	poDt/SqXQKhoTk8Q2TyoO5wrpCryTGgt7VsKgc37hHC2dgfp1zucyvaoqTM2OZpXThGlRrNeie03f
	BQnimbCjsoBa7yopsmPtCBjxj2zw1qlJG7XgUT9fOF0n56A0axQTayO95RuDmctfAasDG5w2tEpkh
	x87IcQfvaIhidDLxrxCwHV/KY0GUQS1cTyNsOasi0jX7Z5p0suHspyWNL/+RumijZd8ltXjnN6/Qe
	H0UTuaaCbCdqgGPSDl/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqtUu-003ANi-2p; Fri, 04 Nov 2022 10:00:24 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqtUp-003AKr-BH; Fri, 04 Nov 2022 10:00:21 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N3bdS6RwQzJn3Y;
	Fri,  4 Nov 2022 17:57:16 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:00:12 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:00:12 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<lizhengyu3@huawei.com>, <liaochang1@huawei.com>,
	<u.kleine-koenig@pengutronix.de>, <rdunlap@infradead.org>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <lihuafei1@huawei.com>
Subject: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
Date: Fri, 4 Nov 2022 17:56:57 +0800
Message-ID: <20221104095658.141222-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_030019_747419_3A656885 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This is reported by kmemleak detector:

unreferenced object 0xff60000082864000 (size 9588):
  comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
  hex dump (first 32 bytes):
    d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
    00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
  backtrace:
    [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
    [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
    [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
    [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
    [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
    [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
    [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
    [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
    [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
    [<0000000040c62c03>] ret_from_syscall+0x0/0x2

In elf_kexec_load(), a buffer is allocated via kvmalloc() to store fdt.
While it's not freed back to system when kexec kernel is reloaded or
unloaded.  Then memory leak is caused.  Fix it by introducing riscv
specific function arch_kimage_file_post_load_cleanup(), and freeing the
buffer there.

Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/riscv/include/asm/kexec.h |  5 +++++
 arch/riscv/kernel/elf_kexec.c  | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index eee260e8ab30..2b56769cb530 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -39,6 +39,7 @@ crash_setup_regs(struct pt_regs *newregs,
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
+	void *fdt; /* For CONFIG_KEXEC_FILE */
 	unsigned long fdt_addr;
 };
 
@@ -62,6 +63,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     const Elf_Shdr *relsec,
 				     const Elf_Shdr *symtab);
 #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+
+struct kimage;
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
 
 #endif
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 0cb94992c15b..ff30fcb43f47 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -21,6 +21,14 @@
 #include <linux/memblock.h>
 #include <asm/setup.h>
 
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	kvfree(image->arch.fdt);
+	image->arch.fdt = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
+
 static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 				struct kexec_elf_info *elf_info, unsigned long old_pbase,
 				unsigned long new_pbase)
@@ -298,6 +306,8 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		pr_err("Error add DTB kbuf ret=%d\n", ret);
 		goto out_free_fdt;
 	}
+	/* Cache the fdt buffer address for memory cleanup */
+	image->arch.fdt = fdt;
 	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
 	goto out;
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

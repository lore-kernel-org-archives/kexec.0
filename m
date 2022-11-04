Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45373C43217
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T71LkabXVOvKqU3uMPLuazKXcTpdpS8qyqgSiYeL8k4=; b=gUl07HTvi5CYdP
	fvxPWaKxJPbZEYgWzAEAahq3QGFZLkN0aXKvphtXdVTZG9aXTvIYfvQtfhqLha4FrOSIqRUrmWa2v
	LX6YRXnhshjQTj9Pk0Fd7lWC/497A1BmihYIZXuf+T0Opke1VHsm8Bjjm3t2X+0agDeWBJJThHb0c
	JbJqrvW9OCZQLU8Ywy8v2dPDwGfs1q/Kbbx5TXAM6CzKdRuy0RSDQAV06383MoVD4ZOT1lDdoG0hW
	icRAHyiGagEZACteRnUzsRNMtrZ9kQN6qFGPcZ1bRGDsUvSaA1+gSIMryQOM+oUxTtwt1FHxkLft5
	GrSQkEGmMOyYC1MaTQ8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqtUw-003AOg-PY; Fri, 04 Nov 2022 10:00:26 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqtUr-003AKw-FZ; Fri, 04 Nov 2022 10:00:23 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N3bhS6M9MzHvZ2;
	Fri,  4 Nov 2022 17:59:52 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:00:13 +0800
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
Subject: [PATCH 2/2] RISC-V: kexec: Fix memory leak of elf header buffer
Date: Fri, 4 Nov 2022 17:56:58 +0800
Message-ID: <20221104095658.141222-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_030021_724755_CA1BA592 
X-CRM114-Status: UNSURE (   9.24  )
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

unreferenced object 0xff2000000403d000 (size 4096):
  comm "kexec", pid 146, jiffies 4294900633 (age 64.792s)
  hex dump (first 32 bytes):
    7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00  .ELF............
    04 00 f3 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000566ca97c>] kmemleak_vmalloc+0x3c/0xbe
    [<00000000979283d8>] __vmalloc_node_range+0x3ac/0x560
    [<00000000b4b3712a>] __vmalloc_node+0x56/0x62
    [<00000000854f75e2>] vzalloc+0x2c/0x34
    [<00000000e9a00db9>] crash_prepare_elf64_headers+0x80/0x30c
    [<0000000067e8bf48>] elf_kexec_load+0x3e8/0x4ec
    [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
    [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
    [<0000000040c62c03>] ret_from_syscall+0x0/0x2

In elf_kexec_load(), a buffer is allocated via vzalloc() to store elf
headers.  While it's not freed back to system when kdump kernel is
reloaded or unloaded, or when image->elf_header is successfully set and
then fails to load kdump kernel for some reason. Fix it by freeing the
buffer in arch_kimage_file_post_load_cleanup().

Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/riscv/kernel/elf_kexec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index ff30fcb43f47..5372b708fae2 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -26,6 +26,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	kvfree(image->arch.fdt);
 	image->arch.fdt = NULL;
 
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
+	image->elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

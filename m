Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31300C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=miEM+ZI1eBAN6H+hUm7y5SHAIdsM2tNi01WsyWumT6E=; b=u7NTSbYQQrst7ccTh7wbkyVzP5
	LvaiJk40FYB/UeqDNByK0cGBp/7IP8GBNNsQuIlbkzcnK7RmD5hD5qapPAGSo+d0dbxCP50AAogBX
	aavRVBw2x16c9JC+tspjX8II4lE/0CuNvJb1ElOjj86PxMtv69eowhd44qc7dLAuE6DyPabdQeS/8
	2dRvLjOggqzNrkeITOWCHaKMqb8V6afbRz4kvRSAr4Iyb0ndDK2lV724C4Yct/xszrToCnkihFnh+
	uL7EYjAGsrGLBRvodPt1COfSLMAK4h1p2K9UaYzbx1OsULpwQSUYxOPykuwu47elIfpqS3qdWCJfc
	CviRGOuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTDk-0000000GBMX-2g0f;
	Tue, 30 Jun 2026 07:49:28 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTDK-0000000GAbN-455n
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:49:07 +0000
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2c7cfa17fedso34254915ad.3
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805742; x=1783410542; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miEM+ZI1eBAN6H+hUm7y5SHAIdsM2tNi01WsyWumT6E=;
        b=ixQLsS+A63rePmdkpfuTziJ9qMnyOYNgdJ8e1gnTM+Ur1phooF0RHmJaeOt6ihnOOn
         2rJ8Wmbu4nwxv8grCgjQhwhf7NBsYkOiWYd59AFRbwoKk+aS9CnDz2glNOVKMBT6pxSe
         lTCdGF7kufKHQMD1lyOY6j5cOPgoUTdbZy2bQIfosrnqoXp/HWXh9buC4Toy92HUTfMA
         hdy7kYnRYvixFQbGxf4GLLixV7lISyq6Y0DEe8XoiBP7Rs/GAkoRl0pmSUBveUskjUmN
         Y21vJkjmTieCHzeGf8hPQ4tn5dyAVrRF9IYCqYItisS9plHQ7/hSUZRlU4flvbChsdJG
         x0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805742; x=1783410542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miEM+ZI1eBAN6H+hUm7y5SHAIdsM2tNi01WsyWumT6E=;
        b=AopYas+8uX460A8H+i6cr76jzd3Lvlsm/7Lv2DBbLlSHqfqMta2OcmHdVakviuww9K
         FVsvEMz5BfkVw8rKK1jkyJfSD4fN5RsDZt5UZAg+hLsFe+0SA8axG6iG3g8bnUGukwTB
         98z8cD9JHYFZjOEeroMi312UR5M/PMsyYeC0mNcHerjmQtmudnyVPZ8QVPb68IPbcx7a
         xWvDiwciL3ZrdTeA6LLmd0u7gf7xRsydCU9sLMWSGY6StTdNP041wb8od3+4ZrHu+rUc
         hOFD/pb8DhyeJfuHXzf4LXgUp9BUlUCfw3qcjheJ0wLj5Wxh1PkfvcTYrY8RH61NkWlI
         0LAw==
X-Forwarded-Encrypted: i=1; AHgh+RoESkLNGoPyCEPWOpRuuaM5AIjMW6qKi/GGuuaN5XD51bggn3pngztJGmb7D55caaq2wHUNbg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4dA3y6WQsoSTRYGSNWI0Wg40/lfBrE14P2RK0CqVi1lR+TbtV
	ebOgwYLB5f7DXeXPeXuftbE9B3mcb/VSxyxPneddjHdBZ6Fd99v5GpES
X-Gm-Gg: AfdE7ckr3MnAuNdmFknjx1+miI+SP3SSNBMPqTPLBM238OGQ6bsfeZb6C5fsVmgxov7
	qzQ45QZwEWChCInEwnqEbGeQFznQDevwVFM2JrSPqO/p5OBfbLJmEWMQhCr1zYUBYuTY3PzdCtM
	cWYludCQSZfVsS/flLDpSPPlo/fo1mc/FXfKaFe6Yqbh+reOv8mIP5yAvJ0d70mtYvED8A53cwx
	YB+sXLIV4ikQPdAapScMfsaLGUf/9mWMbJw1bBbYxAX1ptebZBSN1YXtfj03rWMuzdh8Hod3Myi
	eyzprTU7BRwcNKebJQJH3xSXxUpCyM5PdecLVxRakO5+ckl9hMonQV29nmPsPS8jT1HNHYrywkH
	jjMrhZG8gLePdcAXB/9NFatYai/LVcM2huSGyU0eWzhHs8gQ9w1r85RtyQNSzs4z+COggCuloHH
	W4eBLxM2pFh9EcI1KtSlrYWrjVFg==
X-Received: by 2002:a17:903:186:b0:2c0:a746:7b16 with SMTP id d9443c01a7336-2ca2d8a616amr19688075ad.22.1782805741701;
        Tue, 30 Jun 2026 00:49:01 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:49:01 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 09/10] riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Tue, 30 Jun 2026 15:47:13 +0800
Message-ID: <20260630074715.4126796-10-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_004903_050465_07D6B83C 
X-CRM114-Status: GOOD (  10.84  )
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

From: Wandun Chen <chenwandun@lixiang.com>

Apply the same non-dumpable reserved memory filtering to RISC-V kdump
as was done for arm64. Use of_reserved_mem_kdump_exclude() to drop
flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 59d4bbc848a8..25359d583bc3 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -10,6 +10,7 @@
 #include <linux/elf.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/libfdt.h>
 #include <linux/types.h>
 #include <linux/memblock.h>
@@ -64,6 +65,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	nr_ranges = 1; /* For exclusion of crashkernel region */
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -77,6 +79,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (!ret)
+		ret = of_reserved_mem_kdump_exclude(cmem);
 	if (!ret)
 		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
-- 
2.43.0



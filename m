Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD8BCD5BD2
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=; b=TShjS/BpyDeL/LGn6GGcB/vw4R
	RIsCtmaTwh2sIRRiMD5vPF3Oj2F0Pp51lr0BD2Nq/lNLmXC7INi8+L8YZhnqbAuZHrvhGEG6pls4L
	r3QoUxbv3GqP5AxxE4DKHa2R7EBIbAanJxRPhBDUm3uDKdfAgsIOdY4LrAkJE/vMCPtSDfmXAZpX4
	5dQdsuY4XLKljAeTvNwFfLxuovf+RHKPuE085/sVc5otzuU2Q2P+p9rfI9XCKawaeSI4IFdu/6Rxh
	3wIDHKLRFebwWP+Eq2psH3iGWeDwEQESRf0zxRs51m7reIInwJioTUw6YLx6LdHJXyPzPV0nKNfdU
	AiQ863ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4zb-00000003G96-3apg;
	Wed, 27 May 2026 03:31:39 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4zZ-00000003G70-0XqB
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:31:38 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-83d5bbef760so4689061b3a.1
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852696; x=1780457496; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=blf/MMtZ4GsUxGzz2WFUPCJ/Y+JiH80/1wfva7NQ9KlfDRI22vmrFMVYHu+I2HCybB
         Y7tbubCdC9bJnNH3NSY1RzXEIZUysu+g5aOQV/uer95zx+3gzAWjO5pLs8esjHyVdz4H
         FGoLEcBFymAN0jaFDa7RKMf8GfBJA9dYihsTlPGL4pAO10mXZTy7TW3nMmHeXBRSVZK7
         RRnt1wPbW32iSpxZbFTvUDyVcy2+O0WNrwxjSlt8gN2vvVpbqsdQCLGgnagjmNcFvb2E
         N7PtozNe1LDxyhq6kXNwASa+ua/rWmEO5BNdFRenl3RLIqvwlmCz6XWKY2Z7j7lbaAOW
         RuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852696; x=1780457496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=JwKhFCz47NqvSS+GEq9PQ9EuFA7oNgdhZfLGCocTmRdkKVswbm13uvDS6a+XTzjYaq
         ZP/koaF6tUq/n4lLE7N0prduTUmiHokPUNZG6FZoZIUwKFtQSCerRS4yGrFEifHXXwP5
         6W5T2KiSs6gixYlQyHxNOvR+fy7exW1mGUwqw8bkTVOtRzw0fwXlvnVYc/dUj8EAoMs8
         xxEqn9rH//FCKmGSCc9HdN8giL/JUeq27wwet51dOfAzpi3UTWujo3cFWGQQHquJw3mP
         wD0GnXoT6mo3TcTcj6tWse1Yio9NXD7vQRLJx69FxpQJfJJe6f8x+oaI6/96+8T4yaKu
         VMmA==
X-Forwarded-Encrypted: i=1; AFNElJ83ejjMVQOMlAnEL41UP4zjHQDkogSSPPLJGNnGY3AlbZ4YCHkhq8nKHDDMXna6N+QYWvIljQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVYvW8CLFpJtGZHy/cybz6+PO+g/VAtSmyg0S36IVB8ZgzpWxW
	vkLQXB4Dcxu0TW8Js4tJdxkLyPvplM4Mo3d6YZDt2eNsdO1hJjkj5Esq
X-Gm-Gg: Acq92OHySr4PtCcPcEcHSucZObp8y+37wU22YFBp2NFcmvYiUdRB3MH2WSNjxZOclTU
	xYX24PnddFreMgJ5Rb4M8mXKJsoTQfWlhMc/UAChxdmYKS3QFHkXzRDfHm7uRZZGw7Iac5/shT7
	5kksvLOxwOT6MCy9y6JROZTBYW+CRcRq2fDYAKT0tuMfE6twv711aUPGVx368XGlIRJ6WzIe0A+
	UesAJ4EjP3Yl35jQjGpnD00mSUK/jK7MZW1gj7i96xqxtjmF9y9PyLguOrYWA0QQ+w78iUZstn/
	4dEbB8EKFZ7EgiemDy12XYHP/9Ocp8sdZDFKNG/RoB+I5Y3RkuiiKUKdAv6+A9q8IU0dF6eESry
	09PPJc5zOWwgWSleO3JF2qkRk27Nl6XQtkxDyFk3eOaM/zLjmYXkPCJU/L67CyNklklDbfTkNhy
	f8lx0Dq+bnyLqOa94ST9OTkjC2zqPAvw2BnqTzp4pM1GtTK8zpKmS0g7Y2eg==
X-Received: by 2002:a05:6a00:3a0d:b0:837:8c8f:8f51 with SMTP id d2e1a72fcca58-8415f3bdb92mr20798104b3a.47.1779852696430;
        Tue, 26 May 2026 20:31:36 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:31:35 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 11/11] loongarch: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 27 May 2026 11:29:17 +0800
Message-ID: <20260527032917.3385849-12-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_203137_178645_22984041 
X-CRM114-Status: GOOD (  10.69  )
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

Apply the same non-dumpable reserved memory filtering to LoongArch
kdump as was done for arm64. Use of_reserved_mem_kdump_exclude() to
drop flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/loongarch/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..4b918c3d4a28 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -67,6 +68,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -91,6 +93,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_kdump_exclude(cmem);
+	if (ret)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97651C5620A
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6uyTtFjVVo4Ow+xxdf9JzDuHeX18HS+OnizMa+EN8GU=; b=hhV6GhkeZRT2GfaHz72DL/Nl3E
	f6smtEr553dpKGG1XodPf8McxtoFE9+vfToPOiTYcm8r88/yVjRFWGlhlM2XlG6M2mhvyFE2qIK75
	BW4iweFz0tiPJCUZ/ZdDharbFN/oO4i1oxHTDZTGGBal4adrVq6b/aqoToIOrThkGg8VWclXVdOpF
	UwOqdVZqHSGGBbDeMZ9KJWeu0zrBF/o6VYKV2D6qRO5ulAY8psG8IzB8s4vnbK+OUzbFlkfCMlT7G
	92Os79j44WWFDtg0MliyN90/W3KDm4AZ0e8drwnrp2USa2N6qGMzeKT2GPZ+Kxo0LQkxqXTRvWIW1
	CBbiPvbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruXK-00000005R0s-37dx;
	Thu, 06 Aug 2026 09:37:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruXJ-00000005Qz1-1XxY
	for kexec@bombadil.infradead.org;
	Thu, 06 Aug 2026 09:37:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6uyTtFjVVo4Ow+xxdf9JzDuHeX18HS+OnizMa+EN8GU=; b=mvRZ56VgpeI4/bXiwEW4Fffroo
	GRa2hVSVTIpnKJtm4GxkN4SJtypM8/zgntiyLTEjxxUy2czsh9Hp5FTSexFxCVTOq99F8Zq2Gguxf
	sTkvNuq2sJL9Gr2mnX+nuORVjWboQW2kLNj+ja+BWZurQ0Rue1G/XNwLpX56JwhicoAhIi5mF3oN8
	piNc4OTwr+Ev/mCqzDtu0//xo+SsZ+2uSeu2RcEfQdL4AfLHx81/Hjax3ECAO5w1hsqAH6kvYUSvV
	/8IXwQ9+yG/4Te32/GT/k+gFiNOesxA+qIPPm0EB3MD1n7QXFonlwmoRvMlIIiPr5zQl8w7ziHjOG
	WgstNWSQ==;
Received: from mail-pz2-x00.google.com ([2607:f8b0:4864:3b::])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wruXG-0000000BNZQ-2STn
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 09:37:12 +0000
Received: by mail-pz2-x00.google.com with SMTP id 41be03b00d2f7-cb01d87597cso89616a12.1
        for <kexec@lists.infradead.org>; Thu, 06 Aug 2026 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009029; x=1786613829; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6uyTtFjVVo4Ow+xxdf9JzDuHeX18HS+OnizMa+EN8GU=;
        b=N73AwJSYHD6sg4hLqt69ovjH+PSEa6WRvURkdaDMbq+HjCIFZ76HggtErorca8XzxM
         WQEDmqqYYTCNTmYP9iFC/D5DpwWs43e8CwC0PrAvkKGp3GndgUaC07AjP20K0SvhBBxz
         vG58+l49sAUOd7Z6CY4WBCeDuWE5PqP+FJJ/81SoIWlXKTnL7q92KcIXowFVjmeXuoDz
         Dr5qOD01SSDpZrnMfyvhPndSxW2itu+UwvGGcFZUoo221CIoBTKVZ0iKXqofu3QCN1Np
         r30BU6Bxi/S1YlpTKCWrHtEZWWchKGkAycg7jeMJvfeOIWzkg/3IcLLiNQ8DWkAH1CmS
         fCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009029; x=1786613829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6uyTtFjVVo4Ow+xxdf9JzDuHeX18HS+OnizMa+EN8GU=;
        b=ljLJ1IytVeK3xNrxaYhxVn2FUBB9y3BMtTtsl7cG2fcQCtPYsC3vgXF7srUorrBz0V
         W78xGrQWKcSmJBjO5cCZ32eh1Dn2bn0nGrFgQ8MR0zg1apCeKEIhMNtLiyVsuNY5nnCQ
         9+pIemw0WdnbzTya7Tdsy4VQ6nwPiYSdTcKV/gYKHW00Ogl/+pnFJuUa1nQo4bYbTvDV
         QkNJza8bN9MLcdc88AP42vyt+sSMnwlHnUss3dqmkSvpwKCMaHLOtURHnKyogeDABfba
         4sV6aEI4jr4uwdgBpRKyODPFWpJecMDd17HDmhMzK9fXPOzSZ4cOwFxQrO/fNxaiO9aH
         NI+g==
X-Forwarded-Encrypted: i=1; AHgh+RonkRfYpuhldHyVlYB9qte+pRxc3zg8JN0LKMcWGNZlXAdVVMPvcAfVXsa7yLsjHuwGXJNniw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmnTM9BNzysWHpY0Ddfq5RlomVU/aSB0XSY1yIW47F+726W53B
	jsVdTZTxl6oYRI7eJ39EfsPK40ke5ugIP4ObWc/Hy5IF5KvqEOyRp/sz
X-Gm-Gg: AR+sD13BCOlpodUPc5W7x6cyg0Q3WZIcMVfoJQIaAKSiE31qFkny5SV8edXRpXsVqgy
	RedFbiZ4jKwYh2KqhBJVs7zkei3oz3QEDeRWQP6Ox/1B/QH+JvF9Q4OU4fJrO7smiyJv7zkivbc
	dt3NNXnR/x3EQo3xrOiHojyfur5uXXH2DJZHpSPQ2Xd1KIo1JdABPVXwQAhIk2ZinAXthtOE7ia
	3v817Q6XU4Zr3zuBFEMneFXP9v1mpVSmyP8cuTCOItyy9jmu6vLojOu3HMIUX/yk7ol5Zxaxi+7
	gkJh5A9A0xR/9T0bobEENqLH0YpiQwOTRNSSswnbo9yHUZKbuKDbKtPgMVf7kVAdwNLszoicXbK
	rYk4hcbDMAki2ZulU3dmU79WYWK4EE3DCRYNIMN3sBJ24oiBNBg7kHP1wdD/bNzDSWlwHH+eXd/
	o0X8omvm0405/NW3riHZ2p6atxU+/04jJ2ihBs2KN2fhX8lYyCzlnAc6W9z/T4ZIv6fgrQSiOnS
	Q==
X-Received: by 2002:a05:6a00:464f:b0:846:5d1f:56d4 with SMTP id d2e1a72fcca58-84f47dd0b44mr3119262b3a.14.1786009028817;
        Thu, 06 Aug 2026 02:37:08 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:37:08 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 8/8] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Thu,  6 Aug 2026 17:35:19 +0800
Message-ID: <20260806093519.2907771-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_103710_748753_46CF2C46 
X-CRM114-Status: UNSURE (   9.59  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Wandun Chen <chenwandun@lixiang.com>

Reserve regions (for GPU, DSP, ...) carry no data useful for crash
analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
reduce vmcore size and capture time. crash_should_skip_region() now also
returns true for MEMBLOCK_NODUMP.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index fb78b7814f18..8cc9d666bc54 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -269,10 +269,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
-- 
2.43.0



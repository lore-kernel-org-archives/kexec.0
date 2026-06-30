Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66980C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXdqCoAvNU5Q6CQ7sbboLRp1ZBRBcN1iNhiraDQrK4I=; b=1PyJ8u/HEhr0pAkBVq6nHrSvGV
	yRX9WzB5UZ5lpumovFFt/sbt+VvLrY4SuOvo0OA7MwOfjXwg+8TAthzS61MvqBmGpn+CDYqpFlXNM
	MkdF5PHY6anSJbmr0OHGIZxG6u4Y2KLq2hoS+xpdmQhSlConI+Kohl5xrWNbu1Pqq1/yK9QEdQsFH
	Uz1fqlIVEJIjPjaXDD9le2R03jgJ/6d2wj+DHyFulmB8mLS/v/AeqgZL3+v6Zpg4tpVHmtBxVtkFO
	KAzkKrs2X3+C2m5R7pX/um8ASxHQNUlnj6hrxmfkD/VNhW/0N0HZHe7f5YAKwMHwfgRusE8aAWcjf
	IIueSKZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTCj-0000000G9v4-2GfG;
	Tue, 30 Jun 2026 07:48:25 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTCe-0000000G9pk-3rtU
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:48:24 +0000
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-37fc01881f2so2550605a91.1
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805700; x=1783410500; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXdqCoAvNU5Q6CQ7sbboLRp1ZBRBcN1iNhiraDQrK4I=;
        b=DkvYhZJ4mla3bTpfZnSeGNvJvIOhJmz0c3SrZotgyibR/5pVc+GzTlTVhjIWanSSjM
         UKMRty4+Y8VIGvpd1Ul7aNea5IiuTcMWeyaIMtkHl50xgXWZHc0e7s63+IDpndeJEQHE
         rEwJtaIZRRdVj32qNUZAxFj0mdbjtbNJKW5OdyOIOZ7/q4M6cih4nKO+sfwoGrFG/2fy
         vYqnqRw2ndKRLHoNv/bO7K8fbdzCzqLBoDq3TUmK8lqaa1G+fEop8Dx7FcpoZnyO4NEN
         5/CuSubvOjxRN6yqe+ASJLhyTkpYCwsX9GuRxlQlMcfLxYVZxxxQPJAZwSuqPI3pVQeN
         5WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805700; x=1783410500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXdqCoAvNU5Q6CQ7sbboLRp1ZBRBcN1iNhiraDQrK4I=;
        b=in3mhcfVoWs7uT4YvygQ1CCROGSw04/DdgTGivjRXJeMzn77yZqvA5r35MzhrbuKtQ
         ZmKcfw+aGtZGMtTNmoJnu+wyOfd9OXT6xQwAnzWIsXyIlEDfw/D09UWybA56cZGd1tqZ
         3HshHSB+JywUTMSkZY/bVionR+rMEf0pUCpmxjpn3o83xzv+qXoXrc1X32F1e1mvbE29
         iR5opCtRrAftuKkx8HamMasT9hWZmzU1wrfA1aYdpePdhdznVn/DvZnR2u62pjFY1hbj
         Was8IiJ7Mt2ys9wruLKfLLY6ZfSuxYowap9GPhnYZxPcH+9sqVW71qhfuNGA3CH7mq7M
         ze2g==
X-Forwarded-Encrypted: i=1; AHgh+RoysTYdCvY0PFcBkKzlM61uxy/Wxe4t2B3e5JRZqRJFy1TpEdQzsclZaQEtn3fYa/RRJDDuqQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyf+oSGkyKiS/Tnv9JhyYfs0ytGnZfr9li/fh8JltXDur7Shg7Z
	yq/4C7KeqrUzp8Bm6HHZ2QOjm/Vz1TqpkEGqX+PufzMpSTmz1OpxPTgX
X-Gm-Gg: AfdE7cnB7XEVIqJmY9JFepqqQjOVTrMSrPUhlmEka8Jrzf6liMK66M3Y8Dl1m9mWqSK
	fbVQ7rmqUYV7pt2mSIh2311Lezm/6eNRQSJdEZ12EthzFNazFncHIFA/evr17sf2KDmZuXpZhvQ
	tk/15tnjEukhNJPnfRiUWd66g3kU13kWF6TQLa2hvrJOxfK1y1WFCs4WtzxVd2ZE4YjXC/e+hdV
	4LXFLBF6Y8hCeNbPIbCW7JEk+3yLahhFjpMDVyXXDYIC38914XSBANix6KjieCgdW8sESgogtX3
	ElsnSi6C3hC1CX2dc9EGLahlNF4H7yQAiJuLIdyxCkH2uBX7DkCs8samX3xFbzuO81uPb03PI00
	2DvLu8sVXL9/qEMlOfphAA1VwlUDRdyjcPi9LaxBF0VX2DgPf1tHAROgQXVOUsrelvzSDQEQKYW
	8Cl8q6hMSpkWm2neNgHHGilBRosA==
X-Received: by 2002:a17:90b:2249:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-38052784effmr1969443a91.23.1782805700221;
        Tue, 30 Jun 2026 00:48:20 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:19 -0700 (PDT)
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
Subject: [PATCH v4 05/10] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Tue, 30 Jun 2026 15:47:09 +0800
Message-ID: <20260630074715.4126796-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_004821_416423_3381D621 
X-CRM114-Status: GOOD (  12.52  )
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

Add a 'dumpable' flag to struct reserved_mem so the kernel can decide
whether a reserved area should be included in the kdump vmcore. Most
reserved regions are owned by devices and do not contain data useful
for kernel crash analysis, so excluding them by default is the right
behaviour.

Reusable CMA regions are different: pages in a CMA region are handed
back to the buddy allocator and may contain key data for crash
analysis, so set dumpable to true in rmem_cma_setup().

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/all/20260506144542.GA2072596-robh@kernel.org/
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..55a67cee41ea 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f754079a287d..63ff134dadd4 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -565,6 +565,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0



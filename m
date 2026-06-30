Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0CEC43602
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=; b=G4Cr2eZN9VmChDRnVPAJMuJrUU
	UmtCVMNSs1w22k8ZG6rzlPvuK+FU6EB0uJQQ3jMb3IGr8Z9FVSiVTB3TDVjtrfcF8kt4YsUlvA4yI
	woqIyJifKoWDaW2Av95fSqyflO0XdvGujchUanapDczRXS1YeG8TzSaWCCIqL5ORcE33k8nC/t0QE
	hPJicc3y1Wg9Cj312uBNiHvBs5guFHD1fuPKiVy84+Rkq/yDjbJXmlQrb6OP3G031HGVkfGWWjWQ3
	uYlKHg4RrHalgiyj5kfCD4MmNy8pc+l3RLJ9XfsbJ7Quuh6Gc7dwVnW9TaP5HwEWZoR40jT61IIub
	Wt51fzhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTDp-0000000GBT6-0aIP;
	Tue, 30 Jun 2026 07:49:33 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTDU-0000000GAwk-0f6q
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:49:14 +0000
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-2c82538b6c0so24615135ad.2
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805751; x=1783410551; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=rPs549NUIaOK9IgZRYBxk54jGtXtcrUxfDczlc2YE+mbp8kn/nlC0iTiwYgKSYDuFP
         83GJ/m8phl6S1MQt/PmdOUjV5/KIXIUrDMm96vrkjm8Q52D8iEIfK+iz22yemckToPXs
         bQ5CBjv4yTz4VhpneP5J5vkPD68wYRAGEXqhH3Ly+q7LNhAiLDp3EypZLuxfhN0ydJhp
         CVbypyP/rqzpENRLlG+y15Dr5IxrZojpBE2gP4IIGRtvuRWbxvXx8y/KFM9TMA0P1T57
         nM7TsPHYWj+727QeYJdOgCum87J7vk2Q/q9/UIbElKvT/E6eSMuCRLPXD7GPHvvMB8K6
         3K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805751; x=1783410551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=kpcZJ0cShDQ/NOhyyWyc8tGYjJqI+LrgywGizdSgnvlV2qU11V2EwH7FkP6fAOgzBK
         zDww+fwhvfcv4d9m1Jyze8iAqPWy+sI8Ec5mEIc9hJ7t0ocHt3MydnWG8czDLXK+DzWI
         edgydfKMxu//Tn5wtL2ClMvrXopMk/yMyz+qMUJXNpn/X5mFHB59ktkteQUbqDK4l1o1
         JixMljGbAd4mKqkQZTfSDzH1nPa223yRLV4dSaOVp6gKvZBHw35AjhXKeG9Jml2/rQW1
         c1JdW10s1p6Ibd1osDcr89sufw3AuLontTAGxkXmPHsQFcR/0vz6D819KZnNZZn64H6g
         DX4w==
X-Forwarded-Encrypted: i=1; AHgh+RoxWnAMBW2XPq6LeAVuVZPTJfaXWYVvAwvm+ldWIsX2P5MYbJJG4GzXJWoTyv5sP9KWQcUEcw==@lists.infradead.org
X-Gm-Message-State: AOJu0YysXIDTN80ciLgXh+iGwCsQ08LcU18lvZkN0R5NnXEaMTpOAPeW
	FgGh2U5GmNNu5JvasCsedYCy9x2WmT2+5FpKjS/bAzHvUBqJlqPXBRfv
X-Gm-Gg: AfdE7cmrudBqrpGhEqOoDeZPIoo+tzMy0JA9HFOoqxqGjbF4vU8c66XJvaxtEtWxJqv
	u7RKRI86c5DPFVrTZcU8XhDQ2ZdGb9QPlInxNfELRioI5uNk+n/McOq9ofqZOe8i2agtY94p7+z
	/pgM9XrfawEQPdAj+Ah9G0IGZ4eZT40Y+GfVQ1FReTnk6sJfvGHzPSarBZbHqzguDHOZJbdyQIc
	JY8boobvL/xECfMQzWbAfrlQVDi3Uap6qs6AUNrVpDZDkVKXzto5iURDkO/jusYrZ7tje81ceUe
	OXnmQwCnLd0GOxwGQDCzNN7Aq3lQ5KohiID9/9DcH9qVaa1UqX3v64LG07eEXRtxXICpq+En07R
	DOuz7vUgkaeb+C7L6BzKXBUvs8SXwVMOtxDR+QjOF1Xcxh5b0aUmIpbCQNAdtfvNs3nTscFEyes
	1GuUMsROaf2cSmygGDPNYlnwUd2A==
X-Received: by 2002:a17:902:c94c:b0:2c0:cb0e:ac3a with SMTP id d9443c01a7336-2ca2e71832cmr21250665ad.23.1782805751208;
        Tue, 30 Jun 2026 00:49:11 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:49:10 -0700 (PDT)
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
Subject: [PATCH v4 10/10] loongarch: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Tue, 30 Jun 2026 15:47:14 +0800
Message-ID: <20260630074715.4126796-11-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_004912_223824_557861E7 
X-CRM114-Status: GOOD (  10.16  )
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



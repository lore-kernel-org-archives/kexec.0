Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCF1CD5BD2
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/p28EH8R5CXtCwys+lC44uig9HB9HdXcu6ohyUKifVw=; b=c7RdtnVrjTrza42FOBTkcl47Ra
	4k9xdC3GOg93FZUtnKTgagLrl2NYAY9AeOhZkwk3U3g/idgL5gBE/qcyLKbriW0KK6uzZ/hQfKDOg
	vL3mQt8gEvRM8XGDxjSSA1WhmLXN5e6rmbiIyJZIa+OS9+dW9iuPRHUuQvNzdu09pJrOXDv9Uqcod
	l1HX0V/UQhGnqIThujmfqsS5SZZ8xnBxH64c0mNDWNumZELnpL2JYwxv9XcHCZm9UqxHsMEpAv0wG
	gGggPr7UT5qTYL7ltE8yUbdvgxFMjIxz1TbLUuNdMRTjYk7tE6QM5R+3i3DjrrXQdsKJ+s8A5lKd1
	RfHVBn+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yx-00000003FZ9-18pq;
	Wed, 27 May 2026 03:30:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yv-00000003FXJ-3uWH
	for kexec@bombadil.infradead.org;
	Wed, 27 May 2026 03:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/p28EH8R5CXtCwys+lC44uig9HB9HdXcu6ohyUKifVw=; b=PTeiBKfjlYEd8+1f5CeNC/R292
	Dja/aLsMmUaotg81INbuM6eiyIHpKL3KIUMrDLNwFCaAejaITu2/bfXyuN/nA1bk61bUgfkG1bdEm
	+iIyqC/V+mGetUqZOqx3r9Qy9fT3EFADARqnKnP4VrI2MsQBLW888t8Yrfb1GvQkF6sYY2iO7EiEh
	kmrDqR2t3Yj8rnTdJ82p0ext5L48LzUkv1kK9QARUq+BlZu+USuW2FvnynM2qbikpFfbl6MLyZqLj
	/iaYvi2sXYY/2SuAJwk2CE2bLbfDXKO6DNCEuqcWc2aO1JDRWvR98h1AVZph0nUR3RzDw2CH7Y9jp
	1Y6LBhaw==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yq-0000000CqnE-0HhB
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:30:56 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-83d5bbef760so4688839b3a.1
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852650; x=1780457450; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p28EH8R5CXtCwys+lC44uig9HB9HdXcu6ohyUKifVw=;
        b=HLev4TSZuILLlLhS8SR0cR0L23fxKAvMBWHT7ndPeu4X/iiGFKV0AOVYpFzPn3c/5P
         h/eGEZ5IlEX8Ra5zRTbegsmmXfsftsEDZ22WEEz3zmUrsoCe+Rq9vUE+GrvxdAbPFYE4
         gwuh2aQdNNilVNIUjhMGzFA3wa3wpm0sF93dFJbZ6DUAV8V3tTdV+XRnWx/p7fpGSm1F
         pGbb6qZEkixj1Pw643y66ATQT3x5R55cQfpn1tY1708EXx/sRD6tvB68HSx7iXhBuJ1b
         6jHXby/9UscLkCXOga+G/DxEMFSioW9ky53ZWzWiPm0hcfq6NLdj/XqtzrujASQQwfkl
         sBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852650; x=1780457450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/p28EH8R5CXtCwys+lC44uig9HB9HdXcu6ohyUKifVw=;
        b=nvBVzeTUQB8SooMuVvMWJlMGYr3oh4T3sYEM5h1cVbgqz5MNpr0rJGfYehE+3sGEQN
         fSHnRdE7CFdS1xLCz1qN+69afB1xAzCjoQpbE0eDGX3XkFmQNwCC2+PxDc75gJFWSPaR
         xG43ovjxd7QHog5h8Dr7KKWfr1BkfSneGPYRiKNWqT69ENZvSDelIMlfs0/PGAEnlzMR
         g3oJSN9ByOTID+FOQ5/KrQIqfLln3bCNqH6BJOV3pdUOJcKewbRcu2HfkBkWsdef5532
         +YddJD+PZamLy76xMIDhcz8iRWMyBv6kWEoz1rqqbd3L1u+TThyhVk1Q7o7q2Jv9zUZ+
         AsTg==
X-Forwarded-Encrypted: i=1; AFNElJ96UxhZKRmzS11MPRjc/D3EeVxzomWASElt1yBYJsdBGB39GLHxMTiONk0JlSg8XJdROHssBw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfEkvkCs9wSxCp4HFSsYegCZ5QS6rwaL/A7KR4a4UvUM09mwdM
	rDlz+4G3CoAf+lpCrsg5qoPYoLOHghxyeLiCF36GxTnzmYPkVDzIFZ4m
X-Gm-Gg: Acq92OFu/yANzAsYB8JBFeHBU6RU5EsaK2yZJQnheQy7+D3bimp8UQD8Qy0rEgHqr0Z
	W1caXgVspleLqIozhChs3s+hRfblbqUZsKhzTPmz5YM04e9waLnCY0ur27ZJ8cmRFSvSe8IgZ0D
	xdjwTMuTmw/BrNwDEJrG5hRKhRh4FZg61vGBCJGb8uOtzsGuFEdTRTdYT1VJ2zZsqgokJYJGk9z
	euGu+kJtddW43HsrcwzSTNzEo1KvMqDW+JGgwXeLHZjqFkCFrhxINVipcrnvpx2TM3HJK1Daw0T
	TeTO4qLp4fPkRqNNRTVZ80nopeRYF3mjcmM7+L0OHTqg/WimHqjSovErlhzjfHus/ej5q+2uE1O
	BfYuJW6SRTI3ZixXR6PuQpyV5d3YHthZb5sVzsieqmZgEoMYtI8+iZXTQELxQX+2z7MCUlpyoJX
	UZx3qaAIUUTIYID9RPkGBJ3oO743b05e2LFaJ+
X-Received: by 2002:aa7:930a:0:b0:82d:24f:2509 with SMTP id d2e1a72fcca58-8415f0e26b7mr20587500b3a.1.1779852650451;
        Tue, 26 May 2026 20:30:50 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:50 -0700 (PDT)
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
Subject: [PATCH v3 07/11] of: reserved_mem: save /memreserve/ entries into the reserved_mem array
Date: Wed, 27 May 2026 11:29:13 +0800
Message-ID: <20260527032917.3385849-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_043052_722498_C67C8F55 
X-CRM114-Status: GOOD (  18.35  )
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

/memreserve/ is used by firmware or bootloaders, such regions hold no
useful data for crash analysis, they should be excluded from the
kdump vmcore, so save /memreserve/ entries into the reserved_mem array
for later exclusion.

If a /memreserve/ entry overlaps any dumpable reserved region, mark
the whole memreserve entry dumpable as well. This may keep slightly
more memory in vmcore than strictly necessary, but avoids splitting
entries and never drops data that may be useful for crash analysis.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/fdt.c             |  4 +++
 drivers/of/of_private.h      |  2 ++
 drivers/of/of_reserved_mem.c | 55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 83a2a474831e..745e53b1c564 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -499,6 +499,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	int n;
 	int res;
 	u64 base, size;
+	int nr_memreserve = 0;
 
 	if (!initial_boot_params)
 		return;
@@ -516,7 +517,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		if (!size)
 			break;
 		memblock_reserve(base, size);
+		nr_memreserve++;
 	}
+	fdt_reserved_mem_account_memreserve(nr_memreserve);
 }
 
 /**
@@ -1288,6 +1291,7 @@ void __init unflatten_device_tree(void)
 	if (fdt && alloc_reserved_mem_array()) {
 		/* Save the statically-placed regions in the reserved_mem array */
 		fdt_scan_reserved_mem_late();
+		fdt_reserved_mem_save_memreserve_entries();
 	}
 
 	/* Populate an empty root node when bootloader doesn't provide one */
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 50e5a533e059..30954e859689 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -188,6 +188,8 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
 bool __init alloc_reserved_mem_array(void);
+void __init fdt_reserved_mem_account_memreserve(int n);
+void __init fdt_reserved_mem_save_memreserve_entries(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 888dcb6bdce5..5e27f9403786 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -248,6 +248,43 @@ static void __init __rmem_check_for_overlap(void)
 	}
 }
 
+static void __init fdt_reserved_mem_add_memreserve(phys_addr_t base,
+						   phys_addr_t size)
+{
+	struct reserved_mem *rmem;
+	bool dumpable = false;
+	int i;
+
+	if (reserved_mem_count == total_reserved_mem_cnt) {
+		pr_err("not enough space for memreserve regions.\n");
+		return;
+	}
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+
+		if (!rmem->dumpable)
+			continue;
+
+		if (base < rmem->base + rmem->size && rmem->base < base + size) {
+			dumpable = true;
+			break;
+		}
+	}
+
+	rmem = &reserved_mem[reserved_mem_count];
+	rmem->base = base;
+	rmem->size = size;
+	rmem->dumpable = dumpable;
+
+	reserved_mem_count++;
+}
+
+void __init fdt_reserved_mem_account_memreserve(int n)
+{
+	total_reserved_mem_cnt += n;
+}
+
 /**
  * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
  * memory regions.
@@ -305,6 +342,24 @@ void __init fdt_scan_reserved_mem_late(void)
 	__rmem_check_for_overlap();
 }
 
+void __init fdt_reserved_mem_save_memreserve_entries(void)
+{
+	const void *fdt = initial_boot_params;
+	u64 base, size;
+	int n;
+
+	if (!fdt)
+		return;
+
+	for (n = 0; ; n++) {
+		if (fdt_get_mem_rsv(fdt, n, &base, &size))
+			break;
+		if (!size)
+			break;
+		fdt_reserved_mem_add_memreserve(base, size);
+	}
+}
+
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
 
 /*
-- 
2.43.0



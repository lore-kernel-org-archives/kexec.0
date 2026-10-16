Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AB3CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=; b=3dUGJFyLwC4g+mtWF/DXfmz1a+
	mWB7flR59Bns3Bw2+m5iZTgxWO/pECJkd9jJMAp81W38J6bDHbgE9c7oPu8Nu6FsmUeNVauV2z4P4
	1jegPmZT8Vt0lTFwNBf+uBv+Wzp5RsQxpU38lIbvu7MY0q9rtu0FZU2sbNF67Etphzz/I/kuBJUhA
	9zdcqF6wV28eNT9I7s2E6fkVikgLbCJClZNOovJ73QxRccrkL9ZfbadtN4WYlKu8EythZCPiDmiTI
	Y1a/BVIUisq4YWC6zVzJf9fAAaEiANEC65sFVvcLiGro6uDGzNXhkgL7WWSizlpkXk0YAMXygYyjq
	G4gPKkzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbEw-000000025A9-0mTU;
	Fri, 16 Oct 2026 06:16:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbEu-0000000258U-2QQT
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 06:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=; b=VFqXmnlOrLhD8pDGQ5WfsdsBpG
	xufjc4TxeVlVvD7ntN2VopPo5xumgtbH/kMqzQ17vCWLrZ7mnv88ur4mRjnW7uxiAB1MDlggMsZOH
	8v1Zpyu2buhXHEaWd8XNfiFaR+0V/25bh3qY05w2JjZNsaIPOX2jVE3NVU1QY2MCvCPvUb3OM5OvP
	6tfsWjyLKgCIUpYTX6f+JHhuAOBzdTTKDwdGzcv0bbOLkJY488Jt6MQaQQ47xY1+PQCSiEqy4u5C8
	3wTkxcDLhfYOHg73OWmOGawOmqPd5rL+CFbLiRSw22NsDlaawE4vqvKXTkj7T8pGVT2L37ciq2c4/
	rfCz8FRg==;
Received: from mail-pz2-x0b.google.com ([2607:f8b0:4864:3b::b])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHbEq-000000019Zs-2E9B
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:16:23 +0000
Received: by mail-pz2-x0b.google.com with SMTP id 41be03b00d2f7-cc1631a57d2so1161645a12.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 23:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131378; x=1792736178; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=;
        b=it/Xu88dD2gIkSe+HpUTimu4Z56RVG6dnDZWUdw5dkgdMyyhck8+sIp7h+z52eAWPB
         7sX2t4OjM3T6zthfdorh41pWnPdtDY1ZJEgxBJ/jLVqE4p2Qg2N/uuuRAZ4U1AvC8DQN
         6/HmggIkr55r3TCuuCX1OLBFCyrP3nawYFaLEE7KmVTE3zENJMini+02K49lz4tSbEak
         FFdJ4AbMYh69YaIijINwjSXi9GL/XEmOpqZLEQd9GxoRCL6HETPY7pVcDYKoizLaR45B
         9sGuMM1bnbp7Xt9XorqIV7jrWqRnV7zzZurPU8CQV7xOzBDQStLpUXqIMFaP3PqrTGSQ
         5kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131378; x=1792736178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=;
        b=2WmEdln5Ej0N0xyu5VLdx8HzW207JXllL7ApJz5Int+WohtklyDAp8DAS/kVYLWeK9
         l4cQMFxjKmzKwsu5E8QTlJfFfysz/jY/Uja8Y5neeTPUGAdXhok5nIk+iOLv5RvzeHwH
         AsrpGW6/npTo+xX1mzzxmJ2CswAliQ7USwoE6hLqfScD/Ui4B3FCulokTF/EAXUNeRmk
         hHpA6wb5G4Hp+YfNacPy2P0+ekv2VCkzHm+/+vRE7LztLRzV5GyKilmnXyz3SU9lnkq6
         8wDe0pkxhHdw6fKSRH2yAP6OL+eRNPUX/YhfCJNxc5UQtS2hJBCWFqYIZWdD5ETCEATz
         vZaA==
X-Forwarded-Encrypted: i=1; AKwUvBxlZMOc6xpFf2sSc9s/ecQ2xI5Nz3aV3yO/8kM8tCFuZuICw5yDA9KUz8aj1Pm6IGcZ8oeAdA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLHn4obzrWPlzZ5UFdMW3mLopmNIaq6Vb2HGq0xm6Pe0QfB7o5c
	0A5I+vUW3QkG0jGo8a+/PeEVgjR9xLM+pczM10Kk4paw9quXgMvHl5eO
X-Gm-Gg: AYBFou1T2jOMQXa1erctys6lhvDUmIjyYJDU9ybObWHmstJFNStyGYuhdZy4PPMPSo1
	l+fBHQ0Az0bCnxc/78GDxX/Ft2eRt/BfFqyj+HJ/mmHGGH9W1H7aGQCesnkj6xpTDQr/t1eJRDb
	3eyKOrAjYXJQVlUU1rCt9T1ngAbFRwgoNgWNCOpNH37wlWEUmMU62yNnYITLLJYKptySxJOXVTG
	RR8sCh4Tb3hVi4BWYGd9LWYGu4t1m+/5ZLm3BP6F5MDJu/mEnyrJBimOcsZGSC50QIT5aostfl0
	R2ROQsJBScGLnRZPv49aYWBlyKzdrRY8WijLmJvRuGIv37BKtKBtgx7vND7you/mISsSUrZFLds
	m9xqN0CW6GHYV75YviLG+Io/0rfwKLdwTNRxZxdfF0Q1nbP/LB6Dwxg0Z55q0iHYW8FdVGsi1K5
	B/KwtgqWkKLjDpnDFs0JjZpiQiRbz6BCu3YIR+H3r3vK2AXdKsK+Zh+T97JHU/UhKUVgdAaesA2
	bn9/a2HqHI=
X-Received: by 2002:a05:6a00:2996:b0:878:3538:8f7d with SMTP id d2e1a72fcca58-897c79d707emr18459260b3a.43.1792131378226;
        Thu, 15 Oct 2026 23:16:18 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:17 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [RESEND PATCH v8 1/8] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Fri, 16 Oct 2026 14:15:42 +0800
Message-ID: <20261016061549.4181390-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016061549.4181390-1-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_071620_739658_75F6369D 
X-CRM114-Status: GOOD (  12.13  )
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

Replace walk_system_ram_res() with for_each_mem_range(). A later patch
introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
memblock.

for_each_mem_range() iterates memblock.memory, which is freed after
init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
to filter reserved memory from the vmcore, so extend its condition
(ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
ARCH_KEEP_MEMBLOCK unconditionally.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 arch/riscv/Kconfig                     |  2 +-
 arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62a4be0474e3..529310e3ae1e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,7 +58,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC
+	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC || CRASH_DUMP
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 26cd2a8bd0cd..808e872f4063 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -37,39 +37,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_CRASH_DUMP
-static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
-{
-	unsigned int *nr_ranges = arg;
-
-	(*nr_ranges)++;
-	return 0;
-}
-
 unsigned int arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
+	u64 i;
+	phys_addr_t start, end;
 
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
 
 	return nr_ranges;
 }
 
-static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem = arg;
+	u64 i;
+	phys_addr_t start, end;
 
-	cmem->ranges[cmem->nr_ranges].start = res->start;
-	cmem->ranges[cmem->nr_ranges].end = res->end;
-	cmem->nr_ranges++;
+	for_each_mem_range(i, &start, &end) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
 
 	return 0;
 }
 
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
-}
-
 static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 				 unsigned long cmdline_len)
 {
-- 
2.43.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FFDC982F1
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQZ6M9cJvbnCelbC8h/SiM2wDn1buqTcsR+O1dmHqTM=; b=hlD+SLhT6HmKbwedkJXrSjMOKO
	7kJjwXEXz07lX7/GN/GKIUK7nIuyZewSn4xlaxfmkBHk8yc4750r6105yB/Zav9UCK77wbmA0vrd7
	65VQNNqdTJqQyS9HVMe1YL77jIKvrjSRXCfup8JYDnaaiSyg2M8NeJDCI5a7T+iZAUmINLC3in3Sf
	LfS93SsQVYZZ84y5pinm92BTBlxiaawqEceEgcuF11kss6ckx7iCxi8Kp2Jk9rFX+AUg6Hmxsrvq2
	ErsEbXVq95j18jsZbYPp6iItV5s/u85qF3XoWBttafWsF4VmOMZBPz6H+jYAgAIKn/iHXwjpq8YG1
	WOH0Va3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w6h-00000004ivo-2ws2;
	Tue, 22 Sep 2026 08:44:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w6f-00000004itb-44cK
	for kexec@bombadil.infradead.org;
	Tue, 22 Sep 2026 08:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BQZ6M9cJvbnCelbC8h/SiM2wDn1buqTcsR+O1dmHqTM=; b=Id3DDOHUoUQkdaK+o7w5aqpPEA
	UujTWPy28WCDDdQvGssGwWlhsvUOs0aG15w5NzkLYzVgez6FL/iPBRLQlotbKZvy7dHKHmVCfix/1
	E01lQw/ypvYefRXBcwDEOdwLHNvv0BhSdkp48PjgZeo7F+bnumfzy4oBOwffgIoGg3lVAH8wlgkDh
	85a/qOFtnIh6HSgpMypfjIfDMD7+YwTMNq1IpC9Q5IVVdq855a3yoL9Dw21e1q+6Ho+sF2PD/QBIn
	wSVC6krjLIYVNsEAPAEW/xiUVV9Ufj8/tvjThFOEYq8eGBMrldTxx9OhY7ZNp1cCeUN66k4mTqj3o
	sO84ZFBQ==;
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8w6a-0000000DHaA-3toC
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 08:44:04 +0000
Received: by mail-pj2-x01.google.com with SMTP id 98e67ed59e1d1-39e249c766bso1632789a91.0
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066639; x=1790671439; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQZ6M9cJvbnCelbC8h/SiM2wDn1buqTcsR+O1dmHqTM=;
        b=Fd/mG62JbKtk4HmHAb8GXJWWTXHaIVkuhIXWZYTSlUmEvysommzkCKFBepm2D3L4gy
         queTNf/QexmZyhrcLQdiKJkiDyxS0i9Z/cPYU2LIbeO0ZMQUdJYVeYsDQ/mmlM8+e/Uf
         AYvzWVzilLzZXK6DxiWyjzJy5sIRl4EXyoFEVdNz5Hk8HQXo8uPQWLPv3/T4N5gVkB6P
         oZqnwxvvzfRVWeJXvq0onEyiYM5229CVHPXWdpUqSk7RmgNlp8PNrRd+DkWvcYtgWV+F
         nRAf9OsaEbDSNsZt3wgcqxKH/AKOdw9y1gprMwhyrS7I8mvxcsX0sDCQDXJXNu0cqKdY
         2Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066639; x=1790671439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BQZ6M9cJvbnCelbC8h/SiM2wDn1buqTcsR+O1dmHqTM=;
        b=g+1Mq4lYKkpWDD28lNGG8NwevLA8T07Tc7v1SnqaQMoCojz3cfpxFQciWKKiY2Zpdc
         pFNEImiDyWdY0GmJgvfq7pG21bA34PJKY/PJs5H7ZSK3AgQYLA9qi7nCYCvD0BSeg6on
         AIghzCffe+89y10ZWbUzadw3ST63UaZsYCn4287XLFZvocuWXAWgIAxi8RvjaexP4xLb
         JkjIKGMo/HNHodBz1FXrF/EY+aJVJFIYDcyL9MhEJQL2hdG5BmczXSMS3TgGTu/zYA/p
         x98OViLm9qTnvfiP2gjN8TWNvBE/Zl536IIsyuPyCV3KRGFoNxbdmpYh+HddSHdIBMdS
         YTKw==
X-Forwarded-Encrypted: i=1; AKwUvBynnwUAMQGWUTl8If61yuPKGgI2X7WbdJm40gSpJBQa4YwA0NYNbLfsonvwCaqDQNYbPVd1tg==@lists.infradead.org
X-Gm-Message-State: AFuF++ltlrDD+DSWeoU1+Fi+WI23CHK0pHfrCCbYtEsAJO+ysJVh39AC
	+DTEMCPDZrChWQF4BBKz7l7yQX3VrDwEyKzxcrr5C8NmHzHhFliPXUAZ
X-Gm-Gg: AYBFou1sdNHxfRvD1nea/+3QdmSgrS61Xtihta1RyWCNVgTT3lpcVvUCefNvLnNcTcX
	6JBlmqi8xF45Ni/Sby4br8zzjCTKtk4pxKieetw2m7YzVX8Gis3iXsiT5z71lpLfLy4NmByLref
	fzDpWw/DBHni2V6rBtd/GTnLLAszkUW1xymNN+eojb9tY/2mT7BzIGAyxaWjDyaxtEVcFr4Hzkl
	hzmcTHPTzj2CR/P8dOspoIX+CAAvAZmCdNzIUrLjseEhdxTmslPGiq4YZZtwEvrx1IDmVQf/s3t
	UM/Pnf6Traiikk8GuVZ8FilikjqmP8ntrmcfmMnqN0iF3BsQybSHl46TxMpgPPBtRiTAB0P57g0
	HZRi0M2wNdyQteXmC7fFA85btRFPOxK59KVV7CiWu8p93sPIwY+/1SABbL7KbS9lk4OexsqANVb
	6IpikXJJxp+NakGofkdQQiPaK/MUz3g15drDC/Pax7QyO/PCdOyb564cF3l9EZXQDwg+YWL464f
	qKt5dZ678w=
X-Received: by 2002:a17:90b:35c5:b0:39e:6a80:dd9b with SMTP id 98e67ed59e1d1-3a0731f9793mr476673a91.34.1790066638632;
        Tue, 22 Sep 2026 01:43:58 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:43:58 -0700 (PDT)
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
Subject: [PATCH v7 4/9] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Tue, 22 Sep 2026 16:42:51 +0800
Message-ID: <20260922084256.1515554-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_094401_300367_818E7D68 
X-CRM114-Status: GOOD (  12.45  )
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

for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
weak defaults to for_each_mem_region(), which exposes struct
memblock_region and per-region flags, and filter NOMAP regions explicitly
via the new crash_should_skip_region() helper. This prepares for a
subsequent patch to extend the skip filter.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d0cc2496dc09..c7acb2e449df 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -270,6 +270,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
+/* Exclude NOMAP regions from the vmcore. */
+static bool crash_should_skip_region(struct memblock_region *reg)
+{
+	return memblock_is_nomap(reg);
+}
+
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 {
 	struct crash_mem *cmem;
@@ -285,22 +291,25 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 unsigned int __weak arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end)
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
 		nr_ranges++;
+	}
 	return nr_ranges;
 }
 
 int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
+		cmem->ranges[cmem->nr_ranges].start = reg->base;
+		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
 		cmem->nr_ranges++;
 	}
 	return 0;
-- 
2.43.0



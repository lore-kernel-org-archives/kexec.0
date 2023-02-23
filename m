Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87917C636D6
	for <kexec@archiver.kernel.org>; Thu, 23 Feb 2023 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sbiQ3aqegY50GkgA9nB7EHUseZ++2t87VUEmKd3LEtM=; b=yrYutd5+BquBG3
	bBDRrnGX8/v64+2UpL7uFRmWfLsQNgN4o6xwjk+Q2E+lvGB7OjwunlhNfA7N/eIcTEYiBIu6RE3be
	8juFKP4gRnVTlfHgR1ejijdPqvwxYiXWiTeg4DyRu8yyC6gzBqUf26P+xEm4pnlcGKxy2IyRvUK7a
	iglTmr5fdDzSNKNlEH99EjoiIZmEybO68UStW4Zrz8M7TBAf1D40eRjy6kW+tcT/hyL2C7HoNzFaI
	ek67hUVc4hBvd8RjG64ItkY0p5VG1r9mFsQDpPrD41OiA7EWd/ecQ5AOhqzJfkIJSMtqypA2/16/v
	vlIFliMja0Mk9ewwkdrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVAyt-00GLC0-Hn; Thu, 23 Feb 2023 12:45:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVAyq-00GLAk-Je
	for kexec@lists.infradead.org; Thu, 23 Feb 2023 12:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677156346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M8NX3ZsDrSBQPQ7I5uuezSkfCmMskoJHj9OKngyaMDw=;
	b=R8peO2O5v7yo9AIK0rMyhi3NfetqLgNxs3cUXlGFEi0KNEUN0H6TwWNWtMpiQVQ3LWeATc
	Uv++K+tUWAnYUtxczwjqtzdbPnDUVsBmGwBi1BKrBeqnpl5maoQukVxEKTeHCKgzKCZqDr
	1PH3NZWSEXCOfU0MtbpDVdwalNqpqA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-2n2RkbemMAqn6nr-EOdDmA-1; Thu, 23 Feb 2023 07:45:43 -0500
X-MC-Unique: 2n2RkbemMAqn6nr-EOdDmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EF9B802D2A;
	Thu, 23 Feb 2023 12:45:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-7.pek2.redhat.com [10.72.13.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB1692166B2C;
	Thu, 23 Feb 2023 12:45:37 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	horms@kernel.org,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	will@kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date: Thu, 23 Feb 2023 20:45:32 +0800
Message-Id: <20230223124532.128744-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_044548_765669_F7A826C9 
X-CRM114-Status: GOOD (  20.91  )
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

On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
suitable memory region top down. If the 'xM' of crashkernel high memory
is reserved from high memory successfully, it will try to reserve
crashkernel low memory later accoringly. Otherwise, it will try to search
low memory area for the 'xM' suitable region. Please see the details in
Documentation/admin-guide/kernel-parameters.txt.

While we observed an unexpected case where a reserved region crosses the
high and low meomry boundary. E.g on a system with 4G as low memory end,
user added the kernel parameters like: 'crashkernel=512M,high', it could
finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
The crashkernel high region crossing low and high memory boudary will bring
issues:

1) For crashkernel=x,high, if getting crashkernel high region across
low and high memory boundary, then user will see two memory regions in
low memory, and one memory region in high memory. The two crashkernel
low memory regions are confusing as shown in above example.

2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
and y <= 128M, when crashkernel high region crosses low and high memory
boundary and the part of crashkernel high reservation below boundary is
bigger than y, the expected crahskernel low reservation will be skipped.
But the expected crashkernel high reservation is shrank and could not
satisfy user space requirement.

3) The crossing boundary behaviour of crahskernel high reservation is
different than x86 arch. On x86_64, the low memory end is 4G fixedly,
and the memory near 4G is reserved by system, e.g for mapping firmware,
pci mapping, so the crashkernel reservation crossing boundary never happens.
From distros point of view, this brings inconsistency and confusion. Users
need to dig into x86 and arm64 system details to find out why.

For kernel itself, the impact of issue 3) could be slight. While issue
1) and 2) cause actual impact because it brings obscure semantics and
behaviour to crashkernel=,high reservation.

Here, for crashkernel=xM,high, search the high memory for the suitable
region only in high memory. If failed, try reserving the suitable
region only in low memory. Like this, the crashkernel high region will
only exist in high memory, and crashkernel low region only exists in low
memory. The reservation behaviour for crashkernel=,high is clearer and
simpler.

Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
system, or 4G if other normal systems.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
 - Rephrase patch log to clarify the current crashkernel high
   reservation could cross the high and low memory boundary, but not 
   4G boundary only, because RPi4 of arm64 has high and low memory
   boudary as 1G. The v3 patch log could mislead people that the RPi4
   also use 4G as high,low memory boundary.
v1->v2:
 - Fold patch 2 of v1 into patch 1 for better reviewing.
 - Update patch log to add more details.
 arch/arm64/mm/init.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..b8cb780df0cb 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size;
-	unsigned long long crash_low_size = 0;
+	unsigned long long crash_base, crash_size, search_base;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
+	unsigned long long crash_low_size = 0;
 	char *cmdline = boot_command_line;
-	int ret;
 	bool fixed_base = false;
+	bool high = false;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
@@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
 		else if (ret)
 			return;
 
+		search_base = CRASH_ADDR_LOW_MAX;
 		crash_max = CRASH_ADDR_HIGH_MAX;
+		high = true;
 	} else if (ret || !crash_size) {
 		/* The specified value is invalid */
 		return;
@@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
 	/* User specifies base address explicitly. */
 	if (crash_base) {
 		fixed_base = true;
+		search_base = crash_base;
 		crash_max = crash_base + crash_size;
 	}
 
 retry:
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       crash_base, crash_max);
+					       search_base, crash_max);
 	if (!crash_base) {
 		/*
-		 * If the first attempt was for low memory, fall back to
-		 * high memory, the minimum required low memory will be
-		 * reserved later.
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
 		 */
-		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
+		if (fixed_base) {
+			pr_info("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+
+		/*
+		 * For crashkernel=size[KMG], if the first attempt was for
+		 * low memory, fall back to high memory, the minimum required
+		 * low memory will be reserved later.
+		 */
+		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 			goto retry;
 		}
 
+		/*
+		 * For crashkernel=size[KMG],high, if the first attempt was
+		 * for high memory, fall back to low memory.
+		 */
+		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
+			crash_max = CRASH_ADDR_LOW_MAX;
+			search_base = 0;
+			goto retry;
+		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
-	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
+	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
+	     reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

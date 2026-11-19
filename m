Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F088606A336
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p12TiiOY;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=mA109mmF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=yaApC6dU0pHd7sFvEPl37gN234fN9yV/70NJmvLF6ok=; b=p12TiiOY6bCwpXewqSuhIDqRMM
	+bV5RbrwQFgBlzYXGVm7cm4Nwf9tf3m1VzcTrB5pJWc0VW6ei1S1zwWiqdBwkCOD7qkC0MfM3ZGlO
	HgTe/0bS7eUKjw6iNeOmV7BkOSuQAF6G7+Jk3hM5V4c3/zGQ/8hOiFzO/5pI78POy4Wh5M42zPHWI
	iky/mp+FsvZhqc+x8LH9dxibgYEcsMbMp6lkcd/cqoXVFdRHqWI906SzQsZJMwQq15CpocEjavkSR
	3UpO/HKexgC52t06pXFpkptHu8TI60rKAiPZUJIml6lYJ21IB9gnxB9lUJO4D/bIRJm/OMBIAE0Vy
	SIJtb5XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyaT-0000000BQ7y-3Uin;
	Thu, 19 Nov 2026 09:37:49 +0000
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.34.181.151])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyaR-0000000BQ7E-0syz;
	Thu, 19 Nov 2026 09:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795081067; x=1826617067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yaApC6dU0pHd7sFvEPl37gN234fN9yV/70NJmvLF6ok=;
  b=mA109mmF6+ajFVWL/KcRHicF/1NAnyf6Tl+4ztoRHtlhdMvHx0eIFweV
   tUoYS6Ezc6ejjBVEOJf/x8h/2Rre1Ii8VpzN6+f7EfDJZAx/XAzHmxT7/
   R9XgwxT77OKW+99AdxS+cyAa54sgoi49fq7aDMuBqhNjdq1bDSBj9QHjD
   NVpjsJJmW8/4l9WQe0bOtDdibpGA9pLRoJ8Q1VsEaFZ4GDc82EbBM1ulp
   r/yLj0V7k6bVXrkS6p3oPVUWLKM0zXImNSnYnmINE/+4TSm1ixuIqO1yT
   fp6tf4SJOzsQ+a0ceK/BIG0UNYt+jWVcCgNsUFQ/AQRxAOaw5hO4pd5qr
   Q==;
X-CSE-ConnectionGUID: RH7wZ7VMRcy0znrKcHYrng==
X-CSE-MsgGUID: aa+x/8ecRHSu5AC0qhKt2w==
X-IronPort-AV: E=Sophos;i="6.27,220,1787011200"; 
   d="scan'208";a="34545652"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:37:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:29560]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id ee6cc373-cb5d-4335-a538-01e126e61e5d; Thu, 19 Nov 2026 09:37:41 +0000 (UTC)
X-Farcaster-Flow-ID: ee6cc373-cb5d-4335-a538-01e126e61e5d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 19 Nov 2026 09:37:41 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Thu, 19 Nov 2026
 09:37:39 +0000
From: Federico Parola <fparola@amazon.de>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Zhen Lei
	<thunder.leizhen@huawei.com>, <kexec@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <nh-open-source@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] crash: Fix crash memory reserve dead loop when low and high limits match
Date: Thu, 19 Nov 2026 09:37:27 +0000
Message-ID: <20261119093730.49471-1-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_013747_329250_E219EA50 
X-CRM114-Status: GOOD (  10.88  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On arm64 with neither CONFIG_ZONE_DMA nor CONFIG_ZONE_DMA32,
arm64_dma_phys_limit is PHYS_MASK + 1, so CRASH_ADDR_LOW_MAX equals
CRASH_ADDR_HIGH_MAX. If the first crashkernel=size[KMG] attempt fails,
reserve_crashkernel_generic() falls back to [CRASH_ADDR_LOW_MAX,
CRASH_ADDR_HIGH_MAX), which is empty. That attempt fails too, and since
search_end still equals CRASH_ADDR_LOW_MAX the fallback is taken again,
forever. Boot stalls after the "Initmem setup" messages.

The first attempt can fail on a kexec handover (KHO) boot, where early
allocations are confined to the KHO scratch areas.

Commit edb907a61333 ("crash: fix riscv64 crash memory reserve dead
loop") fixed the same loop for crashkernel=size[KMG],high. Skip the
fallback to high memory when there is none, so the reservation fails
with "cannot allocate crashkernel" and boot continues.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
CC: stable@vger.kernel.org
Signed-off-by: Federico Parola <fparola@amazon.de>
---
 kernel/crash_reserve.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index eee37a11380ce..1417b429b45c6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -421,9 +421,11 @@ void __init reserve_crashkernel_generic(unsigned long long crash_size,
 		/*
 		 * For crashkernel=size[KMG], if the first attempt was for
 		 * low memory, fall back to high memory, the minimum required
-		 * low memory will be reserved later.
+		 * low memory will be reserved later. There is no high memory to
+		 * fall back to if CRASH_ADDR_LOW_MAX equals CRASH_ADDR_HIGH_MAX.
 		 */
-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-- 
2.47.3



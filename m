Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9C606A334
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E2FRAs2q;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=amAS0UaD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Unsubscribe-Post:
	List-Owner; bh=gQ+mCMdhYRYeDcO02x4fd2TOgmX36Kcmpge/k55qYjc=; b=E2FRAs2qaJe6nV
	Jv2bF96ppYCFKQslc8HxWBYzMhYyHB9IDCnusdTMMs9EUQr2MjW9UiQCTyXwGS6egX+wtc/+E1Cyq
	O2Jpg6vTOizpH3qkeNDxVWKSJ7c4Npr55SY1OafN8u+9ap6chgiPL/wgufDSEQU7uhGMb9xrI86WC
	8VT1MXmmiFElodcmumrN7eAFrHnSf7rV4ymISJfycH+enAYODM6Uf9Kq+9DtYNyPNYHZNFUKk7p62
	xuh/ZEBEv7cSRdDH6aTE9qFNuudbrJUMxxAMRBGo6Cty6XSKvrMS5RpYjjEEaezeZtiBmHdFZ3j75
	uvShNqbXKo4p8aQcuCNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU4fu-0000000CaHw-1vIk;
	Thu, 19 Nov 2026 16:07:50 +0000
Received: from out-17.mta0.migadu.com ([2001:41d0:1004:224b::11] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU4fr-0000000CaFm-28c3
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 16:07:49 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=RzSpnRl3L+3BYvT2DeQY1NjutcLyvlWogEngFMMuX0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795104464; v=1; x=1795709264;
 b=amAS0UaDWguLQaCZLF6MFiRpHfwwVyefLk9UQQjcWrN2/3q/MHLLQ2+AauJeSfMQqMuwdsmO
 AvoI15AxGj/7NCtFmkkNKcoyE1SFYPGG/WV5YrpGsosUOTbYYm3XXf2hhfriqjDYUzHAV5Wk+aX
 jHQFJSC9B2/lOokGLE/AMaC8=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 8aebfe3fc16492fa;
	Thu, 19 Nov 2026 16:07:44 +0000
X-Mizu-Trace-ID: 8aebfe3fc16492fa
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 16:07:41 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: fparola@amazon.de
CC: akpm@linux-foundation.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
 baoquan.he@linux.dev, kexec@lists.infradead.org,
 linux-riscv@lists.infradead.org, nh-open-source@amazon.com,
 palmer@dabbelt.com, pasha.tatashin@soleen.com, pjw@kernel.org,
 pratyush@kernel.org, rppt@kernel.org, stable@vger.kernel.org,
 thunder.leizhen@huawei.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_crash=3A_Fix_crash_memory_reserv?=
 =?US-ASCII?Q?e_dead_loop_when_low_and_high_limits_match?=
In-Reply-To: <20261119093730.49471-1-fparola@amazon.de>
Message-ID: <CAEBC780-5EA0-425E-84DA-F16817BE884C@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_080747_752548_2E44DD5B 
X-CRM114-Status: UNSURE (   8.22  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19 November 2026 09:37:27 GMT, Federico Parola <fparola@amazon.de>
wrote:
>On arm64 with neither CONFIG_ZONE_DMA nor CONFIG_ZONE_DMA32,
>arm64_dma_phys_limit is PHYS_MASK + 1, so CRASH_ADDR_LOW_MAX equals
>CRASH_ADDR_HIGH_MAX. If the first crashkernel=size[KMG] attempt fails,
>reserve_crashkernel_generic() falls back to [CRASH_ADDR_LOW_MAX,
>CRASH_ADDR_HIGH_MAX), which is empty. That attempt fails too, and since
>search_end still equals CRASH_ADDR_LOW_MAX the fallback is taken again,
>forever. Boot stalls after the "Initmem setup" messages.
>
>The first attempt can fail on a kexec handover (KHO) boot, where early
>allocations are confined to the KHO scratch areas.
>
>Commit edb907a61333 ("crash: fix riscv64 crash memory reserve dead
>loop") fixed the same loop for crashkernel=size[KMG],high. Skip the
>fallback to high memory when there is none, so the reservation fails
>with "cannot allocate crashkernel" and boot continues.
>
>Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
>CC: stable@vger.kernel.org

Oki.

>Signed-off-by: Federico Parola <fparola@amazon.de>
>---
> kernel/crash_reserve.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>index eee37a11380ce..1417b429b45c6 100644
>--- a/kernel/crash_reserve.c
>+++ b/kernel/crash_reserve.c
>@@ -421,9 +421,11 @@ void __init reserve_crashkernel_generic(unsigned long long crash_size,
> 		/*
> 		 * For crashkernel=size[KMG], if the first attempt was for
> 		 * low memory, fall back to high memory, the minimum required
>-		 * low memory will be reserved later.
>+		 * low memory will be reserved later. There is no high memory to
>+		 * fall back to if CRASH_ADDR_LOW_MAX equals CRASH_ADDR_HIGH_MAX.
> 		 */
>-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
>+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
>+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


> 			search_end = CRASH_ADDR_HIGH_MAX;
> 			search_base = CRASH_ADDR_LOW_MAX;
> 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>

--- Thanks!


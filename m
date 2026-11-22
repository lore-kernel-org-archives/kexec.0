Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E82606A330
	for <kexec@archiver.kernel.org>; Sun, 22 Nov 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cs6+IZA2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghF7CWUM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KzrVEQ03EK5eu+7tSDtmCyEtJgI25e3+3defglUPBK0=; b=cs6+IZA20HZYoVlLFDupZVi9ZG
	TqWzTuuNwzpZYJPwvbgb1QG8Vb8ezZhOAJXRtSZ4daPAv7UOxht0oTXF3qM+3yqrYKH5gwKv5pnpg
	aOjZjh7qRoMnkBKfigZROP4w8CHv62/Rs/G4sKFN7ZIZYVbJF2s9rIP6vFO+YlpstiSMJqDL+50up
	F0vAcvr3NDx3LIsHcsk0z6jF5WyNrIs+/NofXznj5bSB+NUWxSS1I+wljqfu2GUP5bDuhA+7SEif2
	qJpIilU5YtlXTwJr7tFx/dVI11ADqNaeYgB2RNaxx71Z137n5oSPRUtGD8HjLOdd5Grz9KSZiSAbj
	KC+prrmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVASP-00000001MON-2eQi;
	Sun, 22 Nov 2026 16:30:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVASN-00000001MNz-2j6q;
	Sun, 22 Nov 2026 16:30:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0821341709;
	Sun, 22 Nov 2026 16:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7601F000C6;
	Sun, 22 Nov 2026 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795365022;
	bh=KzrVEQ03EK5eu+7tSDtmCyEtJgI25e3+3defglUPBK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ghF7CWUMVugPxg90sHHKYEuZ3yfSWM233Kz7XPmsYFNoH8ePGcEbFvq+3tjJvwARM
	 C31VtR89lcPiYAdWjzKHdq0uDAHG0vykVegt4OhFNQAnrE9uc50dm2/ucEFtc5H307
	 z9ipHD7izlqUI7oLV3OzY3TPmA/V3FAinMcG70EnZV5PW+Nz27ECsoIn64+Qm3lyw9
	 amEOLkCTcLr+6CNiqBmmK1pi+RiViiPRpGmeCK4JtyQb1BwsjhkhXR9GQzDryKfCTA
	 74r2U3LJpqelptWe/c0EjDwCDfzMsxk2zPAFgvuXvS4X18hw1f6OC+2XCKwWbk4SkB
	 aiusnbaFYdUvg==
Date: Sun, 22 Nov 2026 18:30:15 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: fparola@amazon.de, akpm@linux-foundation.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, baoquan.he@linux.dev,
	kexec@lists.infradead.org, linux-riscv@lists.infradead.org,
	nh-open-source@amazon.com, palmer@dabbelt.com,
	pasha.tatashin@soleen.com, pjw@kernel.org, pratyush@kernel.org,
	stable@vger.kernel.org, thunder.leizhen@huawei.com
Subject: Re: [PATCH] crash: Fix crash memory reserve dead loop when low and
 high limits match
Message-ID: <awMYl7QyfPtbM-PC@kernel.org>
References: <20261119093730.49471-1-fparola@amazon.de>
 <CAEBC780-5EA0-425E-84DA-F16817BE884C@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEBC780-5EA0-425E-84DA-F16817BE884C@linux.dev>
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

Hi,

On Thu, Nov 19, 2026 at 04:07:41PM +0000, Bradley Morgan wrote:
> On 19 November 2026 09:37:27 GMT, Federico Parola <fparola@amazon.de>
> wrote:
> >On arm64 with neither CONFIG_ZONE_DMA nor CONFIG_ZONE_DMA32,
> >arm64_dma_phys_limit is PHYS_MASK + 1, so CRASH_ADDR_LOW_MAX equals
> >CRASH_ADDR_HIGH_MAX. If the first crashkernel=size[KMG] attempt fails,
> >reserve_crashkernel_generic() falls back to [CRASH_ADDR_LOW_MAX,
> >CRASH_ADDR_HIGH_MAX), which is empty. That attempt fails too, and since
> >search_end still equals CRASH_ADDR_LOW_MAX the fallback is taken again,
> >forever. Boot stalls after the "Initmem setup" messages.

This is really hard to read :/

> >
> >The first attempt can fail on a kexec handover (KHO) boot, where early
> >allocations are confined to the KHO scratch areas.
> >
> >Commit edb907a61333 ("crash: fix riscv64 crash memory reserve dead
> >loop") fixed the same loop for crashkernel=size[KMG],high. Skip the

How is this related?

> >fallback to high memory when there is none, so the reservation fails
> >with "cannot allocate crashkernel" and boot continues.
> >
> >Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
> >CC: stable@vger.kernel.org

Do you see this in field or it's what some sort of analysis shows?
 
> Oki.
> 
> >Signed-off-by: Federico Parola <fparola@amazon.de>
> >---
> > kernel/crash_reserve.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> >index eee37a11380ce..1417b429b45c6 100644
> >--- a/kernel/crash_reserve.c
> >+++ b/kernel/crash_reserve.c
> >@@ -421,9 +421,11 @@ void __init reserve_crashkernel_generic(unsigned long long crash_size,
> > 		/*
> > 		 * For crashkernel=size[KMG], if the first attempt was for
> > 		 * low memory, fall back to high memory, the minimum required
> >-		 * low memory will be reserved later.
> >+		 * low memory will be reserved later. There is no high memory to
> >+		 * fall back to if CRASH_ADDR_LOW_MAX equals CRASH_ADDR_HIGH_MAX.
> > 		 */
> >-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
> >+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
> >+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {
> 
> Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>
> 
> 
> > 			search_end = CRASH_ADDR_HIGH_MAX;
> > 			search_base = CRASH_ADDR_LOW_MAX;
> > 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >
> 
> --- Thanks!

-- 
Sincerely yours,
Mike.


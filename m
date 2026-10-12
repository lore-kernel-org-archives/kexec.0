Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E217CA9ED1
	for <kexec@archiver.kernel.org>; Mon, 12 Oct 2026 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQsn0vmJ9Enc8KpOevs5GF67ZaQJBMeRFwUmu6G9Q+U=; b=RSCoRwxqQxT5GllXrkiJjZnE85
	+dPG1ZTwZHn4cvwL7R1gVFif4HgqzD7IJN5ZphIN+EgzxwleiY1djkc0MCyvVxqj779/1/bo0lAWQ
	1YUEF13CPZ6AUeTjeQ8r3iDuKVTL6x/PSUwULnhj0Idqed1Wdgy8c/msycJQCR9Hv80NiJFexeDUa
	HCvqoXWpQMqesSVRPs8oqEM4tpMtmg2KrjrMLVYPuCx3rztiS8FzhoiKbJC0qbHxyz7YeKH+4Aksl
	f0s9YL96cR1RzOCy8tjZcXxOwa36hE00ENMNJHXFuiPy8QLFDGN7vudeX0HNPudjT+cRrfTnrOeke
	SMBzHEaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGHFX-0000000AiKb-16C8;
	Mon, 12 Oct 2026 14:43:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGHFU-0000000AiKC-0kS3
	for kexec@lists.infradead.org;
	Mon, 12 Oct 2026 14:43:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 57858601FB;
	Mon, 12 Oct 2026 14:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F02D1F0089B;
	Mon, 12 Oct 2026 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816211;
	bh=kQsn0vmJ9Enc8KpOevs5GF67ZaQJBMeRFwUmu6G9Q+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IM1g2mg+0ZjCqewi5D/5jQ6yvlDnaIY7CfHe3fekAL1P7K2B1Pdazo6RlILpbXA/m
	 OKWqYFRZbakcWW8wvl/IGx3jKOfhx6gG9grJCMyYTTPOO54lwG11SzZLFmYUzoHepz
	 Bifnke+sfu3+fO6tag2ROronuIV/kBdId1F4OR+RJKfkp1MNdS/0oTCG5yW7dFPBz3
	 8Pf5fLzzyjx313sPM1FT9MsaEQoe6yqsWVffDnKvbjyTeb1r8C7W54xPayKybSWynm
	 Go1/udLGAdEhxwHvF3Aq2Z7HlKWiDk2AsjEAtagV7WI5uVTJoAmPH0KF7nRtxv5YPs
	 FLSSDzFuIMwJQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: sashiko-bot@kernel.org
Cc: "Sourabh Jain" <sourabhjain@linux.ibm.com>,
  sashiko-reviews@lists.linux.dev,  "Hari Bathini"
 <hbathini@linux.ibm.com>,  kexec@lists.infradead.org,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Michael Ellerman" <mpe@ellerman.id.au>,
  linux-kernel@vger.kernel.org,  "Alexander Graf" <graf@amazon.com>,
  linuxppc-dev@lists.ozlabs.org,  "Madhavan Srinivasan"
 <maddy@linux.ibm.com>,  "Mahesh Salgaonkar" <mahesh@linux.ibm.com>,
  "Shivang Upadhyay" <shivangu@linux.ibm.com>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  "Baoquan He" <baoquan.he@linux.dev>,
  "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,  "Shrikanth Hegde"
 <sshegde@linux.ibm.com>,  "Aditya Gupta" <adityag@linux.ibm.com>,  "Mike
 Rapoport" <rppt@kernel.org>,  "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  "Pasha Tatashin" <pasha.tatashin@soleen.com>,
  "Nicholas Piggin" <npiggin@gmail.com>
Subject: Re: [PATCH v1 2/2] powerpc: add support for Kexec HandOver (KHO)
In-Reply-To: <20260928084310.10CDB1F00893@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Mon, 28 Sep 2026 08:43:09 +0000")
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
	<20260928083226.107807-3-sourabhjain@linux.ibm.com>
	<20260928084310.10CDB1F00893@smtp.kernel.org>
Date: Mon, 12 Oct 2026 16:43:26 +0200
Message-ID: <2vxzbj8zj7xt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Sep 28 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] boot: late KHO initialization allows memblock to clobber preserved memory
> --
>
> commit 2f581dec390379323e7a0b4e4badb03487eea55f
> Author: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> powerpc: add support for Kexec HandOver (KHO)
>
> Add architecture bits to enable CONFIG_KEXEC_HANDOVER on powerpc. This
> patch checks for KHO information in the device tree before unflattening it,
> allowing a kernel booted via KHO kexec to recover the FDT and scratch region.
> It also moves early_init_dt_check_kho() to be called from setup_arch().
>
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 4afaba19b5867..53c2f1897bfe1 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -923,6 +923,8 @@ void __init setup_arch(char **cmdline_p)
>>  	/* Set a half-reasonable default so udelay does something sensible */
>>  	loops_per_jiffy = 500000000 / HZ;
>>  
>> +	early_init_dt_check_kho();
>> +
>>  	/* Unflatten the device-tree passed by prom_init or kexec */
>>  	unflatten_device_tree();
>
> [Severity: High]
> Does calling early_init_dt_check_kho() in setup_arch() happen too late to
> protect against early memblock allocations clobbering preserved KHO memory?
>
> The Kexec HandOver (KHO) mechanism uses a scratch memory region to strictly
> confine early boot memory allocations in the successor kernel. This prevents
> them from overwriting memory pages preserved by the previous kernel, and is
> enforced when kho_populate() invokes memblock_set_kho_scratch_only().
>
> However, setup_arch() is invoked from start_kernel() long after early_setup()
> completes. During early_setup(), substantial dynamic memblock allocations occur
> before KHO scratch memory confinement is enforced.
>
> For example, move_device_tree() allocates memory for the FDT:
>
> arch/powerpc/kernel/prom.c:move_device_tree() {
> 	...
> 	p = memblock_alloc_raw(size, PAGE_SIZE);
> 	...
> }
>
> This is called via early_init_devtree() from early_setup():
>
> arch/powerpc/kernel/setup_64.c:early_setup() {
> 	...
> 	early_init_devtree(__va(dt_ptr));
>
> 	allocate_paca_ptrs();
> 	allocate_paca(boot_cpuid);
> 	... 
> 	early_init_mmu();
> 	...
> }
>
> Because KHO scratch-only mode has not yet been enforced during these early
> allocations, could they use standard memblock policies and overwrite preserved
> KHO memory state, corrupting the handover?

Sashiko seems to have a point. early_init_devtree() (called from
early_setup()) already does a lot of initialization that x86's
setup_arch() does, including making memblock allocations, allowing
resize, etc.

So perhaps you need to move this early_init_dt_check_kho() call to
early_setup()?

-- 
Regards,
Pratyush Yadav


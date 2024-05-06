Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15592C10F16
	for <kexec@archiver.kernel.org>; Mon,  6 May 2024 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BVRscitY3UJ7pSYn8zkeM8JKCyChFZVGFX5XliUXBAA=; b=ZCrlEQmMYaD5qS
	NX6IQ03KWffeMVeW19P1Kx2YFPjq0XMV4GNSA23Pd0e66j5uRvgtyw0U0NzRazChRImOc+9kOpLVA
	7dxueSjpSAdeJ4dHozGwGQ+UIVXxMUv5fGNaobFNtsho6rQgSG23WJBe4V5ss3WZAnRPZPgWQgVHL
	NzUtQs8kSfX0Cul3S2KzdIQgWbfBIuUMS0voXS4XpVB172JxZpQnz/TRALbmLGCWpJ6VJXbwKi21O
	6dULXubohnn4pDIzNaDKXk6SrmM1T7in9OYj775uclRrEEqGVvuu45co9VC/Ps6CDpuwzkDaZPTcz
	ptCSbRCB/4/OCbCYRmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s40PE-00000007t5e-118F;
	Mon, 06 May 2024 15:37:32 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s40PA-00000007t3z-0o7K
	for kexec@lists.infradead.org;
	Mon, 06 May 2024 15:37:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715009848; x=1746545848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u4Wbi+kWAVVOkhZHAsKkhw70PBDqYs/mFsVXLQcsk3I=;
  b=FOD7FFf/QHr5e41Z6dmc0NXRDDdqPmwJnGDw01prWct3sEaOJdL0sQie
   B1uhDroQLJiRKRgHfaRdAzAoEuRUnGhz+lXeMdReU9PGcWUllqQadglQf
   oJTZtTVODclS7phb5mW+DdNkaJhVruyuEpg53cfwMMDzPYtmu1mhSoUHK
   UPAaCmHnShtJajKMbhm6zPsMkTWFgMLvmhzu2D+vGfGcK+ApT0jR1/av2
   P5CXzL35N8HPEyBKWENm3VnUoUvwEIdLunuh1KH7BUyL3BM8UQpDtd0i6
   RJ2Jy6hKIhRZw1sP2ZsXKuvMEGORjr7ZqV8j50dES4QJ4K2LSE7L8/ejG
   A==;
X-CSE-ConnectionGUID: byJWZWsBSnWHJh1S0mU9/Q==
X-CSE-MsgGUID: 0/Oq3W+nS1K6iiEws0WHiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10608294"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10608294"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 08:37:26 -0700
X-CSE-ConnectionGUID: 3HZKYHL6T1iq+bktUHzxsg==
X-CSE-MsgGUID: Qu6O7tEHQ1+L0dn0IGA/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="59384212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 06 May 2024 08:37:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9D7D9161; Mon, 06 May 2024 18:37:19 +0300 (EEST)
Date: Mon, 6 May 2024 18:37:19 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 10/18] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <bpmagk7v6swftzjjpchplzjwgx3pbdqzklcxybrmrhprqizk45@lxmvva42z36g>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-11-kirill.shutemov@linux.intel.com>
 <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_083728_332307_9A09A4AA 
X-CRM114-Status: GOOD (  35.52  )
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

On Sun, May 05, 2024 at 02:13:19PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:30:02PM +0300, Kirill A. Shutemov wrote:
> > TDX guests allocate shared buffers to perform I/O. It is done by
> > allocating pages normally from the buddy allocator and converting them
> > to shared with set_memory_decrypted().
> > 
> > The second kernel has no idea what memory is converted this way. It only
> 
> "The kexec-ed kernel..."
> 
> is more precise.

"second kernel" is nomenclature kexec folks are using, but okay.


> > @@ -831,6 +833,73 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> >  	return 0;
> >  }
> >  
> > +/* Stop new private<->shared conversions */
> > +static void tdx_kexec_stop_conversion(bool crash)
> > +{
> > +	/*
> > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > +	 * conversions to finish.
> > +	 *
> > +	 * If race happened, just report and proceed.
> > +	 */
> > +	bool wait_for_lock = !crash;
> 
> You don't need that bool - use crash.

Dave suggested the variable for documentation purposes.

https://lore.kernel.org/all/0b70ee1e-4bb5-4867-9378-f5723ca091d5@intel.com

I'm fine either way.

> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte)) {
> > +			int pages = size / PAGE_SIZE;
> > +
> > +			/*
> > +			 * Touching memory with shared bit set triggers implicit
> > +			 * conversion to shared.
> > +			 *
> > +			 * Make sure nobody touches the shared range from
> > +			 * now on.
> > +			 */
> 
> lockdep_assert_irqs_disabled() ?

Yep.

> > +			set_pte(pte, __pte(0));
> > +
> > +			if (!tdx_enc_status_changed(addr, pages, true)) {
> > +				pr_err("Failed to unshare range %#lx-%#lx\n",
> > +				       addr, addr + size);
> 
> Why are we printing something here if we're not really acting up on it?
> 
> Who should care here?

The only thing we can do at this point on failure is panic. It think
it is reasonable to proceed, especially for crash case.

The print leaves a trace in the log to give a clue for debug.

One possible reason for the failure is if kdump raced with memory
conversion. In this case shared bit in page table got set (or not cleared
form shared->private conversion), but the page is actually private. So this
failure is not going to affect the kexec'ed kernel.

> > +static DECLARE_RWSEM(mem_enc_lock);
> > +
> > +/*
> > + * Stop new private<->shared conversions.
> > + *
> > + * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
> > + * The lock is not released to prevent new conversions from being started.
> > + *
> > + * If sleep is not allowed, as in a crash scenario, try to take the lock.
> > + * Failure indicates that there is a race with the conversion.
> > + */
> > +bool stop_memory_enc_conversion(bool wait)
> 
> This is a global function which means, it should be called:
> 
> set_memory_enc_stop_conversion()
> 
> or so. With the proper prefix and so on.

Sure.

> > +{
> > +	if (!wait)
> > +		return down_write_trylock(&mem_enc_lock);
> > +
> > +	down_write(&mem_enc_lock);
> > +
> > +	return true;
> > +}
> > +
> >  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >  {
> > -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> > -		return __set_memory_enc_pgtable(addr, numpages, enc);
> > +	int ret = 0;
> >  
> > -	return 0;
> > +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > +		if (!down_read_trylock(&mem_enc_lock))
> > +			return -EBUSY;
> 
> This function is called on SEV* and HyperV and the respective folks need
> to at least ack this new approach.
> 
> I see Ashish's patch adds the respective stuff:
> 
> https://lore.kernel.org/r/c24516a4636a36d57186ea90ae26495b3c1cfb8b.1714148366.git.ashish.kalra@amd.com
> 
> which leaves HyperV. You'd need to Cc them on the next submission.

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

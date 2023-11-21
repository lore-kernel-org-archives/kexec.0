Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B392C5ACB3
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 09:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ik9mVzMwkzJ7GN1JO07Bmm5n6ENbo7M3J0owZHO7Rws=; b=gzCTWdcu59JYsp
	Cc5sm3H52EaxB2Vw8KgRzsDY2xbY3X+HJhzGiHBRx0RPs0lbcLzu+PA9iy4dz2AWH6LyehZtmjTrC
	5VoWkFXTtejREWPq+FY1AhHsHlEIDDRh3nJ20AKFd48/7limYDTjFKHWWDiVCVeEYgYr/rxNFj46R
	LYZZnW5XAlctpfK8IhDl3nQ3s1iwffqF3HMGhmQrrGQyLHLwFRxlVT+tunuH7ownwf1jv1jCs2wY+
	3ZY5qcoAA4IU5scqQV11smdiy8X50eZXmSZa7+oLaLxVegqIIw561laErKQpA12BipYO32iZy+WX8
	iwew9lwS47iLqG6kId3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5NH9-00GACK-1R;
	Tue, 21 Nov 2023 09:42:35 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5NH6-00GAAk-2d
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 09:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700559752; x=1732095752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKDb5RgVL1eT3zD06y02XsLI88vWKvuYieg0wRPL9PM=;
  b=ZiIV1VJGhEydTHkh9uelnfJrygQHwgUwqg6g4K04537BdQxJPZTMXfyt
   gzAHN5vjCH8Y/Af6rfcZS0qhyYPb3nMRlYHZHLnAng3xUO92GQ1CAaBzi
   1174uKn2OuVcSwfvhnJNKl8rYVLACCGi9J0JG4eGkwTkf12h+RFar2qVq
   6zlMHJIOHqE+zQIKJnALASf1SBuRx6nzxafVkpXRtO14ztrykyaGJno12
   r0HHBo+EKIz4edXJAfsh40yIJlFl9vxi971UnSyhAZW8e5SzOWchXrnkX
   ZNvjdhtz+CaKZWrWv/igUbDbi7BE/IndK8uz9Iotz18EnndGrRpel+h/K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376839382"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376839382"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766584619"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766584619"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:42:22 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 0860910A36E; Tue, 21 Nov 2023 12:42:20 +0300 (+03)
Date: Tue, 21 Nov 2023 12:42:19 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 09/14] x86/tdx: Account shared memory
Message-ID: <20231121094219.x5ez6ohzc773viul@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-10-kirill.shutemov@linux.intel.com>
 <07e7619d098ba3579f642a97b644f256884ed0a2.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <07e7619d098ba3579f642a97b644f256884ed0a2.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_014232_906716_2FB27D29 
X-CRM114-Status: GOOD (  25.75  )
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

On Tue, Nov 21, 2023 at 02:47:29AM +0000, Huang, Kai wrote:
> 
> > +static atomic_long_t nr_shared;
> > +
> > +static inline bool pte_decrypted(pte_t pte)
> > +{
> > +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> > +}
> > +
> >  /* Called from __tdx_hypercall() for unrecoverable failure */
> >  noinstr void __noreturn __tdx_hypercall_failed(void)
> >  {
> > @@ -820,6 +828,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> >  	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> >  		return -EIO;
> >  
> > +	if (enc)
> > +		atomic_long_sub(numpages, &nr_shared);
> > +	else
> > +		atomic_long_add(numpages, &nr_shared);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -895,3 +908,59 @@ void __init tdx_early_init(void)
> >  
> >  	pr_info("Guest detected\n");
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static int tdx_shared_memory_show(struct seq_file *m, void *p)
> > +{
> > +	unsigned long addr, end;
> > +	unsigned long found = 0;
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
> > +		if (pte && pte_decrypted(*pte))
> > +			found += size / PAGE_SIZE;
> > +
> > +		addr += size;
> > +
> > +		cond_resched();
> > +	}
> > +
> > +	seq_printf(m, "Number of unshared pages in kernel page tables:  %16lu\n",
> > +		   found);
> > +	seq_printf(m, "Number of pages accounted as unshared:           %16ld\n",
> > +		   atomic_long_read(&nr_shared));
> 
> unshared -> shared?

Right.

> Btw, I am not quite sure what's the purpose of reporting number of shared pages
> in both kernel page table and that the kernel is accounting?
> 
> IIUC, there might be slight chance that the former is different from the latter
> (i.e., when user reads this while the kernel is converting pages
> simultaneously), but in most of the time the user should see they are the same.
> 
> I can see it might be helpful to report @nr_shared to the user, but how can
> reporting both help the user?

It is critical to unshared *all* pages on kexec or the second kernel will
crash at some point on accessing shared page as private.

This is the sanity check: if number of shared pages in page tables is less
than what we expected, we've lost shared bit somewhere. And kexec will
likely be a disaster.

Ability to trigger the check a any point can help to correlate the leak
with activity.

> That being said, I think perhaps you can separate the /sysfs part as a separate
> patch because it's not a mandatory part of this series but a nice to have.  Then
> the /sysfs part can be reviewed separately. 

Okay, makes sense.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97543C54798
	for <kexec@archiver.kernel.org>; Sun, 25 Feb 2024 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9nQOTiRW4sGrFQl8aBs3ZBeSQDxVio01s7ctUBTcXG8=; b=jhU3dJ10SUY98u
	5pbbCJV57pm/tOPXroDVQPLSMfMCWdi/jdwHb5XaM75NflUeaKzy2OFQTrEuliapvgmsh8tpseafD
	Qq3ZYrRP1Ha5jqfC0R/coaExPbmdp7xl3tF8h2HWfUeVfvunfAXJT5hRw2jH+hfNb79pqn5MkjaHs
	7BD5dNIKlKXj3CehBt6b44YHVwg7b8IXFEGGjOTNgJhu3g9whlG9BsUS/rledAFe8gLB70qx0YB90
	HJUFF3jH8GI78VaWoupELF3QZNb4oIvh0yACTMxOwPLB850FkoUXZVZCQ3Jg9mb2JeVxCFkxSigKs
	4mNNHuGx6gFRb2BsJilw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reGq2-0000000FE9n-1gD2;
	Sun, 25 Feb 2024 15:54:50 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reGpz-0000000FE94-0OIY
	for kexec@lists.infradead.org;
	Sun, 25 Feb 2024 15:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708876487; x=1740412487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a8WuHvI6h6kLGhcZUjOjqEaaYOLzg47IYOWKmjJs8cw=;
  b=Dq7NJsUyWsV/GIeKrzL2cOgJW1YlTHwcYEr9k6lPUjkqrd+9FnGdhzb8
   3YvlCiuOFt9A0xTccPk3sIi3cYMCBSYqy47yo+XYbikM++clwRsdCNahw
   aovatp73lWOGq4UVZHnLuAJE4RclGR5xFbKah/z60zDcB/eJKa9Djt1QS
   ozrGU/xLG06r6IT3AwXeVA9ncEkStfXBehwhhWAQGOoMU1+hk7tJPDsWX
   I9QEzpaj5QFni47k8vLEULp5PqzsX+OPu3Opc70pokS2WVgfqRRcp+6ME
   LehN1s6OYCXaSwpWXpa4bMMYKQjw1tS/b/I7MNmwcinZdzvTOXOkqTqnh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3296456"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3296456"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 07:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937028120"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937028120"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2024 07:54:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B60FB425; Sun, 25 Feb 2024 17:54:36 +0200 (EET)
Date: Sun, 25 Feb 2024 17:54:36 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 08/16] x86/tdx: Account shared memory
Message-ID: <z6dsqhxzj4beyv4vj5uq6khpt6ti4mvs3uxunvli5cvi2hgfmv@rqbyr4wlzb6f>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-9-kirill.shutemov@linux.intel.com>
 <a69a3d67-7352-4bf4-8766-a55ce97e46bd@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a69a3d67-7352-4bf4-8766-a55ce97e46bd@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_075447_188393_AA6B2431 
X-CRM114-Status: GOOD (  35.75  )
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

On Fri, Feb 23, 2024 at 11:08:18AM -0800, Dave Hansen wrote:
> On 2/12/24 02:44, Kirill A. Shutemov wrote:
> > The kernel will convert all shared memory back to private during kexec.
> > The direct mapping page tables will provide information on which memory
> > is shared.
> > 
> > It is extremely important to convert all shared memory. If a page is
> > missed, it will cause the second kernel to crash when it accesses it.
> > 
> > Keep track of the number of shared pages. This will allow for
> > cross-checking against the shared information in the direct mapping and
> > reporting if the shared bit is lost.
> > 
> > Include a debugfs interface that allows for the check to be performed at
> > any point.
> 
> When I read this, I thought you were going to do some automatic
> checking.  Could you make it more clear here that it's 100% up to the
> user to figure out if the numbers in debugfs match and whether there's a
> problem?  This would also be a great place to mention that the whole
> thing is racy.

What about this:

  Include a debugfs interface to dump the number of shared pages in the
  direct mapping and the expected number. There is no serialization
  against memory conversion. The numbers might not match if access to the
  debugfs interface races with the conversion.

> > +static atomic_long_t nr_shared;
> > +
> > +static inline bool pte_decrypted(pte_t pte)
> > +{
> > +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> > +}
> 
> Name this pte_is_decrypted(), please.

But why? pte_decrypted() is consistent with other pte helpers pte_none(),
pte_present, pte_dirty(), ...

> >  /* Called from __tdx_hypercall() for unrecoverable failure */
> >  noinstr void __noreturn __tdx_hypercall_failed(void)
> >  {
> > @@ -821,6 +829,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
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
> > @@ -896,3 +909,59 @@ void __init tdx_early_init(void)
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
> 
> This is totally racy, right?  Nothing prevents the PTE from
> flip-flopping all over the place.

Yes.

> > +	seq_printf(m, "Number of shared pages in kernel page tables:  %16lu\n",
> > +		   found);
> > +	seq_printf(m, "Number of pages accounted as shared:           %16ld\n",
> > +		   atomic_long_read(&nr_shared));
> > +	return 0;
> > +}
> 
> Ditto with 'nr_shared'.  There's nothing to say that the page table walk
> has anything to do with 'nr_shared' by the time we get down here.
> 
> That's not _fatal_ for a debug interface, but the pitfalls need to at
> least be discussed.  Better yet would be to make sure this and the cpa
> code don't stomp on each other.

Serializing is cumbersome here. I can also just drop the interface.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

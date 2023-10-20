Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6EDCDB47E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uNSUQj8Y4Gz6p3XnoxdcBcxVeclWLwuzggty2/XDppM=; b=lLTYzQP86XpkhG
	YlRJw+MjhQBRfD1iWSTpqihIZeWmCdUPlz76QoafnNKiBIjN8Ptd+ZHZXFKQPqPqgOF8pGeV5YjG3
	Qfh+WTzv7bo4QQHxQaYqJeIeKoE3R6rBaYPjHzlVjS6OD7ABT0e+J0BhW0NUN/EtWU80IsTAuPdva
	oGxrT4lSVJD3OkyF7Z0DMuuoy9SpNuGOlO7n5PuDW35uQIkT5Wy7+kqTQIdtsUn5enXI4SPG22PH7
	M2IVmM4HZBQuptMhzUX1TFPRyWPQr/AA+8fYFL8Scqiel33XI6hhJgRpuMln+w0NHmHD5IaV4NSm9
	pXDDmdQ8sMU3C450k1FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlh7-001fPS-01;
	Fri, 20 Oct 2023 09:21:25 +0000
Received: from mgamail.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlh3-001fO6-2P
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 09:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793681; x=1729329681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a++LVpgYV0t0DpSZeHCFw0R4XO+/PCphuhcdSRisZ/4=;
  b=OZ7ChQ9BN1mITbx9N3TmEpA0t/zNk+Wrapr0EgBM6qBrTo8rKAUHnplb
   baIK+YE9n76c8K1n4cXlRye2sstz28JkR6NeaZ/ii6zRkYU7l7wzgK6IG
   2ZownFJawQlU5qIYUQlg0DP47kVb4nDJuw5gSg7GlBN6heKIho384YbAX
   0zjionmeS+ftbOueCvZQBW/hTslY2f6xpIhtLXP5ey0Qfj5TvGgZwMxuf
   jPKCs8NrSZNr8OB269ppXNO8LvfXL1bDv1xZl1uTDRfiYzR38Db8cv3E1
   jE4UM+lmXbMKR6xqQnh7/hnTaOadpz1dIAn6ADjwSSXvPXivIQR5TudWl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="365802088"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="365802088"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760990089"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="760990089"
Received: from blavena-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:21:13 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 2344E109D0A; Fri, 20 Oct 2023 12:21:11 +0300 (+03)
Date: Fri, 20 Oct 2023 12:21:11 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Message-ID: <20231020092111.ho2rmhve23kgcxbr@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
 <20231005212828.veeekxqc7rwvrbig@box>
 <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
 <20231005222839.jt2du72xogg3c5ny@box>
 <f4228262-02f9-3af5-8ef5-be109b5d3d13@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4228262-02f9-3af5-8ef5-be109b5d3d13@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_022122_150669_D4E026E4 
X-CRM114-Status: GOOD (  27.57  )
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

On Fri, Oct 06, 2023 at 02:24:11PM -0500, Kalra, Ashish wrote:
> 
> On 10/5/2023 5:28 PM, Kirill A. Shutemov wrote:
> > On Thu, Oct 05, 2023 at 05:01:23PM -0500, Kalra, Ashish wrote:
> > > On 10/5/2023 4:28 PM, Kirill A. Shutemov wrote:
> > > > On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
> > > > > > +static void unshare_all_memory(bool unmap)
> > > > > > +{
> > > > > > +	unsigned long addr, end;
> > > > > > +	long found = 0, shared;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Walk direct mapping and convert all shared memory back to private,
> > > > > > +	 */
> > > > > > +
> > > > > > +	addr = PAGE_OFFSET;
> > > > > > +	end  = PAGE_OFFSET + get_max_mapped();
> > > > > > +
> > > > > > +	while (addr < end) {
> > > > > > +		unsigned long size;
> > > > > > +		unsigned int level;
> > > > > > +		pte_t *pte;
> > > > > > +
> > > > > > +		pte = lookup_address(addr, &level);
> > > > > 
> > > > > IIRC, you were earlier walking the direct mapping using
> > > > > walk_page_range_novma(), any particular reason to use lookup_address()
> > > > > instead ?
> > > > 
> > > > walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
> > > > we run here from atomic context in case of crash.
> > > > 
> > > > I considered using trylock to bypass the limitation, but it is a hack.
> > > > 
> > > > > 
> > > > > > +		size = page_level_size(level);
> > > > > > +
> > > > > > +		if (pte && pte_decrypted(*pte)) {
> > > > > 
> > > > > Additionally need to add check for pte_none() here to handle physical memory
> > > > > holes in direct mapping.
> > > > 
> > > > lookup_address() returns NULL for none entries.
> > > > 
> > > 
> > > Looking at lookup_address_in_pgd(), at pte level it is simply returning
> > > pte_offset_kernel() and there does not seem to be a check for returning NULL
> > > if pte_none() ?
> > 
> > Hm. You are right.
> > 
> > I think it yet another quirk in how lookup_address() implemented. We need
> > to make it straight too.
> > 
> > There's two options: either make lookup_address() return pointer for entry
> > even if it is NULL, or add check for pte_none() after pte_offset_kernel()
> > and return NULL if it is true.
> > 
> > I like the first option more as it allows caller to populate the entry if
> > it wants.
> 
> Yes, i like the first option.

I tried to this, but lookup_address() has to many callers. It gets beyond
the scope of the patchset. I will add pte_none() check on unshare side for
now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

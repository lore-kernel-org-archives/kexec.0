Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB395CDB47E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=moeH1tIQGVzjPQNz1wugUe+zPy246lIvQHXBq61L4Cw=; b=L/Usy1jDsTivv9
	0rqEL7MpCExnQjUBCtxJNxBxxGA3RVI+etxZDVKlP72XNmLhDQdj2zGMnPj24GyZzf6t/Aftjvsgn
	EjWSR0mqv/BnXCEpOoTeYhMiZvhawVMPX4gRTQCieZvKM/S6vZuP4uQP/jkugYNCgwnWvyytB62iI
	1hSVvksXpk1A8OsEQZR+hYCkdjilaBirWoeNkoLORoAwyFr8JbKtUjE5Mjb4ixZ1xSIHMbkDY3VA1
	ufHTOgkYjtSS8sv5B04si0gT7Y5culiZX+Kx4EdVspkrgmp4jDoNELTzHXpR+UF7Lhp6eXKKqJBok
	fPP4eoyPuNI8KLAMPDOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlzD-001hXg-1X;
	Fri, 20 Oct 2023 09:40:07 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlzA-001hWO-0U
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 09:40:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794804; x=1729330804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZ9h/1dkx6WDuYKgtpvasjXyeVxLzD5QLg3183XfY9k=;
  b=LlNki0cMMPE2bfCk08EntwVIsWmcag8I02m9O9ZBnIBPusyZ6OzkS2kb
   ylUIawLls8ZPQcfe6xYK4iMlVlR2iMQRtvKj3P+GiJKlYf8/esGRwPFW3
   0pOCXkaRtzqMAmW93xwDbI+HNctMV+hSBmE+6lfVsQE/NUnCkScLe3t1A
   G2rXPFjeswo0ZTN9PCBFWBw1ROT3u3jC/8h0Ur+R3fKYEFVN8I4pcwBxM
   X9/8AS73q3pybAaXzlpqj/lAqqWoQf61t67R4R0vkcnDCCsnlbR9gKdKK
   2j2cXAsWxGLY9GwImrDPWUsF/ytKvSGioYLIQDWaq+itYf5SRb4Zs4oFM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472687487"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472687487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750862349"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750862349"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:39:55 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id A0949109D0A; Fri, 20 Oct 2023 12:39:52 +0300 (+03)
Date: Fri, 20 Oct 2023 12:39:52 +0300
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
Message-ID: <20231020093952.nx3a6fid2jqdumnw@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
 <20231005212828.veeekxqc7rwvrbig@box>
 <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
 <20231005222839.jt2du72xogg3c5ny@box>
 <f4228262-02f9-3af5-8ef5-be109b5d3d13@amd.com>
 <20231020092111.ho2rmhve23kgcxbr@box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231020092111.ho2rmhve23kgcxbr@box>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_024004_230174_2636033D 
X-CRM114-Status: GOOD (  28.43  )
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

On Fri, Oct 20, 2023 at 12:21:11PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 06, 2023 at 02:24:11PM -0500, Kalra, Ashish wrote:
> > 
> > On 10/5/2023 5:28 PM, Kirill A. Shutemov wrote:
> > > On Thu, Oct 05, 2023 at 05:01:23PM -0500, Kalra, Ashish wrote:
> > > > On 10/5/2023 4:28 PM, Kirill A. Shutemov wrote:
> > > > > On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
> > > > > > > +static void unshare_all_memory(bool unmap)
> > > > > > > +{
> > > > > > > +	unsigned long addr, end;
> > > > > > > +	long found = 0, shared;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Walk direct mapping and convert all shared memory back to private,
> > > > > > > +	 */
> > > > > > > +
> > > > > > > +	addr = PAGE_OFFSET;
> > > > > > > +	end  = PAGE_OFFSET + get_max_mapped();
> > > > > > > +
> > > > > > > +	while (addr < end) {
> > > > > > > +		unsigned long size;
> > > > > > > +		unsigned int level;
> > > > > > > +		pte_t *pte;
> > > > > > > +
> > > > > > > +		pte = lookup_address(addr, &level);
> > > > > > 
> > > > > > IIRC, you were earlier walking the direct mapping using
> > > > > > walk_page_range_novma(), any particular reason to use lookup_address()
> > > > > > instead ?
> > > > > 
> > > > > walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
> > > > > we run here from atomic context in case of crash.
> > > > > 
> > > > > I considered using trylock to bypass the limitation, but it is a hack.
> > > > > 
> > > > > > 
> > > > > > > +		size = page_level_size(level);
> > > > > > > +
> > > > > > > +		if (pte && pte_decrypted(*pte)) {
> > > > > > 
> > > > > > Additionally need to add check for pte_none() here to handle physical memory
> > > > > > holes in direct mapping.
> > > > > 
> > > > > lookup_address() returns NULL for none entries.
> > > > > 
> > > > 
> > > > Looking at lookup_address_in_pgd(), at pte level it is simply returning
> > > > pte_offset_kernel() and there does not seem to be a check for returning NULL
> > > > if pte_none() ?
> > > 
> > > Hm. You are right.
> > > 
> > > I think it yet another quirk in how lookup_address() implemented. We need
> > > to make it straight too.
> > > 
> > > There's two options: either make lookup_address() return pointer for entry
> > > even if it is NULL, or add check for pte_none() after pte_offset_kernel()
> > > and return NULL if it is true.
> > > 
> > > I like the first option more as it allows caller to populate the entry if
> > > it wants.
> > 
> > Yes, i like the first option.
> 
> I tried to this, but lookup_address() has to many callers. It gets beyond
> the scope of the patchset. I will add pte_none() check on unshare side for
> now.

Ah. pte_none() is not need for TDX implementation, as pte_decrypted()
check will fail for it. SEV implementation would need an additional check.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

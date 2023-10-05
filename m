Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B02E92FC6
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 21:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N6VAa+aOuj4GaR2de8NNwGO5QuENlRQZxnecZRri6MU=; b=FVRIaXaqpmPlzk
	9Bnl47ANsGyz9/u3fcs+FoGTvi8wSbH70bi6DDnOcIfuD/0rKyufazIINZ79A8TzO9Gjy9UoD87dP
	DJYp8B8yHgP8i+G+PQ84nek7yw1W9gSC2Sj696+7Fi9dSOCDGsBZEmkQajJHN9SZxyPZsdwiYwQ6J
	qacjkVievi1xd355njmpBKrS72U9+gpLAT/A+bD4L5K/Qt3VI4kNZKBp497NKWxvHQ79wNhf3h7rz
	KANWcM6sGOi6p5yufqeHPq68ASAqV6aKJ+zivL4ueBHDdCkisgPMeKbPa8ECETAvI9IIl14UJstux
	6CCV/qfcf3TrY9R/8ogw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoVti-004WTU-2n;
	Thu, 05 Oct 2023 21:28:42 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoVtg-004WSd-1m
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 21:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696541320; x=1728077320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ONU1C7tc3rc3AtZ7xkoZa57Ejqtw/z10sNPrapPUHTM=;
  b=eiBbf7Zc3stJi0937rBECvgz/mLain0wG7IpANWECk34PI/9ruQf/Sy6
   HWITDQmduu1ta08Huysu2BRVvAlFEZIszH9y1+nDW4BFVlk6XNEZBk8+K
   UsDG63kj+XIJkBYXezy96XDNhIKPM2xSlUWMchpb3c/ywBcmAyPylrF18
   Fsm77Sto28wwmPpJyXlWueRdVaxcu31y0GwsvrkBJsS56lGoerhu//kve
   5Gp0/tQvyZGhNeY+396pkMPt9HZXWLAEwie330atMDKd3yT5Cke5xFjf5
   uoOd+TURKrOkWJvy/BcAAPuPmJv1IWqOXvczUrO5NWlLZXzSTjAZvQx3F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382496485"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382496485"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875701487"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875701487"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:28:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 1D6CA10A12D; Fri,  6 Oct 2023 00:28:28 +0300 (+03)
Date: Fri, 6 Oct 2023 00:28:28 +0300
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
Message-ID: <20231005212828.veeekxqc7rwvrbig@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_142840_599102_2605455A 
X-CRM114-Status: GOOD (  19.38  )
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

On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
> > +static void unshare_all_memory(bool unmap)
> > +{
> > +	unsigned long addr, end;
> > +	long found = 0, shared;
> > +
> > +	/*
> > +	 * Walk direct mapping and convert all shared memory back to private,
> > +	 */
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
> 
> IIRC, you were earlier walking the direct mapping using
> walk_page_range_novma(), any particular reason to use lookup_address()
> instead ?

walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
we run here from atomic context in case of crash.

I considered using trylock to bypass the limitation, but it is a hack.

> 
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte)) {
> 
> Additionally need to add check for pte_none() here to handle physical memory
> holes in direct mapping.

lookup_address() returns NULL for none entries.

> > +			int pages = size / PAGE_SIZE;
> > +
> > +			/*
> > +			 * Touching memory with shared bit set triggers implicit
> > +			 * conversion to shared.
> > +			 *
> > +			 * Make sure nobody touches the shared range from
> > +			 * now on.
> > +			 *
> > +			 * Bypass unmapping for crash scenario. Unmapping
> > +			 * requires sleepable context, but in crash case kernel
> > +			 * hits the code path with interrupts disabled.
> 
> In case of SNP we will need to temporarily enable interrupts during this
> unsharing as we invoke set_memory_encrypted() which then hits a BUG_ON() in
> cpa_flush() if interrupts are disabled.

Do you really need full set_memory_encrypted()? Can't you do something
ligher?


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

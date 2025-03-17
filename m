Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101FAC282EC
	for <kexec@archiver.kernel.org>; Mon, 17 Mar 2025 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUD4UeStP/nHaOauQgFhtHc18qaLFR2neX3hG45AnXI=; b=Q4ZH2MScrxbXJUY4H71xt4jvga
	y3X5tt2qVYOHXU7FKdc6HRC4sQJzhF1lD09Gp5IDfhbEGshKn2fRaCzrdv8ORS/HkzsS+clviob7s
	xuakTlpTJF5voIYZLZYuFWVPVfP35DoQz5aH/HUrcdZTlxTu9Ay3gUw+1TAcrnpHAx0IViiYRlTj2
	uK74Ps7a45NwOLHh2gnVOErDbzBp1QMrqKch/7+JtWh93gbvbdhyz0gfzNHfN52ykZaeQyjBWcTgJ
	mOZ1G1Ym8z8uO/Dark9K5wNYj8Voofqm+kIAd3SadOuPK4AGx8rZS8exDUOw1fKHh7F42xsMiWaim
	XLQLgRnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tu989-00000002Tsn-2HMm;
	Mon, 17 Mar 2025 11:59:41 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tu986-00000002TrM-1xFc
	for kexec@lists.infradead.org;
	Mon, 17 Mar 2025 11:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742212778; x=1773748778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XFwYDEKcjNARc420Br7HZrIehcMEHv2O4FnRcaIVt6I=;
  b=EWXxeb5LEh82KrNZH/pNPgtiWaVYckEa2ct/QDy82xSFa23N1iY3Hw48
   lruEvifCpHGkGarXt9I+8Vor5PtDqbH1I/iforryU1X9e3RnLGmV/HvLC
   vqt3thB/QG5Q+fEdFU3icVQHCEwOGZaXYYnBlJlZb3b085U73lwzQ5gjv
   tor8M+dIc2r0u3J/YGb/Hv5rG4iNNAPcen9nJEaOLKnZvkrXL90VMxzGO
   HZb5jdc3inxkqg7BterFbl1dO7IwUFFWd03nmPQ2wiqftBx8lNO7y1ElK
   kaejQ6BHlUeku23rF1GUYkwW8HtetzeBp2f16o+f2OB++v57ziQBkNweQ
   g==;
X-CSE-ConnectionGUID: 0J40mf+ERHavb1zJDLR7vQ==
X-CSE-MsgGUID: NGhmwvb4R8iQi1yJ7Un2yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="46069375"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="46069375"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 04:59:33 -0700
X-CSE-ConnectionGUID: 49VgUIGlTg6X23qk61NTDA==
X-CSE-MsgGUID: FidGX7h5QvKWATo2WsUIXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122655091"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Mar 2025 04:59:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 405B41FC; Mon, 17 Mar 2025 13:59:27 +0200 (EET)
Date: Mon, 17 Mar 2025 13:59:27 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Huang, Kai" <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <mfkjehhth2pwwzcueircxl57afmip5kwqlajopnjuwunztmqvn@vx6k62dgdxkq>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
 <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
 <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>
 <uchg74rtpcpwlkxgqww2n6nh23p4ouaswqc737xy7y6rqzowtb@pbf4whogx2s4>
 <0c6cab4ea4e898a62ecb0b047959f09011d3c85f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c6cab4ea4e898a62ecb0b047959f09011d3c85f.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_045938_507481_D8F5CD4A 
X-CRM114-Status: GOOD (  15.94  )
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

On Mon, Mar 17, 2025 at 11:32:42AM +0000, David Woodhouse wrote:
> > And we don't want MCE to be enabled during kexec for !TDX_GUEST:
> > 
> > https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com/
> 
> Actually now I've added proper exception handling in relocate_kernel
> perhaps we could rethink that. But that's for the future.

There still going to be a gap once the new kernel is started until it gets
proper exception handling in place.

> > I think we should patch AND instruction to include X86_CR4_MCE on
> > TDX_GUEST:
> > ...
> > -	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
> > -	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
> > +	ALTERNATIVE __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d), \
> > +		    __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57 | X86_CR4_MCE), %r13d), X86_FEATURE_TDX_GUEST
> 
> Yeah... although the reason I'm looking at this is because I want to
> kill the ALTERNATIVE so that I can move the relocate_kernel() function
> into a data section:
> https://lore.kernel.org/all/20241218212326.44qff3i5n6cxuu5d@jpoimboe/
> 
> So I think I'll do it like this instead:

Looks good to me. Thanks for the cleanup you are doing!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


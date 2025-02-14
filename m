Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B839C021A4
	for <kexec@archiver.kernel.org>; Fri, 14 Feb 2025 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KlpflXfCy2nZxnTPZY6jXqiJAu833eQPgf2aU6JA0fI=; b=lx7DULAPeN8KhL7ejiG9szXKhB
	r/jNXAPK0lbS2LUKbFFgy6JPF3sqeAFlvO8acMfNfKTPHRH+gkxg9/yBjYYtuIqGEJ0cM02wMGfix
	ugVcvIR6xnuKdQ68wcmNUvlmGdxCIhQN+l2OpApfmgWdOfTYjgtMv2mRQ5zXcuwllIFQ6bdwWaUAU
	fOD/pbMO1OHs+cvH9nSEFaYAlzPnR8luYee9Tg9BA5jOkqMkcx3AABzaNlGYgeegbq7iXEb4k0B+J
	WKL9J0qUMULKpPJ3nMN+0fiJ7UrzViIHhAjefjAO6JFDZMSKv9h4XHHmruwYy6LmStv5MicSV3ior
	VhfzmdpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tivuH-0000000F2jz-11X0;
	Fri, 14 Feb 2025 13:39:01 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tivtE-0000000F2c1-276e
	for kexec@lists.infradead.org;
	Fri, 14 Feb 2025 13:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739540277; x=1771076277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Vn39/Rq51zcgHvhj8EEw+qofBX8yop9IUhvBSHBKF4=;
  b=KG14Efx5jPLFG7EA6oaQ/Im1emiXL6Coe6AbzBkbtqKi3aLu5BQHkt8J
   OuEhbJade5L3Sh6jZghfDatsyZKFKwt4qXWtbLI5TQilf9UtiKSVE/a4z
   0wajz6jDxQsZfP1ZH5fKfLNibKSPI/Dxo9hkSMIW4UdauUT+psqWXE2gV
   1/wH19FGCl+ykwhfjChYaV+grgNAE2EpweiYtp5jivTW18fvC27SiM/B/
   vIkZ3CVM8TgOlPKYpyK8iVKIdvO4BWSyXY+3uGT1yR0Gf0TI8QZEtZ4ht
   KtyZoNZZUVK8RnuYLYGEcsy/23AdtB1QfIv90+S71UJiOM07Af++0UZg8
   Q==;
X-CSE-ConnectionGUID: H07qa8nbQz+3SyuhlZD23Q==
X-CSE-MsgGUID: BihcsoMCRum+hgx/Y2XFqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57819771"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57819771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:37:55 -0800
X-CSE-ConnectionGUID: CFOgtk3WSHe9cthpWGjLng==
X-CSE-MsgGUID: Br3FgHXFTriCryF1gvYm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150635321"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 Feb 2025 05:37:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A0A8F32D7; Fri, 14 Feb 2025 15:37:51 +0200 (EET)
Date: Fri, 14 Feb 2025 15:37:51 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, ebiederm@xmission.com, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	x86@kernel.org, rick.p.edgecombe@intel.com, bhe@redhat.com
Subject: Re: [PATCH v2 1/1] kexec_core: Accept unaccepted kexec segments'
 destination addresses
Message-ID: <uszziotbygfz3i5u6bcpczbcu7xhqmbec4p7eqjjhlgdcgtnxj@fm7ycfwhx3bu>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <20241213095449.881-1-yan.y.zhao@intel.com>
 <69dc7277-7aa8-4091-8993-ff1195ef4c3a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69dc7277-7aa8-4091-8993-ff1195ef4c3a@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250214_053756_552711_88E58434 
X-CRM114-Status: GOOD (  18.49  )
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

On Thu, Feb 13, 2025 at 07:50:42AM -0800, Dave Hansen wrote:
> On 12/13/24 01:54, Yan Zhao wrote:
> > +	/*
> > +	 * The destination addresses are searched from system RAM rather than
> > +	 * being allocated from the buddy allocator, so they are not guaranteed
> > +	 * to be accepted by the current kernel.  Accept the destination
> > +	 * addresses before kexec swaps their content with the segments' source
> > +	 * pages to avoid accessing memory before it is accepted.
> > +	 */
> > +	for (i = 0; i < nr_segments; i++)
> > +		accept_memory(image->segment[i].mem, image->segment[i].memsz);
> 
> The "searched from system RAM" phrase both here and in the changelog
> doesn't quite parse for me.
> 
> Also "System RAM" is the normal phrase that I use to describe the memory
> that mostly ends up _going_ into the buddy allocator. It's not just me:
> 
> 	cat /proc/iomem  | grep 'System RAM'
> 
> I think a more useful comment (and changelog) might be something like this:
> 
> 	The core kernel focuses on accepting memory which is known to be
> 	System RAM. However, there might be areas that are reserved in
> 	the memory map, not exposed to the kernel as "System RAM" and
> 	not accepted by firmware. Accept the memory before kexec touches
> 	it.

If kernel compiled with CONFIG_UNACCEPTED_MEMORY, EFI_UNACCEPTED_MEMORY
is part of System RAM. It translates to E820_TYPE_RAM. See setup_e820() in
EFI stub.
-- 
  Kiryl Shutsemau / Kirill A. Shutemov


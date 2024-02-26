Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC3DC48BF6
	for <kexec@archiver.kernel.org>; Mon, 26 Feb 2024 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OvJWHdnREErClClAGDLwxAutyCnuwBF5TjBZ9pTZdy4=; b=OxIn2uDzYSvZ0w
	b9QBa9PNokOkrThnBPDzwAMDsgMu5IJZwY5SJe9RgTXbmGEWfTUubHOlUnctkxogWqIsnUlOVcE7A
	4nw84fYjXZ8tJ9aXcQ6TsQ6jAEMbAwq+9Mtk0ZX2/OkkMXPyGTdWc80gQjs2PH9Nl7g+a6YMz4F83
	T9173PsqzERfpJGA+UGSimlGPt3xPFga6wsaAZDX/z4k2Q9/nUZhpdEo1MH45wmd0Nw2ciTFN4xVS
	db16dCtg9jvoCXfQNLjWRHx0ZZztxZ50guCDR9algFUND3QmyuFdi8c2uhIrZjYf40iOG+7FkSMpc
	xz2BfwnG+9yBHvi9Uqbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reakO-00000000lGY-3srx;
	Mon, 26 Feb 2024 13:10:20 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reakJ-00000000lDo-35Xx
	for kexec@lists.infradead.org;
	Mon, 26 Feb 2024 13:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708953016; x=1740489016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IEntOfzJkMUOI5LibQULm5rlRuQbtScOfPwEQty/vnM=;
  b=Ngr18/F8b02LQNZssIQovMmNKUIb2HT6UGvoeHfvEoRfnMPXOkjKHGWJ
   Mr2/q/SMkmTe/UlP8k5LFQuhzGHf12GAsw3Jm43m3sIs11rFcKRz6Ebsm
   CXrjWS/+JYHLXOURoYXHd470Ql2dEfKsm4LHcHS4mrrapQP4Hz+t9Duvw
   EHHZo3b/w6erS591QFdm/3ACoNhe36A8OXybDIzI2ygtvCSmgPp2DICdy
   taf0nU2flex3E6I5agOolZOtz9SoiKFynYl0kTkTB4PV0YZcARe93MY4C
   UN7g1Et4nyDq69uy9AfLMgW7wVniDDB1eEVs2fGy9r2JtqNiw8gnmAsUe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3351322"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3351322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029985"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029985"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 05:10:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8E41B3C1; Mon, 26 Feb 2024 15:10:06 +0200 (EET)
Date: Mon, 26 Feb 2024 15:10:06 +0200
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
Subject: Re: [PATCHv7 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <6rbvgzd7l5nw3hjxyup5cm2d3dl7cmkqmmq4zdgzlcp544o4pj@ykyquc6u5glc>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-11-kirill.shutemov@linux.intel.com>
 <a14bda4a-15ad-4d20-8b60-0ab92b608f2f@intel.com>
 <3nqc34o54ydpdvo6j7a5hltyjs6kkw5jy5i6dgvivg7f4hzec2@l6jetcopnm6k>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3nqc34o54ydpdvo6j7a5hltyjs6kkw5jy5i6dgvivg7f4hzec2@l6jetcopnm6k>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_051015_919151_09EF2431 
X-CRM114-Status: GOOD (  22.21  )
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

On Sun, Feb 25, 2024 at 04:58:46PM +0200, Kirill A. Shutemov wrote:
> On Fri, Feb 23, 2024 at 11:39:07AM -0800, Dave Hansen wrote:
> > On 2/12/24 02:44, Kirill A. Shutemov wrote:
> > > +static void tdx_kexec_stop_conversion(bool crash)
> > > +{
> > > +	/* Stop new private<->shared conversions */
> > > +	conversion_allowed = false;
> > > +
> > > +	/*
> > > +	 * Make sure conversion_allowed is cleared before checking
> > > +	 * conversions_in_progress.
> > > +	 */
> > > +	barrier();
> > > +
> > > +	/*
> > > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > > +	 * conversions to finish.
> > > +	 *
> > > +	 * If race happened, just report and proceed.
> > > +	 */
> > > +	if (!crash) {
> > > +		unsigned long timeout;
> > > +
> > > +		/*
> > > +		 * Wait for in-flight conversions to complete.
> > > +		 *
> > > +		 * Do not wait more than 30 seconds.
> > > +		 */
> > > +		timeout = 30 * USEC_PER_SEC;
> > > +		while (atomic_read(&conversions_in_progress) && timeout--)
> > > +			udelay(1);
> > > +	}
> > > +
> > > +	if (atomic_read(&conversions_in_progress))
> > > +		pr_warn("Failed to finish shared<->private conversions\n");
> > > +}
> > 
> > I'd really prefer we find a way to do this with actual locks, especially
> > 'conversion_allowed'.
> > 
> > This is _awfully_ close to being able to be handled by a rwsem where the
> > readers are the converters and tdx_kexec_stop_conversion() takes a write.
> 
> Okay, here's what I come up with. It needs more testing.

I don't see a problem during testing.

#include <linux/delay.h> has to be dropped, but otherwise the patch is
fine to me.

Any feedback?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

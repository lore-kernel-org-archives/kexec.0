Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEC3E95A8E
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CDmwH+/OoBnKIxyXN4y0KioJO+wS4lTKhReRNVn6U1c=; b=SDeXuA42rC/Ej3
	T5FNlZBUuFHIOWP7Cqo7ULN4AHTvoV+DHYpHMR+0tVATOio05MQ2zOw6edcT3oe5vNJXPRI0DWReZ
	tN7DXGzoQEuMYa9aSOksIohwrUo2h/nvQdqQCqgkXHpgbWX00ll+qHcZa0BBjpiEqVcKMbj3Llf6W
	G/wrwaT1jWlk32jVoZ6+eMmXAM7xTkhUW6SmOYeTtOWNg1jVTdcHdq+kfLn3v2Pb7iOKfTAlD7C3Q
	+LYIcwW6lT2R8DEi/bI4r5V41/Ah0MgkQYsA0XknoX2MhkcgjIBXqtYfqmhdBBXXSDUngAV0+wiMB
	gHTCozSevInqgdUCx/6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqRW-00Ap2p-1U;
	Mon, 09 Oct 2023 13:37:06 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqRT-00Ap1v-2D
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 13:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696858623; x=1728394623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTBhh0Z/eWz4qUWI59Hqv+z4l97YfU9wayl/EFDoxSw=;
  b=fhPvEhQAQLfkY2E5WldCWKNKM1gIUsX1g7uxFCccOTNgdjSj8J2gsy+J
   PthyFCv2RRuIXHlGJ6QXCczZSe4NUkI8491xHNgROZz2eqG5W1w8a7Ocb
   ZV1ENcoqTm6tJxYUT0Y6RJNjqogew97U07mmffD2huAKh0VndQsha10VC
   bQG7mhMLXfYN4tTytruoOYmyojdpYIjhDbgQgYevqq0H/wf1P+kQr2RxB
   dQTDzMcFM5/9kgGnVY8GveP9GYyQ4HPqxfdWi4Tr17ROsYu4xRbJEbV31
   T43W69kq2gjnpQ9AYBic30RhtSue2YcQh9OijrVfaFY08/GUl9/cr9xrJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450645443"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="450645443"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="756721610"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="756721610"
Received: from ahuge-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.233])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:36:58 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id E967510A196; Mon,  9 Oct 2023 16:36:55 +0300 (+03)
Date: Mon, 9 Oct 2023 16:36:55 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
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
Subject: Re: [PATCH 00/13] x86/tdx: Add kexec support
Message-ID: <20231009133655.3aqi4kwx7wtqgqtm@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <ZSNADxBZEDyxEnZ4@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSNADxBZEDyxEnZ4@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_063703_766789_F37C162C 
X-CRM114-Status: GOOD (  19.16  )
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

On Mon, Oct 09, 2023 at 07:49:35AM +0800, Baoquan He wrote:
> On 10/05/23 at 04:13pm, Kirill A. Shutemov wrote:
> > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > TDX guest.
> > 
> > They bring kexec support to the point when we can start the new kernel,
> > but it will only be able to use single CPU. It should be enough to cover
> > the most common case: crashkernel.
> 
> Not sure if this question has been raised and answered in the past. Please
> forgive my bad memory if it has. The one cpu is fine to kdump kernel most
> of time, while we enable all CPUs by default when kexec rebooting. And kdump
> kernel with multiple cpu is allowed too. Wondering if there's plan to
> support the multiple cpu on TDX in the future.

Sorry, I didn't update this part of cover letter properly, but the last
patch of the patchset makes possible to kexec with multiple CPUs and the
2nd kernel will see them all. It requires support on BIOS side, otherwise
we fallback to single CPU kexec.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

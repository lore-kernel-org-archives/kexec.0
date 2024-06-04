Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCF5C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JSS2i+y+t4ff6Rx0e8XrKQghNZKwGK65i5bLKwhpI/o=; b=eo5KXA4zxiedw4
	5qVnSm/gPucxUafLksYzkygWveTAHTOpzNumUakn8DVwCC1bpSphGnZitrqLeeq0cKrhEtiePY48s
	/EXFheeuv9Fyc7PRRlGaDjafJ/MjaBcdmP9nPxukDsbi68FsjU3haYR7VmrIjTOWqMDES9xl0iSsl
	xbpiLkdTVCwwnug21yq+haISVieIB7U6esea9r/5irlv+PGItdt3as6vm06Lj76MGZjZKMyCWN4yb
	cXpJ6z+GORS8GTdn1mRpWcyNXxYLX0F+qbMEOVAy6OYWP7s+aGzsrCnHF48jWeZNqDrciRzLzj4PD
	rPKTEZC0NcOfQQl5BAxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEWxq-000000036is-1gr1;
	Tue, 04 Jun 2024 16:24:46 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEWxn-000000036i9-0SWM
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 16:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717518283; x=1749054283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvWvcrNQgufN9CzRFzzo7ISHTN099yhCI9EO4AnyfJE=;
  b=E9RPLouuoQ01gCfFcWIVyvTv26hRngmW+hPVI/ttl9onKU7DtSnF0J/w
   V5K1wsByzqj0WG1hQIHfUHRWfJ00V5tM2G6MVj+PEKJiK/fXesLBgYHMG
   pAZy45J6i19uGkuLxsCMOkpiYC7NcTqn8t+bXpCsieuCPuFg/jQEep22o
   TOGr191rby9xVHpvV1dje3NiJbETfv6XiK9OrnpN3tKGFsqAoIHw4PkCn
   0hbNvYmSJ1voNHlTfEGjQ+IULpcGHKkeLqtHqfKPYb5bcIb4TL/Rw8QG3
   mNTIqrjgPY54FHJjCnd0s9DU0DmHX7vuhtgWrFKoKBUneWOkm9aJtPEqw
   g==;
X-CSE-ConnectionGUID: Wi58wWSuQHS2Atai+fUvdA==
X-CSE-MsgGUID: 8KLI8vxYT5OKtqxl2mnTYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13829920"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13829920"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:24:42 -0700
X-CSE-ConnectionGUID: qUBTJsF0Q7eFyomBX4zctA==
X-CSE-MsgGUID: n0UalEy1Qt+6LV6QKuU3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37293248"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2024 09:24:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 34FF52DC; Tue, 04 Jun 2024 19:24:35 +0300 (EEST)
Date: Tue, 4 Jun 2024 19:24:35 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 09/19] x86/tdx: Account shared memory
Message-ID: <5sjy5qfztnipehq3j3hn4jsufrd642n272sjjcpowvgze5qm22@jjfmw6u4rvgl>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-10-kirill.shutemov@linux.intel.com>
 <6fd2c15b-5bd9-4e7e-8da0-4ca2c89b38f9@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6fd2c15b-5bd9-4e7e-8da0-4ca2c89b38f9@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_092443_187489_2CC84B1D 
X-CRM114-Status: GOOD (  15.80  )
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

On Tue, Jun 04, 2024 at 09:08:25AM -0700, Dave Hansen wrote:
> On 5/28/24 02:55, Kirill A. Shutemov wrote:
> > Keep track of the number of shared pages. This will allow for 
> > cross-checking against the shared information in the direct mapping
> > and reporting if the shared bit is lost.
> 
> It's probably also worth mentioning that conversions are slow and
> relatively rare and even though a global atomic isn't really scalable,
> it also isn't worth doing anything fancier.

Okay, will do.

> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 26fa47db5782..979891e97d83 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -38,6 +38,8 @@
> >  
> >  #define TDREPORT_SUBTYPE_0	0
> >  
> > +static atomic_long_t nr_shared;
> 
> Doesn't this technically need to be:
> 
> 	static atomic_long_t nr_shared = ATOMIC_LONG_INIT(0);
> 
> ?  I thought we had some architectures where the 0 logical value wasn't
> actually all 0's.

Hm. I am not aware of such requirement. I see plenty uninitilized
atomic_long_t in generic code. For instance, invalid_kread_bytes.

And I doubt TDX will ever be built for non-x86 :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04B0C27C77
	for <kexec@archiver.kernel.org>; Wed, 12 Jun 2024 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AUBvd6qPdn2MJVmI8NG79ScXaW9fyTNWyC4zpwZAB7w=; b=uJpWiEZ/NESKQa
	0VgQilyhY+WMZCXaGCxjigVl4QFV6X72sFrSoM8+GMe5gqkfNJraJMsUA3t8pkoQ3OlBOtVWWTUZ+
	i6sSC6Vx/uymF0RZ5HZOP0WXWujJP007BwpRtOA8SRe6ItddOI0E1eavMCWUSN0272bSx2K2uxyfl
	Mu6MezJp7/DDxHyjoAsXGInwL2mhsjQ2hY5mXpciOIH3IbFdZygeoe3mKgWsUluXuBTqV8TMm0cPG
	hiGiAsmrcxHwPuXFAiXSrPWiMlxeiQgVlO3wbhjGKWDIibvLRG5SO2DFHGQpldDnOywRPXp/d3H8D
	sWdUJILbaKnraVAWJeJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHKDk-0000000Bxse-0DkL;
	Wed, 12 Jun 2024 09:24:44 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHKDf-0000000Bxmj-0ppY
	for kexec@lists.infradead.org;
	Wed, 12 Jun 2024 09:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718184279; x=1749720279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qea/Jn12txiTuu1sQzZhiztNW21tvwMqG/CoQdaTdLE=;
  b=Ji0uTgrtXzmB9eNKa9GjDTeC4+2EBQfjyduHVY9emfybV/mj76BUDE0o
   iOiBJ2EaVjI9KjNMuG2TlZ9L0Y5ReTN4x+/3jww8GXYALrkYZKYRIZIcI
   GbIFq4PPmABUzaf1FtvXIjvbAooRIvJxZ7IYuv9pX8WujYuLgevxyZZPO
   IB9KIuftEGEkYIk3FQ8bfbhyV/RazxwtnI4jLgAs977ecxCJBF1SY0eeQ
   fYZU+hwwLxqVLwaoI1WlVvgmN0wZYFv9vYuWw/kZq4PxOqB2t4HUiVaE2
   95Y4mg9/8xEH0IJhPGAtnWEN/E+G9Ja+KcDdblZUPscPnsyCTHdU2GjKI
   A==;
X-CSE-ConnectionGUID: sNB5MHj9Tu2mFSHaeEv76Q==
X-CSE-MsgGUID: NOOk9iRySGC4xsdzOM8icA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15166822"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15166822"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:24:38 -0700
X-CSE-ConnectionGUID: i2TjnqRFRByO99lPQ1rpLg==
X-CSE-MsgGUID: 3Cah0xaYTqG0k8+PVw92kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40201459"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 12 Jun 2024 02:24:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 195CE193; Wed, 12 Jun 2024 12:24:30 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:24:30 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_022439_431159_1B4CDF3E 
X-CRM114-Status: GOOD (  18.53  )
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

On Tue, Jun 11, 2024 at 09:46:53PM +0200, Borislav Petkov wrote:
> On Tue, Jun 11, 2024 at 06:47:05PM +0300, Kirill A. Shutemov wrote:
> > Borislav, given this code deduplication effort is not trivial, maybe we
> > can do it as a separate patchset on top of this one?
> 
> Sure, as long as it gets done and doesn't get delayed indefinitely by
> new and more important features enablement.

I will try to deliver it in timely manner.

> Usually, we do unifications and cleanups first - then new features but
> this kexec pile has been long in the making already...
> 
> > I also wounder if it makes sense to combine ident_map.c and
> > set_memory.c.  There's some overlap between the two.
> 
> Yeah, we have a bunch of different pagetable manipulating things, all
> with their peculiarities and unifying them and having a good set of APIs
> which everything else uses, is always a good thing.

Will give it a try.

> And since we're talking cleanups, there's another thing I've been
> looking at critically: CONFIG_X86_5LEVEL. Maybe it is time to get rid of
> it and make the 5level stuff unconditional. And get rid of a bunch of
> code since both vendors support 5level now...

Can do.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

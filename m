Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F57C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 08:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q3zkEawuVWA3ZQroLzZ9KHJz8zIxL0LhJANy+y44+/E=; b=E14UpeSnYzV8m/
	gvMW7h1n/ipvMNAWPVyoRmhqfLLPBuZ45nvrZQOjGC1sVYKZ1Mo8zk6F25kYFAHl1GY77R5FRkaGa
	gwnuOFEqPRn+4i1E7lSxDib9qfxSLWnqx9IoRhOFcpl6dksJM/DXzQcFrlx8qQT4wO8nCSldWjIlG
	E0f84+Ro43di0n8xi+5NCel2slGf5pRdFWkpjfN1V3V6L9MCc9Jhkzknig6HZcUMCDGeTSvHUnjBB
	bC+CnN+485AhIZW6CsSz6qOup7UkE8d3/yh57aqVFnKfHm86/Q+lVip80BwMCkff7pmoWZiFK5FfE
	dEkHVo+S9b/LFwmcNPwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzY9c-00000003K6K-2fjH;
	Wed, 24 Apr 2024 08:39:00 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzY9Y-00000003K3g-338Q
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 08:38:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713947937; x=1745483937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hMMvxpDfbjDULv1fmXRnELIn09JQOXoi13BP9n0Ktzo=;
  b=merlmbe1D1jzqrbXEZNrHQ1b6DHTRRoL1OLzdOvoC/e7ZoFqCrZQFDbU
   hPKA/pi8frNU8stnFBUAV18STKyywTPfWyxF0WKwsZ4XNPmMhRmH+jDsQ
   IIaUiAH4VS2i9fAP17wUdY4tEWXvkLWreXJY3BKFSiMBX774AVJKz01uI
   HI9IROlDiIUPQWRu4eqt5o8WynbtW5lhajadMDXBHIfhcrKTEtQTKcHHv
   1WD7D340j69T55sOQ/Myz7q8L6HCZvRxqNMXEi7L16cQWILp9x3jou7my
   oDKNpHbH95kViS6Mih0H8eDfNGaRjS9BKGowQ99A33/omtkrpPe9zxb3y
   g==;
X-CSE-ConnectionGUID: l1oG8A4FSeywgDhARZ9ekQ==
X-CSE-MsgGUID: 23EHV1UtTK+Jkr//Kq2x4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13398967"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13398967"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:38:48 -0700
X-CSE-ConnectionGUID: +3UgJW18TYqRu6s+Kb1SXw==
X-CSE-MsgGUID: BmfrGwObTz612CZwmk9qVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24711899"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 24 Apr 2024 01:38:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3DCFA28A; Wed, 24 Apr 2024 11:38:42 +0300 (EEST)
Date: Wed, 24 Apr 2024 11:38:42 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
Message-ID: <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_013856_821725_BC201609 
X-CRM114-Status: GOOD (  14.50  )
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

On Tue, Apr 23, 2024 at 06:02:58PM +0200, Borislav Petkov wrote:
> > 
> > Currently CPU hotplug is prevented based on the confidential computing
> > attribute which is set for Intel TDX. But TDX is not the only possible
> > user of the wake up method.
> > 
> > Disable CPU offlining on ACPI MADT wakeup enumeration.
> 
> Something's missing in that "justification". It should explain why
> CC_ATTR_HOTPLUG_DISABLED is not needed anymore.

It was wrong from beginning. If ACPI MADT wake up method is used on the
platform, we cannot handle offline, regardless if it is TDX or not.

> And looking at patch 3, I'm still unclear as to why this change is done.
> Is it that the "ACPI MADT mailbox wakeup method" is going to be used by
> TDX guests now too so that you don't need CC_ATTR_HOTPLUG_DISABLED
> anymore?

ACPI MADT is the only wakeup method supported in TDX guests. But offline
is broken is because of ACPI MADT, not because of TDX.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

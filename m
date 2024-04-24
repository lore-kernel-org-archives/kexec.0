Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39667C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jyALsXLY++1r/atSwZezSk50UURt7zyrA9aXSmZhziQ=; b=WVki3aJM2+G575
	uf44Uc5Zw1eD+Y0eDgqpxkVIQjHoKkfqbmtEeY3Anr+Yx4xEuU+980OKXHrDjgCigsBvKSOh0jcgQ
	9oZCrp9yRsAiNLNeIQCcb/ZOfk6/7hQpw3I7J1ClIj/K5MYt++nkdXVhzjAvHBuer5t9BJUhWtQ05
	3bHv++K0F1DU378P9EbkAxNO9xmjoPB+yqT32gHSvZHlngybld9bQEROmo367FIVheKKsExLCOnrp
	XGEkVEZccL6RrBgSK3KDMXG+VdtV74Yt9S5vcjGnB0ozzp2oDPEb1WcFiua6Lq8UD/19Zlza6P6RK
	hGFLERqqPxvKJci02Jng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzdj3-00000004VRV-31oZ;
	Wed, 24 Apr 2024 14:35:57 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzdj0-00000004VQb-3pj6
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 14:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713969355; x=1745505355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kYUJMj8WambktxnBcdatjza3aKu1bxR5g5szXi3Etjc=;
  b=F8zIvabAa8rHy+9kema+gQUjVPfUWiWPuoS5dfJvjyvO2fn4sKl+WOPG
   hKwU5vKTTJrHtMzo0nbQZ6qXT2FhpNbtUrubx/rrk63S72R6vw3J5EVtK
   dnxZ9V9o+UCF4HgoMDxz1PvU5yyT1HNIN2sYw/5Z++P3lBV0Nri8UsJni
   +6irn6QddDIA7SMNDW4HFfiJjRLeJMwLHz9iITjHONip0iFNuVDaB2cXl
   W7GerVK8SGY04Zb2uD4KKaWlax3x7nyZDpAfw5UU2EZr/eiYinXCnHvOz
   /jncUwIsBAhuZ++lMJ2IhE9czGM+a/uSvRZ1qABHjH54JTMbI02DaTkHa
   g==;
X-CSE-ConnectionGUID: l6dk1sM9R0aCzpkTimrngw==
X-CSE-MsgGUID: w3h2rNk8RKKSHVuygmizsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9825857"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9825857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:35:53 -0700
X-CSE-ConnectionGUID: a/dchSKJR/COZIoy8TSfXA==
X-CSE-MsgGUID: wBqVpR8xRTSjGjiyMjjTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="62191162"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 07:35:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 715EF1BD; Wed, 24 Apr 2024 17:35:46 +0300 (EEST)
Date: Wed, 24 Apr 2024 17:35:46 +0300
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
Message-ID: <svpuqhoglv7s2wtu754i4oicowueen47vq6eobjbznsromb4m3@4h7vy346n4ak>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
 <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
 <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_073555_009415_AD6591B0 
X-CRM114-Status: GOOD (  14.48  )
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

On Wed, Apr 24, 2024 at 03:50:52PM +0200, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 11:38:42AM +0300, Kirill A. Shutemov wrote:
> > It was wrong from beginning. If ACPI MADT wake up method is used on the
> > platform, we cannot handle offline, regardless if it is TDX or not.
> 
> Sounds to me like this fact should be a prominent part of the commit
> message and these 1-4 patches should be carved out as a separate set
> fixing that ACPI MADT thing and I should take them separately now...?
> 
> Also, does this need to go to stable although it is kinda big for
> stable. If stable, do we need a smaller fix first which is backportable?

Correct me, if I am wrong, but I believe TDX guest is the only user of
ACPI MADT wake up method. At least it was added into kernel for TDX guest.
So it wouldn't fix anything user-visible. It might affect a future
platform that uses this wake up method, but it is a guessing game.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

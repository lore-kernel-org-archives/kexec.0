Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D17C41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LFNUT7430/0Xj3Ngiy+QeQqlPfznWhcWoToP1Mv+eqo=; b=hwfwfzpWw5X/Lv
	jIQXEcJ0drNNFq4Caj8VKvn5P/4fO9pAxRysoQqof/KDcOU+RzdvI7kZkOj0zMbbqnJnko1hGqZNf
	AHbeXAMB8hSLwGLfz8dkEGLbhAHevgFPZRiCOq4UxUQBSwQY/8XWEntcoP1r06Kc+409qNHjhET9n
	an3X2OmUkZY16Di7Rql3iwSeLEyHXuS4+Q+3M5upVXdwFUOnM26w2KdPD++2LIP7MRWvZEPamUH0O
	q5c+fjFSFrMvEpxfRkxdOg1kmMrXROHLTS9DhOD+1Zydes8XEnfcfhSUL+1X0eAWbcFp40ZSmQPnG
	k8jl7yI6CRSzJXbJMB2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGiTp-006QLZ-2R;
	Fri, 22 Dec 2023 16:34:33 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGiTl-006QK6-2p
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 16:34:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703262869; x=1734798869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nwu0jTUTyUVExiakxdbtIQfJuL2c3K4kO9Pr5Ymd8sQ=;
  b=fO+SlFyuw72KMKXLr1jBPOOFt1KrQ92h2oI63KQbvLW1X+jun1ZjkNHi
   szX8UNjeO8IT8Tpy42j6fNJuX0Wa4YXkvkyasIVj81PPFYptSaOhislU0
   i0QKyZB2qKYaXp8uyOYNpCAkIGSnfRt6+TQpo6xSk7suLe8B+r+foTZt0
   dMUJvwxf036t6St0dOxwi2P6gQ/QUGYddtkCJbKykVK6pslRmyJB0eFfv
   ncvC0TGlqofvcl+xKRCCzAvD/bRH3mbkMnHu8aI1i+ntHvNaJiSnoRDQh
   ZL6ec6B0MdpmazGNb9u4GAtnw5YD09vwbVbD8Rz1O3F0YVHp2XyJgm4DR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395024982"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395024982"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 08:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="777082152"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="777082152"
Received: from hassanfa-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.171])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 08:34:23 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id EC2FB10945B; Fri, 22 Dec 2023 19:34:20 +0300 (+03)
Date: Fri, 22 Dec 2023 19:34:20 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231222163420.4mu5kmznfmsave6k@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
 <877clfmcpy.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877clfmcpy.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_083429_928568_5781E50F 
X-CRM114-Status: GOOD (  12.01  )
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

On Fri, Dec 15, 2023 at 09:29:13PM +0100, Thomas Gleixner wrote:
> So this waits and then does nothing if the wait fails. What's the point?
> 
> ...
> <SNIP 170 lines of pagetable muck>
> 
> Do we really need this specific hackery or is there some similar
> identity mapping muck which can be generalized?

I've addressed all your feedback, but this gave me pause. Looks like none
of kernel_ident_mapping_init() users frees memory on failure.

Is it okay to get this part as is and I will follow up with patchset that
fixes memory handling for all kernel_ident_mapping_init() users?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

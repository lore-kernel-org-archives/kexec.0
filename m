Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B74CD11C2
	for <kexec@archiver.kernel.org>; Sun,  7 Apr 2024 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TkH6Yr1tXfrXjoN13yuRlxz8J98upVD/fOEtaSDqvv8=; b=KkkE942P5weJ4a
	U8aGDdAX7Fi1EOfu9FvRz3ezAmA9EhW1eNjYi9uRFojLB6WN22YHbTBy5kA2JyH87UcQPImYSj1fI
	0J/3frsS5IjlnfngDHBXMyIfL8ymuT+2ta0QOydYK5OZfkwweA8x4jWcVUssQ8fjfIIfjgEWn7oOg
	wDj5vvbr8BX9kDYlOCh0Ksh2VSBKV3YdIQzXU3cgN2ULmau/lobd1diGhAL2QqDrR45gVMV8/netN
	80b3KcqZDdtSsW6GERYoxKGlLXFKU5YjKrqMpg0DcqiNcP3UIP0+YdB3Ny/CMFgAhYA7U+trBJL/i
	d/yGYZMqFCuYy3I2XCwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtUs0-0000000Cwil-0s0U;
	Sun, 07 Apr 2024 15:55:48 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtUrs-0000000Cwgg-3yTp
	for kexec@lists.infradead.org;
	Sun, 07 Apr 2024 15:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712505341; x=1744041341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kkPJdu5raGq+lO4qJBmb+P54LbJQkkF985xzuXyRbo=;
  b=ENg6ivNa+3/jOOOBCWDqhD0d0gW5+8u+W0t2fwAxWAcbu4QYUs6nbV2a
   RlqLk8mNJdwEcZpNTMyrPuleTo8mbVZuMT4HjCwLy9Nh7q4jqgrecLwh+
   S/YUb8blAsngUfCgIHaWbE9x2f/Npmi2Mtu9/jhCDI/1K7OBAbM2Hgxh2
   qntLruTv+ITvz62kQ5SrOsW6aOaXa/5XRpOo8pnHxn6t1vLkWRhXC+NHQ
   fjwQcGSMXAKMC/4i/zoFO1Pmo2Npu/eJaM06QlhkNNAEEbP6BiI3LPtWA
   ZIIxXR/B8lh12ZM5OoXBU6CUFWOzyZVZjezw+Jxi8oACu7lybCIbetmv5
   A==;
X-CSE-ConnectionGUID: iSVcQBoZS0C4caCoA1L3bw==
X-CSE-MsgGUID: U6I0gLnkTbS3/aIaWRwWfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="30271190"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="30271190"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 08:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="937090007"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="937090007"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2024 08:55:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2E8AF1CB; Sun,  7 Apr 2024 18:55:27 +0300 (EEST)
Date: Sun, 7 Apr 2024 18:55:27 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 00/17] x86/tdx: Add kexec support
Message-ID: <da7hfavumtb4nyp6se2pwwkq3idxgzpehnn67qsjdgigh6xq7f@lk4w5o7o6ama>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <bdeda1f9-b7d2-4bc3-ad20-342478be464b@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bdeda1f9-b7d2-4bc3-ad20-342478be464b@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_085541_082854_EB69552A 
X-CRM114-Status: GOOD (  10.11  )
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

On Thu, Apr 04, 2024 at 01:27:47PM -0500, Kalra, Ashish wrote:
> The cover letter mention the inclusion of the following patch - Keep page
> tables that maps E820_TYPE_ACPI (Ashish)
> 
> But i don't this patch included in your patch-set.

Ouch. My bad. Will fix in v10.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

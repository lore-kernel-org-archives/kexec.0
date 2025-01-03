Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7500E77188
	for <kexec@archiver.kernel.org>; Fri,  3 Jan 2025 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZaGpN3ZP6sH688wWTuQXnn7HrEKF/LbCSU6s5+PLE9c=; b=HDYSkmIg1oyasqddXtEGPnPg4k
	Vevy5rauI+HOi4bpum2tOxcSJy51mj32U11DI5b7iDpCFdYV1u1iB7flF7El8W36QBAfDx3vqPKhw
	+WlzzDFdGdYmZ9RKeq+Vey+MT+isRWJEP/lOTaQs6hawkv6/Lc/uy6wp+fmj6Dy4TtEIcweswCS8z
	k0kU497AWLGwjUY/y7bD+QqIE/dQx18Q3Ol7fdH7ok1NJkwM+cJlLqDtRPZCvHAjZ56WAaua2MVLU
	YkFps2BJeUHehP4ZjTXLHLmBIYJz0twBlFtZZFZdHSwhy62L2OXuP7bRh/xIblqU/XfaDrPaUkIPw
	J+TJV6UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTig9-0000000D7Aa-3ac3;
	Fri, 03 Jan 2025 14:29:33 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTidV-0000000D6iM-00Fb
	for kexec@lists.infradead.org;
	Fri, 03 Jan 2025 14:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735914409; x=1767450409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCtGHIyk22ftmAaNHvzMemXse08zxaO3UDZ8N2AEtlI=;
  b=bfz098B3oMMojoPSaf2YKLin3l6asvYhG7ssDGBE367/XbfXpxLkHkvd
   7v8qN5L7v8V7oMeGGMj6htP9ryPtvGmcg61u1jZ2PKorF8lde763hlX2G
   vCFUtSrws4oREFOUMseWWASVOB0/kcpnD61fe1fR+q2z9uXg+quMixQ8E
   A3I7kbkv+bwzZ1h+La992uOHi0Ju4NQ/DuBzSS914tAYj2+fXqNrr3SJX
   tVjnTJibw4St25Q69T0uO7qIU7vB03hQeV3OAZ3neo9oL7X9ygiRs+GVz
   DSAoxPzwsxBCWt4GOwSW4aF0MTL3bN3qLnrBys9wFmCX2damO6m/XUfon
   w==;
X-CSE-ConnectionGUID: u0f0S+5XQaWwrq5W1dYNqg==
X-CSE-MsgGUID: FUdCkIEsR3Wu1JFrGTlDrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="47576542"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="47576542"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 06:26:43 -0800
X-CSE-ConnectionGUID: 5ZDr436bTE2iAz01zQwEpw==
X-CSE-MsgGUID: TtpSlzzeRBO0ztyFURjzBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="102280941"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jan 2025 06:26:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D267A2F7; Fri, 03 Jan 2025 16:26:40 +0200 (EET)
Date: Fri, 3 Jan 2025 16:26:40 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Zhiquan Li <zhiquan1.li@intel.com>
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to
 vmcoreinfo
Message-ID: <d3h7ptoh63zleuhcfrtnj4jagggk7omlylyqys3vhrd3uw2bk3@d54obusanwdk>
References: <20250103074941.3651765-1-zhiquan1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103074941.3651765-1-zhiquan1.li@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_062649_052710_FA3972BE 
X-CRM114-Status: GOOD (  12.75  )
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

On Fri, Jan 03, 2025 at 03:49:41PM +0800, Zhiquan Li wrote:
> On Intel TDX guest, unaccepted memory is unusable free memory which is
> not managed by buddy, until it's accepted by guest.  Before that, it
> cannot be accessed by the first kernel as well as the kexec'ed kernel.
> The kexec'ed kernel will skip these pages and fill in zero data for the
> reader of vmcore.
> 
> The dump tool like makedumpfile creates a page descriptor (size 24
> bytes) for each non-free page, including zero data page, but it will not
> create descriptor for free pages.  If it is not able to distinguish
> these unaccepted pages with zero data pages, a certain amount of space
> will be wasted in proportion.  In fact, as a special kind of free page
> the unaccepted pages should be excluded, like the real free pages.
> 
> Export the page type PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo, so
> that dump tool can identify whether a page is unaccepted.
> 
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


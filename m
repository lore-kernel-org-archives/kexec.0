Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3084CD2FFFD
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GiVly/rhN/EJL1j1BpFSI4H+orvXKAuBHY2n8CO3BGg=; b=reLs0UHtJ5XxVI
	qJlvMD3BhBYi5zXf2l6eVyzLhAcJ5B6Hk+zt4pux/MD8FOPnPd5FYoR1HsenbOg9dPqbPuTzRmjhY
	ZxYWk2EL/uLK0xoEog38dOkRQwQ+PZ+lkbr30uTYHaStBZitz/2QwGzrAFUbmddqSqvs2iFng7+6V
	0CTUXIejTlqJDJZM4KhxkBpnaoly2dXd8Q4ih+SIn0pOObdmPnNMEx/HtdxzAKchhQUcsmu/K/YjU
	FUi24wDpUEgbmBCkjPytm3QfxLmOqis+NQBOkmYe8/dICBzi67cW07a6SdddpnfImM9w9XbrAWLJJ
	CKO24aajtoJVjW73rWDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1m0I-00000000jx8-10Et;
	Fri, 18 Oct 2024 12:22:50 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1m0E-00000000jwA-3oH6
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 12:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254167; x=1760790167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=awYloGo+PANLFp0nhkTibOtcO7WmO6xuHo1JSv1VzMM=;
  b=TbNbARObJv6p5w1qabUWFZr+4zcnVl+bbWc6E9Kv6V3j1FJ1KruKFPP1
   cROTBA6NQIeR4GrVaYrvwvDjNOlYenFgvvSQWLdrNsctGLoHIr6mUiboC
   HDwgwKrkphkXw1eOmwu2YbnXFJhGa9FI34cO2fQg3qkiE3Y49FpEtKZmR
   lx2iy5M5icraimzG3PVloULuWLxRAIyj+cxIKmxJ2rs7o+uYUJSRq4o8d
   O9i9+106Bper2JVbDMMSq4sYjyAbb0uheZjTKEA/Io392iI+0mwQTv3t5
   fLlHaPBylv7p32qT0CybO6AtBJyNVf2CYTV7wd2Dvqwn05iKh+i+d5AJP
   A==;
X-CSE-ConnectionGUID: QPf2dkxvQ9KLXE3sn184bA==
X-CSE-MsgGUID: ++Rt+fy/RX2G7eWA4WNgAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28938169"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28938169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:22:44 -0700
X-CSE-ConnectionGUID: 1KhvwUMkS3CAcMIewNw5fQ==
X-CSE-MsgGUID: 8jNyaGBjQ7+Mj9pUI+sPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109590171"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:22:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1m06-00000004SR9-18Y9;
	Fri, 18 Oct 2024 15:22:38 +0300
Date: Fri, 18 Oct 2024 15:22:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_052247_333734_09A3AA19 
X-CRM114-Status: GOOD (  11.86  )
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

On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> HI Gregory,
> 
> On 10/17/24 at 03:03pm, Gregory Price wrote:
> > walk_system_ram_res_rev() erroneously discards resource flags when
> > passing the information to the callback.
> > 
> > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > have these resources selected during kexec to store kexec buffers
> > if that memory happens to be at placed above normal system ram.
> 
> Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> memory carefully, wondering if res could be set as
> 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> 
> Anyway, the change in this patch is certainly better. Thanks.

Can we get more test cases in the respective module, please?

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

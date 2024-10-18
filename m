Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117B4D30016
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zSvT/X5H2QqmLzN9FY5c1DGapIYUBM0jKJ0WV7kRQmk=; b=uTJdt+gK4av04/
	251aE6Jo9hJ4wFum9Phj5pBQcf5TLoK1Mh+vx1maxmvqorFF6b+2fV42+P5jvF5d6YFmTCLX08X3M
	wwRQuVzFNahvc4ufZnEGSNti5myC6q4ghukopUyial1Tk2gqo+jwzUPU2Vk0laEt0lXslpWQ8PXHm
	WIBrpCP74uVSVP5cfcxy/ogdSZRnWpUI05EsMe7MAiAiCtwZZ0U3qzs7BAkX7otprosqVQynkfxjv
	yjCJKdNm6Ex1D5uKM9HSWvgNFmNKR2G8YuRdF71LQkXiJoNi7jlbfxnnVZS/iaQpwEobYZ24x6/J+
	TXrQb/szDht7a7Bm8hDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1oMg-000000017MG-36Hd;
	Fri, 18 Oct 2024 14:54:06 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1oLO-0000000173L-1NyR
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 14:52:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729263166; x=1760799166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p6gcj2E2AWyHapsnii9ApBkSENMZ4qCfzEIAfYkDheU=;
  b=RjikpbnhTNddCYTZWOpXvTXrFjZeZe3eMejFOKrQdqo8MkoZj53ExNQj
   EA7PSTt3qsV2qr+dHGwl3uALSHOTyL6LAH1hx2PD6Zq7RUoQfCzA54Ihk
   BhLIuj0d2+oYdaP8yuMputH25up/nA6NEorKVze4Nd/IYvOhmWEt8SYGQ
   ftr+nt7ogjod5BX9OD86F/SpvO5lePruLeFnJ6c5Vu4mSGQS0m1J9n24d
   XevT774sy1frH7r7fRqWvLwIwwhZw2+lOJlBLY0gLKux59CmrGpbHbxrb
   r2HUThQZzuWRkRaWrZsAPOZsHopWHRO7JdLg8IkeNMeqNyUNiahHjFBeS
   Q==;
X-CSE-ConnectionGUID: j1YZLikhQhy3FzR3itzwrw==
X-CSE-MsgGUID: BX3RatVXTuatTWg0lEijBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28931382"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28931382"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:52:45 -0700
X-CSE-ConnectionGUID: hTqHQxmDRla9eZdI7ktgNw==
X-CSE-MsgGUID: R5JGxbFyTeCcgIegNnEoRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83463777"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:52:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1oLH-00000004VIk-40Oj;
	Fri, 18 Oct 2024 17:52:39 +0300
Date: Fri, 18 Oct 2024 17:52:39 +0300
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
Message-ID: <ZxJ2NxXpqowd73om@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
 <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
 <ZxJ13aKBqEotI593@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZxJ13aKBqEotI593@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_075246_413795_6F80860B 
X-CRM114-Status: GOOD (  22.33  )
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

On Fri, Oct 18, 2024 at 05:51:09PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 18, 2024 at 09:52:47PM +0800, Baoquan He wrote:
> > On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> > > On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> > > > On 10/17/24 at 03:03pm, Gregory Price wrote:
> > > > > walk_system_ram_res_rev() erroneously discards resource flags when
> > > > > passing the information to the callback.
> > > > > 
> > > > > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > > > > have these resources selected during kexec to store kexec buffers
> > > > > if that memory happens to be at placed above normal system ram.
> > > > 
> > > > Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> > > > memory carefully, wondering if res could be set as
> > > > 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> > > > IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> > > > 
> > > > Anyway, the change in this patch is certainly better. Thanks.
> > > 
> > > Can we get more test cases in the respective module, please?
> > 
> > Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
> > test cases basically is system testing, not unit test or module test. It
> > needs run system and then jump to 2nd kernel, vm can be used but it
> > can't cover many cases existing only on baremetal. Currenly, Redhat's
> > CKI is heavily relied on to test them, however I am not sure if system
> > with CXL support is available in our LAB.
> > 
> > Not sure if I got you right.
> 
> I meant since we touch resource.c, we should really touch resource_kunit.c
> *in addition to*.

And to be more clear, there is no best time to add test cases than
as early as possible. So, can we add the test cases to the (new) APIs,
so we want have an issue like the one this patch fixes?

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

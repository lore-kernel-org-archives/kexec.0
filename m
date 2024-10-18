Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46CDD30016
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N8HYQb6r1ok9utir+5kJhE74PrrF5lu+LLI8jQZlwII=; b=O4qyoyao7Mtagi
	MnnXhDBIK2n/+2EXOGtKg6t9EFGOYkxKo5JE4RolJNVSMIN9rhRdQX9UOvfr9TdbJ5vhJ8U7W+zmJ
	irZWMDWXEGMdN2zRLEFSzIbyA/6hy/R/FkD+l20mDOioYfwIpD9Zbi3kuX1JcvAMaEWoS97OmuYe6
	gOBfTkjWpAzxrTsbtWeFN101UgNj41wBoj9+fJYH1UR6aatB3iztHLOcHCrH4ph2xOnkrqerAqSIz
	VBJKD8Jw4QUKaQ7zJIB33Zc7yYSvcSEGYO95N2uOjqJX9CSib2XMwYTm1Q1fPSHrGKLTp7CSSozAi
	qZhkEr2JVjwE6cXNAK7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1oJz-000000016Xk-2OEK;
	Fri, 18 Oct 2024 14:51:19 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1oJx-000000016Wd-1ghg
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 14:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729263077; x=1760799077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvFFtXDRxbY5FZUBQWKu5jXQobvklQTQdXW0nWSFaTk=;
  b=oIt+JL7LA7ZPBve5xMAADAM7LYwGuNjpD9MHNLLA/3SjVUcdIAmdSQA4
   aVOV7lexTBGkpPEMvJcHYA3QzOmWgbm4H/seBfQM+PorMaXBqNh+ykJoj
   oSKb88RMU7RwnfLoBcpW5SLLjk4WI4CWD0TJvWS3lrVywWPt56J39vsRe
   OCua6B6DxhbB3j8IdfqT0/iCpWRVLeiHAAfliCPnYNWdCXgSeM+XaaeHv
   JTk0rxMhb05FGXTDlk38H/uLHBreG1Ks0iMa0+Ocl8qSuK420iPbLM6JO
   6BL+v/9Gcz98HkgWS3yvFO9VJKzmqW2Z8EvK181FoVPFIZvaTk1GzHrht
   g==;
X-CSE-ConnectionGUID: IdNxqaURT8SYU9uRbVHn4Q==
X-CSE-MsgGUID: nIaOyWbcR9O0hReFhzRk5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="32723767"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="32723767"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:51:16 -0700
X-CSE-ConnectionGUID: GtEjq0w+RiC9vSvLGh+Orw==
X-CSE-MsgGUID: Ei+TJ5/0TPudtRSBGS+kzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78845662"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:51:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1oJp-00000004VH8-3nZe;
	Fri, 18 Oct 2024 17:51:09 +0300
Date: Fri, 18 Oct 2024 17:51:09 +0300
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
Message-ID: <ZxJ13aKBqEotI593@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
 <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_075117_488339_31AD1539 
X-CRM114-Status: GOOD (  18.37  )
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

On Fri, Oct 18, 2024 at 09:52:47PM +0800, Baoquan He wrote:
> On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> > On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> > > On 10/17/24 at 03:03pm, Gregory Price wrote:
> > > > walk_system_ram_res_rev() erroneously discards resource flags when
> > > > passing the information to the callback.
> > > > 
> > > > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > > > have these resources selected during kexec to store kexec buffers
> > > > if that memory happens to be at placed above normal system ram.
> > > 
> > > Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> > > memory carefully, wondering if res could be set as
> > > 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> > > IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> > > 
> > > Anyway, the change in this patch is certainly better. Thanks.
> > 
> > Can we get more test cases in the respective module, please?
> 
> Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
> test cases basically is system testing, not unit test or module test. It
> needs run system and then jump to 2nd kernel, vm can be used but it
> can't cover many cases existing only on baremetal. Currenly, Redhat's
> CKI is heavily relied on to test them, however I am not sure if system
> with CXL support is available in our LAB.
> 
> Not sure if I got you right.

I meant since we touch resource.c, we should really touch resource_kunit.c
*in addition to*.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

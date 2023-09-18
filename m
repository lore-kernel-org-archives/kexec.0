Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA550CD37B0
	for <kexec@archiver.kernel.org>; Mon, 18 Sep 2023 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=buoZ9PPrXJbyVhsnWrLWFBS7VIukmD3F/zNtbVADFi4=; b=1MnYDO5pgoysBz
	xsoc1PN0/H4DynMtQTAvCxPcH3buhIEbg+aFHeTweKoJ7QNnNWMvkHp8Z6WHBSsKEzn/2Io8CQMEr
	qkZYqbzqUwsLBtshG1fUCAgne+kGSMT5YFQM+f48gJAZMIdvVmzlNbjEVpk8WKz1ACLdE4RpkwaeT
	YGn90sIUmqn6crSqWg/bOS7LP9vW+WpvzCvgzfA1fEPjDfXr1uODYHgzke/gzKSBSt1gkN0T1FzUq
	gICzfJHMbsW7itZeyJagAR1ecf2HYxbhTCvpa8OQQTwTuVSKqbXnYoJF1p6OA6bYVQEXhXSCRbTkD
	DOPl0Q/4eVMTxM4Tz9TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qi8An-00Eakm-2V;
	Mon, 18 Sep 2023 06:55:57 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qi8Ai-00Eajd-38
	for kexec@lists.infradead.org;
	Mon, 18 Sep 2023 06:55:54 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382323764"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="382323764"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695417720"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695417720"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:55:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andy@kernel.org>)
	id 1qi8AI-0000000DVlr-18aJ;
	Mon, 18 Sep 2023 09:55:26 +0300
Date: Mon, 18 Sep 2023 09:55:25 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Siddh Raman Pant <code@siddh.me>,
	Nick Alcock <nick.alcock@oracle.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Zack Rusin <zackr@vmware.com>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
	David Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Message-ID: <ZQf0XfrKiwhvkxum@smile.fi.intel.com>
References: <cover.1694202430.git.pstanner@redhat.com>
 <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
 <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230917_235553_073746_B2E4BB63 
X-CRM114-Status: GOOD (  15.07  )
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

On Sat, Sep 16, 2023 at 05:32:42PM +0300, Dan Carpenter wrote:
> On Fri, Sep 08, 2023 at 09:59:40PM +0200, Philipp Stanner wrote:

...

> > +static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
> > +{
> > +	size_t nbytes;
> > +
> > +	if (unlikely(check_mul_overflow(n, size, &nbytes)))
> > +		return ERR_PTR(-EOVERFLOW);
> 
> No need for an unlikely() because check_mul_overflow() already has one
> inside.

Makes sense.

> I feel like -ENOMEM is more traditional but I doubt anyone/userspace
> cares.

ENOMEM is good for the real allocation calls, here is not the one (the one is
below). Hence ENOMEM is not good candidate above. And whenever functions returns
an error pointer the caller must not assume that it will be only ENOMEM for
allocators.

> > +	return memdup_user(src, nbytes);
> > +}

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

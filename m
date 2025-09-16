Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B52CAC598
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dzUzS+kHI5Z0ZUp6XUgy9wSwtWU+3YVQiw8hkVgXRRE=; b=SutjcIGZRDdaI+oAfAfOX6AYGU
	CjoAuJCMBeHFVCqgsvEg6Tg0Yx/70MBlFKP9R89tpfc7rdotAKFbg+9CIcj2eINZPrnZFRMnL33v1
	Id4RF1IK1by8Bmz1+mjK1QPRzzOtgwmwlyp7c/QZMfkdrRUdeurfK+5/HNNRi0Y9UoeFtOhOLXlLL
	j92eD4jMEXegE11wkxSKaQqfdyJBSH19gKwHqqW/iGIlBwWsbHN145Qc07STPulZ80kLbXPAgCuMf
	Kv8Tu4JcqYvYn0HrHuSBtHHjz5XI+sJ0wJLBfaJ8Cpm+nGTpRq895pYqQrsP/tpU7tkzsdhwX7DWD
	B5rg7bog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyUjo-00000007lgi-0MRO;
	Tue, 16 Sep 2025 12:24:48 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyUjm-00000007lff-1Kyf
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 12:24:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758025487; x=1789561487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ID/SUPHO379yH7YmVkyZCjkRQuJKKK5YrFKRKXZY9gQ=;
  b=fKZNRfcQEd+qCxMeKmx0gHKnJDZNE0q31v8BAanZEncgCzelMSO9Rp+w
   N06e5rTQ+t3Usw1p60UuTedkpJX7OnELJidCNswUzSYmqrTavQd3e5nYd
   FXqySozzqJduVWL13UnUTPHZaJ/6Y4N9woXMhRv2/2+1Vx2AhpNMVJZTb
   wAXiQyoGvU6RMD1wB5HwQeKT3SfkKEzNwx3fx3C9Big2x98LszmwrVkzF
   VjUu7CYxaKhvAdBEmQprX8uVlkSbQz9FMeMApZ3JiovNjMNdr6yE4u71S
   GBUMphqeza5ihQp/wab9DLVpOx2HCVn4MuuWCq4x9H9uyYY2a/O824E5+
   A==;
X-CSE-ConnectionGUID: 2TxF5p1SSOO322f41PUTHA==
X-CSE-MsgGUID: 1MIcNA20T4W5V4/1fmBIrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="63935526"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="63935526"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:24:46 -0700
X-CSE-ConnectionGUID: DFEXcNlxSwGShB5ye47W8g==
X-CSE-MsgGUID: SUlbrvTVQLiXVdPiJyRWPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174864948"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:24:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyUjg-00000003WU9-2wPR;
	Tue, 16 Sep 2025 15:24:40 +0300
Date: Tue, 16 Sep 2025 15:24:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aMlXCODJ4SqS_Bci@smile.fi.intel.com>
References: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>
 <20250915221436.GA925462@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915221436.GA925462@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_052446_425637_6A387D6E 
X-CRM114-Status: GOOD (  17.37  )
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

On Mon, Sep 15, 2025 at 03:14:36PM -0700, Nathan Chancellor wrote:
> Hi Andy,
> 
> On Mon, Sep 15, 2025 at 05:55:43PM +0200, Andy Shevchenko wrote:
> > clang is not happy about set but unused variable:
> > 
> > kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
> >   745 |         unsigned long maddr;
> >       |                       ^
> > 1 error generated.
> > 
> > Fix the compilation breakage (`make W=1` build) by removing unused variable.
> > 
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> 
> I don't think this fixes tag is right. maddr definitely looks used in
> that diff. I think it is a follow up simplification that introduces
> this.
> 
> Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")

Oh, you are right!

> Otherwise, this patch looks correct to me and GCC 16 will warn on this
> as well.
> 
>   kernel/kexec_core.c: In function 'kimage_load_cma_segment':
>   kernel/kexec_core.c:745:23: error: variable 'maddr' set but not used [-Werror=unused-but-set-variable=]
>     745 |         unsigned long maddr;
>         |                       ^~~~~

I'll add this as well to the commit message (in shorter form).

> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thank you! I'm going to send a v2 soon.

-- 
With Best Regards,
Andy Shevchenko




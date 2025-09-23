Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F01CAC5AC
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X3tx+fZ731hStR3QwB8Vwr+fatNxOU7DCvOysaUDqs0=; b=QwT4hdM/lIfMKa4INirDJFtfhM
	Q0+HDgwFcamyMEFkw7dGdqaa+iCLGMlubRiOoYi5EPssmFdFgpcpI2bnsUGvhcFwiXKNHmm+ggDkj
	4d+NVmtgeYwmp2traG0qqkIYywIwZMr/rGCvgkSbo1Gu4FwJCvohwFUBTf+y+G5JfuGwYIwoiHH7s
	NFkMDolK0WtbHtGio5RX3t/i/uNQ8XXLwkhoiXQSKiEgdVwD8viDXjTfZUmvSlyc1qdycs1GuI+tq
	TXu8wz9zHzpw7U4wo62enLLvNSrukmvTzYN2/Fr/zUfbyiKscjGd9BicyOFlInLPdqNr0FODCct7L
	zwe6H+pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v17AR-0000000ET2Q-171D;
	Tue, 23 Sep 2025 17:51:07 +0000
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com ([35.155.198.111])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v17AL-0000000ESvj-2DbP
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 17:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758649861; x=1790185861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3tx+fZ731hStR3QwB8Vwr+fatNxOU7DCvOysaUDqs0=;
  b=ElkO3lfH+fs7+vze2TEL5m8RjCu3ymS6EAZkBuzWNAzEGmoQMuMSRKo6
   N2uBXe++899BQdFJiYU+MzAReLP+mYdl5uxkysk2X9TXqwWrHBtomTX/4
   XWwioPjoJZCZYVF+vj22PHqRyrbvtw52h936Q/rsWQaUDW4UfDcmfiI+O
   c0vECNJWzBavRYXFYYzNtIvsUTeIg/F/Ncqfr58XNC7WWwVin3i/c682/
   t9f9ufy7rSgFQ6ikh2+38QbuTk61ZjpaSWSRSYus4lDeSvG1vyuTIaSlQ
   C+KNXWpqs1Nli966baMSQlZUiL3Esps7Puq81jy0213QFZRlnwVyjFDo0
   w==;
X-CSE-ConnectionGUID: lwCl1RWXT+aKK2oadLaBiA==
X-CSE-MsgGUID: 475HWfd+TQehZxD0e1rLsQ==
X-IronPort-AV: E=Sophos;i="6.18,288,1751241600"; 
   d="scan'208";a="3480840"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 17:50:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:47695]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.121:2525] with esmtp (Farcaster)
 id 3a68c820-3ea0-4f05-bb30-09be8ba4b876; Tue, 23 Sep 2025 17:50:58 +0000 (UTC)
X-Farcaster-Flow-ID: 3a68c820-3ea0-4f05-bb30-09be8ba4b876
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 17:50:58 +0000
Received: from 80a9970eed1e (10.106.101.9) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 23 Sep 2025
 17:50:57 +0000
Date: Tue, 23 Sep 2025 10:50:55 -0700
From: Justinien Bouron <jbouron@amazon.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, Justinien Bouron <jbouron@amazon.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aNLd_6CO6YMvm2MN@80a9970eed1e>
References: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
X-Editor: VIM - Vi IMproved 9.1
X-Originating-IP: [10.106.101.9]
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_105101_673556_C6078DD5 
X-CRM114-Status: GOOD (  24.79  )
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

On Tue, Sep 16, 2025 at 02:51:09PM +0200, Andy Shevchenko wrote:
> clang is not happy about set but unused variable:
> 
> kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
>   745 |         unsigned long maddr;
>       |                       ^
> 1 error generated.
> 
> Fix the compilation breakage (`make W=1` build) by removing unused variable.
> 
> As Nathan noted, GCC 16 produces the similar warning;
> 
> Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
FYI the commit this patch is fixing (i.e. f4fecb50d6e1) is going to need a
second revision as well (I haven't submitted it yet, still working on it), this
means that your "Fixes:" tag will need to be changed again, requiring a 3rd
revision.

I am not sure what is the proper way forward here. Should I:
    - Send my v2, without fixing the unused variable and then you send your v3
      with the updated "Fixes:" tag pointing to my v2.
    - OR fixing the unused variable in my v2 (i.e. "absorb" this patch in my
      v2).
In the latter case, I am not sure how I am supposed to credit the work in this
case? Do I need to add another "Signed-off-by: Andy Shevchenko" besides mine?

I'm still learning the ropes on how to contribute through the mailing list so I
would be grateful if you could share your input on what's the proper way forward
here.

Best,
Justinien
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: fixed Fixes (Nathan), added a note about GCC (Nathan), added tag (Nathan)
> 
>  kernel/kexec_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5357ed39e9d1..32722926bc7e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -742,7 +742,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  	struct kexec_segment *segment = &image->segment[idx];
>  	struct page *cma = image->segment_cma[idx];
>  	char *ptr = page_address(cma);
> -	unsigned long maddr;
>  	size_t ubytes, mbytes;
>  	int result = 0;
>  	unsigned char __user *buf = NULL;
> @@ -754,7 +753,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		buf = segment->buf;
>  	ubytes = segment->bufsz;
>  	mbytes = segment->memsz;
> -	maddr = segment->mem;
>  
>  	/* Then copy from source buffer to the CMA one */
>  	while (mbytes) {
> @@ -782,7 +780,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		}
>  
>  		ptr    += mchunk;
> -		maddr  += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.50.1
> 


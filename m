Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EEECCD1BF
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDN+ThyNVQ8b/2Ptq1WNLoggDamDN4huotNCUsgtnek=; b=KEbcLli2BcQE8AqTZagpdo5Hyg
	faygIXAZo4mO1vJ34klXbq/A4HFamP1WDXD3dMAQnA29W7xwJINNP6qVYYCammJXKCEoYUw5zjNM+
	honOAQfxTkoJDZnElyO1QzJxWwk0TiqVUtOqylq6N+UFNxZionHzbWey6CzijViNmUBaRIodNpTrc
	GsWZHzsEmicvxxRXnReP9Dp+s08repEJMvNfbbFNE2k8pHmShYePxQdVYBiEchHJRoLUWGkjBIfk2
	elp2cehbdCgwrE0iYHJuTU0tW+cXrTW82bOJ739W0SRStMJZ619xDyp3VqdJjcMQ1OixjCZ9pebhn
	RupNen6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCJtQ-00000009pVn-36tO;
	Fri, 24 Oct 2025 15:39:52 +0000
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com ([35.155.198.111])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCJtN-00000009pVA-3uZ9
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 15:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761320389; x=1792856389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zDN+ThyNVQ8b/2Ptq1WNLoggDamDN4huotNCUsgtnek=;
  b=qW6wPj/9uno9OvFSw840PgQANMQHYt3s8sHvbW9npx6u2iSykUGopprY
   4iuG/XcoN3t99GkGVNCUHcJe7aFkex9iVJDk/5VDQ+udMmwE8wUox68Hu
   iUWJ5+CsbRp0VNiB1TVFW9/S7sScCL3VBfY60asd5SWaJFr4C0Jl9PfAR
   plYhwPemF2iSB9gMfORyywatSYwjzR/Cz3TAkdkMjzTPlDMkfEpDlAfmq
   ZO04YAFjfrrNLPoVaupFDUGvSIE6HqUMWerxa5aF3zmZdHbftXZSkN7mc
   bUW6itHwyKPxNwyKGYj5280tSxRQFWPYNI9EVFN4vviBejAIVn6snNCsR
   A==;
X-CSE-ConnectionGUID: qqWwwP/4SwSMIBSg1EtjKw==
X-CSE-MsgGUID: X0SsnNokSRSfbA1joNAaOA==
X-IronPort-AV: E=Sophos;i="6.19,252,1754956800"; 
   d="scan'208";a="5538092"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:39:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:17502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 180f7de7-0d90-40fe-924f-05c3a8e95183; Fri, 24 Oct 2025 15:39:46 +0000 (UTC)
X-Farcaster-Flow-ID: 180f7de7-0d90-40fe-924f-05c3a8e95183
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 24 Oct 2025 15:39:44 +0000
Received: from 80a9970eed1e (10.106.100.47) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 24 Oct 2025
 15:39:42 +0000
Date: Fri, 24 Oct 2025 08:39:40 -0700
From: Justinien Bouron <jbouron@amazon.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aPudvI4dQnvgOKBd@80a9970eed1e>
References: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
 <aNLd_6CO6YMvm2MN@80a9970eed1e>
 <aO1lmNyLCVUhL_kO@smile.fi.intel.com>
 <aPt5CYz5Cc-7St6L@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPt5CYz5Cc-7St6L@black.igk.intel.com>
X-Editor: VIM - Vi IMproved 9.1
X-Originating-IP: [10.106.100.47]
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_083950_022258_E946B90D 
X-CRM114-Status: GOOD (  30.84  )
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

On Fri, Oct 24, 2025 at 03:03:05PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 13, 2025 at 11:48:24PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 23, 2025 at 10:50:55AM -0700, Justinien Bouron wrote:
> > > On Tue, Sep 16, 2025 at 02:51:09PM +0200, Andy Shevchenko wrote:
> > > > clang is not happy about set but unused variable:
> > > > 
> > > > kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
> > > >   745 |         unsigned long maddr;
> > > >       |                       ^
> > > > 1 error generated.
> > > > 
> > > > Fix the compilation breakage (`make W=1` build) by removing unused variable.
> > > > 
> > > > As Nathan noted, GCC 16 produces the similar warning;
> > > > 
> > > > Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
> > > FYI the commit this patch is fixing (i.e. f4fecb50d6e1) is going to need a
> > > second revision as well (I haven't submitted it yet, still working on it), this
> > > means that your "Fixes:" tag will need to be changed again, requiring a 3rd
> > > revision.
> > > 
> > > I am not sure what is the proper way forward here. Should I:
> > >     - Send my v2, without fixing the unused variable and then you send your v3
> > >       with the updated "Fixes:" tag pointing to my v2.
> > >     - OR fixing the unused variable in my v2 (i.e. "absorb" this patch in my
> > >       v2).
> > 
> > Second is the best (integrate this fix into yours v2).
> > 
> > > In the latter case, I am not sure how I am supposed to credit the work in this
> > > case? Do I need to add another "Signed-off-by: Andy Shevchenko" besides mine?
> > 
> > Just in the comment block (after the cutter '---' line and before the diff) in
> > a free words. No need for any special tags for this in such a case.
> > 
> > > I'm still learning the ropes on how to contribute through the mailing list so I
> > > would be grateful if you could share your input on what's the proper way forward
> > > here.
> 
> Any news, folks, please? The bug is still in Linux Next and prevents me from
> building my stuff cleanly.
I am working on sending the V3 as we speak, sorry for the delay.

Best,
Justinien Bouron
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


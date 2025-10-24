Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B4CCCF9E3
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZLvMMGLPrwC4lG+ycq2alCZKKK/dEl3bx8H9eEFcpQ=; b=eH2YfcQN3PSExfmQRBL6/M/RBk
	yu/wyTI8Thyhb20LU+EJWfiKPcsbkIX+B4h28mzdihaH6793v131nAG1huQmqhF92LaOh15WLDbtp
	a7knhH+jkoyA60Eve55C9Oz37GTVo2HcpHu0yYXSEgWIphlkNfpMcB1/MxVoz9LhnKhS2hOIA93aM
	B5z6kh8Xbv7skP28sXwxXAUrlwSuocjr0Mz2HzT2oyPT8g7YR+SnLWUm7I+wdst550L6H2jYRXUbk
	pHYGufJEPUOia2T0zqX++1ZygitF4prpvoxHAqIGYQ6rDw7HUuT/4uKLTZIyLZAMd60hgho3axgYZ
	a7czPQ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCK5e-00000009rj2-1PsL;
	Fri, 24 Oct 2025 15:52:30 +0000
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com ([35.162.73.231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCK5Y-00000009rh2-36w6
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 15:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761321144; x=1792857144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZLvMMGLPrwC4lG+ycq2alCZKKK/dEl3bx8H9eEFcpQ=;
  b=bX0xYGFPzWFNCzc8jKs9VocTqpbErsVr34acta22q39MsJEWQVRnpUT7
   Rvt0BzIgiicA+1uIDAUopmYD5kfSW9QBhc+IZTiKwDWYwB04yWHBRKGDB
   aYzuzFJltoL3q7tIvs4wMBRAhNk3mOaPgCOxHZswBTpgMm2WSgsxw1ZwS
   NNhC/xwHv3p+L/FHLON+Yixsxk8k1E7krW9STO5xHm/TBR96vOX2LEnwI
   TrBvdV3yYf475J22lAk8p17BpZZEulseE9FUfikKRL47shMaDSzC8mn5W
   l3Uglf+069NGgyRijRqoJmPWwDFb+2Bs5k/b+AnK02dwS/+eXJA/HUgO2
   Q==;
X-CSE-ConnectionGUID: qBwoSCLaRMeOl+2TB46dNQ==
X-CSE-MsgGUID: 4n+btcNcT8uXKFNToDW02Q==
X-IronPort-AV: E=Sophos;i="6.19,252,1754956800"; 
   d="scan'208";a="5464797"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:52:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:15943]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.61:2525] with esmtp (Farcaster)
 id ccefef81-52eb-42be-b5ad-d91f33391713; Fri, 24 Oct 2025 15:52:20 +0000 (UTC)
X-Farcaster-Flow-ID: ccefef81-52eb-42be-b5ad-d91f33391713
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 24 Oct 2025 15:52:20 +0000
Received: from 80a9970eed1e (10.106.100.47) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 24 Oct 2025
 15:52:19 +0000
Date: Fri, 24 Oct 2025 08:52:17 -0700
From: Justinien Bouron <jbouron@amazon.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aPugsWImYm0Vj7Dk@80a9970eed1e>
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
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_085225_011634_6BEC981E 
X-CRM114-Status: GOOD (  29.85  )
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
V3 is up: https://lore.kernel.org/lkml/20251024155009.39502-1-jbouron@amazon.com/

Best,
Justinien Bouron
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


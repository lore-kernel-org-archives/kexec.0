Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65DCF8D761
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EoN1CWGLCZOdklUYrgE5XBMTZqfsWrhlj/7/48ef/xg=; b=xm34vZrdKak/LsPn2jJxELBaJq
	PQoFnAgQhYgUeeOkB6PHNUSS2aShY9divZH8VEzRE7vezJhgSTVi1bUbqY6s903rBZPQfxjiF52oA
	Y5O1+18LeUF9KKZ+OumIL3bOiZup1YZIpwI/CudFbUm3HLsvmmkz2iuV2u6hoRc3meSeywovwX7xC
	m9WCdXX8kiFvlCp7wprBtaNm8x+wJ0U3hIDC9gbtOHD2Ct/KkE6WnZv61HO8jrnNTZaF57zowlTDJ
	ZMpJvCoIRj54XtV5u7+neFPcT9/qJ+v2rmw123q5iTzx+OPe1+W01PH2PAvS5UQ0oIj06s3oY7zQS
	kgqbt73Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDPPi-00000002ex3-2hcO;
	Thu, 16 Apr 2026 16:17:58 +0000
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com ([50.112.246.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDPPf-00000002ewe-2rCC
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 16:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1776356275; x=1807892275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EoN1CWGLCZOdklUYrgE5XBMTZqfsWrhlj/7/48ef/xg=;
  b=AcbsxqGfwLRiBziMSWY/u5/3524XbLDXHDOTV7IFBiPo1jpmmnaUtppS
   V0Ec+3VkgT2GqRy3r3DlZuMkuksdkv/RjFDcS3AVu7po+fcPCZrwLx6BR
   E/3XZMZVCrmU/GHrtAq2X9zvIWJ+6/lNBEf7jnkG+oatOzcgVOKZSJ2mS
   KSsydvOO1XGl+0r8MVU/5cG72Qur3bs0hmSgTvVHaFLLWbAfZu25Y4vEa
   0fqhumi4qbYWjOu8UG6VKys8pCZUGuc9fSaIySqExXFe+hzkz6vrKw8Xr
   2zvqc1m96qexcvECRc5CkBfpR1bEThUqIBu6lGqrIFAa4cq6q9V1bUZMW
   A==;
X-CSE-ConnectionGUID: x4INR6wCRPuVGINf1EHiAw==
X-CSE-MsgGUID: 11m9AFWQQMqcMoYGCg4QbQ==
X-IronPort-AV: E=Sophos;i="6.23,181,1770595200"; 
   d="scan'208";a="17298797"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 16:17:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:2261]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.173:2525] with esmtp (Farcaster)
 id 8e1c12c2-e53f-4a55-8a68-57cfbc2e1bde; Thu, 16 Apr 2026 16:17:49 +0000 (UTC)
X-Farcaster-Flow-ID: 8e1c12c2-e53f-4a55-8a68-57cfbc2e1bde
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 16 Apr 2026 16:17:48 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 16 Apr 2026
 16:17:46 +0000
Date: Thu, 16 Apr 2026 16:17:44 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Pratyush Yadav <pratyush@kernel.org>
CC: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Alexander Graf
	<graf@amazon.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Changyuan Lyu
	<changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH v2] kho: skip KHO for crash kernel
Message-ID: <20260416161744.GA65710@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
References: <20260410011609.1103-1-epetron@amazon.de>
 <2vxztstf7ys7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2vxztstf7ys7.fsf@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_091755_860587_64C2FA9E 
X-CRM114-Status: GOOD (  36.50  )
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

On Mon, Apr 13, 2026 at 01:52:40PM +0000 Pratyush Yadav wrote:
> Hi Evangelos,
> 
> On Fri, Apr 10 2026, Evangelos Petrongonas wrote:
> 
> > kho_fill_kimage() unconditionally populates the kimage with KHO
> > metadata for every kexec image type. When the image is a crash kernel,
> > this can be problematic as the crash kernel can run in a small reserved
> > region and the KHO scratch areas can sit outside it.
> > The crash kernel then faults during kho_memory_init() when it
> > tries phys_to_virt() on the KHO FDT address:
> >
> >   Unable to handle kernel paging request at virtual address xxxxxxxx
> >   ...
> >     fdt_offset_ptr+...
> >     fdt_check_node_offset_+...
> >     fdt_first_property_offset+...
> >     fdt_get_property_namelen_+...
> >     fdt_getprop+...
> >     kho_memory_init+...
> >     mm_core_init+...
> >     start_kernel+...
> >
> > kho_locate_mem_hole() already skips KHO logic for KEXEC_TYPE_CRASH
> > images, but kho_fill_kimage() was missing the same guard. As
> > kho_fill_kimage() is the single point that populates image->kho.fdt
> > and image->kho.scratch, fixing it here is sufficient for both arm64
> > and x86 as the FDT and boot_params path are bailing out when these
> > fields are unset.
> >
> > Fixes: d7255959b69a ("kho: allow kexec load before KHO finalization")
> > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > ---
> >
> > v2: Per Mike's review [1], move the guard into kho_fill_kimage() instead
> >     of patching the arch-level producers and consumers. This fixes
> >     both arm64 and x86 in one place and avoids redundant checks. Tested again.
> >
> > Note regarding backporting
> > The offending commit was deployed with 6.19. The only other supported
> > kernel version with 6.18, unless I miss someting uses
> > ```
> > if (!kho_out.finalized)
> > ```
> > which in the case of crash kernel it shouldn't be finalised.
> 
> While normally you should load the crash kernel early in boot and at
> that point KHO should not be finalized, I don't see anything that
> prevents crash kernel from being loaded after finalize. In which case,
> you can trigger this bug before d7255959b69a ("kho: allow kexec load
> before KHO finalization") as well. Also, before f322a97aeb2a ("kho: only
> fill kimage if KHO is finalized") (landed in v6.18) kho_fill_kimage()
> was also guarded by if (!kho_enable). So you'd hit this bug in all
> kernels before that point in the very same way as today.
> 
> So should we update Fixes to 3bdecc3c93f9 ("kexec: add KHO support to
> kexec file loads") and Cc stable?
> 
But in this case it seems a userspace misuse if it finalizes kho for
crash kernel. Whereas with the current state we hit the bug with a sane
userspace. Yeap we would hit that in earlier kernel than 6.18, but none
with KHO is supported is it?

I don't have strong objection for backporting it to 6.18, but it feels
unnecessary. 
> >
> > [1] https://lore.kernel.org/all/ade2ExpM8ROXV-vy@kernel.org/
> >
> >  kernel/liveupdate/kexec_handover.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index cc68a3692905..1029fe8778f2 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -1551,7 +1551,7 @@ int kho_fill_kimage(struct kimage *image)
> >  	int err = 0;
> >  	struct kexec_buf scratch;
> >  
> > -	if (!kho_enable)
> > +	if (!kho_enable || image->type == KEXEC_TYPE_CRASH)
> >  		return 0;
> >  
> >  	image->kho.fdt = virt_to_phys(kho_out.fdt);
> 
> -- 
> Regards,
> Pratyush Yadav

Kind Regards,
Evangelos



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



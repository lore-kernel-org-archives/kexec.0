Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFD6F364B2
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HrytP8IlU1zcnz3KNtUwmivDgViJtRjefBb3Lu7mQ2M=; b=qfz3PoeDFbnD0FKX37v2JPbNND
	tngfRCtj5wSrdHMOdMKINgSNe7noHcnz7NNFHm4zUNLgjVasWPsYopemFSOrv+AY89HijIAkS0nib
	pypGoVnrt7OxOIPUJmJYOb8GV6f1XTojTKoyCLpxNd/l9hoSOp+ngHfT+Q+UfZxK+r25F6uP618gQ
	l3Jgz5cxuHPSHXOXq7Y2nZiVkfZ5dWRLw0WhdY8i9SWKCjlYbl1A0Z9/TqQS/sNKqLEHhxE3u+M1s
	rWM6hadm8T5iEjo5BDixODikNQjSVp8MXCIQNmT4I5RCuIwI50XRlnzNYr+BMHFpncOcukeuv6aMy
	f/BvyNRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAuTJ-0000000B7DU-0TS7;
	Thu, 09 Apr 2026 18:51:21 +0000
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.1.125])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAuTF-0000000B7Cr-3wyt
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 18:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775760677; x=1807296677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HrytP8IlU1zcnz3KNtUwmivDgViJtRjefBb3Lu7mQ2M=;
  b=EhGU7CNGFKxoa6H/cIHaLgnycd7/NvV4zHEQVHyvYq2s/AGYSGuP4aM2
   Ai2W34Og9A1pYl5qWO5f3NUDktIWzhW2ro4hoaNFr3/1OLja8GKBJ0C7J
   F4h1QPIM1/tMvU93/tbZgr3/0vqMacQluhtf67wuoI94yUy2QzYtGgrz2
   2gv8ysZSaJFWmq73klMfFA8wBZ8T8wh0yu7fDNg7eD9M8yB/lFvqW/UYq
   6CaBhs4y/rzH/PL+aEb9CoCAjn8vBV0DJt2h2ZehiKYMUMbMLqm9Rmvxm
   PC5Dtb7uoT4/EIaUMXl4qybxAdpi9rA9ABejyF8dXmRxHd9snsx4Nxgxb
   A==;
X-CSE-ConnectionGUID: /VYPa2h5RAKD6+SZdMGPJg==
X-CSE-MsgGUID: rSvJMwIbSpSENj2cE02f5g==
X-IronPort-AV: E=Sophos;i="6.23,170,1770595200"; 
   d="scan'208";a="16952641"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 18:51:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:15277]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.233:2525] with esmtp (Farcaster)
 id 79311853-5cd8-4807-beb1-7c2687e50223; Thu, 9 Apr 2026 18:51:11 +0000 (UTC)
X-Farcaster-Flow-ID: 79311853-5cd8-4807-beb1-7c2687e50223
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 9 Apr 2026 18:51:09 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 9 Apr 2026
 18:51:07 +0000
Date: Thu, 9 Apr 2026 18:51:04 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav
	<pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH] of: fdt: skip KHO when booting as crash kernel
Message-ID: <20260409185104.GA74321@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
References: <20260407150639.69923-1-epetron@amazon.de>
 <ade2ExpM8ROXV-vy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ade2ExpM8ROXV-vy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_115118_056744_0AFE2D03 
X-CRM114-Status: GOOD (  20.35  )
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

On Thu, Apr 09, 2026 at 05:22:11PM +0300 Mike Rapoport wrote:
> Hi Evangelos,
> 
> On Tue, Apr 07, 2026 at 03:06:33PM +0000, Evangelos Petrongonas wrote:
> What about x86? ;-)
>

Well... I was planning to reply with "we will sort it out in a followup".
I have a suspicion though, that you knew that the kho_fill_kimage()
approach would take care of it. Nice! Thanks for the tip.
I will post soon the v2.

> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 43a0944ca462..77018ec99fc8 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -926,6 +926,9 @@ static void __init early_init_dt_check_kho(void)
> >  	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
> >  		return;
> >  
> > +	if (is_kdump_kernel())
> > +		return;
> > +
> 
> This seems redundant if don't add KHO nodes at the first place.
> 
Indeed it is, it was more of a defense in depth in case there were stale
data somehow, but I will drop it in v2.

> >  	if (!of_flat_dt_get_addr_size(node, "linux,kho-fdt",
> >  				      &fdt_start, &fdt_size))
> >  		return;
> > diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> > index c4cf3552c018..b95f0b386684 100644
> > --- a/drivers/of/kexec.c
> > +++ b/drivers/of/kexec.c
> > @@ -271,7 +271,8 @@ static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node
> >  	if (ret && ret != -FDT_ERR_NOTFOUND)
> >  		return ret;
> >  
> > -	if (!image->kho.fdt || !image->kho.scratch)
> > +	if (!image->kho.fdt || !image->kho.scratch ||
> > +	    image->type == KEXEC_TYPE_CRASH)
> >  		return 0;
> >  
> >  	fdt_mem = image->kho.fdt;
> 
> kho_add_chosen() bails out if there's no KHO buffer in kimage, so if
> kho_fill_kimage won't add KHO buffer to kexec_crash_image it should be
> enough.
> 
Indeed, one guard to rule them all. Much more elegant than the
"let's sprinkle checks everywhere (apart from x86))" approach.

> > -- 
> > 2.43.0
> > 
> > 
> > 
> > 
> > Amazon Web Services Development Center Germany GmbH
> > Tamara-Danz-Str. 13
> > 10243 Berlin
> > Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> > Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> > Sitz: Berlin
> > Ust-ID: DE 365 538 597
> > 
> 
> -- 
> Sincerely yours,
> Mike.

Kind Regards,
Evangelos



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



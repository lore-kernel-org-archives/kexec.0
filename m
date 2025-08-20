Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B492CA0EE4
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VcUvGNuA3d7yrOnkNCw6tvQdIAkf+02/D+Y78DFw/Ck=; b=0jDk0bssuKxlTjm+N4eiBACb/f
	GDiITHUz5bzCYCYp/k2hFCSjMccXR2IGGQCSb/GVF+gd/dS6VVHgk9zfSbpXCV2qRMqYm0BCAMdI+
	G6rkWmfUGvTR3i09qdqBJkbiM5x9h5/inXLyAnKS3USYLdiMc+SHIk9R9E4kTktg7JUHOKJnkYv1u
	mLvqWr3NVnAAK7DTw2cJbNi/4YWRAPOGuUXauA3uomdGAI+E+EH5ZGlvRiWLE4xlvczvGD+dxHWNl
	SS1N8EqXIT2ClJm7eFj1y3w7qWhzDQadVioNairlbSujRwoMJKnz71Q+PwlopDEpzzhTBtDLfsLXt
	SAc/Sq7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uojtW-0000000E5uU-2JiM;
	Wed, 20 Aug 2025 14:34:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoj6G-0000000DrzZ-4AC5
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 13:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755697415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcUvGNuA3d7yrOnkNCw6tvQdIAkf+02/D+Y78DFw/Ck=;
	b=cwK5AnMW5xmWgPyZBlnI1e9tcV/9VCxevSGUInSbLUrNx/oC5+/o/20O9YlP1dwxqsuP4q
	geQdMbem4zgtsntB5RHj+4MZVypjsjXOqKlehRp58Rj96j4MHdnzYK4z6U3elxEqHKpgdI
	qKzJ/KHSFAG/se76FFcnvegnfMqlQNk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-VHmAvDi2N2eBWQWFQX-ffg-1; Wed,
 20 Aug 2025 09:43:30 -0400
X-MC-Unique: VHmAvDi2N2eBWQWFQX-ffg-1
X-Mimecast-MFC-AGG-ID: VHmAvDi2N2eBWQWFQX-ffg_1755697408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F32D19775B0;
	Wed, 20 Aug 2025 13:43:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72B6019560B4;
	Wed, 20 Aug 2025 13:43:25 +0000 (UTC)
Date: Wed, 20 Aug 2025 21:43:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	namcao@linutronix.de, sravankumarlpu@gmail.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Message-ID: <aKXQ96ZE6yyfUuYq@MiWiFi-R3L-srv>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <aKXPPQ93H/KkxgZh@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXPPQ93H/KkxgZh@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_064337_101455_CBB2A3DF 
X-CRM114-Status: GOOD (  23.73  )
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

On 08/20/25 at 09:35pm, Baoquan He wrote:
> On 08/20/25 at 05:14pm, Jinchao Wang wrote:
> > crash_kexec() had its own code to exclude
> > parallel execution by setting panic_cpu.
> > This is already handled by panic_try_start().
> > 
> > Switch to panic_try_start() to remove the
> > duplication and keep the logic consistent.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  kernel/crash_core.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index a4ef79591eb2..bb38bbaf3a26 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
> >   */
> >  
> > +#include "linux/panic.h"
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <linux/buildid.h>
> > @@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
> >  
> >  __bpf_kfunc void crash_kexec(struct pt_regs *regs)
> >  {
> > -	int old_cpu, this_cpu;
> > -
> > -	/*
> > -	 * Only one CPU is allowed to execute the crash_kexec() code as with
> > -	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> > -	 * may stop each other.  To exclude them, we use panic_cpu here too.
> > -	 */
> > -	old_cpu = PANIC_CPU_INVALID;
> > -	this_cpu = raw_smp_processor_id();
> > -
> > -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> > +	if (panic_try_start()) {
> 
> Seriously, where can I find this panic_try_start() and the
> panic_reset()? 

Ok, just found it's in a patch series. Grabbed the patchset and will
have a look.

> 
> >  		/* This is the 1st CPU which comes here, so go ahead. */
> >  		__crash_kexec(regs);
> >  
> > @@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
> >  		 * Reset panic_cpu to allow another panic()/crash_kexec()
> >  		 * call.
> >  		 */
> > -		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> > +		panic_reset();
> >  	}
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> 



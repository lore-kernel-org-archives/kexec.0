Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8A2C46CD2
	for <kexec@archiver.kernel.org>; Sun, 24 Dec 2023 04:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q4p8rEqL4HfM/aP4PGF53ox+RyR3KOPvTh7v8xw69Z0=; b=uOrgpYHvrrozmd
	Q+T8/DTNNiGoq0uLPaGiXoJ5xszTav9nd14AWskW8dJNoKuoLty3SCeAxAfCOry2oQvRP5j5BnatN
	kRSYjsiBjcoNzTA89c05WHUd/9iPvUxlalxqgLFTp3Fog/nWFUtP1sr3TWhY6gtXsIMgBN9FlFriv
	WeEEE/M3/6rdDEUjMcq/SWXblxaSdC6nro2rSZIe1AJmnZkoMGFQ3cT2lMjE6xiag6n2WXF1Pa+R4
	EldLlEHNDQpAcISlMyyR0RNdDRwP53VpydwBPKEk/eHEu0O3E1IZwHewS3GSBOXk/8wTIPeTJQXMv
	l34dOb95UlBOWBo2rBKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHGNU-008sK1-1i;
	Sun, 24 Dec 2023 04:46:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHGNR-008sIH-0I
	for kexec@lists.infradead.org;
	Sun, 24 Dec 2023 04:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703393169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NfIP5VGXxX0Vbo7RIsC7FRwPJeV44ad3sg3nU9VzDsE=;
	b=ZMIZ8lqmpkEFoMvCnVC63iSllkbJQGbiHTi7TwVGgDhbWvOLcm7mwaGN7u4DpTPicqtoaV
	p3ERBRp6ifn2GYd2wR8PLODLsDAEhAq/LYkVP6hNGSY14/AQR6cR3bUNSUTSWiu9uV9o6O
	quox1CY0/HIQRABSD0TnIxuA9DnYgCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-k0nEAYs9O-mOBrNey4ZvAw-1; Sat, 23 Dec 2023 23:46:05 -0500
X-MC-Unique: k0nEAYs9O-mOBrNey4ZvAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394938339B8;
	Sun, 24 Dec 2023 04:46:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 864A3C15968;
	Sun, 24 Dec 2023 04:46:03 +0000 (UTC)
Date: Sun, 24 Dec 2023 12:46:00 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <ZYe3iN816iiKDwIu@MiWiFi-R3L-srv>
References: <20231222121855.148215-1-fuqiang.wang@easystack.cn>
 <ZYWPHSmwK8iG6xUr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZYWPHSmwK8iG6xUr@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_204613_224481_56FFE3AF 
X-CRM114-Status: GOOD (  30.42  )
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

On 12/22/23 at 09:29pm, Baoquan He wrote:
> On 12/22/23 at 08:18pm, fuqiang wang wrote:
> > In memmap_exclude_ranges(), there will exclude elfheader from
>                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       elfheader will be excluded from crashk_res. OR
>       it will exclude elfheader from crashk_res.
> 
> > crashk_res. In the current x86 architecture code, the elfheader is
> > always allocated at crashk_res.start. It seems that there won't be a
> > split a new range. But it depends on the allocation position of
>  ~~~~~~~~~~~~~~~~~~
>   It seems that there won't be a new split range.
> > elfheader in crashk_res. To avoid potential out of bounds in future, add
> > a extra slot.
> > 
> > The similar issue also exists in fill_up_crash_elf_data(). The range to
> > be excluded is [0, 1M], start (0) is special and will not appear in the
> > middle of existing cmem->ranges[]. But in order to lest the low 1M could
>                                          ~~~~~~~~~~~~~~~~
>                                           in case
> > be changed in the future, add a extra slot too.
> > 
> > Previously discussed link:
> > [1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
> > [2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
> > [3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/
> > 
> > Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> > ---
> >  arch/x86/kernel/crash.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index c92d88680dbf..97d33a6fc4fb 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -149,8 +149,18 @@ static struct crash_mem *fill_up_crash_elf_data(void)
> >  	/*
> >  	 * Exclusion of crash region and/or crashk_low_res may cause
> >  	 * another range split. So add extra two slots here.
> > +	 *
> > +	 * Exclusion of low 1M may not cause another range split, because the
> > +	 * range of exclude is [0, 1M] and the condition for splitting a new
> > +	 * region is that the start, end parameters are both in a certain
> > +	 * existing region in cmem and cannot be equal to existing region's
> > +	 * start or end. Obviously, the start of [0, 1M] cannot meet this
> > +	 * condition.
> > +	 *
> > +	 * But in order to lest the low 1M could be changed in the future,
> > +	 * (e.g. [stare, 1M]), add a extra slot.


Rethink about this, seems above code comment is fine to be kept, and the 
same feeling about the elfheader region split from crashk_res. So, other
than the patch log concerns, this patch looks good to me. Let's see if
other people has concern about the newly added comments.

> 
> Sometime, too much is as bad as too little. I feel below words are
> enough to state three regions are gonna be excluded, and may cause
> another split (may not cause). The code comment plus commit log can help
> people know why they are needed.
> 
>   	 * Exclusion of low1M, crashk_res and/or crashk_low_res may cause
>   	 * another range split. So add extra three slots here.
> 
> >  	 */
> > -	nr_ranges += 2;
> > +	nr_ranges += 3;
> >  	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> >  	if (!cmem)
> >  		return NULL;
> > @@ -282,9 +292,16 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
> >  	struct crash_memmap_data cmd;
> >  	struct crash_mem *cmem;
> >  
> > -	cmem = vzalloc(struct_size(cmem, ranges, 1));
> > +	/*
> > +	 * In the current x86 architecture code, the elfheader is always
> > +	 * allocated at crashk_res.start. But it depends on the allocation
> > +	 * position of elfheader in crashk_res. To avoid potential out of
> > +	 * bounds in future, add a extra slot.
> > +	 */
> 
> Ditto.
> 
>  +	/*
>  +	 * Elfheader gonna be excluded from crashk_res, to avoid potential
>  +	 * out of bounds, add one extra slot.
>  +	 */
> 
> > +	cmem = vzalloc(struct_size(cmem, ranges, 2));
> >  	if (!cmem)
> >  		return -ENOMEM;
> > +	cmem->max_nr_ranges = 2;
> >  
> >  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
> >  	cmd.params = params;
> > -- 
> > 2.42.0
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

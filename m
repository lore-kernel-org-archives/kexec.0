Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFE6C87FD3
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0UiEs4Rh6Bq7jrDzS2r+cL0UHOZ82z9RlYdz/rMI4Q=; b=ft9Zaq16cs8480TqOp4Jy49GEq
	9vakkhJqICI1mVfA0ROdjmHbhZ46taVP9CrKqZcgZEFX06jHGmc+FWzA6Ctb4VeX15u2b1Wrw6t52
	UC/i4xyU19m3CPp9HzgGhAjDf9znWBvMgZgFhaJfsb02XXLtPgsUhZtJlpJBHpJWGznEukdz5cy7z
	dgm02fNKD+1LwGp7xgMlbtrmmQxRq9+OnOoZPeal2pFFo8xDqGUy1nG0dKnfw5fZ/AO/f381x80nc
	d5ZnhFinnmFePL7fThfBrwiAVK/JG14IjAUfQBdlDuMrYvaSSsG5Pamr03EBsG912CPKrb1w3xSVu
	Netf08ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMuq-00000002taK-3Pac;
	Fri, 08 Aug 2025 13:13:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMpz-00000002sj3-2VEz
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 13:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754658526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0UiEs4Rh6Bq7jrDzS2r+cL0UHOZ82z9RlYdz/rMI4Q=;
	b=hZGMcfrFmRxKog8HN1dBv62CVEg1t7SP+G1oUBmyF4zIqsAf05eb3JHq7g7WA416ph+FyV
	egiNg9BJ25auBxWQodvMwTZ95LFY+FzBeGslFK/yl9pPnLCOv5qRguvO2oPxuPDdwo/z5p
	DiA0sWDkCDnr0i9b4lLKCzfAurBv34M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-46aA9S8HOqitMnE-iqR_lg-1; Fri,
 08 Aug 2025 09:08:44 -0400
X-MC-Unique: 46aA9S8HOqitMnE-iqR_lg-1
X-Mimecast-MFC-AGG-ID: 46aA9S8HOqitMnE-iqR_lg_1754658522
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A801956086;
	Fri,  8 Aug 2025 13:08:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A81B19560AD;
	Fri,  8 Aug 2025 13:08:39 +0000 (UTC)
Date: Fri, 8 Aug 2025 21:08:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJX20/iccc/LL42B@MiWiFi-R3L-srv>
References: <20250805062333.121553-5-bhe@redhat.com>
 <20250806052231.619715-1-sj@kernel.org>
 <9ca2790c-1214-47a0-abdc-212ee3ea5e18@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca2790c-1214-47a0-abdc-212ee3ea5e18@lucifer.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_060847_717758_52AD9C61 
X-CRM114-Status: GOOD (  25.28  )
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

On 08/06/25 at 05:26pm, Lorenzo Stoakes wrote:
> On Tue, Aug 05, 2025 at 10:22:31PM -0700, SeongJae Park wrote:
> > Hello Baoqua,
> >
> > On Tue,  5 Aug 2025 14:23:33 +0800 Baoquan He <bhe@redhat.com> wrote:
> >
> > > Now everything is ready, set kasan=off can disable kasan for all
> > > three modes.
> > >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  include/linux/kasan-enabled.h | 11 +----------
> > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > > index 32f2d19f599f..b5857e15ef14 100644
> > > --- a/include/linux/kasan-enabled.h
> > > +++ b/include/linux/kasan-enabled.h
> > > @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
> > >
> > >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> > >
> > > -#ifdef CONFIG_KASAN_HW_TAGS
> > > -
> > >  static __always_inline bool kasan_enabled(void)
> > >  {
> > >  	return static_branch_likely(&kasan_flag_enabled);
> > >  }
> >
> > I found mm-new build fails when CONFIG_KASAN is unset as below, and 'git
> > bisect' points this patch.
> 
> Yup just hit this + bisected here.

Sorry for the trouble and thanks for reporting.

> 
> >
> >       LD      .tmp_vmlinux1
> >     ld: lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'
> >
> > Since kasna_flag_enabled is defined in mm/kasan/common.c, I confirmed diff like
> > below fixes this.  I think it may not be a correct fix though, since I didn't
> > read this patchset thoroughly.
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index b5857e15ef14..a53d112b1020 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
> >
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > +#ifdef CONFIG_KASAN
> > +
> 
> Shouldn't we put this above the static key declaration?
> 
> Feels like the whole header should be included really.

You are right, kasan_flag_enabled should be included in CONFIG_KASAN
ifdeffery scope.

Since CONFIG_KASAN_HW_TAGS depends on CONFIG_KASAN, we may not need
include below CONFIG_KASAN_HW_TAGS ifdeffery into CONFIG_KASAN ifdeffery
scope. Not sure if this is incorrect.

Thanks a lot for checking this.
> 
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >  	return static_branch_likely(&kasan_flag_enabled);
> >  }
> >
> > +#else /* CONFIG_KASAN */
> > +
> > +static inline bool kasan_enabled(void)
> > +{
> > +	return false;
> > +}
> > +
> > +#endif
> > +
> >  #ifdef CONFIG_KASAN_HW_TAGS
> >  static inline bool kasan_hw_tags_enabled(void)
> >  {
> >
> >
> > [...]
> >
> > Thanks,
> > SJ
> >
> 
> Cheers, Lorenzo
> 



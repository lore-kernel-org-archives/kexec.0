Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A29C87FCB
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ek84SNcPpQCmMHvcqQa3TlILZVgRFvPfl/s5BFwLTA=; b=1AvS0DnKm6+YGDzPZGcnI0a8Ya
	bTIaBfW7LTQxmKzjHp9ob4FvCf63TfZ3uXatFiHUdUMPPGB3LDHo7WjhgrJ6/mE1vzHWj88/6dEOn
	dsP12NAoxQaicV2uG9PMWydhgEqrR35+0SR2JIar9KJzHyc6pO0Wx3ddj3YN7wUZKT6/iREJbOyk4
	CaHWpaia4XZ8ksLGLiFAPZd+Qv9e1uir2vTxCqDAAtC3HKhE9DVTBc5xmjNEKZljrDcQlwcsb8EkS
	2Nzo633n87kcDYK8UR7C3Wm6VWxtFTxHnbkAoRydQJ6MhRI81qKJjBJT5eKVLXOoxDXjfCN7JskAi
	b6Mu+nLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulryi-0000000BR8g-1dK8;
	Tue, 12 Aug 2025 16:36:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulp27-0000000AuwR-0HXx
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 13:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755005237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ek84SNcPpQCmMHvcqQa3TlILZVgRFvPfl/s5BFwLTA=;
	b=WNv5E/5c17aBkaxBFgAncAGPLvhVGbHfj5ucm7H/IrVFU+PlMds2XbRNLFi9hcNbwCuWcC
	/GVBrYYeNVZMc4VO4DJxn2QS1VDYHapyrVbLhFiurUE679b2S238ANPLVqQ3Y99UB0ljBT
	lYfYpFR2XWRk6RycX4igPrAujRv6A8s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-l3ZgW3CKOGqqNd4zvWIV_g-1; Tue,
 12 Aug 2025 09:27:12 -0400
X-MC-Unique: l3ZgW3CKOGqqNd4zvWIV_g-1
X-Mimecast-MFC-AGG-ID: l3ZgW3CKOGqqNd4zvWIV_g_1755005229
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C128018002C8;
	Tue, 12 Aug 2025 13:27:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9513530001A1;
	Tue, 12 Aug 2025 13:27:07 +0000 (UTC)
Date: Tue, 12 Aug 2025 21:27:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJtBJgC82CpUkwTi@MiWiFi-R3L-srv>
References: <20250805062333.121553-5-bhe@redhat.com>
 <20250806052231.619715-1-sj@kernel.org>
 <9ca2790c-1214-47a0-abdc-212ee3ea5e18@lucifer.local>
 <aJX20/iccc/LL42B@MiWiFi-R3L-srv>
 <b5d313ef-de35-44d3-bcbc-853d94368c87@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d313ef-de35-44d3-bcbc-853d94368c87@lucifer.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_062719_189076_827308D1 
X-CRM114-Status: GOOD (  19.72  )
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

On 08/08/25 at 02:24pm, Lorenzo Stoakes wrote:
> On Fri, Aug 08, 2025 at 09:08:35PM +0800, Baoquan He wrote:
> > On 08/06/25 at 05:26pm, Lorenzo Stoakes wrote:
......
> > > > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > > > index b5857e15ef14..a53d112b1020 100644
> > > > --- a/include/linux/kasan-enabled.h
> > > > +++ b/include/linux/kasan-enabled.h
> > > > @@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
> > > >
> > > >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> > > >
> > > > +#ifdef CONFIG_KASAN
> > > > +
> > >
> > > Shouldn't we put this above the static key declaration?
> > >
> > > Feels like the whole header should be included really.
> >
> > You are right, kasan_flag_enabled should be included in CONFIG_KASAN
> > ifdeffery scope.
> 
> Firstly I _LOVE_ the term 'ifdeffery scope'. Fantastic :)

Learned from upstream people with expertise on both english and kernel, :-)

> 
> >
> > Since CONFIG_KASAN_HW_TAGS depends on CONFIG_KASAN, we may not need
> > include below CONFIG_KASAN_HW_TAGS ifdeffery into CONFIG_KASAN ifdeffery
> > scope. Not sure if this is incorrect.
> 
> Well I don't think CONFIG_KASAN_HW_TAGS is necessarily implied right? So these
> should remain I think, just nested in CONFIG_KASAN, should be fine.

After investigation, I keep the CONFIG_KASAN_HW_TAGS ifdeffery scope out
of CONFIG_KASAN scope. Otherwise, I need define the dummy
kasan_hw_tags_enabled() function twice. I am personally not fan of the
style. While if that is preferred in kernel, I can change it.

#ifdef CONFIG_KASAN

#ifdef CONFIG_KASAN_HW_TAGS
......
#ifdef CONFIG_KASAN_HW_TAGS
static inline bool kasan_hw_tags_enabled(void)
{
        return kasan_enabled();
}
#else /* CONFIG_KASAN_HW_TAGS */
static inline bool kasan_hw_tags_enabled(void)
{
        return false;
}
#endif /* CONFIG_KASAN_HW_TAGS */
.....
#else /* CONFIG_KASAN */
static inline bool kasan_hw_tags_enabled(void)
{
        return false;
}
#endif



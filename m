Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61F1CA0EC0
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 16:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGK9n6dq7VxCb/OM51wQ3RDMD15RnRtHlU5OclWuDJs=; b=MkLz5TxooyYw1P+0R7MTqW/LlB
	JrEr5ssu6+tOxOcCoZNh6G48izuOjhhP5MLNsCXRS7R69RK8kgLpVinzyJo0MCoXkU7L+l7lh89B7
	rbyYYLDh27YkQu4oWXrWy+942Af1ZxGBr/jHcaQeXcpkmOFWuxN0a2hjjXMbIRCp80xGxEeAFTzU5
	7X7wdneL9YK6wj1gs8/VAYzO56nWa2OhtFLYq1X8J0pqNaKonXrlpHx+pPyYVA9SnTEK56Q524Ubs
	gQdleGW54IZL8SPJ+ed0MwX/6djphpcI9sb8SyUtHwk7M7QOJMd8ftQfzprNOIWrePMEnLfbHj5kp
	LKTCBjUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPWh-00000003GC8-2zdT;
	Fri, 08 Aug 2025 16:01:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPVf-00000003G16-36bo
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 16:00:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGK9n6dq7VxCb/OM51wQ3RDMD15RnRtHlU5OclWuDJs=;
	b=HcrWyGT70KbUzpfdijTruk1GcT1uiCtkfmAQhjegxP9HPgpqvCoX52fvxI7722+TsnmdV/
	WWJBi+2YfE8Z2sDsKIjSXbmWCNm8BeOog1E4n02vm+Emu+IxIa4F3AwYXraIVTKZzcLWjw
	bx1xd7+jgH587u/ywJELLkHY0C6BbXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-wt4H8Zk0P262tjW9FjN_lw-1; Fri,
 08 Aug 2025 11:59:56 -0400
X-MC-Unique: wt4H8Zk0P262tjW9FjN_lw-1
X-Mimecast-MFC-AGG-ID: wt4H8Zk0P262tjW9FjN_lw_1754668794
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6256195608B;
	Fri,  8 Aug 2025 15:59:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54FE0300145A;
	Fri,  8 Aug 2025 15:59:51 +0000 (UTC)
Date: Fri, 8 Aug 2025 23:59:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJYe8rAa3lIe4Nat@MiWiFi-R3L-srv>
References: <20250805062333.121553-1-bhe@redhat.com>
 <20250805062333.121553-5-bhe@redhat.com>
 <CACzwLxivXFYXuF1OkqcP9THar7UGQ3VVAQgQm=PU9Tohb8hnRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxivXFYXuF1OkqcP9THar7UGQ3VVAQgQm=PU9Tohb8hnRQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_085959_858670_B5FC4345 
X-CRM114-Status: GOOD (  24.62  )
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

On 08/06/25 at 11:24pm, Sabyrzhan Tasbolatov wrote:
> On Tue, Aug 5, 2025 at 11:34 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Now everything is ready, set kasan=off can disable kasan for all
> > three modes.
> >
> 
> Hello,
> 
> I've been working on this already and a different approach
> with the Kconfig ARCH_DEFER_KASAN has been proposed.

Thanks for telling, I don't always watch MM mailing list, so missed your
earlier posting. 

I went through your v5 series, we are doing different work. I am adding
kasan=on|off to generic/sw_tags, and have added kasan_enabled() to needed
places. In fact, based on this patchset, we can remove
kasan_arch_is_ready() more easily since in all places kasan_enabled() has
been added there. Before seeing your patches, this is what I planned to
do to remove kasan_arch_is_ready(). I will see what can be done better.
Maybe I can carry your patch in v2. I will try tomorrow.

> 
> Please see v4 thread.
> https://lore.kernel.org/all/20250805142622.560992-1-snovitoll@gmail.com/
> 
> It also covers the printing in a single KASAN codebase, instead of
> printing "KASAN intiilaized" in arch/* code.
> Also covers the enabling KASAN via kasan_enable() for all 3 modes.
> 
> It's up to KASAN maintainers to choose either version.
> I just need the confirmation now if I should proceed with v5,
> or your version if it covers all arch and cases should be picked up.
> 
> Thanks
> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kasan-enabled.h | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index 32f2d19f599f..b5857e15ef14 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
> >
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > -
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >         return static_branch_likely(&kasan_flag_enabled);
> >  }
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> >  static inline bool kasan_hw_tags_enabled(void)
> >  {
> >         return kasan_enabled();
> >  }
> > -
> >  #else /* CONFIG_KASAN_HW_TAGS */
> > -
> > -static inline bool kasan_enabled(void)
> > -{
> > -       return IS_ENABLED(CONFIG_KASAN);
> > -}
> > -
> >  static inline bool kasan_hw_tags_enabled(void)
> >  {
> >         return false;
> >  }
> > -
> >  #endif /* CONFIG_KASAN_HW_TAGS */
> >
> >  #endif /* LINUX_KASAN_ENABLED_H */
> > --
> > 2.41.0
> >
> >
> 



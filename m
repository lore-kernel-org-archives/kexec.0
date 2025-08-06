Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B5BC87FD1
	for <kexec@archiver.kernel.org>; Wed,  6 Aug 2025 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9lYYsLzSzPrboBgIaB2CsUlJcp8uiiPFpeJB8b2vvMg=; b=tBC3XDztN6obKIBK8HrUDu2eD5
	RreC/rBgii12amTvST4PRMFV/BPZ+VDk7F+O7OreEzrf+o12qBiCO4Q9jE9CcAisg4sQ+Sg+JBhZ9
	4Gdao38CdX+ZEi1JVbDJpXWy6xwg6D2Affu+kPuXO1nmOPXrOJ6Ub8//CxAwu0o2iHEZhrgBrvL/o
	7UoNaN2YMsPGlmFKuZ7TWmEQa085OpNEcxXw8jboEX2C3kqtM19Zu36bY+dWdH0HVzwhGsF8PlEsw
	f/FNFvyUadnfTTpKoE8OJ079BxIA33u6+GjQwJuuHaJ9y0p+iefjqXFh5iih7461Mo2Iqu4pPWoDc
	LL0X4KIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujafH-0000000Eo3x-28Er;
	Wed, 06 Aug 2025 09:42:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujaZH-0000000Emua-16Y8
	for kexec@lists.infradead.org;
	Wed, 06 Aug 2025 09:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754472977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lYYsLzSzPrboBgIaB2CsUlJcp8uiiPFpeJB8b2vvMg=;
	b=fVjS002P7i3yGq1sBqrZwA1FRHjJEWvK0FYX52PWgW/FrPHPm2ny8B5n1AfBprN6hlbbps
	G7CU/E7ObUMmO3Qp4HxGe/U0nqGwWqRUWQ4TKrbbLPTDBpY8gu+0Myu2PqMYG2WZih5ceN
	B8lI5ENHPcrWHMGtlwGuJPs9oryYIME=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-UFCNoUSGPC6BIOrNHzU-2A-1; Wed,
 06 Aug 2025 05:36:11 -0400
X-MC-Unique: UFCNoUSGPC6BIOrNHzU-2A-1
X-Mimecast-MFC-AGG-ID: UFCNoUSGPC6BIOrNHzU-2A_1754472970
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1772619560AE;
	Wed,  6 Aug 2025 09:36:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.218])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 791923000199;
	Wed,  6 Aug 2025 09:36:07 +0000 (UTC)
Date: Wed, 6 Aug 2025 17:36:03 +0800
From: Baoquan He <bhe@redhat.com>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJMiA2hh3S9JCqOu@MiWiFi-R3L-srv>
References: <20250805062333.121553-5-bhe@redhat.com>
 <20250806052231.619715-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806052231.619715-1-sj@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_023619_376465_65B0B8B5 
X-CRM114-Status: GOOD (  23.12  )
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

On 08/05/25 at 10:22pm, SeongJae Park wrote:
> Hello Baoqua,
> 
> On Tue,  5 Aug 2025 14:23:33 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Now everything is ready, set kasan=off can disable kasan for all
> > three modes.
> > 
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
> >  	return static_branch_likely(&kasan_flag_enabled);
> >  }
> 
> I found mm-new build fails when CONFIG_KASAN is unset as below, and 'git
> bisect' points this patch.
> 
>       LD      .tmp_vmlinux1
>     ld: lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'
> 
> Since kasna_flag_enabled is defined in mm/kasan/common.c, I confirmed diff like
> below fixes this.  I think it may not be a correct fix though, since I didn't
> read this patchset thoroughly.

Thanks a lot for the reporting and fix. The below code is great to fix
the error. I reproduced it and tested with below fix, it works.

Since there's other reviewing comments, I will merge this into v2 post.

> 
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index b5857e15ef14..a53d112b1020 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
>  
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  
> +#ifdef CONFIG_KASAN
> +
>  static __always_inline bool kasan_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }
>  
> +#else /* CONFIG_KASAN */
> +
> +static inline bool kasan_enabled(void)
> +{
> +	return false;
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_KASAN_HW_TAGS
>  static inline bool kasan_hw_tags_enabled(void)
>  {
> 
> 
> [...]
> 
> Thanks,
> SJ
> 



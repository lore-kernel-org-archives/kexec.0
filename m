Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF04D5E39D
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lh659XfoCeAo+KdUpmqDXFPgGNRaeAKTqTT67lATSrY=; b=yguJ7ly7J8fIlNhGgsZcNOCPQA
	vcx9xeaYJ/NLZatXjQjLBSt4RyRIezIqbNGtOoaLQr8uCQRFyPHHCLK//reo18FvrR9pXkLn9hBcU
	PWhngSbFoIJpwrMGdCC7Y70enMN1T/EbG93ZWaccZbImb61wP7B1xt5e2Aq90yjauLoqi/cPywiEN
	O7tLRv69kMglNTjfhwtnFanaOqU3XQKE6Rb8rdV+lUe0YI9zEYSWWXot+SaR+4Devye6ILmyuNZEZ
	xCcsQUbDbKPvs5zdzP9Xk+lSiFIXNmw+TQIc2IGO1EIY0g+TgUV7kFGkPCnx18ixG2DP5DdlrRwS4
	+G+qFitw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVWcx-00000005PNh-0GRv;
	Tue, 16 Dec 2025 15:06:15 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVWco-00000005PMH-3FsJ
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 15:06:11 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6492e7891d2so6415410a12.2
        for <kexec@lists.infradead.org>; Tue, 16 Dec 2025 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1765897565; x=1766502365; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh659XfoCeAo+KdUpmqDXFPgGNRaeAKTqTT67lATSrY=;
        b=FkAkRcBYvWyBaZbI6k9ELdAiXw8pmudAKBDVMU8oL3qZAYignSgJWp/OrzkN7ctyW9
         kuK3TKzrVdRi14jj4zCpU/1hk9IOS2p7bjGkEV8LLCuc73P1fXww6u5EaTKvlIU9DodU
         Hk7L2II2gDeGkKKuRgzaK1gnKdJfhl5A6yih4hrfx0/sjsnICDo1Ryh/yDvRP6NK9imF
         /K9tw0thuumqHBZWKjsiGjezfDoH58XU+uAZChqAnNq6KM+0OJgocqJChfWXCnQcfAy5
         hezY+p4fwTiGi4kwSN9Rfn5gwBAGU6ry5jkbGVUljXnERBdKMAqedtv76yujy5fa0FWZ
         ubyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897565; x=1766502365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh659XfoCeAo+KdUpmqDXFPgGNRaeAKTqTT67lATSrY=;
        b=QccAyrs/V8AxPHFc+rlxhnEmDtGAAMq2uFHlo34ZfFxxIQit2Dj3kS4gQS2wSdWdhi
         D5dlJpL/KzdEdQ5EBa225Fb/q7hlqGc0NI5CkV7kT0WSMEr0r9z3X5lNXh3GaakFlEoz
         7e6sfNEzwY4CfXExkX5Emwu5oGT1VsxzbMejpVjplTizkB02Rw7WZUutUzZGk57ifbVA
         Rx2Jqi23Zmu0jyVTDqK7RBB0UMqnDu/hvW0GtVjkLJnxfosCCY9SBF089A4Q97sfTjXN
         J2HOqCzGI03IPVfMKp8y/6Ctrvd8kyklQiwvMagQKmYHZNI0N/zBUi3fJcij3CBj+PPj
         JY/A==
X-Forwarded-Encrypted: i=1; AJvYcCXNRcYs/U3svw3CNlAqNHGLPsujiRFXnR+db0ppxHnY8JQiX9/fVIGALQGtfw6Y1imkGfe4Dg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yytd+5CAXHPZRr9DT0RX1VDVzF+l7KdN0APnvAJFG8tNVByr+hc
	I47m9Qq0lrbf/uCnu4Eomfa2QEbY/ZFl+OSt8fLhvKiHpmRLykW92pL1N4FRSyplnAEQNFl5gsU
	EyK9Wyn5nvwxlkfK/hRzCP8ozgRerdXLAYuiauE0H0Q==
X-Gm-Gg: AY/fxX6g900bacggOE9ja3LbFnZjz/sW2OqtkjGgXa3gRkI841ozyZ1eniWuZarfCi+
	hF55358kPgsYTyGIAR4zYyGOti0d6bF8Fzgv9RTiQyXh+t3IjfDokOA7oMeDv5GYn38nPMB8ewQ
	D8z+sxJXQvG91n/gtL8xAy5sirHEA/uFV3kf71/lJPnHDfasE5F6rCEeoDOqoZW5rvhf305iXO+
	qg+hvp7zS462TgJoTuraAE27w6epznNINiSl8kv+z5aVQW0x6YRkxbUxWpsHcRnUTlM0ytDI7bs
	dOoDUuEv+a2WkjYOw7M/CUy6YLxgE3FlUqc=
X-Google-Smtp-Source: AGHT+IF7Gcyw0dR/Mj5s3q1xjJTEdfwQeE3CY9pghDlV87292o4JU329+ZkzRMnXcaagEpzUe2UzPtSwp27MoAuofdw=
X-Received: by 2002:a05:6402:3493:b0:649:815e:3f9b with SMTP id
 4fb4d7f45d1cf-6499b15f4abmr14450484a12.3.1765897564682; Tue, 16 Dec 2025
 07:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
In-Reply-To: <aUFJH9xzJXYOt_X8@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 16 Dec 2025 10:05:27 -0500
X-Gm-Features: AQt7F2rLiLltujK01JjqfmvwLUCS-mIQBP1haAEc57IK1JW5hrZ7L2WDIqYN0GM
Message-ID: <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_070608_649671_250D6BF7 
X-CRM114-Status: GOOD (  16.98  )
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

> > +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> > +                                               unsigned int order)
> > +{
> > +     unsigned long pfn = PHYS_PFN(phys);
> > +     int nid = early_pfn_to_nid(pfn);
> > +
> > +     for (int i = 0; i < (1 << order); i++)
> > +             init_deferred_page(pfn + i, nid);
>
> This will skip pages below node->first_deferred_pfn, we need to use
> __init_page_from_nid() here.

Mike, but those struct pages should be initialized early anyway. If
they are not yet initialized we have a problem, as they are going to
be re-initialized later.

>
> > +
> > +     return pfn_to_page(pfn);
> > +}
> > +
> >  static void __init deserialize_bitmap(unsigned int order,
> >                                     struct khoser_mem_bitmap_ptr *elm)
> >  {
> > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int order,
> >               int sz = 1 << (order + PAGE_SHIFT);
> >               phys_addr_t phys =
> >                       elm->phys_start + (bit << (order + PAGE_SHIFT));
> > -             struct page *page = phys_to_page(phys);
> > +             struct page *page = kho_get_preserved_page(phys, order);
>
> I think it's better to initialize deferred struct pages later in
> kho_restore_page. deserialize_bitmap() runs before SMP and it already does

The KHO memory should still be accessible early in boot, right?

> heavy lifting of memblock_reserve()s. Delaying struct page initialization
> until restore makes it at least run in parallel with other initialization
> tasks.
>
> I started to work on this just before plumbers and I have something
> untested here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/deferred-page/v0.1
>
> >               union kho_page_info info;
> >
> >               memblock_reserve(phys, sz);
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


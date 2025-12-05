Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604D6D32D9E
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5e1JDxNMsKeBjrN3+x94DCexyw30V6kM+/jaZC8wkNo=; b=id+jUQfyczbMxjwTuZzFAq73Dp
	My2kDnsJ0aQCdk5Zc57y6LxOT0lyojmMtzK4vJ1wERawhokWw2TYR755qTqXI38dTiMBbQK/o7MMj
	9OO8281txCyh/hMBLSwjWMa3A7bpLYh9o7IQ1jHCe8fN42tuU2m/Ol1+ut0hlg4aGk/twAjZbVTGo
	MNPtaPG88RHgB+qd6S0QSu9prZ8QNxTd4zSot5Z8v0APR76qJvqsl6CcQKSR6dG9HS5QUYhMNFXuM
	v51BEV7SgcL/b/PC65BTSODOq2/WqeN/DmcTxAoLLBM/ikivH/nBSVo1EPnUIV9Htwo8C0gJ9hk+t
	nks5ClDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRXP3-00000009d0N-2G4D;
	Fri, 05 Dec 2025 15:07:25 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRXP1-00000009czb-2XAb
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 15:07:24 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so22585685e9.1
        for <kexec@lists.infradead.org>; Fri, 05 Dec 2025 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764947242; x=1765552042; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e1JDxNMsKeBjrN3+x94DCexyw30V6kM+/jaZC8wkNo=;
        b=Cx8a5uhjYHpW8uK5JdiAuLHNUofFYiKzoNvlT8HY/2RC93ACjJF4iRRt8YXfgqqKZL
         +VHV0gnAhSU/hCtY1+ymS5AY4zlkNEOfGTHGpRYAElWzQ7JcLfRxwxWFIa1wiNvbLMyq
         J/rqjsK5Wr8NAcfG3A6jkb/6hZqpcxef4zuWysaI9aDOTTRYXA8sjKKLq8B+EifplmzB
         zgrl1zsdSDIvHAXu70fzHP46pCJB4uQ8ULnfD/3fb/wdXqCLXy0ZlrMCYhOeEhwu0RKY
         hYqua9X5zPvG6BlFehpqn8BQ8f4+h6UGjWlioT3jenzfSVCN71c1HgXv6ttotV2TDFbS
         g3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947242; x=1765552042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5e1JDxNMsKeBjrN3+x94DCexyw30V6kM+/jaZC8wkNo=;
        b=MR4Y3YPQqdTWfiaFsUEd4DHmGQ7dF1x9rDAQrS6g3gDgYQ/f6NH5oO8k9eSYhtuzSb
         PIkOCDBZxdxP4tM/5vl/JxSfs5DWPjCyHogItrSjzzdUTEj0f/gC/2aptuD+wmXYhJ9a
         S9yiYHhuiTUmwkhtopm/L2ejzknP34+Sg5QTK88ZRgNvBrbDjQnxerX6XXSNs1tcCb7f
         m2zpkuTxBRLp2WOehnge/Lhb3uLAX2xY5Y1P8Mm8mCfvSD1nFS4lstLVWzNYJuWf5CaF
         EhRlL0c4jknYs+6FPB4betvV8QmeIbfzyoKFcQI1p/d1duKQoEGEn3MOY5vnUkjKzMDb
         08Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWmmBpBo/0NIDUNMrlQWxJKyl3bAWi9/mMflQCz+8S+im/0fFzyZkH+9jJwqUemmBE2x07Z3w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnLqU9bwJ67tsGo+9EihF6mZNhUNTng7J8LzUDX/qtTnaI5HJb
	hhSyRBr1ciyLcGKdwJ/jjUBhNinpqwJcYmHLUVWirnaGkLIZSMc9sXcekm9/i/R9Wycxwonlzsi
	fV3j+edva0LlL6zM+HW+O4bW8Sb3NthU=
X-Gm-Gg: ASbGncvf0DsOmXC5PVVklBsuj5M19MZ4oTqnhqxBZ7Vv4+vR2HE8LDvSS7HUzSw8bl+
	/aQanqkAKH0HD4FbF0MAzfHbymU8mR07/Cskngl7pA4EdqDMIH0cR1+nQhcudYUuWCsFmwbSJam
	XjWzkNW4wTTaVBHGx9HkCfv1HT7otQBKPE/Kihn5/JEweDdFR2/uZE3CaAbxr+xg3NaHJLsqOxr
	0goao+3sb2JG6uA3WF3cfgcECTNY8QiSPY9Z1pgQ3IrD62gspJnPPD5JlPj2C6kApkP1N0a0KGd
	KZqBdTqx0pBmrRtkqi8291eoknPSvWC9FA==
X-Google-Smtp-Source: AGHT+IGM8UyEJTTT9Z6uFlHy6NNxt69p9mMEtv2ZpYk3WvAawcJYPmX38Eb9ObakRfbW3X3Kb6QvbtgtLouD0E5YqJ4=
X-Received: by 2002:a05:600c:45d1:b0:471:1435:b0ea with SMTP id
 5b1f17b1804b1-4792f38d501mr76181395e9.24.1764947241641; Fri, 05 Dec 2025
 07:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com> <20251128033320.1349620-2-bhe@redhat.com>
 <CA+fCnZfDYHUVKX-hdX3SgmuvJEU-U+MuUJGjs-wJJnfRDHz2sw@mail.gmail.com> <aTKHzmxR3JA2R7qD@fedora>
In-Reply-To: <aTKHzmxR3JA2R7qD@fedora>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Dec 2025 16:07:10 +0100
X-Gm-Features: AQt7F2oIzOZoI9YYmMGEGfR2euyjD-iV_heXJVsHmHq5B90kIr5LFLwzTYtsmlM
Message-ID: <CA+fCnZdZQFVBf_NkrKk0U+TAptfi6RRmCkPY5ZpOUeObBpwAnQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] mm/kasan: add conditional checks in functions to
 return directly if kasan is disabled
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_070723_700327_7320DA0E 
X-CRM114-Status: GOOD (  21.13  )
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

On Fri, Dec 5, 2025 at 8:21=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 12/04/25 at 05:38pm, Andrey Konovalov wrote:
> > On Fri, Nov 28, 2025 at 4:33=E2=80=AFAM Baoquan He <bhe@redhat.com> wro=
te:
> > >
> > > The current codes only check if kasan is disabled for hw_tags
> > > mode. Here add the conditional checks for functional functions of
> > > generic mode and sw_tags mode.
> > >
> > > This is prepared for later adding kernel parameter kasan=3Don|off for
> > > all three kasan modes.
> > >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  mm/kasan/generic.c    | 17 +++++++++++++++--
> > >  mm/kasan/init.c       |  6 ++++++
> > >  mm/kasan/quarantine.c |  3 +++
> > >  mm/kasan/report.c     |  4 +++-
> > >  mm/kasan/shadow.c     | 11 ++++++++++-
> > >  mm/kasan/sw_tags.c    |  3 +++
> > >  6 files changed, 40 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > index 2b8e73f5f6a7..aff822aa2bd6 100644
> > > --- a/mm/kasan/generic.c
> > > +++ b/mm/kasan/generic.c
> > > @@ -214,12 +214,13 @@ bool kasan_byte_accessible(const void *addr)
> > >
> > >  void kasan_cache_shrink(struct kmem_cache *cache)
> > >  {
> > > -       kasan_quarantine_remove_cache(cache);
> > > +       if (kasan_enabled())
> >
> > Please move these checks to include/linux/kasan.h and add __helpers to
> > consistent with how it's done for other KASAN annotation calls.
> > Otherwise eventually these checks start creeping into lower level
> > functions and the logic of checking when and whether KASAN is enabled
> > becomes a mess.
>
> Not sure if I got it correctly. Are you suggesting it should be done
> like kasan_populate_vmalloc()/__kasan_populate_vmalloc(),
> kasan_release_vmalloc()/__kasan_release_vmalloc()?

Yes, please (assuming you're referring to how these functions are
defined with all Sabyrzhan's patches applied).


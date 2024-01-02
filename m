Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9644CC47074
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZtJwGZSBz9X04R5JUTiZTGGiqZj9dZpIniPxsbAYlf0=; b=NKc1WOjMuqnHxt
	kWIm3B5e+jAduGSRxxNSOGdqrKgDobfD1OfOUoFqQmXuNqImdLK5tmHewyqQ3TjbeBOcftPAMs4+q
	bqiEB+GzgchhsnCh0/StcNdzt83fwLcHUV78KmnBC7DvC+sDW1JDq0do9bPdJ7fYcCWadzfOBoJyL
	k1llW6WYWM2HlWxOzTjAaQNkkr/OR0kpxfpOClpPlNjF7azCjhDO7aDwYBQq+ohuO4Ti2olVHcCRf
	83J6YrM4/uv2M16dZEOUmfdtRR9boDpA4yOptWKNWo0sTT2gVDcK1Jy3qy7Ay2/JRExQ/tJjVyboF
	/xhIO8gn4dm/FRpeEq2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgZj-008MnX-2T;
	Tue, 02 Jan 2024 15:21:03 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgZf-008MmI-32
	for kexec@lists.infradead.org;
	Tue, 02 Jan 2024 15:21:02 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28bc870c540so7341023a91.2
        for <kexec@lists.infradead.org>; Tue, 02 Jan 2024 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704208859; x=1704813659; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC8zZpW88JATTyPu75m9EIR8gbeNaY6Wy3+vSQqo4pc=;
        b=eOLQSWnn8WTXz+dnQ02y0wznByBbWZmqqcR+Gt5TGbEE75eUf8LL47e4SRBwoYOukd
         FYTaes6gcTQ4jVsUpUtFNArr87xckrqAvxjFkQ/VXaOYwJvz/mDG41blTmQB2+SbyU4a
         Qyg1nISk4jE940OBSFUosH1AfeD8jcBfPrLIDLhh5zvGGZJW2RmjSsrd8mWwkJomUc/x
         gPfZICFlTT7aO29dl/R2+PKRcD3O8zmWTYaeFu55VobDStFy5ASGEmvWsjg8lK69FZQr
         S391gu21inJtemb8o8OmZq/DKUvzo8fRPfod+wRAWXLX3lPQLYyFASjqw2obnJZcCYVr
         Efgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208859; x=1704813659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AC8zZpW88JATTyPu75m9EIR8gbeNaY6Wy3+vSQqo4pc=;
        b=YioWLoLNZhylORce2nosirkl4hsVWU0HaiMFcMaFx6/CwX+S1W0WPCFlzO6tWw3BD/
         RnBlYPLXbc3ZBbujiM0GV9VWaO39JbAwerJBG54VqkvGoxDtnOgfEtd6GxrCpTqBEsO/
         /butE5fXRJhk7RhBEWAl/KIh8/5cy74Pcz3DM3ZIWki6lZ+gHPiqvnBBcMC89naMdHeI
         eDeBRxpfdo0Q4vSyXO4UhBf5+3exuTXysLngTKt850ewY6w/wnAn17C6KxpItIV11Cnv
         ptbFA7N4gj8hope8Ft1kEnXOMwv5G5gD3o0tttxFSilw4jI0sTct+DgqGpn+/vqHUk74
         taBQ==
X-Gm-Message-State: AOJu0Yxm1KAcriyRd+Qz6jvVkaCv60vvqZ+GumTm0flupqz2rbfYViJ9
	JnV2HiaYEqZK6TSnzjx98FY=
X-Google-Smtp-Source: AGHT+IFM4gcGnxZgIt3nx6IqoNlCeiNV7/WpfyDiCmnxC7Me+8kboX3wHN6544VVey8RQv1Hn6uBvQ==
X-Received: by 2002:a17:90a:6fe3:b0:28c:5391:7683 with SMTP id e90-20020a17090a6fe300b0028c53917683mr6307876pjk.65.1704208858728;
        Tue, 02 Jan 2024 07:20:58 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b0028bf79ad453sm22365618pjb.21.2024.01.02.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:20:58 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] crash_core: optimize crash_exclude_mem_range()
Date: Tue,  2 Jan 2024 23:20:46 +0800
Message-ID: <20240102152046.111961-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZY/wtvltzGR0CokV@MiWiFi-R3L-srv>
References: <ZY/wtvltzGR0CokV@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_072059_980174_3CA596CB 
X-CRM114-Status: GOOD (  24.30  )
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

On Sat, 30 Dec 2023 18:28:06 +0800, Baoquan He <bhe@redhat.com> wrote:

> On 12/29/23 at 12:10pm, Andrew Morton wrote:
> > On Wed, 20 Dec 2023 00:34:18 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> > 
> > > Because memory ranges in mem->ranges are stored in ascending order, when we
> > > detect `p_end < start`, we can break the for loop early, as the subsequent
> > > memory ranges must also be outside the range we are looking for.
> > > 
> > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > ---
> > > Hi Andrew,
> > > 
> > > Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
> > > crash_exclude_mem_range()" can be ignored, use this patch instead.
> > > 
> > 
> > Some reviewer input on this would be helpful please?
> 
> 
> I suggested this in below discussion thread:
> https://lore.kernel.org/all/ZYEOshALGbDKwSdc@MiWiFi-R3L-srv/T/#u
> 
> So it would be good if squashing this into patch 3 of another patch
> thread you are asking:
> [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
>

Hi all,

I've squashed this patch into the patch:

[PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()

The link to the new patch is:

https://lore.kernel.org/lkml/20240102144905.110047-1-ytcoode@gmail.com/t/#m255d0d26148f2b384f6b7ab77eb38edf3f1bc0df

> And I would suggest withdrawing Yuntao's below patch on your
> mm-nonmm-unstable branch.
> 
> 961c69e9f1bf x86/crash: fix potential cmem->ranges array overflow
> 
> Becase there's better one to fix the potential oob from fuqiang,
> although fuqiang need improve his patch log.
> 
> [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
> https://lore.kernel.org/all/20231222121855.148215-1-fuqiang.wang@easystack.cn/T/#u
>

I'm okay with that.

> > 
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >  		p_start = mstart;
> > >  		p_end = mend;
> > >  
> > > -		if (p_start > end || p_end < start)
> > > +		if (p_start > end)
> > >  			continue;
> > >  
> > > +		if (p_end < start)
> > > +			break;
> > > +
> > >  		/* Truncate any area outside of range */
> > >  		if (p_start < start)
> > >  			p_start = start;
> > > -- 
> > > 2.43.0
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

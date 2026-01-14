Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDD1D39000
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 17:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l16mAKGChN2PX3pOsEUpJwNSJXDy5Uc5IHVR3AfNsDg=; b=d/8T171Om7/dy9xu55mGw86J5p
	xfliteeZpf2nIsnaTgMF+VhsoSpd1nWCn2c0M+XeXzpBWt1hKpaDjwvnG49mKOItmF0W6DFfzqFeH
	JKPAEW4I91pID21RY0oP9KRfGeZrqdQrKaZVCDh5nV+XqfcdpKh1KBY8oL5UsYApTh6T8SVDp4Gt1
	l1jFxUa9yOMKLwg+YUILFFoCO2UXo5eTnAf/TC14HUhT1UpVmRvgZNoOOYQsnpNpCJKdZq5ChmULy
	xZIAbpkO7bgYLMjK1EaMsbqqJsGXzpj6ymzj+5msQN84S95GN3r2shKF5zK9hjW3Y//+a4LBszqjk
	ZB7gIzfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg59U-0000000AFHq-0Cqx;
	Wed, 14 Jan 2026 17:59:28 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg59R-0000000AFEx-0ZVj
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 17:59:26 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5014b5d8551so14471cf.0
        for <kexec@lists.infradead.org>; Wed, 14 Jan 2026 09:59:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768413563; cv=none;
        d=google.com; s=arc-20240605;
        b=AehPaCK1IToZrIH31U/jhT16+Uqw5f6h7rXjcjLEBAbPS46e2sacKtG72moHYOqcYI
         tuc3a6vAgw4284uqAZdrrH4eioxkSsj3otwQOD6glJRtCRbI+9GWZYv2gJ9QX+3Su60m
         0H+dXa1R4uttCLcF5m2wi1qE5okvamgEvkJagOa0m5G70zm83Et1NPWWLnxdtauI/owV
         ojL6OS0VdEOLRlbRnIfVZQxdUz50lCDR1X1ukDIkuL2DEnSQhTH1i31w7B1dn7mK+s2i
         sEPlOSbMfzwmKWpysowlC2IXScYGegoDuWuUr5caq5hKAp+x7WuincLFTsJL8aKFjP2f
         wMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l16mAKGChN2PX3pOsEUpJwNSJXDy5Uc5IHVR3AfNsDg=;
        fh=MGU2eMiQOOITpP2i7G7S3H57VE4PGMxwu5oVmS17bPI=;
        b=VxAFJLfiGK5nzqg8wBLQ4K41FfK1WrPC2Vzltput70wWhZ+PQpSKrydcsAJjqo55fx
         HyqeIPSbgMIOBPX/fyjNm8nleu43OZllt7Yr1sFp4lkTezAk85jF8uucdVaiFQpg+Nex
         oNKg65N1rOaCYlp5mD/68FKbbge5Lh63tDhwXNreG0e7iKaea90KCJa45PWbfGBiSJ5D
         OONucCIu6N+o37SQGTfvgtPvdEF9rNICzOBMjtlWv5h0Mx0cV00697GNIJuQ0G90Wnfs
         ulE2y8gX2PSQqw/BbfA6arpcGSYeUn7I2urVL7h+rmjIJx0hoJ4WQBiU2GTN+OaOuxb5
         DzwQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768413563; x=1769018363; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l16mAKGChN2PX3pOsEUpJwNSJXDy5Uc5IHVR3AfNsDg=;
        b=qiqc/Nk660WLOoDFyGDVOMPjG344Dsvku01wK5HzHgi3ko5RbWxsSTSXh/sPWeh+aW
         mgOKFYt7tOVv7rYj6m1JEeHBaWkPT79i1Kpgw4E5QWrhLSV2zXHW4NE5i6KhcXCUB7Z+
         C+SwxaAetyxzRQlF8L9EjkfZRrRPklYV7qMbVipM7RRHPCBE/cbuB8gBffert622UkZc
         tYVtSi21SP4y5WEKkmvXWg0IVHSmFP9znS8JKft9hXMSYa2CAZH5EVaZecNFNgZZ3XNf
         VFWYSHSz6y68s4FHaLDbCbHtTzDSpTItfcTOxQ2Je/x533sWpefAvbZ+la0OTgauL7+M
         LLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413563; x=1769018363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l16mAKGChN2PX3pOsEUpJwNSJXDy5Uc5IHVR3AfNsDg=;
        b=kBUI1pmkoUpWDB6Q7JO6Z4v2/tTob5RSV5BHdzzGJPhrrKQidU6Kq4jKdcP30gwpuS
         eLRYzTtchU250aFJZTBohmZt3NJgg7bh+dc9lPPpnlHdcpvekKiYtZFuV1FrPDCrRkgH
         7a6LY0nWNb3rEwO79312MjYoAYIqhvYB9e3wh727OZEqyrl+T7nICjwF8SYN8FDyXdW0
         BAu/HgIaWZ7Cb/PLs26jq5e3QmSWxR2LCU08QzDH3jGQz1V9rRfDhUHTB5k9rfku71a1
         ubr9H0W5oRwomR5ETZoNcwq3ChxzxPs1H5hUQ/uRFPAo1c+0AWq+s8MCb1TxVnY1C3+0
         OhmA==
X-Forwarded-Encrypted: i=1; AJvYcCXX3dSjKY2nfpg3j/Mszm/0cfQegmGMQrLsCypkC2caQ2QBwK/4MMi3zKdGrKoGnm+iskjXnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOiSCPkN5bSfaWDRZ17BtV7ME+fCzOa67VC+BNGYRB8wsU/UmY
	XokBqLn25yorPFOIPEKxVw/Wmrld824ybiHeg1tnJSMW1KVUs5pkD1X1TTVvE5cfOpWxh8gI9Uo
	+poM2qR7GwaWiyRhr0hCX4/kUMAXtCATubs7XT67h
X-Gm-Gg: AY/fxX4khMOXKAE6kn5DcOsce9ROmnpDUtBCcfuLcwdPOZP2edrD5UwTcemk8f40StA
	6z11sIs+08LbilHkEaxXd6laipOin6mDsZO2NBTZVEJz0Ca0TNyeSGpQlVHStxn3g3/HddjtIaO
	P4tmDyotN2sl2pVMpbY4nN1aqArK9J5IGdg/jkB/kaTnQZYD0VKT+2geIoNGcGBmxrgMIfAAlDo
	IxHFfEgqqt5huQvouAq38ZhKMAbzWCZ8f2P7Fj8CIcjbV5p/uJ+d02SvqOHBsbYE/cx84yfB/7a
	U2tY9/yP6suF+tcUe6DAV/rTZg==
X-Received: by 2002:a05:622a:1187:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-5014821f599mr13933411cf.12.1768413562436; Wed, 14 Jan 2026
 09:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20260113033403.161869-1-ranxiaokai627@163.com> <2vxztswoi16k.fsf@kernel.org>
In-Reply-To: <2vxztswoi16k.fsf@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Jan 2026 09:59:10 -0800
X-Gm-Features: AZwV_Qghg4-9vnb6fryrTxvM74mMBwrbkqD9jDrCoYrfZdn-SMnNF6tTLNYP5B4
Message-ID: <CAJuCfpEwa=_fubhf5wBnFKrKpOgjyXRy94f2BDx38x_NALE_OQ@mail.gmail.com>
Subject: Re: [PATCH v2] kho: init alloc tags when restoring pages from
 reserved memory
To: Pratyush Yadav <pratyush@kernel.org>
Cc: ranxiaokai627@163.com, graf@amazon.com, rppt@kernel.org, 
	pasha.tatashin@soleen.com, akpm@linux-foundation.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_095925_226069_1FE7B101 
X-CRM114-Status: GOOD (  25.60  )
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

On Wed, Jan 14, 2026 at 8:55=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Ran,
>
> On Tue, Jan 13 2026, ranxiaokai627@163.com wrote:
>
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > Memblock pages (including reserved memory) should have their allocation
> > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> > released to the page allocator. When kho restores pages through
> > kho_restore_page(), missing this call causes mismatched
> > allocation/deallocation tracking and below warning message:
> > alloc_tag was not set
> > WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU=
#1: swapper/0/1
> > RIP: 0010:___free_pages+0xb8/0x260
> >  kho_restore_vmalloc+0x187/0x2e0
> >  kho_test_init+0x3c4/0xa30
> >  do_one_initcall+0x62/0x2b0
> >  kernel_init_freeable+0x25b/0x480
> >  kernel_init+0x1a/0x1c0
> >  ret_from_fork+0x2d1/0x360
> >
> > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> > fix this.
> >
> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation=
")
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index cd6b3fb9dcae..2d47f2c50bd8 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t ph=
ys, bool is_folio)
> >       else
> >               kho_init_pages(page, nr_pages);
> >
> > +     clear_page_tag_ref(page);
>
> You are only clearing the tag for the head page. The tail pages are
> still un-initialized. Is that intentional?

In the case of a compound page we set the tag only on the head page,
so this is correct.

>
> What about non-compound pages (the ones you get from
> kho_restore_pages(), aka when is_folio is false)? Do we need to clear
> the tag on all pages in that case?

In the case of kho_restore_pages() we call split_page() which calls
pgalloc_tag_split() and that propagates the tag from the head page to
all the tail pages being split from it. However now that I'm looking
at it, I'm not sure pgalloc_tag_split() works correctly if the tag
reference of the head page is CODETAG_EMPTY. In summary, this patch is
fine but there might be a bug inside pgalloc_tag_split() if the tag
reference is CODETAG_EMPTY.

I'll analyze and reproduce that case. If it indeed has the issue I
think it's easy to fix it by creating a specialized alloc_tag object
with alloc_tag->ct=3DCODETAG_EMPTY and  make __pgalloc_tag_get() return
it if the page's tag reference is CODETAG_EMPTY.

>
> >       adjust_managed_page_count(page, nr_pages);
> >       return page;
> >  }


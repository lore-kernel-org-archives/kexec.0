Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A2CD2502E
	for <kexec@archiver.kernel.org>; Sun, 11 Jan 2026 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zh1Ea0sfF4/38JW+s4dYkrfqw9VrXtKXyOq/yVBUD38=; b=QsQev6AVMG82E+hLytrdQxykNy
	GGvV2e/ZNLnDUhL/lX5SSr4aqewKqVFPDQn96Meby0jGsS7cT2HzXwHTcQalUmkTrVJHoO9PWedCU
	lBZZ6PUxQ+ldKD4oXCHb1ngrOFPAZwIvmxBJP97z6e+AzciCC7XC6M25P0lmhHjqs+y2Z6gI5xtV8
	s7X1qLP+0SXNCLsVhYOotb1dQU/gssB9ggFfxQEvO9bGPsENg6WEiW3vDqhrbYsgqMpqJAtKge23Q
	Z46uBmJ/rdLDlhakig4XBDPDnnnr4+ZzVap3fztpg4Vns7exb2ts1G/xf7s/LEGMIvrVt97Gd/wIU
	BZnIMOQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf1Zt-00000004ShF-2U7l;
	Sun, 11 Jan 2026 19:58:21 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf1Zq-00000004SgZ-3Wy7
	for kexec@lists.infradead.org;
	Sun, 11 Jan 2026 19:58:19 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4ffbaaafac4so598571cf.0
        for <kexec@lists.infradead.org>; Sun, 11 Jan 2026 11:58:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768161497; cv=none;
        d=google.com; s=arc-20240605;
        b=e9bNyNusUK2Ml7K4TRjl8YzwhcWVBY0fyDG7ujY8jFp1WULjFtU/N8L3ZOSj1WOV2w
         VS8DFkvKS4oMl2VpRUTF3X+PGmc3l4BB4LqaggwW0Ubo/XgSWpviAycsWn98B+fj08t7
         bxeBmxXpjze1mSetfI3VjZcBBKDcOSeBPd6Igrbd/Pv4Nf6q+cIw1wZo9u4NdOpyuvzO
         Rla4tHdK72ocHyjfyhL5dPIQFNgPq7SyxqB6McfynFgafDMR1ziDNUMWiPrz9DDtjLbn
         n779epAjB7VIKzrx/Bp0/y9QFl1gQyyZau29n6ZfM1vfBeFuAAp+jGRFx1F87TYiCRzI
         DZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zh1Ea0sfF4/38JW+s4dYkrfqw9VrXtKXyOq/yVBUD38=;
        fh=R9jmA+GTyaE1aZiMZmYN1teC8qlChgX7ygvFvF1m+PM=;
        b=aZipA8Nu7IJJPJZ9dLeyJX7GKz3+/KpDOVCHsUlZ4jnuXdRiPLGCTWyxrLwnqU3Ww5
         sqZhEAMIbmVD7V8hFeN39b7LKpShEWBA0Cj7EjlRhxNPoOEbnQYMGFtdffcX2F/bC/Zu
         cCglH2U09FcHReBX8IqeugtbDP+2jhUT5o3Wx3me/52y/O0eHBGQVArsI0QVJSr2UiDd
         b/EdjHml3akj1DnJRSZC5YfAbVvNptB38YPiPddlM8jWOu+JfocAQRQqjJt6qCX8BCVz
         4hr1g5ifn06N45ejexZwjNXBNYgaVSdnsudojBAcfq/F1ufBftbYmJa9+fdjF5gGxEPj
         u0ZQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768161497; x=1768766297; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh1Ea0sfF4/38JW+s4dYkrfqw9VrXtKXyOq/yVBUD38=;
        b=QEhrC/lfOua1BCGRbs9qEk85gmCzno6bfgiIgD/EbONFqpHkXtR0QsafnFHuU/iF/g
         NrgxWZMqnYIi61zj7TIuItWPUbam9Ti6d2ywrModR385oDOv4vdZxOyNfoMPkmUX1fnZ
         DZVd1jrnKDyAVXJqt30Yji/qyXllaYFWymdHUynxN9Gf9vADJWC0h+lF7vGT7lrdWme1
         23GxzTs1lAUrOpgM3w1nMiL716L+I5OrpVdPykKAhQf1VZVIxZzCZ56uCLrtJbKbf36L
         cls3usZVOHSPuZjT0DYB5kqbMjhr6LfXn13wd3wYWX4Y+OBD2ZOdCuUuJT9EZUy9O+gv
         Preg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161497; x=1768766297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zh1Ea0sfF4/38JW+s4dYkrfqw9VrXtKXyOq/yVBUD38=;
        b=w/TQLEQmbBhLj//Vq04JesNboPVPK96R2DdOtivCQIi/e0nYqWcARnUwKRRxKrBQ91
         grh9wCFeW91FTbgMFQuQ08xDl8O4uTiOiTlzw+CqZchht9L+fyPohoMaI5b/d8JxqpP+
         RvMuvMnHDtmeHe0VnsaVlYBGd/ZygllN3vNaNBGsrH3SrTVRHFsexBFH7fTmydH49GnJ
         rcukAtW4eUHBWQIvOBbaTglPcYNkn1hjjWmz80LMiKhuWXJGOWmL06KWWIeJKxU0bG8a
         3K/MBy6FjYansiAymX3Tm11f8zMQfblGFUJKdJm2mUoahuBDs8QQ4QR0iqX6WfpCzj+1
         M1hA==
X-Forwarded-Encrypted: i=1; AJvYcCV4YHsCKsfcHS//0Q+zQu2lW6irRciNSHoFc9q7zqcctX/dR+R8lN0DJ3IBdKb7TY3epy0B0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWC6Dgq5yasyfNGz19FbqK5aRwEDtXEexbHA24oHr7Ar5eo0QO
	1bfJBmGKgXkNtymewJb06TGhq+WDWaH1lDYWkcxp/8Nv8EJUA3wrQ59+r77eONDBabfaFlt3iFa
	WgBXOMM3ZCTAdKolimA1vI8yf2ApYEPsh9HqsYfHS
X-Gm-Gg: AY/fxX6zIrRNdhAR2EQUDFWPFvUx/WhtDsg3x/tq5sVAFRszgKsh9w17PoJ3kwpgSfE
	z8SMDIUrUxc7x2vu71etr0UIUENaEEjejFKqTNx25ms+UIUKXoRzZgX0UIGbOhlZBDvY1M0ywYZ
	EV7W2PplmuST11Bzrl1YjoX00Mt4Vu68qvYaWcazS/sbl/N2vVoUssFjtTNI6N0IDVkBoW7ppVI
	0xKXR81Ple+vgjlfdt/RKeHO/QHxJktwAp9q6LjW77UQvsM55/jw7XVZzgmacrxECC39w==
X-Received: by 2002:a05:622a:154:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-501196a752dmr12278101cf.1.1768161496290; Sun, 11 Jan 2026
 11:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20260109104251.157767-1-ranxiaokai627@163.com>
 <20260110162843.ecd8e731bdc281f4cd8e4764@linux-foundation.org> <aWNpTnZKfjb6yLHp@kernel.org>
In-Reply-To: <aWNpTnZKfjb6yLHp@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 11 Jan 2026 11:58:04 -0800
X-Gm-Features: AZwV_QjBBqi5O0NpGPsTawGom2tk53BMZOdWMw0CfFJcH1T5LPOizAOCapIckHs
Message-ID: <CAJuCfpFW+o9LR=VsCPX1XONb859G0QshWyK9NmCt43JEk9+HKw@mail.gmail.com>
Subject: Re: [PATCH] kho: init alloc tags when restoring pages from reserved memory
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, ranxiaokai627@163.com, graf@amazon.com, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_115818_886704_A94555ED 
X-CRM114-Status: GOOD (  23.67  )
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

On Sun, Jan 11, 2026 at 1:11=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Jan 10, 2026 at 04:28:43PM -0800, Andrew Morton wrote:
> > On Fri,  9 Jan 2026 10:42:51 +0000 ranxiaokai627@163.com wrote:
> >
> > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > >
> > > Memblock pages (including reserved memory) should have their allocati=
on
> > > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before bei=
ng
> > > released to the page allocator. When kho restores pages through
> > > kho_restore_page(), missing this call causes mismatched
> > > allocation/deallocation tracking and warning message:
> > > alloc_tag was not set.
> > >
> > > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> > > fix this.
> >
> > Great, thanks.
> >
> > It would be helpful to quote that warning message in the patch
> > changelog, please.
> >
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t =
phys, bool is_folio)
> > >     else
> > >             kho_init_pages(page, nr_pages);
> > >
> > > +   clear_page_tag_ref(page);
> > >     adjust_managed_page_count(page, nr_pages);
> > >     return page;
> > >  }
> >
> > Warning splats are pretty bad and it's desirable to fix this in
> > previous kernel versions.
> >
> > To do that it's best for us to identify which kernel version(s) should
> > be patched, via a Fixes: tag in the changelog.
> >
> > From a quick look, it appears that Pratyush's 12b9a2c05d1b ("kho:
> > initialize tail pages for higher order folios properly") is a suitable
> > anchor, what do people think?
>
> I think it should be even earlier:
> fc33e4b44b27 ("kexec: enable KHO support for memory preservation")

I agree.

>
> > Meanwhile I'll queue this up for some testing while awaiting maintainer
> > feedback.
>
> --
> Sincerely yours,
> Mike.


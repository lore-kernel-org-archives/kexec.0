Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F6FCD4F3E
	for <kexec@archiver.kernel.org>; Sun, 16 Nov 2025 05:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pjcLQP3ZDHp6twNylqR3Sw+tWbznJ8lJtAsn5ePnKEo=; b=K7jfkMtQo6W2uHnjncuRSanZ/N
	6iTWM8tp78nl/M8Z3Vdh5vgilQ2+rx8874EEKoy6kbmERZsSir0jZL04Y0wPAXGSIjJVzv6QxmT5X
	fTYqzk5OO1PG+WHx2U/QLrZczD6aWauafwvjdcteZrBckjAJ1ii/xNJorMmEAzdWKrnnOeNdVQy1H
	8qXm0Y6E1dWfnGgm94NVpikkZNH0uXo57ZftOg/UFFO+TkrsO1UZKONOjkgHHR7F3l+7hq73DD9zy
	oMLT2CqbQYrCgT4eb3xU/57H1qdnBCVmqjhgddV8i99foEvq1Onu/dPqFMmqenkzue/3X44a/UVSx
	mUWAGUiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKVbR-0000000EOFm-2C43;
	Sun, 16 Nov 2025 05:47:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKVbP-0000000EOFb-29CP
	for kexec@lists.infradead.org;
	Sun, 16 Nov 2025 05:47:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B5B060183;
	Sun, 16 Nov 2025 05:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BC3C4CEF1;
	Sun, 16 Nov 2025 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763272024;
	bh=VhOMKlmPNnj++jPAfsYIirLTiTxgnvzCapK9dNUeqh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3PCgUrwougN1zKXC/ev3tHuCXsaagLLqRXl/9tu2Vy+Q5BYNo60sdkckcgpRRkRU
	 QW4GB0Kd8l9K7CfxK6inwHkofGiAJW4FCHeX9iPcQVgo/2k1VUB/URuLhPJUhHeJMH
	 XjA7bpDP3ojHGNPeh2+YxcLCr3gLbA6dhQUbSqLpXKPoR8yD9tLi8PcEySBcqGGArm
	 3AwRNFOA6U+wc6hui7nDl+xEkKE4EQKLe51hmRd2T41pI/OG+VIwz3wOT+ChDSUKpD
	 Ze0N7ubs+fQL1k5c6JGtCaiVCWqdgSyrp78MXINMZtvweJweSkHQWElSAcwwUKdIY0
	 MZcJyLTcQl76Q==
Date: Sun, 16 Nov 2025 07:46:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com,
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca,
	ebiggers@google.com, graf@amazon.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 10/13] kho: Update FDT dynamically for subtree
 addition/removal
Message-ID: <aRllULpK1wxZyY23@kernel.org>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
 <20251114190002.3311679-11-pasha.tatashin@soleen.com>
 <aRhKeXM5iAswD7oe@kernel.org>
 <CA+CK2bBnEKk_mQOCfDhnqbUCovLCKhFw-p54Q4_Sutk4oieOVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBnEKk_mQOCfDhnqbUCovLCKhFw-p54Q4_Sutk4oieOVA@mail.gmail.com>
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

On Sat, Nov 15, 2025 at 09:51:07AM -0500, Pasha Tatashin wrote:
> On Sat, Nov 15, 2025 at 4:40 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Nov 14, 2025 at 01:59:59PM -0500, Pasha Tatashin wrote:
> > > -     struct kho_sub_fdt *sub_fdt;
> > > +     phys_addr_t phys = virt_to_phys(fdt);
> > > +     void *root_fdt = kho_out.fdt;
> > > +     int err = -ENOMEM;
> > > +     int off, fdt_err;
> > >
> > > -     sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
> > > -     if (!sub_fdt)
> > > -             return -ENOMEM;
> > > +     guard(mutex)(&kho_out.lock);
> > > +
> > > +     fdt_err = fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
> > > +     if (fdt_err < 0)
> > > +             return err;
> > >
> > > -     INIT_LIST_HEAD(&sub_fdt->l);
> > > -     sub_fdt->name = name;
> > > -     sub_fdt->fdt = fdt;
> > > +     off = fdt_add_subnode(root_fdt, 0, name);
> >
> > Why not
> >         fdt_err = fdt_add_subnode()
> >
> > as I asked in v1 review?
> >
> 
> Oh, I missed that, there is a slight difference between the two:
> 'fdt_err' only contains FDT return value, i.e. error if negative. The
> 'off' on the other hand in the happy path contains subnode offset, and
> contains error only in the unhappy path. This is why I think it is a
> little cleaner to keep different name, however, if you still prefer
> re-using a single local variable for both, this is fix-up patch:
> 
> diff --git a/kernel/liveupdate/kexec_handover.c
> b/kernel/liveupdate/kexec_handover.c
> index 224bdf5becb6..81f60ccb2dc7 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -713,7 +713,7 @@ int kho_add_subtree(const char *name, void *fdt)
>         phys_addr_t phys = virt_to_phys(fdt);
>         void *root_fdt = kho_out.fdt;
>         int err = -ENOMEM;
> -       int off, fdt_err;
> +       int fdt_err;
> 
>         guard(mutex)(&kho_out.lock);
> 
> @@ -721,14 +721,14 @@ int kho_add_subtree(const char *name, void *fdt)
>         if (fdt_err < 0)
>                 return err;
> 
> -       off = fdt_add_subnode(root_fdt, 0, name);
> -       if (off < 0) {
> -               if (off == -FDT_ERR_EXISTS)
> +       fdt_err = fdt_add_subnode(root_fdt, 0, name);
> +       if (fdt_err < 0) {
> +               if (fdt_err == -FDT_ERR_EXISTS)
>                         err = -EEXIST;
>                 goto out_pack;
>         }
> 
> -       err = fdt_setprop(root_fdt, off, PROP_SUB_FDT, &phys, sizeof(phys));
> +       err = fdt_setprop(root_fdt, fdt_err, PROP_SUB_FDT, &phys, sizeof(phys));

I missed 'off' here, never mind

>         if (err < 0)
>                 goto out_pack;
> 

-- 
Sincerely yours,
Mike.


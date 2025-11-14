Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DD7CE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNYC6T9taYLQmC4NDLJeJFJYG67obOWlv+u1sIQ+ETY=; b=bR5tfDAnkAzxiL4CtNOpbbrHe0
	a/vZR+15mdHcLW7KO88Do/GfYY675tmaZtQx6lG+rMMD50huk1C+NVp6daXw1kXv9bUfVPkATz4+4
	bD7QQ6B/wQweZru9d5YqAUpEkmxupBZ5lrV/Z0bFKtapvZ1zS+ZMnNhUHF53C+RN62WW32Z8S5k2k
	gCCSUIAlMW2rhVHsYULYAWOKhyI3qCGaGc89uIxL7330vgSpo90z7OhnlKI+AHWilC7xG9s26OoB5
	VaQ1pU2Y08uSxcCKpL5r55U1/j83g4P14vyIc3QApM161th9tBIWFtZvZ1mlLo9AHT9tFLXw8jndx
	cPL2aYmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwsr-0000000Ckyh-3KST;
	Fri, 14 Nov 2025 16:42:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwsq-0000000Ckyb-2eui
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 16:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hNYC6T9taYLQmC4NDLJeJFJYG67obOWlv+u1sIQ+ETY=; b=dgd2OGpg2kx2ctQFQjzxqDAPfv
	q7xq0/1PkqthwQqOhF3HpMgj+5+tzmGdSLcAcCZoirnwoVfeLL/bx9HFMjEXlX63UtQKKPLnyfzo0
	SubiLHZpDLbwMVZZIR8N9uYCo5CHpxJ2MRUWwIDBL53C5HRDb4IWmEBog65Tj7NsXPuP5h+zGIjkr
	pFkaqwLfS28OHNDulJynCYeqT8XDeGScTN62bRsqGaIuntHMp9oyY7B0WaD3xBjmh9HpW/v+Y3UOF
	KgIbKULLK8YUQIikiwJsmx2xn+HX1aDZff2N9yal84yhZV15Bt3SXtIgKj5zBikGxwcB7z6tSxBqh
	h+/VCSPA==;
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw18-000000030xY-1y58
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:47:20 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so3098809a12.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 08:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763138563; x=1763743363; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNYC6T9taYLQmC4NDLJeJFJYG67obOWlv+u1sIQ+ETY=;
        b=W7k9Wsh62r57OAhlmsqddFRplrWfcimCbLXzl+CIhquzwqCiqtUc3DZa2zbL1+SRQE
         z4IJ5d0vY/WYg1a5KZY2CLBpEUJJDtWKX8v29hNSf5XZ0ZnE41+HY5ozRkGnxVP81Q5g
         Zc4iA8X4YcNkxgd6ELAh4DGXldAcElAZwTwiZwUMwerNaZsS+5cwHTGPmqmz4U6bfBIo
         Ksu9jDWI+TvTznxF1nN5XynIw/i4XDHvH+qNROeF3KVYz2K8vMDrzQduc89RqbOWp1h8
         BTQ6uokInf/tyPVntap/QJeUcQ+YXEDShJjh2OhL7v9BWs/kO+ss9y1MQrBZWJ6JfZrr
         Qgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763138563; x=1763743363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNYC6T9taYLQmC4NDLJeJFJYG67obOWlv+u1sIQ+ETY=;
        b=ohq88EZqjPY+Jmj0in26Ygme2SeiqUj8UAhu5BoerIpkbjidTss+e0z8oUK8aLEgPD
         FaM7emMnh41H3hrfa/8pV+VZD804d40CL4r4ZmJUePgnQHN2ed1A13a0mSqamCdBnw20
         bQPr/gFxVLmOUY0QXRopk285hPCZeXeHylDDw4WJaRC+AGtLskzCUjq97VuQNOh/G1/P
         F9Br8NSC9VgzHB9sBgajQhCoEr7cE0LUaRtwE48IMOd2O5whTUh3xKSCGUta5WBawxpR
         +rDSCFhN+Kk7wbjYuWMTVhfvcZhqZZwQx2luEkK2Cgg3OGAVwtVimGRrZu+Lz9rN9t71
         md3A==
X-Forwarded-Encrypted: i=1; AJvYcCVabKTFxmZ55sq9L7W+n/Y5eAkXkgTOCHRZw6wM9pyzwMCOlyDf6ZzYUEJ+PykTKuy0BTiw7w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCQqnbzqBnAnM3p4CJ+8AL0h4EkcxDDvzRQpE2g7KrRk1kCZun
	zVJisoSY4HrhovG4+RDrrpbumOnAQqotB8LRGuC2PjAK/K/kel5JYqbhuYoYDFQNl+YBUXRXeKp
	9OXyTkNuHhkHXBq46rzNVzgE6DVKeqhDfdJ/qWDHIUQ==
X-Gm-Gg: ASbGnctgPImoa3HNIyL8KEy34WNd6dZiijQX0GK1f1vd0SQL1d0Y+b2SdLd0/u9uZAm
	KyTkrOJ1amxR/wT+6lrJqC+VNcB78RQrapIYHVVIWZVJGI16bKuDN6sCwpNp0X4N57naudRwzFC
	/I+nLv9ZNNsOfujvdcncBu4Ygx0q6NtPByNJSmoIQh54gwBEbpNPKcx7jhDApaaW5Npyw80bRhj
	AN2x4KC9s7YaUApVSN5/LgcCXjvxQnc+JLXXbaxdztjpMFdHunqeYvRQXWQJZAILcyQ3nw0VX08
	tgg=
X-Google-Smtp-Source: AGHT+IHlfh4YdqFOb4m8lf+EaR+1dZhpIJjcSDucXM3q8/9kzn/c1d1ehTKfSLxh6hZh8WmQ8CCr+tqptNyxuPatxRM=
X-Received: by 2002:a05:6402:3507:b0:640:fb00:9b0b with SMTP id
 4fb4d7f45d1cf-64350ec2ff9mr3541795a12.32.1763138563523; Fri, 14 Nov 2025
 08:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-10-pasha.tatashin@soleen.com> <aRdVn-e3Wu_pFdmZ@kernel.org>
In-Reply-To: <aRdVn-e3Wu_pFdmZ@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 11:42:07 -0500
X-Gm-Features: AWmQ_blP7H688ljOem3Nsegg0ERAgHCS_X90A9If73ZSR4mI64llwOx6i_IsE_w
Message-ID: <CA+CK2bCHoHRX9wM+hF-G5G2prVYdDSWzLETPmVXooKsXda5xbw@mail.gmail.com>
Subject: Re: [PATCH v1 09/13] kho: Update FDT dynamically for subtree addition/removal
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com, 
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, ebiggers@google.com, 
	graf@amazon.com, kees@kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_154718_681799_5ACCD253 
X-CRM114-Status: GOOD (  23.06  )
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

On Fri, Nov 14, 2025 at 11:15=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Fri, Nov 14, 2025 at 10:53:54AM -0500, Pasha Tatashin wrote:
> > Currently, sub-FDTs were tracked in a list (kho_out.sub_fdts) and the
> > final FDT is constructed entirely from scratch during kho_finalize().
> >
> > We can maintain the FDT dynamically:
> > 1. Initialize a valid, empty FDT in kho_init().
> > 2. Use fdt_add_subnode and fdt_setprop in kho_add_subtree to
> >    update the FDT immediately when a subsystem registers.
> > 3. Use fdt_del_node in kho_remove_subtree to remove entries.
> >
> > This removes the need for the intermediate sub_fdts list and the
> > reconstruction logic in kho_finalize(). kho_finalize() now
> > only needs to trigger memory map serialization.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 144 ++++++++++++++---------------
> >  1 file changed, 68 insertions(+), 76 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 8ab77cb85ca9..822da961d4c9 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -724,37 +713,67 @@ static void __init kho_reserve_scratch(void)
> >   */
> >  int kho_add_subtree(const char *name, void *fdt)
> >  {
> > -     struct kho_sub_fdt *sub_fdt;
> > +     phys_addr_t phys =3D virt_to_phys(fdt);
> > +     void *root_fdt =3D kho_out.fdt;
> > +     int err =3D -ENOMEM;
> > +     int off, fdt_err;
> >
> > -     sub_fdt =3D kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
> > -     if (!sub_fdt)
> > -             return -ENOMEM;
> > +     guard(mutex)(&kho_out.lock);
> > +
> > +     fdt_err =3D fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
> > +     if (fdt_err < 0)
> > +             return err;
> > -     INIT_LIST_HEAD(&sub_fdt->l);
> > -     sub_fdt->name =3D name;
> > -     sub_fdt->fdt =3D fdt;
> > +     off =3D fdt_add_subnode(root_fdt, 0, name);
>
>         fdt_err =3D fdt_add_subnode();
>
> and then we don't need off
>
> > +     if (off < 0) {
> > +             if (off =3D=3D -FDT_ERR_EXISTS)
> > +                     err =3D -EEXIST;
>
> Is it really -ENOMEM for other FDT_ERR values?

In practice, yes. There are some other errors like format mismatch,
magic values etc, but all of them are internal FDT problems. The only
error that really matters to users is the -ENOMEM one.

Pasha

>
> > +             goto out_pack;
> > +     }
> > +
> > +     err =3D fdt_setprop(root_fdt, off, PROP_SUB_FDT, &phys, sizeof(ph=
ys));
> > +     if (err < 0)
> > +             goto out_pack;
> >
> > -     guard(mutex)(&kho_out.fdts_lock);
> > -     list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
> >       WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false))=
;
> >
> > -     return 0;
> > +out_pack:
> > +     fdt_pack(root_fdt);
> > +
> > +     return err;
> >  }
> >  EXPORT_SYMBOL_GPL(kho_add_subtree);
>
> --
> Sincerely yours,
> Mike.


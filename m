Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C1CCEB2D8
	for <kexec@archiver.kernel.org>; Sat, 15 Nov 2025 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rIydVfx8R0TzH1/4QIZdK5YhW2r+O6Ifbkqz8pnbgWA=; b=FQyhWqEKyzVvPJY+BbwUZ9MUZS
	cvwT6X1eKuwv+WnNX8kHOSN9vW4ztHpiE5YQBAWglYsaHFwRzvaiw4UFxZvCcDz90/YmzAKdauXvw
	ujpTtpnspUBwe5b+gOFcD+bUCjqCPvHGVDj9iXsvLW8uDdL8wBkNe0RLbv/RQQ/9tR/8JaJgVFbbJ
	8iwd8wOy3UuDwzeubA5ugL5n8gMUkC8sevCVgzab6ZiRSzWytaNev1yZPFTxF3nAr47mE7dVOwnKe
	XW7lT6IrpLiVAnbqgFweawy1EMWVx6un8sCqkmjxb0ekD0aI+8mrEIsfSUueMpqog4Xrn18OTZSEF
	XWxpQc9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKHcz-0000000DreM-49Cx;
	Sat, 15 Nov 2025 14:51:49 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKHcx-0000000Drdw-2y5K
	for kexec@lists.infradead.org;
	Sat, 15 Nov 2025 14:51:48 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so5061775a12.0
        for <kexec@lists.infradead.org>; Sat, 15 Nov 2025 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763218305; x=1763823105; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIydVfx8R0TzH1/4QIZdK5YhW2r+O6Ifbkqz8pnbgWA=;
        b=ZFU0fNq8n97nGoO4Itopm3E9xgBv8xoLdkpUykBAFYMgXO2OeZYgkCKgpQ5d+k6v8P
         z7en262PSWTnJWxNA+XFh2MyibBNCtMPOaAOMcrMeCVyJhbC3E7EdKgwxVll4vEl9i/g
         MMnLwhQsD/ZD3Im8z052mLoMam3UfcUX56rV20x+JfswS5rFDCjJ4TmeqVa4vwWIM1lV
         WLSI+abe0Rwapc0clvxZXxQBnvNECYh9fwNNeSugMNrX1Mj5wa5RARUnmUqQNp8yvYfT
         Y7CZwvTzCgrLkjcW5VAHGNGyleSzJr/EUyG03t/wATjy4/jA3O2o+hLb63h+Sy3pnxYT
         f0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763218305; x=1763823105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rIydVfx8R0TzH1/4QIZdK5YhW2r+O6Ifbkqz8pnbgWA=;
        b=g98lqexY/NRw9qKsdZ1gFMWVffs1PM6oguvh3f7taoLLg+tEpY4vwul1JB/MhJ6uJ3
         UHVCtqkAm6XVREcpstw5MNCSC3xUkYFwCmXqVRSygKNcfgkyn+wAqG+M4jhouBTvHjt0
         dosTywMNGf9l0+Gnvp6K5sL+cu4e0sEGmnFwC5RslFMWBXNZ8DUVVrYDabkZ/mDif6zZ
         8fc2jvJ+ALNpCD0ydLt/TRoI17aH2X3MwUFAfmkBE57JaIC0ygkyFSP7jXUh88GGIwpJ
         DMie7UDtOb8etH6eBng67SwqIFoiCSiyj5DgEMRgIgDC6UJgCTZBSzMaqhVg0WXvnYtW
         XIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpc6+2WmqCfJvQdJ+A3JOvny/h+ychuG++Kdg/ApEbillIpuDg5f+12ATziN2qDec35UKAgQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyU29U8/ekxFT0/UA4PaCdSRnx5sQzQ+4gGRviwFFM0Fr7CZw5j
	nLd1n7i65JRJw4LmI2YUVIHo9m3Uu4atoA6TBWvMc9Xaqyck4IkCsHXGJnE5C9noeksWMEOWf26
	iQWkwCaNhrlTQRLVW+gXYBSNbj5bW3dQ47VXH4d20Rg==
X-Gm-Gg: ASbGncs4fsD7K3Z7AIKQs40vW3hX/npuFtFpIucQOORnrXckMjcjYzABN+oAViM4sBw
	kzeofL7hlvh/gvdN1AsXQPjjPRnpHxFzgc6jnUBaBT/OjZZPbMmkjNrKmnswQvEUvlBVqD1aMri
	Ay+alBs2hr4EIVLBtwyujoI+Jz32SALtTe/UYEpnzH5ljHbnBs8FM3/PmOGeSyPfS+8Cu9MPbAW
	1ce8SgPkPdViYJHMitduhD7Ji2Jl2LjNk6UXPdaKVzxg8K8Z2bgJuQVyBuLvMIiQn5dJkTTDgAg
	ZBQ6U1gxhD42w9pB
X-Google-Smtp-Source: AGHT+IEQMTcydSOnSXEZk6d6DShEuKVDmQ+Bt+sZ1KHZZQpJpDG5mcJNdHvQHscSrYwgga2nJvO8Tcun1n9K19t88R0=
X-Received: by 2002:a05:6402:2742:b0:643:8183:7912 with SMTP id
 4fb4d7f45d1cf-64381837d5fmr414948a12.9.1763218304333; Sat, 15 Nov 2025
 06:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
 <20251114190002.3311679-11-pasha.tatashin@soleen.com> <aRhKeXM5iAswD7oe@kernel.org>
In-Reply-To: <aRhKeXM5iAswD7oe@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 15 Nov 2025 09:51:07 -0500
X-Gm-Features: AWmQ_blhrf5vCj-730ss7a9AIJUQQXQW4QkjWD0eNWJZG1ouYtdeYt5sPgpeEXk
Message-ID: <CA+CK2bBnEKk_mQOCfDhnqbUCovLCKhFw-p54Q4_Sutk4oieOVA@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] kho: Update FDT dynamically for subtree addition/removal
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com, 
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, ebiggers@google.com, 
	graf@amazon.com, kees@kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_065147_765957_ED2413EB 
X-CRM114-Status: GOOD (  14.36  )
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

On Sat, Nov 15, 2025 at 4:40=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 14, 2025 at 01:59:59PM -0500, Pasha Tatashin wrote:
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
> >
> > -     INIT_LIST_HEAD(&sub_fdt->l);
> > -     sub_fdt->name =3D name;
> > -     sub_fdt->fdt =3D fdt;
> > +     off =3D fdt_add_subnode(root_fdt, 0, name);
>
> Why not
>         fdt_err =3D fdt_add_subnode()
>
> as I asked in v1 review?
>

Oh, I missed that, there is a slight difference between the two:
'fdt_err' only contains FDT return value, i.e. error if negative. The
'off' on the other hand in the happy path contains subnode offset, and
contains error only in the unhappy path. This is why I think it is a
little cleaner to keep different name, however, if you still prefer
re-using a single local variable for both, this is fix-up patch:

diff --git a/kernel/liveupdate/kexec_handover.c
b/kernel/liveupdate/kexec_handover.c
index 224bdf5becb6..81f60ccb2dc7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -713,7 +713,7 @@ int kho_add_subtree(const char *name, void *fdt)
        phys_addr_t phys =3D virt_to_phys(fdt);
        void *root_fdt =3D kho_out.fdt;
        int err =3D -ENOMEM;
-       int off, fdt_err;
+       int fdt_err;

        guard(mutex)(&kho_out.lock);

@@ -721,14 +721,14 @@ int kho_add_subtree(const char *name, void *fdt)
        if (fdt_err < 0)
                return err;

-       off =3D fdt_add_subnode(root_fdt, 0, name);
-       if (off < 0) {
-               if (off =3D=3D -FDT_ERR_EXISTS)
+       fdt_err =3D fdt_add_subnode(root_fdt, 0, name);
+       if (fdt_err < 0) {
+               if (fdt_err =3D=3D -FDT_ERR_EXISTS)
                        err =3D -EEXIST;
                goto out_pack;
        }

-       err =3D fdt_setprop(root_fdt, off, PROP_SUB_FDT, &phys, sizeof(phys=
));
+       err =3D fdt_setprop(root_fdt, fdt_err, PROP_SUB_FDT, &phys, sizeof(=
phys));
        if (err < 0)
                goto out_pack;


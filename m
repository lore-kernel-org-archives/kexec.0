Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1120CECD9BC
	for <kexec@archiver.kernel.org>; Fri,  6 Feb 2026 02:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uwKKBAWfianGkgf2dOSPW7sjKHIffak4EwdTz+f+A0M=; b=pqB7x48VE2TvaOGs++ePSVQq5m
	bsEP8N4M2vV0kpimJa5qi+mfLCr1/KtPVOEz/iMHyNonKomxG4ubiJZc7FwovVdwO4hxshf5bPu3N
	hIUuhAhEE3EHqzod0zIrFQr7JXWGdeNq9abg4rOHJsxcrZmOhFgMmlx1gKKRUT8z63SF+MDB6GzSj
	SMQNiA8LLDmnky3qzSnAvlCxjgnIQkaZ3i/5jacTPqCvncZZB1qHFobe+rexyNc9IyVwbnzAxJTPb
	dY7AKZKMA1CUTDeAwiWZHp+HetgHtKQ3abl6WBUsEaQVOxg06Yx3qF4Dhwf4dEDtfEBnaHEJ6G/cU
	e5ij1u1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voBQ2-0000000AkOU-1ByK;
	Fri, 06 Feb 2026 02:18:02 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voBPz-0000000AkO8-2Pqg
	for kexec@lists.infradead.org;
	Fri, 06 Feb 2026 02:18:00 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-4359228b7c6so113104f8f.2
        for <kexec@lists.infradead.org>; Thu, 05 Feb 2026 18:17:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770344277; cv=none;
        d=google.com; s=arc-20240605;
        b=SFIC5S5SLAI50ZzZOblYlLUY5eTIvgz9Nzv8Fx7CVp6Ks3GNdFZMrUy68RgG8s/IFp
         F6wyK53dpoVf8Y1CY4jgwMmotw6zcmSMWnYee2Z9mY88LFbiK6AfaGosYbjopRkdBnt/
         cRtNRrnAq3A8fNq9ytcZJ1euQo58hlNXr3wYFCqB74SKq/ubAkEdo9vtf9v9ixav0Bwl
         lsB0MbxNNZgR9KCer/mlJMSmqvSHsQhTqciHr7epXJdJnDZiHuCHmPaFYb7Q7F2m0C2E
         dJDxxv93kGYnkuP06uVM8B9uOX/yABgfX7K60HFGMiT/Lt6WYb2TCdTlS7EwH5lPGP7V
         jm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uwKKBAWfianGkgf2dOSPW7sjKHIffak4EwdTz+f+A0M=;
        fh=Meq/+Gge5C7AF9J/8TV7yjK3e/nfSJVu/w2WX43rCUc=;
        b=fY6n7ITAYObXuY+mlDyTYGcOCi6Mlthu9RwN918b2QyQN8FZH56FQ4RMxkfyaQAkf8
         u8NsqOOitPw/Rn6fQXCAOdF9v3voM/mxlV2B5QcfeRtoJt46521URCtovoTzQefOPyYy
         7oK1t7+D4VsHjMYvYfQ2qLxTBffYYaMFhnqmjVn0EZmtd2IuZKFKzAUpb8n6kCbbywfI
         TWo+nQVX6/LUZ3+cCDT9gp+hg9lIUZfE6cRjXzcz0Vue1cNqBOBdp3qaQtTmuVueO3CB
         q7ApG7UTZR3WAuLytd1BDXFKA5UmezUVkodyk0E9pkExVeReUa/HZnK/nhi1wQ+HhXL/
         82rw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770344277; x=1770949077; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwKKBAWfianGkgf2dOSPW7sjKHIffak4EwdTz+f+A0M=;
        b=XmIQiP/fFj3GejJZFTXbfuOVq+8DpPW4sLd4h595YlmQvpFIvmdit8S7d/kLrAJGwr
         YOAoo58XG5aoyETsPo8VMH8kSof7OTj0nlroDj9yL06phZrulm9iqybuM0dzKAfehjB3
         Wo5evtIQr6UELMgNzaFTuy7hzo1DnOdQvU3vY+uE5Iyy2ZSLccIxU/Ped3mvvwdQOPIz
         gBv1M7lRKFrNQVujsasNhzp0w8HeiZtHY/w2ZIq3iYO/PCsvkpkD6kVk2/QXaY3JTB/0
         Q9NexRen7e4VnIkCUzFpaCJakRuEBfzIiKmuAec3tY32f1eP1MaWjVvbIHn6HTcStuIS
         TsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770344277; x=1770949077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uwKKBAWfianGkgf2dOSPW7sjKHIffak4EwdTz+f+A0M=;
        b=VbWO6g0/CHw/ig0FN65UIWOIQG1IA3LKjpv42PzgJVQ/otp67KH065DCRSOxbzMRnc
         zo6TPGImniaD/4m7dEsbSJ/yBbnBnrFGhffm7lPGtrRv5imt88q+uwe41d4weN5MWbvi
         IB59xDNS50HD9Uc6Egax6fGVf4Bm5F2Z+BTToNpZCXRJoAsgONiW8TWHvfu55GWwNwVv
         tOTvcv4bYYFyjIqBWDEOKYrbyYvMxzVvmgGKH6IIDurZt/l77rZsuTJFA2MD1UPoSJMl
         km4vtgksTKEw4lvMdqsZ63aBi9pYgC/xinPsoXDTJ6zqFasirqV52SHx/jCWksSsozyO
         f7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX7kvw8umWRY8R2NtiT3ssbS1Jn2NaUic6OU1dyrU+HQigY3b16mNau86wZqrq9a0sULhvktg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyITJvBQd9AIGlZIsW54OA62ru3h3x1sNEJzjrtRV+s8yP60Aj5
	puNaiIIF0C07t8F+q3EP7UPcNWuMBYb8Y6aOJ5wexazRFdNvax/xLfx46GArXf1aNWXhjKkMTK5
	WGex8Fw+5arsJknNEUVi37DuiYO2gnNz05Esib+aK
X-Gm-Gg: AZuq6aK1OayZnt08EqVyXOx8pAyQE1kkQLWrFnfNxZcPRaeE1EhGPOqDtjQJ/obUJq9
	ptB9MDxWN8uecHuy5fJrGDVSTcifYtdmhSQcDW0+ieYBux6NOQzsyoac7kXfUeSuhYPujrcO0Oy
	9nu8YhbUyasFqaSRnVavs2vDd/4xsdGvzUQ/4ztSVltPEJQ+uIyzkyJyCwm4ZflZGasvU1OZ/mM
	gjML5Bu6KtPmA/dVGkGPP1k01fVsA9zGhjeZqbgn9Fg4W5faLZmcUSibOVyQKWVIHj8u5Kl813v
	XP0YTBEwvbpOqER/nMJaQGA82Q==
X-Received: by 2002:a05:6000:430c:b0:430:fdc8:8bbd with SMTP id
 ffacd0b85a97d-43629380f51mr1671102f8f.41.1770344276502; Thu, 05 Feb 2026
 18:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20260130005739.3163049-1-jasonmiu@google.com> <20260130005739.3163049-2-jasonmiu@google.com>
 <aYIfRa5fDBaLVR5y@kernel.org>
In-Reply-To: <aYIfRa5fDBaLVR5y@kernel.org>
From: Jason Miu <jasonmiu@google.com>
Date: Thu, 5 Feb 2026 18:17:43 -0800
X-Gm-Features: AZwV_Qh5kY2CdVbBsORvOJOaIaI4NUYwjHlys7b0_-TweShTI-HzzR29KaFBDN0
Message-ID: <CAHN2nP+xPRYgMyhUEoBoqfwOQ4GZtvDjZf+B6JwoGe4xOSgf1A@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] kho: Adopt radix tree for preserved memory tracking
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_181759_644242_0ACDEF97 
X-CRM114-Status: GOOD (  27.83  )
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

Thank you so much, Mike, I've sent out the latest version.

On Tue, Feb 3, 2026 at 8:16=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Thu, Jan 29, 2026 at 04:57:38PM -0800, Jason Miu wrote:
> > The ABI `compatible` version is bumped to "kho-v2" to reflect the
> > structural changes in the preserved memory map and sub-FDT property
> > names. This includes renaming "fdt" to "preserved-data" to better
> > reflect that preserved state may use formats other than FDT.
> >
> > Signed-off-by: Jason Miu <jasonmiu@google.com>
>
> With minor comments below
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> > ---
> ...
>
> > +static int __kho_radix_walk_tree(struct kho_radix_node *root,
> > +                              unsigned int level, unsigned long start,
> > +                              kho_radix_tree_walk_callback_t cb)
> > +{
> > +     struct kho_radix_node *node;
> > +     struct kho_radix_leaf *leaf;
> > +     unsigned long key, i;
> > +     unsigned int shift;
> > +     int err;
> > +
> > +     for (i =3D 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
> > +             if (!root->table[i])
> > +                     continue;
> > +
> > +             shift =3D ((level - 1) * KHO_TABLE_SIZE_LOG2) +
> > +                     KHO_BITMAP_SIZE_LOG2;
> > +             key =3D start | (i << shift);
> > +
> > +             node =3D phys_to_virt(root->table[i]);
> > +
> > +             if (level =3D=3D 1) {
> > +                     /*
> > +                      * we are at level 1,
> > +                      * node is pointing to the level 0 bitmap.
> > +                      */
> > +                     leaf =3D (struct kho_radix_leaf *)node;
> > +                     err =3D kho_radix_walk_leaf(leaf, key, cb);
> > +                     if (err)
> > +                             return err;
> > +             } else {
> > +                     err  =3D __kho_radix_walk_tree(node, level - 1,
> > +                                                  key, cb);
> > +                     if (err)
> > +                             return err;
>
> Nit: if (err) can be moved outside if (level =3D=3D 1)
>

Updated.

> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * kho_radix_walk_tree - Traverses the radix tree and calls a callback=
 for each preserved page.
> > + * @tree: A pointer to the KHO radix tree to walk.
> > + * @cb: A callback function of type kho_radix_tree_walk_callback_t tha=
t will be
> > + *      invoked for each preserved page found in the tree. The callbac=
k receives
> > + *      the physical address and order of the preserved page.
> > + *
> > + * This function walks the radix tree, searching from the specified to=
p level
> > + * (@level) down to the lowest level (level 0). For each preserved pag=
e found,
>
> Hmm, why do we need @level here?
> Or it rather remained from the older versions?
>
I forgot to remove this when we changed the function signature, I've
updated it as well.

Thanks again for the guidance.

>
> --
> Sincerely yours,
> Mike.


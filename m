Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A87E6F090
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/I6XlXAEilN0X40BgO/Y75hBFwj9rzVL3WYipFqiWfY=; b=j5DkpzlCJv4QokJZEz6XLHdp2+
	blS7lDegeBabdjuzIFGM97KmFgnWrmFIDuKBGQE0mOg/HDMxvOIZyawsHSUqrsOIQ2iK4GqU7oRch
	N/j78Yz6TyZAedCFsDs3DzJjIub539pR1dPGCghsn8nXi8xdunOiNJbqMrLrFiPpOxI7r7M/WHdiV
	T4WA2Ab+N4TxvndX24cv7R1t+wdKxFE+AMabBvhYYfOt9FyVXXMlQbjomw0vibJiHmw97O4CHOMXk
	pZEQUS70UqTAjkDYSn1mll0pAH2c5iFn53Fg8DUD+lUPB5Lr7Ky+ykgOQ/U961dq9I296/RB1f6GK
	KP+pf+GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY2cp-0000000FXvO-2hFZ;
	Tue, 23 Dec 2025 13:40:31 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY2cn-0000000FXuz-1Agv
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 13:40:30 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-64d80a47491so3579765a12.1
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766497227; x=1767102027; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/I6XlXAEilN0X40BgO/Y75hBFwj9rzVL3WYipFqiWfY=;
        b=VYoqgzt3E/X9y1tBBjxnGUNB8/+b76Jnxh/8r0wKQHCUBa0C7dSkgIkpS0exqdMUxB
         FE3W84d2MZqWGlAZFP+acuDJ2hPjIgXxTqC0Jlr8/RXD+5gzvaa86raFw+lypMrfwBpR
         LhH3iiGG6xqwR1A7Sad7gKEh8Z2E2Z5ZaBMqGhAoo29qQaK6gCO041BBqMdU0Z1VedCj
         VsrZgE1pQPkwBFpfxXbOvKj3R7Sw43phVHcAOAKIHsHIK4btkLszchcRrUXtilPQB4bX
         q3naEQx96jFlfr4Gz9R7BxW//HIuAQTeEPXo/1AzEngxDI4N2SNubaqBtOSOvjlFH4jY
         tfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497227; x=1767102027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I6XlXAEilN0X40BgO/Y75hBFwj9rzVL3WYipFqiWfY=;
        b=Chr7jHl49Pvv17cU3cUwOV1nbfV33+LXouVcTG+31Klb9Vy+PgLF2gRfKj6jP4tsz1
         cxZxZF90gUy0FzPbq0B7Hx4WcV3GML86+YylhQlFGlwdMKXAbwFgHVuHNjnA/WhNqhk7
         AWtZwQYZU28x24phOTRh5tBe9XlsuUJ4ld1ayg7WwWyVgj6MxETWeAplVO8H28YIO1hW
         lZCJopu6Ih+OEhDbH8OhDLRe/2gl5L8TlKPU6eA1m3q3+SQNMnL4bctt/9c0gR1GFqLF
         qxAXrK7B/eRAb1qFuFde4uhlB70RAiRIW/y3FH14UNtaKS3+p76QIYSc9I3DbKeZd4PI
         aH5A==
X-Forwarded-Encrypted: i=1; AJvYcCWoQkJXXGRsc0gIfR5FpRwTysMNADwGkUqRcs62OGVoqiQZ6E4iIox22qZ+73VX+dCfdEbjjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyHuPOE5UsJiNxBQvX9DaIlvcHhi5Yo4nnkUscSd2Lku7BY5cuK
	g2CH4fzYRKOdpvYR7w++ef+H7dICHFAN2aQoHywFBkavcaIzVc8Ww1yYVuzp9fuRz/vVi9oCWDW
	zBYh/prLEEVBlfL8klXEZ2AxdPcPIo2tnZXv/lVDb+kX9aTsKG+wb
X-Gm-Gg: AY/fxX7MfeQAsK+guYZyvBWXt8ReXU2tBhB3SpPPyJR4k/nRLkjU3O8uV/a8FbCa+rl
	uFGimdINC60X6Ntd0GrdBxDmf2nmPYExkdR+hXgpxIgLY0ZVfi0+s8M89Wos68ry4JfbwUQrneM
	BdWZP604SSJrjQjtdusI9SEe5GNbTijiiq+Ppy38bRk1sLkAywJ6vAYgcOEhYIy/DMq6TIan3Ol
	QU3T3CyJ63tWhAGjakjZJy6AomITR9NdLOzmBP2eLWde7ua1/KyKfiABcMjYCs1bsvR78us1IHU
	GF26yRklfqvoCEmmxrkPAHAv
X-Google-Smtp-Source: AGHT+IEFQU33sVmeVFLErlX5wqjQ/4hBqKHnBwdxQHFQ80Xv+FpUyXlCV3CzWOpTQJ3IoFiUA/3yOMoYcOwx4IV8FXE=
X-Received: by 2002:a05:6402:13c9:b0:64d:1294:42e8 with SMTP id
 4fb4d7f45d1cf-64d12944806mr11460426a12.6.1766497226898; Tue, 23 Dec 2025
 05:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20251219071209.3696755-1-pasha.tatashin@soleen.com> <867buecxll.fsf@kernel.org>
In-Reply-To: <867buecxll.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 08:39:50 -0500
X-Gm-Features: AQt7F2rhzmWJRK8-ihyTcUhLpQ6OBksFDfKd9ZX8sznEaOMe2EFoKSqVAgzv50g
Message-ID: <CA+CK2bC2BQBgtgudZ3-Tpc9ctJEaiFJjx9gNuysXLU1LGpf6OA@mail.gmail.com>
Subject: Re: [PATCH v3] kho: validate preserved memory map during population
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	ricardo.neri-calderon@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_054029_339534_E7EDBF72 
X-CRM114-Status: GOOD (  17.53  )
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

> > Previously, kho_populate() would succeed regardless of the memory map's
> > state, reserving the incoming scratch regions in memblock. However,
> > kho_memory_init() would later fail to deserialize the empty map. By that
> > time, the scratch regions were already registered, leading to partial
> > initialization and subsequent list corruption (double-free) during
> > kho_init().
>
> Nit: I am guessing the double-free is the scratch regions being freed
> twice? Can you please write that out explicitly?

Sure.

> > +     mem_map_phys = kho_get_mem_map_phys(fdt);
> > +     if (!mem_map_phys) {
> > +             pr_warn("setup: handover FDT (0x%llx) present but no preserved memory found\n",
> > +                     fdt_phys);
>
> Enabling KHO but not using it is a perfectly normal use case. This
> should not be a warning. I don't think we should print anything here
> TBH.

That is fair, I considered pr_info(), but I think you are right, lets
just remove print.

>
> > +             err = -ENOENT;
> > +             goto out;
> > +     }
> > +
> >       scratch = early_memremap(scratch_phys, scratch_len);
> >       if (!scratch) {
> >               pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
> > @@ -1515,6 +1517,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
> >
> >       kho_in.fdt_phys = fdt_phys;
> >       kho_in.scratch_phys = scratch_phys;
> > +     kho_in.mem_map_phys = mem_map_phys;
>
> Nit: not a fan of duplicating information. This is already contained in
> the FDT. Perhaps make kho_memory_init() also call
> kho_get_mem_map_phys()? And while at it, perhaps make it
> kho_get_mem_map() and the return type struct khoser_mem_chunk * ?

I prefer the current approach, fetch from FDT once, it is just a single address.

> No strong opinion, so fine either way, but I do think it is cleaner.

Thank you for the review.

Pasha


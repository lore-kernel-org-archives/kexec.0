Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0443FC71136
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jfez9m8g9eXcV1XbFnxKvEJ2+SXiyTgBGjYdJ4K2MFU=; b=pS6dLyjpsR54Zaw266fHu7R4wr
	VAGr5wXMzSW0C303v2fqtUD3/VIKzSKB+maElO+dR2c6CMAQora4WKj3HSFURuLycTrvE4YoK8mlu
	utgWmM4muVBKiWdLm7vqZrFZVRqXTUJ/3zvQRwGJyZNNGOLxQjOJ2a5Zc7f46gTf7DEPwr0zj2qGO
	QTzRDXuQqu5uNeUpt8IW1M7alA/jQj1mFaOAesqBpoq/0x04xnMVxi074Rf+Ce4z53IfUH60uNEep
	tGTI1llef/4uIyTqAXesy4mQniers7/LCadtSTI/xvSAEstwSc9JVA3xmkBJ4GBKVSfAcJezTPMir
	B1N1Yjbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ6DK-0000000GqvN-2EcU;
	Fri, 13 Jun 2025 15:21:06 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ50L-0000000Gc0y-0RZB
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 14:03:38 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7c5b8d13f73so244235285a.0
        for <kexec@lists.infradead.org>; Fri, 13 Jun 2025 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1749823415; x=1750428215; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfez9m8g9eXcV1XbFnxKvEJ2+SXiyTgBGjYdJ4K2MFU=;
        b=hZrrxz3eL1L5c6c3J6FlqqyJrRFcXvZDIYpoIYQ3CoUvws35PBkNoLOgr1kwmGoTvq
         afuMW6CiPCTVGCt0e6GJFBmkoHDBC0voC2m+LoqNaWkZp6R65iOYlccU0DiuF457SQJN
         JWOt3p/Rg93DmVSKabM4Eth+yDEuddTmHkHbrosgMRCyNfGmcoZ2jVb0pn/IfWc4bga6
         0fKSmQTatDk6UoBXFF4dBGvLHpUSW/OU91gTze/NIZmksPifC/jzRQ62STgkv9v/DMpW
         7qCleJi5OulQt5V427ZAdFwxPJWjdMJzMfvmc1zFDLQmF0qrTLnPnRYlnMk8q1VK0YOt
         aE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749823415; x=1750428215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfez9m8g9eXcV1XbFnxKvEJ2+SXiyTgBGjYdJ4K2MFU=;
        b=NIdkFDTp2w3GPwYmPDC100uFOeiYvgCcP3088xJ2izl5Visz2Z5llD0WkgaA+ovjfH
         QpfdVSZ7fYTsMLbEiM1rbCS1f/1SB1Bw+t825xgpzFqILLgbJHaXGfHdffIHfXO+MPjf
         2rCkE4TovyLpkhcB91jEEnmkYLG5e2O7ryBoTk4xNYA1UW7RJBFx5jS4dYrzFg0BD0Ko
         3jFp7368jKaVB/UwqCTLWbgtxEbxiTmCX33WhgKjzb0GXjA3p6BhPLrLG3YV7S6Eqfg0
         DqpTLZW3ZJGypMHLdQCIfOy/RaJmMfM6Lzs68SclVyptdKcNosGCmMHomNXS7qN6Y1AA
         bvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKkrY3AStsWOKAao00nBTh/RNKOgKVjHEN86gW7k5LPWDBqp6caKggmpKlBbfL39pZBerqug==@lists.infradead.org
X-Gm-Message-State: AOJu0YyMwzk9YlPlHVfastNmqwGMnn6frmN6nXKNMHyDYxHt/7o9cF5X
	H9qB6s1ZIXOG4i6BuliFOaKUJ1UjF4cTuEZ9a7BQT213S94kL76CqhYvmXRr/9LYeacbv1Hi7Up
	1UZT4bNwGYobBU8hEhNzqgFVkjWLWuwByb70KUaH4IQ==
X-Gm-Gg: ASbGncvWr0hIylPsm6AW3isQ7FrSv8++nZ3GrVKOg6CCmVLVG1RPuNzh4cBMdhU0i3m
	a6tRKITrosOszGI/JTP+dS8nk7+V0+AuDpSxwfFxLyjDPE4LDZBOyWX2tsndAeSvd1WtueiPSrB
	q05biCw8GlXY6Nk0wqwC5WF4KIxhGp+fkQt0HgPQka
X-Google-Smtp-Source: AGHT+IEYtrF3JeWGspY0IB/x4ptpkv6RjcW9iWzE02RebZefIVkzcRcfsOf0K/L+k0JZSqJS9wd1O9/eT89BbTYNJmI=
X-Received: by 2002:a05:620a:390a:b0:7cd:31ca:d81 with SMTP id
 af79cd13be357-7d3bc47669dmr499779585a.27.1749823414616; Fri, 13 Jun 2025
 07:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250613125916.39272-1-pratyush@kernel.org>
In-Reply-To: <20250613125916.39272-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 13 Jun 2025 10:02:57 -0400
X-Gm-Features: AX0GCFtynq6uZkJCevICxm6uo_i_e5E0E4kzTiNB65e-YQ2MVftwAmOZ1grw1MI
Message-ID: <CA+CK2bCyTi+C+JaOjbaMhX=vnD7NTW-T4VDb9xJcTZTjwTJr6A@mail.gmail.com>
Subject: Re: [PATCH v2] kho: initialize tail pages for higher order folios properly
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Pratyush Yadav <ptyadav@amazon.de>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_070337_146544_771F3D05 
X-CRM114-Status: GOOD (  12.75  )
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

On Fri, Jun 13, 2025 at 8:59=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> From: Pratyush Yadav <ptyadav@amazon.de>
>
> Currently, when restoring higher order folios, kho_restore_folio() only
> calls prep_compound_page() on all the pages. That is not enough to
> properly initialize the folios. The managed page count does not
> get updated, the reserved flag does not get dropped, and page count does
> not get initialized properly.
>
> Restoring a higher order folio with it results in the following BUG with
> CONFIG_DEBUG_VM when attempting to free the folio:
>
>     BUG: Bad page state in process test  pfn:104e2b
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffffff=
ffffffff pfn:0x104e2b
>     flags: 0x2fffff80000000(node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
>     raw: 002fffff80000000 0000000000000000 00000000ffffffff 0000000000000=
000
>     raw: ffffffffffffffff 0000000000000000 00000001ffffffff 0000000000000=
000
>     page dumped because: nonzero _refcount
>     [...]
>     Call Trace:
>     <TASK>
>     dump_stack_lvl+0x4b/0x70
>     bad_page.cold+0x97/0xb2
>     __free_frozen_pages+0x616/0x850
>     [...]
>
> Combine the path for 0-order and higher order folios, initialize the
> tail pages with a count of zero, and call adjust_managed_page_count() to
> account for all the pages instead of just missing them.
>
> In addition, since all the KHO-preserved pages get marked with
> MEMBLOCK_RSRV_NOINIT by deserialize_bitmap(), the reserved flag is not
> actually set (as can also be seen from the flags of the dumped page in
> the logs above). So drop the ClearPageReserved() calls.
>
> Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation"=
)
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


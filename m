Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D058D5E128
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tD9Lp67s7fpdz6A6waWN21OJYKTBdSKb+Od0op95dQE=; b=2RETzgTCEfT3zuE/zJLROQ9oXO
	ge47lC/bk+YsxHIHTFZ50LDwvFkTyluEH72E5FSQsf7zhMXGTICAk6jX22bwJEbKHqsJE/1GnFrmS
	HEaxJmCdAIW1mWDvys/8E+JT4yT+lu6qOBF4G550QlsaacGCRhjOLTaQ8AyaW5zPt22yIPfq7yO01
	BJj0Ke3ghHtTDMEvnXhc28wAyBXO/z9o1gMEe73oOSKqgc8DGHcIDFC4orlWHo8eEzUR6t6+Dn1wp
	IPbezxoScylTRnkRUfgX9uEhYMaqYKBaH64fSRyL+ikIyaWnqCqSd+FeBtB6oR8C0H6Z1qi+8JhDk
	LJrXifPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVShL-000000054Gm-0Ciu;
	Tue, 16 Dec 2025 10:54:31 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVShI-000000054Fi-0Kc7
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 10:54:29 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so7862248a12.2
        for <kexec@lists.infradead.org>; Tue, 16 Dec 2025 02:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1765882466; x=1766487266; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD9Lp67s7fpdz6A6waWN21OJYKTBdSKb+Od0op95dQE=;
        b=AnHDko99N5zQGydNZbKZCE7xn/hMFSpCbEQ61BTLNlpId9ZoD1Z1eZqdbAIGunupjO
         loHMJosK2xBsxURsT0k3k9UiIZI1bZEPHXcRwirVvVuZk9lD0QTn63LVB9jV1rDNxD/w
         InvpSWjESljJ3IfwyoP5auiA/93Ore6hp4S7XPWKh7yxgJaQFPWp3xBIOwC00H10u9r6
         OEjkZwlKYfaMY2Fqw2i6a5mDgAGQmFBnSRS8a7Li5x1dM8q9wQssE3uYNscT5XzE6ymf
         0NpH/N4mqeJlMqRXnOHQmaxZ/mJ9JiVlJh3uGcprjLu+6f7/SjwrlspgRAaPszECkP7G
         qFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882466; x=1766487266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tD9Lp67s7fpdz6A6waWN21OJYKTBdSKb+Od0op95dQE=;
        b=L3tzjQ+Z3MMarMJN//mu06mPWpVTs8UxtNfd4tPMMFuTDUUF/swjTXKSjSY0dtiYHF
         Z/td8BYXfGmNpROa7gsdfm7i6V+/Tb7lmmA/hgTTZg+3WF3hPwiifwxNphPrXZ4az3n2
         OqANkJSBngKK2Yy1vZ8vOXtMYjQm9GA9S1/65PkQVjzQw8cXJL6PHr4CU6ECGO9hIH+s
         RhFQlX7WkXas9iriWBfCgiAxMaYYMaBSBO87UwH+bSsvhcJ2pUsyB2I/1dQoauJ4cOiL
         0DeSG/WPTD5GTE3wuHVg3R3LiTAuahJdV1JE8Bc/UirKa2AmC/aQhW3cU077MWuQxrXZ
         ycXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmA11jalafoLhejqbpNU+jfWpJznj+pNyzetKu4yPNAIml3dkgFiMAUt5j6g8fDJWmKmYNiQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2NWPghSeBuC/M4/echcrlhC5uycjKPumLe6bAgWROl1tnb+yW
	+iII4Acbn4oqBvSVedpJeK77tNM8AbX6N3/txSRVFxS1JY8xpz6LYZZUkkiKkFNk3eKC9iHeSjy
	4f4dgfealIV5vWmJqTqRD2ClDIIUQkUuqE7ke3Ew8IA==
X-Gm-Gg: AY/fxX56Vuc7yA6SxAfCRjLg62ZlDTYX+WLR4lPDDMLmz/ESE2fbu8YlbtiNzp5fxX3
	z66qmCc9rOjpq9lD+ThZtURqCyRPIgmcTvp3bZXJ4OgmeuQ3bu51ZnrWZtr7dbIFXcHYSZEzsha
	MRU7BIE684a3jQcNCk9T772Yyexfo/Xs0KhY3ATvV8060f/dnNmWAPZBtkIyBcIAMPdrfGMXL+3
	QW9f4lFP2BC8cR+RiSRtv/qbL0yTVFfhtExLZAozMnxlFLiwFSR+gPQX/qTp+pnG98YDkEuzakB
	GiK/V9d/SwbHg6+MlW9+4RLa
X-Google-Smtp-Source: AGHT+IG8p73VOEd7PIH7r8dPppBNaqwWAp6Ul+8IZ1rzMRtM5hnO+5XyLdPBbMwU+FeyF1VpXJUhh7Mk0kFKx5MSPVw=
X-Received: by 2002:a05:6402:1e8a:b0:647:5544:77e with SMTP id
 4fb4d7f45d1cf-6499b1e4cb3mr12436882a12.29.1765882465622; Tue, 16 Dec 2025
 02:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de>
In-Reply-To: <20251216084913.86342-1-epetron@amazon.de>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 16 Dec 2025 05:53:49 -0500
X-Gm-Features: AQt7F2pQE57kuXlYblzW6adJj1GXxwk29ATnbIbA7QihcN0-E40g7fo6gXcODdg
Message-ID: <CA+CK2bDeaEc=9hENwz+LaJ0DXuvL0PxU0_MGKtZh34YkrQT=3w@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_025428_180937_843648BD 
X-CRM114-Status: GOOD (  35.96  )
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

On Tue, Dec 16, 2025 at 3:49=E2=80=AFAM Evangelos Petrongonas <epetron@amaz=
on.de> wrote:
>
> When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
> initialization is deferred to parallel kthreads that run later
> in the boot process.
>
> During KHO restoration, `deserialize_bitmap()` writes metadata for
> each preserved memory region. However, if the struct page has not been
> initialized, this write targets uninitialized memory, potentially
> leading to errors like:
> ```
> BUG: unable to handle page fault for address: ...
> ```
>
> Fix this by introducing `kho_get_preserved_page()`,  which ensures
> all struct pages in a preserved region are initialized by calling
> `init_deferred_page()` which is a no-op when deferred init is disabled
> or when the struct page is already initialized.
>
> Fixes: 8b66ed2c3f42 ("kho: mm: don't allow deferred struct page with KHO"=
)

You are adding a new feature. Backporting this to stable is not needed.

> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> ### Notes
> @Jason, this patch should act as a temporary fix to make KHO play nice
> with deferred struct page init until you post your ideas about splitting
> "Physical Reservation" from "Metadata Restoration".
>
> ### Testing
> In order to test the fix, I modified the KHO selftest, to allocate more
> memory and do so from higher memory to trigger the incompatibility. The
> branch with those changes can be found in:
> https://git.infradead.org/?p=3Dusers/vpetrog/linux.git;a=3Dshortlog;h=3Dr=
efs/heads/kho-deferred-struct-page-init
>
> In future patches, we might want to enhance the selftest to cover
> this case as well. However, properly adopting the test for this
> is much more work than the actual fix, therefore it can be deferred to a
> follow-up series.
>
> In addition attempting to run the selftest for arm (without my changes)
> fails with:
> ```
> ERROR:target/arm/internals.h:767:regime_is_user: code should not be reach=
ed
> Bail out! ERROR:target/arm/internals.h:767:regime_is_user: code should no=
t be reached
> ./tools/testing/selftests/kho/vmtest.sh: line 113: 61609 Aborted
> ```
> I have not looked it up further, but can also do so as part of a
> selftest follow-up.
>
>  kernel/liveupdate/Kconfig          |  2 --
>  kernel/liveupdate/kexec_handover.c | 19 ++++++++++++++++++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index d2aeaf13c3ac..9394a608f939 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -1,12 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
>  menu "Live Update and Kexec HandOver"
> -       depends on !DEFERRED_STRUCT_PAGE_INIT
>
>  config KEXEC_HANDOVER
>         bool "kexec handover"
>         depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FI=
LE
> -       depends on !DEFERRED_STRUCT_PAGE_INIT
>         select MEMBLOCK_KHO_SCRATCH
>         select KEXEC_FILE
>         select LIBFDT
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 9dc51fab604f..78cfe71e6107 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -439,6 +439,23 @@ static int kho_mem_serialize(struct kho_out *kho_out=
)
>         return err;
>  }
>
> +/*
> + * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory
> + * regions may not be initialized yet at the time KHO deserializes prese=
rved
> + * memory. This function ensures all struct pages in the region are init=
ialized.
> + */
> +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> +                                                 unsigned int order)
> +{
> +       unsigned long pfn =3D PHYS_PFN(phys);
> +       int nid =3D early_pfn_to_nid(pfn);
> +
> +       for (int i =3D 0; i < (1 << order); i++)
> +               init_deferred_page(pfn + i, nid);
> +
> +       return pfn_to_page(pfn);
> +}
> +
>  static void __init deserialize_bitmap(unsigned int order,
>                                       struct khoser_mem_bitmap_ptr *elm)
>  {
> @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int or=
der,
>                 int sz =3D 1 << (order + PAGE_SHIFT);
>                 phys_addr_t phys =3D
>                         elm->phys_start + (bit << (order + PAGE_SHIFT));
> -               struct page *page =3D phys_to_page(phys);
> +               struct page *page =3D kho_get_preserved_page(phys, order)=
;
>                 union kho_page_info info;
>
>                 memblock_reserve(phys, sz);

In deferred_init_memmap_chunk() we initialize deferred struct pages in
this iterator:

for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
 init_deferred_page()
}

However, since, memblock_reserve() is called, the memory is not going
to be part of the for_each_free_mem_range() iterator. So, I think the
proposed patch should work.

Pratyush, what happens if we deserialize a HugeTLB with HVO? Since HVO
optimizes out the unique backing struct pages for tail pages, blindly
iterating and initializing them via init_deferred_page() might corrupt
the shared struct page mapping.

Pasha


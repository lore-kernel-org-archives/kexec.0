Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF73EE4988
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KRg6CrcJkBXZs3BQb5XRdbXuKq3vmzU1zmho9EhETiQ=; b=zOIRcYvSbxzLQsTXAspG1eQHJO
	FVS/6Q6/cDYpZ4kieBArW6gFwUufVagwbOUrK91tQf0DUEs+IkHfrmQsiDbzqdeJnEohbHCKwMLjy
	QeMiIoNkrzibq57uohFjaFp0K2kqK484CMaibgKNu2WHDILhi2Z+0ELQamujJpZUBIYdSKlEGRQ9k
	XNkfsXyzrBNgJGjFJ7qOrfQzgFsguQXShAxUhWolInOJNwvfqQJaxlwPJYs4rwzHgFelEvODFZMUT
	UElHWjpczz0EEB1qC0Be0fv98axssKcNksY92uXkL7iDbUzj1wiWybFaBGRmS1VUzBgAFKEV9ybPG
	MwHyO9IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacjS-0000000542t-08is;
	Tue, 30 Dec 2025 16:38:02 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacjO-0000000542W-495c
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 16:38:00 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-64b61f82b5fso13543478a12.0
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767112677; x=1767717477; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRg6CrcJkBXZs3BQb5XRdbXuKq3vmzU1zmho9EhETiQ=;
        b=NOFwM/DVm2hIbDxHy8IG+c+ZfyXhzhh/+2VQFdodSVV9JWtiwusW2/un774s4aKtmv
         oChdAAWwt3upb9drfnveCSBTCkk4UxwRqy+jkb5VPyzNiQUHzq14+QuOfPBQMVpWmZ3T
         4yNpsKNaX5VSwHahCF6ojy46dZizUuJvxyJ0R6o1Y0POTf0kN6C37a+KHPMvoIybaqE5
         Norts6b/ZxWTrBFerCsGsunDGeljSD3ALOy6Y0MCgHp/E2TbEaTjL0LaohVMoXKUccE8
         cVV29TiYwvCpmUfEfZyKBX2fe0EowbsxOlLAvQaUv087ea8U5MIJPMtrNjyqXWjMNlmo
         LdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112677; x=1767717477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRg6CrcJkBXZs3BQb5XRdbXuKq3vmzU1zmho9EhETiQ=;
        b=UzYGYofmG8ocY3J0Co4Iu9f+hSrvZt3L4d+7zdb0a2ELM8RHcXaFrwHNVX9v8kSuAg
         EzQEGRytREdQ50u4r7XAqIETCShP9acfZkXSb7ExDUBDEw8hlxbrcBnuHUYUmXTpKjl7
         lzQ8+y4qQtXSxvX3cZnjL/+QzYy1HdmGbXzvqySOptQtM11DweJHD2kAPXILjLg6kfyL
         MmjQslKcPscX+nn7XBDuxjPzGShzKqfeUpMVK1vOMu+zfzZEjh9XDMOEhwvMiL3XtCWW
         y387kK1Iec2rz7CmfdkYB9dEIq6sv8YzNGRbF3S0lyA49i/AivpxBFB4CeVl1J8qZsJ6
         B2gA==
X-Forwarded-Encrypted: i=1; AJvYcCU1A57kbprvkYvtVpOTNvqEV18Biv943NPMMa5dGPl93zWSm6KvyyQz0teWG86TLpDqc90uyA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywgnhl7ICKggYuuQe6ieQY1OgjcvTDfp45qQX9szP3wryZKStkE
	wG+IvrukDdL4+v6XbO0Splg+tvqmvOJTg2ygTussYshmkS2R0dTUXXVyTvHYkkTwQy/PAf23yJ+
	sOa7MYY2tf4MuSnnF401CaekmV7mtckmh5f6MaHupIg==
X-Gm-Gg: AY/fxX6iLmmh+RGrWumMCkuEPnhzVS5x00oVYmrFBQI4J5ikAcD1VOIyrhCHkfDo/yJ
	UqAH4QzossvffZYK4v6jEFM1zuCXtvQCaecMoy7bgmkabygQ0zyLhvmx4BC+XGXJkKJkD7GX+mX
	x9spUsF7iv5rZoigFs/wWiR89clH/W1RhH9EdAQZCJtmJinnqCcLdfmKkVr78FbyfhTPjOhqv9h
	EjcVFLnCPJGl5Hqa3vphLrHjWV0UUVqb5934PHMiBoiRtwi7EZXMQN8CpfPpK9ecyL5knMKwp35
	+mgpBLg87IKmWYUMReeWGRSbxw==
X-Google-Smtp-Source: AGHT+IGt84JqyxLT4FVa1NK9x43gWi2TvpGddBi/ddcId92JOTd0e+vB9z2i06mYaiwFTk4rPI2jpbCaXF0BnPuhN5Q=
X-Received: by 2002:a05:6402:2713:b0:637:dfb1:33a8 with SMTP id
 4fb4d7f45d1cf-64b8e944eddmr31901439a12.3.1767112676868; Tue, 30 Dec 2025
 08:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20251206230222.853493-1-pratyush@kernel.org> <20251206230222.853493-7-pratyush@kernel.org>
 <CA+CK2bAVuHG1cVPQz8Wafe8o2TtitrqJjqfHOT7Xun=zWMoo2Q@mail.gmail.com> <86qzsd7zmu.fsf@kernel.org>
In-Reply-To: <86qzsd7zmu.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Dec 2025 11:37:19 -0500
X-Gm-Features: AQt7F2pvBnnd5fD8grNsYPQ7hitVBz_yujsMM_6ymMYxKOIzOHac-8gxUv2SYKE
Message-ID: <CA+CK2bDQDsjBkYabH5DVzSr_kuut-XHKb+JFTA=PLa+8gcCVLw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] liveupdate: hugetlb subsystem FLB state preservation
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_083759_096770_6334C824 
X-CRM114-Status: GOOD (  40.89  )
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

On Mon, Dec 29, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Tue, Dec 23 2025, Pasha Tatashin wrote:
>
> > On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.=
org> wrote:
> >>
> >> HugeTLB manages its own pages. It allocates them on boot and uses thos=
e
> >> to fulfill hugepage requests.
> >>
> >> To support live update for a hugetlb-backed memfd, it is necessary to
> >> track how many pages of each hstate are coming from live update. This =
is
> >> needed to ensure the boot time allocations don't over-allocate huge
> >> pages, causing the rest of the system unexpected memory pressure.
> >>
> >> For example, say the system has 100G memory and it uses 90 1G huge
> >> pages, with 10G put aside for other processes. Now say 5 of those page=
s
> >> are preserved via KHO for live updating a huge memfd.
> >>
> >> But during boot, the system will still see that it needs 90 huge pages=
,
> >> so it will attempt to allocate those. When the file is later retrieved=
,
> >> those 5 pages also get added to the huge page pool, resulting in 95
> >> total huge pages. This exceeds the original expectation of 90 pages, a=
nd
> >> ends up wasting memory.
> >>
> >> LUO has file-lifecycle-bound (FLB) data to keep track of global state =
of
> >> a subsystem. Use it to track how many huge pages are used up for each
> >> hstate. When a file is preserved, it will increment to the counter, an=
d
> >> when it is unpreserved, it will decrement it. During boot time
> >> allocations, this data can be used to calculate how many hugepages
> >> actually need to be allocated.
> >>
> >> Design note: another way of doing this would be to preserve the entire
> >> set of hugepages using the FLB, skip boot time allocation, and restore
> >> them all on FLB retrieve. The pain problem with that approach is that =
it
> >> would need to freeze all hstates after serializing them. This will nee=
d
> >> a lot more invasive changes in hugetlb since there are many ways folio=
s
> >> can be added to or removed from a hstate. Doing it this way is simpler
> >> and less invasive.
> >>
> >> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> >> ---
> >>  Documentation/mm/memfd_preservation.rst |   9 ++
> >>  MAINTAINERS                             |   1 +
> >>  include/linux/kho/abi/hugetlb.h         |  66 +++++++++
> >>  kernel/liveupdate/Kconfig               |  12 ++
> >>  mm/Makefile                             |   1 +
> >>  mm/hugetlb.c                            |   1 +
> >>  mm/hugetlb_internal.h                   |  15 ++
> >>  mm/hugetlb_luo.c                        | 179 +++++++++++++++++++++++=
+
> >>  8 files changed, 284 insertions(+)
> >>  create mode 100644 include/linux/kho/abi/hugetlb.h
> >>  create mode 100644 mm/hugetlb_luo.c
> >>
> [...]
> >> +static int hugetlb_flb_retrieve(struct liveupdate_flb_op_args *args)
> >> +{
> >> +       /*
> >> +        * The FLB is only needed for boot-time calculation of how man=
y
> >> +        * hugepages are needed. This is done by early boot handlers a=
lready.
> >> +        * Free the serialized state now.
> >> +        */
> >
> > It should be done in this function.
>
> The calculations can't be done in retrieve. Retrieve happens only once
> and for the whole FLB. They will need to come from
> hugetlb_hstate_alloc_pages().
>
> Maybe you mean getting rid of liveupdate_flb_incoming_early()? Yeah,
> that I can do. It will make this function a no-op once we move the
> kho_restore_free() to finish().

Yeah, this is what I meant.

Thanks,
Pasha

>
> >
> >> +       kho_restore_free(phys_to_virt(args->data));
> >
> > This should be moved to finish() after blackout.
>
> Sure.
>
> >
> >> +
> >> +       /*
> >> +        * HACK: But since LUO FLB still needs an obj, use ZERO_SIZE_P=
TR to
> >> +        * satisfy it.
> >> +        */
> >> +       args->obj =3D ZERO_SIZE_PTR;
> >
> > Hopefully this is not needed any more with the updated FLB, please chec=
k :-)
>
> Yep. IIRC when I sent this series the older version of FLB was in
> mm-nonmm-unstable.
>
> >
> >> +       return 0;
> >> +}
> >> +
> [...]
>
> --
> Regards,
> Pratyush Yadav


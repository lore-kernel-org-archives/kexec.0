Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E3606A31C
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s1CWeH1J;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oq7mXUay
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=p4OcSAvcvQKsjkU4ru+MvGNBWR2vHDxkyHmPg+JgZAI=; b=s1CWeH1JIPzOdE
	IuW0W05Knlc4E35HJ5wN6J7AZ2TSpvOAYq3BWoRdc/rLrfJOTxbIAzzIZau2Bv0i1/jffl9QEDmzU
	09nH405xIg0VuJME8AjLBrytqL8CgzXNEomYJBB5/Tnqr9Eko8PssGjA7yT6eFGCwypW3JTYfLnoT
	3gazMUpDcGOipl8q+f12ZbQQKRqN5DKnlQfCYCN5rhAAxWpSklDKi2pNEf4Mip8b4uogNyIv05r+D
	5GXRQTjff66e1gHvzDw1Uhhx+9GC79y8Qi7S5xSlkT3ydHTfS3u9st5AIFTkLSmlZeJxiMeBhGtBT
	flF7GAO6qS+xJelu2tFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPyEr-0000000FqXA-1fiu;
	Sun, 08 Nov 2026 08:26:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPyEp-0000000FqX4-3zGv
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 08:26:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 53CEF44879
	for <kexec@lists.infradead.org>; Sun,  8 Nov 2026 08:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364471F008BF
	for <kexec@lists.infradead.org>; Sun,  8 Nov 2026 08:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126415;
	bh=p4OcSAvcvQKsjkU4ru+MvGNBWR2vHDxkyHmPg+JgZAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Oq7mXUayhQTDePVUjrfThAEG1V7e8Y9jHk7AEkIGpjTfkJ74OuNKPp2JUR7gO6tjO
	 gK8sjs0oIZYhKDO6UAQr8qwL/YVbv56dLKzgtpDd7Ua8fA1u/US0Lt6Z7nqH5rpA4e
	 /IbdbI//jYesPChnrmZ3wF53SnhaOo9IpQJRu/gjg2BgoiNbccUOk2BlPXeSHLr2bJ
	 W+AKvkmtSnFlVXENHlF79lpkVV5/tb9l3kXutdiZPrBwEESDq5a9oN/zvlNORF7AkL
	 cVdyb9kv+rjJRYxLzhIkLE1kUTtu2vZibPxBIDsg25TnlJwIVxiE8uI0sMGN6rYzyO
	 hqnXX48hdsztA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b571979178so286284a12.2
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 00:26:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF1niTHovVI6zChdbnwWsdbWRRWTyPcSvvSKHttdHneQ5nd8yMOfLu2tf/t5R+Wl58rl2/5Og==@lists.infradead.org
X-Gm-Message-State: APuU4Z+fQGLEpnNJ9Ya4VJGSEFwsiDDUhSMrnfNYfHem/tYITxSeODid
	zQ9LmM102MwGeegznPMcN+6aGW+G/ttsxVzUdpuzH8CPSGpjk4icftPGxiYZDmJ4csxcV+Hyv6R
	XmHtEUMK1jhhB4JEMcu7mytQbJE/DNN0=
X-Received: by 2002:a05:6402:1ecc:b0:6b7:1c:eaf2 with SMTP id
 4fb4d7f45d1cf-6b7224041dfmr591123a12.7.1794126413758; Sun, 08 Nov 2026
 00:26:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029172956.20791-1-dongtai.guo@linux.dev> <20261029172956.20791-6-dongtai.guo@linux.dev>
 <aux9Hm0QFJLUDPWv@kernel.org> <CAAhV-H7Dsnz03iXChzE6nYM2cs+D6fdDFiWrDxX5jM13kYL6HA@mail.gmail.com>
 <auypq8_7T-vml5_B@kernel.org> <CAAhV-H6aO_QNEzV-r6+FbNa=9EUQgv1vH0ET-ETXAH5x6oQGjA@mail.gmail.com>
 <avAvdiYY7SJ_Gfwt@kernel.org>
In-Reply-To: <avAvdiYY7SJ_Gfwt@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 8 Nov 2026 16:26:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5q2SiDJC+ZSA4F7kw2vO=Y+c5J-aNg=PNMoh_CZ7qWdg@mail.gmail.com>
X-Gm-Features: AclHuK9UKAm9d_ZAky8YF1Z-Jn3w5G8u3fB621EiI1G-bSq5xcRQq5mtls0NIdA
Message-ID: <CAAhV-H5q2SiDJC+ZSA4F7kw2vO=Y+c5J-aNg=PNMoh_CZ7qWdg@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] LoongArch: Allow memblock arrays to resize
To: Mike Rapoport <rppt@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ardb@kernel.org, shuah@kernel.org, ilias.apalodimas@linaro.org, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, 
	guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, 
	liukexin@kylinos.cn, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 4:14=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Fri, Nov 06, 2026 at 10:35:01PM +0800, Huacai Chen wrote:
> > On Fri, Nov 6, 2026 at 12:07=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Thu, Nov 05, 2026 at 11:07:01PM +0800, Huacai Chen wrote:
> > > > Hi, Mike,
> > > >
> > > > On Thu, Nov 5, 2026 at 8:57=E2=80=AFPM Mike Rapoport <rppt@kernel.o=
rg> wrote:
> > > > >
> > > > > On Fri, Oct 30, 2026 at 02:29:52AM +0900, George Guo wrote:
> > > > > > From: George Guo <guodongtai@kylinos.cn>
> > > > > >
> > > > > > LoongArch never calls memblock_allow_resize(), so the reserved =
region
> > > > > > array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
> > > > > > (INIT_MEMBLOCK_REGIONS + NR_CPUS).
> > > > >
> > > > > This might be something to fix independent of KHO.
> > > > >
> > > > > Huacai,
> > > > >
> > > > > What's the reason LoongArch never enables memblock resizing and w=
hy it
> > > > > defines INIT_MEMBLOCK_RESERVED_REGIONS to include NR_CPUS?
> > > > At first we didn't define INIT_MEMBLOCK_RESERVED_REGIONS, then we g=
ot
> > > > boot failures on a 128-cores machine, so define it, and the value i=
s
> > > > similar to arm64.
> > >
> > > AFAIR, arm64 had to reserve some per cpu data before they could enabl=
e
> > > memblock resizing, so they had to make it static.
> > LoongArch is similar, so below 64-cores machine has no problem.
> >
> > >
> > > > The reason LoongArch never enables memblock resizing is because the=
 mm
> > > > code is derived from MIPS, and MIPS never enables it.
> > >
> > > If that's the only reason, you might want to revisit that :)
> > Yes, it seems we need memblock_allow_resize(), but maybe it is better
> > to bring back paging_init()? Most other archs call
> > memblock_allow_resize() in paging_init().
>
> paging_init() is a historical relict that hugely misnamed everywhere :)
>
> I think platform_init() should be fine.
If paging_init() is unnecessary, then arch_mem_init() is better than
platform_init(), at least the name is better.

Huacai

>
> As far as I can tell, by the time platform_init() calls init_numa_memory(=
),
> all memory reservations that must happen before any memblock allocations
> are done.
>
> > Huacai
>
> --
> Sincerely yours,
> Mike.


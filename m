Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF0606A320
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SitE1lrs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKFzGvSF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0W/6CqRYQKhRFQh0YmGByeLiEw+AYRdR3bmjVY7Mfnw=; b=SitE1lrs3UgqpmBybhXh4Mx/Kz
	5Xk38EjF1Hg+G0OeLPpCDpxJk94ssObgRFcEWt85j866iAFzerLQsOe6kZo5jKfyeJoVS6L9rDGBV
	dtgdCauDxCD8x8mNOztUSjCwT9IHOlaZAIQy19U0XynV1K/fp+mFsx8ez8MNFc5ig07hMJIZSJ12n
	r+sXkQ17gccQUh7LYyBj4ol+6ajtj4IGbTCV0yjNEc6rgadZ671f3tMt22k/H8Pn1fXl/vGgA9dRG
	kwon9vtizcUh2oeT3xzbF2g0ak7t2CQfMOxwC4p2M7LBy99yp5MMFRVLIjuYbHiXwfVnQhZlb7nQP
	6PrIqrpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPy3J-0000000Fplq-1Xib;
	Sun, 08 Nov 2026 08:15:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPy3F-0000000Fplk-2q75
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 08:14:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AAC566146D;
	Sun,  8 Nov 2026 08:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F881F008A1;
	Sun,  8 Nov 2026 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794125696;
	bh=0W/6CqRYQKhRFQh0YmGByeLiEw+AYRdR3bmjVY7Mfnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MKFzGvSFZwWIFFRA0ZXyvs16A8suXF5CnHj8Yu6DWVn1XNaXrMDEdixojJ9WmXEb7
	 B8HFMUjzOTvU6RwlNQjwdzjqPDvQCGA/4AJ0Em0zHhj4ypRhnI0mKxzYLZP1OV0ifL
	 eA9/fxW3Pxy16892wCazYquUCYCuIsm8XcchNAPA4t/tkQu4javpgOcU7RVq4A3nxo
	 k4uHK/8yLyZ3smraijDdggziz20OX07t14xfVyqW5GBbR1PgqbbVWyHXUI4Z32Xbrc
	 0iyAWtnR+xfX5UnU/tie3OAW89SLmVQEk/G3YHRAs2N39oS4qhXV1enxnkV6a1AaEm
	 jVNdWp25bMNnQ==
Date: Sun, 8 Nov 2026 10:14:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ardb@kernel.org, shuah@kernel.org,
	ilias.apalodimas@linaro.org, akpm@linux-foundation.org,
	baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn,
	kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 5/8] LoongArch: Allow memblock arrays to resize
Message-ID: <avAvdiYY7SJ_Gfwt@kernel.org>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-6-dongtai.guo@linux.dev>
 <aux9Hm0QFJLUDPWv@kernel.org>
 <CAAhV-H7Dsnz03iXChzE6nYM2cs+D6fdDFiWrDxX5jM13kYL6HA@mail.gmail.com>
 <auypq8_7T-vml5_B@kernel.org>
 <CAAhV-H6aO_QNEzV-r6+FbNa=9EUQgv1vH0ET-ETXAH5x6oQGjA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6aO_QNEzV-r6+FbNa=9EUQgv1vH0ET-ETXAH5x6oQGjA@mail.gmail.com>
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

On Fri, Nov 06, 2026 at 10:35:01PM +0800, Huacai Chen wrote:
> On Fri, Nov 6, 2026 at 12:07 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Nov 05, 2026 at 11:07:01PM +0800, Huacai Chen wrote:
> > > Hi, Mike,
> > >
> > > On Thu, Nov 5, 2026 at 8:57 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Fri, Oct 30, 2026 at 02:29:52AM +0900, George Guo wrote:
> > > > > From: George Guo <guodongtai@kylinos.cn>
> > > > >
> > > > > LoongArch never calls memblock_allow_resize(), so the reserved region
> > > > > array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
> > > > > (INIT_MEMBLOCK_REGIONS + NR_CPUS).
> > > >
> > > > This might be something to fix independent of KHO.
> > > >
> > > > Huacai,
> > > >
> > > > What's the reason LoongArch never enables memblock resizing and why it
> > > > defines INIT_MEMBLOCK_RESERVED_REGIONS to include NR_CPUS?
> > > At first we didn't define INIT_MEMBLOCK_RESERVED_REGIONS, then we got
> > > boot failures on a 128-cores machine, so define it, and the value is
> > > similar to arm64.
> >
> > AFAIR, arm64 had to reserve some per cpu data before they could enable
> > memblock resizing, so they had to make it static.
> LoongArch is similar, so below 64-cores machine has no problem.
> 
> >
> > > The reason LoongArch never enables memblock resizing is because the mm
> > > code is derived from MIPS, and MIPS never enables it.
> >
> > If that's the only reason, you might want to revisit that :)
> Yes, it seems we need memblock_allow_resize(), but maybe it is better
> to bring back paging_init()? Most other archs call
> memblock_allow_resize() in paging_init().

paging_init() is a historical relict that hugely misnamed everywhere :)

I think platform_init() should be fine.

As far as I can tell, by the time platform_init() calls init_numa_memory(),
all memory reservations that must happen before any memblock allocations
are done.
 
> Huacai

-- 
Sincerely yours,
Mike.


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CE606D81A
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Lqu3Ekh9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYo5p/HM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fYG2b96fyayScxVvqtx3OSAsQSRRGOB6T40PDUmTI+8=; b=Lqu3Ekh9eLnMw+rMYP3Kqn9XNA
	PcqTy08nqSkHtkyxEn/XT3rC7vHwWw9e6pY7LS/qUcNXM+398V0+YAgUK7ZTgNJieAKHwj2Ag8h9I
	Tt39tz1m3aIfu+GefhAprU59nXC0ArOE0/QEmQq65nobkiADNXF+rX/ZSIpVC0wAmMpoxUT6aNtOA
	PJYrgOdQgBULT2SrWW0fmIODdD6XhxcoOeIF3ZiqgpC6vPzW/cgTHrSdLhfRXKjyGT2ERuOF12Pdu
	I2RDCh8sVpGRIsNAEEOKpBnc2/9PSETlgXniDnqfnQZK2RuCl6+Q3tb/D/lY1/tapzh04qi2zv3e+
	IdRsUNHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzzk-00000009YBT-3fxs;
	Thu, 05 Nov 2026 16:07:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzzi-00000009YB2-457V
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 16:07:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 44758602C3;
	Thu,  5 Nov 2026 16:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9871F00919;
	Thu,  5 Nov 2026 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894838;
	bh=fYG2b96fyayScxVvqtx3OSAsQSRRGOB6T40PDUmTI+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYo5p/HMbU1gpXil/HFCks0XvJiGMwmcZT5vbnMwHLk29sKgRmtxnOzZk1wDd/aea
	 3QO93SZshqmi5XcbWCDImlOImNePvoMJSzaG2b7YVRdjnMMdkX2pMzX3zjGqqi9z/R
	 1giA01W0A74nBvUCV4Evs/Jpwh20TV7FcDEvOARPx86KpxOfYsGMq3+4ict6Zw0DmO
	 s71kK6K/sdKfuvuYgcVNrK3Izbx/cjngYc8wS2qLay+oUhVI6HRfeV9UV4zP/v7cDI
	 sRVdM/r2aEzpO9PIo3TiPHvl/20iU0QuIOji7FmhpavsI/vN/TSq8Nm8/IpxBsuWOM
	 +wCOYw3XpsVoA==
Date: Thu, 5 Nov 2026 18:07:07 +0200
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
Message-ID: <auypq8_7T-vml5_B@kernel.org>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-6-dongtai.guo@linux.dev>
 <aux9Hm0QFJLUDPWv@kernel.org>
 <CAAhV-H7Dsnz03iXChzE6nYM2cs+D6fdDFiWrDxX5jM13kYL6HA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7Dsnz03iXChzE6nYM2cs+D6fdDFiWrDxX5jM13kYL6HA@mail.gmail.com>
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

On Thu, Nov 05, 2026 at 11:07:01PM +0800, Huacai Chen wrote:
> Hi, Mike,
> 
> On Thu, Nov 5, 2026 at 8:57 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Oct 30, 2026 at 02:29:52AM +0900, George Guo wrote:
> > > From: George Guo <guodongtai@kylinos.cn>
> > >
> > > LoongArch never calls memblock_allow_resize(), so the reserved region
> > > array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
> > > (INIT_MEMBLOCK_REGIONS + NR_CPUS).
> >
> > This might be something to fix independent of KHO.
> >
> > Huacai,
> >
> > What's the reason LoongArch never enables memblock resizing and why it
> > defines INIT_MEMBLOCK_RESERVED_REGIONS to include NR_CPUS?
> At first we didn't define INIT_MEMBLOCK_RESERVED_REGIONS, then we got
> boot failures on a 128-cores machine, so define it, and the value is
> similar to arm64.

AFAIR, arm64 had to reserve some per cpu data before they could enable
memblock resizing, so they had to make it static.
 
> The reason LoongArch never enables memblock resizing is because the mm
> code is derived from MIPS, and MIPS never enables it.

If that's the only reason, you might want to revisit that :)
 
> Huacai
> 
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.


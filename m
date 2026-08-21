Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43449C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=APGED5YlpOpMPxOSsAuKA6X7ShEtj4fbflQDOHFgkgs=; b=OCAi6B4ujWBhEEXmCS3K/cuvlK
	zIFcy5Lzs8ta0HiyOYQioJriI9S2932Jsv7S/QyLQ6n0U/1G/vIVgnHj2m8JP37uAq9HrU/NVEHmK
	fsJmzoznv5E0q6FcFwjyD1HAig6uwDwBSHG718yNez379qJLOujkLYw/TBS/D28CPO6wwAGnvvOqf
	KZaoM+sBJFIeragmftJXIQXJrrfrySq4r7FT0bQVvX7t4PqYKO5jyGl/YHKaiatia0VEUyKnkuSp7
	4mEOqi/grZ57RdW9loiSISelOGS556RKIk57LdjObarGnFqr+Rl38Wm8fsujG/F72ncBewfPH7dt0
	KvwdS5kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMVS-0000000D5tB-3J0r;
	Fri, 21 Aug 2026 10:29:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMVL-0000000D5sz-3VCW
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:29:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 78A55406B3;
	Fri, 21 Aug 2026 10:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AF31F00A3D;
	Fri, 21 Aug 2026 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787308183;
	bh=APGED5YlpOpMPxOSsAuKA6X7ShEtj4fbflQDOHFgkgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ixUI3kRsD8NoUTtmkjyJfa4wlDS1R4IthffH+JxKoU6cmU1lGAaG4clXL287xuHh1
	 FzXDa/qYuq72kJG0jgYnXPTUntW8HTxORTjZ9zMtzU2H76m9/ZwKxWBR8g7VqYAuva
	 kgQFavADAJwi0NRufxA8l8j/zT3OVVcMAxgx1gl2+e85rIVJR64+x6g9/HBkUVYvVx
	 kCH7LrYn2BlvwyddOASSf0J2KMGbkAaRPTHlkFbYif7VFRWytKOhy+T2rQDtkoB01E
	 Od3baF8witTx31YqfSZSFnCFr4BovvmI0G+CDmqrfhlwEDpZqh6I3Ig2QOF85lHa94
	 BNRaFCMkdKWqg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 2926B1980052;
	Fri, 21 Aug 2026 06:29:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 21 Aug 2026 06:29:41 -0400
X-ME-Sender: <xms:kiiIarVzSmx1y-aArkHdOBg6_uN2EF6kmHm7eYV3kLj8d1ZetYmTnQ>
    <xme:kiiIarad1L4afhIQcR9TpUON9bZV2_aFZEy-RJGSw_E5CZfR8pB7srH9uie3fSiuB
    dePAuvZWbvXhhgkEl6OfcEL-YeY89S6pgIr0B7jnImbXdTXQ6RL2xCu>
X-ME-Received: <xmr:kiiIaixDRegUN-DZiVZpoNH_w4V-cSHrk9NAzrk7u6EdWuZo3aVYGcDscRg>
X-ME-Proxy-Cause: dmFkZTGP4bL3rkkhiaU+LYYEJklVw3I4bCV0bLo9Xe/rEgNWD79Kg2qnSiGX6a0LzPvrT3
    wfkn1QSVsDXoCCou0Ai4CQZtSMXEfYR7TcfJrEs2qA5nuREzR/25/SXv5FHUVnpahHF5rZ
    sKtXsan+W3eHdPeJRne/qiXwfCfCb10WRvmLB30Ci3uaIEVL5D3olIiiOSnObxq8C6IPWE
    CaoBiOtHyQu+B9nz7YFtvwuilTaX0/jGLK4wKrha13aK2nLIfCvV4FGU476zMpcM2zcLB4
    bT9trOvY0ulRdAD+iw9eIBoGr0FK47s7WRgK6yQyBMu7G61oTI+YvMopiv4VSl18lOJ5Z3
    PFVi+866/3m3g5aFzO7xOv7m6vuXzMUw4Lv+jO9gfxTn5uM0B+j96kCvw/jt8I+huXrLkU
    wKkJaFlospdKLrCQDk16EZ8+PTysacY1zlTDsV2ACyFg8I0wjizXHCfA4iRjksBttHwcTY
    wvEmk9ehfcuSKoQI7pMdYMnnya1y9zVIko1YRNEGK1ERHWn8XNmEmOW7aegRM9a2hLgBF2
    fUrsAB+TJNQlwN/Ob1VoLupB9GoBMoq4ahvuVHXxmmOnPY+KATnU/KnrCbrHVXlRRWx6En
    75CalTn5X3AfHuDh0QqtF9FFmIT9W6QxvSkRgXvqsKl4lNvEtZYrfgg/K2hA
X-ME-Proxy: <xmx:kiiIagJ6K1_IhTU6mwLPUNctDqMy9YCXitJsDYeigc3ethIccfkWKg>
    <xmx:kiiIapfwVryqGlX_G8FBQ-G81dMyuek2WOwFvDgVQNTkC2pFWFIxZw>
    <xmx:kiiIaouDMVQjpMMhVDXhzsvSFoiQl94RJjkg-M1USLW9qB4i-AysmA>
    <xmx:kiiIanFDd2c0gVRX9E4XBv2diwz95NhoIw-LxCwp5NSInmTPRSGErw>
    <xmx:kiiIaifnfAIs5050IA3B1i7QlIb-FxA2CFT7Ar6PadIGJ8yF-mjmyIVy>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 06:29:38 -0400 (EDT)
Date: Fri, 21 Aug 2026 11:29:36 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 0/6] efi: mm/memory-failure: keep hardware-poisoned
 pages out of the next kexec
Message-ID: <aognoSPb8vbkR3U8@thinkstation>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
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

On Fri, Aug 21, 2026 at 03:06:00AM -0700, Breno Leitao wrote:
> The allocation is capped at 1MB, which covers 16TB at 2MB per bit. Past
> that the stub doubles the unit rather than growing the table, so the
> table stays bounded on any machine.

For unaccepted memory I didn't capped it. On x86, architectural maximum
is 4PB which would cost 256MB in the bitmap. It should be okay for the
scale.

> Memory hot-added after boot is not covered either: the bitmap spans the
> RAM the EFI memory map describes, and a frame outside it is silently not
> recorded.

We might update it if/when it gets solved for unaccepted memory.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


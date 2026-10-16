Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9684DCC6B38
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQB95Af/E5XMUzOd1o5+dg+Sf+tk922WnkyKACk5+dk=; b=xxSwKlN8aByw2Li+TsNhGGbuSf
	HBTLeYLvNu8XzGtwFtb9+MRyTfpK0VDlp3VZ+3xk+FlPOQhiDuPxribciI6IJCN24aLIY8SNIxfO4
	rDtg9LoggW0Xj9a9qf9wI4HNtFriPTYBctyrx6h4M+K4x7BJsOUNPCnM7XKPpy9WXeHgEjJ0oNJwd
	h2ppEUw/x5uDSw5EC0zSF4GJuOmdak1RcSyqnqWAzm2QIc/yxxK4c+uSDIE0KGqZePElOyRzMDXE1
	+TEMOuNBjQHxIvsGM2JjRe0+RvXM+3qxGjeG2ulMwriX56weHGAo8CT4zXAJng2LjCQf7Awrl+YJK
	Gxrso7ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkIU-00000003LOD-2UIl;
	Fri, 16 Oct 2026 15:56:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkIS-00000003LMy-31zy
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 15:56:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DA1C439D5;
	Fri, 16 Oct 2026 15:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8311F000C7;
	Fri, 16 Oct 2026 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166200;
	bh=yQB95Af/E5XMUzOd1o5+dg+Sf+tk922WnkyKACk5+dk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=UmuKQWaYNhLCoCDvX8WEM8hcq42dPkmZLFhcpxMHA9x4utlhotv8Bfcq7o95hJPdW
	 6T/dj2i5BbBlVux21pmLg1iLWVp6sHNB16FtiGhm3HHocacX8aFrMe22vLhymGO61i
	 vwVp6MCiq0eEs1kmPrhNOe0G6zdszUocUkFZMnqReoCov6qfl8hMtpmC3Davhncqzt
	 oAMLe5wkyi2OB2xZgrkIFSw55eN9G3P9AVt6oOCJJGslVO13upX34dD1vtLkLgdUSp
	 Lt3EtlPqIAjBbA1l2WRFTj2nJJkQW5fMJdHu84tYstWAH7xoecALQ7//2O+jIyGGcE
	 otrQO9Fmp8DGw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5BE5D198003A;
	Fri, 16 Oct 2026 11:56:37 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 16 Oct 2026 11:56:37 -0400
X-ME-Sender: <xms:MUnSakfzuYcWJiut2WUllz8GSqbeg6MbLu_a5l4pnrpc8TB1nfparg>
    <xme:MUnSahAzwY0W75fa-KrgEywqTeSBGUZCz6OP-8S7VesWAbLiyWSBEiQhbMW1OBw6k
    J_3S6DxFjLikGSirWPuZFvH3TOxTOaAltcFZhIGwd2DBEyNka00OP3O>
X-ME-Proxy-Cause: dmFkZTEd5A+po8hRzEuoSl6lbgWNmZNleZYJTjJeD+qXa20JbnLlhSKqyEW8jLoFYvJcYn
    SBmRcSI98oQZwgbaCtIhnWqdvYVVA0ib8iDey8x+O5Cqyi9T6c/SVIONSslSft+LfU3yH1
    crV0TLVqX2UkylxZgHGr/NSrLqmqU8MPwtxiAR3xM2a1rXr9uz//kHZ9RLGThEPck1N8iu
    YRCOpVisIQWp2Q3eHYq22vIaFRoGWqw3Sf3T+hfcZEsm3F8S7ROqwnz0S1XDQvN/0jhCA9
    Fusj2a/avYvPwAT0N1a5zJ3wG+Tp/KDi1XpMUotrdDVrep7Upus2yIlRmt+5KYEdGZefWJ
    RKcsokkX02LxsGbxe0bRU26k5WR0xvX2ls5b5USByHtU9BiQ1LAJqHm4el5XC9wmQOZQHa
    x1ywvLsPo5ptomQFkjsTWfA8ZM7HZC5iYrMPrX0uRu8V/GhFlCZf43vPGEvY3IPyRDAQwi
    hBU50uLFSoX0IJXDntBvLX8/ssDVhMBKYsrjhEmc6Q7zb1LUwh7h7WWBqj2dg8g2vxsbt0
    E3zVcGle6vkdNxsjfKx0YirYMuE33spaeySunshr96xjKEknsJ0YmCJoJk/kRzzvI1dex/
    v1dOZe0+oJoGx1y+QWSjGWy1irTZptXN1YhtohsK0d6xjCKdfapS6Z8wBIvw
X-ME-Proxy: <xmx:NUnSaroYEdU46thzMj9KCjPtsyJT7GhrjOISMsvF2_aZLZZU54xQMg>
    <xmx:NUnSahtU9Sgb1KGPYTnzsfWmgSsvEJdWZ9QQY9XfRILG_5BvjKAQZg>
    <xmx:NUnSajgHWCZp7C29Jk66411JPGXC77Uxz47AlJock2TjHPBIiRSUHg>
    <xmx:NUnSat2_A6ZknAC4W2Fr_OAirIJFVjZjyTPnu9V-tCMApqCbWvih-Q>
    <xmx:NUnSaj--l7QickoLRbAHz_Lfhp3Del5G5AuZ83LPZ75dnxseGIouatg4>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5291AF8008E; Fri, 16 Oct 2026 11:56:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 17:56:13 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Abhishek Shinde" <abhshinde@nvidia.com>
Cc: "Mark Rutland" <mark.rutland@arm.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Jeremy Linton" <jeremy.linton@arm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Vitaly Kuznetsov" <vkuznets@redhat.com>, "Philipp Rudo" <prudo@redhat.com>,
 "Viktor Malik" <vmalik@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Andrew Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <5236ef55-28b4-4331-8c7d-a6d112aa185f@app.fastmail.com>
In-Reply-To: <20261016144121.GA439341@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
 <20261014000227.GV13920@nvidia.com>
 <8fb05f13-e770-41a4-af66-d239b4c95201@app.fastmail.com>
 <20261016144121.GA439341@nvidia.com>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE format
 boot image
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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


On Fri, 16 Oct 2026, at 16:41, Jason Gunthorpe wrote:
> On Wed, Oct 14, 2026 at 06:39:14AM +0200, Ard Biesheuvel wrote:
>
>> > I've asked some folks here to take a look and try to test this with
>> > real DRTM capable HW. It seems very promising that it will work to me,
>> > and I surmize this is also close to boot a UKI?
>> 
>> It already works for UKIs as well.
>> 
>> The next step is to run it deprivileged - I think the arm64 stub code
>> is already very close to being runnable in that manner.
>
> Abhishek was able to test it on some Grace hardware, and investigate
> the DRTM. He was able to show it works, using some FW debugging to the
> serial port and the post-kexec dmesg:
>
>  <kexec>
>    INFO:    DRTM service handler: version
>    INFO:    DRTM service handler: get error
>    INFO:    ++ DRTM service handler: TPM features
>    INFO:    ++ DRTM service handler: Min. mem. requirement features
>    INFO:    ++ DRTM service handler: DMA protection features
>    INFO:    ++ DRTM service handler: Boot PE ID features
>    INFO:    DRTM service handler: dynamic launch
>
>    [..]
>
>    [  10.655030] DRTM: launch completed
>
> So this solution is absolutely viable for DRTM kexec. Great!
>

Excellent news!

> He had a couple of issues, I will try to summarize them as I
> understood them.
>
> 1) ARM DRTM requires that the executing CPU be the boot CPU when
>    launching the kernel. My patches enforced this in the EFI stub
>    assuming that the EFI stub will be the same CPU as after exit boot
>    services. Since the kthread has no CPU assignment it picks
>    something random and fails these checks:
>
>    [ 3219.695710] kexec_efi: EFI stub: ERROR: DRTM: boot PE 0x20000 
> does not match current PE 0x430000
>    [ 3219.695726] kexec_efi: EFI stub: WARNING: DRTM: preparation 
> failed, continuing without DRTM
>    [ 3219.732742] kexec_efi: EFI image suspended at ExitBootServices(), 
> system table @ 0x1001bff00090
>
>    The kthread this runs in picks a random CPU so it doesn't
>    work. Abhishek was able to put a kthread_bind() in to always use
>    the boot CPU
>

Interesting. I'm not sure this is a reliable workaround, though, given
that the return from ExitBootServices() occurs as a result of another
syscall(), and the kthread is long gone by then.

I think the reliable approach here is taking down all the other cores
before doing the kexec.

> 2) Most of our systems use 64K page size, so the restriction in the
>    series is not great. Abhishek used a 4k predecessor kernel and
>    confirmed he could boot a 64k successor
>

I've dropped that requirement already - the TTBR0 side can just switch
to 4k pages.

> 3) Some compile glitches:
>
>    1. arch/arm64/kernel/kexec_efi.c:175:35: error: 'PTE_ADDR_HIGH'
>    undeclared (first use in this function); did you mean 'PTE_ADDR_LOW'?
>

That is only #define'd when CONFIG_ARM64_PA_BITS_52 is set. I don't think
we should be using that directly, though - I'll investigate.

>    2. KEXEC_EFI_STUB declares depends on ARM64_4K_PAGES but nothing about
>    PA_BITS, so a 4K + 48-bit-PA config does not compile.
>

Same problem, I suppose?

>    3. With rustc 1.85.0, which is what scripts/min-tool-version.sh asks
>    for on arm64, the link fails:
>
>      ld: arch/arm64/kernel/kexec_efi_glue.o: undefined reference to
>      `__rust_no_alloc_shim_is_unstable'
>
>      ld: rust/alloc.o: undefined reference to 
> `__rust_alloc_error_handler_should_panic'
>
>    He used rustc 1.96.0 instead and it builds fine.
>

I think this is related to the use of the 'alloc' API, which my efiloader
crate uses but does not exist in the same way in the kernel. I'll look into
this as well.

In other news, I've added some other features to the prototype: x86_64
support, support for UKIs including sidecars etc (the kexec image loader
now accepts a cpio archive which can be presented as the ESP) and some
other improvements. This is highly in flux so let's compare notes often
so things do not diverge unnecessarily.




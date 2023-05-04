Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F1C77B7C
	for <kexec@archiver.kernel.org>; Thu,  4 May 2023 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzBmj2f8ixrvRoJ6WyZStkLpfMSam4/iDygyqPpBeeo=; b=gV/TMbo39FLSkF
	vYxHKm/JpaNigksWsj4ZHtT3XLE2KgwgvCBIeYfzCsSQswhw/CtTTIMGMbZZ8fqkkFPcYQjnbwmJK
	KzbWRObbiULRT8Gx5PaBAQD4RqHYm0vOF64YfEl3LJ9o2hxMxE5RN+OhHY5yBPnTXJCQAMSCQ5xHt
	YimpE9Fg4wVIkF1VZyQ8x3TDRPtNJeT7b3z1kQXrd1c649CDqz15KSwHo0/ffaByvyUzEoCpsWnBu
	VPc1DT+jojKCcMZ0ZlS6HG4dx5XWsfWAKDqWjiPIxNBc+OFAnZp+j44OOvpTESpgEQ4QeWu0HgJYq
	FqcCpf6ZEeBSRCe5ZPtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc9q-008MmT-1D;
	Thu, 04 May 2023 16:50:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puc9n-008Mm2-0x
	for kexec@lists.infradead.org;
	Thu, 04 May 2023 16:50:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2E0EC635B9
	for <kexec@lists.infradead.org>; Thu,  4 May 2023 16:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488ACC4339B
	for <kexec@lists.infradead.org>; Thu,  4 May 2023 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683219013;
	bh=LnxU0mtbpVcYRhXrl6BfN+mJMOSbX/mplQBWnjpmU9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nHjhbwIHbj7GWS4eeibhroKBklOxYBz2JWey63wimD3GfLUgE2M0FwhwriAL/DuiY
	 sFzC6tWwyfzaTw9HgiM45m93/msuWVkrax86bsjVe14ke8so2VAFSAkMGaTlhZHzTX
	 1/V2Y6eSMF/kDZY/xb0MZhpgjjmrgShVh1gR+TfO58ay7w1Ul5BcfBBZpN6PjZQvlP
	 7M2fU4iQwbzYs4SGZUErZ0fSeyY2u1TYiPLT6HR5mW7n1U8+m5nYrXB/oiyZoykvW2
	 bKHzgtZaq18UCsxIPQx7OeGXulGaiBo+IuXaRPQK5qJ+ISdgsr2q84ZikKRGUe/EPj
	 5qz1AHU1X3lyg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so868218e87.3
        for <kexec@lists.infradead.org>; Thu, 04 May 2023 09:50:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDxwcIncrz2TmM2PK6R+UbmxEEXcRG2Cktb2uWKwUKEpRWSMMp6a
	KE61SP6iRl8S4ldLP7PQcn2nW8MeXBUOAueJEQ0=
X-Google-Smtp-Source: ACHHUZ6L39r7UTYQIWcoXoMPUxF1kf6NkATn9zx5QFGjcqLkrzIAsQ3f/R98d9ZYtKN2w/Au2qSUkvohX97665N7ni0=
X-Received: by 2002:a19:5511:0:b0:4eb:3b4c:50ac with SMTP id
 n17-20020a195511000000b004eb3b4c50acmr2404597lfe.65.1683219011285; Thu, 04
 May 2023 09:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230504164147.1166614-1-jeremy.linton@arm.com>
In-Reply-To: <20230504164147.1166614-1-jeremy.linton@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 May 2023 18:49:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVdFd+t6meubb66eVy-x6Sbwh58N0D8zPSWQTQwpX1aw@mail.gmail.com>
Message-ID: <CAMj1kXGVdFd+t6meubb66eVy-x6Sbwh58N0D8zPSWQTQwpX1aw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support kexec'ing PEs containing compressed kernels
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, piliu@redhat.com, 
	bhsharma@redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_095015_402441_B89B71B3 
X-CRM114-Status: GOOD (  22.09  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 4 May 2023 at 18:41, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> The linux ZBOOT option creates PEs that contain compressed kernel images
> which are self decompressed on execution by UEFI.
>
> This set adds support for this image format to kexec by decompressing the
> contained kernel image to a temp file, then handing the resulting image
> off to the existing "Image" load routine to pass to the kexec syscall.
>
> There is also an additional patch which cleans up some errors noticed
> in the existing zImage support as well.
>
> Jeremy Linton (4):
>   arm64: Cleanup _probe() return values
>   arm64: Add ZBOOT PE containing compressed image support
>   arm64: Hook up the ZBOOT support as vmlinuz
>   arm64: Fix some issues with zImage _probe()
>

Thanks a lot for taking care of this!

This all looks good to me. The only comment I have is that EFI zboot
itself is generic, even though arm64 is the only arch that distros are
building it for at the moment. So it is not unlikely that some of this
code will end up needing to be shared.

Acked-by: Ard Biesheuvel <ardb@kernel.org>


>  kexec/arch/arm64/Makefile              |   3 +-
>  kexec/arch/arm64/image-header.h        |  11 ++
>  kexec/arch/arm64/kexec-arm64.c         |   7 +
>  kexec/arch/arm64/kexec-arm64.h         |   3 +
>  kexec/arch/arm64/kexec-elf-arm64.c     |   1 +
>  kexec/arch/arm64/kexec-vmlinuz-arm64.c | 172 +++++++++++++++++++++++++
>  kexec/arch/arm64/kexec-zImage-arm64.c  |  13 +-
>  kexec/kexec.c                          |  11 +-
>  8 files changed, 201 insertions(+), 20 deletions(-)
>  create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c
>
> --
> 2.40.0
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

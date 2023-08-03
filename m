Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B14EB64DD
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RafMcI7bMSzJi3kOD9Qj8pTpgEmgdTXvbm8/j39M26s=; b=EP5lMcXcj4Qn9F
	P9myEouGbzXz6WrRyYXGIpdQHNkeGTzisNd9/5XPJwlkqDo8AFZolbs1qyfM/+uD022psD9MYrlmz
	IQceU2BV1cA2sHWyMnqx0uZ7ZDVrZmZlGPDMB6/imDncqW8xxvEtnGTySKwHDeqczolfjpQXGgdOq
	a8sIqn57OmODewTryLKjX605ZtYg7WB1tu2TsLgkg86SyazgzowPILcPjha4eSb0sws/MIsI6kQYn
	o30BCAUx0WjKaaqRtaXz/EFjtLMz7TSnlktUpDgHtnQMOWZVs1d4fgHgHKuUaG4qbVhBCLRQysDnO
	Rix2JjrO5QDmCFbc8B0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZJ3-009dEl-08;
	Thu, 03 Aug 2023 14:28:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZIy-009dB5-1s
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 14:27:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DC08761DCC
	for <kexec@lists.infradead.org>; Thu,  3 Aug 2023 14:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB89C433C9
	for <kexec@lists.infradead.org>; Thu,  3 Aug 2023 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691072875;
	bh=SYezfMKoOwd06i4EdWxJdHq56YPVKCiPJTP05WrmoRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ce/zqNjzKTx1w0oEMvSeHRwJFaXj5t64SjzqGMBvSrjuRDlSertEXIyMH6eFgCiR4
	 0FzZRKjTZD7J/dSdi3DqzfDqUSH5JWTYDeC7sHxKW4qQJwJ3oazo6As/lYfBHcvIam
	 Mbs7Z/NZEL9fhlCxBOL3BKW5YjA0/A0OEBkMg+2GsezEALvkmp1KnuODa5JlbpkvFI
	 fk5ESeBlo7N+WiTKKW6BVICyWEOv4X9Ptqfydi8AwZrBxqgiNINnejLfVTzLAVC2ec
	 O3FSVvpxkKWNzF/SoCH30FUCBkcIAdzeJyTkkO9plQNPKcBtdtkj5cuEJPIlb8EK+b
	 BHWoMImDB56OA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so16109841fa.1
        for <kexec@lists.infradead.org>; Thu, 03 Aug 2023 07:27:55 -0700 (PDT)
X-Gm-Message-State: ABy/qLZM4pYkprJ5RM7t00hNNdn+wuufig6HLyljX41ghi7v+2/FJHvn
	LtmMz5H6SfooWjr0MOCr6mKgSlQFHXFWJBeYnB8=
X-Google-Smtp-Source: APBJJlE2li6enqKdhY/67+FOLHVsKLoDwihFl4Guijp3+nlazzgS5h35KJKK4NMvZ4fFFAlcETvzQ20xCTP2P0SmadQ=
X-Received: by 2002:a2e:870a:0:b0:2b9:4821:22b6 with SMTP id
 m10-20020a2e870a000000b002b9482122b6mr8216088lji.10.1691072873230; Thu, 03
 Aug 2023 07:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local> <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local> <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local> <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local> <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
 <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local> <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 3 Aug 2023 16:27:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
Message-ID: <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_072756_707733_40A89B83 
X-CRM114-Status: GOOD (  31.08  )
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

On Thu, 3 Aug 2023 at 13:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 2 Aug 2023 at 17:52, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Aug 02, 2023 at 04:55:27PM +0200, Ard Biesheuvel wrote:
> > > ... because now, entering via startup_32 is broken, given that it only
> > > maps the kernel image itself and relies on the #PF handling for
> > > everything else it accesses, including firmware tables.
> > >
> > > AFAICT this also means that entering via startup_32 is broken entirely
> > > for any configuration that enables the cc blob config table check,
> > > regardless of the platform.
> >
> > Lemme brain-dump what Tom and I just talked on IRC.
> >
> > That startup_32 entry path for SNP guests was used with old grubs which
> > used to enter through there and not anymore, reportedly. Which means,
> > that must've worked at some point but Joerg would know. CCed.
> >
>
> Sadly, not only 'old' grubs - GRUB mainline only recently added
> support for booting Linux/x86 via the EFI stub (because I wrote the
> code for them), but it will still fall back to the previous mode for
> kernels that are built without EFI stub support, or which are older
> than ~v5.8 (because their EFI stub does not implement the generic EFI
> initrd loading mechanism)
>
> This fallback still appears to enter via startup_32, even when GRUB
> itself runs in long mode in the context of EFI.
>
> > Newer grubs enter through the 64-bit entry point and thus are fine
> > - otherwise we would be seeing explosions left and right.
> >
>
> Yeah. what seems to be saving our ass here is that startup_32 maps the
> first 1G of physical address space 4 times, and x86_64 EFI usually
> puts firmware tables below 4G. This means the cc blob check doesn't
> fault, but it may dereference bogus memory traversing the config table
> array looking for the cc blob GUID. However, the system table field
> holding the size of the array may also appear as bogus so this may
> still break in weird ways.
>
> > So dependent on what we wanna do, if we kill the 32-bit path, we can
> > kill the 32-bit C-bit verif code. But that's for later and an item on my
> > TODO list.
> >
>
> I don't think we can kill it yet, but it would be nice if we could
> avoid the need to support SNP boot when entering that way.

https://lists.gnu.org/archive/html/grub-devel/2023-08/msg00005.html

Coming to your distro any decade now!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

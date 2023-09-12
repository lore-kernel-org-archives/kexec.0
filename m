Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B75BCA0ECF
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uCVgcRAaAk6ZRvbV6UNZeCa20vvEZtXWVE/HkYElr+M=; b=LpTKk+WJaGrwP3
	6JU6mWNVzD0Eb7miOIbfXYzli0PUsZ9ie7NzKcSBS+FdW2GfkVontFbDJmEjR1D4A2muD1USDD3hk
	6pLb22CTncxKLkYuPJwrnspZHkcR1X2P85L48BQ/+BB8T8s3phgGlNOayGq9U+8w/G4lghAT953qT
	rXk9K1O+XT7wGsL/12h2r9/OWXR/GWXhyqjNYsqyvtMpKeZD3T1jsFZeLVSTgodPOXpdz5Nouap7k
	Rg7A4iPkIxoM3soOAFF8/jUw8t+AvMYU0f3INEpiwUaweBG/1M9RQrWLnutTuSRY1imj5tXEzr6Wp
	5G9HAGdDXgEttkMDCCZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg0ho-002yFf-2c;
	Tue, 12 Sep 2023 10:33:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg0hl-002yF3-1J
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 10:33:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C556E604EF;
	Tue, 12 Sep 2023 10:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DE0C433C8;
	Tue, 12 Sep 2023 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694514792;
	bh=G6tVIRokXJPGvWKTOTzEY6bZMaPMLiU8C0XfnDPSZEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q70e/AuK1dlDgyzk41Krdj9+9w+iAK60hbwst/thT3/E+V0KBqHGq1bFVgnz1Y5tE
	 BNcZP8gyWxZmWST7xvNT50QLa1ma63GmiAsqDWy8g7fdExd57pqsnNBpEGG5y1CZZ4
	 2heJ6mtCFwi67ozo4eMk4t6tHr94WJ0+E7dwbUXTNqGn7j9LaJoii57znlFVGsSLTr
	 CalxdbClCdh/LrVxIBFE7zWni43Mp/BcEIcZiCJ88jtqnZd7S+8SJsueC3Lp4b40+d
	 +fJZjQLcQazODhw0TaBJUbAqaBJzs0VoOyrGVHiL5tqKRbPbbB7mhVtMICse6Raz7p
	 hKI6oYLR2eDCg==
Mime-Version: 1.0
Date: Tue, 12 Sep 2023 13:33:07 +0300
Message-Id: <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>
Cc: <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, <bhe@redhat.com>, <bhelgaas@google.com>,
 <lennart@poettering.net>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
In-Reply-To: <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_033313_503922_F18EF1E2 
X-CRM114-Status: GOOD (  21.17  )
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

On Tue Sep 12, 2023 at 1:54 AM EEST, Jan Hendrik Farr wrote:
> > What the heck is UKI?
>
> UKI (Unified Kernel Image) is the kernel image + initrd + cmdline (+
> some other optional stuff) all packaged up together as one EFI
> application.
>
> This EFI application can then be launched directly by the UEFI without
> the need for any additional stuff (or by systemd-boot). It's all self
> contained. One benefit is that this is a convenient way to distribute
> kernels all in one file. Another benefit is that the whole combination
> of kernel image, initrd, and cmdline can all be signed together so
> only that particular combination can be executed if you are using
> secure boot.

Is this also for generic purpose distributions? I mean it is not
uncommon having to tweak the command-line in a workstation.

> The format itself is rather simple. It's just a PE file (as required
> by the UEFI spec) that contains a small stub application in the .text,
> .data, etc sections that is responsible for invoking the contained
> kernel and initrd with the contained cmdline. The kernel image is
> placed into a .kernel section, the initrd into a .initrd section, and
> the cmdline into a .cmdline section in the PE executable.

How does this interact with the existing EFI stub support in linux?

> If we want to kexec a UKI we could obviously just have userspace pick
> it apart and kexec it like normal. However in lockdown mode this will
> only work if you sign the kernel image that is contained inside the
> UKI. The problem with that is that anybody can then grab that signed
> kernel and launch it with any initrd or cmdline. So instead this patch
> makes the kernel do the work instead. The kernel verifies the
> signature on the entire UKI and then passes its components on to the
> normal kexec bzimage loader.
>
> Useful Links:
> UKI format documentation: https://uapi-group.org/specifications/specs/unified_kernel_image/
> Arch wiki: https://wiki.archlinux.org/title/Unified_kernel_image
> Fedora UKI support: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_1

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

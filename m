Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03805EDE9AD
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G31kAIlh7bM6aiP8dRo0STFU5lraO6NDUPZ3KEs0hKQ=; b=wzpFcZSUDcRRMX
	hPm3H7ozDH5iqUj8cVJHOjHiWL3nMSwiD4swB/ZFhWJ+CV9wd9DyQsjJgTgq3xwUZ7YTlV9bO0QqG
	1ULHX2pBRhPcqZYQs5F+eLUKdRiGQtUcBgtweoG5Gmch4rWlplzk8YHCyO7PFSYQ/witKyQhnsH1c
	QH0AgX1s3ZcFPUMPlIfupmOliGg5ZLSlxh7rsybLjQrP7Cw1cZQtX7VFGE/IkTRugwz/1oiIICqpN
	dMpPj59EAcnC/t5yq9E89I6Nje4qZBKDzXsRn9njjq3Tra0hNDd22u7Ztk3GDIX8juDtLkHa1DI1U
	tZGuS7S7ldnraR829zAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qglDX-008JBd-0h;
	Thu, 14 Sep 2023 12:13:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qglDU-008JAT-0i
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 12:13:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 46F6A61D0E;
	Thu, 14 Sep 2023 12:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309EBC433C7;
	Thu, 14 Sep 2023 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694693582;
	bh=RrzfH6UbrmAt6KmTCe5UqLl8JJkSJQZSUuFTonNvkh0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=a4EmMNTfKpEzhz1VhakLJKRSXwaOcGp5rkN8Tpc5zNgAehu5Ty7hucgLpUnLaYAA6
	 IBT92FOnlRCVlF1wTIj7LdXT4xP3+PtQtFCrI9P0mTiCPC2ILho8tuis4hJfasnp/o
	 sCx6Sw0X4L5+fLOXMwNqTUolLgyudgo+U0WjvIgjP9n6sw1hu+RVbibennJnhRDwEv
	 l0NsBphimJ48ny85AsQfGMoMmDC3UdxoLgAsxVoulSeNsKgWj3e2F2jQx0kdRV2x9Z
	 /iAVk1TQPFKnuy6/JSR9GH6mQO2vFSWLHdNwL2xBpjEAPtRcVZ2ZQQThgh3gVR1RFv
	 Xzj81y4MchDTw==
Mime-Version: 1.0
Date: Thu, 14 Sep 2023 15:12:58 +0300
Message-Id: <CVIMQI0YC3HN.1NUKBC7EF0M31@suppilovahvero>
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 <bhelgaas@google.com>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lennart Poettering" <mzxreary@0pointer.de>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
 <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
 <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
 <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero> <ZQLOLLbu0fh27LpQ@gardel-login>
In-Reply-To: <ZQLOLLbu0fh27LpQ@gardel-login>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_051304_340931_CFD52C3D 
X-CRM114-Status: GOOD (  33.86  )
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

On Thu Sep 14, 2023 at 12:11 PM EEST, Lennart Poettering wrote:
> On Mi, 13.09.23 17:45, Jarkko Sakkinen (jarkko@kernel.org) wrote:
>
> > On Tue Sep 12, 2023 at 11:49 PM EEST, Jan Hendrik Farr wrote:
> > >
> > > > These are sort of "tautological" arguments. There must be some
> > > > objective reasons why this architecture was chosen instead of
> > > > other (i.e. using what already pre-exists).
> > >
> > > I think I misunderstood you in my earlier reply. I do not understand
> > > in what way you think my arguments are tautological. Can you
> > > elaborate?
> >
> > current Linux kernel has these features *already* in
> > place:
> >
> > 1. CONFIG_EFI_STUB
> > 2. CONFIG_CMDLINE
> > 3. CONFIG_INITRAMFS_SOURCE
> > 4. Secure boot with MOK keys and .machine keyring to manage them.
> >
> > Given that every single feature in IKU does exists in some form
> > in the Linux kernel, I think it is fair to ask why scrape away
> > this all existing science and reinvent the wheel?
>
> Nah, systemd-stub does considerably more than what you list above.
>
> 1. It measures the components of the UKI separately into PCR 11, 12,
>    13, which makes the mesaurements predictable, and allows vendors to
>    provide a signed PCR policy with can be used to unlock TPM2 secrets
>    that ause a PolicyAuthorize policy. This is a fundamental
>    improvement over mechanisms that bind to literal PCR values, since
>    the "brittleness" goes away.

I guess this is an appropriate reference:

https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/

I quickly checked what sort of use cases we have for PCRs in the
kernel. I could spot one:

https://www.kernel.org/doc/html/v6.5/security/keys/trusted-encrypted.html

Generally, my only concern here is potential conflicts with user space
extending the same PCRs as systemd does.

Since this all is only used for boot phase I guess this should not be
an issue, right?

> 2. That said signed PCR policy is included in the UKI in another PE
>    section, that is made available to userspace.
> 3. If you like it brings a boot splash to screen before passing
>    control off to the kernel, which is also contained
> 4. It can contain a devicetree blob, which it will setup for the
>    kernel it spawns
> 5. There's a random seed maintained by systemd-stub in the ESP that is
>    updated and passed to the kernel, which includes in in the pool.
> 6. It picks up "credentials" (which are TPM protected, encrypted,
>    authenticated supported by systemd) that can be used to securely
>    parameterize the invoked system from the backing fs (i.e. the
>    ESP). Similar it can pick up sysext images (which is another
>    systemd thing, i.e. dm-verity protected, signed disk images which
>    can extend the initrd and the host, by being overlayed on /usr).
> 7. It picks up "add-ons" -- which are PE binaries that actually contain
>    no code, but are SecureBoot signed/shim signed "mules" for carrying
>    addition kernel cmdlines, devictree blobs (and maybe in future
>    initrds) that allow some form of modularity in the UKI model.
>
> And there's more. This is just off the top of my head.
>
> Now, I can totally see you personally might not need any of this
> stuff, fine, but a claim that this stuff is redundant is just bogus.

Backing story was missing completely. Please add this reasoning to the
patch set in some form (cover letter and possibly some patch
descriptions). It is bogus without proper context, which is totally
different than my personal use. The response that I received was more
related to personal use.

It took quite many emails to learn about PCR usage. IMHO that should
have been told here so that we can then e.g. inspect possible conflicts
etc.

> Afaics all big distributions are preparing to providing UKIs
> soonishly. It would be fantastic if kexec would just work with this
> too, and the dissection would be done on the kernel side instead of
> userspace.

I don't see any existential reasons anymore not to include this to the
mainline but it takes what it takes in terms of time span of course.

>
> Lennart
>
> --
> Lennart Poettering, Berlin

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

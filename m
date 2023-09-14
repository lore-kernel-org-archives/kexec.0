Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF13EDE99E
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KV86NdSClnoLSFOf12bJS1fjB11RmJ7GjcpT5Oamzik=; b=ji5GQoS0nSKF0P
	BIWXXbQezcxnRv6P2mqLuNipiaGFfq5tq5iN3b8GNYKfXLi4+RorOChGyW0oyj5LOryrukMJPGhWG
	obeR+G/n4I76rxiuRnkmuLKRt2XXf44TtZ1Ia318F5bLyfT3kwDvmsEpjGDE4115HgjY5LutZNB22
	0rRmvWtaJIZAk0zTFve1+Ps1nBs0sCZDeM+yaTfokA9YgQ2AU+mXioXQlSpurM9RyIcKvzW643bTF
	PdfQqwxP4sOwRmqPO08RZ21PGgt+YjXylgIwH5jrz7aAw/7jOndx5yn22VbU12vkiWJcikQWNv8Vu
	fss7xA2WNgVK1ZBpslDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgiNY-007oK1-0Y;
	Thu, 14 Sep 2023 09:11:16 +0000
Received: from gardel.0pointer.net ([2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgiNV-007oIm-0a
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 09:11:14 +0000
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 41459E801F5;
	Thu, 14 Sep 2023 11:11:09 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id C9E14160258; Thu, 14 Sep 2023 11:11:08 +0200 (CEST)
Date: Thu, 14 Sep 2023 11:11:08 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
	dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
	akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
	bhelgaas@google.com, Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Message-ID: <ZQLOLLbu0fh27LpQ@gardel-login>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
 <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
 <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
 <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_021113_363020_CD176486 
X-CRM114-Status: GOOD (  19.46  )
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

On Mi, 13.09.23 17:45, Jarkko Sakkinen (jarkko@kernel.org) wrote:

> On Tue Sep 12, 2023 at 11:49 PM EEST, Jan Hendrik Farr wrote:
> >
> > > These are sort of "tautological" arguments. There must be some
> > > objective reasons why this architecture was chosen instead of
> > > other (i.e. using what already pre-exists).
> >
> > I think I misunderstood you in my earlier reply. I do not understand
> > in what way you think my arguments are tautological. Can you
> > elaborate?
>
> current Linux kernel has these features *already* in
> place:
>
> 1. CONFIG_EFI_STUB
> 2. CONFIG_CMDLINE
> 3. CONFIG_INITRAMFS_SOURCE
> 4. Secure boot with MOK keys and .machine keyring to manage them.
>
> Given that every single feature in IKU does exists in some form
> in the Linux kernel, I think it is fair to ask why scrape away
> this all existing science and reinvent the wheel?

Nah, systemd-stub does considerably more than what you list above.

1. It measures the components of the UKI separately into PCR 11, 12,
   13, which makes the mesaurements predictable, and allows vendors to
   provide a signed PCR policy with can be used to unlock TPM2 secrets
   that ause a PolicyAuthorize policy. This is a fundamental
   improvement over mechanisms that bind to literal PCR values, since
   the "brittleness" goes away.
2. That said signed PCR policy is included in the UKI in another PE
   section, that is made available to userspace.
3. If you like it brings a boot splash to screen before passing
   control off to the kernel, which is also contained
4. It can contain a devicetree blob, which it will setup for the
   kernel it spawns
5. There's a random seed maintained by systemd-stub in the ESP that is
   updated and passed to the kernel, which includes in in the pool.
6. It picks up "credentials" (which are TPM protected, encrypted,
   authenticated supported by systemd) that can be used to securely
   parameterize the invoked system from the backing fs (i.e. the
   ESP). Similar it can pick up sysext images (which is another
   systemd thing, i.e. dm-verity protected, signed disk images which
   can extend the initrd and the host, by being overlayed on /usr).
7. It picks up "add-ons" -- which are PE binaries that actually contain
   no code, but are SecureBoot signed/shim signed "mules" for carrying
   addition kernel cmdlines, devictree blobs (and maybe in future
   initrds) that allow some form of modularity in the UKI model.

And there's more. This is just off the top of my head.

Now, I can totally see you personally might not need any of this
stuff, fine, but a claim that this stuff is redundant is just bogus.

Afaics all big distributions are preparing to providing UKIs
soonishly. It would be fantastic if kexec would just work with this
too, and the dissection would be done on the kernel side instead of
userspace.

Lennart

--
Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

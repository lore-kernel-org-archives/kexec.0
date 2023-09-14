Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9208CEDE9BB
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2iBCRpMWqsNS3NrRcb6viaI2TaPcrnQ8CesTRoFH27o=; b=hdCGGo8CBz7tQh
	95LgA+9vObji9dv8lCbFmu/gDshDgrUnz2EdBHi69JAfpWCAuqE/M635AknCzPAkSr+L73FMT6+hi
	yJfu+e+2xSXVXR3IGuyWOEpSCz5W1iYo9E3qdVs2Oby3gpJSFLhmJlb2EjBITsmSd/kGAcmBksFyq
	8rQqtONXOVMSYJ7gZOpXOUPD0WjXbLrn52EsIelTwHlEs2r5xBa+IVDJSzN96whUGC7farWghUA5k
	iwNbZaMc0Z4EGbR4cppOyP/x+Web++E7ap3Bh+tteDPq1hgqyFk8oaBVRTN9m++TyWgdvm2bIZq25
	fYmnjbjnCudbbAUu3ftw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qglQL-008KBu-1U;
	Thu, 14 Sep 2023 12:26:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qglQI-008KB5-2e
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 12:26:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id D021FCE265C;
	Thu, 14 Sep 2023 12:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A2C433C8;
	Thu, 14 Sep 2023 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694694375;
	bh=uwlERtgcIl0boGXES+0Lt7l/GYtqRgkvwlIpXYuTrm8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YMGgoK0vFJEZoIZLtjMUT/xcAi3HPriqpw9cgkjwNFEh6vBAofPrJ8v0/yo0uOC7i
	 XWHuPDy/xbSvaK8C6WgylQQPRgD11XSQZOPvPV2nyKDynKecvnmcmvICbUgC0GSl0b
	 olHpjVrfOBE+v/pzfg6/Fpt/BDA2ydU1f2W6xVJYWNrEhFYN+N8SluW9NSyfFRJ4hw
	 WdL+XNAlkrdZWstCts+UpCRGFritbMLgy3VClfw5T7vB1QsUN/VefDbGATVrz3dAfT
	 fNb3B4xndSvJUymSfj8S/H4Se7SG+Jxtq46MQqTUsm3QitAbhVnl4NYIwGpPEIHCCA
	 Ul/gVfgqDt2nA==
Mime-Version: 1.0
Date: Thu, 14 Sep 2023 15:26:10 +0300
Message-Id: <CVIN0M3IHRKL.3U005Y5QTOJL5@suppilovahvero>
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, <bhe@redhat.com>, <bhelgaas@google.com>,
 <bluca@debian.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lennart Poettering" <mzxreary@0pointer.de>, "Philipp Rudo"
 <prudo@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen> <ZQLTJFb3S/xn5CWo@gardel-login>
In-Reply-To: <ZQLTJFb3S/xn5CWo@gardel-login>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_052619_204390_6ED8E3A1 
X-CRM114-Status: GOOD (  34.29  )
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

On Thu Sep 14, 2023 at 12:32 PM EEST, Lennart Poettering wrote:
> On Mi, 13.09.23 16:00, Philipp Rudo (prudo@redhat.com) wrote:
>
> > For example there are two definitions for the UKI which contradict each other.
> > The dedicated one [1] you have cited earlier and the one in the BLS for type #2
> > entries [2]. In [1] the .linux and .initrd sections are mandatory and the
> > .osrel and .cmdline sections are optional while in [2] it is the other way
> > round. Which definition should the kernel follow?
> >
> > Furthermore, I absolutely don't understand how the spec should be read. All
> > the spec does is defining some file formats. There is no word about which
> > component in the boot chain is supposed to handle them and what exactly this
> > component is supposed to do with it. But that is crucial if we want to add UKI
> > support for kexec as the kexec systemcall will replace the stub. So we need to
> > know what tasks the stub is supposed to perform. Currently this is only some
> > implementation detail of the systemd-stub [3] that can change any moment and I
> > strongly oppose to base any uapi on it.
> >
> > In the end the only benefit this series brings is to extend the signature
> > checking on the whole UKI except of just the kernel image. Everything else can
> > also be done in user space. Compared to the problems described above this is a
> > very small gain for me.
> >
> > Until the spec got fixed I don't see a chance to add UKI support for kexec.
>
> So that spec is initially just a generalization of what
> systemd-stub/systemd-boot/ukify does. The descrepancies between the
> cited specs mostly come from the that generalization. If you want to
> enumerate kernels and order them the ".osrel" stuff for example is
> necessary, hence the boot loader spec really wants it. If you don't
> care about the boot loader spec though and just want to register the
> kernel UKI PE directly in BootXXX efi vars for example, then there's
> no need to include .osrel. That all said we should certainly make the
> two specs align better, and clarify the situation. Suggestions/patches
> more than welcome.
>
> Ultimately, I think a spec written as description with a single
> implementation in mind (i.e. systemd) is a generally a bad spec. Hence
> if kexec in the Linux kernel wants to add support for it, that'd be
> great but I'd see that as an opportunity to adjust the spec to the
> needs of the Linux kernel in this area, so that it reflects well more
> than just one backend implementation.
>
> Hence, seeing the spec as set in stone and as inherently low quality
> is the wrong way to see it I am sure. Instead, the goal here is to
> adjust the spec to make it work really nicely for *both* systemd and
> the kernel.

Bringing better backing story [1] would also help the spec. Immeditaly
when there's some reflection surface, also the possible faults it the
spec become more apparent. Also this makes spec refinement less boring,
which can be boring and tedious if you write it isolated by yourself or
in a small group :-)

I need to check if I could with some effort extend my current testing
environment for UKI [2]. Need to study this better at some point.

> Lennart
>
> --
> Lennart Poettering, Berlin

[1] https://social.kernel.org/notice/AZklKOsIYBZXDL9Bya
[2] https://github.com/jarkkojs/buildroot-tpmdd/compare/master...linux-6.5.y

BR, JKarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

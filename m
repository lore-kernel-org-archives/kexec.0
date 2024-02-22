Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE9EC48BF8
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s7/4PxTs0pzGrDOmPRj5ZayRvgpBYYWWhpKEqfIDGRw=; b=FE0zH5RrejmLxE
	oTclKl2Y63hf4EizJKX/w3mjDVHtb0vKZ1gAIXJXMQ3Zk2fTAJCV4ip0dxPC9julrfj7ZRErMTZUO
	Be2UTIu944enT0/Ye9P6Hc+wNRqmVe34Pbiwm47jOTmg3YuC/1iTo4KNAe6rNSNiGIrBsTlJ9IGsi
	EMkLUNtFXlIF+0cLbVHA19U5XNrXu3DR5RlzT13gxqX7pWpC/mIjn6eE8/1D2CFVKLsj66UABC16H
	tgv8yugRt/unDSTZ3xzio44v8QLK1QYqS1FDlTGlD7G/kCDXb0IgEAjnGMXLJr862s8saw7NR37mB
	CXkhpGdluV2IL8AwK9WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5TX-00000004GVA-3neP;
	Thu, 22 Feb 2024 09:34:43 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5TU-00000004GSU-2HDR
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 09:34:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DF162CE1E98
	for <kexec@lists.infradead.org>; Thu, 22 Feb 2024 09:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B4C433F1
	for <kexec@lists.infradead.org>; Thu, 22 Feb 2024 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708594477;
	bh=twL/O1XH0IQ5h96lKQERqeU1tJQqEQZBVZgUwRHwFlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jcncjh+y1tVYMLld1ZQCZGfPYyIJx2iPpfQCPBbIimujG7o+Rsyys/8gzP/O+f8fV
	 XOw/s6eUtIWCcllKyiMXgacGO5soYfbkHQ0+NEEZ1gf3hemDhVJMrG2sP09NaH4g7F
	 zIT9AVu3pe4nydblV2OzqtI7v3ecEuxyolBXXh7dv59kcBCbNk743kWTeJpm7gbrhf
	 aSNV0DhaTVcL7JmzUO3hEtIFNjBvGVXrv1o51RaGkEDegP1D8rP4jybV2Zb51efNJ/
	 AfOCtZWZEd7T9tbA94bHp6B457qYv3iIAGeOTxTd+X6rzol00H4VwsfSOeaQmwWuO/
	 U/sJm+TlQIz0g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512bde3d197so4300722e87.0
        for <kexec@lists.infradead.org>; Thu, 22 Feb 2024 01:34:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWocY7pg5loiQ50KIhOOfLyCDJjzLWhryZmF/BrdK2JvvYpWJm5x6ih8AVDEqP/N9QYpu/MV8BqGiPE+VGKt6/YoPnPgRVJra8E
X-Gm-Message-State: AOJu0Yw7AIF6gmg9TbV8kgdUdW7lhU2Tlu/ouXzhvMnmnqYiYZD4J+qQ
	uiQE2ZUTdVHA+B7qrBDdCA3wCK1w7igdexO4L13dV76fAepY8ieCu8TgXV1P4ExLAXA0MIJ2OTQ
	i23hRRtW6ZfwS0umrPGO7aXVTr70=
X-Google-Smtp-Source: AGHT+IFgnHge1ffZxf+MbWd8mZJewYby/ooDbKKmh7V38xeDaM5XPDlRS942sAJqjVoJxG0ZgpzQmoetZB69KZLL9/Y=
X-Received: by 2002:a05:6512:b0f:b0:512:d5ca:eb2f with SMTP id
 w15-20020a0565120b0f00b00512d5caeb2fmr3086686lfu.52.1708594475263; Thu, 22
 Feb 2024 01:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com> <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
In-Reply-To: <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Feb 2024 10:34:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
Message-ID: <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com, Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_013440_959601_175E562F 
X-CRM114-Status: GOOD (  34.75  )
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

On Thu, 22 Feb 2024 at 04:05, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 15/02/2024 8:17 am, Ard Biesheuvel wrote:
> > On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
> >> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> >>
> >> The SHA algorithms are necessary to measure configuration information into
> >> the TPM as early as possible before using the values. This implementation
> >> uses the established approach of #including the SHA libraries directly in
> >> the code since the compressed kernel is not uncompressed at this point.
> >>
> >> The SHA code here has its origins in the code from the main kernel:
> >>
> >> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> >>
> >> A modified version of this code was introduced to the lib/crypto/sha1.c
> >> to bring it in line with the sha256 code and allow it to be pulled into the
> >> setup kernel in the same manner as sha256 is.
> >>
> >> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > We have had some discussions about this, and you really need to
> > capture the justification in the commit log for introducing new code
> > that implements an obsolete and broken hashing algorithm.
> >
> > SHA-1 is broken and should no longer be used for anything. Introducing
> > new support for a highly complex boot security feature, and then
> > relying on SHA-1 in the implementation makes this whole effort seem
> > almost futile, *unless* you provide some rock solid reasons here why
> > this is still safe.
> >
> > If the upshot would be that some people are stuck with SHA-1 so they
> > won't be able to use this feature, then I'm not convinced we should
> > obsess over that.
>
> To be absolutely crystal clear here.
>
> The choice of hash algorithm(s) are determined by the OEM and the
> platform, not by Linux.
>
> Failing to (at least) cap a PCR in a bank which the OEM/platform left
> active is a security vulnerability.  It permits the unsealing of secrets
> if an attacker can replay a good set of measurements into an unused bank.
>
> The only way to get rid of the requirement for SHA-1 here is to lobby
> the IHVs/OEMs, or perhaps the TCG, to produce/spec a platform where the
> SHA-1 banks can be disabled.  There are no known such platforms in the
> market today, to the best of our knowledge.
>

OK, so mainline Linux does not support secure launch at all today. At
this point, we need to decide whether or not tomorrow's mainline Linux
will support secure launch with SHA1 or without, right?

And the point you are making here is that we need SHA-1 not only to a)
support systems that are on TPM 1.2 and support nothing else, but also
to b) ensure that crypto agile TPM 2.0 with both SHA-1 and SHA-256
enabled can be supported in a safe manner, which would involve
measuring some terminating event into the SHA-1 PCRs to ensure they
are not left in a dangling state that might allow an adversary to
trick the TPM into unsealing a secret that it shouldn't.

So can we support b) without a), and if so, does measuring an
arbitrary dummy event into a PCR that is only meant to keep sealed
forever really require a SHA-1 implementation, or could we just use an
arbitrary (not even random) sequence of 160 bits and use that instead?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

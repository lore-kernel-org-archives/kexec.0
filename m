Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B39EC77B7C
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0migSFh+dCkKY1g7Jgzb91cXAXNKlHU7CceKhsJQspE=; b=ZIs8kMcOq8AnfC
	+OBUKvYOCwDQvqhPd/r07eJPQf1HZSqOXbRpAo7v/uaHTHXcDvIKBdMsjb+kpaKauly567o8bCocA
	Weih5YND6b5N7JAP/loM5vP2MJsi7unX4qY8QQLWiVk1v4ZxrEMhd+VwME3yIxoBiiSy2ZJ9au6SW
	SlYinj7mQjrN36+UOeoQKO3FxlBY5xyWVGPy08IUyCync78cDH7rqwjV8wF1KT6/p0JAzN7aJiHyH
	euJ1iN7KwxkzZZGWN7AwUDZH1LYocS1uKtmGpcGmYXvAii6jAUuuyXRQ5Z3NGnzeO1oMMz1YH1qfD
	gahdv1XDdCb1eV9oh20w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxRPx-00BsMv-05;
	Fri, 12 May 2023 11:58:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxRPu-00BsM9-0D
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 11:58:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 394F2655D9
	for <kexec@lists.infradead.org>; Fri, 12 May 2023 11:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A3C433AE
	for <kexec@lists.infradead.org>; Fri, 12 May 2023 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683892712;
	bh=kBhJdbyF6NKdOXxRSKL9gtjCpg8g2as7soVqRjtDJis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WIQ4MS7o0Hqbi+1MvcqYhXbhBRPuD8I/plsTbVMLgMyq/fwWG1/cxYKX8JqskFdH0
	 3d1pox/z3YlrpEX0Fn7gDOiw4fBdxxsEPo5CYjDGr6oz8D0TU6+hIGnJ99JQpbdt5r
	 hwG/bjBfaph2oFB82BAuNQ4mhtfWYQnHvSYnXgew1tQQavYHG8twGfMI5LdyHg0e5l
	 SG8PthdYX6PLxq/F6G2VLSjFWF37KrS0OzjQp8oD+cUXLcxSjNmSe8NvCCElWe8m5K
	 hi5JmDxMFALwra/9HPthOJ2ZJX2UfBVIGOz4PqEbS1FMmEvoa5glDKGMpb7sgCFLfk
	 qoHgzEC7dn6vQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4eff50911bfso11016826e87.2
        for <kexec@lists.infradead.org>; Fri, 12 May 2023 04:58:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDxsnC7zlkFmHqbnG++NwSdPU1CZ9hjn1gN4zhC/DRRDkX/oa9kg
	drH2f9zXWEIya+g3rkImdSIFyOFhg6bGyqzbR+A=
X-Google-Smtp-Source: ACHHUZ4lN3kGWU0INu3Ag5oHbIJY8Yq+UgbBBSxtAi2XEj4awDEsVBTTDIqxI0QgVndMh10ixrl6vNC24Nn+1nyHsx8=
X-Received: by 2002:ac2:5ecc:0:b0:4f0:2e3:740f with SMTP id
 d12-20020ac25ecc000000b004f002e3740fmr4072413lfq.54.1683892710012; Fri, 12
 May 2023 04:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com> <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org> <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
In-Reply-To: <20230512112847.GF14461@srcf.ucam.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 May 2023 13:58:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
Message-ID: <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	iommu@lists.linux-foundation.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	James.Bottomley@hansenpartnership.com, luto@amacapital.net, 
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_045834_176162_AB97FAC7 
X-CRM114-Status: GOOD (  22.98  )
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

On Fri, 12 May 2023 at 13:28, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Fri, May 12, 2023 at 01:18:45PM +0200, Ard Biesheuvel wrote:
> > On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > >
> > > On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
> > >
> > > > SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> > > > now?
> > >
> > > TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
> > > at the whim of the firmware in terms of whether the SHA-2 banks are
> > > enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
> > > extending the SHA-1 banks, a malicious actor can later turn up and
> > > extend whatever they want into them and present a SHA-1-only
> > > attestation. Ideally whatever is handling that attestation should know
> > > whether or not to expect an attestation with SHA-2, but the easiest way
> > > to maintain security is to always extend all banks.
> > >
> >
> > Wouldn't it make more sense to measure some terminating event into the
> > SHA-1 banks instead?
>
> Unless we assert that SHA-1 events are unsupported, it seems a bit odd
> to force a policy on people who have both banks enabled. People with
> mixed fleets are potentially going to be dealing with SHA-1 measurements
> for a while yet, and while there's obviously a security benefit in using
> SHA-2 instead it'd be irritating to have to maintain two attestation
> policies.

I understand why that matters from an operational perspective.

However, we are dealing with brand new code being proposed for Linux
mainline, and so this is our only chance to push back on this, as
otherwise, we will have to maintain it for a very long time.

IOW, D-RTM does not exist today in Linux, and it is up to us to define
what it will look like. From that perspective, it is downright
preposterous to even consider supporting SHA-1, given that SHA-1 by
itself gives none of the guarantees that D-RTM aims to provide. If
reducing your TCB is important enough to warrant switching to this
implementation of D-RTM, surely you can upgrade your attestation
policies as well.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E214D591AE
	for <kexec@archiver.kernel.org>; Mon, 18 Nov 2024 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O1w+lsuqWYRJntMtz2qLI0BlT/+XwPoIEjRUBsn52Fc=; b=Gj18CawctkQpbHjmI2z6DdYSDE
	C9SkNUyztpDx+R9YOTMSsdqdQuHbxXPVT240X8eLPWAeVqaSjNMJnNO4odWQV5LNr1VILc00E3+aW
	tor9lJVp39welcFYCp17x04tTLrTpGWozs/9Mxjj0oCsh+NGYUioY7hDCHTFMwGI59ig6Pub6UAPo
	LNIGipgiHg9eEBGQk5MHVD2KH4dfvIz3/NAVOc4T6ygR0qDGFMkEWGvFqVIa+2oPAF3gRAFr4W7iI
	+QnjVg2T2t/4batnH+63HL/EQIxL/7lE+hIuq0cBCZiGJUgGqjDFbwqmgU/woF5JMoa8IRiWVcJm4
	LVZv+YOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6il-0000000AN8x-0HU8;
	Mon, 18 Nov 2024 18:43:35 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6ii-0000000AN5w-0r9Z
	for kexec@lists.infradead.org;
	Mon, 18 Nov 2024 18:43:33 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a9ed49edd41so20740566b.0
        for <kexec@lists.infradead.org>; Mon, 18 Nov 2024 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1731955410; x=1732560210; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1w+lsuqWYRJntMtz2qLI0BlT/+XwPoIEjRUBsn52Fc=;
        b=aaew6fxaScJjBsjrs6vw3cTyib5DoyiZjQMWsHQ2zSp2CJei8RlDT/rIkLbK+b0koX
         2DlncLAKOsIncUAuRVV4mqdR33WWNBxlYEsWBi8F7UYYdQAIO8ZHaTJEYVrPMr+qUfwt
         ITgBu8RWsz9eUWwoottcxSnizPCp1djWtPN7iwfc21p6jQat4j2RY2ZfSQBxjvZXBg2i
         ZbwAUI02ciR1Ax6MIR9SMhOmuDb9SjtsYgcBsUq5HxOVZxaK15g3OEsZbcbjJik3BzPs
         wp+Bp4qF9VLSzlFSgBqUSvouWC/gLTAhSHka80+CxHOOy6YSoY3zRaYq9fZt+Wl9jvyG
         ysMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731955410; x=1732560210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1w+lsuqWYRJntMtz2qLI0BlT/+XwPoIEjRUBsn52Fc=;
        b=rQWIe70PFkSzCS4MWTjJvKExioiwY9YGGXqW1ZEKsxKZGY9gZTe90MUKYkWlwOHGfC
         SiurjOgTPxC0PLgBMYEZqZeshCOS1qmERJup11hXNfIWYcxZmSIUKPtfwAypLyKEB8eo
         TzOrjn61iconaQMfzU9536kzfJrGRtXYWqz2apdS51OBPSx3iLjGEoVpzJlKS5eZX2Zj
         Exhp+EtgsX78q50sMQEi50ULwyEuP8L8ZPg2z8/kJeimdUM5vaZu0VSPTFjzL+4y1eA2
         BoVEH0aMcj7NpFD17gg5XuDLEsJO9BbykhV9fFFeYdzE4XhelOLYIP2rwB84nULRKSC9
         PRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh4bHKrOJmoQv4MplxTY49cVDD4XL08mXQSEks+TKYU31onEvzURgW6hiJxcRDeQV1l1CDOw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6Yz/ygAJue8gygxWCp84ew+rqmMd2HETxBR9FsdY8oTe/67HO
	xghmAoYUJ9hZNYn3KNJv4aWzrgdfKO5KrTDKMTCXaIjSrJge9zDAdmRMEP1/vLkpzlxuUE0weC8
	LZQMKLDRFTKnx0/Ee5yAhQVjVghnXXT/geXL9
X-Google-Smtp-Source: AGHT+IHAyobrpYhrEBcyr/G7yiagryncHdMlgXIut6kTA6vbnwPpNOKPrExpgWDFQU6kYcKY6TYMJKk/J77ccxtsq0w=
X-Received: by 2002:a17:907:701:b0:a99:eb94:3e37 with SMTP id
 a640c23a62f3a-aa483552bc2mr1302741366b.58.1731955409669; Mon, 18 Nov 2024
 10:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com> <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
In-Reply-To: <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 18 Nov 2024 10:43:18 -0800
Message-ID: <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Eric Biggers <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_104332_448287_00137E66 
X-CRM114-Status: GOOD (  50.03  )
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

On Thu, Nov 14, 2024 at 5:17=E2=80=AFPM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> On 11/2/24 12:04, James Bottomley wrote:
> > On Sat, 2024-11-02 at 10:53 -0400, Daniel P. Smith wrote:
> >> Hi Luto,
> >>
> >> My apologies, I missed this response and the active on v11 cause me
> >> to
> >> get an inquiry why I hadn't responded.
> >>
> >> On 9/21/24 18:40, Andy Lutomirski wrote:
> > [...]
> >>> I assumed that "deliberately cap" meant that there was an actual
> >>> feature where you write something to the event log (if applicable)
> >>> and extend the PCR in a special way that *turns that PCR off*.
> >>> That is, it does something such that later-loaded software *can't*
> >>> use that PCR to attest or unseal anything, etc.
> >>>
> >>> But it sounds like you're saying that no such feature exists.  And
> >>> a quick skim of the specs doesn't come up with anything.  And the
> >>> SHA1 banks may well be susceptible to a collision attack.
> >>
> >> Correct, the only entity that can disable PCR banks is the firmware.
> >
> > No, that's not correct.  Any user can use TPM_PCR_Allocate to activate
> > or deactivate individual banks.  The caveat is the change is not
> > implemented until the next TPM reset (which should involve a reboot).
> > BIOS also gets to the TPM before the kernel does, so it can, in theory,
> > check what banks a TPM has and call TPM_PCR_Allocate to change them.
> > In practice, because this requires a reboot, this is usually only done
> > from the BIOS menus not on a direct boot ... so you can be reasonably
> > sure that whatever changes were made will stick.
>
> Okay, since there is a desire for exactness. Any system software can
> send the TPM_PCR_Allocate command, specifying which PCRs should be
> activated on next _TPM_init. There are restrictions such that if
> DRTM_PCR is defined, then at least one bank must have a D-RTM PCR
> allocation. In agreement with my statement, this is the mechanism used
> by firmware to select the banks. Depending on the firmware
> implementation, the firmware request will likely override the request
> sent by the system software.
>
> This brings us back to an earlier point, if one disables the SHA1 banks
> in BIOS menu, then TXT will not use them and thus neither will Secure
> Launch. Secure Launch will only use the algorithms used by the CPU and
> the ACM.
>
> >> When it initializes the TPM, it can disable banks/algorithms. After
> >> that, when an extend operation is done, the TPM is expecting an entry
> >> for all active PCR banks and the TPM itself does the extend hash that
> >> is stored into the PCRs.
> >
> > This, also, is not quite correct: an extend is allowed to specify banks
> > that don't exist (in which case nothing happens and no error is
> > reported) and miss banks that do (in which case no extend is done to
> > that bank).  In the early days of TPM2, some BIOS implementations only
> > extended sha1 for instance, meaning the sha256 banks were all zero when
> > the kernel started.
> >
> > Even today, if you activate a bank the BIOS doesn't know about, it
> > likely won't extend it.  You can see this in VM boots with OVMF and
> > software TPMs having esoteric banks like SM3.

How is this not a security hole you could drive a truck through?
Indeed, looking at the docs, TPM2_PCR_Extend says "If no digest value
is specified for a bank, then the PCR in that bank is not modified."

>
> Let me correct myself here and again be extremely precise. When an
> extend operation is done, the TPM driver expects to receive an array of
> digests that is the same size as the number of allocated/active banks.
> Specifically, it loops from 0 to chip->nr_allocated_banks, filling
> TPML_DIGEST_VALUES with an entry for all the active banks, to include
> SHA1 if it is active. Coming back to my response to Luto, we can either
> populate it with 0 or a well-known value for each extend we send.
> Regardless of what the value is, the TPM will use its implementation of
> SHA1 to calculate the resulting extend value.

At least extending unknown/unsupported banks with 0 modifies the bank,
which gives software that might rely on that bank an indication that
something in the chain doesn't support the bank.  But does actual
TPM-using software in the wild actually look up the event log and
notice that it contains a 0?

This sucks.  How on Earth didn't the TPM2 spec do this instead of
having explicit handling for "a PCR got extended, and the code that
extended it didn't support a given bank, and therefore *the resulting
PCR value cannot be relied on*?  It would have been *one single bit
per PCR, bank* indicating that the PCR's value is incomplete, along
with some basic logic that an incomplete PCR cannot magically become
complete, nor can it be used to authorize anything unless the
authorization policy explicitly allows it?

Anyway, other than the fact that everyone (presumably?) expects
software to be aware of SHA-1 and (mostly) SHA256, and presumably
users of SM3 already expect that a lot of things don't support it,
SHA1 doesn't seem very different from SM3 in the sense that (a) people
might not want to support it and (b) the actual behavior of a boot
chain component that doesn't support a cryptosystem is FUNDAMENTALLY
DANGEROUS.

Is there explicit guidance from TCG as to how this is supposed to work?


In any case, I have a strawman suggestion to resolve this issue much
better from Linux's perspective.  It's a strawman because, while I
attempted to read the relevant part of the specs, the specs and the
ecosystem are a mess, so I could be wrong.

Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
exclusively use TPM2_PCR_Event.  I would expect that passing, say, the
entire kernel image to TPM2_PCR_Event would be a big mistake, so
instead Linux should hash the relevant data with a reasonable
suggestion of hashes (which includes, mandatorily, SHA-384 and *does
not* include SHA-1, and may or may not be configurable at build time
to include things like SM3), concatenate them, and pass that to
TPM2_PCR_Event.  And Linux should make the value that it passed to
TPM2_PCR_Event readily accessible to software using it, and should
also include some straightforward tooling to calculate it from a given
input so that software that wants to figure out what value to expect
in a PCR can easily do so.

And then software that wants to use a SHA-1 bank will work every bit
as well as it would if Linux actually implemented it, but Linux can
happily not implement it, and even users of oddball algorithms that
Linux has never heard of will get secure behavior.

(Why SHA-384?  Because it's mandatory in the TPM Client profile, and
anyone who's happy with SHA-256 should also be willing to accept
SHA-384.)

>
> Even with these clarifications, the conclusion does not change. If the
> firmware enables SHA1, there is nothing that can be done to disable or
> block its usage from the user. Linux Secure Launch sending measurements
> to all the banks that the hardware used to start the DRTM chain does not
> create a vulnerability in and of itself. The user is free to leverage
> the SHA1 bank in any of the TPM's Integrity Collection suite of
> operations, regardless of what Secure Launch sends for the SHA1 hash.
> Whereas, neutering the solution of SHA1 breaks the ability for it to
> support any hardware that has a TPM1.2, of which there are still many in
> use.
>
> V/r,
> Daniel P. Smith
>
>


--=20
Andy Lutomirski
AMA Capital Management, LLC


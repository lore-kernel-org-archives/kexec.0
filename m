Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B071D591AC
	for <kexec@archiver.kernel.org>; Mon, 18 Nov 2024 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iPj/zJyl+iBTZNeNPnPjulGAj1EfNYv6wlquTzB4Fos=; b=2252vZbgQVvFfHj5ExkKqu41KZ
	78+tJURb6uoutxgTg7T0D6M15unn/XJpideY9soL0Z5iFSkigdGd39aB7GaqV59FJrZMxi7x32Y/O
	L9EaPyGtqRTFiq/KO/BHT8N5OGGFYWDoa6cvqVtCnx4Lr87wcCzLJZ1qvNTe47HeZbw8iFWJzIfHw
	GzyPCv55BBmpUWMlZwx8HoKz2g2zGeKAjKSEgelldtwSNT9MEnxexJVm8nnSwTq5vIIcYNk2cnKQj
	g15c3rE9SuMQfFeeM9kUqKBkQ+LX3T8NsiW4HY99RpFiSMeaZ/+Jw4l98QocM3tnrXU19Do78vILu
	Ai57cEaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6pH-0000000AO93-06he;
	Mon, 18 Nov 2024 18:50:19 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6pE-0000000AO8K-27ws
	for kexec@lists.infradead.org;
	Mon, 18 Nov 2024 18:50:17 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a9ed49edd41so21733066b.0
        for <kexec@lists.infradead.org>; Mon, 18 Nov 2024 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1731955815; x=1732560615; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPj/zJyl+iBTZNeNPnPjulGAj1EfNYv6wlquTzB4Fos=;
        b=eBz+KXodZ7G9q6YGawAtACglOsMmjaHKz3KvqxpRtB0Dkr+iQE/PkFFzPM1b17ugag
         i7aJtDZS7dJQh/gXmGJBht1DJbFgJAgofBVwVX4KWbDM0GwBe+Sk8jYlRj/xmWlv0/MG
         EFEf1ahEUtaNbi5qTq5ZUwbSGqzhd8IQvHbnHuSnOzrz5v4SMIXVTV42SVHyWTlVBD3+
         +4mf1wqclYfIxu1/oG6Cxtsu2s3ENfRF7uSoRCBMScw/MZoly1K+XbP7Wveu2OSsedhK
         5ZgOm0p0CxPTZntNV/1CI55WLU11+q6ZMzvm4dXzoxU2oHsAQgroCErJ7ebkr7MZFCyt
         JJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731955815; x=1732560615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPj/zJyl+iBTZNeNPnPjulGAj1EfNYv6wlquTzB4Fos=;
        b=ubB7s8VtOP1sN0IwBL6cysVCLRHIhTiM8bE+ybMglBSNwPlghyqaAcRMvPOYVrEmU7
         BwZOIMFOqdOl0R3e2NByGG1+RekDfue8O4OIe/aE7QhS7nI8w6HIMwgUWVdD4ZcLlb3U
         TUFzPIg+w09eH5lF1Ech1FNtkLwljPdHxyenw/XS+1IzYMbplBs37ko0sxF/luminL1J
         087pbxjEdziAHL4GsfgNgemt7Yb5eJiKr/F8Qalf1qaOqX1Tgew+HLY8Bb5OPTXAamzZ
         Zqp4gjzuiSiyDjxxFVO2WR8KfN8tIN68aF132pqhEmQvMpXUs5KuaqyH82hQBHT3EXmh
         zJMw==
X-Forwarded-Encrypted: i=1; AJvYcCWa4r23hXW9skp+5wBJIT9YP+VwdQ2lG9asy7F/5X4JUvDPiyu1iYNcl5ibVdgwAECOdJkNMg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0efzbHhHZWkrr2XVcmwm/QrCdIT/YHNZo4Qjt1e6g60jW/LOD
	2WLSfNIlw8DyIK2n7CQNXRwnKfZ03ML2FRXbaEXHulVXHM2y9Hgk4+NaZRxPhBzGmTmI4UBlARb
	8yOrxyg6HTrVJgAi4a49p4jiNzQ/RJx5Cz4je
X-Google-Smtp-Source: AGHT+IFfJmdKn/zNImT7l4QO7Fi2ir7TwUttjVFKSek/OFfDMGfS7Gvt2c45q8Ed4/UdpiH0ZuP7Sx4z+gzbVPQA1XA=
X-Received: by 2002:a17:907:7b8c:b0:a9e:d4a9:2c28 with SMTP id
 a640c23a62f3a-aa483552c2bmr1213767666b.53.1731955814987; Mon, 18 Nov 2024
 10:50:14 -0800 (PST)
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
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com> <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
In-Reply-To: <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 18 Nov 2024 10:50:04 -0800
Message-ID: <CALCETrWrdK9-g2VK1h8E34kRNHbfdX0zjUqwZ+xpNqkEmrdLsw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20241118_105016_546112_0C9037D1 
X-CRM114-Status: GOOD (  26.57  )
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

On Mon, Nov 18, 2024 at 10:43=E2=80=AFAM Andy Lutomirski <luto@amacapital.n=
et> wrote:
>

> Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
> exclusively use TPM2_PCR_Event.  I would expect that passing, say, the
> entire kernel image to TPM2_PCR_Event would be a big mistake, so
> instead Linux should hash the relevant data with a reasonable
> suggestion of hashes (which includes, mandatorily, SHA-384 and *does
> not* include SHA-1, and may or may not be configurable at build time
> to include things like SM3), concatenate them, and pass that to
> TPM2_PCR_Event.  And Linux should make the value that it passed to
> TPM2_PCR_Event readily accessible to software using it, and should
> also include some straightforward tooling to calculate it from a given
> input so that software that wants to figure out what value to expect
> in a PCR can easily do so.

Whoops, putting on my "knows a bit about crypto" hat for a second,
this is not great, as the algorithms aren't distinguished, and one
could hypothetically add a wildly insecure hash to the list that
breaks it.  Instead it should be something like:

"SHA-384 48 bytes: [the SHA-384 data], someotherhash 71 bytes: [other
data], ..."

It might even be polite to include some human readable text that also
indicates what got hashed, e.g. "initramfs", so that anyone reading
the event log can see what got hashed.  On that note, maybe making the
whole thing human readable and using base64 would be nice:

"initramfs\nsha384 [base64 data]\nblake3 [base64 data]\nsm3 [base64 data]"

Whatever format is used should be unambiguously parseable.  And who
knows, maybe there's already some kind of industry standard for how
TPM-using software is expected to behave here.


>
> And then software that wants to use a SHA-1 bank will work every bit
> as well as it would if Linux actually implemented it, but Linux can
> happily not implement it, and even users of oddball algorithms that
> Linux has never heard of will get secure behavior.
>
> (Why SHA-384?  Because it's mandatory in the TPM Client profile, and
> anyone who's happy with SHA-256 should also be willing to accept
> SHA-384.)
>
> >
> > Even with these clarifications, the conclusion does not change. If the
> > firmware enables SHA1, there is nothing that can be done to disable or
> > block its usage from the user. Linux Secure Launch sending measurements
> > to all the banks that the hardware used to start the DRTM chain does no=
t
> > create a vulnerability in and of itself. The user is free to leverage
> > the SHA1 bank in any of the TPM's Integrity Collection suite of
> > operations, regardless of what Secure Launch sends for the SHA1 hash.
> > Whereas, neutering the solution of SHA1 breaks the ability for it to
> > support any hardware that has a TPM1.2, of which there are still many i=
n
> > use.
> >
> > V/r,
> > Daniel P. Smith
> >
> >
>
>
> --
> Andy Lutomirski
> AMA Capital Management, LLC



--
Andy Lutomirski
AMA Capital Management, LLC


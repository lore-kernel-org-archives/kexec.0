Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D077DD591B2
	for <kexec@archiver.kernel.org>; Mon, 18 Nov 2024 20:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F56XnCiPK1ucbtbbIcuwS+1n5yBs1+kTrZwft20AGGo=; b=cj1CrdXSJ8mvp4os3o9QmZ0JhI
	zAKM95KeVbXWOji0M+VuNnz2ggi+pfYG+/6/75Fba9f1Bkr/CEGT+waOEeQiW0z4ZZtuqxuigt/dE
	8gWYZemWKthx2aw5tyC7OqnUqsNcBnWpkiCfn1wFx0E743EFk9gRFNpdNkzAiceDcMPVkB/f7hXp3
	RfpGvUXcG6vwduw5TVTGXhPEA2gtpY9y493KUup26DqwIi2ZmDf97VM5/bbJ+czYY7qlke+zX2NUR
	nr39qpeQ/sS+UQ52YHtOKcYgHaoKh4uu3vXdk2AhlyzyAff3GLPlM/w+yBTUSkgrqP4mJPRYcwfqi
	pwghcAeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD7x8-0000000AWur-0kjS;
	Mon, 18 Nov 2024 20:02:30 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD7x4-0000000AWtk-2Mx7
	for kexec@lists.infradead.org;
	Mon, 18 Nov 2024 20:02:28 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a9ec86a67feso33526766b.1
        for <kexec@lists.infradead.org>; Mon, 18 Nov 2024 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1731960144; x=1732564944; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F56XnCiPK1ucbtbbIcuwS+1n5yBs1+kTrZwft20AGGo=;
        b=Q9padEfQmG7Jmj9QJjzChCddR6BsTkGsCkIzqVvL+G11ZiQzHEJ34SUyTv/t9ZFkcx
         t+Du2e7lZ/01H2hPM6Ih0rJKJ1hZtazgjxLNJx6oWpSCEycfhlFXQcahSmwHv1PxtTEC
         lW7J5E4cjHSeyWEipPd9nb8NpgZTaZW0ClvqdFKDUSXES3FjjW8o4w9xDn8L6eMF2r2b
         OEXJPRJx7TVxO7Sm3rgW5R1o9USCdsYA6iKJWQX30phtkGVWMh/t+Ub8kqTqEs1eZ1s7
         MOrphg3cva+tQO1Ssn+SWXKVjfSqq+it1bkc1kp3CD6abJzzHFY8oM9gEw7n4PFd+n0Q
         pRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960144; x=1732564944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F56XnCiPK1ucbtbbIcuwS+1n5yBs1+kTrZwft20AGGo=;
        b=gG6S9Bp1I5tXFwBTJ3VwoLPAUrsipIJ6U/fx905ogZcV37Md0b3ia4UUGBNQVg8otz
         CW6LbIn7CxEkUSeRwb1zNzlCuZrRsTF17LtoHwxE4u3UnT0hFQ1oxh9X3yBJ7aQ0aNTo
         jV+GvM8L69nEpIfYVkgiwawAe3+9ZVPwUjf6Bm6imqEEfmq/tkSRpPBTsju56iDym8Iu
         ddMlHxw2COtl6tdGjM9JPUIuhuHpASFlz20cd+iX2OZulKylspRKU2vzu9ye1FB/Ydq2
         gBzw0T9wLEvEJCSHoklg9sSMh+Cc67tOz6eXtlIJznssgwgyAVWRWGrq8GnjhmGwohlg
         Ezdw==
X-Forwarded-Encrypted: i=1; AJvYcCXuxL6kwE4DWAexR/8zti67ifvi2e+QNTRW2DJxfsAJI1uzZajfhxqJacl3HN8iVf3HJhGiWg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPEOCsS7wiTV1Ld7/Q5jq6u5nVxakdtXebY6WLJjW/PcgvDyZj
	jSQ5IcBdm4xwv9NPA6umZBlcK+foz9H8n5xLZyj/V1YBiIwQUF+30q39jKhxd9sYXpcuPFa5EzR
	y3czcp4HX/+EpDqKY4jNqgPezbZPVr/NYqWs0
X-Google-Smtp-Source: AGHT+IFoQ/M1Rp3ASKc7+vFPOEp+9oiYAQ8ueOL2fLtrqLS19jm7uOri1Atv932nS8Gcqo/IWYlS3CoMIuiDqjl4zlU=
X-Received: by 2002:a17:907:9412:b0:a9e:d7e3:ccae with SMTP id
 a640c23a62f3a-aa483427760mr1375196366b.16.1731960144547; Mon, 18 Nov 2024
 12:02:24 -0800 (PST)
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
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com> <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
In-Reply-To: <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 18 Nov 2024 12:02:13 -0800
Message-ID: <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_120226_811437_0D0ED81B 
X-CRM114-Status: GOOD (  42.40  )
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

On Mon, Nov 18, 2024 at 11:12=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2024-11-18 at 10:43 -0800, Andy Lutomirski wrote:
> > Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
> > exclusively use TPM2_PCR_Event.  I would expect that passing, say,
> > the entire kernel image to TPM2_PCR_Event would be a big mistake, so
> > instead Linux should hash the relevant data with a reasonable
> > suggestion of hashes (which includes, mandatorily, SHA-384 and *does
> > not* include SHA-1, and may or may not be configurable at build time
> > to include things like SM3), concatenate them, and pass that to
> > TPM2_PCR_Event.  And Linux should make the value that it passed to
> > TPM2_PCR_Event readily accessible to software using it, and should
> > also include some straightforward tooling to calculate it from a
> > given input so that software that wants to figure out what value to
> > expect in a PCR can easily do so.
>
> Just for clarity, this is about how the agile log format works.  Each
> event entry in the log contains a list of bank hashes and the extends
> occur in log event order, so replaying a log should get you to exactly
> the head PCR value of each bank.  If a log doesn't understand a format,
> like SM3, then an entry for it doesn't appear in the log and a replay
> says nothing about the PCR value.

I have no idea what the "agile log format" is or what all the formats
in existence are.  I found section 4.2.4 here:

https://trustedcomputinggroup.org/wp-content/uploads/TCG_IWG_CEL_v1_r0p41_p=
ub.pdf

It says:

This field contains the list of the digest values Extended. The Extend
method varies with TPM command, so there is
no uniform meaning of TPM Extend in this instance, and separate
descriptions are unavoidable. If using the
TPM2_PCR_Extend command, this field is the data sent to the TPM (i.e.,
not the resulting value of the PCR after the
TPM2_PCR_Extend command completes). If using the TPM2_PCR_Event
command, this field contains the digest
structure returned by the TPM2_PCR_Event command (that contains the
digest(s) submitted to each PCR bank as
the internal Extend operation). This field SHALL contain the
information from the TPML_DIGEST_VALUES used in
the Extend operation.

So we're logging the values with which we extend the PCRs.  Once upon
a time, someone decided it was okay to skip extending a PCR bank:

https://google.github.io/security-research/pocs/bios/tpm-carte-blanche/writ=
eup.html

and it was not a great idea.

There seem to be six (!) currently defined hashes: SHA1, SHA256,
SHA384, SHA512, SM2 and SM3.  I haven't spotted anything promising not
to add more.  It seems to be that Linux really really ought to:

(a) extend all banks.  Not all banks that the maintainers like, and
not all banks that the maintainers knew about when having this
discussion.  *All* banks.  That means TPM2_PCR_Event().  (Or we refuse
to boot if there's a bank we don't like.)

(b) Make a best effort to notice if something is wrong with the TPM
and/or someone is MITMing us and messing with us.  That means
computing the hash algorithms we actually support and checking whether
TPM2_PCR_Event() returns the right thing.  I'm not seeing a specific
attack that seems likely that this prevents, but it does seem like
decent defense in depth, and if someone chooses to provision a machine
by reading its event log and then subsequently getting an attestation
that a future event log matches what was read, then avoiding letting
an attacker who temporarily controls the TPM connection from
corrupting the results seems wise.  And I don't see anything at all
that we gain by removing a check that (TPM's reported SHA1 =3D=3D what we
calculated) in the name of "not supporting SHA1") other than a few
hundred bytes of object code.  (And yes, SHA1 is much more likely to
be supported than SM3, so it's not absurd to implement SHA1 and not
implement SM3.)

>
> For some events, the hash is actually the hash of the event entry
> itself and for others, the entry is just a hint and the hash is of
> something else.
>
> I think part of the confusion stems from the twofold issues of PCRs: at
> their simplest they were expected to provide the end policy values
> (this turns out to be problematic because there are quite a few ways,
> that will produce different end PCR values, that a system could get to
> the same state).  If you don't trust a bank (or don't know about it),
> you don't code it into a required policy statement and its value
> becomes irrelevant.

I think that "you" refers to multiple entities, and this is a problem.

If the vendor of an attestation-dependent thing trusts SM3 but *Linux*
does not like SM3, then the vendor's software should not become wildly
insecure because Linux does not like SM3.  And, as that 2004 CVE
shows, even two groups that are nominally associated with Microsoft
can disagree on which banks they like, causing a vulnerability.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F066E7717F
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 22:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DFfich0wCzNZpgo4PXY6tmakvrRskVcHsJ5GFyjyu8=; b=qgtRzYtc/aIVIDFLZzuYKsTrMS
	nRTOk0ZCdsHmw74Skh24n8LR2DT0Iedy/PSWlq/UbiVo11Tn2Lqijqrr0wc8FTPKFjOdO9YEDlmvL
	c0KkNLBSgxDFNncsAmUZoM1KuLa7kWLKi16hC7Fz+EPmg9HFtgh244SawZS2Lz22iuK4SwqqF577/
	FKQmuA13fJqqJahXNBQiMp5TQM4oX7nZJHSb+TMwzc/z/BiEwxmGFyf7zkhBoue3YUVif2+xXxpx8
	uGSL+5neQfQ4NRpyunbXSu851TojzX3iDYIyt/JC261zK4sr9pGibIvxxqF8GoojFVeUZoc0hGL4B
	e+CV4EDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLrib-000000026T5-3Fbf;
	Thu, 12 Dec 2024 22:31:37 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLrhd-000000026Ha-0Q1b
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 22:30:38 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso1688716a12.3
        for <kexec@lists.infradead.org>; Thu, 12 Dec 2024 14:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1734042634; x=1734647434; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DFfich0wCzNZpgo4PXY6tmakvrRskVcHsJ5GFyjyu8=;
        b=s8bbTa4aKqoSPBWP4Q2xVOorVJ37CLd1+1nevJm5+w5sSUX3GdN73mg60BFT97e5KX
         DVNmB6AVte+NlAjq+af+Di6oXjuywvjEc0tUNXv4BviGvLO+5qdosUtEpZE5g+OdI7xj
         xN3jrohj6I8RTHbaUpoLIzdpIEhfN8XSM+9wO8RIy2RE505E61z6Z8+l/KuR+YU+hn/f
         XM248RDO5SxQzY19ojvRTujdkJfNHHiJ4UF9hutscS0wI5WRgUUh2bqGiwPTB30XbKLa
         6zpqyHMwz9i6gTq5eG1OVpP1Z3z47su3Ggj56RR5wtyBXRO7S8RehU4PGQLrc0XMsTxy
         wGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042634; x=1734647434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DFfich0wCzNZpgo4PXY6tmakvrRskVcHsJ5GFyjyu8=;
        b=cPoDXTt2xUp3fKqonm4Xu394FKZHWwGhNci3/fPSGoyNP3Gxoc9UJw8cxKk72kLjk7
         C9AWYeES7tVVqoPeIrR826pOE3sf+EeCZPKLUdAhPsxEnERdP8WTUXUppj1ZIHo8+AZb
         27GHs5/N6lxFDRSKIRqo6a0OQkIxNand8JaaX012dkNJVdUV5110+ZE+rqX1yEZrqUwn
         PHloGkbuud7PjuxgRLbpMj5fSDbpCSP8wJU4FxVmlgluu6f5dlcKN/DpAIr52p7HgF5D
         XGRkSKhsON1Z01ag9Ud5E++oSFTeJcGSbrmmAuHzDF5ncXkXCQA3/IK2KH5uKnYZBwsp
         DnhA==
X-Forwarded-Encrypted: i=1; AJvYcCUHVeEOxzqYySoyoLiHDyWlA9DI1/zw9EDSPq4MEtqE3mTjj3yF7v5LlTGIked8SX9D12ka1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmUknI9gyJBt+BfISgmnI0PvVy9Lw1SApIX660O57zH6RPutsv
	i3QYieZZLtbBUvP9+giFwFJXMTuU+qhMcrqTDdof141Hjqy9B4Z8C8/NbWnUCDv3uzG4EnpnWg6
	AKcyREgwDsHJKF6FrbC9KSP85p+PbaDdXaK2P
X-Gm-Gg: ASbGncuDbYPP49uwy2wwXXGmYc2seclHKfShTW1LxQROQU+o0h2ufGBVeFSiNSUXDe7
	a012vxUaDvGTDaUS9JvdWr1W29gCfVe90IB/0
X-Google-Smtp-Source: AGHT+IGl1dmIiaH9NI8b8hOYdpWTfrRri9yyfmHuI52Jogvcc1hUauGAXPes+nuLyRdasCl6AgOKkv55XUwt8CfhqfE=
X-Received: by 2002:a17:906:c14a:b0:aa5:31f5:922a with SMTP id
 a640c23a62f3a-aab7797eb4emr40990566b.19.1734042634250; Thu, 12 Dec 2024
 14:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
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
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
 <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
 <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com> <61a4e812-9514-41a6-a000-e6c026a4ec45@apertussolutions.com>
In-Reply-To: <61a4e812-9514-41a6-a000-e6c026a4ec45@apertussolutions.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 12 Dec 2024 14:30:23 -0800
Message-ID: <CALCETrXQqR6Az7puNXLfhoL37iLHtG1qOyqC_K301TGmMOQvvA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20241212_143037_301828_543D301D 
X-CRM114-Status: GOOD (  64.39  )
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

On Thu, Dec 12, 2024 at 11:56=E2=80=AFAM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> Hey Luto!
>
> Let me try to address your concerns below.
>
> On 11/18/24 15:02, Andy Lutomirski wrote:
> > On Mon, Nov 18, 2024 at 11:12=E2=80=AFAM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> >>
> >> On Mon, 2024-11-18 at 10:43 -0800, Andy Lutomirski wrote:
> >>> Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
> >>> exclusively use TPM2_PCR_Event.  I would expect that passing, say,
> >>> the entire kernel image to TPM2_PCR_Event would be a big mistake, so
> >>> instead Linux should hash the relevant data with a reasonable
> >>> suggestion of hashes (which includes, mandatorily, SHA-384 and *does
> >>> not* include SHA-1, and may or may not be configurable at build time
> >>> to include things like SM3), concatenate them, and pass that to
> >>> TPM2_PCR_Event.  And Linux should make the value that it passed to
> >>> TPM2_PCR_Event readily accessible to software using it, and should
> >>> also include some straightforward tooling to calculate it from a
> >>> given input so that software that wants to figure out what value to
> >>> expect in a PCR can easily do so.
> >>
> >> Just for clarity, this is about how the agile log format works.  Each
> >> event entry in the log contains a list of bank hashes and the extends
> >> occur in log event order, so replaying a log should get you to exactly
> >> the head PCR value of each bank.  If a log doesn't understand a format=
,
> >> like SM3, then an entry for it doesn't appear in the log and a replay
> >> says nothing about the PCR value.
> >
> > I have no idea what the "agile log format" is or what all the formats
> > in existence are.  I found section 4.2.4 here:
> >
> > https://trustedcomputinggroup.org/wp-content/uploads/TCG_IWG_CEL_v1_r0p=
41_pub.pdf
> >
> > It says:
> >
> > This field contains the list of the digest values Extended. The Extend
> > method varies with TPM command, so there is
> > no uniform meaning of TPM Extend in this instance, and separate
> > descriptions are unavoidable. If using the
> > TPM2_PCR_Extend command, this field is the data sent to the TPM (i.e.,
> > not the resulting value of the PCR after the
> > TPM2_PCR_Extend command completes). If using the TPM2_PCR_Event
> > command, this field contains the digest
> > structure returned by the TPM2_PCR_Event command (that contains the
> > digest(s) submitted to each PCR bank as
> > the internal Extend operation). This field SHALL contain the
> > information from the TPML_DIGEST_VALUES used in
> > the Extend operation.
>
>
> Let me start with providing background on the two measurement policies
> that is implemented by Intel TXT (from Intel TXT Developers Guide):
>
>   - Maximum Agility PCR Extend Policy: ACM can support algorithm agile
> commands TPM2_PCR_Event; TPM2_HashSequenceStart; TPM2_HashUpdate;
> TPM2_EventSequenceComplete. When this policy is selected, ACM will use
> the commands above if not all PCR algorithms are covered by embedded set
> of algorithms and will extend all existing PCR banks. Side effect of
> this policy is possible performance loss.
>
> =E2=80=92 Maximum Performance PCR Extend Policy: ACM can support several =
hash
> algorithms via embedded SW. When this policy is selected, ACM will use
> embedded SW to compute hashes and then will use TPM2_PCR_Extend commands
> to extend them into PCRs. If PCRs utilizing hash algorithms not
> supported by SW are discovered, they will be capped with =E2=80=9C1=E2=80=
=9D value. This
> policy, when selected, will ensure maximum possible performance but has
> side effect of possible capping of some of the PCRs.
>

What is responsible for choosing which of these policies to use?

> Allow me to clarify/expand on the last statement in Maximum Agility.
> There is almost certainly a performance loss as anything larger than
> 1024 bytes, for example the Linux kernel, the ACM will bit-banging the
> bytes to the TPM using the TPM2_Hash* functions.

Surely, if Linux's stub started using TPM2_PCR_Event, it would first
hash any large inputs and then send the _hash_ to TPM2_PCR_Event
instead of, say, bit-banging the entire initramfs to the TPM.  But
you're talking about the ACM and I'm talking about the Linux stub code
in this patchset.

But the capping-with-"1" does suggest that maybe one can actually cap
with "1" without preventing downstream software from consuming the
event log.

>
> Before addressing the next point, I would also clarify how the D-CRTM
> measurement taken by the CPU is done. It uses the _TPM_HASH_* functions,
> Section 22.9 of TPM2 Commands specification, to store SHA256(SINIT ACM)
> | EDX into all active PCR banks. For clarity, when this done, EDX holds
> the 4-byte value of the SENTER parameters for which 0 is the only valid
> value currently.
>
>
> > So we're logging the values with which we extend the PCRs.  Once upon
> > a time, someone decided it was okay to skip extending a PCR bank:
> >
> > https://google.github.io/security-research/pocs/bios/tpm-carte-blanche/=
writeup.html
> >
> > and it was not a great idea.
>
>
> Let's begin by why/how that attack occurs. The TPM Carte Blanche attack
> took advantage of the fact that without BootGuard in place, the SRTM
> measurements are done by the software/firmware, to include the
> self-referential S-CRTM measurement. In particular, for the target
> platform, it just so happens that it was possible to construct a
> configuration where not a single hash would be sent to the SHA256 bank.
> This allowed the attacker the ability to replay any set of measurements,
> i.e. carte blanche control, into a completely empty PCR bank for which
> the attestation service would accept quotes. The key to this attack
> requires both, access to an empty PCR bank, and an attestation service
> that will accept a quote with only the exploited bank present.
>
> Let us return to my statements above, which will demonstrate why
> TXT/DRTM completely invalidates the attack. First, as noted above, when
> the CPU is processing the GETSEC[SENTER] instruction, it (the CPU) will
> compute the D-CRTM as SHA256(SINIT ACM) | EDX, sending it to the TPM
> using _TPM_HASH_* functions. The _TPM_HASH_* functions result in all PCR
> banks to be extended with the D-CRTM value. If Maximum Performance PCR
> Extend policy is in use, which is the default policy used by TrenchBoot,
> any algorithm not supported by the ACM is capped by sending the value
> "1" as the digest value for the extend. Therefore, after the TXT
> sequence has completed and before control is given to the Linux kernel
> by the ACM, all PCR banks will consist of either, the D-CRTM + all ACM
> measurements, or the D-CRTM + TPM2_PCR_Extend(0x1). There will be no PCR
> banks with empty DRTM PCRs, thus none of the banks would be usable for a
> TPM Carte Blanche-style attack.

Sure, a "carte blanche" attack in the sense that the PCRs are entirely
blank won't happen, but if any component in the chain does not extend
a bank, then an attacker can replace the code _after_ that component
without being noticed.

> (c) Upon initialization, cap the PCR banks with unsupported algorithms
> using a well-known value.
>
> A problem with (a) is that the result will be an unorthodox event,
> PCR_EXTEND(H(H'(data))). An attestation verifier will have to be aware
> of that this is being done, and have a way to determine which method was
> used for each event. This creates a potentially expensive cost for any
> existing attestation solutions to incorporate support for the unorthodox
> event. At least for DRTM solutions, it seeks to solve a problem that TXT
> does not experience.
>
> For Linux Secure Launch, I would like to propose an alternative to what
> the current logic does in the setup kernel. Specifically, Secure Launch
> will trigger a TXT reset when an unsupported algorithm is encountered.
> Instead, I would like to propose the adoption of (c), and have it
> extends a well-known, fixed value for unsupported algorithms. Secure
> Launch can leverage the fact that the TPM driver's extend function
> already expects to be given digests for all active algorithms.
> Therefore, it will record the well-known value, 0x01 to follow the ACM,
> into the digest buffers of any algorithms that Secure Launch does not
> support. This will result in the well-known value being extended each
> time a measurement is recorded. This will not be a problem as no one
> should be using those banks for attestation and can ignore those digests
> in the event log.

This seems to be at least not terrible.

Or I suppose one could use TPM_HASH_ functions? The spec for them is
somewhat impenetrable to me.

>
> I would like to note that we made a conscious design decision early on
> to use the PCR performance policy approach. We weighed a variety of
> security concerns, hardware availability, and the practicality of
> integrating the capability into our respective efforts. I do not want
> you to feel as though we are not taking your comments seriously. Ross
> reached out to some their contacts, and I reached out to a colleague
> with domain experience as well. From a cursory review, no one saw an
> issue from a crypto standpoint, beyond some algorithm recommendations.
> As we highlighted, they did caution about the resulting unorthodox
> measurement that would impose a burden on attestation solutions.
>
> Hopefully With the background and context presented, you would agree the
> above is a reasonable approach. If you do have concerns, please let us kn=
ow.
>
> V/r,
> Daniel P. Smith



--=20
Andy Lutomirski
AMA Capital Management, LLC


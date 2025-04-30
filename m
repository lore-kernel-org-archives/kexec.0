Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A0C369D9
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ip+1pU0/7y4XrFaMpYVtokEe/oCFDkRUZ+HJT51DN8=; b=12P21wTuv3TwWWkzDXMXEMFham
	mpeQ2MgEkuZl37blHKdc7fOcGdmGLz3YY0Ok2lJGg1ApK6umTpVnHuiuDYD7uB/mloaVy4Sx+lkno
	NvhxrQdqFMVUS6hqiVSnD0x2mdqRWWCZ7I9mcfRi9tLTnu+F6F3UgrXn+KCZyvNp+W4DNMEnykxV8
	ZN76WT/115JdaSRuxabh8u4fHH/5OQKnI8SDtetsYrUqN67CnKK6gtxjrjtx9knIKFuA6G6Tv8BKi
	a7As15z9Z8ac0vilKq8fTOCrbE4J7qAoB5LIOcoVn7+/2tm0Xv7KVFYOJuegkf5D4LD7exMiHifVg
	LSjjAh9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uACXW-0000000DkH3-2zDw;
	Wed, 30 Apr 2025 18:52:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uACXT-0000000DkFV-00ZH
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 18:52:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D16BF4AE86
	for <kexec@lists.infradead.org>; Wed, 30 Apr 2025 18:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE592C4CEF0
	for <kexec@lists.infradead.org>; Wed, 30 Apr 2025 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746039129;
	bh=m/8gh4C7zSRFHSMiGPx6X+dYvNjlflIkT8CNHGNdgfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0XEYzBjXEs7k3H1bpfFbLIC50pge/zBlw5NJpBoyn/DO4UXUgfdKWkLUZcNavgHu
	 29JMw5pGAyK9aW3P90pXWRBLsKGdQOujst3jjSeXF/mxYm7ulHgB6GGONkVpRi97dJ
	 aL22QdPb0Sz/oPGGA6F+CAzRwNseI6mLBkKSan6kXcQM1qLeugR260yZgYkBChgWVk
	 7TG2G0fPC5nqK86ErkRsxwzQDwrfq2uy5Soa8LfMMUT46cR7ZNSaFz1WVFi/rGbW5b
	 uRmdAjhkvsMFHALFQbV1sPgSDMA7fdZ5L4m29CPLXd3HypBgRZ0iSw5aOVHJmiTZg4
	 U/zSfdUGKj7cA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5499c5d9691so231027e87.2
        for <kexec@lists.infradead.org>; Wed, 30 Apr 2025 11:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVj9FUKClzuAOsuVKNZd1nYhANs+X0KAGwhX4Q6+RyznuSKhN3WkGaZYS2phh7Bz6r9oxw8QA==@lists.infradead.org
X-Gm-Message-State: AOJu0YySaRD29YlEgnTudLEZunrJfFHRYklJ7nmrCS0BVQT55haqxf/S
	zfzKlkUtvPOcS2uSlvYX9RCz26mg6t1qhw95cUreZshOP1XonZ46n6iTd5Q8aiAJjUhISOVaIce
	t97bYV9NuYaSo2wNt/fqtYz7xwn8Bhryv+qi+
X-Google-Smtp-Source: AGHT+IE0K5POXjSzi6PVmVrzzNUz5C/TwrdOq3L9wFNvUlNtX4GskbINsst/0+rP2duvkTLtKdKGSet0iv4McAObDYU=
X-Received: by 2002:a05:6512:33cf:b0:545:c7d:1784 with SMTP id
 2adb3069b0e04-54ea72919cemr26556e87.43.1746039126238; Wed, 30 Apr 2025
 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-19-ross.philipson@oracle.com> <CALCETrVayuzp7fstavHkx99eieUCNj3=Zt8D=WOqMnmeT6DKmQ@mail.gmail.com>
 <077163e1-b7e1-4bc9-8294-e557cc7bd78d@apertussolutions.com>
In-Reply-To: <077163e1-b7e1-4bc9-8294-e557cc7bd78d@apertussolutions.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 30 Apr 2025 11:51:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVfrP=RL0W1cOY1PXGAsVLgbgSVLCy+ZsDg=-rxMQ=u9w@mail.gmail.com>
X-Gm-Features: ATxdqUFyoGR-AY1tkFj9SH8YcCxlyGufKMkkioxYlBMgz0llRYwovkkXKsIy3U0
Message-ID: <CALCETrVfrP=RL0W1cOY1PXGAsVLgbgSVLCy+ZsDg=-rxMQ=u9w@mail.gmail.com>
Subject: Re: [PATCH v14 18/19] x86: Secure Launch late initcall platform module
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_115211_150445_E9D63A8B 
X-CRM114-Status: GOOD (  50.83  )
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

On Tue, Apr 29, 2025 at 6:41=E2=80=AFPM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> On 4/28/25 13:38, Andy Lutomirski wrote:
> >> On Apr 21, 2025, at 9:36=E2=80=AFAM, Ross Philipson <ross.philipson@or=
acle.com> wrote:
> >>
> >> =EF=BB=BFFrom: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> >>
> >> The Secure Launch platform module is a late init module. During the
> >> init call, the TPM event log is read and measurements taken in the
> >> early boot stub code are located. These measurements are extended
> >> into the TPM PCRs using the mainline TPM kernel driver.
> >
> > I read through some of the TPM and TXT docs, and I haven=E2=80=99t foun=
d a
> > clear explanation of exactly what gets hashed into which PCR.  (Mostly
> > because the docs are full of TXT-specific terms.)
>
>
> For Intel TXT, the general approach is detailed in section 1.10.2 of the
> TXT Software Development Guide[1]. I point you at the Detail and
> Authorities Usage section because the ability to do Legacy Usage has
> been unavailable for some time.
>
> In section 1.10.2.1, the dialogue explains how and what the initial
> measurement is into PCR17. After that is Table 1, which provides a
> listing of all the measurements the ACM could make before starting the
> MLE. Just as an FYI, on Gen 9 and later, the STM measurement will be
> present and will be the hash of the PPAM module.[2]
>
> Section 1.10.2.2 gives a similar treatment to PCR18.
>
> [1]
> https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel=
-txt-software-development-guide.pdf
> [2]
> https://www.intel.com/content/dam/www/central-libraries/us/en/documents/d=
rtm-based-computing-whitepaper.pdf
>
>
> > But I=E2=80=99m really struggling to understand how the security model =
ends up
> > being consistent with this late_initcall thing. We measure some state
> > into the event log, and then we do a whole bunch of things (everything
> > from the very beginning of loading the kernel proper to the whenever
> > in the late_initcall stage this code runs), and then we actually
> > extend the PCRs.  It seems to me that this may involve a whole lot of
> > crossing fingers that an attacker can=E2=80=99t find a way to get the k=
ernel
> > to execute code that changes the event log in memory prior to
> > extending PCRs such that attacker-controlled values get written.  Even
> > if the design is, in principle, sound, the attack surface seems much,
> > much larger than it deserves to be.

I hate to be obnoxious, but your email kind of exemplifies why I, and
I think many developers, REALLY dislike the TXT and related specs.
It's full of magic words that mean nothing to anyone not immersed in
this particular ecosystem.

>
>
> There is a more fundemental flaw to your scenario, but before covering
> that, consider what measurements could be tampered with that are made by
> the setup kernel:

What is the "setup kernel"?  Do you mean the early code in the kernel?

>
>   - Kernel Setup Data
>   - TrenchBoot's SLRT
>   - Boot Params
>   - Command line
>   - EFI Memory Map
>   - EFI configuration items, populated by efi-stub (currently unused)
>   - External Ramdisk

Are you saying that all of these items are measured by the early
loader (and *not* measured by the ACM or otherwise by anything that is
trustworthy and runs before the early code)?

>
> Outside of the case of an external ramdisk, the attacker can only
> pretend valid configuration data was passed to it.
>
> Correct me if I am wrong, but I don't think that is what is bothering
> you. You are either concerned with one of two cases here. Either you are
> concerned that the attacker may be able to hide the loading of a corrupt
> kernel or that the attacker can corrupt the kernel after loading.

Here is my concern:

Suppose there is a set of measurements that an attacker wants to
replicate.  Some of these measurements are done prior to transferring
control to the early code that's in this patchset (call these
before-Linux measurements) and some are done by the loaded kernel
(let's call these Linux measurements).

I am concerned that the attacker will load a combination of things
that have the correct before-Linux measurements but the wrong
after-Linux measurements.  (Wrong in the sense that, *if those
measurements actually landed in the PCRs, then the attacker would
lose*.)  *But* the attacker carefully chooses what they're loading to
gain control of the system prior to the actual PCR extension.  Then
the attacker extends the PCR with the hash that they want to
replicate, and the attacker wins.

For the security model to make any sense at all, then it needs to be
impossible for the attacker to gain control prior to the early kernel
code running without changing the before-Linux measurements.  But
there is a huge gap between when the early Linux code runs and when
the late initcalls run, and the attacker has that entire window to
break your security.

> first case, the answer is no; the attacker cannot. The kernel and the
> initrd if it was packed in the kernel are measured and sent to the TPM
> by the ACM running in cache-as-ram before execution begins.
>
> The second case is the flawed scenario, a strawman, if you will. This is
> a runtime-integrity problem that is outside the scope/protections of
> load-time-integrity solutions such as SRTM and DRTM. If the correct
> kernel was loaded and measured, but an attacker already has a position
> in the system that they can corrupt the kernel before the user-space
> init process can be run, then they already won.

I'm arguing that it seems like that this patchset has a
runtime-integrity problem.  It's outside the scope of the TXT spec per
se.  It's in the scope of *the Linux kernel*, and anyone who wants to
trust that the Linux DRTM code actually works needs to factor in this
giant weakness.

And you haven't explained why there is no way for an attacker to
corrupt the process between the early kernel code and the late
measurement code.


> > Is there some reason for all this complexity instead of extending the
> > PCRs at the early stage when the measurements are taken?
>
>
> We did have TPM logic in the setup kernel at one point. Within their
> rights, the TPM maintainers took the position that the only TPM
> interface logic should be the existing driver.

Hey TPM maintainers, I think this is nonsense, or maybe someone has
misinterpreted something that someone else said.  I understand that
avoiding code duplication is nice.  I understand that, at runtime, all
TPM access ought to go through the driver.  But, if the driver is
incapable of working during the very very early kernel load, then
there should be an alternate interface.  Kind of like how we have
early_printk instead of saying "well, there should only be one printk,
so instead of having early_printk, we'll just have a big buffer of
messages and log them eventually".  Or kind of like how we might call
EFI boot service functions during early boot.

--Andy


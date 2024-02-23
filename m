Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AC0C5478C
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xFCT3xMI7+rPW/YE3D+fR2X423mIxdm3KPTDJJdQrKA=; b=Tp34QZ5gw4qRTo
	rNXR3YSVRqwefMdzuOudrJcuT8+AZxtPAXCFHfEqe6ghn8Dsy5uegt+PIDTYLhcMaYPxPMl7a5IS4
	Elj6JQtB48gvRXFKOamXpionSTsSO5kxuwRZugm61O5wc6qzDxszPAcuigevmgKNZFed4z45C/m6P
	vLDnyjoiQKOz7pc2pvcOkpQkOOrdWg8gqExOxvFRPFgEr4qtwLS9T3dL4B06qV9/HvgShNHMN16uX
	oGvGTidu91g/EgflYeIyxZlvBp0qAWyT5n9fKtPAYEn+EcZ874CGZbnnbrbtLkqjSaYZ/xRgrS7Pj
	m4lcG0ru4Yhqr1Ft96Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdS02-00000008hg4-15WD;
	Fri, 23 Feb 2024 09:37:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdRzO-00000008hYc-2OaL
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 09:37:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 49BE863441
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 09:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F74C43394
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708681021;
	bh=WmJ0OMw0PMDqgKg1zGlDpZIg7VOeRdS3myN/hyG1fUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lTO9NyHW+QOcMkPuRJcotERPkR/T2h9Kq86+n167xu60btQS459z0+tDwQV9XtMkF
	 CCzImEA3iAnuVeKfshq3AGjapuUcNQ2z+0C3diuj1m7yJl6nabO3pjg5uK8hE2R/4I
	 nU/fJ+g+YZnImI/WG2V1kvg/CNU1ux5b7YpQKc0k+M09ttWcGpefZhfZtYlfr/Vsiz
	 zG006FszQVM54ch5S67QwNbU22wRqoal5Way327q1cACUXVIVY8J+rWHhRVDi78YzE
	 /LR62mm8Zc8HPECYu4ZYElfIj9f9T7E49tbsdxG++WabH4jk93AVVcCMa2QiiQtUCJ
	 jq0wikgl2s6mg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d27184197cso1639201fa.1
        for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 01:37:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV30m822r/7zytZlGxInYipuk+0mbCPGut/zkN/btpbllEujJVJxWS6k8Ptb3ZZjzI3Vngpm02SsvfVnNtQV8EgBmMl6Db+wVSF
X-Gm-Message-State: AOJu0YwIWF8iatoTS8i4XBNI4HAn0AM6AZ6P2E+qCoTgN428bTqIFYQq
	joILL63GJXI9FKXK3pwr7us6Nkl5e9g9pQIhakIiYr+29G12oawOhceR819Cag3u4nMYEF/TqTl
	U1cP0zqPOGTrZqOCSC20odn6JL5A=
X-Google-Smtp-Source: AGHT+IG8RzI+KlFZjtnX9Ar8ORCwXhB3wnST2X3XRz5ROmCtiTukZgWnN7bJJrkNqPIDPlBotgqwm3wzCz7lultVJL8=
X-Received: by 2002:a2e:a30f:0:b0:2d2:40d7:9a55 with SMTP id
 l15-20020a2ea30f000000b002d240d79a55mr940682lje.4.1708681019139; Fri, 23 Feb
 2024 01:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-15-ross.philipson@oracle.com> <CAMj1kXHXt6z94JCM2C5rLz-n9nGA46bb1eMbqcP5e7K9+NzPSg@mail.gmail.com>
 <c5bd3ee4-4bf1-4e9a-8e5d-12ee8e195d3d@apertussolutions.com>
In-Reply-To: <c5bd3ee4-4bf1-4e9a-8e5d-12ee8e195d3d@apertussolutions.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 23 Feb 2024 10:36:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEUdj+==Ud_YWP2FP05St3KDsduzUMsOZzu9LRsLVsLVA@mail.gmail.com>
Message-ID: <CAMj1kXEUdj+==Ud_YWP2FP05St3KDsduzUMsOZzu9LRsLVsLVA@mail.gmail.com>
Subject: Re: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_013724_678515_206B5BAC 
X-CRM114-Status: GOOD (  36.20  )
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

On Thu, 22 Feb 2024 at 14:58, Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> On 2/15/24 03:40, Ard Biesheuvel wrote:
> > On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
> >>
> >> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> >>
> >> The Secure Launch platform module is a late init module. During the
> >> init call, the TPM event log is read and measurements taken in the
> >> early boot stub code are located. These measurements are extended
> >> into the TPM PCRs using the mainline TPM kernel driver.
> >>
> >> The platform module also registers the securityfs nodes to allow
> >> access to TXT register fields on Intel along with the fetching of
> >> and writing events to the late launch TPM log.
> >>
> >> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> >> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >
> > There is an awful amount of code that executes between the point where
> > the measurements are taken and the point where they are loaded into
> > the PCRs. All of this code could subvert the boot flow and hide this
> > fact, by replacing the actual taken measurement values with the known
> > 'blessed' ones that will unseal the keys and/or phone home to do a
> > successful remote attestation.
>
> To set context, in general the motivation to employ an RTM, Static or
> Dynamic, integrity solution is to enable external platform validation,
> aka attestation. These trust chains are constructed from the principle
> of measure and execute that rely on the presence of a RoT for Storage
> (RTS) and a RoT for Reporting (RTR). Under the TCG architecture adopted
> by x86 vendors and now recently by Arm, those roles are fulfilled by the
> TPM. With this context, lets layout the assumptive trusts being made here,
>    1. The CPU GETSEC instruction functions correctly
>    2. The IOMMU, and by extension the PMRs, functions correctly
>    2. The ACM authentication process functions correctly
>    3. The ACM functions correctly
>    4. The TPM interactions function correctly
>    5. The TPM functions correctly
>
> With this basis, let's explore your assertion here. The assertion breaks
> down into two scenarios. The first is that the at-rest kernel binary is
> corrupt, unintentionally (bug) or maliciously, either of which does not
> matter for the situation. For the sake of simplicity, corruption of the
> Linux kernel during loading or before the DRTM Event is considered an
> equivalent to corruption of the kernel at-rest. The second is that the
> kernel binary was corrupted in memory at some point after the DRTM event
> occurs.
>
> For both scenarios, the ACM will correctly configure the IOMMU PMRs to
> ensure the kernel can no longer be tampered with in memory. After which,
> the ACM will then accurately measure the kernel (bzImage) and safely
> store the measurement in the TPM.
>
> In the first scenario, the TPM will accurately report the kernel
> measurement in the attestation. The attestation authority will be able
> to detect if an invalid kernel was started and can take whatever
> remediation actions it may employ.
>
> In the second scenario, any attempt to corrupt the binary after the ACM
> has configured the IOMMU PMR will fail.
>
>

This protects the memory image from external masters after the
measurement has been taken.

So any external influences in the time window between taking the
measurements and loading them into the PCRs are out of scope here, I
guess?

Maybe it would help (or if I missed it - apologies) to include a
threat model here. I suppose physical tampering is out of scope?

> > At the very least, this should be documented somewhere. And if at all
> > possible, it should also be documented why this is ok, and to what
> > extent it limits the provided guarantees compared to a true D-RTM boot
> > where the early boot code measures straight into the TPMs before
> > proceeding.
>
> I can add a rendition of the above into the existing section of the
> documentation patch that already discusses separation of the measurement
> from the TPM recording code. As to the limits it incurs on the DRTM
> integrity, as explained above, I submit there are none.
>

Thanks for the elaborate explananation. And yes, please document this
with the changes.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

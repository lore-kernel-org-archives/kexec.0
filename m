Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF52FE677EC
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pyJuOWiKJJC3dF6n7hi3rOY7UsrEHl6K8s2I8fsfnHo=; b=j7R0Gc+5MU2TCa
	Whoepyse2SR9aRUxsXZz0n7INsB5cZ7NnlnYe1xLEr98YRUas8aqICRvcq3WxJhSl6/CkrHSrhsBI
	1BYP0hZ7ODMI2wmFWtYcyCTykdSFdw1pTbu5cu/wbi3cxyvXHipZwCynm4mokyOISGR2wsD0hGXw2
	omdfAxyCFVFqbdc3RAuymwF7mt/3iiBoL9l51bFhjUIyinds0YjxgbNxKuOyX+9Og1CCBLLh6Ctxm
	X6a2saKCUA+X00QVne2nVCMCKKHcwrHcby5lVHiORCb6+Jv+/00+DmGyK5NSzLLotUusACckRzWFg
	pQM1ngcc8VFq8UijUevg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7A27-00000009LaT-1NFd;
	Sat, 02 Nov 2024 09:02:59 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7A23-00000009LZ8-2DwH
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 09:02:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C7A2DA4029D
	for <kexec@lists.infradead.org>; Sat,  2 Nov 2024 09:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B419C4CEE0
	for <kexec@lists.infradead.org>; Sat,  2 Nov 2024 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730538173;
	bh=LBoNUIt26/rOHWnEOHVZz/A27Sk+n0iu8cOSeH8LX0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T92cCCswFZ6WUioUkTmAiZjzCFTDeI+a3/42QMv5GjnyNBbMyng9Px/d+iIX2InM9
	 3AZnttj3GzjwZ2lzOP/h3brXdgoQoGYzuA7WYBmAkbWiBU2dNjo+ZW4zQTGS7LUM1k
	 dbtmjb2bFrO/MAiO73+Bz6l3Ktq6bELYuCzxuV4NHaB+G9uYkwiiMwZfz8JwnG0i1J
	 n1+n5fO85Fg+fLTfst0zqL81ZEL9oe181eo59eLEmvaQkTlEzOAaKxuZUCFbWABq3Z
	 hPDmi4z6gt370GEiK8h4bl9GY/CLtSPP2i/8/XUdz0mRl4d4nIKN4N2gugIjuys4Er
	 8ZnA3qUSEqY+A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e690479cso2824893e87.3
        for <kexec@lists.infradead.org>; Sat, 02 Nov 2024 02:02:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEFPFxO/M8Rj4/pzi10I7utsKgs4S2P1VW9R8Wgofueq0/1+5fa3A+Mb+o83mzeilqM46/6g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCswU4ktqb8D8frkL3RnX5N1KAoP8QHxjaUO/QMods3KrO9QwE
	z0x6shBFHbGFT6M+/i3ieDU7DdgGO7ygo9BA8M5OaSzNuvmZM2A1QP/slCiF6ABvkOk5KsiPcun
	JjQmFc5cZNo9imtB8VetBl0iks78=
X-Google-Smtp-Source: AGHT+IH5OhSbyxPUwoV8Hi3NZvUJk62Sk/kM4uS3eDew9nHH5ECqnhoFDJijntPKiKzAeGwvpQ6+AOtWhMBUTM8YWgU=
X-Received: by 2002:a19:e043:0:b0:539:94aa:d512 with SMTP id
 2adb3069b0e04-53d65e1771emr2299160e87.53.1730538171706; Sat, 02 Nov 2024
 02:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org> <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
In-Reply-To: <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Nov 2024 10:02:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
Message-ID: <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James.Bottomley@hansenpartnership.com, andrew.cooper3@citrix.com, 
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dpsmith@apertussolutions.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, herbert@gondor.apana.org.au, hpa@zytor.com, 
	iommu@lists.linux-foundation.org, kanth.ghatraju@oracle.com, 
	kexec@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@amacapital.net, mingo@redhat.com, mjg59@srcf.ucam.org, 
	nivedita@alum.mit.edu, ross.philipson@oracle.com, tglx@linutronix.de, 
	trenchboot-devel@googlegroups.com, x86@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_020255_720738_7B19DEBD 
X-CRM114-Status: GOOD (  26.49  )
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

On Sat, 2 Nov 2024 at 07:29, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat Nov 2, 2024 at 8:22 AM EET, Jarkko Sakkinen wrote:
> > DRTM needs to be able to set the locality used by kernel. Provide
> > TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
> > the kernel command-line has 'tpm.set_locality_enabled=1'. The operation
> > is one-shot allowed only for tpm_tis for the moment.
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > - Do not ignore the return value of tpm_ioc_set_locality().
> > - if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED))
> > - Refined kernel-parameters.txt description.
> > - Use __u8 instead of u8 in the uapi.
> > - Tested with https://codeberg.org/jarkko/tpm-set-locality-test/src/branch/main/src/main.rs
>
> This version has been also tested (and encountered bugs fixed). I wrote
> a small test program to verify that it works linked above.
>
> After the boot, the new ioctl can reset exactly once the locality. Other
> benefit is that the feature can be selected per driver (at this point
> tpm_tis drivers) and protection of the access with DAC, SELinux etc.
>
> And thanks to the kernel command-line parameter, it is an opt-in
> feature like it should because vast majority of users will probably
> never use trenchboot. I.e. set 'tpm.set_locality_enable=1' to have
> the ioctl available.
>
> I think this is a solution that at least I could live with. It has
> somewhat rigid commmon-sense constraints.
>

Before adding a kernel command line parameter, please ask yourself who
is going to set it and where, and whether there is any risk of abuse.
The kernel command line is external input that is not signed, and the
only known user of this set_locality feature is internal to the
kernel.

Same for the ioctl() [as well as the read-write sysfs node]: looking
at the code (patch 19/20) it doesn't seem like user space needs to be
able to modify this at all, at least not for the patch set as
presented. So for now, can we just stick with making the sysfs node
read-only?

The only thing I would recommend is exporting the set_locality()
symbol in a module namespace, so that it is obvious that it is not
intended for general use by other modules (although not impossible).
E.g., CRYPTO_INTERNAL does something similar, and if
MODULE_IMPORT_NS(CRYPTO_INTERNAL) appears in new code, reviewers are
alerted that it accesses internal APIs rather than ones intended for
other subsystems to use.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEBFC83F15
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gt82NL5b5gLGIcFCdvu5qbl51ngTsuL5uw5l4KNPoTc=; b=HoAfPGVbZqHR9v
	E+VXRbR9F3NU7t9Pbcd2ORGx8GjDeKV98wea/3eqcGOG/KsGMla/sXpuzjHgzkoagp7FfTgXz1AbP
	M1n/WIR5t3BCl788U2ahPtwnQV6DWeEpsFO7kwXZQ+Lv2P3hXRrrcHPOIW7L+szvP85InthWO3cH0
	BX/fLLsa/qzHLZ2Wly433/wWL6zBFKZ67oLaMQmjyXTNh0CVC64EtzKqSXbDmkNOV6/z+xC8dNEPL
	JLpMRyLUpT3U73EXdGaFeO7EjXpH78CSJEG3WNRscgwBH8aY4d3vIch/rTvsojzZDhQgCaBD6d1jt
	Dxlz7Njox0nqrkrkMaBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfDo-00000002BNi-2WPs;
	Thu, 29 Aug 2024 13:29:56 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfCw-00000002B7b-4C8a
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 13:29:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A0EA4A4403A
	for <kexec@lists.infradead.org>; Thu, 29 Aug 2024 13:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B616C4CEC9
	for <kexec@lists.infradead.org>; Thu, 29 Aug 2024 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938141;
	bh=/JM47t330311w1URWNgJKWeR3KsLsi57yIqe7LWcBDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GWUmH+VDn7PGqf7OCkWt61y26BuOc3jvCOyW80wPk0Ea2oPNCiKqWh1ZzJXv2Ycpm
	 d1z9q70phGGVVwWFmlVTPx43K+W1FXEuXO08ofStOQh8+8e5gwvR+o8WHBPEHD1Nmq
	 9b1Krr82ZBHWHYH115jZ3ZYVifjgZmjZvstLzZIzQigeybQLkBs3s+WuWK6DN2MRfV
	 TqvT7Cxc9LzX4rpzAGWe8DIH6JIyG4v26B4oEirVDm1dDj6NU4A67skJ8Pa8yX45X1
	 NFfhPhhzPr7eY/1oHrx3CjjtLwSz2EZfRhsxrrbO37iHQ5ARxzE79CGDoAv/4dboNm
	 e8coKFIvcg1+Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so819143e87.3
        for <kexec@lists.infradead.org>; Thu, 29 Aug 2024 06:29:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUue2M741bGbxhOSBi2JHAGdmdjgoXniJkbZGYmrJPD8o7hRwz2t5iT1MMWfG5n6kPswCWHUA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxrhYFjPznxvYyJttUQ2yP6uts64Qz6aFhH94AdyRPPnin4RyVW
	SspmX/TOS5cO1NHRahaYhdEtB6K6YMxBA3UQRrrnlCqb60mX2T422E4X6wAErvLljio1uSn0pKU
	NIwA4+f5p0dpfCqliIBT0pzP/eo0=
X-Google-Smtp-Source: AGHT+IG7brDpiVxJl+LLeO4JEGrNvWC9+/qw29ZvVDhohPvAunRSDVjoDP7LpczQ2+SS7Lyf3hGLblkJdiXuBsb3zXM=
X-Received: by 2002:a05:6512:340c:b0:52e:9382:a36 with SMTP id
 2adb3069b0e04-5353e57cb27mr1967760e87.30.1724938139518; Thu, 29 Aug 2024
 06:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
 <202408290030.FEbUhHbr-lkp@intel.com> <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
 <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com> <ZtB2bP1Mx3zTr9e5@earth.li>
In-Reply-To: <ZtB2bP1Mx3zTr9e5@earth.li>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 29 Aug 2024 15:28:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHvTjC1ALgHnu-_Tad4Ur9RqJR_d9h8bQDvXcx2p5H2AA@mail.gmail.com>
Message-ID: <CAMj1kXHvTjC1ALgHnu-_Tad4Ur9RqJR_d9h8bQDvXcx2p5H2AA@mail.gmail.com>
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Jonathan McDowell <noodles@earth.li>
Cc: ross.philipson@oracle.com, kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	oe-kbuild-all@lists.linux.dev, dpsmith@apertussolutions.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_062903_190671_E60702A1 
X-CRM114-Status: GOOD (  21.73  )
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

On Thu, 29 Aug 2024 at 15:24, Jonathan McDowell <noodles@earth.li> wrote:
>
> On Wed, Aug 28, 2024 at 01:19:16PM -0700, ross.philipson@oracle.com wrote:
> > On 8/28/24 10:14 AM, Ard Biesheuvel wrote:
> > > On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote:
> > > >
> > > > Hi Ross,
> > > >
> > > > kernel test robot noticed the following build warnings:
> > > >
> > > > [auto build test WARNING on tip/x86/core]
> > > > [also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
> > > > [cannot apply to herbert-crypto-2.6/master next-20240828]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > > And when submitting patch, we suggest to use '--base' as documented in
> > > > https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_base_tree_information__;Iw!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIxuz-LAC$ ]
> > > >
> > > > url:    https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI7Z6SQKy$
> > > > base:   tip/x86/core
> > > > patch link:    https://urldefense.com/v3/__https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson*40oracle.com__;JQ!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIzWfs1XZ$
> > > > patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
> > > > config: i386-randconfig-062-20240828 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIwkYG0TY$ )
> > >
> > >
> > > This is a i386 32-bit build, which makes no sense: this stuff should
> > > just declare 'depends on 64BIT'
> >
> > Our config entry already has 'depends on X86_64' which in turn depends on
> > 64BIT. I would think that would be enough. Do you think it needs an explicit
> > 'depends on 64BIT' in our entry as well?
>
> The error is in x86-stub.c, which is pre-existing and compiled for 32
> bit as well, so you need more than a "depends" here.
>

Ugh, that means this is my fault - apologies. Replacing the #ifdef
with IS_ENABLED() makes the code visible to the 32-bit compiler, even
though the code is disregarded.

I'd still prefer IS_ENABLED(), but this would require the code in
question to live in a separate compilation unit (which depends on
CONFIG_SECURE_LAUNCH). If that is too fiddly, feel free to bring back
the #ifdef CONFIG_SECURE_LAUNCH here (and retain my R-b)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

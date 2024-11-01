Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC85E6F061
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3QcpP6a1UKpZG3Myh2TZfD8XF3BTD4+bF6aOeJjKFPc=; b=cU9bX0/6t7s9A4
	NcpsJUOZ+OwYjL632RDmIGBBPbm4g3MvBoZ/uUlfHo1M4fp0JGvHNDEUDes9rAnZUkG9BhI1+lXTL
	JHsJ8MxEbsKuskbkRZh2zUOkaGt732mwtZ2nSgLd60pwiNrEckBPazg3EndC4rwSMikmB6i6HrAaW
	eA5DqGP5Cp7bVL+FthZKVt+pYTYJLcLHMwKEJWTit6yYjtOeHNouOM9KnESTgD3Lavk+2Mt6kAi47
	1R2J/Rsyh5jx3T0/8pq7iX/21gBQSomGe67lrVF3C244djoPgYOHkxI5sgZZU3CYwwlee3BtmcWwp
	rkNVxeVsQ36KwVntx2sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sTH-00000007Iku-1Hfv;
	Fri, 01 Nov 2024 14:17:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s7V-00000007FSG-1uNR
	for kexec@bombadil.infradead.org;
	Fri, 01 Nov 2024 13:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:References:To:From:Subject
	:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BaaKDaUoDiP/deVBSSRSEh9rOpuImVeMWlz7zXkMGBQ=; b=BA1FRuDmXJ/Atil+bPpUS4Q5cV
	CpcyRaVGxMoxlKSqVTEJlQ4bPGzmOOclDpvDMB8rWgI38pYMC2JVjUbdkTMGpEoaxBjeFWVpTc0Ly
	S0rLagnD2qDupgG2Z9gDaKQtJXcJ8hTJ0+xOa2fPlw6/Kt6KuQixZjrTWQCVReya8HKDcB9VE5bN0
	MgCvMBLCHpazMZ7SSnRluxEiDRMYzCNmWJkinsmhnBnVkrvTBY0JOzoD8bomCR3U1Ce1Q4Z0CmZmu
	/8W7VKp9F7+UHsbBbgA20xuz4Wawe6hcjLTgjhqkugSBaP2kguugBFIiPXwKEqXKy75yAjneQeojD
	1fnQDNVg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s7Q-0000000AiJd-3GYx
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 13:55:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 529875CCAA9;
	Fri,  1 Nov 2024 10:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FEBC4CECD;
	Fri,  1 Nov 2024 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730456922;
	bh=mSFWh3r0scHZ1FR2DYIx0Tc2V6UZfNOyeDKa23YOOmQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Dp17+hLhUwjK7Vwhq5YmGk2Rk/Vmsz7lB3wJrvj8hnCTYk50wdScvildLCtA4iBAO
	 6eA4s5JD6uE23Qn4gAlSnK9KxBlBRbni3VS+RIg95V3ZR/azVJqcizrcu6XMMtwJAS
	 Mvjp40ENNcaw476FxBKgo0TQsqFR++HZ6ibnCwrrM//1IzgoZzHcNk39p6ZsvxZJ7S
	 /6ePK9AoJdXCSJrtoWkjNiKAf21Y79MeAo+g1X290rINW5gItxttGySRNYb2V1w5wM
	 LSIpd6L/3kNBbY9n6PC3N3wVb1ZkATqlA0IZVVOaZZ7pzVAgK9/bqmoMGP2MRUsCT1
	 ME7TUSxuYp0XA==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 12:28:38 +0200
Message-Id: <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_135517_133260_9577C997 
X-CRM114-Status: GOOD (  22.03  )
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

On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement). The project has been and continues to work on providing
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> Technology (TXT) is present today and only requires a preamble loader, e.g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as the
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development stage
> and the project is looking to support it when it becomes available.
>
> This patchset provides detailed documentation of DRTM, the approach used for
> adding the capbility, and relevant API/ABI documentation. In addition to the
> documentation the patch set introduces Intel TXT support as the first platform
> for Linux Secure Launch.
>
> A quick note on terminology. The larger open source project itself is called
> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
> the use of Dynamic Launch technology is referred to as "Secure Launch" within
> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
> in the code. The stub code discussed above is referred to as the SL stub.

1. I don't see any tags in most of the patches so don't get the rush. This
   includes also patches for x86. Why I would care to review TPM patches
   when there is over a dozen unreviewed and untested patches before it?
2. TPM patches have been in circulation in and out of the patch set
   for some time now with little or no improvement.

Why the sudden buzz? I have not heard much about this since last early
summer.  Have to spend some time recalling what this is about anyway. I
cannot trust that my tags make any sense before more reviewed/tested-by
tags before the TPM patches.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

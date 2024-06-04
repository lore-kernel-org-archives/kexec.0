Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78DAC25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 19:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4UWFNHkuWCBS2Njgt205J4wX/70KIrnzHKJ/f/hH1pA=; b=4puU7x5VdqlY4B
	KuJsthOITpdJgojvw6kGxenaaKzGjwPq86iiFLf4XNdt/57aw3zuq72yV4fGC3IGCL7VnZ85odfSD
	p+hNEQapv6nLuID+YT5IYBr1MH8xK6wrwPPm66VOggSGKlqj8EKCnWqC/A2u3ioJtKTmoSYu6SISx
	9Bu3S5cn9Q6TLJ6LXQpddqjz/OKD9eadIL2LgoMv7fsal6zxAAeKwfHZ17nm7v6P4HGf24OwGTji4
	IAqMHzl8KEYX0LlmitV3PQFj2ywKm33AXVYwaUO5pxpQ6gfSctKzjqFRPkHmg1w7FvO2kcb5geZLL
	XA8m0HDEYAasz4aaP/3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaJg-00000003eqe-1qPt;
	Tue, 04 Jun 2024 19:59:32 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaJd-00000003epZ-01x7
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 19:59:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8C754CE130D;
	Tue,  4 Jun 2024 19:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0531C2BBFC;
	Tue,  4 Jun 2024 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531165;
	bh=adyoGD8HAr9AhEMKf45Q/gY8eQHlMUzh9eGEMTWGPQM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UylMGIDgJLWEehf+t7DF8NuRbR6al89Udi4ScfRrcCa2QN0ZXVNFmTkSK5wTztvr2
	 NPOlR+8M00XKQtNcDmaiJr3i5nPOmYl2mBjyjqEcAvCPE8TPr/otpaL1Lo0gcC9PX3
	 w5KXCw87V8jzkSqye0G1at/h5bm7RzEp5q8fAQgH9bbswEZsL3S4VO0uRf8TsUl+28
	 hoDj1ploWFj8pNatF0LpslXrlmLpObjIYjD06OhdTVooXTSo858Cwt4oD09HY7BxqJ
	 oRYksTt5fFT/JzwCbV3gvkvT5cGMS6Lx53wXep24/DEJRVdyxUHYkg2371SpV9TdbD
	 zD9HDl21l34aQ==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 22:59:18 +0300
Message-Id: <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-10-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_125929_530865_B91D8CEB 
X-CRM114-Status: GOOD (  12.31  )
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

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch()
> routine during early kernel boot. After determining what platform is
> present, various operations specific to that platform occur. This
> includes finalizing setting for the platform late launch and verifying
> that memory protections are in place.
>
> For TXT, this code also reserves the original compressed kernel setup
> area where the APs were left looping so that this memory cannot be used.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/Makefile   |   1 +
>  arch/x86/kernel/setup.c    |   3 +
>  arch/x86/kernel/slaunch.c  | 525 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/dmar.c |   4 +
>  4 files changed, 533 insertions(+)
>  create mode 100644 arch/x86/kernel/slaunch.c
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 5d128167e2e2..b35ca99ab0a0 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
>  obj-$(CONFIG_IA32_EMULATION)	+= tls.o
>  obj-y				+= step.o
>  obj-$(CONFIG_INTEL_TXT)		+= tboot.o
> +obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o

Hmm... should that be CONFIG_X86_SECURE_LAUNCH?

Just asking...

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

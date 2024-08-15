Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3228C3DA7F
	for <kexec@archiver.kernel.org>; Thu, 15 Aug 2024 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wrVp35LaT7j/bANyJZAoIBryFdEz+v75RoR2vhHDclg=; b=oZxkBvRg/FjOm5
	7uy1680DxEuimdeBMnYmLGffGbCVeOpkXWZKOTKKwBXkSinTZQUvjk19a4SfwZu2QZLa0o3oWTjoe
	nTjEJMpID1y3SKq06/gMi/W6S0AmOf8YYOMEmQFmc2qQR98XKHkGYNcuk9ZEc7RaVDBQK/6HwyC6a
	Q6D2oiAFSURPqXm0a8DVSFPEWAgMhqtAeH9evDp0ESloE7dnZyZgE09lE6KsZzW2H0rWSecdxH60H
	ddSQQPpCzWDTQaNc2Q+cCxAUa1XLjXdUOHDl8OxQL7Ao+DbR/GLVU1jU2x6YdPkjG+jGW/udxW5bi
	RQHjR5ejJJmPqqOsdxdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sefJj-0000000An9p-24ma;
	Thu, 15 Aug 2024 18:35:23 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sefJg-0000000An8n-2ZtT
	for kexec@lists.infradead.org;
	Thu, 15 Aug 2024 18:35:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3DE8ACE1D9F;
	Thu, 15 Aug 2024 18:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB574C32786;
	Thu, 15 Aug 2024 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723746917;
	bh=cTCsOgynQ4MwhMR6ZY7de0r7dfkhZkEHbhoL0qooFwQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ABo/r0KpwzV2fsu7t9P88x9rSwJlLxWCZferGBEeusbxc7rkDoUTF3J8FWwiBqwqT
	 NWJ2Xp90EgLXVEbil6GcV6DJHVaeoSTZi0TgVXlv9VIiBMvvFYrRJid9gLrX/txws7
	 siYy5jScFJrXwMXXkt0d9iiK3DUfh5wGFRCEdfchdNfkT04PQWTO+dMD6ip9w5NLB1
	 REC4S4UU4k9XDBy0Bx9u67wRSu7YIcEuxtwUQDBRVZ86u/aPmhNmriluSFbl0eVYSV
	 Vj+N++DUAjE6ZtDvBDIcwM/lybcx0V1R3Q/dmHf3imznH1+CD3U7BBdaxQlqGS7Aqi
	 LrEYvArcKSYNA==
Mime-Version: 1.0
Date: Thu, 15 Aug 2024 21:35:13 +0300
Message-Id: <D3GPA85MRNMM.3GMP3BTBEEYFP@kernel.org>
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
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
 <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
 <ad84cdaf-bea6-483e-82f3-c83a6b7006c3@oracle.com>
In-Reply-To: <ad84cdaf-bea6-483e-82f3-c83a6b7006c3@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_113521_014433_345DCC2F 
X-CRM114-Status: GOOD (  17.96  )
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

On Mon Aug 12, 2024 at 10:02 PM EEST,  wrote:
> On 6/4/24 3:59 PM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> The routine slaunch_setup is called out of the x86 specific setup_arch()
> >> routine during early kernel boot. After determining what platform is
> >> present, various operations specific to that platform occur. This
> >> includes finalizing setting for the platform late launch and verifying
> >> that memory protections are in place.
> >>
> >> For TXT, this code also reserves the original compressed kernel setup
> >> area where the APs were left looping so that this memory cannot be used.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >> ---
> >>   arch/x86/kernel/Makefile   |   1 +
> >>   arch/x86/kernel/setup.c    |   3 +
> >>   arch/x86/kernel/slaunch.c  | 525 +++++++++++++++++++++++++++++++++++++
> >>   drivers/iommu/intel/dmar.c |   4 +
> >>   4 files changed, 533 insertions(+)
> >>   create mode 100644 arch/x86/kernel/slaunch.c
> >>
> >> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> >> index 5d128167e2e2..b35ca99ab0a0 100644
> >> --- a/arch/x86/kernel/Makefile
> >> +++ b/arch/x86/kernel/Makefile
> >> @@ -76,6 +76,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
> >>   obj-$(CONFIG_IA32_EMULATION)	+= tls.o
> >>   obj-y				+= step.o
> >>   obj-$(CONFIG_INTEL_TXT)		+= tboot.o
> >> +obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
> > 
> > Hmm... should that be CONFIG_X86_SECURE_LAUNCH?
>
> Further thoughts on this after discussions...
>
> The Secure Launch feature will cover other architectures beyond x86 in 
> the future. We may have to rework/move the config settings at that point 
> but for now I don't think we want to change it.

OK got it.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

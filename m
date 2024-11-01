Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05117E6F08E
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 22:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C0gzEgoJe4bYHHFw0o1GTdGMcMEApWHSGCHxcdyl57Y=; b=2goHR+PFRX4+XB
	uQjgG+2ueGZsqrOy1cUptWQVfdPxBmxqc8ZHxN6qbyxUiFXNnliMf3rYc7f0HyDHkyldYiGRGCpyg
	oQPviW+2obLELBwAKXIBOFESY/8s8HnXaIZLG8D/NJVWohpky/98CixHaNot1/Xj8fKJw8iapSeAs
	jIC9mcM8wFdy+1VsulR78SBRnJeZGeLTJkk/TrwQJ7w2CDafIaRKF4wA8vulo+UPzK0smBozKzNdF
	KZE6d+d0cAlJ6zpSLKNrCyOo5HDomO+wUeb2m9RWPubU8jB3zG4zATfRJGQQSn4bj8XR7rhTD9aGJ
	h+7pEpNLQT1u26NKd9og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zyi-00000008RyC-1kas;
	Fri, 01 Nov 2024 22:18:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zyf-00000008Rx8-0qTT
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 22:18:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 507545C58DC;
	Fri,  1 Nov 2024 22:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E707C4CECD;
	Fri,  1 Nov 2024 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730499523;
	bh=SfvWv72ZbUeIjpMhK1H+Di14U2NJnni6MvQ7OWwTfDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8B5FbihtNvVjmiGncdZkw/5g49VXEDLWU6dCd6f7AgBZV7b3MDz4Mio9teMOIupZ
	 ARqPuoMHB79uUnWfl+rqF4KTcZ/gObfhf3oVmSS9eCRk0qutPaqPxfYhbHSu3Vq/je
	 HAnbzuzI/c9euOqXkGM4iUaORjvXEUct9BNxVVJk/Pbc72JYcDPtDceTthEVk9fecj
	 /Eb+mS/2aEEzZIyWFJQYVe4M7FITlC7FUxUCj5mBCz6yf4dfV6rgbJW7pxdd+uGM6c
	 HQnGDrwoQ/wXmcgGWjGK7qycALq7sacle8cuCNP5D38T9ddXyPOhWhHpmJw1iV1I20
	 ayJ6MSw0pdYXA==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 00:18:39 +0200
Message-Id: <D5B6VSE24UFU.3IMXJC23PCNFW@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <mingo@redhat.com>, <bp@alien8.de>,
 <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
 <mjg59@srcf.ucam.org>, <James.Bottomley@hansenpartnership.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <luto@amacapital.net>,
 <nivedita@alum.mit.edu>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <corbet@lwn.net>, <ebiederm@xmission.com>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
 <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
 <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org> <87msiitxto.ffs@tglx>
In-Reply-To: <87msiitxto.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_151845_300488_F4915188 
X-CRM114-Status: GOOD (  14.46  )
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

On Sat Nov 2, 2024 at 12:04 AM EET, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 23:19, Jarkko Sakkinen wrote:
> > On Fri Nov 1, 2024 at 11:13 PM EET, Jarkko Sakkinen wrote:
> >> I think we can sort them out independently as long as we find a
> >> conclusion how to address locality change.
> >
> > And to be fair: there was no reaction from anyone. It is mostly x86
> > patch set, meaning that I was waiting for some reaction first from that
> > side.  And I did respond to that when it came.
>
> The x86 side is mostly self contained, so the damage there is minimal,
> but the TPM parts are changing the generic operations and the x86 parts
> depend on them.
>
> So let's not create a chicken and egg problem and solve the TPM parts,
> which at my cursory glance are partially legitimate fixes, independent
> of the actual trenchboot x86 functionality.

Yeah, I'm already writing a (draft/RFC) patch to demonstrate my
proposal that I sent so all good.

>
> Thanks,
>
>         tglx

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

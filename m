Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FF2C52D7C
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=POF7aIyachH5KEqC/XwHe3uAl/o2li8DEUzvH5mxgJc=; b=NmNQFD2shfmWBE
	JGgk96hCyIKS4hFGryS3HhAdX5INkowDdZftQcgz0rxWUmRTlm8wS6Fk/2UAUa5PKAxCH459E03EB
	BLJaFsNLBi4875qcy3nFogu+SJpeodFZsq6RjclODHeGono6DJthT0ttr+VHwYsT8okNgCQO4goKu
	cbesKQDZx3A+g5sACsRJWotH67wc5UBFH1xcUSrSlpgN5+dJosWrqCrLp37DY0mYV9jVDjO3Np0f/
	cyrjxMQc/GMEr5sqFvKC3ODBWV1FQZyAHB+ySlAW29rn6RQwiPKM2aaTj5a6XuKEy1GBrpuCEJgJ5
	OYMYxujmzQvDZo6Xh3LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg6lP-00000002VIH-2Sz5;
	Mon, 19 Aug 2024 18:05:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg6lM-00000002VGZ-235D
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 18:05:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EAA7660C81;
	Mon, 19 Aug 2024 18:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEA4C4AF0E;
	Mon, 19 Aug 2024 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090751;
	bh=uLSpmh/E5SFR+0qV7rTBO7Co/W3e9kkntMp3LEBgW5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adPXV4dvUSE0pwCC6K1YfPntPyebWDDj0fD+pJW3wr5fWWivDUihmzH65OZg46th3
	 XY10Ijh0JETmHQ73y7+fG4I7PgmkHr7U80iDyJGFtweWoz0YsD2HhM0IN6gAouT3+4
	 6/b3YMhfpj3SjpIxmEsO8HaHTh/HP48Vhopc1sof3H6TSo2NuxemqhNg0cvH00Yqjd
	 FoE10+toTGsLcJhCGFlHGlNrtMPcWL+mwRQvrS4NYp3KGBtiTY7wERz0v8glMM02y5
	 B4p9QyU2xjbp0fZfBDFDQLq1UwKFMdeTscNEQhbErYHeZ8xohsUeIfaNIwX+yr65Nd
	 gZnFXr8lOKE8A==
Mime-Version: 1.0
Date: Mon, 19 Aug 2024 21:05:47 +0300
Message-Id: <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Cc: "Andrew Cooper" <andrew.cooper3@citrix.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
X-Mailer: aerc 0.18.2
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org> <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
In-Reply-To: <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_110552_593845_F878CE1B 
X-CRM114-Status: GOOD (  12.56  )
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

On Fri Aug 16, 2024 at 9:41 PM EEST, Matthew Garrett wrote:
> On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:
>
> > For (any) non-legacy features we can choose, which choices we choose to
> > support, and which we do not. This is not an oppositive view just saying
> > how it is, and platforms set of choices is not a selling argument.
>
> NIST still permits the use of SHA-1 until 2030, and the most significant 
> demonstrated weaknesses in it don't seem applicable to the use case 
> here. We certainly shouldn't encourage any new uses of it, and anyone 
> who's able to use SHA-2 should be doing that instead, but it feels like 
> people are arguing about not supporting hardware that exists in the real 
> world for vibes reasons rather than it being a realistically attackable 
> weakness (and if we really *are* that concerned about SHA-1, why are we 
> still supporting TPM 1.2 at all?)

We are life-supporting TPM 1.2 as long as necessary but neither the
support is extended nor new features will gain TPM 1.2 support. So
that is at least my policy for that feature.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

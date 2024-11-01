Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1208E6F08E
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 21:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X2JDvUvEq7rUTgJcu2dro1zk4xkCsG1h3oJrGTyjYUM=; b=qjJse0e/87DeQZ
	sMV9/NzYW0OeX1zakT7PWi048VIxx0JnHbFxdwsyg+4CNvvrw4M89CyVVNRp2jTysHBFrMuAQZtUI
	pZ71MYzqPscvBlK3LD2ihlLpQ4j2yty2VziSwnc8lzHbD21tr4oUsWm580B4XnAETW6diGak/Z3ei
	fUQ10vXYkEmrSAwlAGJ5A/jGM4Rm/qQLzHRsjd3Ql0dTQPKFriaJE+e9qRayIOQ/tNZm5U5fG3/9W
	WLT8w7Rtz7ZM6QeLPZ9NUCuzDYV5mPR2P0ONcN2FqdJposPABEEdtK/nRvInrgCfu91bGIc9AS/pG
	yJyK9rwmqItUxpdqmlvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6z3m-00000008Lj1-14Hp;
	Fri, 01 Nov 2024 21:19:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6z3Z-00000008Leg-09hd
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 21:19:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D0FED5C5E47;
	Fri,  1 Nov 2024 21:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9031C4CECD;
	Fri,  1 Nov 2024 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730495983;
	bh=fJEg2VjMXer2Y0al47UWb2qt+VXk29+LnZoE+tlChVM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nHYL0beIEk+vI+DD7w/Us6zMyJvldIqAHUSHcrklNSvCq11LHVJ6CBt5xv78b/JJC
	 dPgfCM0V6snWFNmONDbXmhzak1nJPTLPySPFRUP6u0ExWLG4v595JsxTxoCBMrdjFC
	 MemL5Z6ImC8jJD4GJHp89n7ZT8Hlxi8POl1YslvSCwUkZcXMSg4Rv6kE/ZzPa3pG1C
	 hh/T4YG/hSqq/sGxKd6WvIuzu+pTMu7CuG8uE9ou0AIh3M3TG0vQsvpSUDj273uU/N
	 hPD62pWdslpiS1uhT+lzHqwad/pyPyc8nOEunPm6wT3zzTJD7lqpahjKEqBJu4hL8U
	 v723ef+lxzjkA==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 23:19:38 +0200
Message-Id: <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org>
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
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
 <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
In-Reply-To: <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_141945_490847_F7D4E0DC 
X-CRM114-Status: GOOD (  29.85  )
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

On Fri Nov 1, 2024 at 11:13 PM EET, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 10:34 PM EET, Thomas Gleixner wrote:
> > On Fri, Nov 01 2024 at 12:28, Jarkko Sakkinen wrote:
> > > On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
> > >> A quick note on terminology. The larger open source project itself is called
> > >> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
> > >> the use of Dynamic Launch technology is referred to as "Secure Launch" within
> > >> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
> > >> in the code. The stub code discussed above is referred to as the SL stub.
> > >
> > > 1. I don't see any tags in most of the patches so don't get the rush. This
> > >    includes also patches for x86. Why I would care to review TPM patches
> > >    when there is over a dozen unreviewed and untested patches before it?
> > > 2. TPM patches have been in circulation in and out of the patch set
> > >    for some time now with little or no improvement.
> > >
> > > Why the sudden buzz? I have not heard much about this since last early
> > > summer.  Have to spend some time recalling what this is about anyway. I
> > > cannot trust that my tags make any sense before more reviewed/tested-by
> > > tags before the TPM patches.
> >
> > If I intend to merge the patches then I surely have looked at them
> > deeply. I don't have to send a reviewed-by just to apply them
> > afterwards.
> >
> > There was enough motion on these patches and this posting is in your
> > inbox for 6 weeks now without any reaction from you.
> >
> > The TPM changes are very much independent from the x86 specific ones, so
> > why do you want x86 review tags in order to look at the ones which are
> > specific to your subsystem especially as some of them seem to address
> > real short comings there independent of trenchboot.
>
> I think we can sort them out independently as long as we find a
> conclusion how to address locality change.

And to be fair: there was no reaction from anyone. It is mostly x86
patch set, meaning that I was waiting for some reaction first from that
side.  And I did respond to that when it came.

IMHO: let's get a solution for that one problem and then it should be
fine as far as I'm concerned.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

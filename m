Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A154E6F062
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LyzQxyieV5Xv/WIuOXxNlqBNv+SVSXQe8tNxCeolvNg=; b=Re8QzljjLmFa0/
	mXqWCX5aHalGJOFAl33iE8bM1qqi0L70aMS22g2NS2p7uZuXChtrt7nEJt0CV7+i1k640l3sj0Oes
	2OyxABEz6uP0tLcYXGsgPw3M/FMA2Jr5rpheBAtIptgxdkuZ8rsI3MP1gTotB5S2lA5C5yXOxqH40
	KAcVhjUW2riBEKHMM9QHoFlzKcmo0dJ8vfQ5aGEyVxckbTE+Yd2/syuEHDkJ+0yfLyXypaLh/3Hmb
	SZn/eRAgdVICpscqFgraGJNFmFQ2uEQKNpez2lF/OflGnB1sM1Eu70YMSTWtOB3EkMWmhMa8ZDIxv
	aY8GIfkDxjHyTJDrnLww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6yxo-00000008Kkr-1ao1;
	Fri, 01 Nov 2024 21:13:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6yxl-00000008Kjp-2wnV
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 21:13:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0A84CA44A4B;
	Fri,  1 Nov 2024 21:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71602C4CECD;
	Fri,  1 Nov 2024 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730495624;
	bh=vrlQ5nkW/wzdW59TsobYC/cGECVvY5bM8O3JACd5vR8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Z27lBmP5zV5S/Lm4wBLsyOzhvmCy+PaD+aSiDJoAmhJdwIpgWu7go74DLTbL/DmAQ
	 m4VM1XbkSRlPF534HjALo5a+qdkHgu9qy7+8tWZNobfIsypdUOnVT0zMYvrKbUDL4O
	 pr1BHsYZ9HdZm3+qsutLq53SUhzXTlall69hNmqjdD/bOYezVVbNGKRm6m/IunumGl
	 yvVYFXZZqN56obQzEkxMIxL4DYP8SF14xIQkYNBExMzLjQ854ir3tdEZDwvoO4vfKs
	 /NGBCW4lZDq+POOJewWgjrRi1z/wGj1/cGx7DlUqqRKhNteHFYOtX09Yf+Ee0YlFcE
	 f90hDeNlC3TVQ==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 23:13:39 +0200
Message-Id: <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
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
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
In-Reply-To: <87a5eivgku.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_141345_872266_64DAF5FE 
X-CRM114-Status: GOOD (  25.07  )
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

On Fri Nov 1, 2024 at 10:34 PM EET, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 12:28, Jarkko Sakkinen wrote:
> > On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
> >> A quick note on terminology. The larger open source project itself is called
> >> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
> >> the use of Dynamic Launch technology is referred to as "Secure Launch" within
> >> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
> >> in the code. The stub code discussed above is referred to as the SL stub.
> >
> > 1. I don't see any tags in most of the patches so don't get the rush. This
> >    includes also patches for x86. Why I would care to review TPM patches
> >    when there is over a dozen unreviewed and untested patches before it?
> > 2. TPM patches have been in circulation in and out of the patch set
> >    for some time now with little or no improvement.
> >
> > Why the sudden buzz? I have not heard much about this since last early
> > summer.  Have to spend some time recalling what this is about anyway. I
> > cannot trust that my tags make any sense before more reviewed/tested-by
> > tags before the TPM patches.
>
> If I intend to merge the patches then I surely have looked at them
> deeply. I don't have to send a reviewed-by just to apply them
> afterwards.
>
> There was enough motion on these patches and this posting is in your
> inbox for 6 weeks now without any reaction from you.
>
> The TPM changes are very much independent from the x86 specific ones, so
> why do you want x86 review tags in order to look at the ones which are
> specific to your subsystem especially as some of them seem to address
> real short comings there independent of trenchboot.

I think we can sort them out independently as long as we find a
conclusion how to address locality change.

>
> Thanks,
>
>         tglx

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

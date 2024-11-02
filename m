Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC58E677F5
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eCCFIyloZl8Rfnq5PoNowjnnPxFRnSwBzTaIe7qwpUI=; b=DEcTBsYDkLRsPv
	pa5KNSupzoVw6j+XB4zbHVx1hNgNNQfS3vacWLt64hvn3Aff13JZbIln9K4GgK2YKKlStYf9027T7
	zK7AGe9T7t/+kP+Ux0+K78uqiUQ2MipA/91Dx+mhodLO7eBjAhJo25zA1RWKsgkQf01+HHwvfHmL5
	Nd1j/ht4ShIP5oEJ4hdQi5jg4TYGtXFxl7PKkr4A7RM3mskb3+nWIdv6YixBU3D8c+7NiDE/8/qwh
	91tBjb7YppDDU4Tiu4g44/ksAOdI7wfktfo28F4QuTwBJGRfEkq02uxdHd9za62BHED8ap+FZEjGS
	3IfFBY5sl6lU2b5lmk3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7EM0-00000009nOU-1Rd6;
	Sat, 02 Nov 2024 13:39:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ELx-00000009nNl-37i1
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 13:39:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 67D18A40078;
	Sat,  2 Nov 2024 13:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74441C4CEC3;
	Sat,  2 Nov 2024 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730554783;
	bh=sxBligjgKTVDk7jjHZnmdCYx6SXn35Wcjb9+LxenKDs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=um5mVVfufD7+UoTS8jMDsamcAhTuEjg6A0ORTzlgu/Q9HKzwpAFL8iOUXfTlXE6SC
	 /p0QR+RtUL9Lu/NsyzijhcdmJ7LLTFvDK0Il25LCvW5ro0aSLqy/cuIPeFJ32CNN2d
	 EN4I7xt4Fqi1xj5fDmEMseVMu5/OUto2eSx8ZhLDvnZMjfVKzFYlhNY8zClW0aRoFG
	 GmnpSIGDIQLBPeArr7ea6SBJDNPyFj71iMd+Eof2IlOmyJdsGPcPMohuEw0fPsUw9F
	 tW483OucMVL5HcSVaPNMb/aegWoBkcTzRpZ2wAr6Pd1DE/c0yJRZl0s9Ce3WF6t1SA
	 LbSvkCk/SYRMQ==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 15:39:38 +0200
Message-Id: <D5BQGY5425TQ.3U6N698H2KYWO@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, <James.Bottomley@hansenpartnership.com>,
 <andrew.cooper3@citrix.com>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>,
 <dpsmith@apertussolutions.com>, <dwmw2@infradead.org>,
 <ebiederm@xmission.com>, <herbert@gondor.apana.org.au>, <hpa@zytor.com>,
 <iommu@lists.linux-foundation.org>, <kanth.ghatraju@oracle.com>,
 <kexec@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <luto@amacapital.net>, <mingo@redhat.com>, <mjg59@srcf.ucam.org>,
 <nivedita@alum.mit.edu>, <ross.philipson@oracle.com>, <tglx@linutronix.de>,
 <trenchboot-devel@googlegroups.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
 <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
 <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
 <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
In-Reply-To: <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_063945_918034_B0F20272 
X-CRM114-Status: GOOD (  17.72  )
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

On Sat Nov 2, 2024 at 12:52 PM EET, Ard Biesheuvel wrote:
> > Short answer: I have no idea. I would not mind that but neither
> > the commit message for TPM give a clue on this. Actually, I *do
> > not care* if it is RO and RW but I'm neither good at guessing
> > random shit.
> >
>
> You were cc'ed on the rest of the series, no?

Yeah, but that does not make sysfs attribute having store operation less
confusing. At minimum 2/2 should replace the current sysfs patch, if
store operation is not required.

> Shall we clarify this first, before proposing patches that introduce
> new ioctls() and kernel command line parameters to a security
> sensitive subsystem?
>
> My reading of 19/20 is that the secure launch module sets the default
> locality, and given that it can be built as a module, setting the
> default locality needs to be exported to modules (but as I indicated,
> this should probably be in a TPM internal module namespace)
>
> If setting the default locality from user space is a requirement down
> the road, we can discuss it then. For now, let's not go off into the
> weeds and derail this series even more.

If sysfs store is not required after all, and only thing that touches
the locality is slmodule, tweaking 17/20's set operation to this would
be good enough for me:

int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
{
	int ret;

	if (locality >= TPM_MAX_LOCALITY)
		return false;

	ret = tpm_try_get_ops(chip);
	if (ret)
		return ret;

	chip->default_locality = locality;

	tpm_put_ops(chip);
	return 0;
}
EXPORT_SYMBOL_GPL(tpm_chip_set_locality);

Now that I've worked on this issue I think also 15/20 and 16/20 are
pretty clear I can suggest some tweaks to the commit messages later to
make then more self-explatonery.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

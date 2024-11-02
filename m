Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB528E677F5
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LJMXQlE0Ir0CJLrLYjB92xWNGGvXtoFhKuMfcL4BMjM=; b=BA1Q/e6jWrCYjL
	1KJW7yLQdDmeqyRgALG7OGFSiNVKbYUUxUGymyst4M04VIqlKRtlIFwAwHPF02Dd1d6tztpxYoRSk
	7HHWKGZ6vGJAjlG3bD/oF306chyPrz2jxQvftmz55s2nKGUJ7o9umFSm2d272cv8v+DT4C597WYxL
	3WNN5KzyWdNBhAs5XtCjCCTMbN7w9QkxslhcBwuRe3kM/hoZwIoEbFbyjXl3v+sMvqs+XyVIgFm08
	a9tTnvKLuXjLxkG7jyh6LntANDUMdhhdErKLx6b95hRRyEqpSqv+VtnYOuK3AHpMjGAUNUa3zgS4b
	GoztxPInWtSBfTkBcUWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7BX6-00000009VVG-1mQq;
	Sat, 02 Nov 2024 10:39:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7BX2-00000009VSg-0NGq
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 10:39:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 66B2AA402DC;
	Sat,  2 Nov 2024 10:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7DC4CEC3;
	Sat,  2 Nov 2024 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730543938;
	bh=VBKEa56BIF6QsRkD7RAecoTuv66Z7zv8Det8m4u7ftI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gOtMufXPnc1DFubhW7urf50dPP0bw7KIiI3fvULoHrreHHmwFH9QwAfpNb54uDN18
	 kaAGkZTYHObw5uIJMbV9bUddVCc1ac0Saz5R1wPok7rFAng3z5LsAVZOXlyl/LCoCt
	 G1hsDOSZJJDG9/uEQhCnicp3jmsm2plmYOIQmF7hHiJ/+a4a9RXHKtxhsRYhofwHAA
	 lLkViIuMowQlJi/iR0N36yOu8ktoVAz+045SjYt1aw8Ju46YHIUBQqLfWk7NqGhDuM
	 AEFABWsbKJAh+lmxj5cmSoWXmdQVVQTiAKI8qVrgMtzWekCyE9Ldt7bWWVUyLtMp5U
	 CZ0rOmGMK8dyQ==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 12:38:53 +0200
Message-Id: <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
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
In-Reply-To: <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_033900_216964_919EDAFD 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message.
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

On Sat Nov 2, 2024 at 11:02 AM EET, Ard Biesheuvel wrote:
> Same for the ioctl() [as well as the read-write sysfs node]: looking
> at the code (patch 19/20) it doesn't seem like user space needs to be
> able to modify this at all, at least not for the patch set as
> presented. So for now, can we just stick with making the sysfs node
> read-only?

Short answer: I have no idea. I would not mind that but neither
the commit message for TPM give a clue on this. Actually, I *do
not care* if it is RO and RW but I'm neither good at guessing
random shit.

I haad to assume it was *needed* for reason that I do not know
given that sysfs attribute was RW.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

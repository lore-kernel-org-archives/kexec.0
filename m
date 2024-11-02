Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55280E677F8
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DHv7DrHTOQYui7bVTJcAfVc1bKDxmTDja9VrqGA37I8=; b=AP1rOlCkdTDfpf
	Oq7Nk//uPqShLc65i5tj9HqVZpuSv2Kt0oqICexxB7OxLKJlv+Ai+Oc/fdpYLNQOI37xWQuG1JMPQ
	MofeSgh8oRad9H++MUXTjGTuF+a+/1kKePBw2YRh+D/6w5WRYouQ4fHS4UdBh+M1kQw6eb7UOjqi3
	yR9/7w8uTX8m/hESOzhajQu9sVmzExORDjprKk6QAJWrvGlbkDWQ9WSRWd4t/6U97BEkBFWWfs3nI
	xATmtU2Z1OFR0adwSdDFB/T0ED8v3XVqJRAqDW4peM79i6tsaEyLQeorznHbLgMes7oXrqA7jNBxB
	RyMwgYOQ21dB2Y8VqFLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7BYf-00000009Vjm-01SA;
	Sat, 02 Nov 2024 10:40:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7BYc-00000009ViR-21G6
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 10:40:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CC4275C3300;
	Sat,  2 Nov 2024 10:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A74C4CEC3;
	Sat,  2 Nov 2024 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730544037;
	bh=tV3w/NhiYLlSxyTG9f/8MYrM2eWyQSkpoUd6CUZpQ/s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YqfIep9RAimhK5lG8GqaDVHqPzgB0uQJtTNYapUpHHL3VKHD63sfcJEgzueni7hxh
	 cilOlKzjwtdBMAy/OQZ+l0IpY0UmNFTwXCvsHHnr7kkoK/43Rug3DEoVA+M1xExXzq
	 BOTjSEjqGkivPG88YnB5MWaZUg8+CWRWayIW79lY9vYeYXYzUrSgq8nDMHSDKx2rCF
	 8Q7UW0GpW0FwAXMD9WoKaep1r8yt4QQxPeQLyx1CeRryvMAk5IZgYpA87cz4tAe5PC
	 cmA3WWCIh6wxIYGhm7nB1aprTmMUmQq43pnRUZGmIZNenwodP9jmmhiXWEG730hFGH
	 Ln33GT8WM1epw==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 12:40:31 +0200
Message-Id: <D5BMNT065TE5.1SV8CSW8KEG6L@kernel.org>
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
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
 <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
 <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
In-Reply-To: <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_034038_571206_0644508F 
X-CRM114-Status: GOOD (  13.85  )
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

On Sat Nov 2, 2024 at 12:38 PM EET, Jarkko Sakkinen wrote:
> On Sat Nov 2, 2024 at 11:02 AM EET, Ard Biesheuvel wrote:
> > Same for the ioctl() [as well as the read-write sysfs node]: looking
> > at the code (patch 19/20) it doesn't seem like user space needs to be
> > able to modify this at all, at least not for the patch set as
> > presented. So for now, can we just stick with making the sysfs node
> > read-only?
>
> Short answer: I have no idea. I would not mind that but neither
> the commit message for TPM give a clue on this. Actually, I *do
> not care* if it is RO and RW but I'm neither good at guessing
> random shit.
>
> I haad to assume it was *needed* for reason that I do not know
> given that sysfs attribute was RW.

Let's put it this way: *if* write is needed this the way to do
it now and also in the future (or along the lines). Or least
harmful at least (single additional locality change per boot).

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

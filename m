Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF441C3DA4A
	for <kexec@archiver.kernel.org>; Tue, 20 Aug 2024 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7jzFlRTPE7Gt4UYrsbD9SRS9vxdnixnS/pyGfJB8jB4=; b=HNmaRluPulxBSx
	LyJZI/m5dFyPRe7tbMC7nOP+64JA0talMXAi4OuekShRblx045kKng9LAqaPu0vTD85RHAwwNJWaz
	i9aEqqhjftpr0tJjoKKEOxK9a7p7xY9WXZfOkmb90oyMzU2OW5uKdxLM6WvfBiLbfaE+fnGRoASCg
	+em7TU0XfTeTNrfTpdADiYXicKBge95I5L145TbIn02KvOJ92DkcdIbG0d7WgxURFFTKdao6+U+/B
	eC/Z2K88HA9AvjDfgKQcjrpbwzkmbFu9+bOKsGFSWlgQED8XAX6CxcjJT+mUAXl8zPgVheQfuAf6e
	YAzD5rIpjNzPG6IQHYrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgRkj-000000060hb-0LgY;
	Tue, 20 Aug 2024 16:30:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgQkt-00000005oMr-0Icl
	for kexec@bombadil.infradead.org;
	Tue, 20 Aug 2024 15:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cul7AYUW/oUYJetixYQFOVkrNIZzj7nX7ZdNR4EJkYY=; b=Hv06YoWTk+usWSzELMTfm1esEU
	8L4isOW7XfYvKOQivByEdh3N5uU30tkhzmi5G4OJige7VF6wmlnjW9NmbpgcDhfXefJ5Mz2B97y4V
	W1jh3S1FC7E4kf9il9rrZNOrn1vvyQXi0dvo1Ahmjb+1XwL4hkYvQffGzCOGOh8NTetABl8GAtZ/E
	bEM5gqpMf8UTlRlF+Gj3FfsYA8rtQ1SNI7q56u5hD0uX0fGSfbdOZbNfyiX+WekV8Ub0cke1WdSEM
	7EKiXoq9jpBeLE6eik1qzXSe86yWAhmo89/mOWOXjYFCMkRXYC0nGcdiUqqdMfbWLIud+a5no1U7I
	Y+ruBScQ==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgQkp-00000009M0d-13Iw
	for kexec@lists.infradead.org;
	Tue, 20 Aug 2024 15:26:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B4C6760E00;
	Tue, 20 Aug 2024 15:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E3C4AF14;
	Tue, 20 Aug 2024 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167595;
	bh=cul7AYUW/oUYJetixYQFOVkrNIZzj7nX7ZdNR4EJkYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYij2JgHvU1AVhaIiSFSmqh3C4f+ic8eJASZifn6Evsee/JMB21kiEgUtpOIBAzfw
	 WhPHhWbdxcAJ3GX75aIWxGKoIE+TbIbkElRQxkSiCM1gSh7PD6MUNxSUUoVKCpdCo5
	 Br49eRY1Fh7j8jsrdqPjohHKrKIQUkf6RV1BkZp3Zhod/8qnYQgViR4l08DXR6aSmW
	 DulskVJSqnfDMUzs1+E910tAcZopB11i46RMlqd/GfDzeV8Bwbz6KJUBtopdAKLoXo
	 UJG9b6LftIfnK02/OMGuvfBF4uYp8xc4JKrLL2vskwO7qu1TbpCs1VTOoV0Mv/xjHN
	 vN7mHGvix1P4A==
Mime-Version: 1.0
Date: Tue, 20 Aug 2024 18:26:31 +0300
Message-Id: <D3KUEGW4Q63K.NEFOY5C6ZG2O@kernel.org>
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
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org> <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
 <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org> <ZsONwsWs3zCln70O@srcf.ucam.org>
In-Reply-To: <ZsONwsWs3zCln70O@srcf.ucam.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_162639_688154_9A732475 
X-CRM114-Status: GOOD (  19.44  )
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

On Mon Aug 19, 2024 at 9:24 PM EEST, Matthew Garrett wrote:
> On Mon, Aug 19, 2024 at 09:05:47PM +0300, Jarkko Sakkinen wrote:
> > On Fri Aug 16, 2024 at 9:41 PM EEST, Matthew Garrett wrote:
> > > On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:
> > >
> > > > For (any) non-legacy features we can choose, which choices we choose to
> > > > support, and which we do not. This is not an oppositive view just saying
> > > > how it is, and platforms set of choices is not a selling argument.
> > >
> > > NIST still permits the use of SHA-1 until 2030, and the most significant 
> > > demonstrated weaknesses in it don't seem applicable to the use case 
> > > here. We certainly shouldn't encourage any new uses of it, and anyone 
> > > who's able to use SHA-2 should be doing that instead, but it feels like 
> > > people are arguing about not supporting hardware that exists in the real 
> > > world for vibes reasons rather than it being a realistically attackable 
> > > weakness (and if we really *are* that concerned about SHA-1, why are we 
> > > still supporting TPM 1.2 at all?)
> > 
> > We are life-supporting TPM 1.2 as long as necessary but neither the
> > support is extended nor new features will gain TPM 1.2 support. So
> > that is at least my policy for that feature.
>
> But the fact that we support it and provide no warning labels is a 
> pretty clear indication that we're not actively trying to prevent people 
> from using SHA-1 in the general case. Why is this a different case? 
> Failing to support it actually opens an entire separate set of footgun 
> opportunities in terms of the SHA-1 banks now being out of sync with the 
> SHA-2 ones, so either way we're leaving people open to making poor 
> choices.

This is a fair and enclosing argument. I get where you are coming from
now. Please as material for the commit message.

BR, Jarkko


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

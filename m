Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA564C52D7C
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gQ2YTZZEqKdsqxZgEoZrjejQMp5sAsoYQQ/dVvwTM8g=; b=H3FjpwTTumBgb2
	MfslWBz7PHe3vOm1AyF4T+gApOp8ASbMkeWoxmYG3Hxo5dqVSKcKUTEmyyE3ItJfxJchBHCUF27P4
	+nqZLOchsUaoOHpkETatWt6XmWwvI3SdPa6Irk07036dxQ6EI4DqP2Hm3C4JKDy7C/6Z9iS7IGMZ6
	MjxDFYxp5v3UxDQAEFdzaQ7gzlY3U7h+hvIh5ro8vmE2EOwqQQ2H9d5bVA2aratgo2OQTiW2AFOYG
	aWQGXUWmxeLbeHYzy+BPw5iqopJJLXloH2mdlMEusYKqUOMvZcpidjhAe9dHXWoYwmlxKC861rexA
	FTmUABHMTPCzfXlZkTdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg73L-00000002YXD-0Tvo;
	Mon, 19 Aug 2024 18:24:27 +0000
Received: from cavan.codon.org.uk ([2a00:1098:84:22e::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg730-00000002YTx-3EV5
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 18:24:10 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 2F2FF409FF; Mon, 19 Aug 2024 19:24:02 +0100 (BST)
Date: Mon, 19 Aug 2024 19:24:02 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <ZsONwsWs3zCln70O@srcf.ucam.org>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>
 <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
 <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_112406_959950_AB2F4B5C 
X-CRM114-Status: GOOD (  20.44  )
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

On Mon, Aug 19, 2024 at 09:05:47PM +0300, Jarkko Sakkinen wrote:
> On Fri Aug 16, 2024 at 9:41 PM EEST, Matthew Garrett wrote:
> > On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:
> >
> > > For (any) non-legacy features we can choose, which choices we choose to
> > > support, and which we do not. This is not an oppositive view just saying
> > > how it is, and platforms set of choices is not a selling argument.
> >
> > NIST still permits the use of SHA-1 until 2030, and the most significant 
> > demonstrated weaknesses in it don't seem applicable to the use case 
> > here. We certainly shouldn't encourage any new uses of it, and anyone 
> > who's able to use SHA-2 should be doing that instead, but it feels like 
> > people are arguing about not supporting hardware that exists in the real 
> > world for vibes reasons rather than it being a realistically attackable 
> > weakness (and if we really *are* that concerned about SHA-1, why are we 
> > still supporting TPM 1.2 at all?)
> 
> We are life-supporting TPM 1.2 as long as necessary but neither the
> support is extended nor new features will gain TPM 1.2 support. So
> that is at least my policy for that feature.

But the fact that we support it and provide no warning labels is a 
pretty clear indication that we're not actively trying to prevent people 
from using SHA-1 in the general case. Why is this a different case? 
Failing to support it actually opens an entire separate set of footgun 
opportunities in terms of the SHA-1 banks now being out of sync with the 
SHA-2 ones, so either way we're leaving people open to making poor 
choices.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

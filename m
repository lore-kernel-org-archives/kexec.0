Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4ABC25B74
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 02:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gGM93Oqs/BuGhhmiQ4m3Wy34L2cvhelBRrINJCSGYig=; b=yLKrKXFfEECjWD
	+zYM11yfMtOk9g7/k4mMhyTXKbXBARdonpUlxtFG6ygjLochm4mY2RwnLnQBP3eCu0BAav8qw6SOo
	/MFRjx18PMdKU2NOAnTzKbbjmCbqglr9yYitWtoGs4Cav+EVOXkt+qvcVB4KBUB8k4kw3rLMOtx/s
	qldWjpZRXnh7Io28WKHopwn228vAdEyLDwQP/KC8Slwptbh2QG1CUiPDrFd29wIu1ZS376CK03/lr
	7GJqmhFGk5draZrKaAm4AoJvPnz4CsnSIv+9jo853xZjNKEKvxJ+mpUyQLpPycx5Kowm6Ksna5sBz
	IEIcLTpXGl/dwPxdr/3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCrpK-000000090TC-10Ua;
	Fri, 31 May 2024 02:17:06 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCrpH-000000090RL-007N
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 02:17:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E8130CE1B2E;
	Fri, 31 May 2024 02:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C8C2BBFC;
	Fri, 31 May 2024 02:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717121819;
	bh=P5d/0b92iEEWWrKJQ67tqG3rp+vdYxJZiUvaostorGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkaByAMrS7s3R8mRhw3b+e4esv4ruad8pwZal97P7yPssH0JV1AZh/jIKAQTk6Tu+
	 JS1Bcf42qlwozPi845OchFKmaFQBRLqLd5IbpLo33CwKwmKGGFe4caWgrY+BF6I3Oo
	 lQvzd7s68N16zgT+eX1feCQkUFxpflo7srOsfgGO5Nuu3GlQXMIjaZH3HK4tB4440c
	 GoqHWACn0iwEfylTG+VXzj9wuwAN+hfKFtYP4YBMVwebVRc6/hx6mLpjLqG0qGlEEW
	 X+Fvudlzs2OvFvkw16SPZ8f9OE+vPr6XP+zhRE/XXACoJ4CmeoxbHv5oyuab8yZeqJ
	 3rAnt80rtWJDg==
Date: Thu, 30 May 2024 19:16:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <20240531021656.GA1502@sol.localdomain>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240531010331.134441-7-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_191703_425327_C06C0E4D 
X-CRM114-Status: GOOD (  21.11  )
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

On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> choice of hashes used lie with the platform firmware, not with
> software, and is often outside of the users control.
> 
> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> to safely use SHA-256 for everything else.
> 
> The SHA-1 code here has its origins in the code from the main kernel:
> 
> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> 
> A modified version of this code was introduced to the lib/crypto/sha1.c
> to bring it in line with the SHA-256 code and allow it to be pulled into the
> setup kernel in the same manner as SHA-256 is.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Thanks.  This explanation doesn't seem to have made it into the actual code or
documentation.  Can you please get it into a more permanent location?

Also, can you point to where the "deliberately cap the SHA-1 PCRs" thing happens
in the code?

That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
but why would you not at least *prefer* SHA-256?

> /*
>  * An implementation of SHA-1's compression function.  Don't use in new code!
>  * You shouldn't be using SHA-1, and even if you *have* to use SHA-1, this isn't
>  * the correct way to hash something with SHA-1 (use crypto_shash instead).
>  */
> #define SHA1_DIGEST_WORDS	(SHA1_DIGEST_SIZE / 4)
> #define SHA1_WORKSPACE_WORDS	16
> void sha1_init(__u32 *buf);
> void sha1_transform(__u32 *digest, const char *data, __u32 *W);
>+void sha1(const u8 *data, unsigned int len, u8 *out);

Also, the comment above needs to be updated.

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

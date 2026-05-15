Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E513FCD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NziRoAw9HSfsIxI7N4WC0v3NR/TwGKQztxd+B+F2bZg=; b=zIjVRGnr9uu50OwOicnGlq8xAw
	OazC7sVupfzwg0j5B0dg7jSofWZjqyCVwkPHutE+2lgaO/dhDTc/BNB4CPpffPLjgwOEZDLjOQx3i
	md3MEAtja9+f5C9tUcgNxuXvrqzOA01c+HyWgNNZhRwZztz+K33E8K8+Fb7uxzZWA9iOliNgXVN0f
	bde2BZH6nsG1dEhS/lwlV/7Q3C3TgfERJLk8TRkQeygEh0GC02UzGFMYrnkF1hDFx02BvMVwy6K2Y
	s4+H0BsoyclpZKExDyKRUPeHPFnQxPYmuM7HOXDg4Je2F5aclNhz0AyONWBnWHUR9y4iEt6Jno3E9
	79trydVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO2JV-00000009kjJ-0q3s;
	Fri, 15 May 2026 23:51:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO2JS-00000009kiq-2BK1
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 23:51:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8C529406CA;
	Fri, 15 May 2026 23:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE60C2BCB0;
	Fri, 15 May 2026 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778889085;
	bh=+YzNzv7+8ANMNSfpUKGBa4/M7FpU0LJIdO4rB6Fn/kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsLvklbzrw4NVy9ivGINX2a36fbGi+ygffgepGdJ5hG6qyRf8Q3nqxgS3QcinfRrB
	 e5KpYLoJhrppPPjF2+sNnfN+Mq6Lk8g7B2uZMU5EfcRk35pIXiqn92mahYDw0h5UhY
	 7+Bvclxqd2QZrPlQx1tWgTdXJN/w31+PcP+8FPYlw+ovzGBICFhpBwJIfSwEz3Ru9n
	 8+wldIff/nA144OZx1CwHzDaXKjo5SDfzdWUlTbIK5qfrrHqz2WNoJ309w6VbcEwW8
	 VgRZDrMFI0wtKR/5dZf4227iefM6Xwz7ZZgw3Hy7aj15i34hehJuUfWtvCI/DZL22X
	 OhKMaqeIAFe7A==
Date: Sat, 16 May 2026 02:51:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	iommu@lists.linux.dev, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <agexemLOag0eAiJB@kernel.org>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-2-ross.philipson@gmail.com>
 <agemXwxVb9jvAbYM@kernel.org>
 <20260515230553.GO7702@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515230553.GO7702@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_165126_587085_76AC1F5F 
X-CRM114-Status: GOOD (  12.92  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, May 15, 2026 at 08:05:53PM -0300, Jason Gunthorpe wrote:
> On Sat, May 16, 2026 at 02:03:59AM +0300, Jarkko Sakkinen wrote:
> 
> > LGTM
> > 
> > I'll hold on from actual tags up until there is some consensus with the
> > patch set.
> 
> This patch set is huge, and I know there is alot of interest now in
> DRTM.
> 
> Can we please split out and progress the TPM reorg mini-series at the
> front?

I'm not usually for "non-functional" series but in the case of D-RTM
that could stil bel a good idea.

I.e. let's iterate it through faster than the main series and get it to
the mainline before next merge window,  and then switch gears back to
the "main series".

> 
> Jason

BR, Jarkko


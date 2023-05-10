Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45D0C7EE25
	for <kexec@archiver.kernel.org>; Wed, 10 May 2023 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2219FMXMpTEqSdf70I5UmvgQHt+ujquJxs73vPTSEWk=; b=Rhu+GQ9KhGjU6D
	zFyoNInXpSeKS88FE29076iKzDTJoMiFbr1npcSHS4OdnUCuYcb4N12UFwNyK0Ox8U2ZYj4dnP4yV
	wfDw4yVmkVtsEqT1MfVg0I6eNVI2PiFouYYxHP1PjiFzZEHug0tVVb7usAEcWBFWV2JpUqfkKi2ZH
	5Oozd7QdD5kC+5zOVHSU7RcCt8DrZzKE5QNJbSDmNi0TySK2bjUATQUdi9LVZlJh7XuqTM2QDNN9c
	2y7C3exn79iOi/JW414u5JeRHwtPjnH129j/La/txgP/LRXk1oVpIDkcDlz5vGbsjtHTFQ6cxBw24
	z4//i+1ISZh6EvmcKNvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwsId-0078vw-0M;
	Wed, 10 May 2023 22:28:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwsIb-0078v0-0k
	for kexec@lists.infradead.org;
	Wed, 10 May 2023 22:28:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 44F1B63442;
	Wed, 10 May 2023 22:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5981C433D2;
	Wed, 10 May 2023 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683757719;
	bh=1W4Tchoh84C5QWw5XU02NZ4Hk4wBRIADDe2kWbFhDbg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MQrjtZE7rCyCxkaAjSFd9e5OPXIDJEZf7inGknMgUfolDQrdak7030W6sVj5Y+jvh
	 nPs/M8QHCh9gftNAXVp8cbWVnTADGxNjM/qWFGfQLuX2l9ZRJCGcYCocyyS4X5BD1a
	 enq0ve6NoQ41pHnmbnj6UWom4F7KY73uvhyriHRj/PGVQAl3D72FwRg7kBmj05J2+G
	 bYzK7oiMwvRtx3IzUpmwvyum0I8f30YOVAqVifHUixcVQj/yDZjnBH7v/QlJmf3MIb
	 F+2QBE5p/KMfgZOML7a9i627jSqnm9E1FHpLjDBUZ8pxrnKRdT1uad9C0RWk0QehBe
	 VjDvU+SMF1sfw==
Mime-Version: 1.0
Date: Thu, 11 May 2023 01:28:33 +0300
Message-Id: <CSIYAN7SXASE.34Z0FBRCENLAI@suppilovahvero>
Cc: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <dpsmith@apertussolutions.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <bp@alien8.de>, <hpa@zytor.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <luto@amacapital.net>,
 <nivedita@alum.mit.edu>, <kanth.ghatraju@oracle.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, "Ross Philipson"
 <ross.philipson@oracle.com>
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
In-Reply-To: <20230510012144.GA1851@quark.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_152841_333263_5DFFDB98 
X-CRM114-Status: GOOD (  19.73  )
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

On Wed May 10, 2023 at 4:21 AM EEST, Eric Biggers wrote:
> On Thu, May 04, 2023 at 02:50:15PM +0000, Ross Philipson wrote:
> > From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> > 
> > The SHA algorithms are necessary to measure configuration information into
> > the TPM as early as possible before using the values. This implementation
> > uses the established approach of #including the SHA libraries directly in
> > the code since the compressed kernel is not uncompressed at this point.
> > 
> > The SHA code here has its origins in the code from the main kernel:
> > 
> > commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> > 
> > That code could not be pulled directly into the setup portion of the
> > compressed kernel because of other dependencies it pulls in. The result
> > is this is a modified copy of that code that still leverages the core
> > SHA algorithms.
> > 
> > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>
> SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> now?
>
> And if you absolutely MUST use SHA-1 despite it being insecure, please at least
> don't obfuscate it by calling it simply "SHA".

AFAIK the TCG specs require for any TPM2 implementation to support both
SHA-1 and SHA-256, so this as a new feature should lock in to the
latter.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

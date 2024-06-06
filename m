Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A82C25B75
	for <kexec@archiver.kernel.org>; Thu,  6 Jun 2024 06:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3/K1meMueLgex+AXzuBlGZaTf0G/Gv09HRZLOHxKIWM=; b=NG+Y2J/Pn+7Nqy
	QwAg+DhD6ychGgylURrMTYSkVPleTbRLFGlYOObF+O1p5i+oC7o2rD1upDM9aPWqRJ7BtfaVeinL4
	XzdHw1U0oXl2ODY3LWOlBjPbBu6kA5eCsOhrLVG1oaSAGuq6zw0GDEa2HYwzmPY6YLDWrH6AAa88c
	kpmKw4h2RtizMEdwfz2mvPtS5cHZkqZITiY2t2IxKAzYlUxL22urPxB0v1pJfT46qXHAgDmDIRD3K
	P1cfPsICc+aXa4K49Fjg0BaFS1ZJFaZ+yGaA+tNxt8KXmNAx1VQEqglRhLa1S4GWc555SbgGyNqA1
	CZ9PnLFmPQcaR9wSOOhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF6Du-00000008T2B-21PD;
	Thu, 06 Jun 2024 06:03:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF6Dr-00000008T1A-164w
	for kexec@lists.infradead.org;
	Thu, 06 Jun 2024 06:03:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8C031614C0;
	Thu,  6 Jun 2024 06:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9185C2BD10;
	Thu,  6 Jun 2024 06:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717653768;
	bh=+N73ZoMcTU2eT6S1zwH3KuWbb697R2JF/05UDlnStFg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZmLynZHbI6+wxCoH1qsyPjAEaqVNs7ObvEwVHIw3vJZfJHIwRxJfcf9FU3FL6NEEi
	 g9yD4HLhAw0LoywOGsYjq7bj/p6fVvb66y+JJBELnB9P9WEGYvqEaCXlDEachSbGHA
	 FRaf5sPKiic7EiwGrHG5hgacpnqiYn4ByHic1mk3NhtPrm61IpuUiVVO4X4U7s04ud
	 GWGcjFMk85/3uLd6E8wEDOs9t3QNJ7LCJGI6cZyTTZ7CLOmIbPrLmc0PYZ3FpQL6R4
	 mmbSZBbf9uHeBP9BxtYYUfhCFOxhy9eo/RtlsfNXBCA7SAb0aoSLB7LZDYGzuDJ59Y
	 n/Am9dYvkU9Kg==
Mime-Version: 1.0
Date: Thu, 06 Jun 2024 09:02:39 +0300
Message-Id: <D1SPFVXS6FOG.IQQB3INFYEF2@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
 <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
 <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>
In-Reply-To: <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_230339_552592_1E1EB4D7 
X-CRM114-Status: GOOD (  12.71  )
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

On Wed Jun 5, 2024 at 10:03 PM EEST,  wrote:
> So I did not mean to imply that DRTM support on various 
> platforms/architectures has a short expiration date. In fact we are 
> actively working on DRTM support through the TrenchBoot project on 
> several platforms/architectures. Just a quick rundown here:
>
> Intel: Plenty of Intel platforms are vPro with TXT. It is really just 
> the lower end systems that don't have it available (like Core i3). And 
> my guess was wrong about x86s. You can find the spec on the page in the 
> following link. There is an entire subsection on SMX support on x86s and 
> the changes to the various GETSEC instruction leaves that were made to 
> make it work there (see 3.15).
>
> https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html

Happend to bump into same PDF specification and exactly the seeked
information is "3.15 SMX Changes". So just write this down to some
patch that starts adding SMX things.

Link: https://cdrdv2.intel.com/v1/dl/getContent/776648

So link and document, and other stuff above is not relevant from
upstream context, only potential maintenance burden :-)

For any architectures dig a similar fact:

1. Is not dead.
2. Will be there also in future.

Make any architecture existentially relevant for and not too much
coloring in the text that is easy to check.

It is nearing 5k lines so you should be really good with measured
facts too (not just launch) :-)

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

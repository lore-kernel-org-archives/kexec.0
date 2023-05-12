Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D778C77B7C
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7r5ptAhPQbtoiqHdFUN/SLtOTqcBNz6HW9Y+4SYAX2E=; b=32NS15LRLmHKCk
	AP5WsaYDi3CiyjNnrLEW5zZ5BKdp8QTGgt87NfFGPsNOZhLMbRsymvGyr+yEkf6ZBTidg9J977s3E
	bzxz8pfmbAFQW2CnjLnvkHJzUSK7s0uMiz8JyD2r+1jYN7vN4FpzAQfOtCrTBMVuzp/I4nUULDXEQ
	EjZgac4eXcGyCsyuKJe/L3RQRJOLIx+RQPQvtGnE0ewYIiw632tWcI0NbQmQxgDBZrfgaVwL/U7Cd
	eNT94byFuq8xxUMu68fhKUofw56KjctzOEqjIk8kb0/3kaDsLW9nd9rdyVb4HV+pkjm/+nksE3Yee
	OF8WKYRtieYHAvOuKH9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQRK-00Bi1B-2L;
	Fri, 12 May 2023 10:55:58 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQRH-00Bi0R-2x
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 10:55:57 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 39D4242527; Fri, 12 May 2023 11:55:54 +0100 (BST)
Date: Fri, 12 May 2023 11:55:54 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Message-ID: <20230512105554.GB14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-5-ross.philipson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_035556_079466_13EC9947 
X-CRM114-Status: GOOD (  10.75  )
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

On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:

> +#define SLR_TABLE_MAGIC		0x4452544d

From convention I'd expect this to be 0x534c5254, but not really an 
issue.

> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID	0
> +#define SLR_BOOTLOADER_GRUB	1

Oof. Having the kernel know about bootloaders has not worked out super 
well for us in the past. If someone writes a new bootloader, are they 
unable to Secure Launch any existing kernels? The pragmatic thing for 
them to do would be to just pretend they're grub, which kind of defeats 
the point of having this definition...

> +} __packed;

Random nit - why are they all packed? Are there circumstances where two 
pieces of code with different assumptions about alignment will be 
looking at a single instance of a table? It doesn't seem likely we're 
going to be doing DRTM in a 32-bit firmware environment while launching 
a 64-bit kernel?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

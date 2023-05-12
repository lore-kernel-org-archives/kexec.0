Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D82C77B75
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tv1hKHBZ6y3tUrSH9wogrz0Tn6g8QU/V0HlwHfiNIQA=; b=ZumN9WAIe1vb0M
	amdNbCPXnZnY1zEg/DVVfv5Ns+88Tg/4ztd0UGWqoy9YUuS9QZxb4Njv5KaqUYb8ZfFy1aLbVJOo3
	M5KEbgyIIogA982p+Lk7I15zL627L0mRfVsjvHmsbSuwXLj4rRmgGQDIvNYve616A9Mp3jL5yp9xn
	nIAUBLDQ5bkpvL2Uq6ylfyY8plg7g0uQ3/8IOTyi+MOyoDAdIUu7I0Av0Q8s/mMz1pyEDy4qnECcv
	+lFxhdwVhcCFxezUE4CMpG/PFfly26yyhi26t4/tiPnz6rPRYdHq5b3LfhyQMykgReqU+5iyvWCX0
	o9GeVKjawXGIgSKgPZQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxVc1-00CU5F-0I;
	Fri, 12 May 2023 16:27:21 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxVbx-00CU3m-34
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 16:27:19 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id B2FD340A6F; Fri, 12 May 2023 17:27:12 +0100 (BST)
Date: Fri, 12 May 2023 17:27:12 +0100
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
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Message-ID: <20230512162712.GB18400@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <20230512112623.GE14461@srcf.ucam.org>
 <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_092718_118223_C8CB09EE 
X-CRM114-Status: UNSURE (   9.29  )
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

On Fri, May 12, 2023 at 12:17:50PM -0400, Ross Philipson wrote:

> I am not 100% sure what you are asking but we also measure the EFI memory
> map. This comment is just to note that if the e820 exceeded the space in the
> fixed map in boot parameters, we would pick up any extra entries when
> measuring the setup_data list.

Ack, picked this up in a later patch but didn't come back to follow up. 
Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

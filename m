Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A25C77B75
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fOsrIWadhPkN1HKVUwAl9xt9ToDwkHVNKpaXU7zIYBg=; b=kxkYnc0ibns/qU
	jbmmvlbFSZJ3Bu/fvVhyvIFaikWetQe0zOM6JCcuuPLCS+XLHw/rz+jl9/XGkzyCSRPFcWZNcVTJR
	GBl9TLMjgkmohBGZ/G0qLihj80J4bc8PW/jGaz0oDjsZQsdt8oNz2qeExjBa66sVzKYwhgiYVjMGr
	3eShi3KUiXTBykbreVe1hvKLQboabhQms6b8unMiMU64/hW5qfyQSneUUKiBzA7GTy65XCf0a7bd7
	SxotoFIk2UZw9EB1ZubhKLQy6tizYb/2xmmZKMFxBzELFbfTvX4FaNxzYJth8xMldszdclxVY9P0v
	9qA3Mp1Hfn4OQJA5Zuow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQJj-00Bguz-0J;
	Fri, 12 May 2023 10:48:07 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQJh-00Bgrt-0O
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 10:48:06 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 3B95440A6F; Fri, 12 May 2023 11:47:53 +0100 (BST)
Date: Fri, 12 May 2023 11:47:53 +0100
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
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <20230512104753.GA14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-3-ross.philipson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_034805_286192_308DDA4C 
X-CRM114-Status: UNSURE (   9.13  )
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

On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
> +built with KASLR disabled::

Why does Secure Launch not interoperate with KASLR?

Re: IOMMUs

> +It is recommended that no other command line options should be set to override
> +the defaults above.

What happens if they are? Does doing so change the security posture of 
the system? If so, will the measurements be different in a way that 
demonstrates the system is in an insecure state?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF906C7EE24
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kWzg9sQmYh/6O5cTQsljAKmejZW8TNgDjFqwCcfT/0k=; b=ERtnpaF3KFk/a5
	i5kG39SlTpNu5jNLD9znvOPUV1+55RZY1djum/CDPqq0r+COh+lYbM7213p0suMytDtFVl0HH1GTi
	LjwSLJ75FInJt/kLeZCTNKRPGtWkqvGE5Q9FVeS45D/id55WcYWnhBAhXcalPFGXPoZrufQh40Pmy
	WYZRMeh4r5OM5OA8rixLDyM/XZmSRl4PRj75QJpoNZTcBjAfMyFA6/qKfdn72sfO50hENRMJZqip+
	8lMUVXNcE4z073Hlz+W/7+0n8xUdry5eA2UE2vM/fbpAfYXjlNgY7EqI34oNSu459ul82AMQD5bIj
	fJB91lzGItLB305kv09g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxR80-00BqIl-2A;
	Fri, 12 May 2023 11:40:04 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxR7x-00BqHw-2S
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 11:40:02 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 1D9DF40A6F; Fri, 12 May 2023 12:40:00 +0100 (BST)
Date: Fri, 12 May 2023 12:40:00 +0100
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
Subject: Re: [PATCH v6 11/14] reboot: Secure Launch SEXIT support on reboot
 paths
Message-ID: <20230512114000.GG14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-12-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-12-ross.philipson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_044001_924557_66993808 
X-CRM114-Status: GOOD (  10.53  )
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

On Thu, May 04, 2023 at 02:50:20PM +0000, Ross Philipson wrote:
> If the MLE kernel is being powered off, rebooted or halted,
> then SEXIT must be called. Note that the SEXIT GETSEC leaf
> can only be called after a machine_shutdown() has been done on
> these paths. The machine_shutdown() is not called on a few paths
> like when poweroff action does not have a poweroff callback (into
> ACPI code) or when an emergency reset is done. In these cases,
> just the TXT registers are finalized but SEXIT is skipped.

What are the consequences of SEXIT not being called, and why is it ok to 
skip it in these circumstances?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

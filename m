Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C653CC77B7C
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NE9OAIQjh7SMMj9v7fpKvNOeaeQl92eaixTbjLHrNFg=; b=E9B51fJdsWOmdD
	W3tn5eqbTDqeRHOga1Z66XTm/6KR0X5hIAWPC4LnkDbJT9YaCa74wF/OiSLcFnQQaC7fDazmt9p4u
	tVqjt21RITwn1z22DEiT1v4613+2kk1Fkv0m6D/TDclEmpXHe9bYTCMPXg2ZXSECDETQ4fxeKF4IK
	0UYHxXPSDpj70TbU5ExWx2r+Etfe1tYyDR50ASiYZZvE6aZQwXkq/xfYwEAO2i/5d4zgZaM3OZKJI
	KVs4v7rYntOPMp0eKqpu3ClCQ0q/Oi1NMMFBZV0aDjscdeydMXjl6vnyx3YEWb6MhwZya/ka5Yu6i
	pCjiQwy6p5kYaB7vdWvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQa3-00BjKF-2Y;
	Fri, 12 May 2023 11:04:59 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQa0-00BjJN-35
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 11:04:58 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 664F140A6F; Fri, 12 May 2023 12:04:55 +0100 (BST)
Date: Fri, 12 May 2023 12:04:55 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20230512110455.GD14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230510012144.GA1851@quark.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_040457_121018_D39F91BE 
X-CRM114-Status: UNSURE (   8.14  )
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

On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:

> SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> now?

TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also 
at the whim of the firmware in terms of whether the SHA-2 banks are 
enabled. But even if the SHA-2 banks are enabled, if you suddenly stop 
extending the SHA-1 banks, a malicious actor can later turn up and 
extend whatever they want into them and present a SHA-1-only 
attestation. Ideally whatever is handling that attestation should know 
whether or not to expect an attestation with SHA-2, but the easiest way 
to maintain security is to always extend all banks.
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

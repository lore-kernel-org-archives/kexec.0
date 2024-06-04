Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB051C27C52
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 19:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+EBXAQYfli1iOgWhbq0elOGxuIOKGh1wPXbzzu/X6vI=; b=yW6MwuqiSvHnTV
	wvzA3KcSlduh1EGZRq7HYJDRO+xwVNp+aWt1S17oI2nINDb1hAS82LBQaolYG451LLtFtuklj+ZXT
	PQBB2H0Y+7+DI8UyjEm+PbgkKak13i2E97aSGwjTM907eBnrh6GlTwGnGb6GugTT34Gdz4la7qK9G
	B1wlih0s7EiCZDYF60UC3b5TmHcGqIukdF2lRv5AgA3czDxUjaGWWKmbUG0WBAv6vUVo/YtYc6GAe
	QovUZ5WMqnKykutT+qhg1qf/j/P/qkRtt8lvIoOCawasz5TXbZEoz0dAlRmiZ0hVyPM2+vkv1NLdP
	Eij4fGyGcQBJLDnf4j1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaIh-00000003eh6-1E33;
	Tue, 04 Jun 2024 19:58:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaIf-00000003egG-09uj
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 19:58:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9D62F61255;
	Tue,  4 Jun 2024 19:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0E6C2BBFC;
	Tue,  4 Jun 2024 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531107;
	bh=EdXREgrUFbhjr5J9t9xfAPvnQcvPhKQ1IC5dTo+Axkg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=n8SKDzmdRAxmg/cdodk0J19d2WNc3XJ8TNLT2QE1Wnss24vGwthUtE4wxphTxOnBI
	 7EiS2dyoKsrcu5VjuCibb4F7u0poTQqvPefUSPhWQRefKgIsY1p/p6/1gWHyJzW6cB
	 L5jka2UwpQMtdF8SmaJeWiNCz8Pq/5Uxj4OpFCpMsHZBTtLSib52BLbff5DWT9+YE0
	 ulAtWhzBRdPzRzapJRSs5rCZ9ADYWpT6dQB8YcMq95qUY6EBIyMeEwoKwLasS+NX7N
	 T7wAy+5TFRHb/A444x+5RHSozYN8O6dptYC4gXpbR/qx6lIx8KQ1mNZqHivZPDqXmx
	 vcSGHh+M/fpYg==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 22:58:19 +0300
Message-Id: <D1RHYMFSVGSW.39IL7KFK8A47N@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-10-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_125829_227954_42606634 
X-CRM114-Status: UNSURE (   5.10  )
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

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch()
> routine during early kernel boot. After determining what platform is
> present, various operations specific to that platform occur. This
> includes finalizing setting for the platform late launch and verifying
> that memory protections are in place.

"memory protections" is not too helpful tbh.

Better to describe very briefly the VT-d usage.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

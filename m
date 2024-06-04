Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39062C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K4qi7R+GY3ZhgxOz4mWF2kPMRBl9UHw4k/BabVOiO4E=; b=wBlzgeIaYG71Ku
	ohqpmptbVifh9cF4ljhPMcdpQpgHZKRFd02PzL2/dMMZSJ4vhULlESnVQ1eHhtWLb2toxeCzff6HU
	E12tk0eF5GL6UNzrCM0OzfpOYY0MRWJm9nVXVPXGou7k5pwADTdyAwKdrs9Gu+vEB7CENL5hiSYN2
	rG9u68MQOs74o8dVlZFpH5fFVU+GTI1JEJ8jzhOJE+zJZHmqAEf93qOpjV3V4+0UXhlnwC+RBwAp5
	S/Wa/GmWnvbXor0cxUZAx8HxFNtnfceOY7mUfYUCkZQ0wICoYGjmygPHWmVEgv55nfoKE/P8HsLKv
	O9yTWY0eGWUOzMaFx6ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYmu-00000003RMC-3Cgc;
	Tue, 04 Jun 2024 18:21:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYmr-00000003RKy-3uTu
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 18:21:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 289B361408;
	Tue,  4 Jun 2024 18:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05055C2BBFC;
	Tue,  4 Jun 2024 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525292;
	bh=rJen4p/W7Qw4c91Xr9BpGnLPEjJLClcQzjp1Wn6mzUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jImRPbGPC31H3Lp5sDakUcWNcoHmB1MSC8DZsrgV4n4jN8IRnrKQN9FNSGA+F666V
	 ixNdbhn5DqJdm5jlYRGVpYwtyWwFT1R5NGqAgJ4c4dWV9ce4Aw3wlT0CGDrdqU91gY
	 2+SIqS5xZGyKN1Oi4WurYpYLnlLKubqE9we2LEL7GMTYRezo7XmT078tfQ1n24Sto5
	 bn+3T9AII3RuOHzXf1l8M9F+1wKLINvwAyzmHlxz6PQeBJ2zTDxvouJRXIaBYXs5ya
	 NKO7D8Uhz/+o8s4tIoiA6n2EMXU3TmqFLMGeQ5gpgr8bsfN/dAlEWc9gIsakqS6dW/
	 Qb3MFnYgR6ONw==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 21:21:25 +0300
Message-Id: <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
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
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-5-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_112134_039688_063D0C4F 
X-CRM114-Status: UNSURE (   4.91  )
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
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

If a uarch specific, I'd appreciate Intel SDM reference here so that I
can look it up and compare. Like in section granularity.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

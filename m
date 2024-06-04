Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C37DC25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7OLOeXPBMZrYAXPugYIF51fjH3ukVV3YAUlzITI4V5Q=; b=27TO3RpdPM/Kzl
	s1DjWnlZxwPeNnMyhLLvzV5CE6kNmtaTdRbofopvdGRgaIXVwlS8tORQfD3K+bQ+C8I3gTbrbNjDk
	qUDQrdqBogm+I+qe3CmPeYJOgSgMu6xIwmvntAWxO5pMuRX5TEh1pwj4WTErpHrPxWWzSPI/zb/fM
	A7PEQN8OZeA+iYocBtAg5a/PNTKaTRN9bTfLNWfgLEBZCg8tEz1Fg/ushb8DM6v6TGq+vlorrT3eu
	XWEXu6YKBSC25l0Ow0xAFnC9eZadP00+aXO9WNdIR5iUl4Q7rsaJhXA+CN5r+IYrXGhs2IXOLP045
	0geiVeOabRWQq6M7iAAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcvg-0000000469x-2SJB;
	Tue, 04 Jun 2024 22:46:56 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcvd-0000000468s-0r5e
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 22:46:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E0596CE0D92;
	Tue,  4 Jun 2024 22:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F9FC2BBFC;
	Tue,  4 Jun 2024 22:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541210;
	bh=ObbnLVomG7LC8630jJzSGjNJGO+w2KG9eNNPYANJnj0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k/M4pTAMFdu5Hv+tECjoZbb2qx5QG85dWrdxlikREB1N4Yrkfra+Xt/4tBwy9jBrN
	 6gvscFO/m0b46P3kR6b/x3NOD7+4Xw2JYwmG7UCgDzJJHNWonTsNyGxrVuP5VDgP+6
	 rvhBAAbSyJQHdIGWFSFstEqyRv0/W4twBgMFw/YVkcOYuuRqm9eSMKr4g29pIuZLSL
	 95ZyNhwUbmCgFG2JWqyOR7dzFKM3H3ydjE2eoZPt8JHOUNfskKNnOEFy9lPJ2L39D8
	 j7IkkqQEz8oaHIIrfa/bwaMpP6VT1SkuDa7wrMYbZHIa1VM0Mcj2kLboXvwaw+Ddir
	 K0tjSsn1vSETA==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 01:46:42 +0300
Message-Id: <D1RLJJY17T2J.I1BP34BUK2AS@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 10/19] x86: Secure Launch SMP bringup support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-11-ross.philipson@oracle.com>
 <D1RI46IG5GSA.17H7M0DIQGRQ0@kernel.org>
 <d95d73d2-c728-4da2-b68e-d2e39a518ae6@oracle.com>
In-Reply-To: <d95d73d2-c728-4da2-b68e-d2e39a518ae6@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_154653_476300_BF73BB29 
X-CRM114-Status: UNSURE (   6.23  )
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

On Wed Jun 5, 2024 at 12:47 AM EEST,  wrote:
> > static inline bool slaunch_is_txt_launch(void)
> > {
> > 	u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
> > 
> > 	return slaunch_get_flags() & mask == mask;
> > }
>
> Actually I think I can take your suggested change and move this function 
> to the main header files since this check is done elsewhere. And later I 
> can make others like slaunch_is_skinit_launch(). Thanks.

Yep, makes sense to me.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

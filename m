Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBECE677EF
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JyZxbGrVayBQ81IkgbPV8eWVLzlKAKl1krICjHSl0yI=; b=Gu7AFE8ccC9Ew4
	Kn35HCBskydY1EYiNOWsrR+qoaIFX5/wy0w94NX7DrB/I7C5xrgYDUkiC4m4S31By3nLBDqebzXyC
	dmmuDG+FqlQw2q/fGazc3uq0nfdvYtEYIh1mTb+oJHk7xs4q5hSz8GnMdwexdViWnccDst7Z3EWID
	WGbj9It71zXibVj77G5oQLIHQcv8w7IlGH14OmYFtjRMDIlblEw4BRGXdUUdgkwnyJbRgrVqyjNzX
	NSb/M2wLbbflVymOz3+/LJwHGITRxCm+K7TOF8sA/2ocodJd32TaB1C6HQHO1ZUGbOBuK4YxD8K15
	Hghoz+bvnmXn+H7OdO+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7EiW-00000009p9J-0jws;
	Sat, 02 Nov 2024 14:03:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7EiT-00000009p8G-0wsf
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 14:03:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 87CFAA40183;
	Sat,  2 Nov 2024 14:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F357BC4CEC3;
	Sat,  2 Nov 2024 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730556179;
	bh=ZLS8k2hCcSrDj/7M9xiZ525QVQIkvt4SYg63pY+uces=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=OL76AlXppOEgaPLRvOdzPtX1KYy7U2H6tK9emSQRGpBH4CwmwnLeWOf6ww3LIxQVJ
	 9uvAptu3mlOSnkkJaDa4S8mFBUjj526MSluXQHiHpoAVtT35/1w90Z+jpfbGQtWW6i
	 ug9Rmz/4odjf7FZjByk8xIr/59oKhBkhK45heHo9vpneXu5IE3H1QzPkwTQEuFXogk
	 ZI54GIf88ujwbVT7tF7vome8H5biZjIJsZvkS8Vj6VoyngXiRPeS1BYrhFwotXFr9q
	 Vf1d9YyaQx8qhS97yUHqqP1RyS9ZuWiDCQs2O4/GrSKhx+5nURvSiLMeulEWXvYu4g
	 AbH2S0NN5vpGA==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 16:02:55 +0200
Message-Id: <D5BQYRP5BCGN.27P7RQRRUIYSS@kernel.org>
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
Subject: Re: [PATCH v11 15/20] tpm: Ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-16-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-16-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_070301_350345_4E94A590 
X-CRM114-Status: UNSURE (   7.32  )
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

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> When tis_tis_core initializes, it assumes all localities are closed. There
> are cases when this may not be the case. This commit addresses this by
> ensuring all localities are closed before initializing begins.

Replace with:

"tpm_tis: Close all localities to ensure D-RTM compatibility

There are environments, for example, those that comply with the TCG D-RTM
specification that requires the TPM to be left in locality 2. Prepare
kernel for such environments by closing all the localities."

Please don't do anything to the code change (despite my one random
earlier comment).

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DA7C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 22:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jAaxXvUXQh896X8hpuDkx126epC+iEQQbCgRYomDNgA=; b=IRPQZlF88dwNL+
	hmjsH1AN+rgBelMLHvQ5M0Hg9zAsjBX03lwNuCbdLpvui+5W59QA2ytnEh2qOa0HTChtk/H+1bJ+8
	YCI5C6KvaANiT8MWmusQ3s7fF4ow8W6F7oxEpGl5baXBrHUfO04zB5XzbCe2Z6VJksrUYUOz2PG7H
	2CoLlPyS8j/4rjMK7nK31sJY0Urf5OwIDr6Lh949gw9oZvMkUUJ1ZFkz7EUXxDMDdz8uSAsZEfMn6
	XG3u+c/+u2Ij4fQ9RQvHwOkvxrHOFNBjl6/aY4OJSnJv8YmtoHEltzxZVJ3DwyvdBs1aXN9XlkwFW
	mBl8IvafWRlg9UDiFLiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEclf-000000044UN-3qcm;
	Tue, 04 Jun 2024 22:36:35 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEclb-000000044T0-3ZqY
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 22:36:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 05175CE1367;
	Tue,  4 Jun 2024 22:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7037C2BBFC;
	Tue,  4 Jun 2024 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540589;
	bh=vkh29LcZuA4Sz0xUo0Giq6q/HmkTXs9ahlbNzKVYxng=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Wa1jwYWe1gDKB/JcdKkJd5eqvpX/bLh954mEJEiY5sfp1Jsl9BzcS7gIADAcpRFQ8
	 5b2Z+KR0PO7iC+UefSD+nWYWgv5dim7w3OceDBruFV/tyaWv7LDlGrITfKmLGoAM6a
	 57yxX26az1npx87W6+VsZxy1l3ruChkkm4Pzk7eYQK0dOcyeNIoegwdV1vps+HxRSO
	 FcPOpucMgOCpo9fUxHYSbyfugusoq5loIrWUAewdkYAUpoUYvEe7Kv6HTcEuWk8TxF
	 QgIqjzR2Sq65KRa0Piil1C789ZsmBR+bfL1YZBun7IlsuINQyGQLIitVySKAf4bAbN
	 puw6F6rCHqlBg==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 01:36:22 +0300
Message-Id: <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
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
In-Reply-To: <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_153632_305171_B8B70601 
X-CRM114-Status: GOOD (  12.54  )
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

On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> Introduce the Secure Launch Resource Table which forms the formal
> >> interface between the pre and post launch code.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > 
> > If a uarch specific, I'd appreciate Intel SDM reference here so that I
> > can look it up and compare. Like in section granularity.
>
> This table is meant to not be architecture specific though it can 
> contain architecture specific sub-entities. E.g. there is a TXT specific 
> table and in the future there will be an AMD and ARM one (and hopefully 
> some others). I hope that addresses what you are pointing out or maybe I 
> don't fully understand what you mean here...

At least Intel SDM has a definition of any possible architecture
specific data structure. It is handy to also have this available
in inline comment for any possible such structure pointing out the
section where it is defined.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

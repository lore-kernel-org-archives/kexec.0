Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8470E6F092
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tR+QBk7hfa7RlnNnYTwRyAohqol9I1Ge1U4wmRwhEAQ=; b=O4hVm9EuXhPhIs
	7OfDMRfCQDRsxKK3gylDtTykJ78jru02r8DVJBDKSGgZkMu+Es8JQfpGR0ZxO2J8SffPVBF85RvsU
	B4kJpBHDZWtixJwBn/Q/qft05Vdx5F8v7hevtytNjncv2pV9bo9uaIDwU3exAqGFvg7S0DcSFYoQV
	v/bKzAAYRBN8Rspuhjztt2eFzfiOjbVXSdlS7q6XQ4R3kkvnMBOp6GMbr/d99FSpuBLD76dcvSUqG
	aw4eyGqDSwpPg9hsZgk1/7eWJwzqnbUnXVgA2TtquB3b5E27InwaLhMwQSgaoiS+AKHRdzV894WfU
	TTgh05VuL+8cfzVBhQBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zX3-00000008Osb-2RZq;
	Fri, 01 Nov 2024 21:50:13 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zX1-00000008Or1-0Lv4
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 21:50:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8A6E1A44DE6;
	Fri,  1 Nov 2024 21:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1406AC4CECD;
	Fri,  1 Nov 2024 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730497809;
	bh=KEMzaKGo3anPlxd3W6Jufkxyiqrz0Fn3Kr0IoeQ02K4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UWcBm+Xpl3DlVCGQvVDnSl9k2SmTDdR0uxFOt2euozsCGAqRdZKyXvLnDTJfRW925
	 x9/vMH6AjJvjF+Qak0qjfHiUes4mKkaAMHQYoVUROVmXM5Hr3mmxnja4R5D7mACU2w
	 cW7LSmFhm2JnXt32AxHF0n3LgUyIk/4nE+l0JXyvScKlTbFwobSpbRH3HwPhB8uYAa
	 c2RozITzQlxydytXz18BwrCWnrmBlhA9PXwqKsFqyC0p2hf+53Qcmhl+LUiuUpy3bp
	 QTFnT+QCPtEQ5sr7ni4fh+2ldDghLhrXtlaBK87wxznb4EZuJWk5ESN1iMSe6KBAFz
	 YFrDxBo6CDv+g==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 23:50:05 +0200
Message-Id: <D5B69X48SFO7.RMZ1I1926BPF@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and
 querying the default locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-19-ross.philipson@oracle.com>
 <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>
In-Reply-To: <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_145011_202284_37FC5893 
X-CRM114-Status: UNSURE (   9.05  )
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

On Fri Nov 1, 2024 at 12:06 PM EET, Jarkko Sakkinen wrote:
> On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> > Expose a sysfs interface to allow user mode to set and query the default
> > locality set for the TPM chip.
> >
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>
> Must be read-only. Should be decided per power cycle.

I'm throwing one incomplete idea not all things considered...

So one idea is would be to apply set operation to /dev/tpm0 as ioctl
(would not be available for /dev/tpmrm0).

Then at least access control rules would apply.

The open here is that the IMA etc. will use a different locality during
boot-time, like it would also with sysfs attribute.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

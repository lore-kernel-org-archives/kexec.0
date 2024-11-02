Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F0E6F09A
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 01:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w3yrv7puiJBb6xJRcI8+NLqTa4mrQqLYPb/PTN2mPdQ=; b=3OJtWtnvs6Vad0
	zZKO+2SVbq1fwRWdaYPNinNPuk8uYbdQULGsckSJy+QSjjHJyOIFXF8cFN6kYdosg99BMLDVcjLGw
	aEgstFkVCpRaYO+JAR8fEsxgd2zX8zj0sGRFBpozhP6/lR91d9I9NRDu83k3SakV1/CGVBrmrpY/A
	aunIJwr2Ak31Cvuh7nWBKEXLRunkoflNSbUML1M9JdSKxtADrXgl/qK6gJdIgs0LsRDlh3K6Q/Wry
	jDFqi1rExPwV2CS47zDmVm07b7YWLAtk8+FDFrnU9zY+2gJrwZ2ZE86DQv+ZKCDWpdcwuCxL4cinh
	30shdlcDHdQdV2IaXuqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t736w-00000008pU1-40R9;
	Sat, 02 Nov 2024 01:39:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t736u-00000008pT7-0xh1
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 01:39:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3CF5C5C55F2;
	Sat,  2 Nov 2024 01:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3256AC4CECD;
	Sat,  2 Nov 2024 01:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730511566;
	bh=IaQl3xXmqIlGoa3l2q44Qr4bCwT9TUCnkQYdd7ZyWj8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EvhPienQsr02gNyzBolx1UhCJ1qhimKmTyH8tA5JP3/dkX+EovpwLa10jl07kvICq
	 KpjNiRsz5REVf64QX57lOuT87MNvpT5g5w6ffxRJyyjmVDpY6cx7XeCGLV7CysMFvC
	 6i5LijMVHR3jTYdYodnQ6JGKQwo3kWdWKkJJ6M1GSfUKXaiqlikzWWiMUMbGnJgLWY
	 ltTyzV5iKNMLr50jdOGeUr5p47Mt+AiPwQHmRp+7k++aOyeMHbe3snlraOgayvuE0V
	 CtDIMGLaLyzX6DxAVngENUmyJsjNyLd8ANfd0St0wbfWjF03CtcrVd+smY/rs6q2YI
	 /bFbtGlgGYLEg==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 03:39:22 +0200
Message-Id: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
Cc: <James.Bottomley@hansenpartnership.com>, <andrew.cooper3@citrix.com>,
 <ardb@kernel.org>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>,
 <dpsmith@apertussolutions.com>, <dwmw2@infradead.org>,
 <ebiederm@xmission.com>, <herbert@gondor.apana.org.au>, <hpa@zytor.com>,
 <iommu@lists.linux-foundation.org>, <kanth.ghatraju@oracle.com>,
 <kexec@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <luto@amacapital.net>, <mingo@redhat.com>, <mjg59@srcf.ucam.org>,
 <nivedita@alum.mit.edu>, <tglx@linutronix.de>,
 <trenchboot-devel@googlegroups.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <ross.philipson@oracle.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-18-ross.philipson@oracle.com>
 <20241102013716.1036396-1-jarkko@kernel.org>
In-Reply-To: <20241102013716.1036396-1-jarkko@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_183928_417737_09EA0097 
X-CRM114-Status: UNSURE (   8.01  )
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

On Sat Nov 2, 2024 at 3:37 AM EET, Jarkko Sakkinen wrote:
> DRTM needs to be able to set the locality used by kernel. Provide
> TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
> the kernel command-line has 'tpm.set_locality_enabled=1'. The operation
> is one-shot allowed only for tpm_tis for the moment.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I hope you could take it from there if this works for you in the big
pic, and address possible comments, thanks.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

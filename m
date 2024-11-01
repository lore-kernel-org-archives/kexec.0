Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7709AE6F063
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 14:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pMT5lMVhIVppJwD9jH7BYswFWMekMhQSwic8Wl0gC0g=; b=RIPL3KD2TgjVFs
	1Ox0NJN7rOjtRhpVyVXMhrstwScga1DFsyoLbCKpp7v7y6Uu0bQS/gokXlpEplPy19pNFrSyBOj2d
	CSLW7Oi4yruzjkgA5cyTR1Vq/e06dB7fhNg8+acp2VhRGbijXfYKwE4G0KQTYbmg6jS72As6IXNgr
	jn4YKsENt2B5RgaXQERC/cjeAC9m27RB4B59+IOsdKWixsuKAOnPjgszsniCvmncVhAVrVoJFXBu5
	czX40dEbH3LFV1h5Ox5oyfBga7pegH1SyszK8FCZOFqoJOpN8VzmBqgnnnwwKGcgqWghhvR5t1gAe
	1atADTkdY1FHrQRx390A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sTK-00000007Ilt-0WqL;
	Fri, 01 Nov 2024 14:17:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s7e-00000007FTw-3kM1
	for kexec@bombadil.infradead.org;
	Fri, 01 Nov 2024 13:55:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:References:From:Subject:Cc
	:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=j7rq1zckz0jJJuh+oXSHsEBtqOr5Q1izk3adIndgVqA=; b=MWt/0gh8NuTn1ZY67YRlxjURKf
	xag7H0xmhD2dZagJTtB629gfpafEDRkWvXXJn1BicwZ7EN12PJ1MCTXgcrvOrj2m3o6ahPyJOY3c6
	nLelRo+HMUPDx85mPY25JqIknNsJTZplhI8H0InnE5UnEVmEDVZeDr1bcBOta8qXfr2KCC/pKLclO
	1YndCuI9eJZaX618SnmqnxH+JUbB73QBIAQTlxZfgQLa92m+ZQ1Omc98QIujZtsMJhIr7pNUaR8Kp
	3ZX0owDS3szec2YKF4ju+N7Gku0jHAymv8udK3AC6AbuM4Tc4WpLgLREbNavqtMlfJtRDzd/LU9Re
	84VNDGqA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s7b-0000000AiN6-2ttJ
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 13:55:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0875C5CC846;
	Fri,  1 Nov 2024 10:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7494C4CECF;
	Fri,  1 Nov 2024 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455603;
	bh=j7rq1zckz0jJJuh+oXSHsEBtqOr5Q1izk3adIndgVqA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=GlaL8xIAQtARK/uThgcYxUBBAZrNlqE0XT2UPbieKeJaPjS2CWn0J1JIVx+jFSYJV
	 TD5knnHxU5Jl+JEjgc9RBTSbxbC4eXuEcB+8F0k/zByVRZRZ0j5ZYF+ZNVWcV+Q7K9
	 rW5+7uQgBGas2ZKTSRrZQxBkpA0wOMTJd99FzYE8lpTne6RkQG4ZqEp7WOzuLkccOZ
	 m+Qq3e/5QXptVHJ60VpFGyeJmqUIp0ibwCCr2qslBuSt/ohTiZvQ891TOSNRhmgSlt
	 +J4hyJMzNNO5SmmNdieN24oiW0GaPZzW3O93bwZ4hNlJDHdzoJss7CrE9lDkdLYnH3
	 gSE6hvYJgDu1g==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 12:06:39 +0200
Message-Id: <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>
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
Subject: Re: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and
 querying the default locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-19-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-19-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_135527_914291_46CBF857 
X-CRM114-Status: UNSURE (   5.56  )
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
> Expose a sysfs interface to allow user mode to set and query the default
> locality set for the TPM chip.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Must be read-only. Should be decided per power cycle.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

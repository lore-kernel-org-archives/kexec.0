Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796C8C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 22:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n/5WNqn48Zxv6+lkPivlD7rK312cxG0mayBkRVdL6Qs=; b=NYyBJlhKJS1tey
	rCR3phoWfMGWWTdWkLSWK6agTikD053UhkPei3mO7ON49TaUWDDu118HrVd45Amb2VZmCZI/hdWjY
	p1CCmXa2cZ1LhtUs6HOVu/M6XTh1McqNdJQjFtS75qSYnurxJPufZtgLfjK0DlonEwGu9YlnbK9BN
	OawJ4kiXRqzmBSxmyFh+ltmemlw0TMMaouoYiNrgtu/PEwnOO/vyz30YgwrY+IOeDxWto9oMBFpKy
	PdLejShs5lpBqnPTUXGtqSG3WhS0t2YgfMYWnCwvp9Mf9rc64u8FJ/qnqfv3r/ZTySTXMZlERGIWJ
	tT6wGwPGB9ApwsSsewWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcsc-000000045Y3-2qjZ;
	Tue, 04 Jun 2024 22:43:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcsY-000000045Ws-3wiP
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 22:43:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1F80F614E7;
	Tue,  4 Jun 2024 22:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA590C2BBFC;
	Tue,  4 Jun 2024 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541021;
	bh=Gvkfp5YbJwML1P1XHALdTu+UlMk812IdrdYozmeU+R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9vMEgfymZiMHowJPK0j6PGnB4K8NiMVfmeC5CboYCxP4VQiCLtom6Bh3LGBUMGv2
	 RJYIUtTdCGtmGvwIEoZ5W3VGKDeMauC1Plp4BeHnilMFU0u4qtt8xJdpTJdYTu8Wem
	 3Q7k1fhtOTW3HcMO6VNZylFS3AhvFtv+ke3kt9hy4wyKOacVXfU7w4i3DY/0w5uHS/
	 lheegCWh9BSlWj52kUQD2plb2avqcjLDF6G958ch3TQwzwc2062ybktk6reSnYIVRP
	 RMZIuot6TzcVOOZ5t0RExBJo9ZZzZF6/XwCYxa4vLSLe1kjTIQIrEN+1djb3HXXFFM
	 J3AtNbhAAyKAQ==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 01:43:34 +0300
Message-Id: <D1RLH5CJJ2NA.33QHHJNR5IZ41@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com>
 <D1RHWYUN14C0.34HJBW7BI3CIV@kernel.org>
 <e5287d8c-58ec-4f24-b27f-f8de688931d6@oracle.com>
In-Reply-To: <e5287d8c-58ec-4f24-b27f-f8de688931d6@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_154343_292270_50CF7A57 
X-CRM114-Status: UNSURE (   2.62  )
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

> > s/tpm20/tpm2/
>
> Reasonable. We can change it.

For the sake of consistency. Anywhere else where we have code using TPM,
either "tpm_" or "tpm2_" is used.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

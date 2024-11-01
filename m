Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2783CE6F060
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WprMcPX0NbGQMMeKyhQMDqKhg6ZoWE/D2Y8PGeFuB0Y=; b=EttrJZS3GOUoRV
	To4b1i7rLi7Q1diNqQl6S2uZ1sijXekr057CMseYGDJir4fCsD3Bq20f0+eweQtYMEfVL1PtaC8dN
	IAXs6yDK68XqIkwbv74atT1UcNEHJf48tCLmiLjhH3C07ZtHN5EdzzN0319JkAeX02h3pnhTgqWjn
	+xdSsd2vufWHql8I5UFycZPaopcKMwRTHhB0UUhzOy8aUNaIT72ByklGqLex/bQmrSkHfT1zkRfGj
	ihSB+8OcR1YjYBffg5TPDjr96EZyavw5mAUewGHYj9cqDMNv++ueu6eXo7/lsoDLxuHAjoJdkOyWh
	Qg2aqUiTy3+NkluY3gZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sWZ-00000007JER-2tgV;
	Fri, 01 Nov 2024 14:21:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s8Q-00000007Fe9-2lzF
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 13:56:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D64845CC686;
	Fri,  1 Nov 2024 09:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80C0C4CECD;
	Fri,  1 Nov 2024 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730453597;
	bh=NwWCs6WM3syfKj7MjlqJouLOOSPhG9Wx+R6ZwW1C3TM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UP7H7AklAaM/Ys4LMMzt+OLFxwV3c1kO/yKJIL3aPp9S8iQZFBk41Cz+DTCLB6WnN
	 icplAKJ1JuJBqsv7i17oeUUkFAeuZrUYpEQCDD5PcveWTrmrIdWnCviwFrtwngig5k
	 gX73tKB4R0KzQh2OmbGnH/jNKb5xOaZgS1QlTtpPe6PiDiD4jEl7vNMPI5qOFBKmCz
	 luk7q9o4Xju2pp/tbtE6ot7F4RwhX5DyRGI0xoy8VjaWSjsMctAngJqoBHBb1rQAmq
	 CKeMPQCEGCt8o8E4xpJxbXwQjmL/qjOfS211csjXoE9akkkOszWs8Bb8mPNHCj2eIg
	 vn9sMkK17xQAg==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 11:33:13 +0200
Message-Id: <D5AQLQJ7LN9K.3F3RQZVUMH0GG@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 14/20] tpm: Protect against locality counter
 underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-15-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-15-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_065620_126150_939A541A 
X-CRM114-Status: GOOD (  14.57  )
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
> Commit 933bfc5ad213 introduced the use of a locality counter to control when a
> locality request is allowed to be sent to the TPM. In the commit, the counter
> is indiscriminately decremented. Thus creating a situation for an integer
> underflow of the counter.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>

Remove reported-by.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..a6967f312837 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,10 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
>  	mutex_lock(&priv->locality_count_mutex);
> -	priv->locality_count--;
> +	if (priv->locality_count > 0)
> +		priv->locality_count--;
> +	else
> +		pr_info("Invalid: locality count dropped below zero\n");

Explain the context.

>  	if (priv->locality_count == 0)
>  		__tpm_tis_relinquish_locality(priv, l);
>  	mutex_unlock(&priv->locality_count_mutex);

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68715C27C52
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nwkKP30tx0/EQhbLDl+EKkapdOtuyCA36YwKkQAFFbA=; b=azFFugGXkz01rL
	I1BQqRh97kh0u6SqTqikW4sFeaVNvBDGsbOEw1C9MWanGoAEJio9o+MzJWZQiHvTpX7NvEduJHvx8
	3kc5DCsN82yULchxDmApcDqDVzo16YB/7ZsnCxwIhSDaE+RAtaP/wKama+QxwrIA27Uq8C2HnfcY+
	fO1jWIcC7LdVw8t8eyU3kKRZnyOWfS8ueVMXj2cNvp5HAzsZUUN+Wc6NK39wdBJfb1flFKrdSXkaQ
	k9WvFIqun7Vzf0f5quzA7MIemkgLdXHm85SGklqLUWc+ByDZkhy30FAjgQyRJWkwPRpcBfaBtYeVi
	8pSVB7cQRyn7r1L13pMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaW2-00000003gvk-2hRL;
	Tue, 04 Jun 2024 20:12:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaVz-00000003guY-2wu4
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 20:12:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6EE14CE10AC;
	Tue,  4 Jun 2024 20:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57DDC2BBFC;
	Tue,  4 Jun 2024 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531932;
	bh=Xh63A7TD6mb8qSMe+jtLlQgcmtNjDBvQNIrZ/CLVB5Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZWambTg6yb/UrCbZ7miWvZqg7168mDRTkwDbXwt0fAnwLef8WNiEg+6HUOAsrce3N
	 z2CY+y3egawd+jRXtJ0LprLnxfLHqzEMwo9UEjhBMTGUUJ8y0fy1G+9NmRD4Ugcbqm
	 IUP3HokldOC+3gzkBHwQ+OwMsros/gDaro4uEpLzLkmf4tK8nI7SH+L8Q5H6BRDVVx
	 CODJdx50y1lKgshh8ti0RlMQdBKuXLMvs6DwPcpN51P+J7Quy1DvdBdOXgXks1lDGQ
	 stUXZPPjswSahTuhj0LHX3txOknL7UB/RrSdnDEDt7391TxhXoyirthwtwh6Oxug9h
	 bzJZA+Vpm2TBQ==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 23:12:04 +0300
Message-Id: <D1RI95NQL24F.2E53ZWDFAA8QM@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 13/19] tpm: Protect against locality counter
 underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-14-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-14-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_131215_929358_88BE3B00 
X-CRM114-Status: GOOD (  16.04  )
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
> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")

Not sure if we have practical use for fixes tag here but open for
argument ofc. I.e. I'm not sure what is the practical scenario to
worry about if Trenchboot did not exist.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 176cd8dbf1db..7c1761bd6000 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
>  	mutex_lock(&priv->locality_count_mutex);
> -	priv->locality_count--;
> +	if (priv->locality_count > 0)
> +		priv->locality_count--;

I'd signal the situation with pr_info() in else branch.

>  	if (priv->locality_count == 0)
>  		__tpm_tis_relinquish_locality(priv, l);
>  	mutex_unlock(&priv->locality_count_mutex);

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

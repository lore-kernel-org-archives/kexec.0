Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E083C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Bxftprqw9g/aebcY5nlVmUlPo1xYrxc1mLpjrRtheU=; b=n+KyKM/OKvzje+
	c1XaPNUjQi5zBgzatS6eKLxzLfIPOMIcPdIL9ZrPkZWSNx5r4XUX15QK7R9myWLj0NH5HO15UCSEZ
	jrO6/InEis5WA6MPMnHs40KAY04w1CgVd5u23oO4zYOxKEu5C9XZqjrxppv8sAHivkZfeBNCTVGSL
	+W5f87/HObsvPAMFERp2eb6jP9Twma+W0N4lmYGdRFbKsc9lgL7vWUhH+niPrpsIMhXHGMmkSSJB2
	tNgxpK/jt2a4iaL0n4thzby3Y3f4jER7vZmK4avPX6RI8lMk0tHzDmzNu+qUiKfTS7TfttdXiLyOk
	y8KljhlfgwPr5fR4xx5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEal5-00000003iTS-3uAH;
	Tue, 04 Jun 2024 20:27:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEal2-00000003iSR-2z27
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 20:27:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 22BE260EF0;
	Tue,  4 Jun 2024 20:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF80EC3277B;
	Tue,  4 Jun 2024 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717532867;
	bh=1WFPt6YbL8G4ZsYp/yQJxcMU9eiBBdcr3RYbZ6QX754=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=smGaAySOhkWIJykMXHinTp+dGQnhmzYqqhi1VLJH+Z29+8A6YD6CJ/NU2QmUdkOoW
	 jsqnsaeIhP1DTiF7LsEi5hZFOS5vVWW5iezALy7DR4tdBjPZgmV8c8GypDxhJRIKAz
	 Wxpmwg2VabkC0bzd5g9Q1cEjntEqWPI3zwvEJZeYBPws0USxWgQKrYmz8L7lBQf6Ab
	 FpZsjcU0GJvOh2MJjn6ChFV1hrVKM8zuf0hvKWFUBTleIAsUP4qJICuE52/G7oUmtc
	 Itw+MsrusyEgkV4Qe+vJn5Ef0B6954fQjgoJiTRjQIFQ75VFhE+XXsxO9d063YXT6+
	 KZyVye3hR+ihw==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 23:27:40 +0300
Message-Id: <D1RIL3HMPSXB.PYNHI82D7NI3@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 17/19] tpm: Add sysfs interface to allow setting and
 querying the preferred locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-18-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-18-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_132748_812162_CF26DEA8 
X-CRM114-Status: GOOD (  12.24  )
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
> Expose a sysfs interface to allow user mode to set and query the preferred
> locality for the TPM chip.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm-sysfs.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 94231f052ea7..5f4a966a4599 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -324,6 +324,34 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
>  static DEVICE_ATTR_RO(null_name);
>  #endif
>  
> +static ssize_t preferred_locality_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +
> +	return sprintf(buf, "%d\n", chip->pref_locality);
> +}

Disagree with the naming.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

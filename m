Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D468C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 19:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RiZQbs+LeTBUPjzRfycx5zsOc9hplbGiAhbP9kI+IEQ=; b=ifOMyv5ARmVwQnm0ry+INqbA7Z
	O7LKt2tPhua338WkdQHcH5ABDeB6nbUxXUT3Q3te8MXjxEuW8NKTQZ+GvbNGWT2i0SlNlfQoQ8SrE
	Cc6qVPtZ1knWaVknoealIHrKR5HNKPtO+26DTxvXPYcarrN/IlYiAQEUpEMwmz8tlMwRmAKpqWEh5
	WsbqcKRB8/21kTukLJlMfaURp+sZKjncPAAIuNZMLIwNnaJC8u6ISntPnshbGUlF1bqc/MAwGKNiM
	zXd6VZyN/9X+gmo0onjxiGSor+EvnLylg2RFen2NRNAVlWra06f8X/EoENzszKBucNYeMGNpicN1J
	sG5Z0olw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoOD-00000003963-2F2r;
	Fri, 17 Jul 2026 19:38:29 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoOB-0000000395e-3DjQ
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 19:38:28 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-92e512a9a6bso461383785a.2
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784317106; x=1784921906; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RiZQbs+LeTBUPjzRfycx5zsOc9hplbGiAhbP9kI+IEQ=;
        b=Q8wKHEVz8hWcX/AQMx9bPa8d127khAVPZe9UJd0Jcg20jlG8TbeB0JQLOA/O6D9Fcb
         Xs5PUpqmZne5PZVth4h2LdS+4BTF/pKMp7qZCktbd0+KYgbF5eCXgp7MsSHzDuXXYWuE
         454LUtVgPLlxht6oIakpJFVKtZY/kRB317WVRl3iP+TYlNdnvppsqLEFxSI7WlkSUvO+
         Yxq6s/f3RHhxwTYSFl3x6zoHnsyc7pwxYMvSRuS2cFpokzpigJ4gikhTdOq16leNPYwf
         fz5A9rXDbLXK2PrWTxkJLPk7TzOQrnkTUnkqogGgpq4n1y0MKa9iHokMS1jZEt4p/Jyc
         2HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317106; x=1784921906;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiZQbs+LeTBUPjzRfycx5zsOc9hplbGiAhbP9kI+IEQ=;
        b=ndp41XCQYaHrzM7OHG9oLxtvccoC68ajtKynKwkpVS8waBYpu9D6JGJsbp1CiawwVf
         hwxiCA6Y6npx4BEPmvYZU9uOLhKGYshe4Vfy3ljfKr9NdmKyNQYQnIqCCTdrfha3MTfS
         Pr8kCNDiNa865oM9n0B7C3UXMX7zoHQqGWEqdQ8z8dms+4l3wcs1mkDTVhRZrrn5rVUe
         /MhEkD+oYATmahzPi6aFlvwaB5rw9o5R/w1Ii1sWx8OSwfWX433YAw/iv0UvRfK8pEOF
         16p4UgYYQfuVY9SQsx+2dIAECw5x+gW8TdW9wDGEP/zTrgfj4mi73bg5XUp8R10zWdyM
         se3A==
X-Gm-Message-State: AOJu0Yzoj+SD7SV7NOfY1jMmptlSPgrd36gApinNWMJBej/UW5H1/UKe
	fj9TAJHqx7GO8LM5SIcBd/wmWHHaZB+QBggioqkRcJCi1ds6sxwghvQj+wsewcGNqE95+pAhpoD
	J1M1q
X-Gm-Gg: AfdE7ck/1P5dNRVGh6ohqDOCvCF/40dtMYd5D1NQw/1SxY4wk+/pLni5LcwRqXR5l4F
	TMJWMxAtckc8Fh0h5uFG8ntjIppgb2oEfeQH1lVkfFBSM49FobfY63r1KiiCQCDpoDzBSh7iHEl
	56j93bjxsmeWKArE8CRttdoB80gI8fNpnaMnOvJLzk/ihdFXM2YAUCgiTMCAhU/DGSsFa5dWC3p
	Xw7XPbtzvw2AzkjgoFw1AkB43nyzj8Yl3RL0X9gu9uyK2SAFq4cUE4xys6HHcD8sbbMVMDv5LXr
	9ZXaGmo9U67T0l2oEyNyTpg3tisBmoe0KNCQwjexw+kImDyDStOWXtFY0E5HcAbe6y4SFvviyAe
	UuILFWa+FCjXHR5c9OvoFbrIAUgEepztpflFwbjDZ0OoJqyq7qtQV9e1DRBYtJSdI21SCZ9r4IF
	pUJgSQA++3yzviCMrztzBGSrAEjIJ8CPbOhkWI3y0=
X-Received: by 2002:a05:620a:2319:20b0:92e:c117:5ed1 with SMTP id af79cd13be357-930b431cdc2mr336172685a.81.1784317106546;
        Fri, 17 Jul 2026 12:38:26 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5461ad9sm227825085a.38.2026.07.17.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:38:25 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-3-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-3-dmatlack@google.com>
Date: Fri, 17 Jul 2026 19:38:18 +0000
Message-Id: <178431709881.189683.11618075685237566784.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=jsqG06VtS3z0e6bZDXnLFvK+GuvHlYm90fGXP1i+Rc4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWoSv7CPVSgTbWNsDTFax6B9Q5Aiwar1MuXi8H
 x50paKyCOCJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqErwAKCRC7dyhM23N6
 3vd9D/9LK37IfAvABvCB3smI016O0dV4EVZWcpeNUJPs9CXoBkx1Bef0DMELfdieowtWX/lZleI
 xBJjyEEYD1cTVAp9Zja352m0E+GSJZFaN7w55yvbXEfHV9Wb+1/lx/ltYe85mtIx9n9fwyYlfRI
 cCjhFjcK5JKexzWd59YK+m7BMK3xRXzT6+TR9nVUvVmpnJZbQTfy1g9AtHgNhWDIWuigLUxhLgP
 tQhOMUeQYgJjt5HieCsENdL/zFDDKVpq7YGmYkYBoMq1t3efoa8nwdrIZRvKII9b4HPgkjvk23x
 b+WVxvPZyeeIuWUsI/RvHNH76AcUzjK26tUi90y5PF7JSXQFfsu6n+NJPRXALO/L+bkORobGVLy
 oJHJRNYALyLfmmtP9iaFQQpO2DXd7YAlrUqnOM/GhEnZZ0SFXYFXFT3o5Uy+iwjdSXUsGMH66rz
 F/TkgJk6p9KD0noyJ0goJF1Qor4MRSKBziJCYSxFbmcnjSBiuP71TIuHZ+uFy2qYt4rr7Wz/lIs
 JMCpUM70IwXa7+7E9bW/3jCxbYEKT4aV0r7ZLPGzC0EPMlrHJuwBmS4WaKP5Z6CWIGyr5+Kpgs5
 arq11V5kI8UaDm+rqkudultVgSV24G7f/68wOBq+Vr/HL/P30cLAjMqvZ9B5WdBK3aHWce5vLci
 t8z3cfef0fMXsQw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_123827_819226_889CCAFC 
X-CRM114-Status: GOOD (  10.04  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 10 Jul 2026 21:26:05 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 899758883dd5..03075ce06ac9 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -125,6 +160,157 @@ static struct liveupdate_flb pci_liveupdate_flb = {
> [ ... skip 18 lines ... ]
> +static struct pci_dev_ser *pci_get_empty_or_append(struct pci_flb_outgoing *outgoing)
> +{
> +	struct pci_dev_ser *dev_ser, *found = NULL;
> +	struct kho_block_set_it it;
> +	int err;
> +	u32 count = 0;

Nit, please move count above err, to follow reverse-christmas-tree order 
for declarations.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


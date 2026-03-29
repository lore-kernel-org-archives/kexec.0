Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25FFFF4923
	for <kexec@archiver.kernel.org>; Sun, 29 Mar 2026 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EmjkZkbbVjjgaCUxuu5+nE0xjPd5gN1qT4GlMrecGi4=; b=eoF1haLNajEuBoBuM0xQEjivHY
	XLJze8AkI+gpfrvkNyLyHEwmVwjgZIRsR00alrLdu/eaa1XeeJeBI3Rm7dF2IgBJS9VcHqQ16El6i
	AbIQk/niUD7PA+g1PdZz7XxhFoHacRCv4OSzxlN58vgttQ8iJRKkv6mBq7g6Ji7XPcwO+YWYI4VMq
	uxyXtfiUNqwssXu9hCGRLoxWmOe6QUJy7yQBHLFvUEqyRRrS/bx3Y+goH/PSs83pAY8oS3w72Dnoa
	8dxG55TqCAbJsh+Nbbgf2pdej0++rso0yhMU/gqlNqp36XpFPyPkjiLEkyAHZQjLoZItIrRRqvvp4
	RKoWuBOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6z4x-0000000AP0R-1fs2;
	Sun, 29 Mar 2026 22:57:59 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6z4v-0000000AP05-1lJb
	for kexec@lists.infradead.org;
	Sun, 29 Mar 2026 22:57:58 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-128b9b7e3edso1936117c88.0
        for <kexec@lists.infradead.org>; Sun, 29 Mar 2026 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=code406.com; s=google; t=1774825076; x=1775429876; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EmjkZkbbVjjgaCUxuu5+nE0xjPd5gN1qT4GlMrecGi4=;
        b=HKPAa44nBkG5sgl+ttMM/v2P79D/VH7axoUH9+xUwERCv6KGdR9uSGQSZdjXtIPIYR
         PAA4K9Rp62IsGf7uHzCvlgQcu093CPEEUiSIjcKpRpwfx7sP1DCJCCfdI9c3jYPaQqb3
         c4MtcFCoZ/oWqVERpbYCNGQgF3t+0kj19xwwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774825076; x=1775429876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmjkZkbbVjjgaCUxuu5+nE0xjPd5gN1qT4GlMrecGi4=;
        b=EajEIN77GRzjUQi6UMjbSVpvGBNXEtrosZzG7Bqo2bhqQ/Tb0C3Ns/6S8FlbtfRQe4
         7j6HRb2CfHY0czI91c0UtJX+KAed7iw+qn2UzYDmTK7zQF3NtoYGsPsDpD4ezmrYtxrY
         laoZMIbYD7yi24pICAa8OEQ+e1Yu/FH1h14LinNSg1SSHVzArs95GrGedIY3kmSY2NM/
         XWon4eWBg61gmvdZkx1U2ZXnYOhZrTcbJDPFAkmrJZXu8zaxKhrwStuIML85g8tL08AB
         infDeA3ZZIScKzdOSeBSKzqQW+PgxZoGd5989mDtANz3e7wdDgmeRUeGZK6egYy0EC3I
         TPLw==
X-Forwarded-Encrypted: i=1; AJvYcCUwWs8M8QhqgWxhtIgbQjVYSKYgmvl+orQSeTeOW4rc4pD8OWDYRn8s/3+MwClQMMd3xW3Vcw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZArsx/iCwABNY4zPmZCwpOwm1Ur/OWkuyNG/F253X0bUBqdih
	eA9WU12+Riiin+eIplCowl7fCIGaOJlxTCqjlkUACotO47PV72vy4nr/4xo7ryBRFQ==
X-Gm-Gg: ATEYQzyLOrgv6NAj/bwpXSPZcsMWN3cVH5W8Y8CTwrV5p9h3tiAIV4xOW4OZwcYXfJd
	QKHiKa3+zqJ8DKhA9s9v3ZAUhLzkO8HHRYXQnYn7LSuVGv7jPoOsI1bQ4qoKyRXErp2Wyjr192m
	claos2UzOBi1dZL4sg1fEuLqUN5+gFIRc/y3l+aWRyQFTTnabnkbYxt1svJrWJjpYRBDj/hKvbq
	AB8X7w3dnXQAUcly6m9C46w9cShoY/05XpAmnGfbGphltaGADCHik3A24RFTh6FAUQ67CkO/Qpo
	fAl0BgAkADUiCaCcLuzcRQre4yy9ThFeV/7L2j4BMCV2ZJ7ycZZApm9tLfQDsBUc+o269yWuEFS
	WSx3itEnwY12DR2porhn/3mBw9XJ6ioWU3+mNlKvlJDh5Oa1lVeGth+OOZNpl1ApK7jYM+Xy+r/
	+4Hd1ieKad7LPqisuWPewiErpb4UM2ivVYjx5ROhcm2ka/x0/p0sNa8HKsvnE4bQm5pqMsSyEjZ
	69Piif5JB5OiDMBDjZeMAWux2p+
X-Received: by 2002:a05:7022:2209:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-12ab2912740mr5861569c88.27.1774825075962;
        Sun, 29 Mar 2026 15:57:55 -0700 (PDT)
Received: from ubuntu ([2601:645:8a00:6e44:958e:90e9:e30b:7ecc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm6096026c88.0.2026.03.29.15.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:57:55 -0700 (PDT)
From: Josh Snyder <josh@code406.com>
X-Google-Original-From: Josh Snyder <josh@cod406.com>
Date: Sun, 29 Mar 2026 15:57:51 -0700
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 08/28] tpm/tpm_tis: Close all localities
Message-ID: <v2l4v5imh2lmsayevxz3palyjeglpxo3qu475gjpchitgfzil2@l24ax4vevjp7>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-9-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-9-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260329_155757_468426_60245DFA 
X-CRM114-Status: UNSURE (   7.56  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Dec 15, 2025 at 03:32:56PM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);

When I applied this patch locally, tpm_chip's locality_count underflowed to -1
and no IO was performed. That is because tpm_tis_relinquish_locality is
implemented like so:

  struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

  mutex_lock(&priv->locality_count_mutex);
  priv->locality_count--;
  if (priv->locality_count == 0)
	  __tpm_tis_relinquish_locality(priv, l);

I was able to work around the issue by calling __tpm_tis_relinquish_locality
instead.

Thanks,
Josh


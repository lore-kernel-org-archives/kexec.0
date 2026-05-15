Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E20CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4LfQsLm4zjgCBkokqW/LNO8kguAx5+WYTFTmZDrk46E=; b=iAY8eVjScy0ey3PAKbuElQsZDB
	rzG8B8e1kLyZkFpTzmGMqmBKlmXhg0omzhLAyhQFHdmuf7q7at/0aEM79yyG40s1JKS5Ht0edJjvN
	PbGqLsmxMmpToAifUgvZMBiMhqGWTDFNhaAZY9EkBYLA/i4B362qtcuidtTG4nayrGsaTR8GZANkP
	Yx5dN6uaXLcYt6t1s4SD4Iq+IjHXmBueIUTyX3QXMPHmdiWDIwxb4a4MaTKNl8WXU2RNSIlc1NYP0
	JZCI3aop8We6bRtmSwhHs/HHwtFi4qWxNRPwUY9ToSDeW8Ts/mTN+ZXxmf7fQ98bznrmUTkSLqrAZ
	twIAfYPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzru-00000009TN1-1Rvn;
	Fri, 15 May 2026 21:14:50 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrr-00000009TKY-3z8x
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:49 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1350288eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879687; x=1779484487; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LfQsLm4zjgCBkokqW/LNO8kguAx5+WYTFTmZDrk46E=;
        b=ljQ/Tbe9ZVX3WoOPHslf8YI6dFm/EI+lQ3uTGmViSoE7svBAZKoL4rQnga/3mnfGUG
         CAvTYmRYW97uSnXUpmWFZYBnwFb9yBU8VyRki+QYw4mF16OmezyVQ4VuBlmDZxo+1CZD
         BOJpt0qIOxk6jLKLyMWqzUvVChxextDvwbXC3PGQeKUfBxcIFkE6vkquJS0aVjcoMcXA
         haZUkNR/8RHF6m78jOwOPmuo03yi7eRa4pG4nc5ku18TXe4tIqYzBCyg0MLC+GvhdT49
         h5sy/mTFZWBl25fr7kPm1L7Iwnm0FYBVG9RCqA7j67DG57leXhOLLp8ryCRhGpPTmC9y
         MWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879687; x=1779484487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LfQsLm4zjgCBkokqW/LNO8kguAx5+WYTFTmZDrk46E=;
        b=rg4Ep5IQW7BsHBBgGum+BdlSgL1sixKCnVjcQFV217FiLrhCi04H+vwVzjSTWdqAsz
         X9YHUW357VCbOViu36u35nPnzktkOlUkv0q+cAm8S450LpBh2V7k6HulKbJAejJUTQ3f
         0wRBWLEW/2WQPid7NTELGw56+nTJAXAzV7SdVze8GvVIdVhIW/bQ5F+SwDh7kjbmZWV5
         veT859fzHHzh4FRIJ12V49Xmv05d9YiJ22s9K2zs46PkUgHEoQkWahesU/Lp0uoG9ydW
         9K9CR1IA/tlFJvB6qngr7hJItgC4duPtU1KMKW9AGIGx04c4ruyg+oiywz5DR0tPnqju
         pEcA==
X-Forwarded-Encrypted: i=1; AFNElJ8OUmrApd4vhV8mFtJJtfnu+uxGrzqRAIL6+Z7TW6H63SgtANQOlx6k8NVqc56ln3JrojPUJQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxIlh2ssTeKs5C2C7eOP7WgmVs6aLWRW4bHFwPYFFc1/dozLAIC
	a9TAVyD6loaEXuTiie/ctsJ1D2RjkPaom+QZobMVykmbEM9Vmvy9x0JX
X-Gm-Gg: Acq92OHMxKu/XRJsGrRHuVmgS+SLhjcdVEYntdfY2hTsiGQJcCY5aMH/jIudBeKjqm6
	YzoOVXaLac0NjgsgZzfeMX4dcvl/XSIzt9bQkHyhta4TLdJxWYl0j4fzJ4vFo9Sj1P4rgfBXY7j
	433lBdaiNCxWjJnqVIzlMlQaMP2k7LtP4Y/cN0j/O+OudRSZWPiOqp+eYYFJqCV7bzI92iuqBFw
	ChewI3I8pxEnkC4xWH+fjn7FJucO8MlDms5DWhYY8CSPBIq5VvEIM8ga9O0aGBlkgsRCvi22iTm
	TxwbzVXiOu9x1b7qB55R4An9OLVBGyf6rvb0AsI9C/WlAFR40yvJfIm7EuxVWM7NqchcdZLJbGI
	i9j1aeKhKDMZOZx3sfzMn7kRD/+oBufilANZAQjpLGN+3S7dqI3JHj54cJolXRGwTmID5VB3TOl
	+v+BgzZgGEBMU+NCTpsJdyTt3s5IGbYCY=
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-30398680c36mr2863934eec.22.1778879686973;
        Fri, 15 May 2026 14:14:46 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6c3sm9740068eec.19.2026.05.15.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:46 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 12/38] tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
Date: Fri, 15 May 2026 14:13:44 -0700
Message-ID: <20260515211410.31440-13-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141447_993332_EF0F079C 
X-CRM114-Status: GOOD (  11.61  )
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Validate that the input locality is within the correct range, as specified
by TCG standards, and increase the locality count also for the positive
localities.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 1fbb74a565f4..70aba05f4ee1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -179,7 +179,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	mutex_lock(&priv->locality_count_mutex);
-	priv->locality_count--;
+	if (priv->locality_count > 0)
+		priv->locality_count--;
 	if (priv->locality_count == 0)
 		__tpm_tis_relinquish_locality(priv, l);
 	mutex_unlock(&priv->locality_count_mutex);
@@ -233,10 +234,16 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int ret = 0;
 
+	if (l < 0 || l > TPM_MAX_LOCALITY) {
+		dev_warn(&chip->dev, "%s: failed to request unknown locality: %d\n",
+			 __func__, l);
+		return -EINVAL;
+	}
+
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
-- 
2.47.3



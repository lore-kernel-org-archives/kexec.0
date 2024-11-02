Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D1BE677EE
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 06:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ToFCG7kmB43KSfyxqrry2do/bRnzdtpS3GslL04L1Lo=; b=3vgF413vvc6RMC
	Ycm5GgV7TOs3WHg/o/5jVlQg4Dn2QJiUWZ0C6Q7dNUA+y3WxzNVdUGeOusYMkmW5jPdgMkVOH+JxZ
	LSgiTD92DOVFCpPDtu8h4B4HQ0sP68iAf5hD1KZwg8+1Ock+VGgZJcRFv0Hng0ubKvZ8AJL4DzaFx
	fZq0fvAKzeLFuIIyiOX05jik76XYm4J6dOQCuRvRI96neJGYYGJ9VPheEtJXfSVDSX4iRA/x66Gey
	EFaDh+H75xNc70wo6nyW9hssV1F9vEupEBPQSpBxogWWIQ2ZM82c+TrtyYqusxRe4I5j9azDL9agT
	dsS+ghJiIgiYMYy6ZQkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t77Xd-000000098Bx-3oBF;
	Sat, 02 Nov 2024 06:23:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t77Xb-000000098AM-1zW8
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 06:23:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 048A85C110F;
	Sat,  2 Nov 2024 06:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59A8C4CEC3;
	Sat,  2 Nov 2024 06:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730528598;
	bh=NY0xcRqGkYBk6+Iddjn1WeUvmoSjuS6NoFtXitHCID0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uV7o7pOrKf9LSTRyEOabwTBsOog6I7KPkza7UGoUxg1Xd+xU07PDpBzcVsPypJyq4
	 K+3gaFSR4nWjuiQwKoI0B16X7FxC3485i9dR1dnz1mkBfdVHQy3OMWlz1MbXRAwiZj
	 uvPuMuR8X6okk1idTIHZ9wiNiGt5EAOL+tys3W4DNSymZotpPvt39IQ2xBVNTfNFmo
	 HjHnP6H30hx4tt4BaHCrbgR+O6D0COycWSDU2rNfbHqUArAYgWHMz/CyTl+OGmnyIi
	 xSBPF9Oc+soqtNrmQKbbC1Rz5VZpRHfoppBTRrIN7CeIx4YsFHgf81ZvaJgmtnKLTM
	 Hvb3IVJ5+8OaA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: jarkko@kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: James.Bottomley@hansenpartnership.com,
	andrew.cooper3@citrix.com,
	ardb@kernel.org,
	baolu.lu@linux.intel.com,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dpsmith@apertussolutions.com,
	dwmw2@infradead.org,
	ebiederm@xmission.com,
	herbert@gondor.apana.org.au,
	hpa@zytor.com,
	iommu@lists.linux-foundation.org,
	kanth.ghatraju@oracle.com,
	kexec@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luto@amacapital.net,
	mingo@redhat.com,
	mjg59@srcf.ucam.org,
	nivedita@alum.mit.edu,
	ross.philipson@oracle.com,
	tglx@linutronix.de,
	trenchboot-devel@googlegroups.com,
	x86@kernel.org
Subject: [RFC PATCH v2 2/2] tpm: show the default locality in sysfs
Date: Sat,  2 Nov 2024 08:22:57 +0200
Message-ID: <20241102062259.2521361-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102062259.2521361-1-jarkko@kernel.org>
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_232319_590587_E35AFF27 
X-CRM114-Status: UNSURE (   9.27  )
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

From: Ross Philipson <ross.philipson@oracle.com>

Expose the default locality as read-only attribute through sysfs.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- A new patch.
- Import from the original Trenchboot patch set.
- Drop the store operation.
- Tested with https://codeberg.org/jarkko/tpm-set-locality-test/src/branch/main/src/main.rs
---
 drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..4f5e60b1e4c9 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%d\n", chip->default_locality);
+}
+static DEVICE_ATTR_RO(locality);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -336,6 +344,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_locality.attr,
 	NULL,
 };
 
@@ -344,6 +353,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_locality.attr,
 	NULL
 };
 
-- 
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

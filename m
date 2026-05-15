Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C51FCD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EseM1chjBypSoW0cp1ToXZvQ5KcO5EkTarmMMC63WUM=; b=Gd6E0w5JXSGcSk+PUVKIVtyaoo
	HjvvaXzrcUVf75u6UXfGKmxp80bjlHRYBMkyaz2mdzlQFbtgNe/zu5CyroJnbH034u1EfbmvnrmnL
	sH7uAuk7T86gY8KowFQEWHtN+w34l2CL9EtT4eOTBnUHcwv1W7OmHDzaBT3vCakc/bXZ22Sp+o4iM
	t5D/xwG8IycIlPklwl+HSC4i/gp5T6Y3LFQsPLFmhh58Gepeiid+1UJ2pVmdLQIXp429VSFF5YqNs
	fBus/djafvgsJ/FA5E/faGUhymr2qwxs9Os9BjUxS+XtPHIn48ToEBlwZiYNL3QKVA5rKFbHX+iYL
	Ass6oNow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsJ-00000009ThP-0x1W;
	Fri, 15 May 2026 21:15:15 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsH-00000009Tfi-1alL
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:14 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso1356931eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879712; x=1779484512; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EseM1chjBypSoW0cp1ToXZvQ5KcO5EkTarmMMC63WUM=;
        b=niuXQ8M5wXv0s85/z+xi7avm8/mAaKNjEiaVF9ZCrjqaXhfB4RmCTd7PdA7QZwhr8m
         JiFh1TWDIUTHIJsavmZsz8S1jx8Oge/22kxeDvx2A8LyiHv0P/UOQHihyXI/bl6rdO08
         uYpizbeH57My8skKSqvhdyG1ETUYTkEjgqkMRJ1noC5A0xT26zH6K6NcNxSdiwkVJFi7
         maA7jQI9CLCxHbuCevTM9RibvkDrzI10CZ+dVfR8dm9rimrex8asz4kxYPRZbRNggoYu
         Id/Q8/ekxyWcGgjozcsv4Gytqo9sfLgixTZmqzaB47zBZvO6wKs9k1jsWU0LJk0B3e4E
         p73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879712; x=1779484512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EseM1chjBypSoW0cp1ToXZvQ5KcO5EkTarmMMC63WUM=;
        b=aRXDvkhzWgqXOffuipaJWBwYyA1P1aliCX6PK4WhXfhFpYHp4aEu+xE7+iidDlixUs
         ed1eIOqMExKe804AKmEBV2PHCaU5iB+ikw7Y+Z7EIkI9Y0SodsLQMqpFo5RR6PRSw/qh
         mNEQ8+Vl9y0g3j7lXjUi22RT/biddbUU4rDqM0QBQbXorJ9P0rBVWak5QaZNu94f51NU
         DK6/2P927zaHCOc7G3Vu0/z953Wsg0jAdLtTHSXu5Nu5hvvDb371TSy7SfoCDzB6OzSq
         +D4PIn9/sSa1Ea6vZNzmjwBmu6aMV55qOkrNyHHMF592ZRNEOJAVQpfUJvD2tSsGqk8Z
         xGGw==
X-Forwarded-Encrypted: i=1; AFNElJ+HHihwZ42wTnPwThVMNhG73o4czp93C4r16AnHzazkbqxMtqcOnE8RoTdB+MSsVysYgq2ojw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyIskbnR5VXO5Fg/YVtpwbF20qYtSSotjFI757iAB6DrNVSba3m
	9MAtLEv5vhoLEJdn4XmhMe9d2+tRcrx711BFWqC+qGBMcc4FaImQUubX
X-Gm-Gg: Acq92OFRLDMc+qS4oXnvd7d1NNlnkJHihAagWNYtHggrP9aIovnuty5t4800Xd2Xwgz
	pGTiPnOJjTmgZBpmqMUpmQzMXCmL6PJLxuWpnLVhON2FMf/AQSxFAk0rMs2KnTibtIgTKsSzrf7
	Ga8P+6YWtcGi4eUKxb2pytyfdPsMsxvjE1MI59uJMR25y1tUf5nJ4Mxi0T8lj5gWWYsoRbT0cQn
	5OtpL6BjRBgZBH+nOM3xDi2ZOSm1az5foXJZSB1GfEyV2fqN0ftZle/O3pSiHIOvQ6cNyUu7iEh
	S6EXWOF2pIYgjLV4XV9SnsnEYRZsAQ0ymhfswu28xA6E91eVomD6FRg3ziI+DXBCNOx59qyKBwk
	i5IrSejp5/upeH1Vr8SpORD2q6uyiOIC+WZH9aRhW1XcHDdjeJxoMNUxswsFJB/w1o27Ds3XTTI
	8fCMtdMsIPDRfjDsXCZyo4wmeqZyv+Fgw=
X-Received: by 2002:a05:7301:19a5:b0:2ed:e17:d50d with SMTP id 5a478bee46e88-3039868c8bcmr2807177eec.32.1778879712290;
        Fri, 15 May 2026 14:15:12 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm8003129eec.26.2026.05.15.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:11 -0700 (PDT)
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
Subject: [PATCH v16 21/38] lib/crypto: Add SHA1 support for pre-boot environments
Date: Fri, 15 May 2026 14:13:53 -0700
Message-ID: <20260515211410.31440-22-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141513_431062_7F6973AA 
X-CRM114-Status: GOOD (  11.81  )
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

Allow the SHA1 library code in lib/crypto/sha1.c to be used in
pre-boot environments. Use the __DISABLE_EXPORTS macro to disable
function exports and define the proper values for that environment
as was done earlier for SHA256.

Acked-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 lib/crypto/sha1.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index daf18c862fdf..f30b5ff3b31e 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -125,7 +125,7 @@ static void __maybe_unused sha1_blocks_generic(struct sha1_block_state *state,
 	memzero_explicit(workspace, sizeof(workspace));
 }
 
-#ifdef CONFIG_CRYPTO_LIB_SHA1_ARCH
+#if defined(CONFIG_CRYPTO_LIB_SHA1_ARCH) && !defined(__DISABLE_EXPORTS)
 #include "sha1.h" /* $(SRCARCH)/sha1.h */
 #else
 #define sha1_blocks sha1_blocks_generic
@@ -207,6 +207,12 @@ void sha1(const u8 *data, size_t len, u8 out[SHA1_DIGEST_SIZE])
 }
 EXPORT_SYMBOL_GPL(sha1);
 
+/*
+ * Pre-boot environments (as indicated by __DISABLE_EXPORTS being defined)
+ * don't need the SHA1 HMAC support code.
+ */
+#ifndef __DISABLE_EXPORTS
+
 static void __hmac_sha1_preparekey(struct sha1_block_state *istate,
 				   struct sha1_block_state *ostate,
 				   const u8 *raw_key, size_t raw_key_len)
@@ -302,6 +308,8 @@ void hmac_sha1_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 }
 EXPORT_SYMBOL_GPL(hmac_sha1_usingrawkey);
 
+#endif /* !__DISABLE_EXPORTS */
+
 #if defined(sha1_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha1_mod_init(void)
 {
-- 
2.47.3



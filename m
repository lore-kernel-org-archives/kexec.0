Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48562CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpW1a/fScKIJOJjIsuP4+bGqNlbA4fQX64i8+rdO0zg=; b=Rtvisy2zvL7Mnu9TFxH8O6uZ/u
	H052dpPNirz+3TRPvf7uKhz7V44kOgizGe443mZqRWfVvlR+s4Q7s65i0clJR3hHIMSb/JiUjedNy
	8KE6hpw70s/cpJz+d3yDHI5Qgd0VTWhiOKJ1TLCVZtsRacFlwlo3pkY0AduSZyuYwEIc5yTn5vjcV
	7nl5369CswunT/pMfNiq5xehGtgUhapxctiIR9AyM+atr4EaJmDJokUo4yFwTGQkozb+nhB2SH6Du
	ceaA2sqAxmVcoIfO1I4Afkqs7AG45M7UKm5GK1qwnz1k7Kcny9MxRGfc/8CVx687FqERhfuZ9iZaF
	eLw7ZSAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsM-00000009Tli-1Xwa;
	Fri, 15 May 2026 21:15:18 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsK-00000009Ti4-03jN
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:17 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-2f3c623322bso1044660eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879715; x=1779484515; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpW1a/fScKIJOJjIsuP4+bGqNlbA4fQX64i8+rdO0zg=;
        b=AaE0ds18vKvfhtGlBoTNIk/vC0Gwaq90G0N8uoAEvfbX7R1h2cBCs61hOG6ypnpsU+
         /u6UgG7SziS8sm18ZUY3t4OmsoRZdr6MXQyPOCU+/Wfw9Lm2v+yqCQIA1RzeymsTNmGY
         suZzgUkTl6ZB/VkXkWcrUFfeqPBUvyfT9hg+yuvujwx+A+m+WYM3ZYz4j+i/pJhoBFtP
         X0H68diD5D2akS43PZaErwzJL04s3MsY/6yeNURkZjvIpe9mFICQPkvTwbxlPNNLYQ7y
         ecSsAvaVib8KrvUwipqB1x1FOL91euFcRZ5Y9D8v6Un48fuLmXEzMM4LsjozN2qpLtYL
         JIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879715; x=1779484515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpW1a/fScKIJOJjIsuP4+bGqNlbA4fQX64i8+rdO0zg=;
        b=eockBScCjzaouHILLqS5Zrxy53nPQYPywmBAIeLrmKu2Rs4Iu3sT9ghIv4NQhIvF1m
         Z4srUVnVBYo/NBdQrDq6J5ccKtqLkMflbOBxlj6l5Nkm5leMPiTD+Ffr/tNRRFS+EVeJ
         qIq2zjEMRTmjmU5qquQd2Ot7ZlKdfykqJBwRngVDGoA8vtf5KaFCxU3vp/LTABXjM36g
         bDOw8jtMy0gbHt5ga5bIE4TMIg1I/xivkKnV22ASJDwG/QileGLBUvMbzO7Ofk+Nf9rv
         8O9hXd6zY5B34NO6XC/MHIJ5umWxw924JH85GZw/dTcVMLzVCO5iaa+la6cmepSUrEVM
         oR1w==
X-Forwarded-Encrypted: i=1; AFNElJ9nzrvIiMahQCjIBXsdQPT7s9I8U4LSXzfg125c8rb9P93GwmtsZJpfvyW7Nb0MwQKQ2Pm/nQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDNZ1WN3UYhJNqSVFt7jVSYDrBl3a6OrQX0gFe9wT2SIf+x4EW
	6ZBJb0wuiCAcx00Lbf+SlbAy17jFaxeB4aRFZRy10T7mf4ApMgsX/4UL
X-Gm-Gg: Acq92OHQ3x5nWwOQqlEq9R0JEJ9uJ4d0LLk0WrCYOYu28INoUQLeUEt+WWpvTbqg9Ov
	kxGUCrgQLCQa7pS6Yiff2MBajDmfGu3f2edxkckO2NaLjQ/PGGXwqcp60Z/w6lEPPCHNCPxGVp0
	u3J+4wEJDifFaSbhPTU8dafsWecyIfSDKAq/QI2dzuEr7hQHytyVZI957XczoBpMIbRYN7HXRyE
	vF6rG+JRPEBAb2qROl+rz1FErjVbTfSkp8UcW0LjYTlK4VC79yjvKsEiki3kfJMJdNjA/+4YFBp
	Svxyis4mlaHOlHluelOH8hDMuQ0wiAjc96JTibyrqC5MW/JP0kMzQAWK+fx00GjWbWp3x5d3yFF
	CYWRPweaLhTwi3OGk7a0Y1u1Rqhu+V10b8yc/SSeWFQc2N9MzhTmuBpfdp/F+Kztq0fRTFpMtMR
	Wfj7NeM9ltZp/m00SKKg318IqRwUDAZRM=
X-Received: by 2002:a05:7300:a94b:b0:2be:142f:d499 with SMTP id 5a478bee46e88-30398678a39mr2873251eec.16.1778879715061;
        Fri, 15 May 2026 14:15:15 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm8003208eec.26.2026.05.15.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:14 -0700 (PDT)
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
Subject: [PATCH v16 22/38] lib/crypto: Add SHA512 support for pre-boot environments
Date: Fri, 15 May 2026 14:13:54 -0700
Message-ID: <20260515211410.31440-23-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141516_059001_B7437AB1 
X-CRM114-Status: GOOD (  11.46  )
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

Allow the SHA512 library code in lib/crypto/sha512.c to be used in
pre-boot environments. Use the __DISABLE_EXPORTS macro to disable
function exports and define the proper values for that environment
as was done earlier for SHA256.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 lib/crypto/sha512.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/sha512.c b/lib/crypto/sha512.c
index 605eab51aabd..160e81d86da6 100644
--- a/lib/crypto/sha512.c
+++ b/lib/crypto/sha512.c
@@ -133,7 +133,7 @@ sha512_blocks_generic(struct sha512_block_state *state,
 	} while (--nblocks);
 }
 
-#ifdef CONFIG_CRYPTO_LIB_SHA512_ARCH
+#if defined(CONFIG_CRYPTO_LIB_SHA512_ARCH) && !defined(__DISABLE_EXPORTS)
 #include "sha512.h" /* $(SRCARCH)/sha512.h */
 #else
 #define sha512_blocks sha512_blocks_generic
@@ -250,6 +250,12 @@ void sha512(const u8 *data, size_t len, u8 out[SHA512_DIGEST_SIZE])
 }
 EXPORT_SYMBOL_GPL(sha512);
 
+/*
+ * Pre-boot environments (as indicated by __DISABLE_EXPORTS being defined)
+ * don't need the SHA2 HMAC support code.
+ */
+#ifndef __DISABLE_EXPORTS
+
 static void __hmac_sha512_preparekey(struct sha512_block_state *istate,
 				     struct sha512_block_state *ostate,
 				     const u8 *raw_key, size_t raw_key_len,
@@ -406,6 +412,8 @@ void hmac_sha512_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 }
 EXPORT_SYMBOL_GPL(hmac_sha512_usingrawkey);
 
+#endif /* !__DISABLE_EXPORTS */
+
 #if defined(sha512_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha512_mod_init(void)
 {
-- 
2.47.3



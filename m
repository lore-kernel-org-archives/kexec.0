Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02538E7106D
	for <kexec@archiver.kernel.org>; Thu, 21 Sep 2023 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r5Fe38Ncy9+6Mgf7Jx+XMqBQr8eQDzV+9lBd4qExdlg=; b=Z18up2EK5JgC6f
	FUhw6vgzwZuhKWzhEFaQ7t++UUoGPW+Xvmw3R/xZoqy06FHwOdLlXAB7bcO2qOrPcIlMw7vj4w2eo
	Tjn9nz9nYExXy7gTxrmXowxdtx440SCHAmiMIgppUpL2DXQ7Z3haHaSZgIA/hrJEKag/FcdIW7eWy
	q6YXfflPqOABimX/A8TJptig64kLZ+dkOKok4S56uZmKslP7gJtD7A4ss0i+RxCsW+zd4Brl6L92o
	lPubXR+Dnrx2Up+55eWCEychDEXcaDSo7bEVOl7O2FaQU9JqYF0RpOiRAQQkTMbUDeq4REL4hPWvq
	9kx8QLXMFuxBC3z9impw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjJsD-0069H2-0o;
	Thu, 21 Sep 2023 13:37:41 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjJs4-0069Dx-2n;
	Thu, 21 Sep 2023 13:37:34 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso548013b3a.2;
        Thu, 21 Sep 2023 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695303451; x=1695908251; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8swn7HmC4uSQV3vzfL086oj2XFrz2A4bNyoHSHM5TA=;
        b=RtRQDpPZMxPBlNMYC5a6dEjkBW7pybEIj8mkCWLSXGYTq6b9rqPpRBCJoW+qTQKU0f
         tDLMKXN7FJZt1slQhoG/7o33Ia3X8heyiv/AfUEzo6e3PQSoQUBZUA9TwcIv09vLA9t1
         emLwJsErO9b177Fvg5yjmrJ6F9PnzyJj4Ufq0WOtZtTlQhVnBY+ZgO3cKXNpeSOaCuX/
         CuimbSSM8b7fbv+omLvE/qo0f1wFaIegyqOU1m95zRzUqwbqTfASu80dfFlQh/xiZEW8
         BGRYyadZijLUIzdHYnKiCP51CeJdkW608ZpHdoAbPQ5iiBVyQRnoGCDS4ejdQKOA+ED6
         er2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695303451; x=1695908251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8swn7HmC4uSQV3vzfL086oj2XFrz2A4bNyoHSHM5TA=;
        b=C7GiOtlMxlfVva8uTa/bF4O45JeICiHFIjAhlRGUSt/0/fAz8LijgTaZSsAYOys8bh
         z/KjyGQ3U7t4BvLm8Z4PBrF/QgSQZQOZkDrnDYcHwKTuVKAzh/HiTFD6P2AsM+Kymb8q
         SvzEsTQPxtrth/PDNdX/uQTb5JJbx31T+A6ZVoEg250DTyyLp1RGbjkpzpymsVcm/Gsh
         fz2EcVR5o93Rl6V4ZDlpB43MDsrFB0oDflAA1Re2agtB2T4YiHtywVGDhCHXpdPxBiwH
         xapDNuJVt81i2YfRObFzJ6GH0QXaaRAh756BSSUO3p3nQtwxAT0fTNPa2dSz7sd8RrYV
         IUvg==
X-Gm-Message-State: AOJu0Yyd4bhZ9Rcydoh6svJ4NVrWWsNGvGIYRASgMLh71irq0bHrzVxl
	jc3K6jry0YCKaXuSzcM8VbGfhQ8nkTNj
X-Google-Smtp-Source: AGHT+IHcOZyXNwTzn1eSqLSYsQeU0FEqWAj2F9tL5lG2ChjxPYE8IDiLXGUX5rRRfibLUsqS4A7ejQ==
X-Received: by 2002:a05:6a00:311c:b0:691:da6:47a with SMTP id bi28-20020a056a00311c00b006910da6047amr1377959pfb.31.1695303451405;
        Thu, 21 Sep 2023 06:37:31 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b00690188b124esm1389785pfn.174.2023.09.21.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:37:30 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"Jan Hendrik Farr" <kernel@jfarr.cc>,
	"Baoquan He" <bhe@redhat.com>,
	"Dave Young" <dyoung@redhat.com>,
	"Philipp Rudo" <prudo@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] arm64: Enable signing on the kernel image loaded by kexec file load
Date: Thu, 21 Sep 2023 21:37:03 +0800
Message-Id: <20230921133703.39042-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230921133703.39042-1-kernelfans@gmail.com>
References: <20230921133703.39042-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_063732_903874_1F2D4183 
X-CRM114-Status: GOOD (  16.01  )
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

From: Pingfan Liu <piliu@redhat.com>

Enable the signing on the kernel image if both KEXEC_SIG and EFI_ZBOOT
are configured.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: "Ard Biesheuvel <ardb@kernel.org>"
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: "Baoquan He" <bhe@redhat.com>
Cc: "Dave Young" <dyoung@redhat.com>
Cc: "Philipp Rudo" <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-efi@vger.kernel.org
To: kexec@lists.infradead.org
---
 arch/arm64/Kconfig        |  2 ++
 kernel/Kconfig.kexec_sign | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 kernel/Kconfig.kexec_sign

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f6..e067864d7ea1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1493,6 +1493,8 @@ config KEXEC_SIG
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
+source "kernel/Kconfig.kexec_sign"
+
 config KEXEC_IMAGE_VERIFY_SIG
 	bool "Enable Image signature verification support"
 	default y
diff --git a/kernel/Kconfig.kexec_sign b/kernel/Kconfig.kexec_sign
new file mode 100644
index 000000000000..880aa9aed9a8
--- /dev/null
+++ b/kernel/Kconfig.kexec_sign
@@ -0,0 +1,54 @@
+
+menu "Sign the kernel Image"
+	depends on KEXEC_SIG && EFI_ZBOOT
+
+config KEXEC_ZBOOT_SIG_KEY
+	string "File name or PKCS#11 URI of Image signing key"
+	default "certs/signing_key.pem"
+	help
+         Provide the file name of a private key/certificate in PEM format,
+         or a PKCS#11 URI according to RFC7512. The file should contain, or
+         the URI should identify, both the certificate and its corresponding
+         private key.
+
+         If this option is unchanged from its default "certs/signing_key.pem",
+         then the kernel will automatically generate the private key and
+         certificate as described in Documentation/admin-guide/module-signing.rst
+
+
+choice
+	prompt "Which hash algorithm should Image be signed with?"
+	help
+	  This determines which sort of hashing algorithm will be used during
+	  signature generation.
+
+config IMAGE_SIG_SHA1
+	bool "Sign Image with SHA-1"
+	select CRYPTO_SHA1
+
+config IMAGE_SIG_SHA224
+	bool "Sign Image with SHA-224"
+	select CRYPTO_SHA256
+
+config IMAGE_SIG_SHA256
+	bool "Sign Image with SHA-256"
+	select CRYPTO_SHA256
+
+config IMAGE_SIG_SHA384
+	bool "Sign Image with SHA-384"
+	select CRYPTO_SHA512
+
+config IMAGE_SIG_SHA512
+	bool "Sign Image with SHA-512"
+	select CRYPTO_SHA512
+
+endchoice
+
+config IMAGE_SIG_HASH
+	string
+	default "sha1" if IMAGE_SIG_SHA1
+	default "sha224" if IMAGE_SIG_SHA224
+	default "sha256" if IMAGE_SIG_SHA256
+	default "sha384" if IMAGE_SIG_SHA384
+	default "sha512" if IMAGE_SIG_SHA512
+endmenu
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

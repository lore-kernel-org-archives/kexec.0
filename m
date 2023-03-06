Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B14C61DA4
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 03:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r0lIzWCvjjrpBUzwXy6rUH7CcDFid+pj9XOMU889LIY=; b=P558fddTDC4XWe
	+xW+JDzhquVwY22dGFfYq7thrNtjeUbvyoRTR3ZlKI/XyrCBDyfGwbv7MZfyTXTAMb39yOzG6/3rE
	rE/PqsAKTj+6tDhOy8spy8DGvCOWV5GGFUQqwRpcNox7EidJWsIaILh3K3y0ylIWYg9OZey3+8QSk
	45+Gmzx+A9huSRnP+bNRUf4X6/YTAgxfqZXPuUDhRrtRliSURTGY7zuk6enQqkGZ+WabG/q45FfXv
	g/Ohlh8jh5oaDwHXlu+EEQSaXfF4fV7NJkQg7niiIIBWIJiE0gDSI0mqyNF4kI12ejZg+/fbCIUBa
	0PYNO6agWgxP6uSl0idQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ19R-00B3C7-Mv; Mon, 06 Mar 2023 03:04:37 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18W-00B2Sz-Ut; Mon, 06 Mar 2023 03:03:42 +0000
Received: by mail-pj1-x1031.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so11788140pjb.3;
        Sun, 05 Mar 2023 19:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4a3X2UJpGVkEkCKZLpiC6CtZYdkpIrB0sY2y8ZRSlA=;
        b=OPG09K+PyjQAJLkndvQbGSHh8ZsyrlhmGiMtf07LeNaFj9x6p7KSLTNYv+9Ooqsi4h
         ldBdZ7+yd4X2es3XcAG9Mna/yr+K2lqcKbXIZvAK4Rnv70RoJikbkIUxeI4orZZSPw7r
         hmwdG5CY7Qu3xxuHsQjsWxnmeGKgwrgHCpkXVAdIF1uAG6WwS6NBHkUM7l1yOrPhHNsu
         YXUQ3GjmheCJ8PA+LTPOqlMjoMZ0qWht6iSLsPqKJg5JSPOZij47TfFa0TwtH9lBZhdW
         Ppv8m1TETpG5bvn8Mju3NX36eNpg/mE1Cull9ER3VT9630GoqoMj4Ph7CQ1/3b5vpFZl
         OJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4a3X2UJpGVkEkCKZLpiC6CtZYdkpIrB0sY2y8ZRSlA=;
        b=uOYy75O61aKcSfBg6bhQiNre8Ms4ks6aXTul4XvaC6h5+aRpWuCyMM8BaAJSG6D7PS
         afdZi993CqCA2sNYVcCIn0Al8SsYHJrahaiU0EFES0Fzbse6/rXcTJkpio2EnIcRq+0Z
         LUG2J2d5RNVHvjLeg4QnSvPxYckHUjGsH112kDpokemo0eGyIyQrcprMj0viYh6lnAjf
         rM2ozht1X6eKXSdyr3m1eFxMSTcbgTv4w8FcDvD9b2S9vEbSlfvO+YDFMtYN9cnZRny8
         LDmMM+A8O44/qzu8NCLEIy/5HWBLzUOEWjGxS3Paw+BWANUNVGemgRWmbCfiy9K3TTpL
         McmA==
X-Gm-Message-State: AO0yUKUYRI1WQdHSCik39dZHYEfMjV7k65ahSQ6enEPHZ1hhOTmGYPgG
	04D8YH4yN6jrBrQPCpz6QjYZJChj6A==
X-Google-Smtp-Source: AK7set88DNyYROwb3m9fSv9kZYyr9WinWKZoWYmcxYffbwht/af+J2U9qH/KesKw6say2sKAElKZ5w==
X-Received: by 2002:a17:903:258b:b0:19a:973b:b615 with SMTP id jb11-20020a170903258b00b0019a973bb615mr8486498plb.36.1678071819212;
        Sun, 05 Mar 2023 19:03:39 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:38 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Will Deacon <will@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@google.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	kexec@lists.infradead.org
Subject: [PATCH 3/6] arm64: Kconfig: Pick decompressing method for kexec file load
Date: Mon,  6 Mar 2023 11:03:02 +0800
Message-Id: <20230306030305.15595-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_190341_066852_94C17287 
X-CRM114-Status: GOOD (  12.38  )
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

After introducing the zboot image, kexec file load should be able to
decompress the Image.gz. (Do in the later patch)

Unlike efi_zboot_entry() which knows the decompression method at the
built time, kexec may loads compressed kernels with variant compression
methods, hence it is helpful to include as many decompression method as
possible.  Here provide an opportunity to let users select at their
will.

Besides this, introduce an extra config option 'HAVE_KEXEC_DECOMPRESS' to
distinguish the reference to decompression routine between kexec and boot.
(used in later patch to keep the routine out of .init.text section)

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig        |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c5ccca26a408..58a65bdaeffa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1419,6 +1419,65 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+menu "Decompress method for kexec file load"
+
+config KEXEC_DECOMPRESS_GZIP
+	bool "gzip"
+	depends on KEXEC_FILE
+	select DECOMPRESS_GZIP
+	select HAVE_KEXEC_DECOMPRESS
+	help
+	  Enable to load the zboot image compressed by gzip
+
+config KEXEC_DECOMPRESS_BZIP2
+	bool "bzip2"
+	depends on KEXEC_FILE
+	select DECOMPRESS_BZIP2
+	select HAVE_KEXEC_DECOMPRESS
+	help
+	  Enable to load the zboot image compressed by bzip2
+
+config KEXEC_DECOMPRESS_LZMA
+	bool "lzma"
+	depends on KEXEC_FILE
+	select DECOMPRESS_LZMA
+	select HAVE_KEXEC_DECOMPRESS
+	help
+	  Enable to load the zboot image compressed by lzma
+
+config KEXEC_DECOMPRESS_XZ
+	bool "xz"
+	depends on KEXEC_FILE
+	select DECOMPRESS_XZ
+	select HAVE_KEXEC_DECOMPRESS
+	help
+	  Enable to load the zboot image compressed by xz
+
+config KEXEC_DECOMPRESS_LZO
+	bool "lzo"
+	depends on KEXEC_FILE
+	select DECOMPRESS_LZO
+	select HAVE_KEXEC_DECOMPRESS
+	help
+	  Enable to load the zboot image compressed by lzo
+
+config KEXEC_DECOMPRESS_LZ4
+	bool "lz4"
+	depends on KEXEC_FILE
+	select DECOMPRESS_LZ4
+	select HAVE_KEXEC_DECOMPRESS
+	help
+	  Enable to load the zboot image compressed by lz4
+
+config KEXEC_DECOMPRESS_ZSTD
+	bool "zstd"
+	depends on KEXEC_FILE
+	select DECOMPRESS_ZSTD
+	select HAVE_KEXEC_DECOMPRESS
+	help
+	  Enable to load the zboot image compressed by zstd
+endmenu
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
diff --git a/lib/Kconfig b/lib/Kconfig
index ce2abffb9ed8..18ab33511ee1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -304,6 +304,9 @@ config RANDOM32_SELFTEST
 #
 # compression support is select'ed if needed
 #
+config HAVE_KEXEC_DECOMPRESS
+	bool
+
 config 842_COMPRESS
 	select CRC32
 	tristate
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

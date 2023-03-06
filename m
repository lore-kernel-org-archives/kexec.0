Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65572C61DA4
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 03:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KpuCWWWFHUwFxGqkaJMz2YA/odPYXf7SFzgT7XdhRfM=; b=ZqYagFL0IbUgum
	0y6M1yvs5Z+2ZSmdri1HnQTUMuN+R3tjvMY7z9WJR5ChEA4PqhRfDlOOC3c1gdInGIRbaJUK2KIa9
	MGTEdlvt0jZwX71jaZtsEA9vRvIjLBsHMwFV1NKa9IHzok9la8IH01gl6VElSGjQaBJDKm5haNJ3T
	//DhwyClebvZf9mJQvTr31ynjFfwKEOVh0gZqp2w33oF3pqm5fzhe/WzKp5wkVApXHWtmptuSDt/P
	aAbu86R4JRn6HziJf1pyXxmGCNOth70lSLQgKFpOItG/wM93zceCI5n8MmKlsjg/oGZ4lurvGb00s
	7l178SDdDFtqqRZoS8iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ1Ay-00B43B-L5; Mon, 06 Mar 2023 03:06:12 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18j-00B2cD-TF; Mon, 06 Mar 2023 03:03:56 +0000
Received: by mail-pl1-x62a.google.com with SMTP id i5so8790483pla.2;
        Sun, 05 Mar 2023 19:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uajbUQnIewe2JrUK08Rp36GBFla2nyzidVlnhov4v/M=;
        b=WZrdj+Isk4V/hOXFfckOgIgGy2pe/UdwvvkYcjTx/ES3KpvHXYilLIihzQhVPAkbWK
         lRifRyBwzy0RYLjGmoSGWipsoXivSfkd9bF9QBKrG78Wg/xlcl5BTzQov+qetNjMIlxZ
         AFTwx1JskAjmAv824RVbHx5NE8menYuABnFqROV9p/yVqcha8fdwsZjGqSQGzfHCM7kp
         W8kjUxAmlWqI0aQsNB7ixF0CFaB3WxCH8HAkPk7p22i0bWO9wSoXtCp7ISf1Wosqf9MS
         8keWuJWbTGBuk5y9Dvf96qEB16dNVJEFH4c48AELbRLjqOBB5xM/HIMaV/BC2xwUlkaM
         Ur9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uajbUQnIewe2JrUK08Rp36GBFla2nyzidVlnhov4v/M=;
        b=crP8+l+ryO0l2CyXoGueR0gfynWe3JV5b85dqz/6/ORCeg1S5dEYooebseiGicubbi
         LbpdPPkOSaULirRa3ZxogIj39eOZOUqxVPY876bzwfPBKMRtJC8BF8uHfF0rWrnp6iTz
         5C0N6jJrquw7NXjwElNXcHRJLeH92WxpLRY1ncnDZaV5r3+8TcNNidwiua6aUZWw94LM
         e3XXXB7tbxEZ/nvm2lGiKK/vgWFxxgKFL3MR6h3D8YIxMC9G7kJOAj5Av7Q+WIAk0YKe
         /kMEYm4W6T/Ki+N0PhCE9kh/07Fo2B/480AANBwQkuN4zQSXrwbIBwURnWykRpnnfIDA
         fTMQ==
X-Gm-Message-State: AO0yUKX3Br/3WNDgcoR+hh2osL3MFeAevZ89sdFs/9FrEU9DQlt43MJd
	d51D8XsEZbLK9lg2JtMhHHrqappXrQ==
X-Google-Smtp-Source: AK7set8hmMUrNWIc99n8GyLvy/rglRTI9XgR+b/60jnclG8T/yq3ZeWruKe+7SgPeOeOv8u/sIa7qA==
X-Received: by 2002:a17:903:244c:b0:19e:3b41:1828 with SMTP id l12-20020a170903244c00b0019e3b411828mr10432774pls.22.1678071832295;
        Sun, 05 Mar 2023 19:03:52 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:51 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	kexec@lists.infradead.org
Subject: [PATCH 6/6] init/Kconfig: Select decompressing method if compressing kernel
Date: Mon,  6 Mar 2023 11:03:05 +0800
Message-Id: <20230306030305.15595-7-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_190354_039571_02097A20 
X-CRM114-Status: GOOD (  10.09  )
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

If choosing an EFI_ZBOOT image, the corresponding decompressing method
should be selected so that kexec can load that zboot image.

This can be achieved when "Kernel compression mode" is determined.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 init/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 44e90b28a30f..046724208645 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -269,6 +269,7 @@ choice
 config KERNEL_GZIP
 	bool "Gzip"
 	depends on HAVE_KERNEL_GZIP
+	select KEXEC_DECOMPRESS_GZIP if KEXEC_FILE && EFI_ZBOOT
 	help
 	  The old and tried gzip compression. It provides a good balance
 	  between compression ratio and decompression speed.
@@ -276,6 +277,7 @@ config KERNEL_GZIP
 config KERNEL_BZIP2
 	bool "Bzip2"
 	depends on HAVE_KERNEL_BZIP2
+	select KEXEC_DECOMPRESS_BZIP2 if KEXEC_FILE && EFI_ZBOOT
 	help
 	  Its compression ratio and speed is intermediate.
 	  Decompression speed is slowest among the choices.  The kernel
@@ -286,6 +288,7 @@ config KERNEL_BZIP2
 config KERNEL_LZMA
 	bool "LZMA"
 	depends on HAVE_KERNEL_LZMA
+	select KEXEC_DECOMPRESS_LZMA if KEXEC_FILE && EFI_ZBOOT
 	help
 	  This compression algorithm's ratio is best.  Decompression speed
 	  is between gzip and bzip2.  Compression is slowest.
@@ -294,6 +297,7 @@ config KERNEL_LZMA
 config KERNEL_XZ
 	bool "XZ"
 	depends on HAVE_KERNEL_XZ
+	select KEXEC_DECOMPRESS_XZ if KEXEC_FILE && EFI_ZBOOT
 	help
 	  XZ uses the LZMA2 algorithm and instruction set specific
 	  BCJ filters which can improve compression ratio of executable
@@ -309,6 +313,7 @@ config KERNEL_XZ
 config KERNEL_LZO
 	bool "LZO"
 	depends on HAVE_KERNEL_LZO
+	select KEXEC_DECOMPRESS_LZO if KEXEC_FILE && EFI_ZBOOT
 	help
 	  Its compression ratio is the poorest among the choices. The kernel
 	  size is about 10% bigger than gzip; however its speed
@@ -317,6 +322,7 @@ config KERNEL_LZO
 config KERNEL_LZ4
 	bool "LZ4"
 	depends on HAVE_KERNEL_LZ4
+	select KEXEC_DECOMPRESS_LZ4 if KEXEC_FILE && EFI_ZBOOT
 	help
 	  LZ4 is an LZ77-type compressor with a fixed, byte-oriented encoding.
 	  A preliminary version of LZ4 de/compression tool is available at
@@ -329,6 +335,7 @@ config KERNEL_LZ4
 config KERNEL_ZSTD
 	bool "ZSTD"
 	depends on HAVE_KERNEL_ZSTD
+	select KEXEC_DECOMPRESS_ZSTD if KEXEC_FILE && EFI_ZBOOT
 	help
 	  ZSTD is a compression algorithm targeting intermediate compression
 	  with fast decompression speed. It will compress better than GZIP and
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

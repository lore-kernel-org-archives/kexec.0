Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B026C5DF6A
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xf+ocxeCJgdee/7hRS+EL0NVdP4x1nusrTTdX8m6N0g=; b=bBa3XI7zEukrUti8tWqYJKZA0b
	PGklikHqVct30ut/T9ltPJpbpF6gHU99xNcUjFmtlg8XUGyNbTXNMj6tJgkPEAyGVYDwEUXBGHK/j
	UkiVT3fvfXqo7wonCPm3d5XpTm5ca/wKTOVYD6BvNRHkAXtZzkrZiQvmONbFSmHAL+tbRrBYFoQIE
	ZXCUeIuKr/guLJPqJwqR/bzIJw0WekprH5qydDe8Tzcc7AlvRX+z+a9YjEjyNhZaQ7GQsunM2KfZd
	+jR6FU8iGx5tJ2Bf4QD4W/uL/jOn1WOovA1+DMpShW8RvnhZ2zAarB/fG65nbNDxk4ge+6NplY4aL
	uFAp+92Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvEwM-00000003rmq-3OV6;
	Sat, 15 Aug 2026 14:00:50 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvEwF-00000003rlY-3Ob9
	for kexec@lists.infradead.org;
	Sat, 15 Aug 2026 14:00:48 +0000
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 557533FCAD
	for <kexec@lists.infradead.org>; Sat, 15 Aug 2026 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786802442;
	bh=xf+ocxeCJgdee/7hRS+EL0NVdP4x1nusrTTdX8m6N0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=q7DbWkas0KM+4CPBeZ/DjuXTe/yAyO7a9Y9SmdwdcTYThurYlJ9X97nbW8isu3hN8
	 wx8fkCneT7bTIjWCZ6j1ZVYMm6qe2KPXqG36XZ06cImBOQHsN+SzLUYwXNO/8Zdert
	 VK1rjDWa8uGJ6H/8RfHzhGVZZ4p3r3zgC95GrtNzo4TO1xyfyCu+lBHjRrGbzT3nVH
	 qnT5fhxBOQOANTmN5cCMwLkHEsi79eVf1ps/8gwqUne46+nVSw00fVyWadv7uMj7dN
	 yAyuCTDthJ6vKKeRV/xz7tfw7+pfgsiT8EzgodC8DR+jxfiCJrBAh26Ki32IiE7TvI
	 pCqLFPNwlBTZDRIiepp9YX8j4gExSici26n7qAKQY95lXy81MJ3Y/8L0Um3+kC3i4F
	 dCMZXPlZCE2GZDcF5eKXH3ULCtyhq0t0gVnXIQ8nIeWhSoqzMEN3rhfY+oSVOYA4az
	 jpKo1tD9xQ7tj4xaa+XROoY6uvYxKmVTfsr5Jxhoq1UkJT9ccR7a0+Y1bmBkOeHcXi
	 u4fO4abvnYPzp1yQRjeWHuufdnBeRMGZhb53K6AxTHZf6WDn240WcjWH/3eRN6Ts9y
	 8XuN6X0+/JyheUGXZjFRLFGj0n2UT1KhTH39KC/rm2IjFXvc9gWwYNQYQf4d8Ttrae
	 VMcW20YFq7Di55AvXosuOUGw=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47faa02f707so1302641f8f.1
        for <kexec@lists.infradead.org>; Sat, 15 Aug 2026 07:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786802442; x=1787407242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xf+ocxeCJgdee/7hRS+EL0NVdP4x1nusrTTdX8m6N0g=;
        b=Crel63/iZc5G+ufPDKdpt27su97MgZ951P7CYDOdxbbR0mUpgvdimbuIHuRw1yURhZ
         PMTaYerigA81dYX0+6QyBjSrRa+ssMdPfkkClMOBDZDGtNq2M2w0JzM9yoB9C9K3dMEx
         NxX35CWqV4BFrjRuXs71eNPh56k6Yv/kwVCV8uJVjYu8NADAt0QeDFufX6YcG6HiQqTC
         8U0wxanYLLTuHvXgz7EMQajIKGF4o/7eOrXHVAgIpvRiBgz5xyV130YX1O+BbCC0gGk+
         WFxu/CnOMBRUp0Fb1pcyZBfktzdHbOY3dxkRtkbg40Nx/u2LgWq1q3EMheIy6efUt6Ko
         DHTw==
X-Forwarded-Encrypted: i=1; AHgh+RpLI8+JhG8WMkOsAkXOgtgnOYBTStzIhVz//cLAJpvrdG0iCsCKXlbfR9RhA37DzEF6h1EzmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwvmnofMCEhvM0C2pPeQ2Zz2cOXrgTjny+cVmeOVl77TyDmp64x
	ksFPKiSR3NSBWIlQeV5+fs6pASeAGGsIQTE7Fy/XErP6XSrQcNIXeydKX4vliedjwDtxdtY4fgL
	pdPYaEi7AFvjekrlTZgMD/ItCCT1AtMkiOd9vis2UEqiHIrnJDBOm1nKtLq9zt+PSt1rCf8fd9T
	3TWA==
X-Gm-Gg: AR+sD10NSuftC+IuZHibWvYVr1RVLDMnsVd0EQ3XyNwEkA2mtgveN73QcIoUxvzaOWn
	oVtZaVc/cdJTerofxq2UiP2S5i8aYHVliSXDJl6d3hSOHEOhNFWQ6fpqNAQjUw8AGwsAG7fS+qZ
	Gd/FRE8cZrVtitOcwIVSELnCxVm/D0k3Slfp2UsrsuPnKrqy70iwTfTgzH7S11k/aajGD7hrzd/
	6TB6ERRQ8mAHIZLeRC8rOdQchYp0beSLUyd6VtPNx/USOLp7ZOZr1Py+9QKP/S7vfWUTM09OkQc
	4Th1tW0/4oUHR80qFg/Rijm7fX2xErpPH749gmWWPCy0dmSBsLN/VMxmVFp2Ek4HCXJRmj8JdDM
	34fASEi8O/lwYLzVDnzDWUPVbudrzTlysbztTSsf3PT3eDO0D4XzUl4gfslIbfRI2OWA7IGQl1E
	oeQXzR6aNl5926QSkUp2hh+PYqxrBUJGU=
X-Received: by 2002:a05:6000:1a8c:b0:481:562d:6fb1 with SMTP id ffacd0b85a97d-4816075be23mr18511399f8f.6.1786802441751;
        Sat, 15 Aug 2026 07:00:41 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8c:b0:481:562d:6fb1 with SMTP id ffacd0b85a97d-4816075be23mr18511293f8f.6.1786802441260;
        Sat, 15 Aug 2026 07:00:41 -0700 (PDT)
Received: from t-14.home (2a01cb000883230031a3fd8213e7cff4.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:31a3:fd82:13e7:cff4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f20051esm18433563f8f.7.2026.08.15.07.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 07:00:40 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] crypto: asymmetric_keys - add KUnit tests for the PE parser
Date: Sat, 15 Aug 2026 16:00:20 +0200
Message-ID: <73155550248025620873094809432c88ffa4c3d6.1786802052.git.fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fcbc6b4d5855ba42a0fccf335b2604ef0b36f092.1786802052.git.fabrice.derepas@canonical.com>
References: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com> <fcbc6b4d5855ba42a0fccf335b2604ef0b36f092.1786802052.git.fabrice.derepas@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_070046_089198_B812D006 
X-CRM114-Status: GOOD (  19.44  )
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

Add self-contained KUnit tests for pefile_parse_binary(), exercised
through verify_pefile_signature() -- which parses the image before any
signature check, so no keyring or real signature is needed. The cases
build small malformed PE images in memory:

  - a PE declaring 0 data-directory entries: the certificate table entry
    at fixed index 4 is absent and must be rejected (-ELIBBAD), not read
    out of bounds;
  - a PE declaring 5 entries with a zero (unsigned) certificate entry
    gets past the directory bound and is rejected as unsigned (-ENODATA).

verify_pefile_signature() is not exported, so the test is built-in only
(bool, not tristate).

Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
 crypto/asymmetric_keys/Kconfig              |  12 +++
 crypto/asymmetric_keys/Makefile             |   2 +
 crypto/asymmetric_keys/verify_pefile_test.c | 100 ++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 crypto/asymmetric_keys/verify_pefile_test.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 6a2f66404..c73979b2e 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -114,4 +114,16 @@ config FIPS_SIGNATURE_SELFTEST_ECDSA
 	depends on CRYPTO_SHA256=y || CRYPTO_SHA256=FIPS_SIGNATURE_SELFTEST
 	depends on CRYPTO_ECDSA=y || CRYPTO_ECDSA=FIPS_SIGNATURE_SELFTEST
 
+config VERIFY_PEFILE_KUNIT_TEST
+	bool "KUnit tests for signed PE file parsing" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && SIGNED_PE_FILE_VERIFICATION
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the PE binary parser used by signed PE file
+	  signature verification.  The tests build small malformed PE images in
+	  memory and check that pefile_parse_binary() rejects them instead of
+	  reading out of bounds.
+
+	  If unsure, say N.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98..35172685c 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -79,3 +79,5 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+obj-$(CONFIG_VERIFY_PEFILE_KUNIT_TEST) += verify_pefile_test.o
diff --git a/crypto/asymmetric_keys/verify_pefile_test.c b/crypto/asymmetric_keys/verify_pefile_test.c
new file mode 100644
index 000000000..8b42eb41e
--- /dev/null
+++ b/crypto/asymmetric_keys/verify_pefile_test.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the signed PE binary parser in verify_pefile.c.
+ *
+ * The cases build small malformed PE images in memory and call
+ * verify_pefile_signature(), which parses the image before any signature
+ * check, so the parser is exercised without a keyring or a real signature.
+ */
+#include <kunit/test.h>
+#include <linux/slab.h>
+#include <linux/pe.h>
+#include <linux/verification.h>
+
+/*
+ * Build a minimal PE32 image whose optional header declares @data_dirs data
+ * directory entries.  header_size is sized to hold them and the image is a few
+ * bytes larger.  With @data_dirs < 5 the certificate table entry (fixed index
+ * 4) lies outside the declared directory.
+ */
+static void *build_pe32(u16 data_dirs, unsigned int *out_len)
+{
+	size_t cursor = sizeof(struct mz_hdr) + sizeof(struct pe_hdr) +
+			sizeof(struct pe32_opt_hdr);
+	size_t header_size = cursor + ((size_t)data_dirs + 1) *
+				      sizeof(struct data_dirent);
+	size_t pelen = header_size + 8;
+	struct mz_hdr *mz;
+	struct pe_hdr *pe;
+	struct pe32_opt_hdr *opt;
+	void *buf = kzalloc(pelen, GFP_KERNEL);
+
+	if (!buf)
+		return NULL;
+
+	mz = buf;
+	mz->magic = IMAGE_DOS_SIGNATURE;
+	mz->peaddr = sizeof(struct mz_hdr);
+
+	pe = buf + sizeof(struct mz_hdr);
+	pe->magic = IMAGE_NT_SIGNATURE;
+
+	opt = buf + sizeof(struct mz_hdr) + sizeof(struct pe_hdr);
+	opt->magic = IMAGE_NT_OPTIONAL_HDR32_MAGIC;
+	opt->header_size = header_size;
+	opt->data_dirs = data_dirs;
+
+	*out_len = pelen;
+	return buf;
+}
+
+/*
+ * data_dirs = 0: the certificate table entry (index 4) is absent, so the
+ * parser must reject the image instead of reading ddir->certs past the end.
+ */
+static void pefile_missing_certs_dirent(struct kunit *test)
+{
+	unsigned int len;
+	void *buf = build_pe32(0, &len);
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	ret = verify_pefile_signature(buf, len, NULL,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	KUNIT_EXPECT_EQ(test, ret, -ELIBBAD);
+	kfree(buf);
+}
+
+/*
+ * data_dirs = 5: the certificate table entry is present (and zero, i.e.
+ * unsigned), so the parser gets past the directory bound and rejects the image
+ * as unsigned (-ENODATA) rather than -ELIBBAD.
+ */
+static void pefile_present_certs_dirent(struct kunit *test)
+{
+	unsigned int len;
+	void *buf = build_pe32(5, &len);
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	ret = verify_pefile_signature(buf, len, NULL,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	KUNIT_EXPECT_EQ(test, ret, -ENODATA);
+	kfree(buf);
+}
+
+static struct kunit_case verify_pefile_cases[] = {
+	KUNIT_CASE(pefile_missing_certs_dirent),
+	KUNIT_CASE(pefile_present_certs_dirent),
+	{}
+};
+
+static struct kunit_suite verify_pefile_suite = {
+	.name = "verify_pefile",
+	.test_cases = verify_pefile_cases,
+};
+
+kunit_test_suite(verify_pefile_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for the signed PE binary parser");
-- 
2.53.0



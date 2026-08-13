Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D88C5B572
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qCW1V67Ahu0HN7EbgMsfgf+m2evOSojVUf49w/6VGa0=; b=dUNOoAOD6MEQZQQUy+srSn2821
	8d0uC6XeED4Begk4zbplN1QzzX30YQ7mRelCHErbcB/LN0ZMnVJzsG15ZpIYMswBq8lJMZbv0s5a7
	/SfHGaalMOLnbktEhJjDlodkZmEU5pg2XXT+t80ACNHCmtDD+x7qFuR1jDt0DUmJczeYduE/p861d
	VaVvXQFWhFH4lAUz7miUXefKla/hZ5wBadfrruDDI429o1T3zeSPocr+J7S9894q4acfCP/5qeWKc
	9rYVeo6K7qUsSilsBpeeRF6JFs6tE02CBCgZ0Lss90WgSuYLDfrJPjW9jGSwDdR/mhq4cv7mK2gOj
	py9LbEwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wua8S-00000001Nlc-2ODA;
	Thu, 13 Aug 2026 18:26:36 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wua8M-00000001Nko-1Wpg
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 18:26:35 +0000
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A2843F135
	for <kexec@lists.infradead.org>; Thu, 13 Aug 2026 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786645587;
	bh=qCW1V67Ahu0HN7EbgMsfgf+m2evOSojVUf49w/6VGa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ddd1oDHfGwcOo5EHu8r1kSY5fl1nBvaT6vZL+fSNJo1Pw6cz5qMXrxQZJpkWl+wDu
	 /WqwjNFipMGVghfYQ381WkojYeY9pOBWTGybUZqxahDnjmLTHRjTcMXh1DIRbgkzDu
	 FWzlV4JX3ZLzFdrfn7WEIN7jBsDg9T8DoZ5NVfMmzi7tUUf/KNLe9FIN1+daxumwe5
	 Dsj957jMuO0CHsL7FqQNZ9WcFmG7tTDjVNvmVjk9JPg0wcO8vsB5LwH9ho/1JESI9H
	 +B2gnzx0bKkvG+INlBwA+8r/RCSDVGw3fMwJ/5G3uD3U07axp7BSK4GS8elm5oekf8
	 lPcJ9ci+QB/DfsUVzxQsY3hvqd5581kZhy5EGPA+Mi6KgNO2JgimpMVR7MQKkBTfIw
	 M/4Cxs8errL7OB2zisObeXDJ8UYR++oCnEeQahB/rEmqfTT7XXEECYNmbrEfDZf5Ul
	 S6ASArJkNk7DBvvPhy3iTgCiRawlEptyx8avPRKH6QJIB9rpZGtuDVzaFuHm+9uKEj
	 8Vx8EKV5DI6LGFtWNbQNP+FK4l7B8h3cuf3n0DG8jCxdGTXMUDdSYzwPaQaRXceK4H
	 p+i6KvDA+tYLS/uL9pHLacfbD7L29IGXvh2ItERiMg4yHikZHzkFryEjW6qK9j2rs+
	 c6SoeMujcZlURBwapQx3UFCc=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e658363so76866f8f.3
        for <kexec@lists.infradead.org>; Thu, 13 Aug 2026 11:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645587; x=1787250387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCW1V67Ahu0HN7EbgMsfgf+m2evOSojVUf49w/6VGa0=;
        b=mXrGUaLqbmXdDv1UJBXtxwDkb/Y9kltvU1bWcPdsIPNe0FaT8u7tH0/Va1s+K7F3tz
         QLvCa7K6cgBuM76MFHT4TulecotRuf/CZxe+Ic0VKB1A7K9a007pfhFQH4nwBkOsFJ6M
         zDSgv0elmgcsnFFxi/VZYDB0Pt0o3+l4XlYY3sTiBAkqSUsvMByQu/F2AEWBEnBy8+uu
         2oOppAf/6CZp8v+WhnDUkx3Uk9dkNCw6tBLyD/J8rhvPcJjW07BbMhOtfmNgp6lTIilf
         77ORxh4MRKJDn1pWyAQN9WbXGOflJjRP5URD8FTbiD/3JMH1WwU3mBGUhKK3f3vx8Rg3
         zuxg==
X-Forwarded-Encrypted: i=1; AHgh+RrGREWlr6QU3Hd80fzTXTek/RrXSLt8RRGrCRL7JdR7cjsf03GUFtTTxnuoP/KQ2gxgcQypBA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0h924RXiUsZKx/zpL5Ix0es7RmNGCXPt+nq4ABz+raAoNoMKB
	QFow6eSTJop7L59Z5eIfgkdVkE5xNjDD4DAoBiCllMFkhZJ3VINeaV7GEpcfv4QtEMnBqSLXjxZ
	lCv+vpuql/6ruSuV312c6lrInnUTvy2X497gcnYuRQcUmhqIY3o8Sbk6UTQf0S8hhrTz0urYDjW
	omiQ==
X-Gm-Gg: AR+sD12iTEqPKfRH/tEevIQ5J46JVdHvqqisTmI0b9qnq2qyD5nDUXrnvVaJGZhRyJ+
	i+iMTY1frU4EsIhlf3OPIJN801gCGH++HvxHPrW5KtdLLar+nNbrptKxxpwhtodApC81JGWpHc2
	nQgr+zJyqP4xLBIc4h2+QDZpGKsLfvNENSpu/rG4E4Zdjxa5J1oqbjuHb1P4Pr/E68TbBOuKMyb
	ZfwepFf6+/6o1mqDpaD5KqcTiZZEL2jYkm/dCOutF4bIAjAdas9SireOqaGkIagGAqD6iasY22o
	vYgB6mLQ8m4+Kc8IaW3ITne9Qhs05gZOx5RGncMy1kc5TU5kqLn8I2nUpiHqr1J0unh7AvdyRpQ
	/SHmTzMfB7y5D/8GWHCaxJu1rQflMA5cd3zyjtHepVWF106AoE78aX5hDDCVsVLWqIkY9uss/XZ
	I5OzF+9ZC3v3UHjKBLL3cfWUek
X-Received: by 2002:a05:6000:460c:b0:47f:e886:6dff with SMTP id ffacd0b85a97d-481606f67e3mr361526f8f.4.1786645587197;
        Thu, 13 Aug 2026 11:26:27 -0700 (PDT)
X-Received: by 2002:a05:6000:460c:b0:47f:e886:6dff with SMTP id ffacd0b85a97d-481606f67e3mr361461f8f.4.1786645586742;
        Thu, 13 Aug 2026 11:26:26 -0700 (PDT)
Received: from t-14 (2a01cb00088323008940b17acf2a49f2.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:8940:b17a:cf2a:49f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f229681sm995577f8f.16.2026.08.13.11.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:26:26 -0700 (PDT)
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
Subject: [PATCH] crypto: asymmetric_keys - bound section data range in pefile_digest_pe_contents
Date: Thu, 13 Aug 2026 20:25:36 +0200
Message-ID: <20260813182546.138705-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_112632_973485_85B1B7CF 
X-CRM114-Status: GOOD (  16.80  )
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

pefile_digest_pe_contents() hashes each PE section with

	crypto_shash_update(desc, pebuf + ctx->secs[i].data_addr,
			    ctx->secs[i].raw_data_size);

where both data_addr and raw_data_size come straight from the untrusted PE
section table. pefile_parse_binary() bounds only the section table's
location, never the sections' data ranges, and nothing else on the path
checks them. A section with data_addr and/or raw_data_size pointing outside
the image therefore reads past the pelen-byte buffer (CWE-125); a large
raw_data_size makes it read far past the end and fault.

Commit f7dd32c5179d ("crypto: asymmetric_keys - fix OOB read in
pefile_digest_pe_contents") recently fixed a sibling underflow in this same
function (the hashed_bytes + certs_size trailer computation); the
per-section read below was left unchecked.

This loop runs only after verify_pkcs7_signature() succeeds, so it requires
a validly signed image -- but not an attacker signing key. The PKCS#7
signature covers the SpcIndirectDataContent (a self-contained digest in the
certificate table), not the live section bytes, so tampering data_addr in a
publicly available signed image leaves the signature valid at that step
while the out-of-bounds read fires when this function recomputes the
digest. It is thus reachable by a local CAP_SYS_BOOT user via
kexec_file_load() with a tampered signed image; the access is an
out-of-bounds read only, but a large raw_data_size faults, which is a
denial of service when panic_on_oops is set.

Reject a section whose data range does not lie within the image before
hashing it.

Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKCS#7 data")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Note: f7dd32c5179d, which fixed the sibling underflow in this function, was
assigned CVE-2026-64544; this closes the per-section read it did not cover.

Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64). Two things were shown:

  1. The defect + fix: a KUnit case calls pefile_digest_pe_contents() with a
     crafted context whose section has data_addr = pelen. Unpatched:
     slab-out-of-bounds read; patched: -ELIBBAD before the hash.

  2. The reachability, end-to-end against a real trusted keyring: a real EFI
     binary was signed with a test key embedded via CONFIG_SYSTEM_TRUSTED_KEYS,
     then its section data_addr was tampered (leaving the PKCS#7 byte-identical).
     Results from verify_pefile_signature(): the untampered image verifies (0),
     one signed by an untrusted key is rejected at verify_pkcs7_signature()
     (-ENOKEY), and the tampered-but-trusted image passes that step and takes
     the OOB read in pefile_digest_pe_contents(). So no signing key is required.

The KUnit case (item 1) is easy to package and I can submit it separately; the
end-to-end setup (item 2) needs an embedded trusted key and signed images, so
it is harder to ship standalone. Neither is included here.

 crypto/asymmetric_keys/verify_pefile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db..4e84fcf 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -292,6 +292,11 @@ static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
 		i = canon[loop];
 		if (ctx->secs[i].raw_data_size == 0)
 			continue;
+		if (ctx->secs[i].data_addr > pelen ||
+		    ctx->secs[i].raw_data_size > pelen - ctx->secs[i].data_addr) {
+			kfree(canon);
+			return -ELIBBAD;
+		}
 		ret = crypto_shash_update(desc,
 					  pebuf + ctx->secs[i].data_addr,
 					  ctx->secs[i].raw_data_size);
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.53.0



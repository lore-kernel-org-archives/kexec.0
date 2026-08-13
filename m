Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C51C5CFCF
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v4gKNmrcl/ldyDb/KPnMDoGw2a6pO4iklkGUcioG2dw=; b=ba7Dddg8NUbhangkztuhjknqN2
	5EelSRdMOXUKJSxlsjbd6J+kkWDik05hzahL2yam+Pc4LfgT7LdkxBTW8JYHCcdPa6YVsQpP9gaNL
	kxU7BysvUI98Bc5gz+wDN6rOnlYTjG0NeIHFTX1nSKEl9fVcSNOqzgCEAMFbvPIQHXX/rIXgdnyFX
	0he+//VfedypXoKnqMxuA3qetS76rJzPSGSY297Oy11a/YjpMjFSPPWWdSbmi93CxaYLFYgwk1qL9
	Nw4sWB9LZrzn2lZbI6z5BgKxNTnUYh/OS8Qx2shNTU/tivMN29lLIZs5ErY9OYpsnxqmNbZmEl23V
	0X4jF7ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYk8-00000001D9q-37jC;
	Thu, 13 Aug 2026 16:57:24 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYk5-00000001D8i-1AWd
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 16:57:23 +0000
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DD8173FC3B
	for <kexec@lists.infradead.org>; Thu, 13 Aug 2026 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786640235;
	bh=v4gKNmrcl/ldyDb/KPnMDoGw2a6pO4iklkGUcioG2dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=jdk0cchKFh0+3KTIUUoaEU594EzICF17vl9sq4C1ObaND1GDlbhwwjM/RiIyMuQ0d
	 Lg4y+WS2fJrOsVQqmoqXmZdLYdwSfDTmBnauQgCnbt8WqPojH3N8HHg/InawgsDwlw
	 1cXUYYa4nvqiXa7eOz9wLfRMr3xXFoHkpqhybF8jpAaUznVDA+tDzLMuMLGRBNYzhI
	 kXXfA9lsNP5AFB/Kjltt8DNHkM1NGAPNbjHSEFlTiqVWNDdt/qQraJDX2DW6Q1D5AM
	 uAyPkfxMFkrV/NPH7+aOt1T/RbxOPhMriD2vypLzmHyTGGrSCmX7oRMYOXsUMHIYup
	 hNBJBbEHMbr4lKBIVNwy4cPbSgquGI1r8BGy/HK3jNCjnDJbcBRkkrmFNgfogfl+CR
	 tOewMDo5ENVyuw/iM8vop44syZzl+aJkE1Bf+lyU78+ZXJAtEGyZMSzxqg29WiST/6
	 nbV1DcwasQdiH8wcFOGZENhETKQgQdejZTe7K1FiTfza1W/TxxCxSeQQEEVy6dOAI5
	 Tz0KaTi/79r+vz0fFoAQ5AVa7OI16ORUjr6+TudbTIDlyS76kjLEupEHNNq7koo577
	 4jFUZ87o8GaoKzHjIiNir7DNHD+UloRfc9aYvHt6ZJSX/mtFcMMGjX5+ZHvUhOunGe
	 rrnWlYOhfJcryRpuAbV7/tg0=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so986205e9.2
        for <kexec@lists.infradead.org>; Thu, 13 Aug 2026 09:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640235; x=1787245035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4gKNmrcl/ldyDb/KPnMDoGw2a6pO4iklkGUcioG2dw=;
        b=g0XkDwLPMcQa/2yY9qg2mVUpka2zvUj/9b00l01D7xRoisGKgmO6/eysVsakiV0Bpi
         dGi+4yUOsMKFd0WGLO99IvQtueSMziFZsYQWeA9GzID/sbbFsrePsNce4veoxsybUTj4
         srhwWyzyQugrvNNDUtMcIZIjYwB0lG/C+MF6tIQddLpMyq1arFs6Zj35KpL4FeW4E3H1
         yEepigBta5pWTw4mp5yATVuNn4WeOmNEASiJ3RLzsiiBcphb8rv8hW33qG12SFbyJxzj
         cmk3MUy6hYy57ufbChNTAsZVakUN8aeQHIubcwycLCfgSlaUCycu10tvYNO0EAunslyW
         Avqw==
X-Forwarded-Encrypted: i=1; AHgh+RqFAKTHJ07/Z4uGW/mg4sczSMs7hOxxcPxDvHPKUuxg5Z9E3Os0TjK5sdYnPZtl/msVOR3ebA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyfk3u5fSpkLGItF3xNz8kff/E9YEVnzAGrPc+eE7w06vMBy9FW
	sn5Otfcy11RdOa6aJqsVvqewv07N3DOVzwS/OAfNPHRaU75436ClA86xO14nepA/2YYw9/NMrAw
	AcsoH3Q+egNKDugPYq8Gu7fAKk9KOwTnIq4x4frvblM3HEh71xBvfRKbDZ4MDhi8XT5w5/bWF9S
	5Erw==
X-Gm-Gg: AR+sD10e6dDZ9xH87BnYjSzHTIAR1FWwSbUOZ1Igq3JeFbJ0zOMngnxPOOrwtznrKvi
	yGX+L5Kd+jOiAAtVUDoD9PMax62ef2phHc7ExZUn7cYaQvan2iXrbmmI8ZN7QzEY+jfcFKGGzxQ
	rRFFSMi8mInk0KF0O5XKLWFrqcEJ+T2E+0vgVUofYVptqIVif2zi+XJDWc2QYn+hKeCBXd2heot
	aBtnxCR/n98iu3Ip+X+mvlFXgYUJrIxucMM8SU6mOR+YZhQPZPJJlT/xNYtDYr6exs5PdTYAnY2
	3RxkM2JH8Uv+Js01eGb6u74/9fyppJFNeTzLAXhbJjd+QhtX7MyE1vzWNsoCPoHF2N3TUd/z93M
	7BuWAKXHXGXx5eoOBzqzdEqcS/JS77oo4L4zU6jHVS/GxgYZk9/3bCn1iyvksOi+C0as4aSym5J
	fOXB9BtzejaDGzbKwWYd+jX9vi
X-Received: by 2002:a05:600c:1d19:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-499821548efmr108289035e9.2.1786640235330;
        Thu, 13 Aug 2026 09:57:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1d19:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-499821548efmr108288525e9.2.1786640235000;
        Thu, 13 Aug 2026 09:57:15 -0700 (PDT)
Received: from t-14 (2a01cb00088323008940b17acf2a49f2.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:8940:b17a:cf2a:49f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm574151f8f.34.2026.08.13.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 09:57:14 -0700 (PDT)
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
Subject: [PATCH] crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
Date: Thu, 13 Aug 2026 18:56:45 +0200
Message-ID: <20260813165654.36098-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_095721_776149_CCF2BE33 
X-CRM114-Status: GOOD (  15.73  )
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

pefile_parse_binary() reads the size field of the certificate table's
data-directory entry, which sits at fixed index 4 of the PE optional
header's data directory:

	ctx->certs_size = ddir->certs.size;

but nothing ensures index 4 is present. n_data_dirents (the untrusted
NumberOfRvaAndSizes) is only upper-bounded against header_size and may be
0, and header_size need only satisfy cursor < header_size < datalen. A
crafted PE with n_data_dirents = 0 and a tiny header_size therefore causes
the ddir->certs.size read to land past the end of the image (CWE-125). The
chkaddr() that bounds the certificate blob runs only after this read.

verify_pefile_signature() is reached from kexec_file_load() (the
lockdown/secure-boot enforced PE-image signature path), and the image is
parsed before its signature is checked. The trigger needs CAP_SYS_BOOT and
the access is out-of-bounds read only (no write).

Require the certificate table's data-directory entry (index 4) to be
present; the existing upper-bound check then keeps ddir->certs within
[cursor, header_size).

Fixes: 26d1164be37f ("pefile: Parse a PE binary to find a key and a signature contained therein")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that
builds a crafted PE (valid MZ/PE/PE32 magics, data_dirs = 0, header_size just
past the optional header) and calls verify_pefile_signature() with a NULL
keyring -- the parse runs before any signature check. On an unpatched kernel:

    BUG: KASAN: slab-out-of-bounds in verify_pefile_signature+0x1d6/0x950
    Read of size 4 ... in pefile_parse_binary() (inlined)

With this patch the crafted image is rejected (-ELIBBAD) before the read and
the case passes with no KASAN report. The test is not included here; happy to
submit it separately.

 crypto/asymmetric_keys/verify_pefile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db..e7f8bdb 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -87,6 +87,10 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*dde))
 		return -ELIBBAD;
 
+	/* The certificate table entry is at fixed index 4 of the data directory. */
+	if (ctx->n_data_dirents <= 4)
+		return -ELIBBAD;
+
 	ddir = pebuf + cursor;
 	cursor += sizeof(*dde) * ctx->n_data_dirents;
 
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.53.0



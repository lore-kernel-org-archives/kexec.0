Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357E2C5CFCF
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 22:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kMizY76jEizmA24XR5LtanW2cG+cuGuImxHD37owg3s=; b=SEN1ZhPoXb2C37qmPJXrUOvi4Y
	GLOlPv/UKaiuFOlJl02EC3gWZuN8fd25Eob6mSjsc3F7AWP2CVVLFfS8CdxkrO6jQp80J/uDq6G6i
	6JP6hIglDdLncQib0PPPPMzDws1hL97/ycLWCYtxW5Wjt1qLRRDYRRKKDtyDcV8vgFlQ2LywAtZaf
	7ZR+wdSomorQzSlgZ+SOBb9mUeY14/8yultcID9n0HV5IYrAzevf0PIlvUDe5O71rUV+LWkMBJN/r
	2db3h+QLZ4zMo8um94U9rpYayaUzSit7kDtLDmYXTFqib4i94Pix/3qApTSmYedrFOUik5F/nrOa/
	/4RZ6oKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv03I-00000003FHW-3nCh;
	Fri, 14 Aug 2026 22:07:00 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv03D-00000003FFx-3wMO
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 22:06:59 +0000
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 98F3B3FCAB
	for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786745211;
	bh=kMizY76jEizmA24XR5LtanW2cG+cuGuImxHD37owg3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=YBfUFt5Oci7sba3uogT1jS5DzB1iVmFiGlrRkzihI/UOZB3EfU92au9wz4aKlLn02
	 n1Ag5XE0odB/CevItd9t7IbJvUr3h0cI8G/skTgfjkTNoeakbjqdiUtSg1aM4/fTLc
	 MHM+Kwaz2LcXMiua8MRg7T5J5m3I5Dcf7tJRMkBAruWKovVHN7rGQDQvq7K4c5ulki
	 Arh/ODP+No4gG2gE46AwXITdhuT2o2Z7CtoWi/dPlUGerAPZa5F3f/MtFjoNTLm7QD
	 4rq7gRp6cBkrx6kD59C5TmZii0jXaYOgRNH0KiuBNsu2mhuczu6DBKxiIjK/xeXp8b
	 fs9Cv2hh6uAOizcMtKx2epL2+x6QLn+l1rBdXeA1LlQ5DyB5WOiUFjTaOMlsr0cV2I
	 M9hjZiSv1Kdt21E4vRDyWWgvqBdV9Lj6DNXZ23UdI3tWaMwo8cpUhfEDV72d3Fv9vf
	 dAw5K3BEieWl7tDJvrzY39UIMgyTTHINYBtFQ6u4zz6w0cTF5YFgsw4B1BJCqVDETq
	 +RL6blnXY4EDmFw2SylNFaNMO8VBicW2t9t2q4OAytDDVCPrqjOg0GF5f2gz6+7BTY
	 gybsdvsONhH7jJmCinFWGsNOgObxIPgJqdUEam7omxBx3c1mENCfDxw4gzPaL4OLU2
	 tI4p7kd6iPSeZ8fFm4VzkaZo=
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47162f83c75so1337794f8f.1
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 15:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745211; x=1787350011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kMizY76jEizmA24XR5LtanW2cG+cuGuImxHD37owg3s=;
        b=l0VzvXfNQd8KXAkRS334s2A+jIuxaBtnTfCjYs9tBWDaW3sASvU4/AcDDygqiQ/Puw
         75v4DYaCz9lP4FfhpIgxtUMPOHu+wlFEb2T2fsYNgSFkasRCcL/nBYF1/o9F32389055
         cKpw7ZA5Yo82VrkG/04BB+rLyoMPQbp1AU3XyLXrXxHWRcF9aAmIPCz6jlxbGpe3DGYB
         pfqhN+z/P2tVP6CVDHzKX4WTfaDDkj7ZPcctzX2/zGVZCxWM0QSDCC3mQn++afEp94z0
         kiUriC9P/DipjHQpdZkgLH3S7M+x/QRvfP0VXKAejTtEAec3znauziBEDdnbNhwX1ycY
         UAZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+Xo++XtINXcKiE1Ts9aOvQgwevA8xjdDafbBE1K5Zt7PlwUo2ofKke9KJG2J2RSghqJiGmg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzttwHwsx0IuRrvNUGLoIOvBGzwk5S9bdZGnW5j3Zeic1RYBu55
	Moo1NCr3jAgXOIdT8ykAyfFKX6m4deVeCKYMCtLp0UPf6QJaL7qHKh7Z/KlbG/5j2PmZbLwrV4G
	xogKrvdi3awscFBBR6dVT5bCo1GQSIE/0zHyih1EyWo1I0B4UdewnL18ZqXywvSy71HUz9BOv7e
	zzcg==
X-Gm-Gg: AR+sD10BnWuT2S7hOonCM9PB8JJxaKQWafLi6NmomX3o6IhzmZNa3oEKYO9A5vhTzXX
	JrGYxi3I5K0JwpSQp1QpejH6ONayKAywgYWqcQ3wFJ/43mn4jnsBvUy56/bHNpPKlXUeqteHzGD
	WTWMUy9LBqKXRTLYFfzPPU7Rqn7bSNb0F45eaL+NkpSDt1LlUUu8+SzbZdAXCcudC7FqQvwISzs
	ZyZWUNEMGk5WJlns7idr57hsRLGqBA8VshtbxXaTzQuTsNME9YI9xvxF//nNLi3okg+3TLjdkZ+
	Uma5HRQYXvUdyJ3PmpiswTImNC8Mfln0NOrse8zx4EeeOtmICnURJHu5CbZGlJj02d5rjDe7Jui
	4YMbQ72YULyJ7WPowCZ8n6wuQgeaXoMWlfHjNy2nSwbnfTeO+vR/wbeK74ZEEU1jfMpVP3NjVA+
	ic6cyaKuOCzVl/tAcSgc/ajkXI
X-Received: by 2002:adf:f288:0:b0:47f:f002:3656 with SMTP id ffacd0b85a97d-48160797e95mr11067518f8f.12.1786745210986;
        Fri, 14 Aug 2026 15:06:50 -0700 (PDT)
X-Received: by 2002:adf:f288:0:b0:47f:f002:3656 with SMTP id ffacd0b85a97d-48160797e95mr11067469f8f.12.1786745210451;
        Fri, 14 Aug 2026 15:06:50 -0700 (PDT)
Received: from t-14 (2a01cb0008832300cfadf2438a4761d3.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:cfad:f243:8a47:61d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219e12sm10376551f8f.10.2026.08.14.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:06:49 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: Ignat Korchagin <ignat@linux.win>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: asymmetric_keys - bound PE section ranges in pefile_parse_binary
Date: Sat, 15 Aug 2026 00:06:28 +0200
Message-ID: <20260814220631.1101496-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
References: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_150656_438714_30A46FF0 
X-CRM114-Status: GOOD (  18.38  )
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
section table. pefile_parse_binary() bounds the section table's location
but not the sections' data ranges, and nothing else on the path checks
them. A section with data_addr and/or raw_data_size pointing outside the
image therefore reads past the pelen-byte buffer (CWE-125); a large
raw_data_size makes it read far past the end and fault.

Commit f7dd32c5179d ("crypto: asymmetric_keys - fix OOB read in
pefile_digest_pe_contents") recently fixed a sibling underflow in this same
function (the hashed_bytes + certs_size trailer computation); the
per-section read was left unchecked.

The digest loop runs only after verify_pkcs7_signature() succeeds, so it
requires a validly signed image -- but not an attacker signing key. The
PKCS#7 signature covers the SpcIndirectDataContent (a self-contained digest
in the certificate table), not the live section bytes, so tampering
data_addr in a publicly available signed image leaves the signature valid
at that step while the out-of-bounds read fires when the digest is
recomputed. It is thus reachable by a local CAP_SYS_BOOT user via
kexec_file_load() with a tampered signed image; the access is an
out-of-bounds read only, but a large raw_data_size faults, which is a
denial of service when panic_on_oops is set.

Validate each section's data range against the image when the section
table is parsed, reusing the existing chkaddr() bounds macro. A malformed
range is rejected with -ELIBBAD at parse time -- before signature
verification and before any hashing -- so a bad image is never digested.

Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKCS#7 data")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
v2:
  - move the check into pefile_parse_binary() and reuse chkaddr(), per
    Ignat Korchagin's review [1], so a malformed image is rejected at parse
    time -- before signature verification and before hashing. v1 put the
    check in the pefile_digest_pe_contents() section loop.
  - because chkaddr() runs on every section, v2 also validates zero-size
    (raw_data_size == 0) sections, which v1 and the shipping digest loop
    skip. This only rejects a zero-size section whose data_addr points past
    the image -- malformed input that real PEs never produce (.bss uses
    PointerToRawData = 0, which passes) -- and matches the "don't start on
    malformed data" intent.

[1] https://lore.kernel.org/all/CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com/

Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that
calls verify_pefile_signature() on real images: a signed-then-tampered
image (a section's data_addr set to pelen) is now rejected with -ELIBBAD in
pefile_parse_binary(), before verify_pkcs7_signature() and with no KASAN
splat, while an untampered signed image passes parse and reaches the
signature check (-ENOKEY, as the test key is not trusted in this build).
v1's KASAN repro -- a crafted context taken straight into the digest loop --
showed the slab-out-of-bounds this prevents.

 crypto/asymmetric_keys/verify_pefile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db14..c447597f7 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -30,6 +30,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	const struct data_dirent *dde;
 	const struct section_header *sec;
 	size_t cursor, datalen = pelen;
+	unsigned int loop;
 
 	kenter("");
 
@@ -112,6 +113,14 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 		return -ELIBBAD;
 	ctx->secs = pebuf + cursor;
 
+	/* pefile_digest_pe_contents() hashes each section's raw data using
+	 * these fields directly; reject a section whose data range falls
+	 * outside the image so hashing never reads past the buffer.
+	 */
+	for (loop = 0; loop < ctx->n_sections; loop++)
+		chkaddr(0, ctx->secs[loop].data_addr,
+			ctx->secs[loop].raw_data_size);
+
 	return 0;
 }
 

base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
-- 
2.53.0



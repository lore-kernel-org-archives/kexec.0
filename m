Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A7C5DF6D
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86RGpNX2OsGBlms7o5V2IbYeBS1f1PX4b53IjP+9t+M=; b=GsC/5YPjRI0m1J+KR0S3inSWZg
	8CAptdrR1Xdo+NxQMUfnhjrwMYaBWLkY/jyISGziEkJ0svD9C9PQI3bPrsSq4TA6ZiF+QNgkaF37Q
	tzEaV7VXN/RCzF/jqN3Uhtwf7/Efz3abk4ke5gPxKNEkWKdGtylSpNE81KqoHjPegC6eSDMJbKSkJ
	9iGOr09RDHj8CvKY5CLKs0O77Y4eBctyb2MYKOMCAOP69KJ2QuP2a1yN1xYWSk4W3r010y8NVW5g/
	3m2KNloE4+pTIBbXlOXwWNDjujQYyo04fda/B9N/DdEqXbNxBDxX6okXbHbFKNFCrwF3UVvngDu6h
	f1/7NYeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvEwM-00000003rlt-30in;
	Sat, 15 Aug 2026 14:00:50 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvEwB-00000003rl7-1hOJ
	for kexec@lists.infradead.org;
	Sat, 15 Aug 2026 14:00:42 +0000
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9CC93FCAB
	for <kexec@lists.infradead.org>; Sat, 15 Aug 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786802435;
	bh=86RGpNX2OsGBlms7o5V2IbYeBS1f1PX4b53IjP+9t+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=FL2avUEsrTQ/SDLW1lpoI0ogMVFDl4OpObelcIcR/aO5h6/GE3qpLGVwQliIlXy0o
	 A2PrEtEVeyDca76SoMgwKeA7ESwpYVpAY1vsYaCtFLplYc6dLjXg+ABixMdvAlIdfY
	 Qf3SWLxzfi0FYtyGvYTT6l4ntXw9DyPluLiMUUaNefYGVTosvVSHvE1tceXx8tNnH7
	 SFQJqKGL4qw7ejzCYkA/IjX7I0pZdsl9oDD8IgDH+iI34I+1QyQ8F7+88R4FB6LWO8
	 2WnJLE14bu3DST5S+tKpkrVmxCQNl6Bh8MvVOyQ11QLpiqKDoOfBZJMRcsUPHfXBr3
	 YQZzExH74wksvrOKtUlDLMhcUXw5y/8tF9j/7w2Jc4/K8pPmPvLfraYe2IZplddqfE
	 H2oJpCx+qya4jjboWbKJy8HX3WUt0MhH73OL2en0OU/e3OI+C5i5+UuNTLryUpbcL8
	 K8TYzCJk/LbN/RN4IkCFhobBVKdN1WwWUrJG6nkf/qN21yYi+UhZo959w/CUgYuc+0
	 eLQHEES3Q+2t35AV43sEe1vEkxmSDUrxADmFxSi/zWs3OXD0aQY0cJQNQD2Z91FHCd
	 tR8LDVrFtXVsMysHQrNkJyyxVwJ6WimEadXfDLVYC2BQPlDCAMmqfYwrTeVOXyYdvW
	 IH1fqKrXuZEzB6gDi+7AJ/Nw=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48000d75326so1225890f8f.2
        for <kexec@lists.infradead.org>; Sat, 15 Aug 2026 07:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786802435; x=1787407235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=86RGpNX2OsGBlms7o5V2IbYeBS1f1PX4b53IjP+9t+M=;
        b=irZErq7QNgETmus60j4DC/00lfGTi43iRI0k5iXfSZT7JQZSDlUmohJExgGW3lXGtC
         bkA9TSSlhTy6OtWKGwG0TJit3GCv/SjFOdYoIX3Z2HBqXZP2+KFEGFQ5AFZGWX7MfAAZ
         U8J0FUqBt++C8cwnJV3EDmDyRd8lrr8+Rqvuz6ZoiYS/VMn3mQD9yiLQnUGI2lVzEHCD
         ZWBzQGxVojBCJRbwSpAxsFcPxZhJr5959mjMfGLp7p71g1OhsRiWex0I70/6EJh8+tWn
         Ke034+hi/3fZOeLeo4OraNfBdWnO7ji9RTvkkGau3yij5PbZ5qG+sEuRSw0DOGr4xYoV
         5cGA==
X-Forwarded-Encrypted: i=1; AHgh+Rra/R/O6exN9Knf5bNkrbUPLLKP+HoosIW0l+8Nblm3Hs7swfqvp8c0+AAjrmyn6ArNisER5A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzQFPAv6rwyO2Vs2z0oCB3lIDecwLiPMavVPSMr2lPPVQ8s2oEi
	M7VX8FNVGOY1XNXrvgUD6TLPSoyx7sxOjO/PWzYUglGfWG5XjMNE7D/uDXoVzjfesBN4Kd79sF+
	t2Qjb9VQ7QZPLPcKMIjyN/OiK0B6IFw0DDFKTcuq5JOnQzkk19r/ErzB9rVp3p4uLP0ku1dynWW
	1Rxg==
X-Gm-Gg: AR+sD11UJ03OWx7KlVTiy9mBy9LB5ZwU+JEbnOWT2bnw8tDCe6NUT1D8B4iDkEcTYuf
	dnfr2l49ee+tVNzVqJD+kZ+VL7I3mjFYt8X8BoRAAHhStjsdA/exOd+8c3B8reZNMon8ItE0UUB
	1JkpYepXTZK28J2xoxXW0TDD6nY7yJKEFrbj4NsiO9KMf7Sd6JWV9zCZuYXWChE2VomQC1c4u/c
	9H3c+L71/GI+gbPXgqQac9NsM6rA5fhoMCtH0Hk49O91Z3BXzf6A+cuKH0G909k/s9Ty44T8YPM
	dXMuoV8+OSjnAu7cNIvFhPCFZX1ZvCTtLJglYVAzfrBpSjBDPyBNy1G2XOhIdHO1SJLJiSDauLq
	N1zINy4NYQvUtWeuGwrMaOlXptnTbVkgcVTIuateTuZ53CCXu6flwFbdWOTW4HV9sQ8N1juvu/+
	c9mQqPC+AAfnOL0SIuOJaS2DcfWh/OUB4=
X-Received: by 2002:a5d:5f4a:0:b0:481:51b5:7503 with SMTP id ffacd0b85a97d-48160708252mr21357138f8f.7.1786802435398;
        Sat, 15 Aug 2026 07:00:35 -0700 (PDT)
X-Received: by 2002:a5d:5f4a:0:b0:481:51b5:7503 with SMTP id ffacd0b85a97d-48160708252mr21357037f8f.7.1786802434963;
        Sat, 15 Aug 2026 07:00:34 -0700 (PDT)
Received: from t-14.home (2a01cb000883230031a3fd8213e7cff4.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:31a3:fd82:13e7:cff4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f20051esm18433563f8f.7.2026.08.15.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 07:00:34 -0700 (PDT)
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
Subject: [PATCH v2 1/2] crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
Date: Sat, 15 Aug 2026 16:00:19 +0200
Message-ID: <fcbc6b4d5855ba42a0fccf335b2604ef0b36f092.1786802052.git.fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
References: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_070039_922887_2C1112F5 
X-CRM114-Status: GOOD (  15.71  )
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
v2: express the "index 4" bound as
    offsetof(struct data_directory, certs) / sizeof(*dde) rather than a
    literal 4, per Ignat Korchagin's review [1] -- self-documenting and it
    tracks the struct layout. It is the same value (offsetof is 32,
    sizeof(*dde) is 8, so the bound is 4). A KUnit test is added as 2/2.

[1] https://lore.kernel.org/all/CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com/

Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64) with the KUnit case in
2/2: a crafted PE with data_dirs = 0 takes a slab-out-of-bounds read in
pefile_parse_binary() on an unpatched kernel, and is rejected with -ELIBBAD
(no KASAN report) with this patch.

 crypto/asymmetric_keys/verify_pefile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db14..1efd5c0d0 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -87,6 +87,11 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*dde))
 		return -ELIBBAD;
 
+	/* the certificate table entry must be present in the data directory */
+	if (ctx->n_data_dirents <=
+	    offsetof(struct data_directory, certs) / sizeof(*dde))
+		return -ELIBBAD;
+
 	ddir = pebuf + cursor;
 	cursor += sizeof(*dde) * ctx->n_data_dirents;
 

base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
-- 
2.53.0



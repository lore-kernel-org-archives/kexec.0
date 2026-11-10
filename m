Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544A606A900
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qinAZTrz;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=z/pehWdh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=AK/SgB0NJhyyMo/+uhJJDQ0snfVmLXzbzA7HTWtNTBs=; b=qinAZTrz3b/S6eREpsk+7m+z1b
	6VbDL4t8prldQBkxbQhgw0cU0CsemJrT/SWBxvdK9nhw76V3au02QJtKaCv0N5idw4LCE/ZTrVCHm
	BLXcDfVdUij67Cnzofgr/CJVGJPNZ6tO8Hoq591LZ3FOL5MJgup9qxpzdz1y1bkijskM8z6YWvVMH
	LMBWTA6dabcIWwTnXZfTbcX8xWj/D/R8zbSro8lh5iOAUdZvKh2n3DgqRme4kOCK8km/5lxhdzhkL
	RFBJwfd8W3Jtf3Op7P2gKDXKkI7AChD9FiA5P9JebagjUeshRo/XacPFqYRkwO0bSS8c2NY6k9VJR
	beWS0mVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQaqh-00000002789-4A6V;
	Tue, 10 Nov 2026 01:40:35 +0000
Received: from [113.46.200.222] (helo=canpmsgout07.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQaqY-0000000274y-35xt
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 01:40:33 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AK/SgB0NJhyyMo/+uhJJDQ0snfVmLXzbzA7HTWtNTBs=;
	b=z/pehWdhVRd/ELfMH/gt5hqXy00rS0mSKpMJfKKpoUb95Kz3+hvKZOcvSGcXpUCFCOFyeTo6I
	O44kGYOmFW4yb8HA+sfsJmWg8arK1dkAdareBWdQ3WJGeKw2j35GImzfqDptOFrUXROU/JdNmN3
	XSi3f3715y4lEoE7y1XpwCk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jNq8P4HRgzLlvw;
	Tue, 10 Nov 2026 09:39:49 +0800 (CST)
Received: from whupemk300004.china.huawei.com (unknown [7.152.185.168])
	by mail.maildlp.com (Postfix) with ESMTPS id EFD2940586;
	Tue, 10 Nov 2026 09:40:03 +0800 (CST)
Received: from huawei.com (10.67.174.33) by whupemk300004.china.huawei.com
 (7.152.185.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 09:40:02 +0800
From: Gu Bowen <gubowen5@huawei.com>
To: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, Ignat
 Korchagin <ignat@linux.win>, Herbert Xu <herbert@gondor.apana.org.au>
CC: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lujialin4@huawei.com>
Subject: [PATCH] crypto: asymmetric_keys: verify_pefile: fix integer underflow in pefile_strip_sig_wrapper
Date: Tue, 10 Nov 2026 09:56:57 +0800
Message-ID: <20261110015657.528337-1-gubowen5@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk300004.china.huawei.com (7.152.185.168)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_174027_381245_D19D3BF5 
X-CRM114-Status: GOOD (  13.73  )
X-Spam-Score: -1.3 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pefile_strip_sig_wrapper() function validates the win_certificate
wrapper that precedes the PKCS#7 signature in a PE binary.  It checks
that the wrapper length does not exceed the certificate table size
(``wrapper.length > ctx->sig_len``) but fails to verify that the
wrapper length is at least ``sizeof(struct win_certificate)`` (8 bytes).

When a crafted PE image supplies a wrapper with ``length`` in the range
[1, 7], the subsequent arithmetic::

    ctx->sig_len = wrapper.length;      /* e.g. 1 */
    ctx->sig_offset += sizeof(wrapper);
    ctx->sig_len -= sizeof(wrapper);    /* 1 - 8 = 0xFFFFFFF9 (unsigned) */

underflows the unsigned ``ctx->sig_len`` to a value near UINT_MAX.  The
following ``sig_len < 4`` sanity check is bypassed because 0xFFFFFFF9 is
greater than 4.

The underflowed ``sig_len`` is then passed to verify_pkcs7_signature()
and onwards to asn1_ber_decoder().  The ASN.1 decoder's own
``datalen > 65535`` entry guard can be satisfied by constructing a
PKCS#7 length field of exactly 65535 (e.g. ``30 82 ff fb``), allowing
the decoder to proceed and attempt to read OID octets beyond the
allocated vmalloc buffer, triggering a page fault in look_up_OID()::

  BUG: unable to handle page fault for address: ffffd1e986cb2000
  #PF: supervisor read access in kernel mode
  RIP: 0010:look_up_OID+0x14/0x100
  Call Trace:
   pkcs7_note_OID+0x33/0xa0
   asn1_ber_decoder+0x363/0xbd0
   pkcs7_parse_message+0xd9/0x1b0
   verify_pkcs7_signature+0x24/0x80
   verify_pefile_signature+0x7b/0xf0
   kexec_kernel_verify_pe_sig+0x1b/0x40
   kimage_file_alloc_init+0x1d8/0x3f0
   __se_sys_kexec_file_load+0xc6/0x270

This is reachable through the kexec_file_load syscall on architectures
that verify PE signatures (x86 bzImage with
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG, arm64 Image with
CONFIG_KEXEC_IMAGE_VERIFY_SIG), requiring CAP_SYS_BOOT.

The oops occurs while the caller holds kexec_lock; if the faulting task
is killed, the lock is never released, leaving all subsequent kexec and
kdump operations permanently returning -EBUSY until reboot.

Add a lower-bound check on wrapper.length before the subtraction to
prevent the underflow.

Fixes: 09dacbbda935 ("pefile: Strip the wrapper off of the cert data block")
Cc: stable@vger.kernel.org
Signed-off-by: Gu Bowen <gubowen5@huawei.com>
---
 crypto/asymmetric_keys/verify_pefile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db14129..cfa85ccb1cf7 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -146,6 +146,11 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
 			ctx->sig_len, wrapper.length);
 		return -ELIBBAD;
 	}
+	if (wrapper.length < sizeof(wrapper)) {
+		pr_warn("Signature wrapper too small (%x < %zx)\n",
+			wrapper.length, sizeof(wrapper));
+		return -ELIBBAD;
+	}
 	if (wrapper.revision != WIN_CERT_REVISION_2_0) {
 		pr_warn("Signature is not revision 2.0\n");
 		return -ENOTSUPP;
-- 
2.43.0



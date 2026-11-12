Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9960A3812
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uaH9Uw2N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Ldztcd661H3PvjadDzPRtXuuc2zNJ5aCxMHzlzHgHqc=; b=uaH9Uw2Na0i4d0VZ5LMX5AkPIa
	vF5CFhFsDZ8RyUCsONDYVX9gyjBNCajvc6eShIvy/4mxcVxz5toYla326+BPVNn6Xv+0WZEH752pH
	pH6XTJnqBjq4aQjgrZht/LrwoS6oMBx1dxYaJiRom5kGsmyDeqDKsIlA2Gz9MchThigDS+GPbJfug
	w9IlYIoxrfnhg8/SDx7936kbkQTWa1EyKQswt+U0NbYkOA+OStbZsoaYHHwjkcU2ClWz2KcFbm8aa
	MSvLSyNGG3nbK8CAuJnZbOTkKZOdREo6Zxq+cxy3EFUAUoNaQ/Nt+r6x+vZTRrrpwIb78tuwwAm7N
	115zVwZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUZo-00000009yNN-2oqW;
	Thu, 12 Nov 2026 13:10:52 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUZi-00000009yMf-40XW
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:10:50 +0000
X-UUID: 7056f720de9a11f19a56ed5b684f684d-20261112
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2df4f2ec-27fa-4d88-8fe7-389c3a28cc42,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:2df4f2ec-27fa-4d88-8fe7-389c3a28cc42,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:918fd7e2ba06005f2a779a888a181c05,BulkI
	D:2611122109330BEIYUWH,BulkQuantity:1,SF:17|19|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7056f720de9a11f19a56ed5b684f684d-20261112
X-User: litenglong@kylinos.cn
Received: from localhost.localdomain [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <litenglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1054885156; Thu, 12 Nov 2026 21:10:31 +0800
From: litenglong <litenglong@kylinos.cn>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	litenglong <litenglong@kylinos.cn>
Subject: [PATCH] Fix buffer overflow in dump_dmesg_structured and dump_record
Date: Thu, 12 Nov 2026 21:10:23 +0800
Message-Id: <20261112131022.1076471-1-litenglong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_051047_334598_28EE3EDB 
X-CRM114-Status: GOOD (  12.22  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Both functions accumulate output across multiple dmesg records into a
fixed-size stack buffer out_buf[OUT_BUF_SIZE] (4096 bytes) via sprintf
with a cumulative offset that is never reset across loop iterations.

The hex-byte escape loops already have a post-write flush guard at each
character boundary (len >= OUT_BUF_SIZE - 64), which was present in the
original upstream code. However, two write sites in each function lacked
any bounds check:

  dump_dmesg_structured:
    - timestamp prefix sprintf:  len += sprintf(out_buf + len, "[%5llu.%06llu] ", ...)
    - trailing newline:          out_buf[len++] = '\n'

  dump_record:
    - timestamp prefix sprintf:  offset += sprintf(out_buf + offset, "[%5llu.%06llu] ", ...)
    - trailing newline at out::  out_buf[offset++] = '\n'

On a long log record, the cumulative offset can approach OUT_BUF_SIZE.
Without a guard before these writes, the timestamp sprintf (up to ~30
bytes) or the newline byte can write past out_buf[OUT_BUF_SIZE - 1],
causing a stack buffer overflow.

Fix: add a flush-and-reset guard before each of the four unprotected
write sites, using the same threshold (OUT_BUF_SIZE - 64) as the
existing loop guards. When the buffer is nearly full, the accumulated
output is emitted via the handler callback and the offset resets to
zero, so subsequent writes start from the beginning of the buffer.

The 64-byte margin is sufficient: the timestamp prefix is at most ~30
bytes, and the newline is a single byte. The loop guards continue to
protect the character-by-character escape writes as before.

Signed-off-by: litenglong <litenglong@kylinos.cn>
---
 util_lib/elf_info.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index cfbbea3..17588d7 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -888,6 +888,12 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 		imaxdiv_sec = imaxdiv(ts_nsec, 1000000000);
 		imaxdiv_usec = imaxdiv(imaxdiv_sec.rem, 1000);
 
+		if (len >= OUT_BUF_SIZE - 64) {
+			if (handler)
+				handler(out_buf, len);
+			len = 0;
+		}
+
 		len += sprintf(out_buf + len, "[%5llu.%06llu] ",
 			(long long unsigned int)imaxdiv_sec.quot,
 			(long long unsigned int)imaxdiv_usec.quot);
@@ -922,6 +928,11 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 			}
 		}
 
+		if (len >= OUT_BUF_SIZE - 1) {
+			if (handler)
+				handler(out_buf, len);
+			len = 0;
+		}
 		out_buf[len++] = '\n';
 		free(msg);
 		/*
@@ -1124,6 +1135,12 @@ static void dump_record(int fd, struct prb_map *m, unsigned long id,
 	imaxdiv_sec = imaxdiv(ts_nsec, 1000000000);
 	imaxdiv_usec = imaxdiv(imaxdiv_sec.rem, 1000);
 
+	if (offset >= OUT_BUF_SIZE - 64) {
+		if (handler)
+			handler(out_buf, offset);
+		offset = 0;
+	}
+
 	offset += sprintf(out_buf + offset, "[%5llu.%06llu] ",
 		(long long unsigned int)imaxdiv_sec.quot,
 		(long long unsigned int)imaxdiv_usec.quot);
@@ -1169,6 +1186,11 @@ static void dump_record(int fd, struct prb_map *m, unsigned long id,
 		}
 	}
 out:
+	if (offset >= OUT_BUF_SIZE - 1) {
+		if (handler)
+			handler(out_buf, offset);
+		offset = 0;
+	}
 	out_buf[offset++] = '\n';
 
 	if (offset && handler)
-- 
2.25.1



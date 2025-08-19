Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4477CA0EFB
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=COja+R5PsBYNbQpPim6KOkucxEvKkni2s7QEgwwvFOU=; b=bWf6SOAzZB5FZcy+SdxocovnT+
	6C8wmDkBS4iHWdoiJKSfkP1dg+vcO1KqSI9DwwS2Ght4kXKO1yysXvgJvwQ+olIZ7N23lc7l/3Tq5
	blzx3DAWV33kMbkT3cZQh+0XOr28h9jctvpz6S/MQArLNAAZl4XpGAXo0drdECt1Nvamo9TXy7lfF
	o23WPNDMvk74J/UQFEvIsHv/sa+foArM4zL1cx5gOJ2ix7nArwShQJwvtj9W4FHkY6CQKLSgvH/ig
	JcpGp0/jrxhWing9ejBFmqBKtZF+mvV8a6LyT3wSl/9V1L+AlIrNWWziKdO+t7NNw7Y/CH2Rq7qrC
	keSC+ayA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIqw-0000000A0Er-14UW;
	Tue, 19 Aug 2025 09:42:02 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIIY-00000009tUR-3gFy
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 09:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755594355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g3jdWVfYy4IUPuLUzOcASUO2okN+VCipL7fdudCy7Vf9PIeHnGHALzZMrUlaxp8CGVT5UyZcQTXbPBtoQNbpUjZyPu+lIyCDFr6sKJtXkkc7D83/ZoN5LnqNdmz8Zqgzhexl+PL42s9Y/sqZmyXPe3lmcLZ18ogxeB1Be3UKBvU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755594355; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=COja+R5PsBYNbQpPim6KOkucxEvKkni2s7QEgwwvFOU=; 
	b=M6N5a3czKlWaP3UJC7PC23iETIMv7XeFV8J5tewODnxfqjVcY0WMJxZm6W0CdKN1wQe6DuZp0Wq6Cv0/bjBCQfVQma5m1bdLxp2s6xt3okIAwsaaa7eW31k8v7zpuFsYmUG0+Q5HqA6nXzraDydJ6rm7Kykb/U7h0ZAwU8hS6zA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755594354;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=COja+R5PsBYNbQpPim6KOkucxEvKkni2s7QEgwwvFOU=;
	b=Zjoj9G2BSBg3FtDzgtnFiiJ/dcclSSmAfsUgBsA3spqmBlTsdfNq/9ZDBqFLF03e
	keK8QGzZY/212T/GjjN01tsgg5D7IxRFEmCZZHFrw1Rxas0uyFrw78DhzdEe975RAwd
	foe5bPPusEMfc3U5ciAHzTFRYQbw8zL33ibMDc5M=
Received: by mx.zohomail.com with SMTPS id 1755594353339843.7793782690626;
	Tue, 19 Aug 2025 02:05:53 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v3 4/6] util_lib/elf_info.c: fix typo: prink -> printk
Date: Tue, 19 Aug 2025 09:05:03 +0000
Message-ID: <20250819090505.647690-5-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819090505.647690-1-safinaskar@zohomail.com>
References: <20250819090505.647690-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270d77344a10c7b831d6720c2b0000cff79c0852ae4f3d1774a03aaadf6daf50cb5dba13a530113f:zu080112272e64c41c9aa8e9ebc11201c40000db4b7eba26a3d5331a17d456a40f5a3f3c3db70cebdb46d39c:rf0801122cd79ce853a99efec1e24160d600006f9255efc116d330e19bc31a0d09ac79dc248f625a38bf7896d5dcabafce:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_020630_981002_AF9F11D4 
X-CRM114-Status: UNSURE (   8.33  )
X-CRM114-Notice: Please train this message.
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

Fix typo: prink -> printk

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 util_lib/elf_info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 0f03093..b005245 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -890,7 +890,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 				if (len && handler)
 					handler(out_buf, len);
 				fprintf(stderr, "Cycle when parsing dmesg detected.\n");
-				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
+				fprintf(stderr, "The printk log_buf is most likely corrupted.\n");
 				fprintf(stderr, "log_buf = 0x%" PRIx64 ", idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(68);
@@ -904,7 +904,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 				if (len && handler)
 					handler(out_buf, len);
 				fprintf(stderr, "Index outside log_buf detected.\n");
-				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
+				fprintf(stderr, "The printk log_buf is most likely corrupted.\n");
 				fprintf(stderr, "log_buf = 0x%" PRIx64 ", idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(69);
-- 
2.47.2



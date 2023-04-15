Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A77C77B70
	for <kexec@archiver.kernel.org>; Sat, 15 Apr 2023 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KdV3Xb3QjH+5NJnkzIskYDkHNjg/hqf3l1Myh5+gTR4=; b=tLYMbLfRXdp/U4
	uWmpV7J5FyS3N8zOHi6h/mBLZbUjxPvp1wI91MRRicrfu4oxK0mm9JHHZlN/0kdBnudq26/94J32A
	/R7/2bEQUDKtVDvBNhJxbkFYrUnoaIPcaL418SnG1SkH60C2zq8CYYEp9uwxS045pRUpXo/PVsB+N
	0l3YNfei9IadASek86smhx02FkhOC+Ci+9tsGEVW4mBUbAAGL5lWdFKXVvlcRZ5zuSjjucXND6UeD
	04fWNAr0mWbHlPRYXVO+a4MKzZsziN4pALiCN93+Pb6qyzyFaqon4uzX/roopgo8WpHa8g8Iik0Jv
	0KtDxGe1CNh2Jan8oIug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pniMe-00CPWx-3B;
	Sat, 15 Apr 2023 16:03:01 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pniMY-00CPV8-2u
	for kexec@lists.infradead.org;
	Sat, 15 Apr 2023 16:02:57 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id BFF801560E1;
	Sat, 15 Apr 2023 18:02:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1681574559; bh=J4mnhS/JXKySiioqpJN+5bd3hhrMXtrJzotBqXduFHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jb5XydPhYM4KtpI6gRNB7LvtG8f0SqHQ6l+zvzYx2ns3TMRnanuRg5iZEsqXlVIj2
	 kiitws6FgCROvWGdmHcoHDS6ke+G3Kx/Bx+0d0qJ6DM+jT+nbSsah7E2rCrehPzuNi
	 fmyUmE75xpgERz0SqyMztkSbcMvhGmrNGl6aVBuaSVJ90rhkCbjrPaAnn4GltCXSRL
	 KegpuXsPxbcbO1TDn0Ze8ZOmDkS5Ue1hKieKQkOifimAtHhqI4JY21I0j2tlIDBvm6
	 aj2gmvu/5ax+fu8P40k37xvWL6nt+Y2tjI9EheT6jIrZdxL/z5dyQ2J7Mt5nnX1waH
	 y6V8lYswhc82A==
From: Petr Tesarik <petr@tesarici.cz>
To: HAGIO KAZUHITO <k-hagio-ab@nec.com>,
	kexec@lists.infradead.org
Cc: Luc Chouinard <lucchouina@gmail.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v1 1/2] eppic: Fix incompatible pointer type warnings
Date: Sat, 15 Apr 2023 18:02:12 +0200
Message-Id: <372e54c039063572535cfce97fb466d921b8b91d.1681574529.git.petr@tesarici.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681574529.git.petr@tesarici.cz>
References: <cover.1681574529.git.petr@tesarici.cz>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230415_090255_289198_5E369714 
X-CRM114-Status: GOOD (  12.19  )
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

From: Petr Tesarik <ptesarik@suse.com>

On Linux, eppic defines ull (a bit confusingly) as uint64_t. This
is an unsigned long on 64-bit platforms with both GCC and LLVM, and
the compiler complains about passing a pointer to an unsigned long
where a pointer to an unsigned long long is expected.

It is not a real bug, because both types are identical on 64-bit
platforms, and on 32-bit platforms, uint64_t denotes an unsigned
long long, but the warning is annoying.

Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 extension_eppic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/extension_eppic.c b/extension_eppic.c
index 45bc032..8aa9ed2 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -122,7 +122,7 @@ drilldown(ull offset, type_t *t)
 {
 	int type_flag, len = 0, t_len = 0, nidx = 0;
 	int fctflg = 0, ref = 0, *idxlst = 0;
-	ull die_off = offset, t_die_off;
+	unsigned long long die_off = offset, t_die_off;
 	char *tstr = NULL, *tstr_dup = NULL;
 
 	while (GET_DIE_ATTR_TYPE(die_off, &type_flag, &t_die_off)) {
@@ -221,7 +221,7 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
 	int index, nfields = -1, size;
 	int nbits = 0, fbits = 0;
 	long offset;
-	ull m_die, die_off = idx;
+	unsigned long long m_die, die_off = idx;
 	char *name = NULL;
 
 	nfields = GET_DIE_NFIELDS_ALL(die_off);
-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

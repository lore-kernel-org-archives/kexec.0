Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF656606A32D
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L5/DHRLg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGGSz1SI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=j3f7/TUv5Xo7Nj2qDzexywJb0Xg99uvLe5xi0xEDiRo=; b=L5/DHRLgV+tDJKMQ1GOoBentTH
	mY1kPFgDFm6o/xOYiov0sC9IfFqx1zPtHDXLXmm7jzzNLOX2FrQI3rPIh4IwsSLx2ImKfhSr+JAK/
	Ckh1juw9KnNJ1o5IU/O1BCx905q6wT0Px41J++J0qUSo9LtssN3JKkQC7UNpaEK8iddK8Vt8C80W/
	YUMgEhVMQMcmDH7GNqp5fN7fXNL39QcgK5U5DDV9eFG0Bf2velybualsm8cmFbVUxyHtDxFcVibKk
	DuWRCbdK0kVBSoGArWTYnndC4Mdif5jicQBkAP6pE44yXckH/NAURMOwkhc+07OvimsUtr3rYjbZ+
	FSvN1sbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGc5-0000000301m-0zSV;
	Tue, 03 Nov 2026 15:39:53 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGc2-0000000301I-3bX9
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:39:52 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-33fb4680717so7079461eec.1
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793720389; x=1794325189; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3f7/TUv5Xo7Nj2qDzexywJb0Xg99uvLe5xi0xEDiRo=;
        b=aGGSz1SI3CBUH3tigRQDD9DwCO/xoIZV626kypeziT+BTjnesBx0zrXHZpnjtVnoxr
         8MzR9FO94/TGL2Aflty4qP3FGSLFlFOxGXULFoyUuiycSUC9TlMcUR+0WTyURpRTChfr
         86qxIICARb9isKIb4meEHuBCCpYt3KsfBRGR6dyvHSHUhx+RCe/QHcuYCnSOObpiblwi
         AmVAnqjN2cmDqPtxFpHf7dIEqDqQPwFysgAZ4etuHM3hJYVcOhdCDcSm/hjMupCSuDBe
         2JATPPVRisgFTNrwIOzt5DcAmycO+ua+clKFg8Ix6dNg0b5ToOiITUwW1SkxmzSgsswp
         SJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793720389; x=1794325189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3f7/TUv5Xo7Nj2qDzexywJb0Xg99uvLe5xi0xEDiRo=;
        b=AKxh05RMHgVScTzrD4fgmcl/W3VsO2wVVsZTuZcCzyt6oUK6BZotX7fb4hst/WKYa3
         FfkrdnMDRA+QihNy8fIZ+cQkZSAPmEXzNqlQK2qpLyGi9Z1/DRIte/4HwrPJvE/zFF1I
         ++/nVMpC182GFz+oeotXm77JjNETzN29e1H4jPyAK6RDcqNvVjWEt48fiGcmQtrO4TAw
         kJHKnaiUyHL8W3gWcZvuFkQrR/xym/a1NEhwmYigl3KzdUZA6ERm0kPnrZmeBWM8RaZN
         NzDFzXXrCAzaZEFxaqLgDwltcKZGOhOt8Om/RsrjO4LXOIW5YjYmIxRwsYVypzNic/9S
         h7Mw==
X-Gm-Message-State: APuU4Z91b+UMh4XnnALJuvrSAtD+goknld3AWquqm5y3iz8V4hnkZFxt
	MAnMDqxtxO5qvPwOOl3Zk34trDjQPbMlTIGWbeoEna3CduFlM0bQJvJW
X-Gm-Gg: AYBFou2ycK2CHUlPmNcalO/cxSyCMJLufJ0t2WPwzQ+pC3uqoASfeg/OkpuGEpTThDt
	rsy9fNcxgS23EN4umaeOKo0b4WiN6tSYnhKApCpGFq+WNyEMW8UHnZ9uifQUJycOYTgit0FSW5I
	JQkfv1MHjCbmtmqqG2L/jRQO40AalJBPjX1c3fAYhpnydXfXmsR7P0g3foS7G3MY2TmPB5sGbFP
	H6dQyqqq8hdlowY02xl3b1S4yi/Mp0xfRp97iJDXPcfB5VZz8rNUsetTO+aDsRggcnJKcz2JEBR
	yvDtXNYJCEBLVbTQvRR5CiXlg7/UfnMX8J2IGsQQYRlv/vEbZic+/QDMdQwY/61iF2pPtm6pVK9
	hDrQxZ2JNa0TfYaYP/tT2hxrz0etCXvskixB4GZnfdKAMS2wxpbT3lKKpL5H/CP2kCTgzBh+85o
	nJrhdOuGE40FN8zJL1jNmLPAt9p1iY1vGQImMAFCuEZB2b6dscyHhCXTSKn+XDs+VYgx8oQflmh
	TgGZlbq4PgrVWXsXiKjpuIvouoLu4BCcU/ds3u8RuiIIlC8S4U7TjPrXIAqkHm9Q6Cd1P4LYkHA
	sZINzKIdKv18+wtMcXodQ9rePTwe5sljHq3ce2Sp69K/5tAuz1CA5gmZ
X-Received: by 2002:a05:693c:4084:b0:36c:9c64:c547 with SMTP id 5a478bee46e88-36c9c64d2ffmr1854274eec.26.1793720389408;
        Tue, 03 Nov 2026 07:39:49 -0800 (PST)
Received: from bridge.. (deps54-26.deps.ufsc.br. [150.162.54.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm50492703eec.9.2026.11.03.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:39:48 -0800 (PST)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] liveupdate: check for duplicate session before growing block set
Date: Tue,  3 Nov 2026 12:39:28 -0300
Message-ID: <20261103153928.716753-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_073950_903392_E105F752 
X-CRM114-Status: GOOD (  12.23  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

luo_session_insert() grows the outgoing block set before checking for a
duplicate session name. On -EEXIST the new block stays in the set.

If the session count is an exact multiple of the per-block capacity (51
with 4K pages), that block stays empty. It is serialized with count 0,
which kho_block_set_restore() rejects in the next kernel:

  luo: Block contains invalid entry count: 0
  Kernel panic - not syncing: The incoming tree failed to initialize properly [-EINVAL], disabling live update

Check for the duplicate before growing the block set, as
luo_preserve_file() does with the token.

Fixes: 2a441a14c2c0 ("liveupdate: Remove limit on the number of sessions")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---

Notes:
    Tested in QEMU: create N sessions, retry "sess-0" to get -EEXIST, then
    kexec and retrieve them. Unpatched, the second kernel panics for N=51
    and N=102; patched, N=1, 51, 52, 102 and 153 all come back.

    Based on v7.4-rc1.

 kernel/liveupdate/luo_session.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..74bc66929f4b 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -176,16 +176,6 @@ static int luo_session_insert(struct luo_session_header *sh,
 
 	guard(rwsem_write)(&sh->rwsem);
 
-	/*
-	 * For outgoing we should make sure there is room in serialization array
-	 * for new session.
-	 */
-	if (sh == &luo_session_global.outgoing) {
-		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
-		if (err)
-			return err;
-	}
-
 	/*
 	 * For small number of sessions this loop won't hurt performance
 	 * but if we ever start using a lot of sessions, this might
@@ -196,6 +186,17 @@ static int luo_session_insert(struct luo_session_header *sh,
 		if (!strncmp(it->name, session->name, sizeof(it->name)))
 			return -EEXIST;
 	}
+
+	/*
+	 * For outgoing we should make sure there is room in serialization array
+	 * for new session.
+	 */
+	if (sh == &luo_session_global.outgoing) {
+		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
+		if (err)
+			return err;
+	}
+
 	list_add_tail(&session->list, &sh->list);
 	sh->count++;
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0



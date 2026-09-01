Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1740C624D0
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3UHjUhSHEFs3BDPKTwtfBJ57unvd2KtLqU4zpNQnvE=; b=U7CcnC8piW5HE8t/vC3fAYrLCn
	eefYhHKIJYnQ3LJc0PnkJjaiDC5W7p0Naai5yXHKEJ38a2luk3Mw30sPfNhTf/kQG5Xau1KuJuGFL
	TLihtVnJoLeNvxQVayKkSoi4x8miVOTXKOF9AL1ftM2GUgcgu5qu0dxeEeaCVPexMs9D9LXWr4TJa
	Bj4OVlvO/4xBtTefCpf+yqtD1NzTOOb8KYyd2iHtf5d4QYEIgy6gDr77Y3LsQw/aDOdtPZsHQVJ9J
	Mlu7jSCi8h1qjpy//6DHlLsWb3bsXSzeU+OYT6qlBUnNmz7hNDEWRB9PqfCI2109G8UYZ/hCUj4AR
	0RMa4jAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StQ-0000000CuwM-0fRc;
	Tue, 01 Sep 2026 18:07:32 +0000
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StK-0000000CutC-2la3
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 18:07:30 +0000
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-ca8aee88725so201063a12.3
        for <kexec@lists.infradead.org>; Tue, 01 Sep 2026 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788286045; x=1788890845; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3UHjUhSHEFs3BDPKTwtfBJ57unvd2KtLqU4zpNQnvE=;
        b=RGbwknrura5PWNMhLe30JwYjxIOgXm85ZFS6gzOG+swNf6xgjH3COY3XpPp0huCIqo
         S2pk9S50XP+tkSji+kkF+X946QhWK/AWYRy0N1f/a51Vnh6+unWDmH+D4aFeLKP+7EGY
         27UgGXKY1JNSY+qJR2CTFhJrYBOXYQuOKTmthiwTXm/8zcsUu64hcUyrifZX38hF410M
         AQinvZZemcZ/W/MBaA0qjT4GpJlY6F9ucqJ3WyLIOWDf3QDR2wKWl5KDwGgM8rd0NiGK
         2SR5E06zSYEvG6F5qgpJSw+cD/3t4KaZlxcNyb1PI0dMVaDXbBWqr3kHPt7cpt7gv/+b
         SSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286045; x=1788890845;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3UHjUhSHEFs3BDPKTwtfBJ57unvd2KtLqU4zpNQnvE=;
        b=HSgpP2gMlxmmpyLSUTAoOV5k73H4nRyMBz+0XBqMzwgPB8SWEHVJz20nQgqQoYNaAP
         sRDr0ke/ef2+JTHZuhFUjqeAZnYSR2QugtE1d8ijW61S1rh1j5fdyNARQEk1f9DUdG6r
         kOwLbxinRY81TbXjRM7Ug7VP1U24TcT6y92uTk3zAZkxhozQAAkU02Q0wge3nQjIdKPP
         m9bZQ/twD/MwL6rNLqOUanc5Mm9zgfnNmdoFfl2NsWNpU8XkpEZkCBVM5AyTGH6yDfmb
         Jkdogfv27QiiG7fOS+LisRO+uYf9weq7/s1CWmSsc+laQ7z58SOpoH+nnAmd99luvqeg
         XtWg==
X-Gm-Message-State: AFuF++l/ySghOaEG7plxSeMXhx1jiowjMZqitA5bGrQPNVzQyxBPrYNi
	8c/dEaNvbJYQ6wxDRI9ZzAoQLHPzbnp9nxVGMxOg1iWh98U+gRtMA1ChMnfZta8KCnjZ8L57hC/
	TERTjNK2jqqRIz1aqD2BO2JEG2xz+ZxXvA5AuvR1UWyclmRZ8En2sBIRPeEJFgTYAVPmIOtwwxg
	fX3lFZCBc0JLhcTP86c4Rr2G9M0DiadpcAGiFSf8tk0fVyZLPnfrI=
X-Received: from pgp10-n2.prod.google.com ([2002:a05:6a02:62ca:20b0:cc2:2955:6540])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7a97:b0:3d0:cc29:ff64 with SMTP id adf61e73a8af0-3d7af8303a1mr17251598637.15.1788286044618;
 Tue, 01 Sep 2026 11:07:24 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:07:09 +0000
In-Reply-To: <20260901180713.4185641-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260901180713.4185641-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901180713.4185641-2-dmatlack@google.com>
Subject: [RFC PATCH 1/5] liveupdate: Extract luo_file token lookup logic into
 helper function
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_110726_711071_1135D99E 
X-CRM114-Status: GOOD (  14.03  )
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

Extract the token-based list iteration inside luo_retrieve_file() into a
standalone private helper luo_find_file_by_token().

This eliminates code duplication by paving the way for additional file
retrieval modalities (like retrieving into an existing file descriptor)
which also need to safely lookup file tracking structures from the token
list before bridging payloads.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 kernel/liveupdate/luo_file.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index c39f96961a85..5e160836a165 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -549,26 +549,32 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
  *         -ENOENT if no file with the matching token is found.
  *         Any error code returned by the handler's .retrieve() op.
  */
-int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
-		      struct file **filep)
+
+static struct luo_file *luo_find_file_by_token(struct luo_file_set *file_set, u64 token)
 {
-	struct liveupdate_file_op_args args = {0};
 	struct luo_file *luo_file;
-	bool found = false;
-	int err;
 
 	if (list_empty(&file_set->files_list))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
 	list_for_each_entry(luo_file, &file_set->files_list, list) {
-		if (luo_file->token == token) {
-			found = true;
-			break;
-		}
+		if (luo_file->token == token)
+			return luo_file;
 	}
 
-	if (!found)
-		return -ENOENT;
+	return ERR_PTR(-ENOENT);
+}
+
+int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
+		      struct file **filep)
+{
+	struct liveupdate_file_op_args args = {0};
+	struct luo_file *luo_file;
+	int err;
+
+	luo_file = luo_find_file_by_token(file_set, token);
+	if (IS_ERR(luo_file))
+		return PTR_ERR(luo_file);
 
 	guard(mutex)(&luo_file->mutex);
 	if (luo_file->retrieve_status < 0) {
-- 
2.55.0.966.g6673acef38-goog



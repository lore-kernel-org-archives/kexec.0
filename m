Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5D4C98312
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCYcL1R5NicLL/NhwgzYeBgYTteRbyS24vJmmzlRDaw=; b=RbFOqvdHnReq64uKLvpnDbFuEL
	Kc5K11mRW4x6N+fDBxg7Q60h3QwpVY4fDg85s4Mjq9sT+5c9kqi28fxiuEP5cXsZyErEOsbCJUUxG
	4As+TXAnuAkcuVIVkJmLOaWEPWenIrB/UkPivJhtNIiAGOKVQJNzJgUxX8i82Mb7sJVvlyga9RIlZ
	ez9bWVYFxC/orU88AnsbqZdiVjBYlfh5VDqflSP9LHSZDL0djrKE4B9Yfnqk3cq673UOYc77STWUb
	ULMd1Ae6aJU1nHax1V2c5MUsGhQCcxaezEoRyrWEgcsDALV/Tm7b2RkPIJz4VTL1KLppI7ASQXs9Y
	II0nAiow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhR-00000009fba-2UTV;
	Wed, 23 Sep 2026 22:44:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhP-00000009fb6-2OVg
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 22:44:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A22B360209;
	Wed, 23 Sep 2026 22:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117221F00893;
	Wed, 23 Sep 2026 22:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203462;
	bh=XCYcL1R5NicLL/NhwgzYeBgYTteRbyS24vJmmzlRDaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLDWEyiH4tsSHQ5jJ4W2INbg6NtCw24Nd55zZ1YffQlaEZPAogYwjP2a/jc2DrkPj
	 fXfbbY0AbOWflZJduor+NXDIF6D+FNeJF7fl8dSS/E5uP0Qr0d96bjebpX+f4ESMn/
	 iPGrG7bYGtfPO3T4UR+BK/3sz9bYHuMUdh/5T7cjpw4U7scGJJsTDgxf2jodSDjEoI
	 sKzZnyHAKe6jGpPk8E3MGJqmqx+C5rJILC4+9pbw+A1ID0OAaQjT1kgvaS4YzT/Y1G
	 pojgEXXMxey8NvFAyaDGkdrYwSbl0qyYLPQj7yrknb+ildxh1CLxjM3OlCEiyPkYsh
	 qIjtHZqFGtM2Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/6] liveupdate: luo_file: look up outgoing tokens by id
Date: Thu, 24 Sep 2026 00:44:00 +0200
Message-ID: <20260923224408.3745689-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923224408.3745689-1-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

liveupdate_get_token_outgoing() is used to look up tokens of
dependencies. It does the search based on struct file. LUO preserves
resources; the files are only handles to those resources.

LUO provides file handlers a ->get_id() callback that can return the
unique identifier of a resource. LUO uses it to ensure the same resource
can't be preserved twice if it can be referred to by multiple files. The
default ID is the struct file, but file handlers can implement the
callback and return something else. For example, memfd returns the inode
of the file, not the struct file itself.

Use ID to look up dependencies in liveupdate_get_token_outgoing()
instead of struct file. This allows the lookup to work with handlers
that use things other than the struct file.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/liveupdate.h   |  6 +++---
 kernel/liveupdate/luo_file.c | 21 ++++++++++++---------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..1cddbab50b98 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -253,9 +253,9 @@ void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb);
 int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 				 struct file **filep);
 
-/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
+/* Get a token for a preserved object, or -ENOENT if it is not preserved */
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
-				  struct file *file, u64 *tokenp);
+				  unsigned long id, u64 *tokenp);
 
 #else /* CONFIG_LIVEUPDATE */
 
@@ -316,7 +316,7 @@ static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
 }
 
 static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
-						struct file *file, u64 *tokenp)
+						unsigned long id, u64 *tokenp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..51817d202ce2 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -950,29 +950,32 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 }
 
 /**
- * liveupdate_get_token_outgoing - Get the token for a preserved file.
+ * liveupdate_get_token_outgoing - Get the token for a preserved object.
  * @s:      The outgoing liveupdate session.
- * @file:   The file object to search for.
+ * @id:     The identifier of the preserved object to search for, as returned
+ *          by the owning handler's ->get_id().
  * @tokenp: Output parameter for the found token.
  *
- * Searches the list of preserved files in an outgoing session for a matching
- * file object. If found, the corresponding user-provided token is returned.
+ * Searches the list of preserved files in an outgoing session for an object
+ * with a matching identifier. If found, the corresponding user-provided token
+ * is returned.
  *
- * This function is intended for in-kernel callers that need to correlate a
- * file with its liveupdate token.
+ * For handlers that do not implement ->get_id() use the 'struct file' pointer
+ * as their identifier.
  *
  * Context: It must be called with session mutex acquired.
- * Return: 0 on success, -ENOENT if the file is not preserved in this session.
+ * Return: 0 on success, -ENOENT if no such object is preserved in this
+ *         session.
  */
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
-				  struct file *file, u64 *tokenp)
+				  unsigned long id, u64 *tokenp)
 {
 	struct luo_file_set *file_set = luo_file_set_from_session_locked(s);
 	struct luo_file *luo_file;
 	int err = -ENOENT;
 
 	list_for_each_entry(luo_file, &file_set->files_list, list) {
-		if (luo_file->file == file) {
+		if (luo_get_id(luo_file->fh, luo_file->file) == id) {
 			if (tokenp)
 				*tokenp = luo_file->token;
 			err = 0;
-- 
2.56.0.rc1.310.g51773c2048-goog



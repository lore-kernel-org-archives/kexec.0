Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73E1CDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 04:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFaoYZTJfRDH9hDuVHVBgZkR1flChQcp5jR5STw0K2M=; b=c6meiuXAKPwtSxJIhnYQVXnEGs
	mFcdLuWuBG2U1xM3+sWOOTidImQxsHvtm20aXNtLQqlxWyr+kqW4urPdtz75EpqmgfIHDD4zApv0Q
	zlqSM0kQfqUTVP5CyzGgeZu6Pw+zeZ7z7rq7M+9OFzwApJ+0MyiGZGyNuOF/UcUwMZ3Ll/vBExWfR
	eVTHVhlC53ca3mPnmt0xITpWdbneGYfqN0llhzuLS8n6l3ChGc/V5OT1E8PemtBgQNU+cLT+4yNBG
	2n6RP3a6LiVEDVtVklU6QUEZ9EZEtC4of1IdZwGc6+J7xr8L8B27ZgZs4BrRG66d6FMOqRTx3Gsoc
	7Xw//DTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbVwF-00000004ODL-2vkS;
	Mon, 22 Jun 2026 04:07:11 +0000
Received: from out-173.mta0.migadu.com ([91.218.175.173])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbVwB-00000004OBt-2Pl6
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 04:07:10 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782101224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFaoYZTJfRDH9hDuVHVBgZkR1flChQcp5jR5STw0K2M=;
	b=RKNYTOPII31SLlFemAcWqWE/TeS/HQJl7crveXc7GdzZz5I+TjbXRbbkZaQSvN3TmVtVYT
	nSSDvsZk7jNyt6B/E4YmD4cYyLjd5RE2oOf/Hiy1FZ2NcIRHyitOaBZNUaYo6dvHseOLCi
	TzRgynUCXY7wguiC8GKfv0LXaYiHBGc=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Paul Moore <paul@paul-moore.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Howells <dhowells@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Randy Dunlap <rdunlap@infradead.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	live-patching@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	damon@lists.linux.dev,
	llvm@lists.linux.dev,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v3 2/7] llist: Add mutable iterator variants
Date: Mon, 22 Jun 2026 12:05:32 +0800
Message-ID: <20260622040533.29824-3-kaitao.cheng@linux.dev>
In-Reply-To: <20260622040533.29824-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_210707_765019_B4E5735D 
X-CRM114-Status: GOOD (  17.59  )
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

From: Kaitao Cheng <chengkaitao@kylinos.cn>

llist_for_each_safe() and llist_for_each_entry_safe() require callers to
provide a temporary cursor even when the cursor is only needed by the
iterator itself.  This makes call sites noisier than necessary for the
common case where the loop body may remove the current entry but does
not otherwise inspect the saved next pointer.

Add llist_for_each_mutable() and llist_for_each_entry_mutable() variants
that support both forms.  Callers may omit the temporary cursor and let
the helper create an internal unique cursor, or keep passing an explicit
cursor when the loop needs to inspect or reset it.

Keep the existing safe helpers as compatibility wrappers so current users
continue to build unchanged while new code can use the shorter mutable
form.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/linux/llist.h | 81 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 8846b7709669..1c6f12411d5e 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -49,6 +49,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/args.h>
 #include <linux/container_of.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -143,12 +144,33 @@ static inline bool llist_on_list(const struct llist_node *node)
 #define llist_for_each(pos, node)			\
 	for ((pos) = (node); pos; (pos) = (pos)->next)
 
+/*
+ * llist_for_each_safe is an old interface, use llist_for_each_mutable instead.
+ */
+#define llist_for_each_safe(pos, n, node)			\
+	for ((pos) = (node); (pos) && ((n) = (pos)->next, true); (pos) = (n))
+
+#define __llist_for_each_mutable_internal(pos, tmp, node)		\
+	for (typeof(pos) tmp = ((pos) = (node)) ? (pos)->next : NULL;	\
+	     (pos);							\
+	     (pos) = tmp, tmp = (pos) ? (pos)->next : NULL)
+
+#define __llist_for_each_mutable1(pos, node)				\
+	__llist_for_each_mutable_internal(pos, __UNIQUE_ID(next), node)
+
+#define __llist_for_each_mutable2(pos, next, node)			\
+	llist_for_each_safe(pos, next, node)
+
 /**
- * llist_for_each_safe - iterate over some deleted entries of a lock-less list
- *			 safe against removal of list entry
+ * llist_for_each_mutable - iterate over some deleted entries of a lock-less list
+ *			    safe against removal of list entry
  * @pos:	the &struct llist_node to use as a loop cursor
- * @n:		another &struct llist_node to use as temporary storage
- * @node:	the first entry of deleted list entries
+ * @...:	either (node) or (next, node)
+ *
+ * next:	another &struct llist_node to use as optional temporary storage.
+ *		The temporary cursor is internal unless explicitly supplied by
+ *		the caller.
+ * node:	the first entry of deleted list entries
  *
  * In general, some entries of the lock-less list can be traversed
  * safely only after being deleted from list, so start with an entry
@@ -159,8 +181,9 @@ static inline bool llist_on_list(const struct llist_node *node)
  * you want to traverse from the oldest to the newest, you must
  * reverse the order by yourself before traversing.
  */
-#define llist_for_each_safe(pos, n, node)			\
-	for ((pos) = (node); (pos) && ((n) = (pos)->next, true); (pos) = (n))
+#define llist_for_each_mutable(pos, ...)				\
+	CONCATENATE(__llist_for_each_mutable, COUNT_ARGS(__VA_ARGS__))	\
+		(pos, __VA_ARGS__)
 
 /**
  * llist_for_each_entry - iterate over some deleted entries of lock-less list of given type
@@ -182,13 +205,41 @@ static inline bool llist_on_list(const struct llist_node *node)
 	     member_address_is_nonnull(pos, member);			\
 	     (pos) = llist_entry((pos)->member.next, typeof(*(pos)), member))
 
+/*
+ * llist_for_each_entry_safe is an old interface, use llist_for_each_entry_mutable instead.
+ */
+#define llist_for_each_entry_safe(pos, n, node, member)			       \
+	for (pos = llist_entry((node), typeof(*pos), member);		       \
+	     member_address_is_nonnull(pos, member) &&			       \
+	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
+	     pos = n)
+
+#define __llist_for_each_entry_mutable_internal(pos, tmp, node, member)	\
+	for (typeof(pos) tmp = ((pos) = llist_entry((node), typeof(*pos), member), \
+		member_address_is_nonnull(pos, member) ?			\
+		llist_entry((pos)->member.next, typeof(*pos), member) : NULL);	\
+	     member_address_is_nonnull(pos, member);				\
+	     (pos) = tmp, tmp = member_address_is_nonnull(pos, member) ?	\
+		llist_entry((pos)->member.next, typeof(*pos), member) : NULL)
+
+#define __llist_for_each_entry_mutable2(pos, node, member)			\
+	__llist_for_each_entry_mutable_internal(pos, __UNIQUE_ID(next), node, member)
+
+#define __llist_for_each_entry_mutable3(pos, next, node, member)		\
+	llist_for_each_entry_safe(pos, next, node, member)
+
 /**
- * llist_for_each_entry_safe - iterate over some deleted entries of lock-less list of given type
- *			       safe against removal of list entry
+ * llist_for_each_entry_mutable - iterate over some deleted entries of
+ *				  lock-less list of given type safe against
+ *				  removal of list entry
  * @pos:	the type * to use as a loop cursor.
- * @n:		another type * to use as temporary storage
- * @node:	the first entry of deleted list entries.
- * @member:	the name of the llist_node with the struct.
+ * @...:	either (node, member) or (next, node, member)
+ *
+ * next:	another type * to use as optional temporary storage. The
+ *		temporary cursor is internal unless explicitly supplied by the
+ *		caller.
+ * node:	the first entry of deleted list entries.
+ * member:	the name of the llist_node with the struct.
  *
  * In general, some entries of the lock-less list can be traversed
  * safely only after being removed from list, so start with an entry
@@ -199,11 +250,9 @@ static inline bool llist_on_list(const struct llist_node *node)
  * you want to traverse from the oldest to the newest, you must
  * reverse the order by yourself before traversing.
  */
-#define llist_for_each_entry_safe(pos, n, node, member)			       \
-	for (pos = llist_entry((node), typeof(*pos), member);		       \
-	     member_address_is_nonnull(pos, member) &&			       \
-	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
-	     pos = n)
+#define llist_for_each_entry_mutable(pos, ...)				\
+	CONCATENATE(__llist_for_each_entry_mutable,			\
+		COUNT_ARGS(__VA_ARGS__))(pos, __VA_ARGS__)
 
 /**
  * llist_empty - tests whether a lock-less list is empty
-- 
2.43.0



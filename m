Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABC606A321
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hVxDcTrG;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FoP+S/Zu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=S2+GAWJu093KmsSX+p7Xa5DYqGY04zbqmyhRiBRhNQA=; b=hVxDcTrGZFfhDY7ueZFDnkLtzS
	K+BIL8q09SvGCoI4/vz3fCjqzUE6wYmE/of6qYZxzKEGlJKsQF1inq9jU2XdpcSK4PRzAaCT5CF8i
	ihqgyx/IkGrB4SyIVHeiPVffypjUKFTl52vcof0mG8XJxYBlrDhw3qhMq1DIuNjzlV3+qK9paE5PM
	IDMwRBGutEkXsz65Cuv8anxNsrVPhSPo5thdM0NNOY+wpAaRjPqouw5R5XZTkzxG7wfCwNC+huXXh
	4l8BLlBdtWgxLD1h7WteG9IOUAbroL1duDi8ILvyO4zwz2Gx/vQ0rI+MUAcCf22NYUJd2NCO0sm6h
	LVusTgMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXCqR-00000000TAb-2kF6;
	Sat, 28 Nov 2026 07:27:39 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXCqK-00000000T6m-06mg
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 07:27:38 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S2+GAWJu093KmsSX+p7Xa5DYqGY04zbqmyhRiBRhNQA=;
	b=FoP+S/ZuUgZhkugJDKfGpPKJdLiOb7/sLhugz8VzW0r5yZvf1zD2eUrmRcL1Ggxbu1nf5oSNo
	oN+tNaSB5x1PKoeODmysqEG3iDjqciVhzCGBPrGyusX/zt47k4k4N53kn/6G6ymsH00DcYKpOxs
	EIUqKWzwMUGNTecHH4ZlqLc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jc20C06Vqz12LFT;
	Sat, 28 Nov 2026 15:26:35 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A2C64057D;
	Sat, 28 Nov 2026 15:27:21 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 28 Nov 2026 15:27:20 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>
CC: <shuah@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <hewenliang4@huawei.com>, Long Wei
	<longwei27@huawei.com>
Subject: [PATCH 1/2] mm: memfd_luo: pick up seals added after preserve at freeze
Date: Sat, 28 Nov 2026 15:24:43 +0800
Message-ID: <20261128072444.1114964-2-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128072444.1114964-1-longwei27@huawei.com>
References: <20261128072444.1114964-1-longwei27@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_232732_552863_057BC865 
X-CRM114-Status: GOOD (  19.41  )
X-Spam-Score: -2.8 (--)
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A seal added to a memfd after the memfd was preserved with a
liveupdate session is accepted without any error, but once the kexec
handover is over the retrieved memfd no longer has it: the change
silently disappears instead of being rejected.

memfd_luo_preserve() snapshots the file seals into the serialized
state, but userspace may keep operating on the memfd until the
handover, by design, so the preserve-time snapshot is naturally
incomplete: a seal can be added at any point in the window between
preserve() and kexec.  memfd_luo_freeze() only re-read the file
position and retrieve() replays the frozen snapshot, so those window
changes were never picked up.  Freeze is the last point before kexec
where they can still be sampled; there is no second chance after it.

Re-read the seals at freeze time, mirroring the file position
handling: freeze is the final snapshot point and changes made after
it are not preserved.  The new seal set is only revalidated when it
actually diverged from the preserve-time snapshot, and the validation
must fail here rather than at retrieve(): while the old kernel is
still in control the live update can still be aborted, but after the
handover a seal that memfd_luo_retrieve() cannot replay would already
be past the point of no return.

Fixes: 8a552d68a86e ("mm: memfd_luo: preserve file seals")
Signed-off-by: Long Wei <longwei27@huawei.com>
---
 mm/memfd_luo.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 6b68220275eb..08524125475e 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -54,6 +54,9 @@
  *   File seals set on the memfd are preserved and re-applied on restore.
  *   Only seals known to this LUO version (see ``MEMFD_LUO_ALL_SEALS``) may
  *   be present; preservation fails with ``-EOPNOTSUPP`` otherwise.
+ *   Seals added after preserve are picked up when the file is frozen for
+ *   kexec. Freeze is the final snapshot point: like the file position,
+ *   changes made after it are not preserved.
  *
  * Restrictions
  * ============
@@ -322,7 +325,9 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 
 static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 {
+	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_ser *ser;
+	int seals;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
@@ -330,10 +335,28 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 	ser = phys_to_virt(args->serialized_data);
 
 	/*
-	 * The pos might have changed since prepare. Everything else stays the
-	 * same.
+	 * F_ADD_SEALS takes inode_lock, so sample the seals under the same
+	 * lock to get a consistent final value.  f_pos is sampled here under
+	 * the same inode_lock as preserve did; freeze is the last snapshot
+	 * point for both.
 	 */
+	inode_lock(inode);
+	seals = memfd_get_seals(args->file);
+	if (seals < 0) {
+		inode_unlock(inode);
+		return seals;
+	}
+
+	if (seals != ser->seals) {
+		if (seals & ~MEMFD_LUO_ALL_SEALS) {
+			inode_unlock(inode);
+			return -EOPNOTSUPP;
+		}
+		ser->seals = seals;
+	}
+
 	ser->pos = args->file->f_pos;
+	inode_unlock(inode);
 
 	return 0;
 }
-- 
2.43.0



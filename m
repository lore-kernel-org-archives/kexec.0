Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB67CD4F5B
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hl34v0Hapr6rkzRxzmrBi68Qpp3Frfw5pxclBRbTd4E=; b=ImrYF6x0z3i8jFIj6yp7zIw7qz
	ZAoWBw3SF4lcLGfVXK7e8dPNgEoLilgn/uffn92d1kN00odkpW2mEYsSJHsbVrEIlTSWisNRHne+Y
	fnF/oollq5BvfyTLpwlX8OVQOOB2Gm+IUmFeWh98gG1FP6X6cfveUwjmjI2KCKlU0AqvuHazdmfBh
	wykeztwtGTKjkngIZoigAmt1ijVDSEdoId/LmGxrWpmAhDAjdDhntU/0CU/zjnthVDfDL86U0KgEt
	1J0+v/LWF3Hn2TTjE0rG72poGKBvE0K/cI/wSVAgVYLTMwaRCHiquXJcgy9eA0Kb4jkN+zCXM5EFE
	GKnzPnog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPJV5-00000001Spy-1cT5;
	Tue, 19 May 2026 12:24:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPJV2-00000001SpU-2gZP
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 12:24:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E2FB244087;
	Tue, 19 May 2026 12:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F81C2BCB8;
	Tue, 19 May 2026 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779193479;
	bh=U6uqIHy8EE/i1NqW9z07GrDK43NwFSOtpRCXLlkTT/w=;
	h=From:To:Cc:Subject:Date:From;
	b=LC03JEtE9gEcI9GO3u+nUrkxOlo/J8fohNMiQ1gD6BxQoj9yS9jqTP1nTPMjaa0pW
	 parkjEr0wR7LZJ1m/Wdj0bzf5qavbL7ggPknymbczPk3dyD5gcpkIxxd18nhokPkcN
	 n7LVA7OuX7wJnp6Pt1X8/KlFBsDrmIsfatLHlMncuHdQ6vl4l54zgru3IqnczOob4k
	 GZVSdvX/dI62PuaES0dcOpHufMVixxZOnWG6IS7/3ecxXzBFMsG1nUu5bgyg3Oxxmy
	 +J4PbLyvFB1lgrl112aVA/RY6fvd6B90wEknQRHrRcMfYv3rIaXd7T5HtIiXagkPUK
	 Mn533+Z6ahxuA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] liveupdate: validate session type before performing operation
Date: Tue, 19 May 2026 14:24:26 +0200
Message-ID: <20260519122428.2378446-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_052440_719805_72148DA8 
X-CRM114-Status: GOOD (  20.23  )
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

The sessions ioctls are not applicable to all session types. PRESERVE_FD
is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
valid for incoming session. Calling a incoming ioctl on an outgoing
session is invalid and can cause file handlers to run into unexpected
errors.

For example, a user can create a (outgoing) session, preserve a memfd,
and then immediately do a retrieve without doing a kexec in between.
This would result in memfd's retrieve handler to run. The handlers
expects to be called from a post-kexec context, and will try to do a
kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.

KHO catches this (thanks to KHO_PAGE_MAGIC) and returns an error, but
since this is considered an internal error and KHO throws out a bunch of
WARN()s.

Associate a type with each ioctl op and validate the type in
luo_session_ioctl() before dispatching the ioctl handler to make sure
the op is being called for the right session type.

Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    I added LUO_IOCTL_ALL but there is no user in this patch. The type is
    for LIVEUPDATE_SESSION_GET_NAME which is supported for both session
    types. The support for GET_NAME is in next and this patch should go
    through fixes.
    
    Alternatively, we can remove LUO_IOCTL_ALL from this patch and add it to
    the LIVEUPDATE_SESSION_GET_NAME patch in next. But that would need us to
    rebase to an rc that contains this fix.

 kernel/liveupdate/luo_session.c | 36 +++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..e84218e3cacb 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -295,32 +295,58 @@ union ucmd_buffer {
 	struct liveupdate_session_retrieve_fd retrieve;
 };
 
+/* Type of sessions the ioctl applies to. */
+enum luo_ioctl_type {
+	LUO_IOCTL_INCOMING,
+	LUO_IOCTL_OUTGOING,
+	LUO_IOCTL_ALL,
+};
+
 struct luo_ioctl_op {
 	unsigned int size;
 	unsigned int min_size;
 	unsigned int ioctl_num;
+	enum luo_ioctl_type type;
 	int (*execute)(struct luo_session *session, struct luo_ucmd *ucmd);
 };
 
-#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+#define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
 	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_SESSION_BASE] = {                    \
 		.size = sizeof(_struct) +                                      \
 			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
 					  sizeof(_struct)),                    \
 		.min_size = offsetofend(_struct, _last),                       \
 		.ioctl_num = _ioctl,                                           \
+		.type = _type,                                                 \
 		.execute = _fn,                                                \
 	}
 
 static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 	IOCTL_OP(LIVEUPDATE_SESSION_FINISH, luo_session_finish,
-		 struct liveupdate_session_finish, reserved),
+		 struct liveupdate_session_finish, reserved, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_PRESERVE_FD, luo_session_preserve_fd,
-		 struct liveupdate_session_preserve_fd, token),
+		 struct liveupdate_session_preserve_fd, token, LUO_IOCTL_OUTGOING),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
-		 struct liveupdate_session_retrieve_fd, token),
+		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 };
 
+static bool luo_ioctl_type_valid(struct luo_session *session,
+				 const struct luo_ioctl_op *op)
+{
+	switch (op->type) {
+	case LUO_IOCTL_INCOMING:
+		/* Retrieved is only set on incoming sessions */
+		return session->retrieved;
+	case LUO_IOCTL_OUTGOING:
+		return !session->retrieved;
+	case LUO_IOCTL_ALL:
+		return true;
+	}
+
+	/* Catch-all. */
+	return false;
+}
+
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 			      unsigned long arg)
 {
@@ -345,6 +371,8 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
 	if (op->ioctl_num != cmd)
 		return -ENOIOCTLCMD;
+	if (!luo_ioctl_type_valid(session, op))
+		return -EINVAL;
 	if (ucmd.user_size < op->min_size)
 		return -EINVAL;
 

base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.54.0.563.g4f69b47b94-goog



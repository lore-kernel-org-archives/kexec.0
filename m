Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BB606A339
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ObwerRlT;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YL2Ed0e1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YUipaf1Xu3soLx3fON/5CvYu8l0nj5iVkY657TVC4e0=; b=ObwerRlT9y6Fui
	6nm8NIK7m177kxAdd/xu6e2dyaxewyR4NdPmzDNroL+B/jAbNOg1iAWjvIaFByKxfCknisTbvE5tB
	gzZISsEdwRARe69KRe7VihOx+Fjl079p0MRiXX0OKyQ9fz78JkTU5EHi7j0c180G41BMj9ys5I9QQ
	EWjDVxC4v9xM21HJ+YkmgRyzQU+TtEXyDpQuoNndOcUnGG0k32GAZjfEmU0gkTjyuSSwjrv3tIB8n
	29p0WIMBaI7TN4GLeKthzUba79GBHFcqpL4xbE41MwOcm9VvPwSlCI+3JcmPNa7HnXyV04nbSu4QJ
	FGI+2btGG63kl21TaVdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpb1-00000007pup-2IWu;
	Thu, 05 Nov 2026 05:01:07 +0000
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpaz-00000007pr8-20dL
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 05:01:07 +0000
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1112423e0c.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 21:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793854864; x=1794459664; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YUipaf1Xu3soLx3fON/5CvYu8l0nj5iVkY657TVC4e0=;
        b=YL2Ed0e15nRt9EmycGUjuUKIdtQVc6ksdmLbSrkyHdD9XQEMcgsvP6ChSpggyuhiC4
         RN9TNCrOLAu/xHo5TIAYXqOhULRIY+d4xiN5dAbF9KPeXxZzpuaG4rCgzaWzRTclFXHr
         5fah280osD8b0B3Bq3p4ziW/hP9R6M/9md3nQ7GPY2drHZf8ejaKDzt+/6iaI8F09MYm
         AJZgoG5DTqgdFlu/tRGviAEzr2Uvc/maVB+JzdHjWLHwAsHBw5n2zA50jCpN08W5hLQU
         ScYFKbGkEaznW+cRRXkqTI4ObFVSnIOL5iMNOFcJ1dCKcPZnGWJ1a0MaaFHSXQrQzblN
         f2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854864; x=1794459664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YUipaf1Xu3soLx3fON/5CvYu8l0nj5iVkY657TVC4e0=;
        b=aGUHe1a4qOriuW8K9FYX8wPQy2WRzktgCdE1QLo6/JKubHg2oxMKIH1p6PWtUZv1hw
         He3c2bzxGetONa4fAbkQ+UT9rgVJDUiCpnm5smAJBo851VmXSkiAkiK9jZRsqhuW8Dqc
         K4D+YZczRGk9Pu/HJPXfyYL00UFZ186bf9EDqjrxduBsiRLoDP/+JISB4+ct510y0G2J
         25yZ0fj9aHvJneQygAtDarcPFQicEsKvm8xBD9yZ/XNJr/m80WDpHeOOFX5aOtfzBjsR
         QZBV1VHMeNAgVOc2R4ffhMk5X7tHZRQrHI38LLN4Bg1LRifpQqBt88MF4HJtY8ZLzsC9
         +2sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHQChZYHe5YRgfShjyRoYu8Uu8Abh8xz7MC4L5LIT9FGT/aVANWQOvIx5ibOEmjThAY2SRqA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+a9zLvwn1Euco/0IpE6CHosqbYQU/ZfCCpr4xf7ffs5mmWOtdX
	LvzFyepIdGXhobIgilI88hDmwOJ7EI3P9X56t3vLgT41Q+ZK/z2a/owHnPIX6AKYWII=
X-Gm-Gg: AYBFou0UXMgiTgxSnf2y8u5DsnroqobOaeejVzryiAd3m51NCrwnbk4jb0++3TzhnBE
	R3284Xj8ARfFUq6k1uOBWoPPQfOLk1VdcOEdZwhxlxybIHsEb6leiViOprETMfBZJ0soDnL8nj3
	u9h3YqsMnbfbae5//mzB11gmMRLJaPLsWQ1CLtrt/sAIchMhFYpxhWkEGYt4sa9KMYPqJS/cgq7
	08PLZQYq188I6+FT9LVedsmYC0Nuh6V7Doz7ffIIUsYcAz3Kxu0OIA3X8MXkU7LFakSVfjU1YmF
	O85kkUhp+sVxvA+Rfv6WE7m1LXmjr0FzWwHNn7nxTOAmb7pVD8gbaTuoBdBTNfN1eKq17ttjxub
	fRnGV/2p0H1TS6KD/B4f8gRIn9BRN7t7Ys5aMwT/qa3N3c1r0Bbt/myw05kvzH90DxF8N9FAm75
	2EGA2V6P389gmqbjLZvsftGLEhrLx94FACmtzuviYNGXaxFxx4s1PTs8mXb2Rstivyd7gJMydKF
	Djha5rI+jNjPUorRnkraCM2k5pFxexgZIxvxtTSP5zGEykxjSW91nSggpU3RHtpfxIe4bt5hWoG
	/bNIKt1fZfwo58KJLFV2+/CcszXnNLHQ+/KuiBbL2Z90xXFsbJhimY9jcLAebEESJlC/MnM8a7X
	VpZ2OschMnugTdp7UdHhjN7w0leLTdDbdi1Sl7ib6VG5vE+wh2A==
X-Received: by 2002:a05:6122:8f85:b0:5ec:20e8:45ff with SMTP id 71dfb90a1353d-5ec68a06324mr9559381e0c.21.1793854864052;
        Wed, 04 Nov 2026 21:01:04 -0800 (PST)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm3305282e0c.8.2026.11.04.21.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:01:03 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v5 5/6] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to freeze sessions early
Date: Thu,  5 Nov 2026 00:00:51 -0500
Message-ID: <20261105050053.3063001-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_210105_621522_0E6560BF 
X-CRM114-Status: GOOD (  26.79  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, LUO sessions are frozen automatically only inside the
reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
iterates through all outgoing sessions under global write locks and
freezes them serially during shutdown. On hosts running multiple
workloads that quiesce one by one ahead of kexec, userspace needs an
explicit per-session freeze point so each session can capture final file
state under its per-session mutex as soon as its workload pauses.

Introduce LIVEUPDATE_SESSION_FREEZE on session FDs to freeze an outgoing
session early. The ioctl runs .freeze() across all preserved files in
the session and serializes their metadata. Once frozen, no additional
files can be added to the session, and subsequent freeze calls return
-EBUSY. Freeze is only valid on outgoing sessions and returns -EINVAL on
incoming ones.

By default (flags == 0), session lifetime remains bound to the session
FD: the session stays frozen while the FD remains open, and closing the
session FD before reboot (for example, to abort the session or on
process exit/crash) unfreezes it via .unfreeze(), unpreserves its files,
and reclaims all resources. During kexec, already-frozen sessions skip
the late auto-freeze and are published into the outgoing KHO subtree.

With LIVEUPDATE_SESSION_FREEZE_COMMIT set in
struct liveupdate_session_freeze.flags, the frozen session is committed:
it and its FLB dependencies are immediately inserted into the outgoing
KHO subtree via luo_session_publish_one(), and the session survives
close() with full ownership retained by LUO until reboot. Once
committed, closing the session FD (or another session failing to freeze
during reboot) never unfreezes or unpreserves the session, allowing
processes to hand off preserved state and exit prior to kexec.

Update the uAPI and core LUO documentation to describe session freeze
and commit semantics.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/userspace-api/liveupdate.rst | 30 +++++++++
 include/linux/liveupdate.h                 |  3 +-
 include/uapi/linux/liveupdate.h            | 46 +++++++++++++
 kernel/liveupdate/luo_file.c               | 54 +++++++--------
 kernel/liveupdate/luo_internal.h           |  7 ++
 kernel/liveupdate/luo_session.c            | 77 ++++++++++++++++++++--
 6 files changed, 184 insertions(+), 33 deletions(-)

diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
index cdd74627ab75..d36537c556cc 100644
--- a/Documentation/userspace-api/liveupdate.rst
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -22,6 +22,36 @@ change, so compatibility is not guaranteed when kexec rebooting between
 different kernel versions. This is expected to change and stabilize in a future
 version.
 
+Session Freeze and Commit
+=========================
+
+By default, LUO freezes active sessions automatically inside the
+``reboot(LINUX_REBOOT_CMD_KEXEC)`` syscall path, and an outgoing session's
+lifetime is bound to its open session FD: closing the FD before reboot aborts
+preservation and returns all resources.
+
+Userspace may also freeze an outgoing session explicitly ahead of reboot via
+``ioctl(session_fd, LIVEUPDATE_SESSION_FREEZE, &arg)`` once it has finished
+preserving and modifying the session's files:
+
+- **Freeze** (``flags == 0``): Executes ``.freeze()`` on all preserved files in
+  the session under the per-session lock (allowing multiple sessions to freeze
+  concurrently), while keeping session lifetime tied to ``session_fd``. When
+  ``session_fd`` is closed before reboot (for example, to abort the session or
+  on process exit/crash), LUO runs ``.unfreeze()`` and ``.unpreserve()`` on all
+  files in the session and reclaims all resources. As long as ``session_fd``
+  remains open, the session stays frozen across any failed ``reboot()`` attempt;
+  at kexec time, already-frozen sessions skip the late auto-freeze step and are
+  published into the outgoing KHO subtree.
+- **Freeze and commit** (``LIVEUPDATE_SESSION_FREEZE_COMMIT``): Freezes the
+  session's files, immediately inserts the session and its FLB dependencies
+  into the outgoing KHO subtree, and commits the session so that it survives
+  closing ``session_fd`` with ownership retained by LUO until reboot. Once
+  committed, closing ``session_fd`` (or another session failing to freeze
+  during ``reboot()``) will neither unfreeze nor unpreserve the session,
+  allowing processes to hand off preserved state to LUO and exit prior to
+  kexec.
+
 Userspace Integration
 =====================
 
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..851692571e13 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -59,7 +59,8 @@ struct liveupdate_file_op_args {
  *                compatible with the given file.
  * @preserve:     Required. Performs state-saving for the file.
  * @unpreserve:   Required. Cleans up any resources allocated by @preserve.
- * @freeze:       Optional. Final actions just before kernel transition.
+ * @freeze:       Optional. Prepares final state before kexec (via
+ *                LIVEUPDATE_SESSION_FREEZE or during reboot).
  * @unfreeze:     Optional. Undo freeze operations.
  * @retrieve:     Required. Restores the file in the new kernel.
  * @can_finish:   Optional. Check if this FD can finish, i.e. all restoration
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 4043d4038712..ba424dc51578 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -60,6 +60,7 @@ enum {
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
 	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
+	LIVEUPDATE_CMD_SESSION_FREEZE = 0x44,
 };
 
 /**
@@ -236,4 +237,49 @@ struct liveupdate_session_get_name {
 #define LIVEUPDATE_SESSION_GET_NAME					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
 
+/**
+ * enum liveupdate_session_freeze_flags - Flags for LIVEUPDATE_SESSION_FREEZE
+ * @LIVEUPDATE_SESSION_FREEZE_COMMIT: Commit the frozen session. The session is
+ *                                    immediately inserted into the outgoing KHO
+ *                                    tree and survives closing the session FD
+ *                                    until reboot.
+ */
+enum liveupdate_session_freeze_flags {
+	LIVEUPDATE_SESSION_FREEZE_COMMIT = 1 << 0,
+};
+
+/**
+ * struct liveupdate_session_freeze - ioctl(LIVEUPDATE_SESSION_FREEZE)
+ * @size:  Input; sizeof(struct liveupdate_session_freeze)
+ * @flags: Input; Combination of enum liveupdate_session_freeze_flags.
+ *
+ * Freezes the session from userspace before the kexec reboot phase.
+ *
+ * When this ioctl is called, the kernel executes the .freeze() callback on all
+ * preserved files in the session and serializes their metadata. Once frozen,
+ * no further files can be preserved in the session, and subsequent freeze
+ * attempts return -EBUSY.
+ *
+ * By default (@flags is 0), session lifetime remains tied to the session FD:
+ * if the session FD is closed before reboot (for example, if the application
+ * exits or crashes), the session is unfrozen, its preserved files are
+ * unpreserved, and all resources are returned.
+ *
+ * If %LIVEUPDATE_SESSION_FREEZE_COMMIT is set in @flags, the frozen session is
+ * committed: it is immediately inserted into the outgoing KHO tree and survives
+ * closing the session FD, transferring full ownership of the session and its
+ * preserved resources to LUO until reboot. Once committed, the session is never
+ * unfrozen or unpreserved, even if the session FD is closed or if another
+ * session fails to freeze during reboot.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_session_freeze {
+	__u32		size;
+	__u32		flags;
+};
+
+#define LIVEUPDATE_SESSION_FREEZE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FREEZE)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 611b9967a3a9..afed2b59f489 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -31,9 +31,9 @@
  *   - unpreserve(): Cleans up any resources allocated by .preserve(), called
  *     if the preservation process is aborted before the reboot (i.e. session is
  *     closed).
- *   - freeze(): A final pre-reboot opportunity to prepare the state for kexec.
- *     We are already in reboot syscall, and therefore userspace cannot mutate
- *     the file anymore.
+ *   - freeze(): Prepares the final state for kexec. Invoked either via
+ *     the LIVEUPDATE_SESSION_FREEZE ioctl once userspace is done modifying
+ *     the session's files, or during the reboot() syscall.
  *   - unfreeze(): Undoes the actions of .freeze(), called if the live update
  *     is aborted after the freeze phase.
  *   - retrieve(): Reconstructs the file in the new kernel from the preserved
@@ -48,7 +48,8 @@
  *    handler, calls its .preserve() operation, and creates an internal &struct
  *    luo_file to track the live state.
  *
- * 2. Freeze (Pre-Reboot): Just before the kexec, luo_file_freeze() is called.
+ * 2. Freeze (Pre-Reboot): Either explicitly via LIVEUPDATE_SESSION_FREEZE or
+ *    just before the kexec during reboot(), luo_file_freeze() is called.
  *    It iterates through all preserved files, calls their respective .freeze()
  *    operation, and serializes their final metadata (compatible string, token,
  *    and data handle) into a contiguous memory block for KHO.
@@ -72,17 +73,19 @@
  *
  * File Preservation Lifecycle unhappy paths:
  *
- * 1. Abort Before Reboot: If the userspace agent aborts the live update
- *    process before calling reboot (e.g., by closing the session file
- *    descriptor), the session's release handler calls
- *    luo_file_unpreserve_files(). This invokes the .unpreserve() callback on
- *    all preserved files, ensuring all allocated resources are cleaned up and
- *    returning the system to a clean state.
+ * 1. Abort Before Reboot: When an uncommitted session FD is closed before
+ *    reboot (e.g., to abort preservation or on process exit), the session's
+ *    release handler unfreezes the files if the session was frozen via
+ *    LIVEUPDATE_SESSION_FREEZE and calls luo_file_unpreserve_files(). This
+ *    invokes the .unpreserve() callback on all preserved files, ensuring all
+ *    allocated resources are cleaned up and returning the system to a clean
+ *    state. Committed sessions survive closing their FD and remain owned by
+ *    LUO until reboot.
  *
- * 2. Freeze Failure: During the reboot() syscall, if any handler's .freeze()
- *    op fails, the .unfreeze() op is invoked on all previously *successful*
- *    freezes to roll back their state. The reboot() syscall then returns an
- *    error to userspace, canceling the live update.
+ * 2. Freeze Failure: During LIVEUPDATE_SESSION_FREEZE or the reboot() syscall,
+ *    if any handler's .freeze() op fails, the .unfreeze() op is invoked on all
+ *    previously *successful* freezes to roll back their state, and an error is
+ *    returned to userspace, canceling the live update if called from reboot().
  *
  * 3. Finish Failure: In the new kernel, if a handler's .finish() op fails,
  *    the luo_file_finish() operation is aborted. LUO retains ownership of
@@ -458,9 +461,9 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  * luo_file_freeze - Freezes all preserved files and serializes their metadata.
  * @file_set: The file_set whose files are to be frozen.
  *
- * This function is called from the reboot() syscall path, just before the
- * kernel transitions to the new image via kexec. Its purpose is to perform the
- * final preparation and serialization of all preserved files in the file_set.
+ * This function is called from LIVEUPDATE_SESSION_FREEZE or from the reboot()
+ * syscall path. Its purpose is to perform the final preparation and
+ * serialization of all preserved files in the file_set.
  *
  * It iterates through each preserved file in FIFO order (the order of
  * preservation) and performs two main actions:
@@ -477,13 +480,12 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  *
  * Error Handling (Rollback):
  * This function is atomic. If any handler's .freeze() operation fails, the
- * entire live update is aborted. The __luo_file_unfreeze() helper is
- * immediately called to invoke the .unfreeze() op on all files that were
- * successfully frozen before the point of failure, rolling them back to a
- * running state. The function then returns an error, causing the reboot()
- * syscall to fail.
+ * __luo_file_unfreeze() helper is immediately called to invoke the .unfreeze()
+ * op on all files that were successfully frozen before the point of failure,
+ * rolling them back to an unfrozen state, and an error is returned to the
+ * caller, canceling the live update if called from the reboot() path.
  *
- * Context: Called only from the liveupdate_reboot() path.
+ * Context: Called from LIVEUPDATE_SESSION_FREEZE or the liveupdate_reboot() path.
  * Return: 0 on success, or a negative errno on failure.
  */
 int luo_file_freeze(struct luo_file_set *file_set)
@@ -533,15 +535,15 @@ int luo_file_freeze(struct luo_file_set *file_set)
  * @file_set: The file_set whose files are to be unfrozen.
  *
  * This function rolls back the state of all files in a file_set after the
- * freeze phase has begun but must be aborted. It is the counterpart to
- * luo_file_freeze().
+ * freeze phase has begun. It is the counterpart to luo_file_freeze().
  *
  * It invokes the __luo_file_unfreeze() helper with a NULL argument, which
  * signals the helper to iterate through all files in the file_set, call their
  * respective .unfreeze() handler callbacks, and clear the serialized blocks.
  *
  * Context: This is called when the live update is aborted during
- *          the reboot() syscall, after luo_file_freeze() has been called.
+ *          the reboot() syscall, after luo_file_freeze() has been called,
+ *          or when a frozen uncommitted session is released before kexec.
  */
 void luo_file_unfreeze(struct luo_file_set *file_set)
 {
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index a7253b48df80..f1ecc8586ea1 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -64,6 +64,11 @@ struct luo_file_set {
  *              previous kernel) sessions.
  * @retrieved:  A boolean flag indicating whether this session has been
  *              retrieved by a consumer in the new kernel.
+ * @user_frozen: A boolean flag indicating whether this session has been
+ *               frozen explicitly from userspace.
+ * @committed:   A boolean flag indicating whether this session has been
+ *               committed (frozen, published into the outgoing KHO tree,
+ *               and owned by LUO across session FD close until reboot).
  * @file_set:   A set of files that belong to this session.
  * @mutex:      protects fields in the luo_session.
  */
@@ -71,6 +76,8 @@ struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	struct list_head list;
 	bool retrieved;
+	bool user_frozen;
+	bool committed;
 	struct luo_file_set file_set;
 	struct mutex mutex;
 };
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 713b9b400f07..4358a5e77c38 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -34,10 +34,16 @@
  * 1.  Creation: A userspace agent calls `luo_session_create()` to create a
  *     new, empty session and receives a file descriptor for it.
  *
- * 2.  Serialization: When the `reboot(LINUX_REBOOT_CMD_KEXEC)` syscall is
- *     made, `luo_session_serialize()` is called. It iterates through all
- *     active sessions and writes their metadata into a memory area preserved
- *     by KHO.
+ * 2.  Freeze / Serialization: Sessions may be frozen explicitly from userspace
+ *     via `LIVEUPDATE_SESSION_FREEZE`. With `flags == 0`, the session's files
+ *     are frozen while keeping the session tied to its FD so closing it
+ *     unfreezes and unpreserves the session. With
+ *     `LIVEUPDATE_SESSION_FREEZE_COMMIT`, the frozen session is committed: it
+ *     is immediately published with its FLBs into the outgoing KHO tree and
+ *     survives closing the session FD until reboot. When the
+ *     `reboot(LINUX_REBOOT_CMD_KEXEC)` syscall is made,
+ *     `luo_session_serialize()` freezes any remaining unfrozen sessions and
+ *     publishes all remaining unpublished sessions into the KHO tree.
  *
  * 3.  Deserialization (in new kernel): After kexec, `luo_session_deserialize()`
  *     runs, reading the serialized data and creating a list of `struct
@@ -276,12 +282,21 @@ static int luo_session_finish_one(struct luo_session *session)
 static void luo_session_unfreeze_one(struct luo_session *session)
 {
 	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(&session->file_set);
+	/*
+	 * Only unfreeze sessions that were auto-frozen by
+	 * luo_session_freeze_one(); sessions frozen explicitly by
+	 * userspace stay frozen until the session FD is closed.
+	 */
+	if (!session->user_frozen)
+		luo_file_unfreeze(&session->file_set);
 }
 
 static int luo_session_freeze_one(struct luo_session *session)
 {
 	guard(mutex)(&session->mutex);
+	if (session->user_frozen)
+		return 0;
+
 	return luo_file_freeze(&session->file_set);
 }
 
@@ -302,8 +317,13 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 		}
 		sh = &luo_session_global.incoming;
 	} else {
-		scoped_guard(mutex, &session->mutex)
+		scoped_guard(mutex, &session->mutex) {
+			if (session->committed)
+				return 0;
+			if (session->user_frozen)
+				luo_file_unfreeze(&session->file_set);
 			luo_file_unpreserve_files(&session->file_set);
+		}
 		sh = &luo_session_global.outgoing;
 	}
 
@@ -320,6 +340,9 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	int err;
 
 	guard(mutex)(&session->mutex);
+	if (session->user_frozen)
+		return -EBUSY;
+
 	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
 	if (err)
 		return err;
@@ -393,11 +416,51 @@ static int luo_session_get_name(struct luo_session *session,
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
+static int luo_session_freeze(struct luo_session *session,
+			      struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_freeze *argp = ucmd->cmd;
+	int err;
+
+	if (argp->flags & ~LIVEUPDATE_SESSION_FREEZE_COMMIT)
+		return -EOPNOTSUPP;
+
+	scoped_guard(mutex, &session->mutex) {
+		if (session->user_frozen)
+			return -EBUSY;
+
+		err = luo_file_freeze(&session->file_set);
+		if (err)
+			return err;
+
+		err = luo_ucmd_respond(ucmd, sizeof(*argp));
+		if (err) {
+			luo_file_unfreeze(&session->file_set);
+			return err;
+		}
+
+		session->user_frozen = true;
+	}
+
+	if (argp->flags & LIVEUPDATE_SESSION_FREEZE_COMMIT) {
+		struct luo_session_header *sh = &luo_session_global.outgoing;
+
+		guard(rwsem_write)(&sh->rwsem);
+		guard(mutex)(&session->mutex);
+
+		luo_session_publish_one(session);
+		session->committed = true;
+	}
+
+	return 0;
+}
+
 union ucmd_buffer {
 	struct liveupdate_session_finish finish;
 	struct liveupdate_session_preserve_fd preserve;
 	struct liveupdate_session_retrieve_fd retrieve;
 	struct liveupdate_session_get_name get_name;
+	struct liveupdate_session_freeze freeze;
 };
 
 /* Type of sessions the ioctl applies to. */
@@ -435,6 +498,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
 		 struct liveupdate_session_get_name, name, LUO_IOCTL_ALL),
+	IOCTL_OP(LIVEUPDATE_SESSION_FREEZE, luo_session_freeze,
+		 struct liveupdate_session_freeze, flags, LUO_IOCTL_OUTGOING),
 };
 
 static bool luo_ioctl_type_valid(struct luo_session *session,
-- 
2.56.0.398.g882cbad275-goog



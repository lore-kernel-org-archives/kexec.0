Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4260A2613
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wwkCZ1DI;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=N4ATDaav
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9q7RwoQiaN01BLggu6ENspiefzk6L5yZx5t6tiYpc7I=; b=wwkCZ1DIrkYNIP
	d5SSn7Jllc/ti9Hpv9o31P70OuzhpKTvMNtb0XW/A3NOyi84hM/FDrPfUHfhj/Fe1+cFVZqoUxQri
	6FQEafo5Mplqe7+7L9Ms3P7KwKZ7BBX+Tds9jVMKkhqSay2ZXjYdBPD4VqRUduOPM3WTkB0SYLWdm
	HWzt2MYXG3rgEQtDRSsJJ0hb73L+/vCubiUow5qj8XUzdabs64yWwWIEru4pZ228uKuhdIbaVRclj
	uYaIJndbDMXcyqWBqeJY8RDTyuJ6xlYqnD+KEQq8XlEtnQ7XUXNACQTEcGeWR/J5U+RSK1pg4kSxW
	8oiLvIeH99D7X/vNoRrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnDA-0000000AJgf-3yjD;
	Wed, 18 Nov 2026 21:29:00 +0000
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD5-0000000AJc2-13b2
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:56 +0000
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-990703f817fso784822241.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037334; x=1795642134; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9q7RwoQiaN01BLggu6ENspiefzk6L5yZx5t6tiYpc7I=;
        b=N4ATDaavWIuz3DOJsLNTvtDS/0Otm9TImg0hs8tIgDWOGC7iOoZJsbahCVZr4jc0tf
         suqIRa1GW5qI0Q3/CdalYFmap5Qqqof7khVpMqw4ueNudnwzNk/p4U7C92SnIcpxQnt+
         snJlAILRgtDn7PNv6nTI0R1sTjW/YQUWsjbsEuP/kyTVI9DifrXsH8gGwv2uso2iYtmR
         PEwIj8haSu3lYU3XJNCfZnvBKkrJobSdpizsZL7CIZM2tSxywZg4nPZ9QVEGIcJgHnaQ
         h2PsCuZ1HpCx8onWJJMvW701dXuIqlQHPch+zkWfx7KRhTg8ADaZUzxbznF+i+2fBI2+
         2Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037334; x=1795642134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9q7RwoQiaN01BLggu6ENspiefzk6L5yZx5t6tiYpc7I=;
        b=aOP2ymdtVhQu1nyCTfdXDydSaz1Ch1Zf1dYoNWeRiCvgSDBQ/4eXUizoXQ4V53qstZ
         9BRymL1YXukHCP1OVqNESv9dhxYTsAWJ9gybwGXHMCWveImTtXZc7v7RjZxTCddl3RfE
         e8zMYIUqob5WbTOLNMiL5b2F4RARy/JqHHSwZKG2q2sQwfhVhqM2fPsnQL0Nn+Jabz67
         gQrtjMsm2sE9Dvz3PI7+AvN2tf2adookqvWCnosZxGQyrhTtVhkg5z2wIaazxAJKBFng
         Gt22qHbTPqKbRN+ccyusLmRi+LbOYpqxfv9AcRdWAgYJMk2iXejNOYy6XNK32DkAND5P
         BI9g==
X-Forwarded-Encrypted: i=1; AL+hErFae61hE/5NfL2b0MyXggW+Q9t/yavpq2czCzqb75kbNf3ctzLkOMDyhsW2IqO1VcYQXLkx1A==@lists.infradead.org
X-Gm-Message-State: APuU4Z9zI0BpQWOM7qJbZCt5gW1XvafvpmrDPxNc+bko+ZZNzXmlsN5m
	ki7DREa2qJ4OTd5MnQS6sSzr9nfpbfKBwWApiWwUFP10HtrltKTrXvnYpM3WKhnN5kQ=
X-Gm-Gg: AYBFou3R6T23uQzn/xpCQ8h7vNTgg3wr115CcDXX2Rn8QFpZc0vVKVNwlKYd4Bl8d+e
	z2fZbdfd0x+rEHYk7a57MSFpR6rE1AI2TusIJwoHMKjpRBQS5LWFmnGRkmcvRRrs8epnZHnFeka
	0mXOQVB3G9DfXK82gSsUcH6IdEzjwg58guE2sXKYQ4b06a7VqxYxreRBhmj1RXHLpbBRNMV+N6K
	MVA1cDXWhMHCTG4CRFsHZHdNkEEOd9hSkzG66ka2vYLDpIZuzLaODQ3BLa4T6VcHVPI0rGnut8F
	5OIdiBqQDWcIquH7IbkAF7+XCV+qgd4n2fkyXMwTVOD/J3BJbtJkBqdBshdDaXB/jMsg74P5hpP
	7EorBgfDeHaPMPRAJpE5/IoAJrWze303P9FZSqKTIokeiukOmLS8ORIdIyjXbjmNbzEsbsPWEGJ
	a5Svb5U+ARIcUf+R0G7ogiYr7pAkKny3tntk6GbzqBrWx/TkrPSQXJp28BiPka3Lo9Up8Px8OVd
	eC92uXWo++vddNSB09uHwm66r1JAENkIinLfXWRsVL41CGfkL5RjzRo1BgGQpwrdcNe//cvGTj2
	4HOu6y4hvijIYuN+jwxMS0OZH46FfdYoVFrkrsVgwghq5MXcu2Z5CNq6cbucuit7DRrASu2Qove
	nIbMQhwfWeFuVcoCQg3UQOQZxsC6FqTImXUJ6rU4P030TQok1o0iI
X-Received: by 2002:a05:6102:5088:b0:7c3:ac79:9b09 with SMTP id ada2fe7eead31-7d6ba49c736mr1818893137.30.1795037333641;
        Wed, 18 Nov 2026 13:28:53 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:53 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-api@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v6 5/7] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to freeze sessions early
Date: Wed, 18 Nov 2026 16:28:40 -0500
Message-ID: <20261118212845.2855249-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132855_403701_F1706A68 
X-CRM114-Status: GOOD (  25.27  )
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

Add the LIVEUPDATE_SESSION_FREEZE ioctl on outgoing session FDs. Once
frozen, no additional files can be preserved in the session and
repeated freeze calls return -EBUSY.

Currently, LUO freezes sessions only during reboot(LINUX_REBOOT_CMD_KEXEC),
serially under global write locks. On hosts running multiple workloads
such as VMs, freezing sessions early under their per-session mutexes
lets workloads freeze in parallel as they pause ahead of kexec,
reducing blackout time.

By default, session lifetime remains tied to the session FD: closing
the FD before reboot unfreezes and unpreserves the session, while
keeping it open skips late auto-freeze at kexec.

Add optional flag LIVEUPDATE_SESSION_FREEZE_COMMIT to serialize the
frozen session and its FLBs immediately and transfer ownership to LUO
until reboot. Committed sessions survive closing the session FD,
allowing processes to hand off preserved state and exit prior to kexec.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/userspace-api/liveupdate.rst | 20 ++++++
 include/linux/liveupdate.h                 |  2 +-
 include/uapi/linux/liveupdate.h            | 38 ++++++++++++
 kernel/liveupdate/luo_file.c               | 37 +++++------
 kernel/liveupdate/luo_internal.h           |  3 +
 kernel/liveupdate/luo_session.c            | 71 ++++++++++++++++++++--
 6 files changed, 146 insertions(+), 25 deletions(-)

diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
index cdd74627ab75..c298b5d0dfe7 100644
--- a/Documentation/userspace-api/liveupdate.rst
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -22,6 +22,26 @@ change, so compatibility is not guaranteed when kexec rebooting between
 different kernel versions. This is expected to change and stabilize in a future
 version.
 
+Session Freeze
+==============
+
+By default, LUO freezes active sessions during reboot, and an outgoing session
+stays alive only while its session fd remains open. Closing the fd before
+reboot aborts preservation and releases the session's resources.
+
+Userspace can freeze an outgoing session earlier with LIVEUPDATE_SESSION_FREEZE
+once it is done preserving and modifying the session's files:
+
+- Freeze: freezes the session's preserved files, allowing sessions to freeze
+  concurrently ahead of reboot. The session remains tied to its fd, so closing
+  the fd before reboot rolls back and releases the session.
+
+- Freeze and commit: userspace can optionally set
+  LIVEUPDATE_SESSION_FREEZE_COMMIT in flags to commit the frozen session. This
+  serializes the session and its FLBs into the outgoing KHO state immediately
+  and hands ownership to LUO. Once committed, the session survives closing its
+  fd until reboot, allowing processes to exit before kexec.
+
 Userspace Integration
 =====================
 
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..ead033c59c22 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -59,7 +59,7 @@ struct liveupdate_file_op_args {
  *                compatible with the given file.
  * @preserve:     Required. Performs state-saving for the file.
  * @unpreserve:   Required. Cleans up any resources allocated by @preserve.
- * @freeze:       Optional. Final actions just before kernel transition.
+ * @freeze:       Optional. Final actions on session freeze or reboot.
  * @unfreeze:     Optional. Undo freeze operations.
  * @retrieve:     Required. Restores the file in the new kernel.
  * @can_finish:   Optional. Check if this FD can finish, i.e. all restoration
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 4043d4038712..ac456f4014c5 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -60,6 +60,7 @@ enum {
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
 	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
+	LIVEUPDATE_CMD_SESSION_FREEZE = 0x44,
 };
 
 /**
@@ -236,4 +237,41 @@ struct liveupdate_session_get_name {
 #define LIVEUPDATE_SESSION_GET_NAME					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
 
+/**
+ * enum liveupdate_session_freeze_flags - Flags for LIVEUPDATE_SESSION_FREEZE
+ * @LIVEUPDATE_SESSION_FREEZE_COMMIT: Commit the frozen session so it is
+ *                                    serialized immediately and survives
+ *                                    closing the session FD until reboot.
+ */
+enum liveupdate_session_freeze_flags {
+	LIVEUPDATE_SESSION_FREEZE_COMMIT = 1 << 0,
+};
+
+/**
+ * struct liveupdate_session_freeze - ioctl(LIVEUPDATE_SESSION_FREEZE)
+ * @size:  Input; sizeof(struct liveupdate_session_freeze)
+ * @flags: Input; Bitmask of enum liveupdate_session_freeze_flags.
+ *
+ * Freezes an outgoing session before kexec reboot. Once frozen, no further
+ * files can be preserved in the session and repeated freeze calls return
+ * -EBUSY. Calling this on an incoming session returns -EINVAL.
+ *
+ * With @flags set to 0, session lifetime stays tied to the session FD:
+ * closing the FD before reboot unfreezes and unpreserves the session.
+ *
+ * With %LIVEUPDATE_SESSION_FREEZE_COMMIT set, the frozen session is
+ * serialized immediately and ownership transfers to LUO until reboot.
+ * Closing the FD or another session failing to freeze during reboot will
+ * not unfreeze or unpreserve a committed session.
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
index cdd3c466e5ac..2cbac44d37cc 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -31,9 +31,8 @@
  *   - unpreserve(): Cleans up any resources allocated by .preserve(), called
  *     if the preservation process is aborted before the reboot (i.e. session is
  *     closed).
- *   - freeze(): A final pre-reboot opportunity to prepare the state for kexec.
- *     We are already in reboot syscall, and therefore userspace cannot mutate
- *     the file anymore.
+ *   - freeze(): Prepares the final state for kexec, invoked either on an
+ *     explicit session freeze or during the reboot() syscall.
  *   - unfreeze(): Undoes the actions of .freeze(), called if the live update
  *     is aborted after the freeze phase.
  *   - retrieve(): Reconstructs the file in the new kernel from the preserved
@@ -48,7 +47,7 @@
  *    handler, calls its .preserve() operation, and creates an internal &struct
  *    luo_file to track the live state.
  *
- * 2. Freeze (Pre-Reboot): Just before the kexec, luo_file_freeze() is called.
+ * 2. Freeze (Pre-Reboot): When a session freezes, luo_file_freeze() is called.
  *    It iterates through all preserved files, calls their respective .freeze()
  *    operation, and serializes their final metadata (compatible string, token,
  *    and data handle) into a contiguous memory block for KHO.
@@ -77,12 +76,15 @@
  *    descriptor), the session's release handler calls
  *    luo_file_unpreserve_files(). This invokes the .unpreserve() callback on
  *    all preserved files, ensuring all allocated resources are cleaned up and
- *    returning the system to a clean state.
+ *    returning the system to a clean state. If the session was frozen early
+ *    without committing, its files are unfrozen first. Committed sessions stay
+ *    preserved until reboot even after the session FD is closed.
  *
  * 2. Freeze Failure: During the reboot() syscall, if any handler's .freeze()
  *    op fails, the .unfreeze() op is invoked on all previously *successful*
  *    freezes to roll back their state. The reboot() syscall then returns an
- *    error to userspace, canceling the live update.
+ *    error to userspace, canceling the live update. On an explicit session
+ *    freeze, only that session's frozen files are rolled back via .unfreeze().
  *
  * 3. Finish Failure: In the new kernel, if a handler's .finish() op fails,
  *    the luo_file_finish() operation is aborted. LUO retains ownership of
@@ -457,9 +459,9 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  * luo_file_freeze - Freezes all preserved files and serializes their metadata.
  * @file_set: The file_set whose files are to be frozen.
  *
- * This function is called from the reboot() syscall path, just before the
- * kernel transitions to the new image via kexec. Its purpose is to perform the
- * final preparation and serialization of all preserved files in the file_set.
+ * This function is called on explicit session freeze or from the reboot()
+ * syscall path to perform final preparation and serialization of all
+ * preserved files in the file_set.
  *
  * It iterates through each preserved file in FIFO order (the order of
  * preservation) and performs two main actions:
@@ -476,13 +478,12 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
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
+ * Context: Called on explicit session freeze or from liveupdate_reboot().
  * Return: 0 on success, or a negative errno on failure.
  */
 int luo_file_freeze(struct luo_file_set *file_set)
@@ -532,15 +533,15 @@ int luo_file_freeze(struct luo_file_set *file_set)
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
index 3d948279f018..bd3f0d192621 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -66,6 +66,8 @@ struct luo_file_set {
  *              retrieved by a consumer in the new kernel.
  * @serialized: A boolean flag indicating whether this outgoing session has
  *              been serialized into KHO.
+ * @user_frozen: A boolean flag indicating whether this session has been
+ *               frozen explicitly from userspace.
  * @file_set:   A set of files that belong to this session.
  * @mutex:      protects fields in the luo_session.
  */
@@ -74,6 +76,7 @@ struct luo_session {
 	struct list_head list;
 	bool retrieved;
 	bool serialized;
+	bool user_frozen;
 	struct luo_file_set file_set;
 	struct mutex mutex;
 };
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 013386534b69..bf58718fa61b 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -34,10 +34,11 @@
  * 1.  Creation: A userspace agent calls `luo_session_create()` to create a
  *     new, empty session and receives a file descriptor for it.
  *
- * 2.  Serialization: When the `reboot(LINUX_REBOOT_CMD_KEXEC)` syscall is
- *     made, `luo_session_serialize()` is called. It iterates through all
- *     active sessions and writes their metadata into a memory area preserved
- *     by KHO.
+ * 2.  Serialization: Sessions may be frozen ahead of reboot via
+ *     `LIVEUPDATE_SESSION_FREEZE`, and optionally committed to serialize
+ *     their metadata into KHO immediately so they survive closing the FD.
+ *     When `reboot(LINUX_REBOOT_CMD_KEXEC)` is called,
+ *     `luo_session_serialize()` freezes and serializes any remaining sessions.
  *
  * 3.  Deserialization (in new kernel): After kexec, `luo_session_deserialize()`
  *     runs, reading the serialized data and creating a list of `struct
@@ -254,12 +255,21 @@ static int luo_session_finish_one(struct luo_session *session)
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
 
@@ -280,8 +290,13 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 		}
 		sh = &luo_session_global.incoming;
 	} else {
-		scoped_guard(mutex, &session->mutex)
+		scoped_guard(mutex, &session->mutex) {
+			if (session->serialized)
+				return 0;
+			if (session->user_frozen)
+				luo_file_unfreeze(&session->file_set);
 			luo_file_unpreserve_files(&session->file_set);
+		}
 		sh = &luo_session_global.outgoing;
 	}
 
@@ -298,6 +313,9 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	int err;
 
 	guard(mutex)(&session->mutex);
+	if (session->user_frozen)
+		return -EBUSY;
+
 	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
 	if (err)
 		return err;
@@ -371,11 +389,50 @@ static int luo_session_get_name(struct luo_session *session,
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
+		luo_session_serialize_one(session);
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
@@ -413,6 +470,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
 		 struct liveupdate_session_get_name, name, LUO_IOCTL_ALL),
+	IOCTL_OP(LIVEUPDATE_SESSION_FREEZE, luo_session_freeze,
+		 struct liveupdate_session_freeze, flags, LUO_IOCTL_OUTGOING),
 };
 
 static bool luo_ioctl_type_valid(struct luo_session *session,
-- 
2.56.1.708.g77570a6a1d-goog



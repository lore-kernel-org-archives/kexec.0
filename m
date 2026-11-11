Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDB60A2606
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=glUfpG2f;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DBs0ZX16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2Kx3wzBfUwksk18ANuXPfQbbKvvrdq3wbuLdN7ATve0=; b=glUfpG2fITQlk9Z00KXqWHe16c
	Mas2GVIWhj9ucCQh4/tfalop9+njwQ+qeh+eOFOxMGkNjnpomSM4ki3N55bGf5LD5/rKzyTI15rBE
	WRG5Ypqb53P8NjtJJhZYz6ndHsmBOtEz1A0U+C9/Vs5B68elCeyg3Q6jX5OUZ+YLrxr35HJuoZ3lb
	/Vhotar7tyMFQFFf3uF7TBlOtWfoEjWTBQfV6KBzWwwyYkKZwmsmEwIw0tFC9z6SKty5iMq0/rwMv
	LGYcmLeg+6ClA0yLmDHxBEk3Awegug+XVknRXMyTsoL5Y3co3OUfIR87Wze5I1XerpM+E3SW1aRQ2
	Fw+M+S7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38z-00000005xs0-2SH8;
	Wed, 11 Nov 2026 07:53:21 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38w-00000005xrS-41Ua
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:20 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1764839a12.2
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383598; x=1794988398; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2Kx3wzBfUwksk18ANuXPfQbbKvvrdq3wbuLdN7ATve0=;
        b=DBs0ZX16NIOVjava7/i7jf1I6/DJTw9QDRDV8+q+KA9fqoJYezzh49VlgOErHoyiOi
         1S8pnZnnH1WZXW4RCzB6dQmrDIbbDqQ3H/wv6wo6rmENqog7wYxgbj2cE5tT3SJ0oZVN
         cEIR/3Zq9kMeEVsHlw9MSplvFmoNt6qkeviCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383598; x=1794988398;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Kx3wzBfUwksk18ANuXPfQbbKvvrdq3wbuLdN7ATve0=;
        b=tnnW9sluMdxm4mb/YocBNJZ2wQ8PvvzAlKAFX+DytqCi0dZ0eYobee/qiGXLqfFuub
         Od2HbQenirYw+co/CAHr3WWl5GJaqyFenpI6eD5C+GDtE5VNtDvV6OYEua31Kr4feac6
         dnFloSw/uG9V4MkIPpb0SnG4EPC/U+HogcmWP8GUCJky2qNFj+MP0Bqm2sDCLq+kkVXh
         fvvxYiU9t6HFKJf3edneZSoUxv3H2Fx4MkV02dNT/UX2ln+Rp6DVHXzR5YFK1QmBw0lM
         AhCEZj8zThrvROnSi0ogNl/vXCeqqKr28whL7rqtdpESfq4JdIsOZ+AxoJcTvyaVvaUe
         UnkA==
X-Forwarded-Encrypted: i=1; AL+hErFnnnA6Q6Sceph0Yh607l4GtQUfgPWkbhMdEwYTVGUiW7UA0Go9NMjM/CvkwIhFBQ+7CZ1A0g==@lists.infradead.org
X-Gm-Message-State: APuU4Z+008sxREZT5Pg72ZAfV/nakKl+hfkWm9NbdjnKOthTCZgEr37i
	yFXXc43kUhkaF8G3mdk0QD8UEUKuDRO3AiYAlsiSP76Yuf706OKlaC7Iv+0t1CfVydI=
X-Gm-Gg: AYBFou1fXbvZo/Kdkga6oDJ/FoFnQVT3KS9tzfLu07zwHr8EzBCxkUqIZC7VXdEDj0k
	Mf7yIimVWMhgmQyiFIW8lCVHr/yqKRD+FvWqJG8ATYGj3AR44bZGseN0fd45MRGPW840y6rwiJN
	3gByRHS73iy6xisJfbp8Jauxn6/8cEbDFkjFeOdjg4G+f8M7ZMYmvzV18szvVi8Bwlgp0nA+gGX
	SloYk+KLNuXZM7rfN8X3FrSFvz9YR2YenSerzyQ2UZJdoXZQOBm6y+J+/nv5vrfb89zwjVKHEVq
	7gEOVDRBex7AAr83+PDBrVqkOdbB/US85iUxt4aUMQZzx+2Z5MVRhhWvgMVWk4yq+U1EWMAidAL
	M08P3kHVBO2Ph8Bfx3IUwDKCQUbIL9G/oKoczJjAsm0Y5R99WuHJX9G6fkzGKWLNJpEYG3iXzVg
	RhooGSyFWWK22xPVZ6yOTBvR2T3bMf6N05tbvxLQe4eHe7dgcnQ1RBI8mrS3iyVoj/hQFw2mlk0
	/GTI96y8P2kwFBCRqyWmeKmwPrPXoMa1iEfEHt768ml6DDMifJe8EadTL8dRW4zx4ZLSSjj6Og0
	WSKaj/BG++w7UnBcHYDjSqeMLnsRgRemRtkn439tdsRgD9SHK60jpJpJjGNT6lCZ3XmLyLQESXF
	HOF4rtm8l8u1RoJMMXEyEFC9egnvvROqUflG4nBYHjf/5dDi70MwoqYW74qvJbS9cAEVKe4OllE
	iVzTV3kpCm3l0Y1MDOnzxZQUjIzS6ch7UXfZ8mWPr2eCnSiL7sn1wFgf6ghcS4+HgVNaDZBXhLE
	g==
X-Received: by 2002:a17:90b:4c4d:b0:3b0:9691:a240 with SMTP id 98e67ed59e1d1-3b182ee8638mr1751151a91.47.1794383598151;
        Tue, 10 Nov 2026 23:53:18 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dbcbaf5sm3506003a91.0.2026.11.10.23.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:17 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:14 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 3/9] liveupdate: Make failed retrieves distinguishable from
 dropped files
Message-ID: <772c150d0a90139a327803cecf087f6865702753.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235319_038045_6AB5D861 
X-CRM114-Status: GOOD (  31.60  )
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At Meta, we want to use live update to upgrade hypervisors in place and
preserve service fd stores across systemctl kexec. Our kernel rollout
stops automatically when host health checks fail.

We need it to stop if the new kernel can't give back state that a VMM or
service handed over. We also want to track files that userspace never
asks for.

Today the process that tries a retrieve sees its error, but a fleet
collector can't see that error or tell whether a session went unclaimed.
Opening /dev/liveupdate to check would itself trigger deserialisation on
the first open and can get in the way of the real restorer because the
device is exclusive-open. The collector polls procfs and sysfs, so it
needs a result it can read after the event.

Let's expose the incoming deserialisation state and aggregate session
and file counts under /sys/class/misc/liveupdate/incoming/. A collector
can stop the rollout on state=failed or files_failed > 0, and track
files that were dropped or are still held. The session owner already
knows which VM or service it belongs to, so there is no need to expose
session names.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../ABI/testing/sysfs-class-misc-liveupdate   | 44 ++++++++++++++++
 Documentation/userspace-api/liveupdate.rst    |  7 +++
 MAINTAINERS                                   |  1 +
 kernel/liveupdate/luo_core.c                  | 50 +++++++++++++++++++
 kernel/liveupdate/luo_file.c                  | 16 +++++-
 kernel/liveupdate/luo_internal.h              | 34 +++++++++++++
 kernel/liveupdate/luo_session.c               |  6 +++
 7 files changed, 156 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-misc-liveupdate

diff --git a/Documentation/ABI/testing/sysfs-class-misc-liveupdate b/Documentation/ABI/testing/sysfs-class-misc-liveupdate
new file mode 100644
index 000000000000..25e3b49d7aeb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-misc-liveupdate
@@ -0,0 +1,44 @@
+What:		/sys/class/misc/liveupdate/incoming/
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:
+		Incoming Live Update Orchestrator (LUO) state and counters.
+		Present when live update is enabled. Each attribute is read
+		independently.
+Users:		system monitoring
+
+What:		/sys/class/misc/liveupdate/incoming/state
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Status of incoming LUO sessions:
+
+		"none"          No sessions were handed over.
+		"pending"       Deserialization has not finished. It
+		                starts on the first open of /dev/liveupdate.
+		"deserialized"  The sessions can be retrieved.
+		"failed"        Deserialization failed. Opening
+		                /dev/liveupdate returns -EIO.
+Users:		system monitoring
+
+What:		/sys/class/misc/liveupdate/incoming/sessions
+What:		/sys/class/misc/liveupdate/incoming/files
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Number of sessions deserialized and number of files in
+		those sessions, respectively. Counts can be partial while
+		state is "pending" or after it changes to "failed".
+Users:		system monitoring
+
+What:		/sys/class/misc/liveupdate/incoming/files_retrieved
+What:		/sys/class/misc/liveupdate/incoming/files_failed
+What:		/sys/class/misc/liveupdate/incoming/files_dropped
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Number of successful retrieves, permanent retrieve failures,
+		and files discarded at session finish without a recorded
+		retrieve outcome, respectively. Retrieves and failures are
+		counted when they occur.
+Users:		system monitoring
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
index cdd74627ab75..39bbb91d0dd4 100644
--- a/Documentation/userspace-api/liveupdate.rst
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -45,6 +45,13 @@ For details, see:
 - `sd_pid_notify_with_fds(3)
   <https://www.freedesktop.org/software/systemd/man/latest/sd_pid_notify_with_fds.html>`_
 
+Monitoring
+==========
+
+Read ``/sys/class/misc/liveupdate/incoming/`` to monitor incoming
+sessions and file retrievals without opening ``/dev/liveupdate``.
+See Documentation/ABI/testing/sysfs-class-misc-liveupdate for the sysfs ABI.
+
 See Also
 ========
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 1572f6c905aa..b98b95cd6d12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15523,6 +15523,7 @@ L:	kexec@lists.infradead.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/ABI/testing/sysfs-class-misc-liveupdate
 F:	Documentation/core-api/liveupdate.rst
 F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..ba174e9aae03 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -75,6 +75,8 @@ static struct {
  */
 DECLARE_RWSEM(luo_register_rwlock);
 
+struct luo_incoming_stats luo_incoming_stats;
+
 static int __init early_liveupdate_param(char *buf)
 {
 	return kstrtobool(buf, &luo_global.enabled);
@@ -423,11 +425,59 @@ static const struct file_operations luo_fops = {
 	.unlocked_ioctl	= luo_ioctl,
 };
 
+static const char * const luo_incoming_state_names[] = {
+	[LUO_INCOMING_NONE]		= "none",
+	[LUO_INCOMING_PENDING]		= "pending",
+	[LUO_INCOMING_DESERIALIZED]	= "deserialized",
+	[LUO_INCOMING_FAILED]		= "failed",
+};
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	enum luo_incoming_state state = READ_ONCE(luo_incoming_stats.state);
+
+	return sysfs_emit(buf, "%s\n", luo_incoming_state_names[state]);
+}
+static DEVICE_ATTR_RO(state);
+
+#define LUO_INCOMING_ATTR_RO(_name)					\
+static ssize_t _name##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	return sysfs_emit(buf, "%ld\n",					\
+			  atomic_long_read(&luo_incoming_stats._name));	\
+}									\
+static DEVICE_ATTR_RO(_name)
+
+LUO_INCOMING_ATTR_RO(sessions);
+LUO_INCOMING_ATTR_RO(files);
+LUO_INCOMING_ATTR_RO(files_retrieved);
+LUO_INCOMING_ATTR_RO(files_failed);
+LUO_INCOMING_ATTR_RO(files_dropped);
+
+static struct attribute *luo_incoming_attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_sessions.attr,
+	&dev_attr_files.attr,
+	&dev_attr_files_retrieved.attr,
+	&dev_attr_files_failed.attr,
+	&dev_attr_files_dropped.attr,
+	NULL
+};
+
+static const struct attribute_group luo_incoming_group = {
+	.name	= "incoming",
+	.attrs	= luo_incoming_attrs,
+};
+__ATTRIBUTE_GROUPS(luo_incoming);
+
 static struct luo_device_state luo_dev = {
 	.miscdev = {
 		.minor = MISC_DYNAMIC_MINOR,
 		.name  = "liveupdate",
 		.fops  = &luo_fops,
+		.groups = luo_incoming_groups,
 	},
 	.in_use = ATOMIC_INIT(0),
 };
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..3aac1afa05c0 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -543,6 +543,16 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
 	memset(file_set_ser, 0, sizeof(*file_set_ser));
 }
 
+/* Record the first retrieve result. A negative status is permanent. */
+static void luo_file_set_retrieve_status(struct luo_file *luo_file, int status)
+{
+	luo_file->retrieve_status = status;
+	if (status > 0)
+		atomic_long_inc(&luo_incoming_stats.files_retrieved);
+	else
+		atomic_long_inc(&luo_incoming_stats.files_failed);
+}
+
 /**
  * luo_retrieve_file - Restores a preserved file from a file_set by its token.
  * @file_set: The file_set from which to retrieve the file.
@@ -611,7 +621,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	err = luo_file->fh->ops->retrieve(&args);
 	if (err) {
 		/* Keep the error code for later use. */
-		luo_file->retrieve_status = err;
+		luo_file_set_retrieve_status(luo_file, err);
 		return err;
 	}
 
@@ -624,7 +634,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 			  luo_file->file, GFP_KERNEL));
 
 	*filep = luo_file->file;
-	luo_file->retrieve_status = 1;
+	luo_file_set_retrieve_status(luo_file, 1);
 
 	return 0;
 }
@@ -719,6 +729,8 @@ int luo_file_finish(struct luo_file_set *file_set)
 					   struct luo_file, list);
 
 		luo_file_finish_one(file_set, luo_file);
+		if (!luo_file->retrieve_status)
+			atomic_long_inc(&luo_incoming_stats.files_dropped);
 
 		if (luo_file->file) {
 			xa_erase(&luo_preserved_files,
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..504963fc9898 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -77,6 +77,40 @@ struct luo_session {
 
 extern struct rw_semaphore luo_register_rwlock;
 
+/**
+ * enum luo_incoming_state - Deserialization state of incoming sessions
+ * @LUO_INCOMING_NONE: No incoming sessions.
+ * @LUO_INCOMING_PENDING: Deserialization has not finished.
+ * @LUO_INCOMING_DESERIALIZED: Sessions are ready to retrieve.
+ * @LUO_INCOMING_FAILED: Deserialization failed.
+ */
+enum luo_incoming_state {
+	LUO_INCOMING_NONE,
+	LUO_INCOMING_PENDING,
+	LUO_INCOMING_DESERIALIZED,
+	LUO_INCOMING_FAILED,
+};
+
+/**
+ * struct luo_incoming_stats - Incoming session and file counters
+ * @state: Deserialization state.
+ * @sessions: Sessions deserialized.
+ * @files: Files in deserialized sessions.
+ * @files_retrieved: Files retrieved.
+ * @files_failed: Permanent retrieve failures.
+ * @files_dropped: Files discarded without a retrieve outcome.
+ */
+struct luo_incoming_stats {
+	enum luo_incoming_state state;
+	atomic_long_t sessions;
+	atomic_long_t files;
+	atomic_long_t files_retrieved;
+	atomic_long_t files_failed;
+	atomic_long_t files_dropped;
+};
+
+extern struct luo_incoming_stats luo_incoming_stats;
+
 static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
 {
 	struct luo_session *session;
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 74bc66929f4b..1a40607bfc45 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -549,6 +549,7 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
 		return err;
 
 	sh->active = true;
+	luo_incoming_stats.state = LUO_INCOMING_PENDING;
 	return 0;
 }
 
@@ -583,6 +584,9 @@ static int luo_session_deserialize_one(struct luo_session_header *sh,
 		return err;
 	}
 
+	atomic_long_inc(&luo_incoming_stats.sessions);
+	atomic_long_add(session->file_set.count, &luo_incoming_stats.files);
+
 	return 0;
 }
 
@@ -626,12 +630,14 @@ int luo_session_deserialize(void)
 	}
 
 	kho_block_set_destroy(&sh->block_set);
+	WRITE_ONCE(luo_incoming_stats.state, LUO_INCOMING_DESERIALIZED);
 
 	return 0;
 
 save_err:
 	kho_block_set_destroy(&sh->block_set);
 	saved_err = err;
+	WRITE_ONCE(luo_incoming_stats.state, LUO_INCOMING_FAILED);
 	return err;
 }
 
-- 
2.54.0



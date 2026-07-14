Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5097C44507
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1qGE5ydJOmS1JfOhVj+BHZS34VvobSfS8GWdyN4K2uQ=; b=OlebMuio7+BokBMzoFLbhR9vyC
	Y1Egs3IbTxmuh4kGPpPHllQWKbd/lV1xHD4kj3aNC/QXjHLv0h0nW/TLO3eRse5tO5IAMEdtqjxN4
	r9jEjoU56AFesX0/2IN+7v0fSd1lG+/Pl8M3Ke35igCJn7BlEJN1D7w39iSTq0EvHGyu4WM0dCvWY
	QfaJeHEsDaz4bdm1uSpH+sY7IAC2llSfodZ4Ykywm/lIE7riD8rKV6B3CP9qr+mJ6rARohhCGt3Oj
	NJaa2ntBbgFHuVH8qyT8BdIu37dRleQwPeI2438kRTFO1yY93OjyUyE9hWk4vcBTlSZXO74KdWGDx
	ZSdJ483g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjiQJ-0000000Cyy6-4151;
	Tue, 14 Jul 2026 19:04:07 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjiQH-0000000CyxZ-3CR6
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 19:04:06 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso1209148a12.0
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784055844; x=1784660644; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qGE5ydJOmS1JfOhVj+BHZS34VvobSfS8GWdyN4K2uQ=;
        b=L5xDCYuJuAJYTXVPjTeWhE7Q3MsmruaiQbaSqJfK0mMAztXbheIz/b7LFS8z3kbpBv
         Mb8Z+8wL81tCLZdh40H04rXtnM0Ub5W5XJU3q+s2o0cwOj05FiuWIjyvE2Ws5WjP9+Eo
         znjb5WVuIrM4A+7TKoKA5y+FDjodOSO7dsKH1vJ5zVXlBu+5rP7APWN0D6YpIfc7qgI/
         m7ewS6mkfbKgSGmZsWW1TGqAXWdwoiKzygLVhh1Dp9hs6KPxhmTXWNM8KHSbO4w/iZhS
         tUV0Sg/pFeqMLgzXaonAVv6gm2mquBP1GD3PqXjMVbE/BM8OAiUpPJ/UEw/uEfQfF5Hd
         rfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055844; x=1784660644;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qGE5ydJOmS1JfOhVj+BHZS34VvobSfS8GWdyN4K2uQ=;
        b=PiQCJJHE2fdtz8T92drCfBbDwGrzA7xsA26Y/Lwm7Uf27CZX+ghbz5DIcHkw0h2kFv
         qbzsdMGC2RMO/q2BWoKZolEVW8svUwe0vwzR0dE/UO1vxgucX3keJKg99glGSyuiYazw
         dpPo8E8Zyv06DhaC47R4nnp858hJbsX5CO6+5CMsuM0la3J81tk8ipMZTkTqYt5r0A//
         rPwusKLcIHm0Q418iyjoRTyZAAEhv3oX+IErem2AzyUYka9qubVcNtljkj/jSgoT1V8H
         gTsISu+cPwr0G/BpVoASOkhMaBIXP7Yd4tDshtUDGzUbqYPy/cSimkbfQowAg48RnIa/
         sQ7A==
X-Gm-Message-State: AOJu0Yw8dQHUMHtSiVLIYhppEF+UuZr/n8g53K5MltSihT79QhWsH082
	+ZzKyzDc+6t+HliNY8rhGCcNeDd/ZSNQEjP13VV2GRp7ZU1tys12Bgm/76uD26dUNU0LTdnBLek
	irB+m2A8eVouWzYb9lRnw4UIEH64zaLYw3IizFLT+a8SQxkDv7d884M/diNjFCL27n9UAFIznbZ
	BehykeCce6TlyWvT7xSabNS7i7Q55CGsFznfCqJRVQDOmfJlm0Wf0=
X-Received: from pgkz32.prod.google.com ([2002:a63:a60:0:b0:c9e:295c:e230])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d49a:b0:3bf:6c08:2b2d with SMTP id adf61e73a8af0-3c110b6c28bmr16229745637.53.1784055843887;
 Tue, 14 Jul 2026 12:04:03 -0700 (PDT)
Date: Tue, 14 Jul 2026 19:03:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714190356.190328-1-dmatlack@google.com>
Subject: [RFC PATCH] liveupdate: Allow multiple openers for /dev/liveupdate
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_120405_809105_A5DA9573 
X-CRM114-Status: GOOD (  23.57  )
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

Remove the single-opener restriction for /dev/liveupdate by removing the
atomic in_use tracking and the exclusive open check in luo_open() that
returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
that concurrent open attempts by multiple processes safely executes
deserialization only once. Update liveupdate selftest to verify that
multiple concurrent openers succeed.

LUO does not inherently require a single opener. There is some
documentation about it simplifying state management, but the only thing
it actually protects is the session deserialization during first open,
which can be easily handled with a mutex.

Relaxing the single-opener requirement avoids the kernel forcing a
design pattern on userspace that it itself does not require, e.g.
allowing multiple userspace processes to create and manage sessions.

Signed-off-by: David Matlack <dmatlack@google.com>
---
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>

 kernel/liveupdate/luo_core.c                  | 46 +++----------------
 kernel/liveupdate/luo_session.c               |  8 +++-
 .../testing/selftests/liveupdate/liveupdate.c | 14 +++---
 3 files changed, 18 insertions(+), 50 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..931bb79da276 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -254,19 +254,8 @@ bool liveupdate_enabled(void)
  * which allows a userspace agent to manage the LUO state machine and its
  * associated resources, such as preservable file descriptors.
  *
- * To ensure that the state machine is controlled by a single entity, access
- * to this device is exclusive: only one process is permitted to have
- * ``/dev/liveupdate`` open at any given time. Subsequent open attempts will
- * fail with -EBUSY until the first process closes its file descriptor.
- * This singleton model simplifies state management by preventing conflicting
- * commands from multiple userspace agents.
  */
 
-struct luo_device_state {
-	struct miscdevice miscdev;
-	atomic_t in_use;
-};
-
 static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
 {
 	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
@@ -329,28 +318,9 @@ static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
 
 static int luo_open(struct inode *inodep, struct file *filep)
 {
-	struct luo_device_state *ldev = container_of(filep->private_data,
-						     struct luo_device_state,
-						     miscdev);
-
-	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
-		return -EBUSY;
-
 	/* Always return -EIO to user if deserialization fail */
-	if (luo_session_deserialize()) {
-		atomic_set(&ldev->in_use, 0);
+	if (luo_session_deserialize())
 		return -EIO;
-	}
-
-	return 0;
-}
-
-static int luo_release(struct inode *inodep, struct file *filep)
-{
-	struct luo_device_state *ldev = container_of(filep->private_data,
-						     struct luo_device_state,
-						     miscdev);
-	atomic_set(&ldev->in_use, 0);
 
 	return 0;
 }
@@ -419,17 +389,13 @@ static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 static const struct file_operations luo_fops = {
 	.owner		= THIS_MODULE,
 	.open		= luo_open,
-	.release	= luo_release,
 	.unlocked_ioctl	= luo_ioctl,
 };
 
-static struct luo_device_state luo_dev = {
-	.miscdev = {
-		.minor = MISC_DYNAMIC_MINOR,
-		.name  = "liveupdate",
-		.fops  = &luo_fops,
-	},
-	.in_use = ATOMIC_INIT(0),
+static struct miscdevice luo_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name  = "liveupdate",
+	.fops  = &luo_fops,
 };
 
 static int __init liveupdate_ioctl_init(void)
@@ -437,6 +403,6 @@ static int __init liveupdate_ioctl_init(void)
 	if (!liveupdate_enabled())
 		return 0;
 
-	return misc_register(&luo_dev.miscdev);
+	return misc_register(&luo_dev);
 }
 late_initcall(liveupdate_ioctl_init);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index b79b2a488974..ca4d0639d39a 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -584,13 +584,17 @@ static int luo_session_deserialize_one(struct luo_session_header *sh,
 
 int luo_session_deserialize(void)
 {
-	struct luo_session_header *sh = &luo_session_global.incoming;
+	static DEFINE_MUTEX(luo_session_deserialize_lock);
 	static bool is_deserialized;
+	static int saved_err;
+
+	struct luo_session_header *sh = &luo_session_global.incoming;
 	struct luo_session_ser *ser;
 	struct kho_block_set_it it;
-	static int saved_err;
 	int err;
 
+	guard(mutex)(&luo_session_deserialize_lock);
+
 	/* If has been deserialized, always return the same error code */
 	if (is_deserialized)
 		return saved_err;
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 502fb3567e38..a8e1a8911849 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -11,7 +11,7 @@
  * /dev/liveupdate character device and its session management capabilities.
  *
  * Tests include:
- * - Device access: basic open/close, and enforcement of exclusive access.
+ * - Device access: basic open/close, and support for multiple openers.
  * - Session management: creation of unique sessions, and duplicate name detection.
  * - Resource preservation: successfully preserving individual and multiple memfds,
  *   verifying contents remain accessible.
@@ -70,13 +70,12 @@ TEST_F(liveupdate_device, basic_open_close)
 }
 
 /*
- * Test Case: Exclusive Open Enforcement
+ * Test Case: Multiple Open Support
  *
- * Verifies that the /dev/liveupdate device can only be opened by one process
- * at a time. It checks that a second attempt to open the device fails with
- * the EBUSY error code.
+ * Verifies that the /dev/liveupdate device can be opened by multiple openers
+ * concurrently without errors.
  */
-TEST_F(liveupdate_device, exclusive_open)
+TEST_F(liveupdate_device, multiple_open)
 {
 	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
 
@@ -85,8 +84,7 @@ TEST_F(liveupdate_device, exclusive_open)
 
 	ASSERT_GE(self->fd1, 0);
 	self->fd2 = open(LIVEUPDATE_DEV, O_RDWR);
-	EXPECT_LT(self->fd2, 0);
-	EXPECT_EQ(errno, EBUSY);
+	ASSERT_GE(self->fd2, 0);
 }
 
 /* Helper function to create a LUO session via ioctl. */

base-commit: 10fd52dc7bbd6013e949ff1833be0821b7553fb0
-- 
2.55.0.141.g00534a21ce-goog



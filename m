Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6F606CEE6
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jGHR9XPI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyNIQCxY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Dp7sSooWMguSrSQWYm7n5WBM775aoRxhTJFL+eJzfGM=; b=jGHR9XPIsWkMrv
	yGULKjBPfgypELH7Tq4wiHVeIfxCbZM7zrz+buaC69x4MMvjunsq3U0DLBjv+lpqkCC6L42WmKZv9
	T8l71b/Tiik7uXYluZkacdwj/mc4gWiSoRnIr+mKLB/UrDs8lHPAHXdcBWpHlumEU25Aw06jAeBq3
	y0p++B6EbYsHmASREwj82s8u6nqccc4oKijs2Y6BgFnaNiYe2IP4u5FmE6dRHaACDomQRdZN/TzR3
	mbkzvUXFNNTYXG1MP8C34l+h+x6u1BxX9LTJCnCjzJrkiI3YEfmjjlWCE9Gx0GrxU87ambZTGc0E1
	NyQwhzp7SqGGg/kS147A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNte8-0000000GzVD-0cJx;
	Mon, 02 Nov 2026 15:08:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNte6-0000000GzUx-1xDc;
	Mon, 02 Nov 2026 15:08:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 39FC443A0A;
	Mon,  2 Nov 2026 15:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E931F00A20;
	Mon,  2 Nov 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632106;
	bh=Dp7sSooWMguSrSQWYm7n5WBM775aoRxhTJFL+eJzfGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eyNIQCxYEcRLLrGyZcPtIprIvg2rkuSpaKrMvW58hJQxt/VyWt7hS3Qal6zoUQ/gl
	 0f9cCCPMX1bOMUh9BIWeFK5f4ATpN0EM/aPUrffzJ9XwWlsu4eKD6ZgzUlwDjfLjwL
	 Uvn00wNomN8/SMqh9jXER44dMwsdR9yWd6JSqBhqRXPHK14atBxuYmQ+rYaoEBUKUD
	 vDmMOPV29JIfjjL6fBW6U6eWYBA/B7Lc6f6IJGDxAZNs993WFUAYbhkuu/ueCEe0L/
	 Yqu69q4QgN/VaqD5PYjScQjBFfvU4mejG6swjL58FVzjyKA2XiENQnp0sJJnQeShIQ
	 zmvRe7kDYECMg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:47 +0100
Subject: [PATCH RFC 20/22] platform/x86: toshiba_acpi: let procfs copy in
 writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-arch-v1-20-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
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

Implement ->proc_write_buf() for the files in /proc/acpi/toshiba so
procfs copies in what is written before it pins the entry, and parse
what was written from that copy. Commands longer than PAGE_SIZE - 1
bytes are rejected now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/platform/x86/toshiba_acpi.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 560e62da05a9..895e321ada03 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1478,7 +1478,7 @@ static int set_lcd_status(struct backlight_device *bd)
 	return set_lcd_brightness(dev, bd->props.brightness);
 }
 
-static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
+static ssize_t lcd_proc_write(struct file *file, char *buf,
 			      size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
@@ -1488,8 +1488,7 @@ static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
 	int value;
 
 	len = min(count, sizeof(cmd) - 1);
-	if (copy_from_user(cmd, buf, len))
-		return -EFAULT;
+	memcpy(cmd, buf, len);
 	cmd[len] = '\0';
 
 	levels = dev->backlight_dev->props.max_brightness + 1;
@@ -1505,7 +1504,7 @@ static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops lcd_proc_ops = {
 	.proc_show	= lcd_proc_show,
-	.proc_write	= lcd_proc_write,
+	.proc_write_buf	= lcd_proc_write,
 };
 
 /* Video-Out */
@@ -1541,24 +1540,17 @@ static int video_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t video_proc_write(struct file *file, const char __user *buf,
+static ssize_t video_proc_write(struct file *file, char *buf,
 				size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
-	char *buffer;
-	char *cmd;
+	char *buffer = buf;
 	int lcd_out = -1, crt_out = -1, tv_out = -1;
 	int remain = count;
 	int value;
 	int ret;
 	u32 video_out;
 
-	cmd = memdup_user_nul(buf, count);
-	if (IS_ERR(cmd))
-		return PTR_ERR(cmd);
-
-	buffer = cmd;
-
 	/*
 	 * Scan expression.  Multiple expressions may be delimited with ;
 	 * NOTE: To keep scanning simple, invalid fields are ignored.
@@ -1577,8 +1569,6 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
 		} while (remain && *(buffer - 1) != ';');
 	}
 
-	kfree(cmd);
-
 	ret = get_video_status(dev, &video_out);
 	if (!ret) {
 		unsigned int new_video_out = video_out;
@@ -1602,7 +1592,7 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops video_proc_ops = {
 	.proc_show	= video_proc_show,
-	.proc_write	= video_proc_write,
+	.proc_write_buf	= video_proc_write,
 };
 
 /* Fan status */
@@ -1644,7 +1634,7 @@ static int fan_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t fan_proc_write(struct file *file, const char __user *buf,
+static ssize_t fan_proc_write(struct file *file, char *buf,
 			      size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
@@ -1653,8 +1643,7 @@ static ssize_t fan_proc_write(struct file *file, const char __user *buf,
 	int value;
 
 	len = min(count, sizeof(cmd) - 1);
-	if (copy_from_user(cmd, buf, len))
-		return -EFAULT;
+	memcpy(cmd, buf, len);
 	cmd[len] = '\0';
 
 	if (sscanf(cmd, " force_on : %i", &value) != 1 ||
@@ -1671,7 +1660,7 @@ static ssize_t fan_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops fan_proc_ops = {
 	.proc_show	= fan_proc_show,
-	.proc_write	= fan_proc_write,
+	.proc_write_buf	= fan_proc_write,
 };
 
 /* Fan RPM */
@@ -1707,7 +1696,7 @@ static int keys_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t keys_proc_write(struct file *file, const char __user *buf,
+static ssize_t keys_proc_write(struct file *file, char *buf,
 			       size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
@@ -1716,8 +1705,7 @@ static ssize_t keys_proc_write(struct file *file, const char __user *buf,
 	int value;
 
 	len = min(count, sizeof(cmd) - 1);
-	if (copy_from_user(cmd, buf, len))
-		return -EFAULT;
+	memcpy(cmd, buf, len);
 	cmd[len] = '\0';
 
 	if (sscanf(cmd, " hotkey_ready : %i", &value) == 1 && value == 0)
@@ -1730,7 +1718,7 @@ static ssize_t keys_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops keys_proc_ops = {
 	.proc_show	= keys_proc_show,
-	.proc_write	= keys_proc_write,
+	.proc_write_buf	= keys_proc_write,
 };
 
 static int __maybe_unused version_proc_show(struct seq_file *m, void *v)

-- 
2.53.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C67608ED52
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fEO2R3Yh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtj+GH2h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Vfgsd3PUinlq5Gnmk93ZNsjvWtIfYjQstKDgqXFFHmI=; b=fEO2R3Yh2EY5Kc
	rF42KOKSEAeIaGJEeQ2706TVNe1TlZNy7x4uZqIPXC9YyAs+q/aPvpnKyK1HRuD/qQy7IKjz3Vhn+
	hFf1BGF5rIQg5gV19pBJ29xRWpg73oOKLMIGG4eE34M3R21q8DRVTvPE1Z9APJFMU07lm3SBXYsCy
	htfA2vwJg4xGC1HqQvLv/seAK5HZibKvMuKE3ZuyHN7AXRl1AqXCs9jCtdJ+YnuSM7u6GtH123KZz
	sdH+kDcE9DHwdMkv1H9aAqZQbFhBvpuxPibEBqEW0wU7h/HbD4szxZZkUHftrfuUQffy8QOOLwh+/
	xC4C8CPjd+J54z5eEJSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgxP-00000006kvO-0fh9;
	Wed, 04 Nov 2026 19:47:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgxO-00000006kvB-2kL7;
	Wed, 04 Nov 2026 19:47:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 66EDC417AD;
	Wed,  4 Nov 2026 19:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D2E1F0093A;
	Wed,  4 Nov 2026 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821658;
	bh=Vfgsd3PUinlq5Gnmk93ZNsjvWtIfYjQstKDgqXFFHmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtj+GH2hqTPplDjhVzhRAWhU8OkVhPJPP0JLMRwTbfdc+nl4HFqaLUtkQ0sGqY9p1
	 cio3rKWjRbaW0hfoe+iR5yUiUxGlvl6F9N71fZhbqKX3d7khRaPNZmLb3yNj8B0VZt
	 vYfLltTat3exR0SQB7Uf68Jxi/SRcYyBvdcK5hbQj2/GV68lWs4IX74yTfnWqymq82
	 M8yspGv/K4UmZRSLladjige3wPn9EOhryHH1PaBstskLXXtn/pAaCO1Kia1pLxX1NY
	 C6gBdMcfP0MHCUtCGkHA2XBsPT4EAkNI1eiSvXtWEQIDsoCAj2OLDYM0olGMiVe6SX
	 LvO7OJ7dWJD9w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: [PATCH RESEND v2 21/26] Input: let procfs own the wait queue of /proc/bus/input/devices
Date: Wed,  4 Nov 2026 20:47:23 +0100
Message-ID: <20261104-work-procfs-drivers-v2-21-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=brauner@kernel.org; h=from:subject:message-id; bh=cAurGI8IRWHsk8N+x2SlkH9/s4vXIqR5KE32d74H9dY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97uoVPNHOMiVW7/vlsMd9s7daas+73xSQc6TwtsuLx am89pNudZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk6xbDPwufULMS+bvROaer RY/ePlP4dAePp5GonG38y6XNHTtmb2H4n3LmTr9vRD1nY+L127WsJ/1+dr1MjVS/KzLXyCg/wcW ECQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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

input_proc_devices_poll() sleeps the poller on a queue of its own.
procfs owns the queue poll() uses now, so leave the poll_wait() to it
and wake its pollers instead.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/input/input.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index d27eecbf4a03..a984810eb80d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1082,13 +1082,13 @@ static int input_attach_handler(struct input_dev *dev, struct input_handler *han
 #ifdef CONFIG_PROC_FS
 
 static struct proc_dir_entry *proc_bus_input_dir;
-static DECLARE_WAIT_QUEUE_HEAD(input_devices_poll_wait);
+static struct proc_dir_entry *proc_bus_input_devices;
 static int input_devices_state;
 
 static inline void input_wakeup_procfs_readers(void)
 {
 	input_devices_state++;
-	wake_up(&input_devices_poll_wait);
+	proc_poll_notify(proc_bus_input_devices);
 }
 
 struct input_seq_state {
@@ -1102,7 +1102,6 @@ static __poll_t input_proc_devices_poll(struct file *file, poll_table *wait)
 	struct seq_file *seq = file->private_data;
 	struct input_seq_state *state = seq->private;
 
-	poll_wait(file, &input_devices_poll_wait, wait);
 	if (state->input_devices_state != input_devices_state) {
 		state->input_devices_state = input_devices_state;
 		return EPOLLIN | EPOLLRDNORM;
@@ -1284,9 +1283,9 @@ static int __init input_proc_init(void)
 	if (!proc_bus_input_dir)
 		return -ENOMEM;
 
-	entry = proc_create("devices", 0, proc_bus_input_dir,
-			    &input_devices_proc_ops);
-	if (!entry)
+	proc_bus_input_devices = proc_create("devices", 0, proc_bus_input_dir,
+					     &input_devices_proc_ops);
+	if (!proc_bus_input_devices)
 		goto fail1;
 
 	entry = proc_create("handlers", 0, proc_bus_input_dir,
@@ -1297,6 +1296,7 @@ static int __init input_proc_init(void)
 	return 0;
 
  fail2:	remove_proc_entry("devices", proc_bus_input_dir);
+	proc_bus_input_devices = NULL;
  fail1: remove_proc_entry("bus/input", NULL);
 	return -ENOMEM;
 }
@@ -1304,6 +1304,7 @@ static int __init input_proc_init(void)
 static void input_proc_exit(void)
 {
 	remove_proc_entry("devices", proc_bus_input_dir);
+	proc_bus_input_devices = NULL;
 	remove_proc_entry("handlers", proc_bus_input_dir);
 	remove_proc_entry("bus/input", NULL);
 }

-- 
2.53.0



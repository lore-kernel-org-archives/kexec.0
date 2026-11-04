Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DF60C1683
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c5jwpmx1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aicfXnWV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Z72TnyR4FqZWuZXLi7RAB/58/idtKzOn4i9EyTHtGiw=; b=c5jwpmx1jWksPx
	6yJ6MnVKcBz4Bi1G2YOZHt3C5XUFGZT3GrVMNZrtW21dGYMvcUl1At04w0nQKY6MzFDx9seLq2Zy5
	frEJ8PCUxX6Gh0wwuDFkE4KmWxa/jXPEnPR3XWEM/3ndpM30aApoIH1i2HcU4J+APMXM8AGh2FH+2
	e5svbVdTTuVVYdWQzRZNfiI0hwi3dysGpF7pIPR1D4S4g+BEgcrKPtnXmaQAxUrmejoRCgjG3nygO
	mWy19Tly+Xw7dcoouxbe/mwDG2D67yo9qZLVxLCH75HlaQyjiUL57z6XI8pzFKzf/kqnpNF3F/MqH
	M7AsDCHzR8MnhP0RIF6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgu3-00000006jMm-0vO7;
	Wed, 04 Nov 2026 19:44:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgu2-00000006jMX-1ECD;
	Wed, 04 Nov 2026 19:44:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1024940584;
	Wed,  4 Nov 2026 19:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0511F00919;
	Wed,  4 Nov 2026 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821449;
	bh=Z72TnyR4FqZWuZXLi7RAB/58/idtKzOn4i9EyTHtGiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aicfXnWVc+2sorHSEArN9gD6s+r89vzM3QCItz87jq7xenbwZcKkxAyhEzMN4zilO
	 XEmAW5nDi6Qpy1HAR+3dogNdprQDzauusCx/5cNW0SrbZVyC5GFUF34a5Ax3Ufz9Ir
	 pPUXceddaTjvbGaHwgGMseQ+qlmEYJQbjS+TTvruu0qlgjbpKch86CrjWevskZ10dt
	 CPwtCbH1BlXfDfr1nCeM9GXk83OUHSgxmRLaA86TuRr7s0NevUTTC4SfMspApoUqNj
	 2Bq8k9a+tUVTivUfQqiyVO9j0Bzx/5RNz+dYk3t96b4Fnb5fexWFIEeXgiYZ4/X6vz
	 2jCoIj12+zkWQ==
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
Subject: [PATCH RESEND v2 07/26] md: let procfs own the wait queue of /proc/mdstat
Date: Wed,  4 Nov 2026 20:43:55 +0100
Message-ID: <20261104-work-procfs-drivers-v2-7-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404; i=brauner@kernel.org; h=from:subject:message-id; bh=Nn5OVy8ZnyI1nSFUur3mK5MV0AP1ijE3ArueCKeFRT8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97qpelclm2eRivDzv95ei9M8+3HNPnr9QzG/qmrjCP rmm56dyRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQCXzP8L+Ry03raKlfQfVPu 0IPvj5U0WoW+KZ9MOfz5Lev7yvuRzAx/BR75d/79PlNgAlP5pc8HHJqssrPnl5s3P0u6bivP2cv FBgA=
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

mdstat_poll() sleeps the poller on md_event_waiters and md_exit() has
to wake it in a loop until nobody is left on the queue, because the
queue goes away with the module. procfs owns the queue poll() uses
now, it outlives the module, and a poll of the removed entry reports
EPOLLERR | EPOLLPRI, so md_new_event() wakes the pollers through
proc_poll_notify() and the loop and md_unloading go.

md_exit() removes /proc/mdstat last now. A sysfs store on an inactive
array doesn't hold the module, so it can still reach md_new_event()
while md_exit() runs, until destroy_workqueue() has waited for the last
array to go, and a wake-up through a removed entry is a use after free.
The static queue didn't mind that, the entry does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/md/md.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 64abf1743e41..7560dcf0f5c8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -351,12 +351,12 @@ static bool check_new_feature = true;
  *  start array, stop array, error, add device, remove device,
  *  start build, activate spare
  */
-static DECLARE_WAIT_QUEUE_HEAD(md_event_waiters);
+static struct proc_dir_entry *mdstat_entry;
 static atomic_t md_event_count;
 void md_new_event(void)
 {
 	atomic_inc(&md_event_count);
-	wake_up(&md_event_waiters);
+	proc_poll_notify(mdstat_entry);
 }
 EXPORT_SYMBOL_GPL(md_new_event);
 
@@ -9176,16 +9176,11 @@ static int md_seq_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int md_unloading;
 static __poll_t mdstat_poll(struct file *filp, poll_table *wait)
 {
 	struct seq_file *seq = filp->private_data;
 	__poll_t mask;
 
-	if (md_unloading)
-		return EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
-	poll_wait(filp, &md_event_waiters, wait);
-
 	/* always allow read */
 	mask = EPOLLIN | EPOLLRDNORM;
 
@@ -10765,7 +10760,7 @@ static void md_geninit(void)
 {
 	pr_debug("md: sizeof(mdp_super_t) = %d\n", (int)sizeof(mdp_super_t));
 
-	proc_create("mdstat", S_IRUGO, NULL, &mdstat_proc_ops);
+	mdstat_entry = proc_create("mdstat", S_IRUGO, NULL, &mdstat_proc_ops);
 }
 
 static int __init md_init(void)
@@ -11074,25 +11069,12 @@ void md_autostart_arrays(int part)
 static __exit void md_exit(void)
 {
 	struct mddev *mddev;
-	int delay = 1;
 
 	unregister_blkdev(MD_MAJOR,"md");
 	unregister_blkdev(mdp_major, "mdp");
 	unregister_reboot_notifier(&md_notifier);
 	unregister_sysctl_table(raid_table_header);
 
-	/* We cannot unload the modules while some process is
-	 * waiting for us in select() or poll() - wake them up
-	 */
-	md_unloading = 1;
-	while (waitqueue_active(&md_event_waiters)) {
-		/* not safe to leave yet */
-		wake_up(&md_event_waiters);
-		msleep(delay);
-		delay += delay;
-	}
-	remove_proc_entry("mdstat", NULL);
-
 	spin_lock(&all_mddevs_lock);
 	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
 		if (!mddev_get(mddev))
@@ -11112,6 +11094,11 @@ static __exit void md_exit(void)
 	spin_unlock(&all_mddevs_lock);
 
 	destroy_workqueue(md_misc_wq);
+	/*
+	 * Only now can nothing reach md_new_event() anymore, which wakes the
+	 * pollers of /proc/mdstat through its entry.
+	 */
+	remove_proc_entry("mdstat", NULL);
 	md_bitmap_exit();
 }
 

-- 
2.53.0



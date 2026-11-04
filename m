Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22360E7509
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T+T+2mia;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2uxiHux
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9vYsQ2z6p4kEQ26Jb8WOubzMzQn6P43ATzZz2gRYd8s=; b=T+T+2miaYyKZLf
	kDFkDc7aFtwf5CQyBH41CqV3qS6qwOgy/eLeEcWKok+izCy+6HtFNh6zrOf5A/uDaK8yjcS1MQRQ6
	jE0whV4rHaQUNX5M60F1UVxjkM+G89mdaQATq3TtqDZ9gNWKJDh80fqQ06b/wKWFuWzus9gWSabDF
	MgWlz56vBVB4NfUTnKCHrld/5xaAgn54IosPJqNHy/jkVskUDYqbUL98kemO6DGbtwyoB1qVAUI4l
	IpC8+5Yo835o9s4K+dUfG3olnU6IFp9f7Eb4jveg6g7cvEuzr/NjxJC8dBiAnmKSMF7M4s7ygws+M
	DplInDNWS+WcEVz46tAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh6G-00000006oci-1h6a;
	Wed, 04 Nov 2026 19:56:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh6F-00000006ocT-3FYN;
	Wed, 04 Nov 2026 19:56:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 844B84010A;
	Wed,  4 Nov 2026 19:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8051F000C1;
	Wed,  4 Nov 2026 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822207;
	bh=9vYsQ2z6p4kEQ26Jb8WOubzMzQn6P43ATzZz2gRYd8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e2uxiHuxfEJdhmjLozO9LVNrgHWWCvyZHjL6HCg7amaM22yI9yG0olu1uJ96j73/Z
	 xTQNcQbMhTyIG8P3vbMDLmuT2phtFdMJBnVFMbLXmKKNtZbqq02BRamAUB44uazdL3
	 urCr5eyZbIruy/giy8yhCYSK2FnSUIzF0uuLJu8guQkWA1W37endcFSgwzxgmXgdpv
	 WgWqivOuiipmtpXNrqJUTWyUBgi0SwINwwt/Cqe2dz7mNJDn9EIm/pVofRmhuImUVo
	 H8QqbrQNf9HFXNZ1hUfz4Fw5j+PPHT9mjrfkR6KYflVEzz/AoZKdc8Eb+kMcDaWwM1
	 H1CvOEcsSWIHA==
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
Subject: [PATCH RESEND v2 28/30] mm/swapfile: let procfs own the wait queue of /proc/swaps
Date: Wed,  4 Nov 2026 20:56:33 +0100
Message-ID: <20261104-work-procfs-fs-v2-28-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=brauner@kernel.org; h=from:subject:message-id; bh=VLC7S5nkyALdZiiw9586D7569GKKbKISIa7jUul9ZSQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97vEV3KXoYc6wwNTta5J2SbyikafkWx/po6m7FWtOr PLmcCroKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMhMA4Z/KivFpjxV2sx0std/ mh+/+VeZnyvk60UXbOG53vWE+fLyG4wMk7fu+rgnv6JzYR1H2t24xj6e5tmlRd9mX90acdHdM9y RDwA=
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

swaps_poll() sleeps the poller on a queue of its own. procfs owns the
queue poll() uses now, so leave the poll_wait() to it and wake its
pollers when a swap area comes or goes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 mm/swapfile.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ee4868ecc3a7..1d063a1cef43 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -111,7 +111,7 @@ static struct kmem_cache *swap_table_cachep;
 /* Protects si->swap_file for /proc/swaps usage */
 static DEFINE_MUTEX(swapon_mutex);
 
-static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
+static struct proc_dir_entry *proc_swaps;
 /* Activity counter to indicate that a swapon or swapoff has occurred */
 static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
@@ -3307,7 +3307,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	err = 0;
 	atomic_inc(&proc_poll_event);
-	wake_up_interruptible(&proc_poll_wait);
+	proc_poll_notify(proc_swaps);
 
 out_dput:
 	filp_close(victim, NULL);
@@ -3319,8 +3319,6 @@ static __poll_t swaps_poll(struct file *file, poll_table *wait)
 {
 	struct seq_file *seq = file->private_data;
 
-	poll_wait(file, &proc_poll_wait, wait);
-
 	if (seq->poll_event != atomic_read(&proc_poll_event)) {
 		seq->poll_event = atomic_read(&proc_poll_event);
 		return EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLPRI;
@@ -3428,7 +3426,7 @@ static const struct proc_ops swaps_proc_ops = {
 
 static int __init procswaps_init(void)
 {
-	proc_create("swaps", 0, NULL, &swaps_proc_ops);
+	proc_swaps = proc_create("swaps", 0, NULL, &swaps_proc_ops);
 	return 0;
 }
 __initcall(procswaps_init);
@@ -3907,7 +3905,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
-	wake_up_interruptible(&proc_poll_wait);
+	proc_poll_notify(proc_swaps);
 
 	error = 0;
 	goto out;

-- 
2.53.0



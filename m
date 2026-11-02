Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABDF60804A4
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nAc+U481;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzeuR62X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=u/RXCBD8nlX7BDzbpngWHwWfgPDQj7BVrPXrBF7wCv8=; b=nAc+U481YCjjGT
	yjmD0m6JIZA3wRbqEaZp8oFfHq5m8JRTFh8vK5pPUdfkIknbCqsySxWwxA7dzCtR7rwrGHnKWFBsL
	ca8f+ONTqmzqnb1KN5j1dsTut3DdMnRCoD2lsh68Yo5BK1yBidnqYzL7Ulqznzk/f4cer8ZyUBYw+
	S7+iqQI4tm94fIHy6LQdMWf0HDJP4pPN103Ug8Cd7u3BFe+8meBwLSDwlBvwBzk5sd0EFTckzI6eX
	SCpfwJnh9cUVS47pI374Wkg3habnTFzFZG/zMrHwjfM3L6pLhbr/F9Chs06c0ZDImGY5ZXZHXp509
	XNjE7XdzDVp83F/bXw/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtqp-0000000H3iw-1JEA;
	Mon, 02 Nov 2026 15:21:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtqn-0000000H3hx-2O94;
	Mon, 02 Nov 2026 15:21:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0575160620;
	Mon,  2 Nov 2026 15:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FC41F00A16;
	Mon,  2 Nov 2026 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632892;
	bh=u/RXCBD8nlX7BDzbpngWHwWfgPDQj7BVrPXrBF7wCv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lzeuR62XFqOGUep6G0u/OgAm/OWRPnnvn8erL4ZU4coYsOJSODUSp+a+2jQzM89Na
	 wls04y7KzCTFwf5dsKwoGQq4HsQJB+8Q/tyIUmNqi21phOIu62KpYImTlB0ls6aGae
	 miRfVbxr3JZPL8lWk8CynKdRTAwmaRBTeg+t7O77J1JsURjyW/dH2I6mYOgaUrqxwj
	 7KTrFfx3AkzJndWmhJ/H+my8YK+kelSQ4n+wOAuAD5nl7vHyDdtVgll57DDfY53FmE
	 lZ2Bqq8ccnEcF5eVt6EqwlmszCQGg+ZSpjDAYPYr+Ujd6ANt6wT/4OLvqxEhsJ83lT
	 c5mbm06d3Q7qw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:16 +0100
Subject: [PATCH RFC 06/27] nfsd: let procfs own the seq_file of
 /proc/fs/nfs/exports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Og6i2j2RItYkKcPNuUOPBq0fveLG9Ax2TG7f5E6VSxk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG7kVLY5MLm6OZ2xjUVJp9EoIqQs8Har0dvS4Du/G
 zkXh5h3lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCTOhZFh8mS2HN0Vqp439x5e
 2xeUd91V5e/Pzuqia7+Lj7wzdlPPYWTYZ8Q7MynkzsRjgb7VR/ifa84RfBwlO7dAjOFb++Stxc7
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Declare the seq_operations and let procfs open and free the seq_file.
->proc_open() and ->proc_release() only set up ->private and take and
drop the reference to the network namespace now. Reading the file then
no longer holds up its removal.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nfsd/nfsctl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f8ce3c0fb077..5b2782f9dbbd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1407,16 +1407,23 @@ MODULE_ALIAS_FS("nfsd");
 
 #ifdef CONFIG_PROC_FS
 
+/* procfs opens the seq_file */
 static int exports_proc_open(struct inode *inode, struct file *file)
 {
-	return exports_net_open(current->nsproxy->net_ns, file);
+	exports_net_init(current->nsproxy->net_ns, file->private_data);
+	return 0;
+}
+
+static int exports_proc_release(struct inode *inode, struct file *file)
+{
+	exports_net_put(file->private_data);
+	return 0;
 }
 
 static const struct proc_ops exports_proc_ops = {
+	.proc_seq_ops	= &nfs_exports_op,
 	.proc_open	= exports_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= exports_release,
+	.proc_release	= exports_proc_release,
 };
 
 static int create_proc_exports_entry(void)

-- 
2.53.0



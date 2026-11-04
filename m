Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A76071AE0
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OjyKrHRt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7uflGoo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jcn7jVvcEygiBPhKNySOIoE9F539N91xJ4TgqDQUCP0=; b=OjyKrHRtlI1lhx
	N1yrHDYC1uJ/ZcA0Rej5kC6lNLOaOLx3iXddpFQgUGLTMb/+pIZSWZGAV23a+sckIQ6FixQZBdtGc
	ksXfKZB2/YG3sQEUE9ATEUOQipSpxVWs2UzJfgSkgInvyT4KUVvs902XnXyN4RHulGPWQYcIk09g5
	iINN35+kj0oU1qiggN0Nk9ICuIiJggnRC7uR/2XKCLDWa/kIRCkQlAZenAdhiaQylMe14jpSDWOBd
	kE5J18yX4YHzG2phPQzalj8rJeg9d3lixjpYdRcYzC8Hxqw141CWmwYz/1rhROSv+qCrIZX0msq/x
	Fv5pynJOPD2B31jTKvKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiId-00000006ztC-0zbg;
	Wed, 04 Nov 2026 21:13:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiIc-00000006zsc-1z6x;
	Wed, 04 Nov 2026 21:13:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 783E2601F6;
	Wed,  4 Nov 2026 21:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890731F000C1;
	Wed,  4 Nov 2026 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826817;
	bh=jcn7jVvcEygiBPhKNySOIoE9F539N91xJ4TgqDQUCP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7uflGoo2J6W0Pkam2p2NQ2ygDWILS85YrEGrtDhRX9LSpjax7FTdN9yNxg/1nr/F
	 V+6mFIzh3/JJOAXY6DVlJDG4EpV1IqKbiDMaZqe2+mP/VD4uYvDHSHZdC+YPnvDk4p
	 B+fx/mBspdALJuO5S6++QQQg+yaKZfyhFe96p7DkhDOmjrSDCUkzL7D2l6jIRx9hog
	 t02UJbdl2o8LcfstRp/uZbtHAIBJlVxjfK6tVrDPho366mZ6VCIHILqfMZVkkl7EFn
	 VcPqHyjXoZJ1/HnO4R2TW6BDouO7Vr2s8cHixo92YGxXCqi5rLrqQLQrblFCpmhTUC
	 1HY2L3LLxnrag==
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
Subject: [PATCH RESEND v2 09/13] SUNRPC: drop the ioctl of the procfs channel files
Date: Wed,  4 Nov 2026 22:13:23 +0100
Message-ID: <20261104-work-procfs-net-v2-9-221e2437fed1@kernel.org>
In-Reply-To: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=brauner@kernel.org; h=from:subject:message-id; bh=I+ev37oI2qOnQB50E4hs4C0vKquyHn0mn+uzhhuE9es=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tO7MzO6bl7rnYiJS+98LnRI2rB8SW+2zhcm6VmdL mnzZE2COkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaimsHIsCL/pkeQ2tMV86Sm GCnwci6xzri2a8OqYh1BgwP67+/djmP4Z6MoeGKi/4+z3/fFeyZzP/p6Min5j4995fEbyvr+l0+ ZMwEA
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

do_vfs_ioctl() answers FIONREAD for regular files with i_size - f_pos
before it gets to the file's ->unlocked_ioctl(). The channel files are
regular files, so cache_ioctl_procfs() has never seen FIONREAD and only
ever failed other commands with -EINVAL. Drop it. Other commands fail
with -ENOTTY now.

The rpc_pipefs channel files are regular files as well.

Acked-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/sunrpc/cache.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 81a3f0068f36..d242b6f33cbc 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1596,15 +1596,6 @@ static __poll_t cache_poll_procfs(struct file *filp, poll_table *wait)
 	return cache_poll(filp, wait, cd);
 }
 
-static long cache_ioctl_procfs(struct file *filp,
-			       unsigned int cmd, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct cache_detail *cd = pde_data(inode);
-
-	return cache_ioctl(inode, filp, cmd, arg, cd);
-}
-
 static int cache_open_procfs(struct inode *inode, struct file *filp)
 {
 	struct cache_detail *cd = pde_data(inode);
@@ -1624,7 +1615,6 @@ static const struct proc_ops cache_channel_proc_ops = {
 	.proc_write_buf	= cache_write_procfs,
 	.proc_write_size = CACHE_DOWNCALL_MAX,
 	.proc_poll	= cache_poll_procfs,
-	.proc_ioctl	= cache_ioctl_procfs, /* for FIONREAD */
 	.proc_open	= cache_open_procfs,
 	.proc_release	= cache_release_procfs,
 };

-- 
2.53.0



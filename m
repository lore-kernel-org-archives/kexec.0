Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE1606E2D4
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qaQmZdCp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Va7zsSD/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ffDqq2EmH3dLLxjgj5UCr7XG2Z9kHARzT7WYJIH1M8I=; b=qaQmZdCpBcNAMb
	ogl5G/iIs+o7VPUzSBMO1saDj1AMmHsEBoOJYzMuxvheMYBwTsHj8IoIZshVdAEMqx9UNk4oWrlMk
	SIX6fvn6MQjw0E9yk8pyArXOU3cHUoNGCBElGgKNgS8+tQou5ILFoh+2eTDIZLDwbqXzOP/J4gUcC
	DVtsT0567fvgA5I768ubqQRGiej7U3ZzyTVx9bo9TNTpmdtA03veIK/1zuVnYDmpz2bWd85Gt16gJ
	QBWRyFl+2J7WAtTkAPS4r/qCR0v+s1Ba1eZh8QomdkFcZwN0RxdUxthH+4aQVs7hc7O0yqxYkk93n
	+/LPvezqSAcO0nsC1MFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh8J-00000006pPR-1u4f;
	Wed, 04 Nov 2026 19:58:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh8G-00000006pOY-3tjc;
	Wed, 04 Nov 2026 19:58:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 89CA143C79;
	Wed,  4 Nov 2026 19:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475061F000C1;
	Wed,  4 Nov 2026 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822332;
	bh=ffDqq2EmH3dLLxjgj5UCr7XG2Z9kHARzT7WYJIH1M8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Va7zsSD/2UsqzeDK17UtGbxk8tZ8VFuDtrgV28CQXE3r+pUU3KAQ9HdqwNtJCrgiV
	 ER/DimX74CNEXlu3IVPIXGbqc5CE12lAQ7b50a7KHKJ/AN/yvURbL8BJKzY3tevFtZ
	 4hUGceV6oWXok2hp5oPMRcHlxbZdVLWyfg0KIahRV4dCHE2oE+Til1RUebK1MkIrRI
	 /sZV1JWTnpcc7uIQut/dpI2nvKSohpgIa1uCWZRw2Ljq27C9lceWDK43vqJZV6NQiW
	 fweTl9sYyzuDv6zPxbywF1J1VTwPH00pLECF3z2ro2vkAz/tU/vmL4m25vP2A1j8av
	 it6DkfL/lb1/A==
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
Subject: [PATCH RESEND v2 04/13] netfilter: xt_recent: let procfs own the seq_file
Date: Wed,  4 Nov 2026 20:58:38 +0100
Message-ID: <20261104-work-procfs-net-v2-4-221e2437fed1@kernel.org>
In-Reply-To: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=brauner@kernel.org; h=from:subject:message-id; bh=BFI4awwUWJFzxPnNllIUF4mTxSJuUKU00IOFrC3aQoI=; b=kA0DAAoWkcYbwGV43KIByyZiAGrrjiej6rmB1rbnTFWCev28j3SQbNVWhEo9oG7+1WnoRYXHo Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmrrjicACgkQkcYbwGV43KL/sgEAvxrm KME07jPCmATQhxOPX+CkeymKJwNpyy2JVbz+TS4A/1C5qF1LfL94UG1aRkd9j3hJLBQu75wvUei vrFWvAtMP
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

Declare the seq_operations and the size of the iterator state and let
procfs open and free the seq_file. ->proc_open() only fills in the table
now. Reading /proc/net/xt_recent/<table> then no longer holds up the
removal of the table.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/netfilter/xt_recent.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 55f1f2d89952..a43fff5308da 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -546,11 +546,7 @@ static const struct seq_operations recent_seq_ops = {
 
 static int recent_seq_open(struct inode *inode, struct file *file)
 {
-	struct recent_iter_state *st;
-
-	st = __seq_open_private(file, &recent_seq_ops, sizeof(*st));
-	if (st == NULL)
-		return -ENOMEM;
+	struct recent_iter_state *st = ((struct seq_file *)file->private_data)->private;
 
 	st->table    = pde_data(inode);
 	return 0;
@@ -626,11 +622,10 @@ recent_mt_proc_write(struct file *file, const char __user *input,
 }
 
 static const struct proc_ops recent_mt_proc_ops = {
+	.proc_seq_ops	= &recent_seq_ops,
+	.proc_state_size = sizeof(struct recent_iter_state),
 	.proc_open	= recent_seq_open,
-	.proc_read	= seq_read,
 	.proc_write	= recent_mt_proc_write,
-	.proc_release	= seq_release_private,
-	.proc_lseek	= seq_lseek,
 };
 
 static int __net_init recent_proc_net_init(struct net *net)

-- 
2.53.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778F606D4EE
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n2GUzzpq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG3jfP4l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fxIBhh7BKiMVxtDmu4/U+E0RVHzkWKjhatO8Mz/jm1g=; b=n2GUzzpqITPgb6
	izruQwTbarTUeQQ15PEGNXMnXBXDu1bxeTO+8UAbCV6CQhAP6Jmz9nOccPFD+VlGU9tYPPkQENh8R
	ZqgqVdgsC9ylEnq/E4rkYsul7m7XAXsxLYiM1XOCWik43rkdkWQuiUTWZ17Laar8pT1p+98PWTAnc
	zJqlnwQmEpBhtEv0r7N7OOGPDO4AnS0tIDJ7yr4UmBbwdH0j2OeyawzJN+rnKACTAPmzOTfYdkLnv
	9L9oYgtTEALlGWUdtpAJKoIT1r2dQBWVFVlVchX5Qn+IsS1c7CEk75AeCxdn0zDAYRIq8uF9Qm7D6
	Vm6U9/3AzgZaT1StWjUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh8l-00000006pb7-3bR5;
	Wed, 04 Nov 2026 19:59:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh8k-00000006paL-1NDq;
	Wed, 04 Nov 2026 19:59:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 979586154C;
	Wed,  4 Nov 2026 19:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF811F000C1;
	Wed,  4 Nov 2026 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822361;
	bh=fxIBhh7BKiMVxtDmu4/U+E0RVHzkWKjhatO8Mz/jm1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cG3jfP4ltLZ0emEodeqGyV0F81UQdOK9veUjoQYm4vphxyhicVcIAruAa+hQZp+vv
	 LuOy8c/zGjrkusiVcA2VvKJPewsxQtOI7YmD/bcmyRhjnxtsLluEEVPgV3DQNWk47/
	 mSdpjmiWy5tp6Q3PNAMQqcpNrwMMBVMexQqgPaJs3Iy/UBHTYwpQM+Lc5KFKqelFF1
	 ody93CB96hEImqNd69y/UCjV7GfX81amWcZ+7LnqODBl023Evc/9fAIcSNlwwSooaK
	 2T20X1BwYkngzdsHGxYvyb9SWZRkV/ciSqqkihKqF4dLUBJm1YcXlGUFPGXCxWvkvY
	 4eJobVyd6CS9A==
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
Subject: [PATCH RESEND v2 06/13] SUNRPC: let procfs own the seq_file of the cache content file
Date: Wed,  4 Nov 2026 20:59:07 +0100
Message-ID: <20261104-work-procfs-net-v2-6-221e2437fed1@kernel.org>
In-Reply-To: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=brauner@kernel.org; h=from:subject:message-id; bh=psvvZ7JIZLE0CRNp8kUfwlc9JvUIb4uUwK5YCFxYJEI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tM6n7F9Us5PDZO+pQGKZ6Zs1PCcwb/5cVO9pcRsm 2mK1t//dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkZiUjw8UVnRyhZ297By25 0hTRu+CuzNW6RbKizFpOAUYq+3ujLRkZjva/ZpdLVCpwYrJbpltzfc1blUefGwUv7OU14v60a1o EOwA=
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

Declare the seq_operations and let procfs open and free the seq_file of
/proc/net/rpc/<cache>/content. ->proc_open() and ->proc_release() only
take and drop the module reference and set up ->private now. The
rpc_pipefs file is unchanged. Reading the procfs file then no longer
holds up its removal when the network namespace goes away.

Acked-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/sunrpc/cache.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 1ceaea7e01b9..007521e8a57f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1606,24 +1606,28 @@ static const struct proc_ops cache_channel_proc_ops = {
 	.proc_release	= cache_release_procfs,
 };
 
+/* procfs opens the seq_file */
 static int content_open_procfs(struct inode *inode, struct file *filp)
 {
 	struct cache_detail *cd = pde_data(inode);
 
-	return content_open(inode, filp, cd);
+	if (!cd || !try_module_get(cd->owner))
+		return -EACCES;
+	((struct seq_file *)filp->private_data)->private = cd;
+	return 0;
 }
 
 static int content_release_procfs(struct inode *inode, struct file *filp)
 {
 	struct cache_detail *cd = pde_data(inode);
 
-	return content_release(inode, filp, cd);
+	module_put(cd->owner);
+	return 0;
 }
 
 static const struct proc_ops content_proc_ops = {
+	.proc_seq_ops	= &cache_content_op,
 	.proc_open	= content_open_procfs,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
 	.proc_release	= content_release_procfs,
 };
 

-- 
2.53.0



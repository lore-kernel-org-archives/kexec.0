Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF9609FD86
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xwde6+3b;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzlZDjTa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mGdLlGj/NJAJr68kXbSPslaJvhomImSQvB5hgldkHFg=; b=xwde6+3bDshKqj
	SDJRVwWq6w2Rubs7UpGSSI2y3bphmRtWKPBSDCuAUF6bXP/2xHtbVCzE73PeHTPS4TB2bs94t81lR
	ttomVVqZaau0YYpq/5MncWiEWX3qohe8mQEMCRn+kUiaH6T3y2y19uU2wg2HUBy43TGMfD6vRFmYs
	slAJYc94FE8J5adX3y34qxxjI/EzbWuPLR9WoNsXDAKDJF0R9oyQEylPBYn0kVg7kQgOppwf6Srv2
	TEFPtyR2zCx4lBdqqJPs2LUE4p81Fj2gFEcY9+K55BJc1DoYFMyBDdfYkePxHb1VDV4S/9zFjZacs
	6bVGbDqvNMv40YaS43RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtcz-0000000GzB6-3bPk;
	Mon, 02 Nov 2026 15:07:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtcy-0000000GzAi-4AiM;
	Mon, 02 Nov 2026 15:07:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FF48605C9;
	Mon,  2 Nov 2026 15:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26C51F00A16;
	Mon,  2 Nov 2026 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632036;
	bh=mGdLlGj/NJAJr68kXbSPslaJvhomImSQvB5hgldkHFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IzlZDjTao7VjuIjRRsnw52RX/0AjF/WBmgT4NSpXmtjt4TJbN8zegt24j5DOlUa3Z
	 44pMabJRvDCRlnweMnKPhfJPYcWc+E6OtpWq1y0Ac43VD4FbMRQP9qey5otxK1q5PL
	 oT9zsk1HsUa3Ue3zXl6S6BVtFghJKXFiWTJwHmxl0PE/8ztq9iyqz6BcdrpCZDdpYi
	 3XtzkYqJlHCU6ToIaLkgAjRlsjmuFBtw97UNIAceQYdi00vVfKPn4AuQDU9qRHk19M
	 URA4zqhN0uKI8rAUpyUb++ZQsVmLXvF7KAChG6Fit1JA/MDvvneOl/7dLgJJZyJ32o
	 yDuj9+i1oCVEA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:43 +0100
Subject: [PATCH RFC 16/22] xtensa: simdisk: let procfs copy out reads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-arch-v1-16-c9492ab08480@kernel.org>
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

Implement ->proc_read_buf() so procfs copies what is read to userspace
after it unpinned the entry.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/platforms/iss/simdisk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index b2f9e7f3ade3..b597d8642e8a 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -234,7 +234,7 @@ static int simdisk_detach(struct simdisk *dev)
 	return err;
 }
 
-static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
+static ssize_t proc_read_simdisk(struct file *file, char *buf,
 			size_t size, loff_t *ppos)
 {
 	struct simdisk *dev = pde_data(file_inode(file));
@@ -250,7 +250,7 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 	len = scnprintf(temp, PAGE_SIZE + 2, "%s\n", dev->filename ?: "");
 	spin_unlock(&dev->lock);
 
-	len = simple_read_from_buffer(buf, size, ppos, temp, len);
+	len = memory_read_from_buffer(buf, size, ppos, temp, len);
 	kfree(temp);
 	return len;
 }
@@ -280,7 +280,7 @@ static ssize_t proc_write_simdisk(struct file *file, char *buf,
 }
 
 static const struct proc_ops simdisk_proc_ops = {
-	.proc_read	= proc_read_simdisk,
+	.proc_read_buf	= proc_read_simdisk,
 	.proc_write_buf	= proc_write_simdisk,
 	.proc_write_size = PAGE_SIZE,
 	.proc_lseek	= default_llseek,

-- 
2.53.0



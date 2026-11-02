Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34C6074658
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cobQD5+1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkL6dVH3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=t7CXhIggcklIY3xO5IiO5lA9eZblBCQpzIpV4iqWwIs=; b=cobQD5+1BsqKRI
	Xee5a/a1K5RwaUwi9uB+KOnNA4f5Ysn2x3idgVLC0hX8JE2PrJQm7AQCVODCMDw+DRvKr73rHa/yw
	RlMzZpqDj9El9kA+/dWUY2qNuKDAyP3k4+w2LXBUAakrBTO9nBUV3upuVoM7ZN5yN6JojdpGOBbaF
	D/3wgD4eDPSJ9DmGnrjEQ41qW9RUMfHEsnu/77rAKEdh0yd4mYmq+PLrV5X0zfrUqkv7XZRorNeAP
	8jvFnmJvHHVbFm4UtMrl4gsM0rXtAH3BN325P6npxgBeyHiQZpJubC+K9iCaGWlELXq0sFduRSy8s
	5GBi7i8MEZpW/JmkjGqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtOk-0000000Gun2-0Kn2;
	Mon, 02 Nov 2026 14:52:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtOj-0000000GumQ-0XjM;
	Mon, 02 Nov 2026 14:52:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 90F5A60200;
	Mon,  2 Nov 2026 14:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943F01F00A18;
	Mon,  2 Nov 2026 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631152;
	bh=t7CXhIggcklIY3xO5IiO5lA9eZblBCQpzIpV4iqWwIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gkL6dVH3qeZTZTEUa5gJkjb3DNPVL8n5WP7/jOyBtnyh2kByZfYEWHf2I4V1dxI/p
	 MRJ7Cw4L3gZu5jux1vQS4dO9q+KH6eZstOXSKpu3hAjg1a2jYzTILzigEgrHxnw7a+
	 i+t8SHRQhy99x5vtc69Wd2RooVfSrGTh0BlmU//CeRIHSUWS8Rx6aYeOu7JZwe1YT/
	 PvpClFllL3x0bHydSz1hKBiSwFXahsk/lqsUAX5OXvNypfMaPi/I/xtwDZZXht4OD1
	 TjstHlA2Hp9ENKs7XrHGkLPp/n8NK6zuyN2Fg1CTZaD1iWdK7fJJWkqOfluwSEGTxl
	 kopkZdZ+WBiqA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:48:49 +0100
Subject: [PATCH RFC 09/16] seq_file: add seq_preallocate()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-core-v1-9-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
In-Reply-To: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
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

single_open_size() allocates the buffer itself because it does the
single_open() too. A file whose seq_file is opened by somebody else,
like procfs does now, needs to do that after the fact. Add
seq_preallocate() for that and use it in single_open_size().

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/seq_file.c            | 36 ++++++++++++++++++++++++++++--------
 include/linux/seq_file.h |  1 +
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 456c78719fd0..a4644cdda7e6 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -590,21 +590,41 @@ int single_open(struct file *file, int (*show)(struct seq_file *, void *),
 }
 EXPORT_SYMBOL(single_open);
 
-int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
-		void *data, size_t size)
+/**
+ *	seq_preallocate -	start out with a buffer of @size
+ *	@m: the seq_file, before it is first read
+ *	@size: the size of the buffer
+ *
+ *	For files whose records don't fit into a page, so that the first read
+ *	doesn't have to work its way up to the right buffer size.
+ */
+int seq_preallocate(struct seq_file *m, size_t size)
 {
 	char *buf = seq_buf_alloc(size);
-	int ret;
+
 	if (!buf)
 		return -ENOMEM;
+	kvfree(m->buf);
+	m->buf = buf;
+	m->size = size;
+	return 0;
+}
+EXPORT_SYMBOL(seq_preallocate);
+
+int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
+		void *data, size_t size)
+{
+	int ret;
+
 	ret = single_open(file, show, data);
-	if (ret) {
-		kvfree(buf);
+	if (ret)
 		return ret;
+	ret = seq_preallocate(file->private_data, size);
+	if (ret) {
+		single_release(file_inode(file), file);
+		file->private_data = NULL;
 	}
-	((struct seq_file *)file->private_data)->buf = buf;
-	((struct seq_file *)file->private_data)->size = size;
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(single_open_size);
 
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b813b7e63d89..834daff48b7d 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -175,6 +175,7 @@ int seq_path_root(struct seq_file *m, const struct path *path,
 void *single_start(struct seq_file *, loff_t *);
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_open_size(struct file *, int (*)(struct seq_file *, void *), void *, size_t);
+int seq_preallocate(struct seq_file *m, size_t size);
 int single_release(struct inode *, struct file *);
 void *__seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_open_private(struct file *, const struct seq_operations *, int);

-- 
2.53.0



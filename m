Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547946078C67
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QtRqEll5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTuaWM9d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=t7CXhIggcklIY3xO5IiO5lA9eZblBCQpzIpV4iqWwIs=; b=QtRqEll5zILdAo
	pN+vl2nGIPpOAityDdP3Fkh2dKhYhP7Tk1fW8EV3Pz1nbjq+k5BgBqHCNoz/pVhllSfJOhHlRTPO2
	u02b4/UmYmoA57ksr7NG7AcAr6o/gV+hz+iwvAw6Cf5B6n0bBIRWZ2vWRaZC3+SDi9hb5pwKVEIxl
	g29i4IW+HHBbbZvreQ+JnMzTBHsXpMidVhpVMQqflANLNBAxAKa+FMzUMUcUPzvs4hBZNaHQWAXpv
	NKalJAGhdC9m487QHrI9Bq+lo8NUFh/ontypqn406dgJFRRUReZbsQyLDOn323+bOUHjX5OlRtVvf
	J+gv1bABX6K+wKo5Agcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgii-00000006efg-3jda;
	Wed, 04 Nov 2026 19:32:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgif-00000006eeD-0Snm;
	Wed, 04 Nov 2026 19:32:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C89E60D9F;
	Wed,  4 Nov 2026 19:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89F31F00919;
	Wed,  4 Nov 2026 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820744;
	bh=t7CXhIggcklIY3xO5IiO5lA9eZblBCQpzIpV4iqWwIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTuaWM9d7bmS3BQXsgtTAPR9uVh6iO0s1VUb1qW5xthyjwQ7vxJulOEZ629mv/ktX
	 8pc572eXrayXIbCxFRUJIEYHlf9ycJZjdr5EilMv+/yNyQNPgE7IbTr67SmbjqGKon
	 wQxWa1oDi8Z96DmUhmEkZsLKgf7TxOqe0u+yeHEa9M+VTfdbUwRpShdZhtLt7n6wLd
	 xG8ZPgiEEG146zAmYMMPTfNZP+A5FSPLxTvy8HupirTDlyG6AokYQO4fF7KBnvln4/
	 BccNNTsARBWlIFPDpemmx+BLFNPVItSM8w4MnywAOEfXW90hS1vRbBdoScA6JM7MiN
	 65ED+/q2glmuQ==
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
Subject: [PATCH RESEND v2 12/23] seq_file: add seq_preallocate()
Date: Wed,  4 Nov 2026 20:32:10 +0100
Message-ID: <20261104-work-procfs-core-v2-12-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; i=brauner@kernel.org; h=from:subject:message-id; bh=cArC7PPeLGnNNo4k1qcZwNiSGSA+jlDCNRnIKXcvzj8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bq9fUy53Y+meKbNe5Zf78F+aKHlY58q16usqyqJv3 +V2rX5U0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR+1yG/3HL357Tm/j6pbNY 7t1vOYdrHYtOvFVkdFthFzlPc30mlyDDP53w+qwZtmFzcn4YvJ2TMYtvgYrB74l+jyOkXn9YOXn VaS4A
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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



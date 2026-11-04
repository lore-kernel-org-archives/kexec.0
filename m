Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1446606C930
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CdKcpWal;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7j0ZanL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DA4U0m1CHtqk19BjQpd8o6fqolui3N68b+LzMS0kHTM=; b=CdKcpWalbu3LIO
	Nvq8l/SbqQMJ4EacuyFh9oCq0T3Nf1YnDqGCmyO54bc0lHjfYC6pcJlpzdYSN2pOu2WKQDv1ZnfxS
	llqXQe+X7rhF6wu8e8L9fc7wvTCfjWDcRAgYcg6+jh3/tSIwFFz/OBtFL59A6p5jNpIbdVrvWkMt1
	EgKZcDq2yQbGrg0+Fkhu3XStUuh8ebb+/Fxnrr5ff9Qu7Rn5K7oOcCvv1Amo91n3BBOSnYMrVOJpF
	9yKVIcFc/xkRSJgoN9IhK0EFGUd9RWudwAA6jhmOt9NzHPK23hBAUBOWhz8sYMirR0BTglEL3Anh1
	IO8pgQgizHKsaPl0fhbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgjq-00000006fCn-2Ky5;
	Wed, 04 Nov 2026 19:33:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgjo-00000006fCP-26l9;
	Wed, 04 Nov 2026 19:33:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 43AD840842;
	Wed,  4 Nov 2026 19:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469811F000C1;
	Wed,  4 Nov 2026 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820816;
	bh=DA4U0m1CHtqk19BjQpd8o6fqolui3N68b+LzMS0kHTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7j0ZanLPklc+rmEtTC9tqa+2dSI7D6dXyu+DrqtYaDUdnd/LUj9Nl96xu78fe9Bo
	 ONceYKUXd7LLhykczcAo+XYQQdU9VnrXajvQp3bn0Dx2obQg2y/zyeUEJ6MGrrd+wb
	 VFFMAfxyna6jHA221MxfRrjIXNI6FL+oxmibL6KxIcoNWzorQNT0Y26Aft3Ya4mbr3
	 nEmiL8AySa8xnCAjT+Cv2punHBoTSIUYIamvaW3tloiPYrIvszTdT7r1QGguINjG6f
	 bcI8iyL36J/mqPEgKJA4dznZGpZUrnKnHaFZ18d22HlBAx+3YRJXUlVnXMqpcyi0q5
	 yU4xE/E1WQohQ==
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
Subject: [PATCH RESEND v2 17/23] fs/proc/vmcore: let procfs copy out reads
Date: Wed,  4 Nov 2026 20:33:22 +0100
Message-ID: <20261104-work-procfs-core-v2-17-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=brauner@kernel.org; h=from:subject:message-id; bh=4DsZPmVa7FbNwblf9/47/FvU9tv8FcehxAI70fSkduE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bm8tNg9c6qctsMOowaPB8dhVZm5nNklTraOzXbl+K qxoZzXqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAjbPYZ/pqcffG5u2ZjJWLlK bcnXA3+MpivM3Mhaxf3f+9SDHRe4pjIy3HaafDysJch9dWB2tJTnbNlTQdMUvf8XW3KJ126efym NFwA=
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

Implement ->proc_read_buf() so procfs copies what is read to userspace
after it unpinned the entry. __read_vmcore() fills procfs' buffer
through a kvec iov_iter. So a read goes through that buffer now instead
of straight from the old memory into the reader's, which is what
splice() did already. mmap() isn't affected. On ppc64 a machine check
while reading the old memory used to be recovered through the exception
table of copy_to_user(), by accident. copy_oldmem_page() copies with
_copy_mc_to_iter() now, so a read through procfs' buffer recovers from
it as well.

The buffer is 128k, which keeps the entry pinned for one such piece at
a time, and /proc/vmcore asks for PROC_ENTRY_FULL_READS so that a
larger read is filled in pieces. kexec-tools treats a short read of it
as fatal. A read that faults on its buffer in a later piece returns the
pieces before it now instead of failing with -EFAULT. fadump removes
/proc/vmcore when its memory is released and that no longer waits for a
reader that faults on its buffer.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/vmcore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index ccb795b85509..1c1e71231f4e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/sizes.h>
 #include <linux/uio.h>
 #include <linux/cc_platform.h>
 #include <asm/io.h>
@@ -427,9 +428,14 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 	return acc;
 }
 
-static ssize_t read_vmcore(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t read_vmcore(struct file *file, char *buf, size_t count,
+			   loff_t *ppos)
 {
-	return __read_vmcore(iter, &iocb->ki_pos);
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
+	return __read_vmcore(&iter, ppos);
 }
 
 /**
@@ -709,9 +715,11 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 #endif
 
 static const struct proc_ops vmcore_proc_ops = {
+	.proc_flags	= PROC_ENTRY_FULL_READS,
 	.proc_open	= open_vmcore,
 	.proc_release	= release_vmcore,
-	.proc_read_iter	= read_vmcore,
+	.proc_read_buf	= read_vmcore,
+	.proc_read_size	= SZ_128K,
 	.proc_lseek	= default_llseek,
 	.proc_mmap	= mmap_vmcore,
 };

-- 
2.53.0



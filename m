Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ABD60A3401
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FK3t565k;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5QLB5cP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TEHVy98izX4fxXB98UXZRCAsXp7Vv98/GN00gGR5FH0=; b=FK3t565kpQWaJZ
	YM32ygMvuzVsaAFSea81Sr2qORkwlC3pTe7H7LP1q4HccxBi+3/Xpig+MYBjtYmB+pTfA7OrLKUkz
	vH8V87QGhTN8wUgZwkLTduoqMUcMYGLGEiYLyrdXNHyUmrQdkd25PRShCbE5LAAOxFybePUCtmtI5
	lnFyEjC2Ga34TpmgSquUCvNakTp0rekO/nfBbLQlm1k2rCQqbSeokuACAGemV4iKl7LLd8fNGzHfr
	G3QiDsacMretVZwucDt55ip1/vy+8L/XPVFSohGDNnGfQc1V/daXMX1vQcOOMYccUkxDzn+ltiWQK
	Aw+h2EEFYhaER1R5Dl0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgj9-00000006evZ-0Dd9;
	Wed, 04 Nov 2026 19:32:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgj7-00000006ev3-24s3;
	Wed, 04 Nov 2026 19:32:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EA56A60DC5;
	Wed,  4 Nov 2026 19:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC9D1F00919;
	Wed,  4 Nov 2026 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820772;
	bh=TEHVy98izX4fxXB98UXZRCAsXp7Vv98/GN00gGR5FH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5QLB5cPRnqisNuC7Gqo3F5XkxxQOdtVGXAFMUWMhX2Z7BYWw49ADkpvPU7MqNxI+
	 j48ixtJJYVGr31znu8c/7Be9nnUewJ72aON0xf/R4isMFiSrAYisnnndH+E4ED8VQQ
	 XcfgL+2d4gDdQBsrsE6enNmVb2q9GlukpVqvYJqVvErrOeF7xxKhbqDxo8qTklwVA5
	 Y30cOxhhLbdaCZP3DnUVtJZjx6p43P/fTZQgcWsWTuUtDrOyubqKAr0fQ8lDQzcJg3
	 4R05YEMlvwuvN8sRYtajj3sC3E3jrB8F1lxhZNUzV+Nt7eI5ePNgQkrGR4Ab/7mBVU
	 5ngUzPN2tzJhg==
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
Subject: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before pinning the entry
Date: Wed,  4 Nov 2026 20:32:38 +0100
Message-ID: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6007; i=brauner@kernel.org; h=from:subject:message-id; bh=XY7ojw2MJH5q6cdYnSISI9dPPhcEOijXA7taVvYOt3o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bm/kTxWWFrr4tjFsg/6s4/3d3zQzvzzb8u92uexKQ aWHfpMOd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk+06GP1wi7B7/1rWYZy25 JqbSIlC9+W/y8g03z9R8S54pVjXRwpiRYZGPccC8jU98amU92Ti0XJqD2prb62ev/Sv9RV1n1mc JZgA=
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

proc_reg_write() pins the entry and calls ->proc_write() which copies
from userspace itself. A page fault in that copy can take as long as
the writer wants, just like the copy to userspace of a read, and
remove_proc_entry() waits for it.

So do what kernfs does for writes as well. An entry that implements
->proc_write_buf() gets a NUL-terminated kernel copy of what was
written. procfs makes that copy before it pins the entry. The copy is
capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
proc_simple_write() if the entry doesn't care. Larger writes fail with
-EINVAL. The proc_ops go away with the entry, so procfs remembers the
limit in the entry when it is registered, like the size of the seq_file
state, instead of pinning the entry just to look up a number.

Entries that take binary data in pieces, like the PCI config space,
ALSA's data entries or a firmware image, can ask for
PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
->proc_write_size bytes and the write comes up short.

->proc_write_buf() gets the position like ->proc_write() so entries
that write at an offset keep working.

Note that procfs copies in the whole write before the entry looks at any
of it. So a write that is too large or whose buffer can't be read fails
before the entry's own checks run, permission checks included, even
where the entry only ever looked at the first few bytes.

An entry that implements ->proc_write_buf() and still has a
->proc_write() fails to register.

No users yet.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c       |  8 ++++++++
 fs/proc/inode.c         | 33 +++++++++++++++++++++++++++++++++
 fs/proc/internal.h      | 11 +++++++++++
 include/linux/proc_fs.h | 17 +++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 959bf9e33245..4f1f83e9f288 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -466,6 +466,14 @@ static int pde_set_flags(struct proc_dir_entry *pde)
 		if (proc_ops->proc_lseek)
 			pde->flags |= PROC_ENTRY_proc_lseek;
 	}
+	if (proc_ops->proc_write_buf) {
+		if (WARN_ON_ONCE(proc_ops->proc_write))
+			return -EINVAL;
+		pde->flags |= PROC_ENTRY_proc_write_buf;
+		pde->write_size = proc_ops->proc_write_size ?: PAGE_SIZE - 1;
+		if (proc_ops->proc_flags & PROC_ENTRY_SHORT_WRITES)
+			pde->flags |= PROC_ENTRY_SHORT_WRITES;
+	}
 	return 0;
 }
 
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index d51ab7548b11..df1caa0f238d 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -417,11 +417,44 @@ static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const ch
 	return -EIO;
 }
 
+/*
+ * procfs copies in what is written before it pins the entry. A writer that
+ * faults on its buffer then doesn't hold up remove_proc_entry().
+ */
+static ssize_t pde_write_buf(struct proc_dir_entry *pde, struct file *file,
+			     const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf __free(kvfree) = NULL;
+	size_t size;
+	ssize_t rv;
+
+	size = pde->write_size;
+	if (count > size) {
+		if (!pde_has_short_writes(pde))
+			return -EINVAL;
+		count = size;
+	}
+	buf = kvmalloc(count + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+	buf[count] = '\0';
+
+	if (!pde_pin(pde))
+		return -EIO;
+	rv = pde->proc_ops->proc_write_buf(file, buf, count, ppos);
+	pde_unpin(pde);
+	return rv;
+}
+
 static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	ssize_t rv;
 
+	if (pde_has_proc_write_buf(pde))
+		return pde_write_buf(pde, file, buf, count, ppos);
 	if (!pde_pin(pde))
 		return -EIO;
 	rv = pde_write(pde, file, buf, count, ppos);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 674e6b4ed21e..da246c5ed4bf 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -51,6 +51,7 @@ struct proc_dir_entry {
 	proc_write_t write;
 	void *data;
 	unsigned int state_size;
+	unsigned int write_size;
 	unsigned int low_ino;
 	nlink_t nlink;
 	kuid_t uid;
@@ -109,6 +110,16 @@ static inline bool pde_has_proc_show(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_proc_show;
 }
 
+static inline bool pde_has_proc_write_buf(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_write_buf;
+}
+
+static inline bool pde_has_short_writes(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_SHORT_WRITES;
+}
+
 /* procfs owns the seq_file, see pde_seq_start() */
 static inline bool pde_is_seq_file(const struct proc_dir_entry *pde)
 {
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea55ed85a2d6..c81c93325044 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -31,6 +31,13 @@ enum {
 	PROC_ENTRY_proc_show		= 1U << 5,
 
 	PROC_ENTRY_FORCE_LOOKUP		= 1U << 7,
+	PROC_ENTRY_proc_write_buf	= 1U << 8,
+
+	/*
+	 * Writes larger than ->proc_write_size come up short instead of
+	 * failing with -EINVAL.
+	 */
+	PROC_ENTRY_SHORT_WRITES		= 1U << 9,
 };
 
 struct proc_ops {
@@ -67,6 +74,16 @@ struct proc_ops {
 	const struct seq_operations *proc_seq_ops;
 	int	(*proc_show)(struct seq_file *, void *);
 	unsigned int proc_state_size;
+	/*
+	 * procfs copies what is written into a kernel buffer and calls
+	 * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
+	 * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
+	 * writes fail with -EINVAL unless the entry asks for
+	 * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
+	 * for ->write().
+	 */
+	ssize_t	(*proc_write_buf)(struct file *, char *, size_t, loff_t *);
+	unsigned int proc_write_size;
 } __randomize_layout;
 
 /* definitions for hide_pid field */

-- 
2.53.0



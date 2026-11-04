Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB9608B1EC
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nEhFkN+6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSlee+0X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9IR2jOxQyurV4Y0UWx6k8fIXiSGUImfiuKIP9CXfPTA=; b=nEhFkN+6qJnKZl
	qwk5RxalQec5J1PdYemF5/fsnAJeBh5krilYZlfrACzr7v3FB7fzuZYYNNvyvHrUI4/HZd2smBQ4g
	5ICkY1jkVd1ADggcZo8+JlmzrUmS/HmlAn3wGr2frnsZqeSqmji1u+n1vubJM6w/5pQjOoIquTEJw
	Nne6IBpG500paOuBrMVrcsxRgKooIKkjnnLj6gGGDd9A1u/JuXEh32rsEq3jvmBJgrYy6KkhWX/jQ
	Eae9J4pj2xNxN37nA3MIdMen+t6W+w0fY0j8ipflWdoxWb0FU1tLavM47FKcO9WcHRb2aaxiwwqst
	KH4WBrnyvwYIRGJVXGvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgvj-00000006k92-32U7;
	Wed, 04 Nov 2026 19:45:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgvi-00000006k8V-2JKj;
	Wed, 04 Nov 2026 19:45:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 01CD460F2F;
	Wed,  4 Nov 2026 19:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE861F000C1;
	Wed,  4 Nov 2026 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821553;
	bh=9IR2jOxQyurV4Y0UWx6k8fIXiSGUImfiuKIP9CXfPTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KSlee+0XDq+bm+ysUh8nPtikOnchu9TkIAW1VCY3OCd0AvNcw44e5Hzp54rCEEeNB
	 L3jWndaPZFN6e+WP3JcpT+3RG0ZhvSz3tOpGSVIOUGFO+0FYAr1NPl7u7cOMMQ0fPJ
	 +knaMWTjbKoGzcmxQNH3DFEm9Ec3Nl5logdXw9qRd0FXTv0BIExvBcdGtMlpPD+P5X
	 hC9PgG8J3C1XX9TXnT/LOUtJaj+Lvw1tPb/+ixseUzpgnUtzTmNqW0vZ9e3rfcGTmn
	 SADjUJW9oNfrCSPr0BRrs6Hxsxw5J/g7bKH0shcxqMZgd6mz8rvFTNgLc1cdCHqadt
	 VP8DK/LvUQzHQ==
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
Subject: [PATCH RESEND v2 14/26] scsi: sg: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:45:39 +0100
Message-ID: <20261104-work-procfs-drivers-v2-14-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2854; i=brauner@kernel.org; h=from:subject:message-id; bh=PgyqcOYZULSLqb7qnigRBp/yeFf2Hrq3aYxTKZd6WWw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97mpZWdQr2n5nhfa9hbuuMma3507NEd2z6qhK4rplW k3LP34/01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRYzMZfrPUzUxT2rba7uSD Anbzi5PuGN7V3NNXoe7+56FVZPzfOCeG36y1zXIX/9lqb7zUZV/JZH9mTlfh9l/TZrc98K+uDN6 7lxEA
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

Implement ->proc_write_buf() for allow_dio and def_reserved_size so
procfs copies in what is written before it pins the entry, and parse
the number from that copy.

kstrtoul_from_user() looked at the first 66 bytes of whatever was
written. Now the whole write is parsed, and anything larger than
PAGE_SIZE - 1 bytes fails with -EINVAL from procfs before the
capability check.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/sg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index fb3ab74e8727..df955896e65f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2288,18 +2288,18 @@ sg_get_dev(int dev)
 #ifdef CONFIG_SCSI_PROC_FS
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
-static ssize_t sg_proc_write_adio(struct file *filp, const char __user *buffer,
+static ssize_t sg_proc_write_adio(struct file *filp, char *buffer,
 			          size_t count, loff_t *off);
 static const struct proc_ops adio_proc_ops = {
 	.proc_show	= sg_proc_seq_show_int,
-	.proc_write	= sg_proc_write_adio,
+	.proc_write_buf	= sg_proc_write_adio,
 };
 
 static ssize_t sg_proc_write_dressz(struct file *filp, 
-		const char __user *buffer, size_t count, loff_t *off);
+		char *buffer, size_t count, loff_t *off);
 static const struct proc_ops dressz_proc_ops = {
 	.proc_show	= sg_proc_seq_show_int,
-	.proc_write	= sg_proc_write_dressz,
+	.proc_write_buf	= sg_proc_write_dressz,
 };
 
 static int sg_proc_seq_show_version(struct seq_file *s, void *v);
@@ -2360,7 +2360,7 @@ static int sg_proc_seq_show_int(struct seq_file *s, void *v)
 }
 
 static ssize_t 
-sg_proc_write_adio(struct file *filp, const char __user *buffer,
+sg_proc_write_adio(struct file *filp, char *buffer,
 		   size_t count, loff_t *off)
 {
 	int err;
@@ -2368,7 +2368,7 @@ sg_proc_write_adio(struct file *filp, const char __user *buffer,
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	err = kstrtoul_from_user(buffer, count, 0, &num);
+	err = kstrtoul(buffer, 0, &num);
 	if (err)
 		return err;
 	sg_allow_dio = num ? 1 : 0;
@@ -2376,7 +2376,7 @@ sg_proc_write_adio(struct file *filp, const char __user *buffer,
 }
 
 static ssize_t 
-sg_proc_write_dressz(struct file *filp, const char __user *buffer,
+sg_proc_write_dressz(struct file *filp, char *buffer,
 		     size_t count, loff_t *off)
 {
 	int err;
@@ -2385,7 +2385,7 @@ sg_proc_write_dressz(struct file *filp, const char __user *buffer,
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
 
-	err = kstrtoul_from_user(buffer, count, 0, &k);
+	err = kstrtoul(buffer, 0, &k);
 	if (err)
 		return err;
 	if (k <= 1048576) {	/* limit "big buff" to 1 MB */

-- 
2.53.0



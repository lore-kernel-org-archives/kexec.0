Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E7606BEE0
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fC5oHaKe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqFhZDQ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PUZ4tW9HsyUaK/ejkkNMI5ANy0GmRkIlRIJ6yNjac0o=; b=fC5oHaKeyGNdsO
	nXXdtdQiAjGc3Il83Nq3yseWJN+p5s675jHoRqsrlpVrJF3Wq8A1rPNNd1fdoqgh57v+tO2gJP5eQ
	6adP4+va/LuGIbiGEYQ6X5S3YdUjfYYr30NtpoQ9keIjWuVx8OKbB12gP3acIlQrHnHJUdatj+PRO
	9NipOdmURcQlsX9UGSlrfuX+ZhmnMaK2lwHKoZ3/aBdyL6BaLdaoZkucbUnrgmbgZxyerJDh2/Ey5
	q/VcpBRJkEoeJdg/KN9lpU4tzLGTQcA0+KB+WawQsjb8a0Pk9OEda/m9PhDVpAJKFALN3HtxwS2WJ
	YXZOe+7w3BfothktdD6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh0W-00000006m2Y-12nB;
	Wed, 04 Nov 2026 19:50:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh0V-00000006m2H-19FE;
	Wed, 04 Nov 2026 19:50:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0987F40E0C;
	Wed,  4 Nov 2026 19:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEC31F00919;
	Wed,  4 Nov 2026 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821850;
	bh=PUZ4tW9HsyUaK/ejkkNMI5ANy0GmRkIlRIJ6yNjac0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iqFhZDQ35GfK/vsXy+ylTu3Eh9YrS9nTSq27+28SnBC9XKvW7PfMWDO9W5Ft0iDiC
	 2su6MPY9k2TxuW2AnVg2vkBoLPH5Ce+Yj7iPgWE1OMfQXuAjt+wKv9ns1AIE6Zh8f2
	 36rTQxsqFfC8trxeiSZnRnFYf6vYHW9H/wwq7q3bPyDytQtzWderj9LRXTMixQp4Qn
	 iDLkoWDCDGU0TpyQelcs1HXFXKLJrD35LCYzeMiq0HAZIegNRaAkkGVKs79qb+wzhh
	 UnoLohKjRfX7+w2z/A62dlh5PLszggZKXcxYK/t9f4zySuslTWVXxeONmWQtVIKX7q
	 3JuDh2CyL543w==
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
Subject: [PATCH RESEND v2 04/30] lockd: let procfs copy out reads of nlm_end_grace
Date: Wed,  4 Nov 2026 20:50:36 +0100
Message-ID: <20261104-work-procfs-fs-v2-4-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305; i=brauner@kernel.org; h=from:subject:message-id; bh=yC83pog7S4Eh2+psAQ8qDYZ/OTNKlefl3tGbza44dqI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tFPEq3Pk861Kea+tknP5Pec7S2X9JWOzJkzvcjg8 eGGlXfdOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS/43hr/CRtGIJZ4n01d4b H1v+y1f677Dj1MpcFgcZT/+6tVNuRDEynBQ9vcEl403OpO9xU4NMHs3nFGp3Oh6vtE0lecu7jQH v+AE=
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
after it unpinned the entry.

Acked-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/lockd/procfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/procfs.c b/fs/lockd/procfs.c
index 852cca8c3588..64195c564cd3 100644
--- a/fs/lockd/procfs.c
+++ b/fs/lockd/procfs.c
@@ -40,7 +40,7 @@ nlm_end_grace_write(struct file *file, char *buf, size_t size, loff_t *pos)
 }
 
 static ssize_t
-nlm_end_grace_read(struct file *file, char __user *buf, size_t size,
+nlm_end_grace_read(struct file *file, char *buf, size_t size,
 		   loff_t *pos)
 {
 	struct lockd_net *ln = net_generic(current->nsproxy->net_ns,
@@ -51,12 +51,12 @@ nlm_end_grace_read(struct file *file, char __user *buf, size_t size,
 	resp[1] = '\n';
 	resp[2] = '\0';
 
-	return simple_read_from_buffer(buf, size, pos, resp, sizeof(resp) - 1);
+	return memory_read_from_buffer(buf, size, pos, resp, sizeof(resp) - 1);
 }
 
 static const struct proc_ops lockd_end_grace_proc_ops = {
 	.proc_write_buf	= nlm_end_grace_write,
-	.proc_read	= nlm_end_grace_read,
+	.proc_read_buf	= nlm_end_grace_read,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0



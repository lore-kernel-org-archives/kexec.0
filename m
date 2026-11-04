Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183D607F972
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FM+h9GvV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLDqIOTw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=K/nPdp0KTrkO/JWfX0DeaffmMq6r1stKUZ+oHzzOxP0=; b=FM+h9GvVUsoQtY
	MEqyf/NVdPedIsNuiTQP/CJQm8FkWhW4ZTaLTnC2kKDYa1pE8OSRO+olcNp7ObDBa4SO8J7j5Mhq2
	LkOvxxNNNF18MNXgMInkt2GdaFuKj0QlBenkGTnVRcGGvnG1TpxCv7NXLuOzTHyXVRDVXsixBUDFU
	QIf8ecUPrrxyXv7W+omYazYXPDAz0njMoHumkS4jlaw/SrzaQ8QPMY46eRzVa+7DJT2Yd7jBzPcOd
	fFrZHLdsOyDeFDnZ+8WY7aX6i3c3NCnVGdp2jUBESscWpL6wLaVY1Xg3P+NEyzOnt9BVt4ykozhip
	SNGa4TfwFftXPR00BsoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgo9-00000006gqW-26ce;
	Wed, 04 Nov 2026 19:38:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgo9-00000006gqE-0CGt;
	Wed, 04 Nov 2026 19:38:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C691C42E5D;
	Wed,  4 Nov 2026 19:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9BF1F00A1B;
	Wed,  4 Nov 2026 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821084;
	bh=K/nPdp0KTrkO/JWfX0DeaffmMq6r1stKUZ+oHzzOxP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oLDqIOTwTl44qDXUKo0I6FzsXq0+ba0WjB4YCiCZU9JLqh15F/mdEZNy1ACYE+I0B
	 qPq4Ssz+iK/J+eJu6nff/NkdfEp6rYdZwfCVKcczyKz5fHXjpvVlG/Qm/dEw9ZL0xG
	 8PXHN37KmNVPmN5T23ck2GcUncr5vJ52nd5OFcXFUE5Goto+9up/68B7m4SIC6mV83
	 dUnBRd6UMVtOXc059f+OnYX0WXgqO/Uzy4tsZ8wr2OaUSvl2vGEki/eN5mj7meJO8a
	 M72qqDynVfbDFqAmqr+C62uIaJhArxnrmC/9rNVTKL6uBLhc9SJ6BYF+yeJf+SxLKs
	 ki60VRKb9D3jg==
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
Subject: [PATCH RESEND v2 09/23] powerpc/procfs: let procfs copy out reads of /proc/powerpc/systemcfg
Date: Wed,  4 Nov 2026 20:37:50 +0100
Message-ID: <20261104-work-procfs-arch-v2-9-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=brauner@kernel.org; h=from:subject:message-id; bh=BKyq5EW+jipwXgvVj6hm7sFkYOn+uIZEAZe7arc6MQo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97vjOI7W5OU2Ecf0JRpsD2T2N0rxx3fUCk8WEDn860 LbzeX1YRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERWv2T4Z/np554211z5HPtN Ea8e5coKrXxtW8d48eZXNxb/m5d+8jD8T260OtJsUDiLw3pdFscpPeXZpb3vZ9Y1ll1xmP9kwnc DJgA=
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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/proc_powerpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_powerpc.c
index d083b4517065..46bc914d74b9 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -24,10 +24,10 @@ static loff_t page_map_seek(struct file *file, loff_t off, int whence)
 	return fixed_size_llseek(file, off, whence, PAGE_SIZE);
 }
 
-static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes,
+static ssize_t page_map_read( struct file *file, char *buf, size_t nbytes,
 			      loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, nbytes, ppos,
+	return memory_read_from_buffer(buf, nbytes, ppos,
 			pde_data(file_inode(file)), PAGE_SIZE);
 }
 
@@ -43,7 +43,7 @@ static int page_map_mmap( struct file *file, struct vm_area_struct *vma )
 
 static const struct proc_ops page_map_proc_ops = {
 	.proc_lseek	= page_map_seek,
-	.proc_read	= page_map_read,
+	.proc_read_buf	= page_map_read,
 	.proc_mmap	= page_map_mmap,
 };
 

-- 
2.53.0



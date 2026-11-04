Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122E607897F
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h7589k5N;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSonnJ4f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LkQzylMBPw/rjuFeKsFyNpbMkN4WRhLixyhJUzJNoRI=; b=h7589k5NUyIdib
	9hZ4TuT4cVsf3B8PIuRqlwNQJjJBMbuV3xic6DFn43QpPduWX4DlgsBTY+e1iJWEYBQjwrLOKZ7oj
	dPt5kOz4b7IRT/E4IMt15l7WfzPpEvvRX83w2/SASi0Xo1BhON4k8nanIVfRXE7ZjPEAadtTCeUnn
	G02WEU59GOoKxAZFzBBhhsCgOQNtJr1MEZa4569g1+H6k1Mt5QcvV11Ynyt8Hb1cAgW9XI6WnbZUh
	uLyF9czLRAN121oAi9AxUoDQxU6tg5IWkB5bGriN27lilGgzFRxbu06G0G5OQ1c+D3gQYAzGk6q+n
	ghPP0+7E4XE6uX8963bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgZd-00000006aBO-2izA;
	Wed, 04 Nov 2026 19:23:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgZc-00000006aB7-32Kh;
	Wed, 04 Nov 2026 19:23:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A854417F8;
	Wed,  4 Nov 2026 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF251F000C1;
	Wed,  4 Nov 2026 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820184;
	bh=LkQzylMBPw/rjuFeKsFyNpbMkN4WRhLixyhJUzJNoRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSonnJ4f7yMH1lOXY4xKOkMixSuWwienI9M9D7I6GKt/5EQqTgA/iQ2QAehjV234u
	 YFAT2O6XmzTeX9l9nI78c+OuI+vrlyGDMu28/cFZIebS7LVWB5yQYSIHuBROdXKmV/
	 POjWxbi8h52DJlKnFdWShCkvORSC+wER9+m5Nc5I6YVlHAPNaszz5jWURsoc99UxNe
	 HtvfWbnrw5mLr/fLV64EYTb0o/e2FYPIZl4AGyyNRZpEiF3Dc+H3TPm7clGTz3Hei1
	 RJrKLHUu/lKQlBjZQXWIB8Dd4bHzwpk5JakS/D+nuaTqJL6rz4xnryqSZJ8XfbWmNB
	 KVSx5DWPRFPdg==
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
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2 28/51] ntfs3: don't warn when a huge label is written
Date: Wed,  4 Nov 2026 20:22:49 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-28-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org; h=from:subject:message-id; bh=CQmQXvWqu+qpRxwX3Ai9kAzqqtrenD8xJsc3ckb17sQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bnz7K1goQOfBzlUZyTmXuaJF8js/Rb7//OzHk6rr7 JYtL5/6d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEvIKRYcP67G2i6Wf/B2W2 7txs3neapZ43c+rjv8+u3w5s27n+2X+Gv2LPNsjtr59gXDV90xsjczOOh182+JoIeRm6VIqkhV3 i5wQA
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

ntfs3_label_write() allocates as many bytes as are written with plain
kmalloc(). A write that is larger than what kmalloc() can hand out then
trips the page allocator's warning, which panics a panic_on_warn kernel.
Use memdup_user(), which fails such an allocation quietly with -ENOMEM
like before.

Fixes: 7832e123490a ("fs/ntfs3: Add support /proc/fs/ntfs3/<dev>/volinfo and /proc/fs/ntfs3/<dev>/label")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/ntfs3/super.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 29aabdc8a801..37e27b73b7a5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -576,15 +576,10 @@ static ssize_t ntfs3_label_write(struct file *file, const char __user *buffer,
 	if (sb_rdonly(sb))
 		return -EROFS;
 
-	label = kmalloc(count, GFP_NOFS);
+	label = memdup_user(buffer, count);
+	if (IS_ERR(label))
+		return PTR_ERR(label);
 
-	if (!label)
-		return -ENOMEM;
-
-	if (copy_from_user(label, buffer, ret)) {
-		ret = -EFAULT;
-		goto out;
-	}
 	while (ret > 0 && label[ret - 1] == '\n')
 		ret -= 1;
 

-- 
2.53.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594760A2602
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BQPYzjqj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr5d/R5Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vVBne5gselOZS7qaEMuXaEvBAuXwNF+VXq/xDlGRpv8=; b=BQPYzjqjg9f8Hy
	TcRqpElVdwRCFXsJ8aP7X8enmynP+Iy11TgtPO52URltEMjegTFDFzF19S+QPnZUJFOteWrnUVMbi
	eauEdCafYo+3A62BqeGFI01Y8uRaLLMLCqYPihsBI2R4kpYtBs9kJ49DqSNT6aC2gIoKbkLlRyM7v
	EVaVrrkKgLe+UHRe/RkHkgO9HtIfx26OYw8/AMShmaoFu9UYGK4zdb9hiene/avF8qhiadddAjo6S
	tNUtUzBz9+vRlZWmDUvk/E5sjwcZ/GgUbTm06PxrW1i1UjLSrBcoBS8kmTYWCv739d3a9NmEL74jg
	BjoBJt9DIjapo83FBbZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtq8-0000000H3QB-10Qt;
	Mon, 02 Nov 2026 15:20:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtq6-0000000H3Oh-2wfD;
	Mon, 02 Nov 2026 15:20:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 26A9060623;
	Mon,  2 Nov 2026 15:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D411F00A16;
	Mon,  2 Nov 2026 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632849;
	bh=vVBne5gselOZS7qaEMuXaEvBAuXwNF+VXq/xDlGRpv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gr5d/R5QulyTLxLD3/MAYMmLMYbT35xK6aId1t52Eow8QSEABCm8rzX4k2Z5I8Uv+
	 UD3L6bdcCyDENgjDUaRYaIjBpv9KifSo7KdKtRyWAroMom4KY5WF+Ln9EUR/OU8bIw
	 cfIbJFU0gkdeaQcslP0HV9lJfr+zxpqlFkl/tfWZ6xjZPkExH482FMNrcXoifnZDpb
	 BBMpFNPyNBOQcsBD+Cr7KjsIhvpuH/wA12Pa4HnVFFk/4VUZAo7SAy5riWBb7UiSlV
	 k2iUhU3k2r67F3NXxANMDiQuT8gkSLpR87qwXkRQSfThiB+qYgkMJbi1jVvEbOj1vw
	 BbGpsyobrAFbw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:14 +0100
Subject: [PATCH RFC 04/27] lockd: let procfs copy out reads of
 nlm_end_grace
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-4-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eZ2kMMEIgx0JCcy46KFAm+0lqPvZbTWW97pZVUITElw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG74O2799hNsR6IfK5pKSQjHJsw/YPHc0p7/jSlHm
 OeZhvliHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ/ImR4eZSzSvCL/kZRC1V
 N2gkpD259yrLxz9novylvNjbUvvXtzEyLO2o59UOLix8XXD14rToR6HSd+5s+1rF8C/DcQqPudp
 iTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
 fs/lockd/procfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/procfs.c b/fs/lockd/procfs.c
index 47949bec7a09..34a7c3705bb6 100644
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
 
-	return simple_read_from_buffer(buf, size, pos, resp, sizeof(resp));
+	return memory_read_from_buffer(buf, size, pos, resp, sizeof(resp));
 }
 
 static const struct proc_ops lockd_end_grace_proc_ops = {
 	.proc_write_buf	= nlm_end_grace_write,
-	.proc_read	= nlm_end_grace_read,
+	.proc_read_buf	= nlm_end_grace_read,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0



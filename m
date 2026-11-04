Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD5606A932
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=itd/7Gof;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5u712B9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Bp2DPgSMAVNPpocNHMMHSMxcgQhQwNKqaFQNAmEUdgU=; b=itd/7GofeRr+l2
	gRQVxCdQBaLA8nmWqIu/GugvP2xM1opFXVdY4FhvoRJsn1xh6TpLiC/X8ug1aZZvQTTadLAZ1uUfu
	LTmtrDnJMq3n7Cdi9gWjSs3W9pNmu/WYLdNXBGZ+Gkt7aopoOquFkP1OsWxLVj/qFNoynV0aa7JRJ
	PeszFwM1Qkz2aiYB5QxBN5/C0/iL12Yqf2KAEhbbvw9sj4yd/VOo/IeguA+nI/t3H4e4d8ugzX2Y9
	mLbn6T4Sdwnb77O2aZkoFM7FkR5DEgg9J+Uy8TxKWFhFPLbvpgmIDRkoUcQIG27S4e3o5P/e1AVyK
	MPqor7g6HluOEGdJ9I/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeoT-00000006Dbo-3XAP;
	Wed, 04 Nov 2026 17:30:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeoT-00000006DbY-0pPi;
	Wed, 04 Nov 2026 17:30:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9DB7E601F0;
	Wed,  4 Nov 2026 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FBE1F000C1;
	Wed,  4 Nov 2026 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813416;
	bh=Bp2DPgSMAVNPpocNHMMHSMxcgQhQwNKqaFQNAmEUdgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g5u712B9uyY/EHBMvMcIJjwX1Q9oNafVwZZdSTe+wWNmne5PBjIRnbjMdNBKEaIP4
	 4sN1akBTM0upEXPMnrPesATu9t0mv+J9tGR4BfcCUQnJpzUcbcj+IvUqAQlpKvEFAP
	 maIQiS285xRthBs8kUjqLULi7ZlP9EZaMs6jvYgyfDdyykDtrKuOIUKXiUE5xq8j0K
	 rnPkE+GVlVCE8ozm0404SgO7RYqyMkzZKzwWo1p+WxGQXY8MTkERhkp4+WNxvZiOYe
	 CguRECqkxpVtUS2A9kODUDoxnBc90vENA1/MJjeZ4tQ9xNPhj1ug3QG1Rnyknyga3s
	 5rdxM+QnpKA9g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:24 +0100
Subject: [PATCH v2 07/51] lockd: don't hand out the terminator of
 nlm_end_grace
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-work-procfs-bugfixes-v2-7-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tKzHzMLxBoW/zY681xcBM67Jqe2y1s4JEAk9OycZ8F8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zma88mPSwzMZES8ZvfsaK7K5NIr2+azZ3b+Xc1Xpm
 7Wz/9nbdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkbT3DP623G/ymh8nr95bL
 Sj1ZqVz5I/v5xTDO2LLF07okt9w1Ws/wP0bKWD8yk0Xj8wP2OJmbXq1N7z9lRV6ZFj3BvzE/x+E
 BNwA=
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

nlm_end_grace_read() answers with "Y\n" or "N\n" from a three byte
buffer and hands out all three bytes, the terminating NUL included.
Leave the NUL out.

Fixes: d68e3c4aa416 ("lockd: add a /proc/fs/lockd/nlm_end_grace file")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/lockd/procfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/procfs.c b/fs/lockd/procfs.c
index a01f08c8c2f3..74f7ab77535a 100644
--- a/fs/lockd/procfs.c
+++ b/fs/lockd/procfs.c
@@ -57,7 +57,7 @@ nlm_end_grace_read(struct file *file, char __user *buf, size_t size,
 	resp[1] = '\n';
 	resp[2] = '\0';
 
-	return simple_read_from_buffer(buf, size, pos, resp, sizeof(resp));
+	return simple_read_from_buffer(buf, size, pos, resp, sizeof(resp) - 1);
 }
 
 static const struct proc_ops lockd_end_grace_proc_ops = {

-- 
2.53.0



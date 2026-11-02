Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441560932AD
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cB5ZGbYi;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkwsCH5N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ymYBzOXC+1qnPq3+H1dG+MOV1EJ0vnAFrYigKbllIFM=; b=cB5ZGbYiAgPhiB
	myMhQhoaXB5rj/U8GIrwuorvVPvm+T0eEKwySFCu0t8HO81X9wq6D9unW7XJuM1OSbpYMpTtxHMqA
	DNL/16JGbo41NfmA0eD1vpG99W/APusromFNILR+cjPRpvm5eLw2/EqIpH7FI0TIYDfkJ1vDy5P17
	NE7zZwBJMSwQKj0s6kaAW8e8qjbvKaa9GzKwPTdPcjs/1IhPMMTpANye277whjL0hKPNK3sEzX3u1
	goF+jllPG9O1kCkmS44iZWcrKgz6zqSCnX3bWlHOPhPdc6/wZBVZXHAv2SXtXCsC37/QktGYWpY6b
	MsjzSuL7ImGplXSpcj6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNthe-0000000H0UN-0iVg;
	Mon, 02 Nov 2026 15:12:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNthd-0000000H0U7-2CZB;
	Mon, 02 Nov 2026 15:12:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 489F743DCB;
	Mon,  2 Nov 2026 15:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7A31F00A1A;
	Mon,  2 Nov 2026 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632325;
	bh=ymYBzOXC+1qnPq3+H1dG+MOV1EJ0vnAFrYigKbllIFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SkwsCH5NX6Vwuc8YrkplsbXUYGZlDfQ9CBIwHzcNKyVojyOkIh1miTD756wE+V94K
	 qbWnPBCFoEsk5Vnl3IISVP4GtRJh7t/+O5UXryDxT4dLTsrhtBDQtWOzMD+XlPQhS1
	 5THCVq9/EcREtyMc1/N5VSwvG3Q1CrUodeGrQPLGHFNfVpmv58FNgX24+XU26JY7OW
	 sUsvQbz2VbjL7MwP3kVNJQ4yIC+/SktiBLhGC+6TRx0O6yviVfRR7mxZOD/Hx4nWfU
	 5GaDkAcE0fW19SSj+Gk/9Y8llQ2bd+zIEgssZ8CrEgkZbej1DhvNKvROVGhxK2nbP0
	 DIw+cl37jf3tQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:13 +0100
Subject: [PATCH RFC 06/23] md: let procfs own the seq_file of /proc/mdstat
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-drivers-v1-6-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
In-Reply-To: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org;
 h=from:subject:message-id; bh=98AwGD4IED7vI5/KgxxfmkGNQYsM7jyTpJ1BeJQdwqI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG5wa9eb9mvKGcqFdjwLmF1n7FyoUu4/zTbeKoP9V
 5jBq1ePOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyaQLD//zX1pfyeqN/TEhI
 Ob3+1Rm/J2p79l/hyunq2m7Kda/Ix4uRoXfzjTPHbDmCeqqTG/in+s5mk9vmK2YguPrLjge1T+z
 2swMA
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

Declare the seq_operations and let procfs open and free the seq_file.
->proc_open() only records the event count for ->proc_poll() now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/md/md.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..e642b763ebc2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9141,18 +9141,13 @@ static const struct seq_operations md_seq_ops = {
 	.show   = md_seq_show,
 };
 
+/* procfs opens the seq_file */
 static int md_seq_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	int error;
-
-	error = seq_open(file, &md_seq_ops);
-	if (error)
-		return error;
+	struct seq_file *seq = file->private_data;
 
-	seq = file->private_data;
 	seq->poll_event = atomic_read(&md_event_count);
-	return error;
+	return 0;
 }
 
 static int md_unloading;
@@ -9174,10 +9169,8 @@ static __poll_t mdstat_poll(struct file *filp, poll_table *wait)
 }
 
 static const struct proc_ops mdstat_proc_ops = {
+	.proc_seq_ops	= &md_seq_ops,
 	.proc_open	= md_seq_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
 	.proc_poll	= mdstat_poll,
 };
 

-- 
2.53.0



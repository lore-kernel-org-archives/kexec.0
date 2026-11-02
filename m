Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEA60AED0C
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JOIZNxts;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIjK3Qwt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BWMrcMxphM3j3KhJxvOCR+KbGizC6kQdxxuLzJskxVk=; b=JOIZNxts1Yb1bR
	8CUjVRE9wNALrGokfPRsyAK3eD+DcVz7Z/v2dPGNvX3TeTV123xOAR0e8cktMVFVomGXH+PqVVyvO
	Ok3IDo+4Zi/InqmhYPl2mUp4+mFXg91j4TDDGlmeBVHASAH29b0SMaK+PZBLSHcaAUK54/DUBLuSK
	tsUr0l0bo+j4aHDE3dJPROVCq+tM+VglcnFwyS6CwuWoQ14q7bD8IcHKPnerSq1fltElpnd4I0Er1
	DbQ8ZGENGI5Qwby3ztWAcvkv4QA0kRXm19fJZcnnXE9FGr44eNnk4JBoHKRHk43tcK9idLcZwiAwG
	dEIcDo0RxUXfcTghEj0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtiw-0000000H0xq-11OA;
	Mon, 02 Nov 2026 15:13:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtit-0000000H0xC-1Uw8;
	Mon, 02 Nov 2026 15:13:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B11BF6053E;
	Mon,  2 Nov 2026 15:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643241F00A16;
	Mon,  2 Nov 2026 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632402;
	bh=BWMrcMxphM3j3KhJxvOCR+KbGizC6kQdxxuLzJskxVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mIjK3QwtTVilSpcRMeaoz6MTKvP7Sy6dH4N9uXF4AEtvkmOD+/LZgf883MtrMNbfX
	 Fc7qy6+hRUrZLI12uqt+tFP3+FSAd9d3s0S7Oj/5J8YKb9MuvzMCclBQW5ujuLEY3R
	 0jZ40m7Qe6thFpBjmEpgSnaWIQpr2OFaA+Hu2iHvPuRwIzTy5CX2f99EzFV0hO5HRa
	 v3h43WiiAhfIdyZllqL5RbxOqUX3/Hcfx8oBtLvZRAePXNc6Si2FGn6GzYJmq+441r
	 GdWXtRs4TvUpEjCZFIA+oogkhKJvXJm8hEiDfFaliMcEnFuCVmnTvn4+eIcYomOAzM
	 v0Y6JeRoVTSgA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:16 +0100
Subject: [PATCH RFC 09/23] scsi: let procfs own the seq_file of the host
 files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-drivers-v1-9-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l1PqfsIz+cqTipGWNtI2ZFkSTs3hYfw6G0B1mtmwjUo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG4wo+Pp/Vmn2AIF2jK3Rnc8S5TW89ldrDXNvflSK
 a9TlSBvRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER2/GNk+LjMbs1f+SqdgEVP
 95yaUyouP9NB9EfZdvNTxdef/51/W53hnylf8tFqgbuGLVyB25bLi7g6NKw02Kjm+6TD3337TuM
 +XgA=
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

Declare the show function and let procfs open and free the seq_file of
/proc/scsi/<driver>/<host>. ->proc_open() only preallocates the buffer
now. Reading the file then no longer holds up its removal when the host
goes away.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/scsi_proc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 3e49c4c8704f..59229bf9938e 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -94,10 +94,10 @@ static int proc_scsi_show(struct seq_file *m, void *v)
 	return shost->hostt->show_info(m, shost);
 }
 
+/* procfs opens the seq_file */
 static int proc_scsi_host_open(struct inode *inode, struct file *file)
 {
-	return single_open_size(file, proc_scsi_show, pde_data(inode),
-				4 * PAGE_SIZE);
+	return seq_preallocate(file->private_data, 4 * PAGE_SIZE);
 }
 
 static struct scsi_proc_entry *
@@ -140,10 +140,8 @@ scsi_template_proc_dir(const struct scsi_host_template *sht)
 EXPORT_SYMBOL_GPL(scsi_template_proc_dir);
 
 static const struct proc_ops proc_scsi_ops = {
+	.proc_show	= proc_scsi_show,
 	.proc_open	= proc_scsi_host_open,
-	.proc_release	= single_release,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
 	.proc_write	= proc_scsi_host_write
 };
 

-- 
2.53.0



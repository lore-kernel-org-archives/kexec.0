Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C451606AE94
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kjw9kvT3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPYohCzD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2GaZul5nsAkiA2gFzaNhtmiz6cl7FK3FoYt1S3NMwg0=; b=kjw9kvT37I8tRx
	HAP0yk+ZgVeWOLLSmsB0vQynemKS4usjQMKU21LdG969fBtCvmrEs/bcpg3lbjoqu+RRSTLGDvzOI
	r+LGnfWKpXc+E4xBHggAXkwM9uyWsnRy/K1l/JsAAAYB+sbgdD64x+4RO2+VM45bpO7C1wX5l9GR7
	o9MhYpdJeonHPie2syNJzeEkYb0/m4UTO8WX2+V/s5PzujCmUlG0YBpS4QshE2UEnJKSk2uBIdnl0
	7PEUXwSsevDHeyMaIEwQiRzSZWt5yYbX+eYUO8xRU08PZESCTjjT3anLhZDv0vHWhFvhTI+jYpCSr
	m5I0KtbBNSa2/Mi/44dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtbN-0000000Gykq-06kX;
	Mon, 02 Nov 2026 15:05:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtbM-0000000GykL-0E3N;
	Mon, 02 Nov 2026 15:05:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6749160617;
	Mon,  2 Nov 2026 15:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC891F00A16;
	Mon,  2 Nov 2026 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631935;
	bh=2GaZul5nsAkiA2gFzaNhtmiz6cl7FK3FoYt1S3NMwg0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gPYohCzDqrsQn8T7TOjQzO9kH78swG2borvDZMC6jw8GKugG2jigIBNCmf3EfbRog
	 yxvhj7CSRV/sJqfNt6IzZWz7NbW/xuPFzaZzRxL8W9WId9cYqsYqwOpJnSNHd9Zx00
	 cVCWJlmHSPUqmOWftRxlfoYvxfeTa2bvDLbr+SmQTCQMClvPyfEa80ucz/9F7McAts
	 lpUGT6YWauh99d+fYUOnejKSIPRBXooAdLcFwky+UxQUTCrbGWHl0wHARoO6g8KLF4
	 jS4r3/hO+n7We6evEMM+LHhfwrC3xfWwpo3o7tQV451heeAi+52LI3LZMXaeoL+eQ8
	 lXFrvyo0JPSLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:39 +0100
Subject: [PATCH RFC 12/22] x86/mtrr: let procfs own the seq_file of
 /proc/mtrr
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-arch-v1-12-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
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

Declare the show function and let procfs open and free the seq_file.
->proc_open() only does the checks now and ->proc_release() only drops
the MTRRs the file added.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/if.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4049235b1bfe..9510e01d5103 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -349,7 +349,7 @@ static int mtrr_close(struct inode *ino, struct file *file)
 		kfree(fcount);
 		FILE_FCOUNT(file) = NULL;
 	}
-	return single_release(ino, file);
+	return 0;
 }
 
 static int mtrr_seq_show(struct seq_file *seq, void *offset)
@@ -391,13 +391,12 @@ static int mtrr_open(struct inode *inode, struct file *file)
 		return -ENXIO;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	return single_open(file, mtrr_seq_show, NULL);
+	return 0;
 }
 
 static const struct proc_ops mtrr_proc_ops = {
+	.proc_show		= mtrr_seq_show,
 	.proc_open		= mtrr_open,
-	.proc_read		= seq_read,
-	.proc_lseek		= seq_lseek,
 	.proc_write		= mtrr_write,
 	.proc_ioctl		= mtrr_ioctl,
 #ifdef CONFIG_COMPAT

-- 
2.53.0



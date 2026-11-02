Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50E609A73D
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PtV1Ujpb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDk6OKCI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=B1LcgTjI6osh59ZzieUt8cHCAfIdiXhMZk2FTOpmVb0=; b=PtV1Ujpb8WdVhp
	UnFIBZZEwqPYVY9zUdxjhRuvdv4vSWSd11KoLQ6RU+8qWN9Y5Wr+F9Hw5yDE07FMri0lN5c2wDBN1
	1bBoqJ8PMBie/njW3MaBEsknjnYGZmGwagCVdrOBaadvAk23qkJS0scXPXTGVQFkZ+lrLzSM0GUGD
	8la2/rOdPjpDX784yjUCWoVpSSYb3/qv6m08OUUzbEuLtje6midWAFvAEj56o1D5kyP4KtBG5OJwh
	OZUwYWubHlF2lCQqhfyjozuKIvUH49VVpC4xs1pRlng51fFbtBUKwEUma9NGEivARJ0U2EDjHrWxi
	AsrFMxX+yvC5WdvpbbmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtvM-0000000H5Ya-0YED;
	Mon, 02 Nov 2026 15:26:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtvJ-0000000H5YN-2548;
	Mon, 02 Nov 2026 15:26:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 42BEC40A1D;
	Mon,  2 Nov 2026 15:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E611F00A16;
	Mon,  2 Nov 2026 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633173;
	bh=B1LcgTjI6osh59ZzieUt8cHCAfIdiXhMZk2FTOpmVb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aDk6OKCI0ar0R/BnCnovLiGiUgsQiS5cX2Iwq/bm/oxbS1/IImKGdug7FdOjvklfD
	 64oCwGAK6j+ynLF1muOCW0FEO0ciDHlSkU3IC2ugiIhQRfFVM/NQ0oqazBDBhOY57h
	 sJCWDt4wqHqEb5aSyBD/+EPtWOITuneefzTGQ8mUGHB8tDqm3gA+4PZZ3S4JIuMiZc
	 GXmPDubR+xVQwezYvxsVrQArwRXqg2mHgtAgwVyPXxzSE4iifxjtpH179wLH+qs5l+
	 IW4VUxjdneaQ8roktcSnrLzCGbyg0Xatn3vQmPJgGEy5D/5zzbKmwEEMZ7lOT8pEwl
	 qwtHvgii6pE7g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:28 +0100
Subject: [PATCH RFC 18/27] sched/psi: mark the pressure files permanent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-18-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tXr5cu1BdmO0jHsjps1+bZ2IKVwDVWrseoizU64SWOY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG7kztYrxVWs4L7JrPOz+wSfbxdD3doWh3h9ivDfs
 j/t3nS+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8TmNk2OS7Of/7mXtnrpvY
 SWw+cDKm06eJnev5ArnA2Z7Kmpt18xn+O605/1eW86zoiteWxTHfRDjWzEmrUjjwJ+3Hhezzqf8
 qeAE=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

/proc/pressure/* are created when psi initializes and never removed.
Say so with PROC_ENTRY_PERMANENT, procfs then calls into them without
pinning them, like it does for /proc/profile.

That also takes care of a rule the files bent. psi_write() takes the
seq_file's lock to serialize the triggers. A reader holds that lock
while it copies to userspace, and now that procfs owns the seq_file it
does that with the entry unpinned. So nothing that runs with the entry
pinned may wait for that lock, and psi_write() ran pinned. Nothing ever
waited for it since the files are never removed, but with the files
permanent nothing runs pinned at all.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/sched/psi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 3132105bf382..9811c3b705eb 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1622,6 +1622,7 @@ static int psi_fop_release(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops psi_io_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_io_show,
 	.proc_write_buf	= psi_io_write,
 	.proc_poll	= psi_fop_poll,
@@ -1629,6 +1630,7 @@ static const struct proc_ops psi_io_proc_ops = {
 };
 
 static const struct proc_ops psi_memory_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_memory_show,
 	.proc_write_buf	= psi_memory_write,
 	.proc_poll	= psi_fop_poll,
@@ -1636,6 +1638,7 @@ static const struct proc_ops psi_memory_proc_ops = {
 };
 
 static const struct proc_ops psi_cpu_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_cpu_show,
 	.proc_write_buf	= psi_cpu_write,
 	.proc_poll	= psi_fop_poll,
@@ -1655,6 +1658,7 @@ static ssize_t psi_irq_write(struct file *file, char *buf, size_t nbytes,
 }
 
 static const struct proc_ops psi_irq_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_irq_show,
 	.proc_write_buf	= psi_irq_write,
 	.proc_poll	= psi_fop_poll,

-- 
2.53.0



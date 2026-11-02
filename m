Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7262608440C
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YsufucKr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hg5z4oUZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=K/nPdp0KTrkO/JWfX0DeaffmMq6r1stKUZ+oHzzOxP0=; b=YsufucKrTyQwvU
	3X16GUg0/2tFJHOQ6+PHiAokTtBNCsj8RInzT+SNC8O5cfcRe2UsebqmU/y3o5P5Ewd5HIKYL36sM
	aNjaybgJd3csziP743EoR1B3l4MvPCYO/VW1ZxOqV40ja3ucbEveSA+H8Dn/o+cSRT6oAZuB9470g
	mNcnwo8FDQQALMBp1M3IWwMjyJrb3ViN7a6Z65kGQqJJVM6MQlHOj1g++g3xXb6D2gwijRjS20moL
	oDOn8L+znQcDlANyfuw1Da+9fQs47o47flm7/g+pq0maxbZt8ddYMbMxE0Gy57hso5tcLT6QsXqKv
	r2Dg+p5dyGuU40t1M1aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtaC-0000000GyIM-2UnN;
	Mon, 02 Nov 2026 15:04:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtaC-0000000GyI3-00k8;
	Mon, 02 Nov 2026 15:04:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BC5AE43C16;
	Mon,  2 Nov 2026 15:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CD51F00A18;
	Mon,  2 Nov 2026 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631863;
	bh=K/nPdp0KTrkO/JWfX0DeaffmMq6r1stKUZ+oHzzOxP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hg5z4oUZuRz8N20Z5C+Q8yL18Y5yCw7qLkDhvSa3q8JNmsjPQwjzQ+mMuPQCiWUbZ
	 Y7Lf4C3jcwYkPZM9FYjlQwVMt+IVrZBJileSjZkYaIPS9b5zUXk14WIw+JVn7EsOU4
	 X4PnMaia2Uw5JRPK0Y/IeoZ5Ktq3pARrGiaVdYugzvHIRDhsmeS/p/quiqvdz+vWfE
	 AUGhD3c15oSYVACYkUFkJnNm0xAkDzUFjRuKB9ZEAXO17dJeJqcdRtoI5OGF1GhbZ7
	 YQIqxbvutG2Qq9CRYrtQhXVKgITYMloJ1QVm1bR6wQ8dUbiyrra8iSth/icVuFpZ8E
	 UfEtn5MBXe+5g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:35 +0100
Subject: [PATCH RFC 08/22] powerpc/procfs: let procfs copy out reads of
 /proc/powerpc/systemcfg
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-arch-v1-8-c9492ab08480@kernel.org>
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



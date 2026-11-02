Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B213606A337
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0ZJvQ9u5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Df3TZq60
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pGKkc9crGkZecPr8vk7TgMVLcv4DpuQHsFCpp4FMbY8=; b=0ZJvQ9u5y7mPl1
	H5jGYU+OU9Zu4JI2YZPAG0wU3Q5Nob1jAQaLRVLVFmCE5qMSRXy19hXgRxG0w91neH6EkuvRCUJrd
	TgODlwcXYqpxDgEC6EZB6By4ao4TNEUHVxRE0wDKOTK3dWA6J9/7yda7VryYT7W5BLNjUkwUTC2sb
	nqam6oARZzsapa0eD83POUfLEyJEdGiSwQMt8oju0Ub3cZ9GP5AhCA8iC9AJRSvbjMAicEbbkFLQO
	9pM0lmMGn8LowaVXkqPwP/+MGMzcJkxZ1w0XK37dyg5TIeY95eh0tn+a8SLM9gncFKUFO4CVpJnem
	SK3AkECNPH/RALcDO/MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNsvT-0000000Gm1X-0UJn;
	Mon, 02 Nov 2026 14:22:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNsvR-0000000Gm1H-3t0E;
	Mon, 02 Nov 2026 14:22:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 798CA439C9;
	Mon,  2 Nov 2026 14:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B385C1F00A1A;
	Mon,  2 Nov 2026 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629337;
	bh=pGKkc9crGkZecPr8vk7TgMVLcv4DpuQHsFCpp4FMbY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Df3TZq60vzd3Ud6sHKXoJyOdQDpB0y91AXsdElaLXcBNikKzPy/szHHI0/CwhfdRn
	 WsM9i5bSUctcGEqYeXI7QRDxIUmUu6UVak83Uv46oMzFfbpgzCr7WVMlJ4BZ9J3HMW
	 AjiG1/VEQjOOGRPDINpgdmcZyMZLtyj1mgE1Unq9dkmYqFAk/CpLvDVWQcV09cYgAf
	 ujO/67H0xCQCJ6g61xa0UOqeiUbiLYXf42d70VBXVhX79yB82XPCpH4/p7mnlrDBHD
	 DpkuL3OCzDyMvDM0Y7nF2tWK4aAoLW1EUN7+2jUNhTpoMsfy3rJmuVaCfP3vQoVnEw
	 qrmaSSpx2GTbg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:17 +0100
Subject: [PATCH RFC 02/38] PNP: isapnp: don't read past the end of the
 buffer on a large pread()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-bugfixes-v1-2-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r49sdX7Qo0uBjLpgxxQ+IVLBreEaXwT40T2nEujvZRA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJN1Oevk86ly4dxr5u5ckPH96NsbLxgkniTHLPuY0
 Ppb4oDwx45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ5CsyMpyUnxT0MYT7za6w
 DL3kKeLy+fudHgfx3zRQWh2/9tvz59EM/2MUrjVNN51Y9MLwwibHKsNwxzdPq+cE1u3LTEhIn7J
 PhRUA
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

isapnp_proc_bus_read() truncates the position to an int. A pread() at
an offset like 0xfffffc00 turns it negative, the check against the size
of the configuration space passes, and the loop then puts everything
from that position up to byte 256 into the reader's buffer, no matter
how few bytes were asked for.

Keep the position as a loff_t and clamp the count against what is left
of the configuration space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pnp/isapnp/proc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index c1f6e6bd0eb2..8197c7f29743 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -23,14 +23,12 @@ static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
 				    size_t nbytes, loff_t * ppos)
 {
 	struct pnp_dev *dev = pde_data(file_inode(file));
-	int pos = *ppos;
+	loff_t pos = *ppos;
 	int cnt, size = 256;
 
 	if (pos >= size)
 		return 0;
-	if (nbytes >= size)
-		nbytes = size;
-	if (pos + nbytes > size)
+	if (nbytes > size - pos)
 		nbytes = size - pos;
 	cnt = nbytes;
 

-- 
2.53.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8254606A91D
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f5P5tB1V;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY7sAPiB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=D8LiDRsnJChLwJhIiURqMi+IEx07pT1snt20aq8E9rM=; b=f5P5tB1VZcUXSM
	22mvob6AGhwy82KMRZF8eOiXRvgN5dOBsQ5bKLip8wqyyMyrf21BO3nB/10ZqZkrfnmHmmQg22Nm+
	85D62CkzkwOlVXHSv+7H+bmoUvhOxq2eJVGehY/tME5TFIfrUyKlTkKaDHOsO/FBBumgQ3XNAXHpP
	ZFByOJnQGOv7vFF9VhCNbz49vH3bHsUcUGnw0x+BfJ5WrqAAMvk/IBaSuH60sKzjsbOloixCRQln0
	8kWuMsOhNXPHTQXlAy9kq7AetiAdIkRBkMeRXrKjXZZurY1eXCI1HqlWJ8pT1zYgY/Me3b7/vUY0a
	3IcRKDOb/3hfTJ6o/VOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtMK-0000000GtnO-22XE;
	Mon, 02 Nov 2026 14:50:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtMJ-0000000Gtmy-0mXU;
	Mon, 02 Nov 2026 14:50:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC68D43B20;
	Mon,  2 Nov 2026 14:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F511F00A17;
	Mon,  2 Nov 2026 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631002;
	bh=D8LiDRsnJChLwJhIiURqMi+IEx07pT1snt20aq8E9rM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XY7sAPiB6xKRBPRrgdmo5CijbkY/r6DYQxS9vxj0LNqLx1chyKoXYwlcmR9Mg/gpb
	 F5C0xihgbQhfrRyBVIKVVrcpdePkU6bEJfTWaA6K8y2wjqTkj4PljLtUxCT7+gauaD
	 vHwKtdNq2oUH6aKWC1zQ0Fmc3y7lbPX7eigS9suG41uI9/NTMrzrBGRYqs9CSX8QqS
	 YHVefpo812EYRaSZV1x2NbZgumIN44gD2ItNTsSmmJa5JrHmCPJLdjSS1kkVCvCbJM
	 MrIkF/uQGgReXjaN3sfePFQ4ESoroUQ2Y58ypaPjPARPc+jYMLSzHsU3vR/cAPSiPd
	 ApZ4JPzTvFg3A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:48:43 +0100
Subject: [PATCH RFC 03/16] proc: make room for more entry flags
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-core-v1-3-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
In-Reply-To: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
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

->flags of struct proc_dir_entry is a u8 and the next patches need more
flags than it has room for, so make it a u16. Bit 6 stays free,
vfs-7.5.mount takes it for PROC_ENTRY_CANT_MOUNT.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 268a0523be12..41e00c978ddd 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -61,7 +61,7 @@ struct proc_dir_entry {
 	struct rb_node subdir_node;
 	char *name;
 	umode_t mode;
-	u8 flags;
+	u16 flags;
 	u8 namelen;
 	char inline_name[];
 } __randomize_layout;

-- 
2.53.0



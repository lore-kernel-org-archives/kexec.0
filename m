Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7E606BA3B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aNI2S/iA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMLUUnxm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=u2X249K8Gv42gMme4huYd6C+95aEaWoamySHZXVPIjo=; b=aNI2S/iAGPhl8p
	NGSs5fuKxTCd+s4HBRdX+KfyHUZY/ezbsOPd3QTMt31bIyC6bzra+5EmJ9cW0LBqbylFGNJrc1Ihn
	Vcx64f+Bm6CURhx7/6+reuWBBkYJeugjXzS2wo6Urbjf6ANMXK8f2AUbOqV1XVz8Y1xeiRkb6m2rh
	f/iTj5RL7JSTdmMFY5UzjVwto7TUGREtXpgZT8+e9PqUqTVs43iFZ0JTzIO9wWMJUKx1sAgJ+YbKw
	IXL24/Wx3ip1Y3U0YFouXQCNAdrM9MahuSzzBvbZeBMTxtW9PeXCJz9czCbZpIn1lSrJ81D7Ft7GD
	mAkIdmMza0Ut4IPogglg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOghH-00000006dxp-0ryY;
	Wed, 04 Nov 2026 19:30:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOghG-00000006dxg-3WMq;
	Wed, 04 Nov 2026 19:30:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9439043B79;
	Wed,  4 Nov 2026 19:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00C11F0093A;
	Wed,  4 Nov 2026 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820658;
	bh=u2X249K8Gv42gMme4huYd6C+95aEaWoamySHZXVPIjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OMLUUnxmfEftMfptXH6aASt5Tju/99MVIqrfpjLsj+gTwl1dsyCFLVnKp80I6LuKO
	 oV0QkRgTSnk8cZI+NetFJ+jomOknbAag3B6bMdcrBaXvZtck+/xvDa4BUJ2zie3Nl+
	 JtAthSnHxj4wqZGdExdBuvFSspoTXOWRxDVg1T0H5FlP1TmWo+WfW5NXkRdAPOD/to
	 FaY8dSSINRoeizDC8sYIFz0FPC+mWeUMnxUQ3X2aX90CpJQU6c09w6oMI8u7UP1as/
	 taIX+tu/yWMo7E9CWiCSlS8Nu91tL7Ok4VCHWyN5iv9o3t3dpMoYVw8gZLA2ml/4cB
	 AZLZ4sqr4PQ7w==
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
	Chuck Lever <cel@kernel.org>
Subject: [PATCH RESEND v2 06/23] proc: make room for more entry flags
Date: Wed,  4 Nov 2026 20:30:44 +0100
Message-ID: <20261104-work-procfs-core-v2-6-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=brauner@kernel.org; h=from:subject:message-id; bh=mmFUc3YfLRQzskFnHhhj02Zv0+dhV+Q1flCEFZM8H8c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bq/YE8ppefVCfjBLi91KVfu7F1mOL7llu6gh/f5jz ymR0dtYOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi1s3I8C83q8EjxTXpWd7G o5PTjr90WyF7Xu/d+3XP7z3p5dvzaw0jw/O3O9s41xUbhTy4tslNTFiwcAZnoY5Ak3vOm7LqhTE tjAA=
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

->flags of struct proc_dir_entry is a u8 and the next patches need more
flags than it has room for, so make it a u16. Bit 6 stays free,
vfs-7.5.mount takes it for PROC_ENTRY_CANT_MOUNT.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 33776bc00ff0..7dea0237f08b 100644
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



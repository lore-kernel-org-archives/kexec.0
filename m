Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52860A16D0
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wgiItlMc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omYmnILU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8JYviDqoWsEGN3uNb5Mh66eaw6snQ2TUUnHcmJoMJ80=; b=wgiItlMcl12qKY
	5L55+cofoVPvAt9dBckLiRUDUk/PrdkgHGnebnYa9v1K7RYSFHBOan0LC0KnSmCUaqaaXS0Z8P5WV
	lkGR3os9OmKz8rsDMNq0wdcYzCc09+RXDfjyK6qgyTh4R7panWSZXtslfGVy8lw9S02gHx1nEBRYz
	We+RdmOCPukQD4xoOzvL81hiWDPxSk7i16arYXP3ZUj7rswc5m89wFfibwV0EMAZA4gTRYGqvl9Mg
	2xrpZ6dO7r9HDr+DIoNnlEsul1BxTH5CLW1tt0hx7AtQdj1TaBdNcMsWuXIttaTwvHW226OXutsRL
	OLyVI7hyDmOZqrqbY/0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh7a-00000006p1Q-21rX;
	Wed, 04 Nov 2026 19:58:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOh7Z-00000006p15-0G81;
	Wed, 04 Nov 2026 19:58:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC4BF41AE2;
	Wed,  4 Nov 2026 19:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB771F00A1A;
	Wed,  4 Nov 2026 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822288;
	bh=8JYviDqoWsEGN3uNb5Mh66eaw6snQ2TUUnHcmJoMJ80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omYmnILU6n/a/8ypDuatFcm5Yn1YdJM3CRKKuli7fcBySnvTgN50xiis4mVllM49v
	 PV+Quk0y9VPAUT7onGY2p/nLF2xkGIDIWXqi4tkrhVP7JJganO4BAn8bDHMRztyoBl
	 kDuAQDvNJ8Uuc3JHKiaYHNXgDWLaFbsRCKaJ0zpPBvI9qjf+zzVVphC8QUnWa1gAS9
	 TqNqVumOE5u8pqbbZNrZhXFAdBkCmBN9rMMWYN4XW4rPv+P/EOoobKcvq4QxkXRKVJ
	 s5UQbq8xS22dtefS2Q7ckkJlMa6rIUtShtzwuWqlg+ImTJMyCWJ++E2LN9ezNnICps
	 7WSbKOm7NJ/JQ==
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
Subject: [PATCH RESEND v2 01/13] atm: let procfs copy out reads of the device files
Date: Wed,  4 Nov 2026 20:57:54 +0100
Message-ID: <20261104-work-procfs-net-v2-1-221e2437fed1@kernel.org>
In-Reply-To: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=brauner@kernel.org; h=from:subject:message-id; bh=gPjf1XFsI8l/uiq7gtBYaOS5PIZm1WCyT/xvmcgXYrk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97lO2Xbpnsl62nNauWplf/xdYPBNLEnswIafyCd/XX xHhEwqnd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkTZuR4eHSqRGfps/7dvOV 691dX8+Wbls1oSJgtmlB5Vsb0VvvEssY/hllnXhlJifSrl2270GVY8Ldju5SgRBVQfPATZXl+2b r8AIA
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

Implement ->proc_read_buf() so procfs copies what is read from
/proc/net/atm/<dev> to userspace after it unpinned the entry. The
drivers' ->proc_read() keep filling their page.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/atm/proc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/atm/proc.c b/net/atm/proc.c
index ca0fc6b90998..cea930b4b840 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -30,11 +30,11 @@
 #include "resources.h"
 #include "common.h" /* atm_proc_init prototype */
 
-static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
+static ssize_t proc_dev_atm_read(struct file *file, char *buf,
 				 size_t count, loff_t *pos);
 
 static const struct proc_ops atm_dev_proc_ops = {
-	.proc_read	= proc_dev_atm_read,
+	.proc_read_buf	= proc_dev_atm_read,
 	.proc_lseek	= noop_llseek,
 };
 
@@ -246,7 +246,7 @@ static const struct seq_operations vcc_seq_ops = {
 	.show	= vcc_seq_show,
 };
 
-static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
+static ssize_t proc_dev_atm_read(struct file *file, char *buf,
 				 size_t count, loff_t *pos)
 {
 	struct atm_dev *dev;
@@ -267,8 +267,7 @@ static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
 			length = -EINVAL;
 	}
 	if (length >= 0) {
-		if (copy_to_user(buf, (char *)page, length))
-			length = -EFAULT;
+		memcpy(buf, (char *)page, length);
 		(*pos)++;
 	}
 	free_page(page);

-- 
2.53.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03153606D4E5
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KdzXXUT3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijnLltQe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mdnthwMs9LvqnLJy6kPpeiwqrlhi6ADC7izliWiN2IE=; b=KdzXXUT3CB1XA9
	0FJ/XrTZ7YYpEohz/i8UVeb2XkJIXGXRxb3dc8PbbsA6HvuCu0dgQzrUp4EROMEPCipVL0FNKWT6M
	qu1/9bYqM/wL1x4YbInEzS2PksK77AlCLK6XHhCQsqdTHWdC/7jZ4eaKAfBsoIpuITzXiMevs/1eK
	5d0rjAsLF/hOhdMIYoVYk4oAuOOIh9qTStchUzcc8uosE73/NZmCOvsYFlzp+krwx3M6vuDHBg+J0
	jRN5Cnhb2FCwjd0LLYL54g/f2l8914Zwnv0ZxTa3wkYLCQBGu2TpGLAePG2+rRwxhfoFhMUiesMCJ
	SWskw+TqYX/oDeuW7eQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgVs-00000006YiP-2JvX;
	Wed, 04 Nov 2026 19:19:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgVq-00000006Yi3-1IbP;
	Wed, 04 Nov 2026 19:19:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B8B2660AA2;
	Wed,  4 Nov 2026 19:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86A61F000C1;
	Wed,  4 Nov 2026 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819949;
	bh=mdnthwMs9LvqnLJy6kPpeiwqrlhi6ADC7izliWiN2IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ijnLltQe5Qk+CqE+VUlDwwHbbObH+9ltW/RmuNk6+QVTedz2m/LYfiuF9co7AFJwE
	 sjrkuOfRO38+K7HcQrICBAwdPPqSWw81opUhQAieZFdKhLDYrT6ksUVuCvctpIzPGG
	 5IfV2bo/AIGZF92z/NIw2/tSYbEzpTKjlj5R/IpCOGOCq9t1qLgWWrxzM1Ldm3iL6v
	 jl4JL0l0pT78R+g4k6uEp1SAko5fY5xHs148DGpmxVJocVPvD8ORDyvyCDVv0yKLOp
	 0BGiObxQ1YUEMDTuDs/OR2Xrm+87BYRn1BsklV+azupKzmP8Z1i0K9CmVfX9sZIjIF
	 wvV04uPKt3MdQ==
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
Subject: [PATCH RESEND v2 12/51] powerpc/rtas: consume the whole write to /proc/powerpc/rtas/progress
Date: Wed,  4 Nov 2026 20:18:55 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-12-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=brauner@kernel.org; h=from:subject:message-id; bh=uNEn+pHXbIRRMkqtNF6NnFXDW3eMy9Pk3SJ7wJuNwck=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9brzZHzRlctZde+1Go+8eGv7b1+cVSZ7+f//NhYzz+ 8+/DW/t7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI5ROG/2mHUo8Ur0zzZ3Z9 kx7D/2mua/jtI8eaYjr1fyTPTo02WcfIcOywWBSj5altb2eddZvFnrJ1ZrTjumSG/rNnerMtg50 vcgMA
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

ppc_rtas_progress_write() shows the first 255 bytes of a write and
returns that many, so a writer that loops until everything is written
shows the rest as a second message. Return the whole count, the rest is
ignored.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/rtas-proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index f38df72e64b8..89b165986851 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -311,6 +311,7 @@ static int ppc_rtas_poweron_show(struct seq_file *m, void *v)
 static ssize_t ppc_rtas_progress_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
+	size_t len = count;
 	unsigned long hex;
 
 	if (count >= MAX_LINELENGTH)
@@ -324,7 +325,7 @@ static ssize_t ppc_rtas_progress_write(struct file *file,
 	hex = simple_strtoul(progress_led, NULL, 10);
 
 	rtas_progress ((char *)progress_led, hex);
-	return count;
+	return len;
 
 	/* clear the line */
 	/* rtas_progress("                   ", 0xffff);*/

-- 
2.53.0



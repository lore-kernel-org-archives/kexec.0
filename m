Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0E360A260D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Af9ngDXM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpHzZpnF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jP/hayhlpAKZdjJKk3r9BHeVVOYyvJcLU3d1z3kH9u8=; b=Af9ngDXMmZXF5F
	oCzLON8vn3+Cn8qdPJMe7U2HDvRis4aKujUj8Gx//D4QGV3vg8SelPRZtknMT1jPp4bHPEwhIPIpX
	6CYklKQHaqnFvB3vcUgY/zUQTm7cHv4xdqk7LPuOUaiybX8QocI8mjeRQYWFlFsowT0PASnZS80Dr
	p8hCEutBPVpB2OJcvWDNRKSI63/fwdoIHqSwHQIgufM4+FmmQiKORPXXcOxoKtfPYGRorlQf/eiEO
	/hb2TYJ36Lh380/F67tsMFvJUXW2OgRbJbG5VgoTUadZabAAiN7zZUBBbVHhiyWEECbhe1Zt9IZHG
	SNkWlCG7KVh7Bb/WAKWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgUD-00000006Y2m-1oqt;
	Wed, 04 Nov 2026 19:17:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgUC-00000006Y2Z-2VMU;
	Wed, 04 Nov 2026 19:17:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A72041388;
	Wed,  4 Nov 2026 19:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C9F1F00A24;
	Wed,  4 Nov 2026 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819848;
	bh=jP/hayhlpAKZdjJKk3r9BHeVVOYyvJcLU3d1z3kH9u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KpHzZpnFwT6+C0q0yRCi5k/OA66tRS7eBzT8lt1HaWQE8e8svE3VZCRBnfRHdCzx7
	 71y/CPv6HCeTe9zbap2gT5FJuzj5hekBtO1a4cjxKuetzIxGjHALxdRgkDffBvgqoN
	 /aj76OWmFdznND17QWfa+CPtL2LoFKokFbuci0W4IBDDUUsoZwEUSEMsIoP5ROVtaD
	 UYsfpJY8su6lg+vsurlkAT18SVCFHIc8HLWY3wDZz/GvQ7lhgYrpLIwR5WyV8knPdX
	 rwvwNGe1ypF9HhdxdQGkkPDxlpkOU61C82qjywHhkl5yTgB9ONziIAgGKfFuFYu0iv
	 y/71Zwy9XejIg==
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
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2 05/51] xtensa: simdisk: remove the proc entry before the disk
Date: Wed,  4 Nov 2026 20:17:14 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-5-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=brauner@kernel.org; h=from:subject:message-id; bh=f7Qg/00vnZM3tuJ138yAFxD6JPv6/GBN+HDx2x0z8gg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9brxQmmA/984KHvt9Xz1eFefxl8hqpieb9fosObahV 1Ne5l9gRwkLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERykxj+u2j/eB40M+7p2v17 /GMmXT/na+Ctz77txmH9Sb+NLH5yrWH4HpzAeT45SPnv5UMnF7jMebDmtMJKXyf/NT8uPWe+O7+ RBwA=
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

simdisk_teardown() frees the gendisk and only then removes
/proc/simdisk/<n>. A write to that entry in between attaches the file
that was written to the disk, and simdisk_attach() sets the capacity of
the gendisk that is gone. Remove the entry first, remove_proc_entry()
waits for a writer that is in the middle of that.

Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/platforms/iss/simdisk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index a2ddb49c269d..e51edb8cf872 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -379,12 +379,13 @@ static void simdisk_teardown(struct simdisk *dev, int which,
 {
 	char tmp[2] = { '0' + which, 0 };
 
+	/* a write to the entry attaches a file to the disk, so it goes first */
+	remove_proc_entry(tmp, procdir);
 	simdisk_detach(dev);
 	if (dev->gd) {
 		del_gendisk(dev->gd);
 		put_disk(dev->gd);
 	}
-	remove_proc_entry(tmp, procdir);
 }
 
 static void __exit simdisk_exit(void)

-- 
2.53.0



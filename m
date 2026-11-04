Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79FF606AB34
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Imgt0B5s;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RajwCGCh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zft31zEOyoxpoaQra2tyBUnsx6CBcNbPccBHjIcKUVg=; b=Imgt0B5sm4l4zt
	1PMl6rmCGVN22e3InGBKgEGBj+t+0h+lyFM8kT5GcrwI1ZMrRNCIaEmIIiYfn7rvbSEqOMYV4JOv9
	xktjS76UvUojKpAombXpGxwwF64TJTfS7AbE6pTCWDSBJKOHHa9Yj8ORM5fGURmAMfywyxOdeKy3H
	768lZx8i8wYw4vwZftM1nCYCmgdX9Od0VrcI9RfWx0bvHrGL8FFpmiwwWIjEVSFS44tDzRueuma/x
	tNmsOODaep8WIdemvv6EBm7W80aWTxvl+/kDFfHL+SBiafBRtbxFRtHk9Yo9oaZbtgFiVtp+0cRzg
	nL9Mclf6teTIAOHNzBuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgww-00000006kiH-2iIu;
	Wed, 04 Nov 2026 19:47:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgwu-00000006ki0-3s6w;
	Wed, 04 Nov 2026 19:47:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CF4D60F12;
	Wed,  4 Nov 2026 19:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A421F00919;
	Wed,  4 Nov 2026 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821628;
	bh=zft31zEOyoxpoaQra2tyBUnsx6CBcNbPccBHjIcKUVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RajwCGChuwyoqoZXwpUtB63CnfJNCXfYV3MXWhfQVc5Ev6XMozMwlvc6X98vleQyv
	 f9HzBE4v113NX/e1l78y5ttqcWo69gQcs6Ww+sQGKZ3cLiPEcmIedv9Dr8Fupfzesw
	 W2qdod9xWoMSOmx1XAyg2z9rNs/8Jv2qrPox1n/Zc4FZI6mKO77lTmc1CJ+0psYuJ3
	 GAD2h5/aLL7ToIPisurMJ320J6bxgj0LUdPq4xrjzKapKKfnTHEzSVwuWV6kBmMycE
	 p8oPLiWRZfJASR8Mhh1/kUIyHucEcqRy1EkK1gmQTe3G+tur6Iu40MBhi/iT5cSWMY
	 VmRs6TTIcG5Ww==
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
Subject: [PATCH RESEND v2 19/26] wifi: ipw2x00: let procfs copy in writes to the debug level
Date: Wed,  4 Nov 2026 20:46:53 +0100
Message-ID: <20261104-work-procfs-drivers-v2-19-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=brauner@kernel.org; h=from:subject:message-id; bh=SZl2laNUZYNGFN2sYGUP5fs3tBGCqMuq/D28k7CZWwo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97up6Oev4hMLPxsZ2136FuR12SNXk+zJzkV2eLvcbC +ML1Vevd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkxyZGhh+zNh/MzVMol5A7 Oltna15SsRRnwKr/s7+v+ix/vNn+yDaG/x5P3yxp3xP3fKd4vL9mjb/e893xlTemrnQuFzt//Ms bC34A
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

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and parse the level from that copy. Writes larger
than PAGE_SIZE - 1 bytes fail with -EINVAL now, and a buffer that can't
be read fails with -EFAULT instead of looking like it was written.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw_module.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_module.c b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
index 15d9a5efb581..08cc0d7f57c1 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_module.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
@@ -216,14 +216,13 @@ static int debug_level_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t debug_level_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	char buf[] = "0x00000000\n";
 	size_t len = min(sizeof(buf) - 1, count);
 	unsigned long val;
 
-	if (copy_from_user(buf, buffer, len))
-		return count;
+	memcpy(buf, buffer, len);
 	buf[len] = 0;
 	if (sscanf(buf, "%li", &val) != 1)
 		printk(KERN_INFO DRV_NAME
@@ -236,7 +235,7 @@ static ssize_t debug_level_proc_write(struct file *file,
 
 static const struct proc_ops debug_level_proc_ops = {
 	.proc_show	= debug_level_proc_show,
-	.proc_write	= debug_level_proc_write,
+	.proc_write_buf	= debug_level_proc_write,
 };
 #endif				/* CONFIG_LIBIPW_DEBUG */
 

-- 
2.53.0



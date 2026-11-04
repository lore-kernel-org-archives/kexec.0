Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE476072D6B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IKbCVSuu;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4qjG/En
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QnuUeY+9+QMi3OegoRzUMDksdZE42uDQ+p1ThOeCsVw=; b=IKbCVSuuWFHpb8
	8VK7pP+XEsCsQaUFEdgGG9994M1Zx8hbtKALZIp89F3pMWJcluQ4xqAzKgpIh+QQidyg5XajqYhiW
	wcYyAW1qU+41AkOejQVyxxlOniB4ekHwmBIv3veFxEa0e5F7gnzL/IoeQVsAoMKbhaPyOaX818TTA
	YjFuex20mHxJhWkdIS+yKa12vw1ekiX41075Q0DNkftPlaOLtCTXRBx/rekRqhgx6N0GAlxJ47p2H
	jC41CxNFeM8zUfkYiLfdMkckn5yI/iRN6P27STPAtw4vWc6+5nwUXwcwM3fVTaHr8czxFdQT6hjPR
	Bl5flfI+po1eHzbmG1Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgrX-00000006iUC-0xdL;
	Wed, 04 Nov 2026 19:41:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgrV-00000006iTn-2XJ3;
	Wed, 04 Nov 2026 19:41:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C03F609F9;
	Wed,  4 Nov 2026 19:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876321F000C1;
	Wed,  4 Nov 2026 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821292;
	bh=QnuUeY+9+QMi3OegoRzUMDksdZE42uDQ+p1ThOeCsVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4qjG/Enl784wKvVxl/9ldVwuuHEc87Y0LUedobA/KdwuI3SCxAckwhwEAtDdOOqU
	 UqZPPnd0i1wsEQPINzLmBf7fes9X1w97pMqml0mB5btMrfd8uToyQFpFM0Tl2wlAjD
	 kgF4RA3JR3lH8viB9FAeGA4ZqAZXhhvVqKaCxsHsidrZt3ppkwceT62jwKoGEsMlOx
	 78OYFlBnZIcEweu6rx9OyaYzVUpLMbaYn5Kxkk/UsZEPHpo8JcSdi7maG+VD8tqYHf
	 NonEOsq87sjklv+/uShbdJtRlOOZ5V+hHfFMq2FNCALvQq2gchvAnrCclCithYaHdM
	 zs/aDQjJX2z7g==
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
Subject: [PATCH RESEND v2 23/23] PNP: isapnp: let procfs copy out reads
Date: Wed,  4 Nov 2026 20:41:18 +0100
Message-ID: <20261104-work-procfs-arch-v2-23-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=brauner@kernel.org; h=from:subject:message-id; bh=O9tLcZSRMcgAQbB8Pp6p1hVEIxcx9tANJYkp4CgYVW0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97uRoSC+OPd30eNcyzvc/yy/YbGGdvPLwp7wL4ZnJy 2++kTT52VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRoLeMDKvtZufJ1LDZnWzr aM1t2LBM8N+nLa95p/c8m1iiUHw97gDDP8vnB0xly+JWrdKTyXnq2i/YvW3iPe61nAKrrcqOL/1 xhQUA
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
/proc/bus/isapnp/<card>/<dev> to userspace after it unpinned the entry.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pnp/isapnp/proc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index 1829c20d5446..2634db5f41e2 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -19,40 +19,34 @@ static loff_t isapnp_proc_bus_lseek(struct file *file, loff_t off, int whence)
 	return fixed_size_llseek(file, off, whence, 256);
 }
 
-static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
+static ssize_t isapnp_proc_bus_read(struct file *file, char *buf,
 				    size_t nbytes, loff_t * ppos)
 {
 	struct pnp_dev *dev = pde_data(file_inode(file));
 	loff_t pos = *ppos;
-	int cnt, size = 256;
+	int size = 256;
+	size_t cnt;
 	int ret;
 
 	if (pos >= size)
 		return 0;
 	if (nbytes > size - pos)
 		nbytes = size - pos;
-	cnt = nbytes;
-
-	if (!access_ok(buf, cnt))
-		return -EINVAL;
 
 	ret = isapnp_cfg_begin(dev->card->number, dev->number);
 	if (ret)
 		return ret;
-	for (; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
-		unsigned char val;
-		val = isapnp_read_byte(pos);
-		put_user(val, buf);
-	}
+	for (cnt = 0; cnt < nbytes; cnt++)
+		buf[cnt] = isapnp_read_byte(pos + cnt);
 	isapnp_cfg_end();
 
-	*ppos = pos;
+	*ppos = pos + nbytes;
 	return nbytes;
 }
 
 static const struct proc_ops isapnp_proc_bus_proc_ops = {
 	.proc_lseek	= isapnp_proc_bus_lseek,
-	.proc_read	= isapnp_proc_bus_read,
+	.proc_read_buf	= isapnp_proc_bus_read,
 };
 
 static int isapnp_proc_attach_device(struct pnp_dev *dev)

-- 
2.53.0



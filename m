Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C086606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wL3CiiOC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx1ml92n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bK3Qf/Fgrn1kHJyqbDbeKZxjvVolEa0ioklWbWt66po=; b=wL3CiiOCzM3gKi
	9OOLHlS9T60i2P1q43SsXV18KZydbJcY9Lh9pKPjupz03FAkgNH4wxaK5sbE54J9sGfGCbheB0SM7
	aaKV7wfX8AeT0xtkXnJqviTfG1ppIRRQHiSbp7zM9r7m0ga9dCgP0X7xnCfxvSs7s1SbO1yW4px8v
	nlFtpruUzZjC3UWNHkbp2UTp7XzAuTeUkIeMN641IedJxiZ8hNj3KNDGQrZNiCH/5Ay62WzbLfRbV
	Iami/mpwnDzHEgnHRGXIeMcegzmXN1/gZt2CguNKAsTQtgHjSj0l5YZioyt44Dswjb9hD74MAdRam
	OCp23IOh1pTQLMCLMuTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgWn-00000006Z5k-1QlQ;
	Wed, 04 Nov 2026 19:20:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgWl-00000006Z5C-2tYo;
	Wed, 04 Nov 2026 19:20:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 711E44386D;
	Wed,  4 Nov 2026 19:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBF81F00919;
	Wed,  4 Nov 2026 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820007;
	bh=bK3Qf/Fgrn1kHJyqbDbeKZxjvVolEa0ioklWbWt66po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gx1ml92nagZ7BrakhHXJtPQ+gcEUXo9KcayoMJOCqeD8l4YNPDO/HrtuxrVu5D/yq
	 AkBUy+fEu7DUS3PpJdPB8rP4qDEH7v+3NmBlnra1bCI78Eid7vxjW2+TTJjKFk1pa7
	 AD/p7tsz2i4zyXv6Wo6PwRfTfO4UBAA/iJgcwnGbIppd57DabriHGLgMEnacFdb1iY
	 GWlISVkMuIM9OcUzNZg45npnuMJt6k2wY5mP16R0b4wLk6SxDPuMPpdKe7JIGFtdcz
	 NWUGr2t2OzbQHDfP3LGVAcsb0fhKK1thVAFYLu2RzFUd22BqXfCyjuiOfZQwNar7gn
	 x0rZz3DaKTIvg==
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
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2 16/51] PNP: isapnp: don't read past the end of the buffer on a large pread()
Date: Wed,  4 Nov 2026 20:19:53 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-16-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=brauner@kernel.org; h=from:subject:message-id; bh=PRZX3tU6vm07qtbuZVgSHwh1cNhLueRVjGfMu08d6P4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9brwfzl4y9YPS+9UnzD/xWPz9cFZ3YUK46s/HNev+T X6yzjO1pKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAik/IZGTbFfnLPjP3etuFi 3uYXH/odI/9bLkx7YPeroPeyylQ3HSWGf0oRmziNpv1f8fdY/M9fuwrPnSgJELfs+hiheTJ/BWs JOxMA
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

isapnp_proc_bus_read() truncates the position to an int. A pread() at
an offset like 0xfffffc00 turns it negative, the check against the size
of the configuration space passes, and the loop then puts everything
from that position up to byte 256 into the reader's buffer, no matter
how few bytes were asked for.

Keep the position as a loff_t and clamp the count against what is left
of the configuration space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pnp/isapnp/proc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index b3abab24050b..1829c20d5446 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -23,15 +23,13 @@ static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
 				    size_t nbytes, loff_t * ppos)
 {
 	struct pnp_dev *dev = pde_data(file_inode(file));
-	int pos = *ppos;
+	loff_t pos = *ppos;
 	int cnt, size = 256;
 	int ret;
 
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



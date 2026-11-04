Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62860606D82B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1qXSMbsD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXEJh7D8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=S8IXtzTL1USde6aV/lVKsFPWulIUW0ciUvC5Tm4lMm4=; b=1qXSMbsDoV7GHs
	56pCfNqTS3k4dV80sOXDofpe9tI/W+BiDdtOTZlWro2E3w1DnK6Tg9JHx8f4bdZIFoRz9dIPulWkC
	0q15JBBqxoK5QDiJJxl1O4GE82OZdSgWYoqa56njPbkEZuaV0CmH3kkd5SUSKtMDSmjnu6K0sT5Yl
	kuqrkfV+2CAohN7UoT+xnQWnRJw1km3Zdq2jo/dKOzA6nMapHKeLkiXOK//qDaAQRGedxy/cDsofN
	r/2kvR8jnEntHq3OGbP1gLHwNbO5thk3yNVP+k1jreXNvhfeG6Bre6+/ceTeLKv3v+sg65ZqJnB1X
	+/47eKji73gi3f73W/3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgZA-00000006ZyP-0Szr;
	Wed, 04 Nov 2026 19:22:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgZ9-00000006Zy4-0xWr;
	Wed, 04 Nov 2026 19:22:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A8B406061B;
	Wed,  4 Nov 2026 19:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293831F000C1;
	Wed,  4 Nov 2026 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820154;
	bh=S8IXtzTL1USde6aV/lVKsFPWulIUW0ciUvC5Tm4lMm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXEJh7D86UeSEY8jNu82u3NLmId2OsI/Nv9nh3XWpLINGlBuLP5Nz+YiwtOsAqIVJ
	 oVeO2qxhNxAYSigqHIpjEKTcnXIbhPS7yHKiS4GRdJ9UYEuLBunN2o2SvnznlXI6BM
	 F5O9M7fZaaFETXY9Ej5mVQrFRkhRZM5mDYAGBCUg69fzwRq+8JjZKWRp58tNqeKTw9
	 Mus1vHfCqkTiD6xzM+KlO6h9c7TF92UrHaTiLn5L+jl6joxLiUSdcubt7/4SNRaTm5
	 vJlimOOsTIbLAxnLoArtNJAZUqCCnnAwocr+VwIzPakK1nD/ZdjgCu3EIbAcmKwTRk
	 HrfU9Pt62XfOQ==
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
Subject: [PATCH RESEND v2 26/51] scsi: core: NUL-terminate what is written to the host proc files
Date: Wed,  4 Nov 2026 20:22:19 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-26-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=brauner@kernel.org; h=from:subject:message-id; bh=jBwXVCCRpDjmnAajxR/zAvEvmAtZKAE0jCj6+Cnx3v0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bnztk+R5Surix3hvm7CKvXpyq57/KmExl721cvVL/ tOc37nndZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkuw7DXxHBqOn8F95zMNyd M6k2rOaLgMESqZzyjQvM9reKiH4XkGX4X/ewceXxBbldmy+3PQ+Iunxzrnshe95/o/05vCxbvk/ mZwMA
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

proc_scsi_host_write() copies what is written into a page and hands it
to ->write_info() without terminating it. ppa and imm parse it with
strncmp() and simple_strtoul(), which read on past what was written into
whatever the page held before. Terminate the copy. A write is at most
PROC_BLOCK_SIZE bytes, so the page always has room for that.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/scsi_proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index fdc355d783da..dbd03360b5a4 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -80,6 +80,7 @@ static ssize_t proc_scsi_host_write(struct file *file, const char __user *buf,
 		ret = -EFAULT;
 		if (copy_from_user(page, buf, count))
 			goto out;
+		page[count] = '\0';
 		ret = shost->hostt->write_info(shost, page, count);
 	}
 out:

-- 
2.53.0



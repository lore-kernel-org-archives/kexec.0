Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB2606D829
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3yo+3eq0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5l8Zw0z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=frXlYovGKxKiSN/Oj3/IY9GUET6etUhHzbC1M94LuG8=; b=3yo+3eq00X4DEL
	KIn9X72yEF9Xet4XF0BJG1EmIeXudk9ASiuDYT4GwDTJVm/FryPkvLD/OUidQyiqORz2669iu953B
	dXI+sZ9bQ1VeI+ecIbkNsErLFdn1ybXvhQhxZNO29saRW+9Db09W0hWhfoBxF7yYvrWJn6dLzT/yw
	yDgrw+9W9h5XyViFwtn6Y+JCYQEDVRKKxfZJUWwqEF/zKs0bk/MXk93gJhhez47NGiQ999s05WpO+
	CPgdN01l73Klhi1pKCXr2jkR2CVszeeNBWP9TJLIFB3kMD2VIJrmtaai/Mr+NWO3aUhY/bg9DyQfO
	5Ahy1UHY05nNnRyQuPrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOf9J-00000006Ilj-46Jj;
	Wed, 04 Nov 2026 17:51:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOf9I-00000006IlN-41KM;
	Wed, 04 Nov 2026 17:51:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A286342D92;
	Wed,  4 Nov 2026 17:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193531F0093A;
	Wed,  4 Nov 2026 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814708;
	bh=frXlYovGKxKiSN/Oj3/IY9GUET6etUhHzbC1M94LuG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5l8Zw0z4fZQ9sAGiyuZKFV/4Ks48j+EfxrlJEYi7n7otbyz7JFysKU1tHI5wpj88
	 CpOhI5fgv4CaHLI1k5XmU9YiA46xrA8Q/vpms1IHownsPnCRxeJYtvKMkZ0z9QgNGJ
	 Dt0qEGBEKG5uhOJH57H9KzWgwJVHzqSv2uWCyWP/yhmZTJIZYv4ihYn15949Cj3mSN
	 QjRMpFLnjQyEc/6vhtJSsBrbaSWk3wEW68rnJHO/8rURtjSRpPMZGCFfamkIjqxgLP
	 QLC4T97JjDLFJHcKQFwVspL3aQSwWyfRwRGbw9wXUukNHQZW8xsWkstW7G+uLWK9lD
	 r9NkjTZDIFp9w==
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
Subject: [PATCH v2 25/51] wifi: libipw: don't return 0 from writes to debug_level
Date: Wed,  4 Nov 2026 18:47:11 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-25-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=brauner@kernel.org; h=from:subject:message-id; bh=PSZyn/5j7f+UAGnOkF9zGJ8rErtLF7uTzeHltQyv5ig=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zrsr82TRXDvnq8eP1Wy9Ln1f/sr/I6YcdTNlV3pEL JFvLsq/01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRS/sY/ifVcHOsK0nzflX4 5M3zNcdYuHyXx97Te1lgK7btRfzEQgdGhgfMrr8XiR5rdt334XRQxNzpt78YSt3vXc1o/eVkzmm Ve8wA
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

debug_level_proc_write() returns the length of the string it parsed. A
write that starts with a NUL byte thus returns 0 and writers that use
stdio retry it forever. Return the number of bytes that were written
instead, which also stops writes longer than the 11 bytes it looks at
from coming up short.

Fixes: b453872c35cf ("[NET] ieee80211 subsystem")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_module.c b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
index 22358b2c2ecd..552c8ff3928b 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_module.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
@@ -236,7 +236,7 @@ static ssize_t debug_level_proc_write(struct file *file,
 	else
 		libipw_debug_level = val;
 
-	return strnlen(buf, len);
+	return count;
 }
 
 static const struct proc_ops debug_level_proc_ops = {

-- 
2.53.0



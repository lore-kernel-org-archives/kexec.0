Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E356606EE91
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OFeKthlH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEKJ5oBt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9+yARzdOpzdllKXUJ7Oz/hxaICj5Mm35ej5JnL7jd2E=; b=OFeKthlHVrVC9b
	tJLN0GdLmPA1qSruMu22JqtUZQPDKyQxwo44adzes1OBVieYxf2Pc+QBRix/pOZnuKcJkOin22YH3
	Qu7R8aMvA9VE0qHckKmZqdnyvuK7NOSBnyHL04Tkr1Dv3yNos91rwORZHdl5jMUPkZNoP8IJqIWZ5
	C4kej9ToZlJ2TsHaTyv16ivTRZf31SKk/UOcFNTyBTYIt0+QiobxS6o3k4anPQlDrawWcwQnE7ez7
	HVNgv8hN7RfZeK+SSdBB9yxnoVJ6FlHMDTy6heQKvs8rSurEP/a4Mb50J4nY1sAat0J7Rd7wHALFt
	cqI/J6RuYdKwcUfXQbyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeno-00000006DHj-0PlR;
	Wed, 04 Nov 2026 17:29:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOenn-00000006DHW-1o7O;
	Wed, 04 Nov 2026 17:29:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30C9B40C24;
	Wed,  4 Nov 2026 17:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641541F0093A;
	Wed,  4 Nov 2026 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813375;
	bh=9+yARzdOpzdllKXUJ7Oz/hxaICj5Mm35ej5JnL7jd2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GEKJ5oBtLs1Ued5KRzNH5ufzbODMyZ6PKn/Udd/hvL22vNsuoFBfVggV2ZFxVjqP4
	 8F6aIiAZmFuauOKTCLsqRblXf+tPD9fnHwb6IvcjUGRXyp5jYpp7RSlQRYmw3/tKTN
	 3hMTsxwcM7o+Kilf/qR1r6m4VjBReM+Zmlafux1A+LYZbzqYGdtm7xeTAIKiPpNlNL
	 g4/R+I932DYQ/ARbsO2FY4bDvIYVnkPqPp5PHE+IMmU+7MpzPMNLR8uYrmx3l5Cm5R
	 oPZrT41KRDe91uyE80CWxhIqW85F4PsqrtLkGrQKTz3AeHWg2FuAsXTXsMj7Uv14PH
	 8ydiIpfAzbpUw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:21 +0100
Subject: [PATCH v2 04/51] PNP: isapnp: don't go on when isapnp_cfg_begin()
 fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-work-procfs-bugfixes-v2-4-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3910; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zJWqbpFP7Eog9HhLBr1/8hQ7kUfFg3Bc340XkbmHZ+k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zvqrMu+3ucHOq8s8Hi6dUyBieqBr4iYJ9fLMtfG+8
 hk+XGY5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxkGT4Z1x3X32vSsH+H8de
 Tzy0tm6dPV/iyZO8NQtV2Rd9k3CX7mdk+Gmf7XH+YJVede/Zl5mfRZNs98TPb/HRte7TWrnzoYE
 JLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

isapnp_cfg_begin() refuses a logical device number above 10 and a bad
card number with -EINVAL before it takes isapnp_cfg_mutex. The callers
that read and write the device's configuration, the proc file included,
don't look at that: they go on talking to whatever device the card
currently has selected and then unlock a mutex they never took in
isapnp_cfg_end(). isapnp_create_device() hands out logical device
numbers without a bound, so a card with twelve or more logical devices
gets there. Return the error instead.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pnp/isapnp/core.c | 16 ++++++++++++----
 drivers/pnp/isapnp/proc.c |  5 ++++-
 sound/isa/es18xx.c        |  6 +++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 219f96f2aaaf..3591a2791c1a 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -853,7 +853,9 @@ static int isapnp_get_resources(struct pnp_dev *dev)
 
 	pnp_dbg(&dev->dev, "get resources\n");
 	pnp_init_resources(dev);
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
 	if (!dev->active)
 		goto __end;
@@ -887,10 +889,12 @@ __end:
 static int isapnp_set_resources(struct pnp_dev *dev)
 {
 	struct resource *res;
-	int tmp;
+	int tmp, ret;
 
 	pnp_dbg(&dev->dev, "set resources\n");
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	dev->active = 1;
 	for (tmp = 0; tmp < ISAPNP_MAX_PORT; tmp++) {
 		res = pnp_get_resource(dev, IORESOURCE_IO, tmp);
@@ -936,9 +940,13 @@ static int isapnp_set_resources(struct pnp_dev *dev)
 
 static int isapnp_disable_resources(struct pnp_dev *dev)
 {
+	int ret;
+
 	if (!dev->active)
 		return -EINVAL;
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	isapnp_deactivate(dev->number);
 	dev->active = 0;
 	isapnp_cfg_end();
diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index c1f6e6bd0eb2..b3abab24050b 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -25,6 +25,7 @@ static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
 	struct pnp_dev *dev = pde_data(file_inode(file));
 	int pos = *ppos;
 	int cnt, size = 256;
+	int ret;
 
 	if (pos >= size)
 		return 0;
@@ -37,7 +38,9 @@ static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
 	if (!access_ok(buf, cnt))
 		return -EINVAL;
 
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	for (; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
 		unsigned char val;
 		val = isapnp_read_byte(pos);
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 3cadbf7cf238..de1eda5a0656 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1950,7 +1950,11 @@ static int snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev)
 	/* ok. hack using Vendor-Defined Card-Level registers */
 	/* skip csn and logdev initialization - already done in isapnp_configure */
 	if (pnp_device_is_isapnp(pdev)) {
-		isapnp_cfg_begin(isapnp_card_number(pdev), isapnp_csn_number(pdev));
+		int ret = isapnp_cfg_begin(isapnp_card_number(pdev),
+					   isapnp_csn_number(pdev));
+
+		if (ret)
+			return ret;
 		isapnp_write_byte(0x27, pnp_irq(pdev, 0));	/* Hardware Volume IRQ Number */
 		if (mpu_port[dev] != SNDRV_AUTO_PORT)
 			isapnp_write_byte(0x28, pnp_irq(pdev, 0)); /* MPU-401 IRQ Number */

-- 
2.53.0



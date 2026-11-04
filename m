Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F0606A33A
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KZM/4AOr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4z066t7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bDYBcNUn+VWuCpTwTZF6KvGO9475Dcj2RU9o+tvUNt0=; b=KZM/4AOrWxB9ZR
	zjlI/oB7JutWrz66D2bJ6n+Y3Ad+IuthdLhIwzA1upjqEmZjpWdCOYKMOQQ0rEeB1I55idF8+/SXt
	9ghmmFfpncWzMU94ZgK+fpzGXI0t884/AtQy9xSIZi0X3r3yElFgkzabneiffb5qbTsUVhTNubWN7
	TOuddpfhoSRkj1QG/lhS+IFxkHHX0+xqHUzOn/vES0q8VXwfWUWMjNHOt0RsY9PCcLpEiGISds6DJ
	BjjG6nM0c2gdASmhwXAuXSjZJuKr7PB7ejX2+Rr1R4zwJLxohYasi86ayRcJvp03fMkpWMT4tdd31
	PADTmCCwxc3ImLSh+tkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOf6x-00000006HdM-3aay;
	Wed, 04 Nov 2026 17:49:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOf6w-00000006HcZ-3CyO;
	Wed, 04 Nov 2026 17:49:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 80123401B0;
	Wed,  4 Nov 2026 17:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ADA1F000C1;
	Wed,  4 Nov 2026 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814562;
	bh=bDYBcNUn+VWuCpTwTZF6KvGO9475Dcj2RU9o+tvUNt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4z066t7qk8SNBZ3qr8F1Dv4FM+zeL5UMqbVPpZhgdQRsqgneSAYM0s8mSty+AN6F
	 uOpJwVDXNMcIMJN/l4FNHGQgvK/QCR0cqApE4XNvTdD9heJSFssRxRma5MIWbLp5q7
	 KuStqfVc5Mi7/uCEtKU/XidV25HekngkokdSavKrGmFA9IR6yxAQ/fT2R/UVEXUpOV
	 JshYWFM1jRBiauogMI9LETcKUpSEg7rlt/XCrsDvHcIcKKrKf+Lfu9grpGXEUlOUBw
	 il1cziT3er+LG8IbGUfsHyBhUl9fEmWujhzvys7fEbuJMHuqJFLv3DIRlBTxlslyyu
	 1lR419jEJXKMw==
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
Subject: [PATCH v2 17/51] s390/dasd: don't look in front of the buffer on an empty write
Date: Wed,  4 Nov 2026 18:47:03 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-17-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=brauner@kernel.org; h=from:subject:message-id; bh=vNxDJDpmoyfXJahneUuQ9vEH9eL70g/8w71rNTJgUxc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zrsssUymaabA31Var5avOM5bfCJp4gvZaynZy78sz mbbvsPjXUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEJKczMuyYrr82Yt6rR8wV ngvXr6z7d1Hu7s13rzfk5t00zdb9H3OckeGStmp/GZ/E1KSXmfqdfP1HWkLun/hu9/dXSsq18Bl 8+mwA
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

dasd_get_user_string() strips a trailing newline by looking at the last
byte that was written. For an empty write that's the byte in front of
the buffer it just allocated. Only look if something was written.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/s390/block/dasd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 2ffe404b890f..e97891e58957 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -933,7 +933,7 @@ char *dasd_get_user_string(const char __user *user_buf, size_t user_len)
 		return ERR_PTR(-EFAULT);
 	}
 	/* got the string, now strip linefeed. */
-	if (buffer[user_len - 1] == '\n')
+	if (user_len && buffer[user_len - 1] == '\n')
 		buffer[user_len - 1] = 0;
 	else
 		buffer[user_len] = 0;

-- 
2.53.0



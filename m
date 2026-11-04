Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC155606A900
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KvLCaRKI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfbswzaD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7dKsu59FtDy8aNyG4WRUkN7aPYhsNBybpSNJpPGyZ1Y=; b=KvLCaRKIIRvam6
	Rpv/xs3WntoSMnMRB0Vspu2lUoDroiGD/Jjwkhf30QvURXauXcA2X+DRxAb+lpFOHB1sSUEWGEcZY
	C9b8ok6oiAZN18tJA5E1RKmLXRfI+VZjarQcC6gkedIwTODNWxVVhuAOvDtTEX/1HHCha3NnHt2lu
	MKyk8wAMBSetbH+tNUmdSmFtIndwmv5CEzle2MKTKH7cKPkYkB3oq8Q8e2mQFxrheoDOdbLJWtP/y
	9wUJt9R/i/ZNmCd0zQv2Sz8ldWLvYd+uNzvVe1QEmmIcTjgF96F/RKVwZIMEDtufp6NFlcz3UGldl
	Gja9SDKoVnyHWF4G5P2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeoG-00000006DVR-2Z9f;
	Wed, 04 Nov 2026 17:30:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeoF-00000006DUi-3HBa;
	Wed, 04 Nov 2026 17:30:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3BE0D60A95;
	Wed,  4 Nov 2026 17:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E771F00919;
	Wed,  4 Nov 2026 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813402;
	bh=7dKsu59FtDy8aNyG4WRUkN7aPYhsNBybpSNJpPGyZ1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gfbswzaDVBU7GKHdo96TauMKv1ceaJJyNilcKhGi1iENsVgvyZyYNALew+6JI6AWe
	 pnCrSRXKJFZI76CSsVO2k0ZfaudiGPDz4H6nanxp+IyJlIS7zpWq7WbGYIpqXvffaY
	 YPXkZIViE9ginAIsagyAOsm2dADTElAlSFhpb7mW7+aUif42uY6NuovJjFCkr22t+o
	 8YZgU+wGhNeEvlg8uYowdA2V5/tkllZe4obLrFZwBz6wKkhavF4aJ1MAwudrDBYgmg
	 iqyQouJN+3c3V4Q9h3e+svUJCBV88Hc0/UG53sSExSaEIpQZoLXQ7yhOlSnC5s6p6e
	 /vqOf39HCSJtQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:23 +0100
Subject: [PATCH v2 06/51] powerpc/pseries: put the node that the ofdt
 property commands look up
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-work-procfs-bugfixes-v2-6-bbf7d5546809@kernel.org>
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
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9GgvRCMv4/Dc1Z942cy3A7/ul6cTW5I084eAKnASIT8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zmZ4quyyZkXDnPt7l06dpyFV4qG0w25zxJ4t0hO4d
 EKlP1YEd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykTo6R4ULmC811i1exrd39
 SCDIqSZw/sIzLju3fTqjXqriV5H7NIjhf6qrTt6RLRKL95YYMKbV3Ltr0FNg0RZ8ear5gYvqs+r
 mMQEA
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

parse_node() looks the node up with of_find_node_by_phandle(), which
returns it with a reference, and do_add_property(),
do_remove_property() and do_update_property() never put that
reference. Every property command written to /proc/powerpc/ofdt leaks
one. Put it when the command is done.

Fixes: 610d91511f99 ("[PATCH] powerpc: Add support for changing properties from userspace")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/reconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 18e3f1a036e3..5a0c9c0b6253 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -271,8 +271,8 @@ static char *parse_node(char *buf, size_t bufsize, struct device_node **npp)
 
 static int do_add_property(char *buf, size_t bufsize)
 {
+	struct device_node *np __free(device_node) = NULL;
 	struct property *prop = NULL;
-	struct device_node *np;
 	unsigned char *value;
 	char *name, *end;
 	int length;
@@ -296,7 +296,7 @@ static int do_add_property(char *buf, size_t bufsize)
 
 static int do_remove_property(char *buf, size_t bufsize)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 	char *tmp;
 	buf = parse_node(buf, bufsize, &np);
 
@@ -315,7 +315,7 @@ static int do_remove_property(char *buf, size_t bufsize)
 
 static int do_update_property(char *buf, size_t bufsize)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 	unsigned char *value;
 	char *name, *end, *next_prop;
 	int length;

-- 
2.53.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B954BC77B7C
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LZhoaDwOM9ynPauz4tzgWhbqgywo6frZ411ySKhNULg=; b=5G5rQdVYL/9WzU
	7l8MQBgX0o04A+z9gyo58T+eHtfpJTGlqfEI6r1HEcp+h1/8zd4nNqo+QQUjOz7+bAHm8u6HcT1/m
	tq+uDT5ulvC95tg5Jgf92MQZm9KSTbwaR5gJ97lplfv9l3hcJugQJolKsc68pocln3xe3mOSl2kTi
	qagiucEtVWrDuTLDvAus2mrsRcnYoBFX7dUaGEkY3bqo1iUQUsPz0bczANAa8KGudVezF1JYTVsml
	+cXwwIzjXZDSxv690kEYpoKMQsThfO12BsbgZi8D84A042BNGOBn7UvKw1fAqVnVIwTLDSr8Q2Pxy
	Tu0s8A6RzV4Bc20fB8zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpVG-00Gvc6-2A;
	Mon, 08 May 2023 01:17:26 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpV7-00GvZ4-32;
	Mon, 08 May 2023 01:17:17 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@infradead.org,
	djwong@kernel.org,
	sandeen@sandeen.net,
	song@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jikos@kernel.org,
	bvanassche@acm.org,
	ebiederm@xmission.com
Cc: mchehab@kernel.org,
	keescook@chromium.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/6] fs: move !SB_BORN check early on freeze and add for thaw
Date: Sun,  7 May 2023 18:17:15 -0700
Message-Id: <20230508011717.4034511-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
MIME-Version: 1.0
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The SB_BORN flag added on vfs_get_tree() when a filesystem is about to be
mounted. If a super_block lacks this flag there's nothing to do for that
filesystem in terms of freezing or thawing.

In subsequent patches support will be added to allow detecting failures for
iterating over all super_blocks and freezing or thawing. Although that
functionality will be be skipped when sb->s_bdi == &noop_backing_dev_info,
and so SB_BORN will not be set, since we already check for SB_BORN on
freeze just move that up earlier and to be consistent do the same on
thaw too. We do this as these are user facing APIs, and although it
would be incorrect to issue a freeze on a non-mounted sb, it is even
stranger to get -EBUSY.

Be consistent about this and bail early for !SB_BORN for freeze and thaw
without failing.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 16ccbb9dd230..28c633b81f8f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1678,12 +1678,13 @@ int freeze_super(struct super_block *sb, bool usercall)
 	if (!usercall && sb_is_frozen(sb))
 		return 0;
 
+	/* If the filesystem was not going to be mounted there is nothing to do */
+	if (!(sb->s_flags & SB_BORN))
+		return 0;
+
 	if (!sb_is_unfrozen(sb))
 		return -EBUSY;
 
-	if (!(sb->s_flags & SB_BORN))
-		return 0;	/* sic - it's "nothing to do" */
-
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
@@ -1761,6 +1762,10 @@ int thaw_super(struct super_block *sb, bool usercall)
 			return 0;
 	}
 
+	/* If the filesystem was not going to be mounted there is nothing to do */
+	if (!(sb->s_flags & SB_BORN))
+		return 0;
+
 	if (!sb_is_frozen(sb))
 		return -EINVAL;
 
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

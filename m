Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96959C77B7C
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 01:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hxSAsULXvz6N7J/4EZhOiGJSOAEIF6fCaS6mBVBUK7E=; b=l6m04b8hZyIO6f
	TZh/kdgOmc6zbHrHswrm/lr8DMgvXebGLp9lSBtQba3IGyenQOEtaisG1u3Nq7kPjmJQvONPDnKgQ
	xd6tp64FgLSJ2EmPuHNWpBgXfYznEWhL+OHUZVztG9+rvkboNw98tpXICS6kj2SWXivZCeCihmUSu
	7P8KOddnscQqK1aESn+17UHrS8fZkdaxB0PY1PXUMnba4noy8yuY5EwpkDFq1ndxaN19r2LSGV3yy
	ooUaVEMooIcbeGAxmQVMt+56Gm6GhT0QX5h/CisHYR9IQ5yygU3AtKQiBt2BQTyEi3jt6W2hM+FAu
	zia4IZwmkXmVioUBL1ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpXF-00Gw9T-2W;
	Mon, 08 May 2023 01:19:29 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpXE-00Gw8M-18;
	Mon, 08 May 2023 01:19:28 +0000
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
Subject: [PATCH 0/3] filesystems: start removal of the kthread freezer
Date: Sun,  7 May 2023 18:19:24 -0700
Message-Id: <20230508011927.4036707-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Here's 3 filesystems converted over to remove the kthread freezer.

Luis Chamberlain (3):
  ext4: replace kthread freezing with auto fs freezing
  btrfs: replace kthread freezing with auto fs freezing
  xfs: replace kthread freezing with auto fs freezing

 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/super.c       |  4 ++--
 fs/ext4/super.c        |  9 +++------
 fs/xfs/xfs_log.c       |  3 +--
 fs/xfs/xfs_log_cil.c   |  2 +-
 fs/xfs/xfs_mru_cache.c |  2 +-
 fs/xfs/xfs_pwork.c     |  2 +-
 fs/xfs/xfs_super.c     | 16 ++++++++--------
 fs/xfs/xfs_trans_ail.c |  3 ---
 10 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

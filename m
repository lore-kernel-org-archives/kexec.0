Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF12C7EE22
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uajH74NCekDUMXKBA6a/M6e+WHM1sbEeRudA5MZbZfA=; b=XTvzkpeuh3KD5d
	4MKD/qfTwc2RbjNhBdJAM0S9Yn2823aFmTTaDj0ciDKZn0XZUn3dP9tQAW+vxhN29zhy3HaSf8K+4
	5/+1pU6o8CcFh8jR+BrLlzUuP/h2CnPROiblyFPnCkb9Z4+PwOztFJ5uFyfNWrbaDPRiQrE+Viu1S
	TsYzAj2Gxz2z+Q9s/uh2uh65ysnSjn58Igpolr3TiW/bJz1KK9TwBLbln7vBA58JPvS0lPZ4bDZh6
	Nh2I5stntSdn+uPItVWeQYbyuj2mX3N3LCILR7slKyvr3FOFSatViTAhDz8DdF2HkuTitGV/9DQub
	+konz7qBo+rebkU10DsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpVH-00GvcS-0U;
	Mon, 08 May 2023 01:17:27 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpV7-00GvYw-2V;
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
Subject: [PATCH 0/6] vfs: provide automatic kernel freeze / resume 
Date: Sun,  7 May 2023 18:17:11 -0700
Message-Id: <20230508011717.4034511-1-mcgrof@kernel.org>
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

It's been about 5 months since the last v3 RFC for fs freeze. Now
that some of us will have time at LSFMM to discuss stuff I figured
it would be good to try to get the last pieces, if any discussed,
and put out a new patch set based on the latests feedback. This
time I boot tested, and stress tested the patches. From what I can
tell I confirm nothing regresses, we just end up now with a new world
where if your platform does support s3  / s4 we'll kick into gear the
automatic kernel freeze.

To help with testing, as this is a rather tiny bit obscure area with
virtualization, I've gone ahead and extended kdevops with support for
always enabling s3 / s4, so it should be easy to test guest bring up
there.

I've picked out using stress-ng now to have fun stress testing suspend,
the insane will try:

./stress-ng --touch 8192 --touch-method creat

Resume works but eventually suspend will trickle tons of OOMs and so
we gotta find a sweet spot to automate this somehow in fstests somehow.
I am not sure how we're gonna test this moving forward on fstests but
perhaps worth talking about at LSFMM for ideas.

Anyway, your filesystem will not participate in the auto kernel
freeze / thaw unless your filesystem gets the kthread freezer junk
removed and sets a flag. I'll post 3 patches for the 3 main filesystems
after this. I've carried and advanced the SmPL patch for a few years
now, and magically it all still works.

[0] https://lkml.kernel.org/r/20230114003409.1168311-1-mcgrof@kernel.org

Luis Chamberlain (6):
  fs: unify locking semantics for fs freeze / thaw
  fs: add frozen sb state helpers
  fs: distinguish between user initiated freeze and kernel initiated
    freeze
  fs: move !SB_BORN check early on freeze and add for thaw
  fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
  fs: add automatic kernel fs freeze / thaw and remove kthread freezing

 block/bdev.c           |   9 +-
 fs/ext4/ext4_jbd2.c    |   2 +-
 fs/f2fs/gc.c           |   9 +-
 fs/gfs2/glops.c        |   2 +-
 fs/gfs2/super.c        |  11 +-
 fs/gfs2/sys.c          |  12 ++-
 fs/gfs2/util.c         |   7 +-
 fs/ioctl.c             |  14 ++-
 fs/quota/quota.c       |   4 +-
 fs/super.c             | 239 +++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_trans.c     |   3 +-
 include/linux/fs.h     |  54 +++++++++-
 kernel/power/process.c |  15 ++-
 13 files changed, 313 insertions(+), 68 deletions(-)

-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

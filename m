Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B1C54EBE
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 01:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6Y/KfGA1u/Ysk8mP0WUE8/wjMUv9QF8a0GDHLxmYmkY=; b=NKssahr0PMzQLK
	6npw+DR1b6ExtYNWhCl+Delk3Vv6QC1N9d97ukwi0ssS1TvpM2PgfKB7fRfaojZUvSvqxGRFAhmsR
	YFyfnFWUXsGseqUCZ3QoGCCDdCFgB+4FK/NCp9u8yPmLgLqwUvFzUZi6ocjfVFNdWr2gEfc5XbhXO
	Ry1tYROrEcLxz1MJ/0UROsNa2qzOKPRBzJUuKvxgGwZ299NAE2cl84UDz0GpMpnFTUiqcjeCpPXQl
	ghfDVf8ZjPPupAAp8wXdXbw8oC7/LHJrGavvprTzfrxskRQi/uXxcMbVscu/Iy5tbPiSoqvxAxlwQ
	3ONGcR5w49SCJY5Q+Z5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVcj-0050Te-6h; Sat, 14 Jan 2023 01:46:21 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUUs-004tvv-Pm; Sat, 14 Jan 2023 00:34:10 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@infradead.org,
	djwong@kernel.org,
	song@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	bvanassche@acm.org,
	ebiederm@xmission.com
Cc: mchehab@kernel.org,
	keescook@chromium.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 00/24] vfs: provide automatic kernel freeze / resume 
Date: Fri, 13 Jan 2023 16:33:45 -0800
Message-Id: <20230114003409.1168311-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
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

Darrick J. Wong poked me about the status of the fs freez work, he's
right, it's been too long since the last spin. The last v2 attempt happened
in April 2021 [0], this just takes the feedback from Christoph and spins it
again. I've only done basic build tests on x86_64, and haven't yet run time
tested the stuff, but given the size of this set its better to review early
before getting stuck on details. So this is what I've ended up with so far.

Please help me paint the bike shed, and figure out the stuff perhaps
I had not considered yet. The locking stuff is really the important thing
here.

I'd like to re-iterate that tons of areas of the kernel are using the
kthread freezer stuff for things it probably has no reason to use it, so
once we remove this from the fs, it should be easy to start trimming this
from other parts of the kernel. The kthread freezer stuff was put in place
originally stop IO in flight for fs. Other parts of the kernels should
have no business using this stuff after all this work is done.

[0] https://lore.kernel.org/all/20210417001026.23858-1-mcgrof@kernel.org/

Changes since the last v2:
  * instead of having different semantics for lock / unlocked freeze
    and thaw calls, this unifies the semantics by requiring the lock
    prior to freeze / thaw
  * uses grab_active_super() now in all all places which need to freeze
    or thaw, this includes filesystems, this is to match the locking
    requirements, and so to not add new heuristics over defining if the
    superblock might be in a good state for freeze/thaw.
  * drops SB_FREEZE_COMPLETE_AUTO in favor of just checking for a flag
    to be able to determine if userspace initiated the freeze or if its
    auto (by the kernel pm)
  * folded the pm calls for the VFS so that instead of one call which
    has a one-liner with two routines, we use the same one-liner on the
    pm side of things.
  * split the FS stuff by using a enw temporary flag, so to enable
    easier review of the FS changes
  * more filesystems use the freezer API now so this also converts them
    over
  * adjusted the coccinelle rule to use the new flag and in the end
    removes it

This is all here too:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20231010-fs-freeze-v5

Luis Chamberlain (24):
  fs: unify locking semantics for fs freeze / thaw
  fs: add frozen sb state helpers
  fs: distinguish between user initiated freeze and kernel initiated
    freeze
  fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
  fs: add automatic kernel fs freeze / thaw and remove kthread freezing
  xfs: replace kthread freezing with auto fs freezing
  btrfs: replace kthread freezing with auto fs freezing
  ext4: replace kthread freezing with auto fs freezing
  f2fs: replace kthread freezing with auto fs freezing
  cifs: replace kthread freezing with auto fs freezing
  gfs2: replace kthread freezing with auto fs freezing
  jfs: replace kthread freezing with auto fs freezing
  nilfs2: replace kthread freezing with auto fs freezing
  nfs: replace kthread freezing with auto fs freezing
  nfsd: replace kthread freezing with auto fs freezing
  ubifs: replace kthread freezing with auto fs freezing
  ksmbd: replace kthread freezing with auto fs freezing
  jffs2: replace kthread freezing with auto fs freezing
  jbd2: replace kthread freezing with auto fs freezing
  coredump: drop freezer usage
  ecryptfs: replace kthread freezing with auto fs freezing
  fscache: replace kthread freezing with auto fs freezing
  lockd: replace kthread freezing with auto fs freezing
  fs: remove FS_AUTOFREEZE

 block/bdev.c             |   9 +-
 fs/btrfs/disk-io.c       |   4 +-
 fs/btrfs/scrub.c         |   2 +-
 fs/cifs/cifsfs.c         |  10 +-
 fs/cifs/connect.c        |   8 --
 fs/cifs/dfs_cache.c      |   2 +-
 fs/coredump.c            |   2 +-
 fs/ecryptfs/kthread.c    |   1 -
 fs/ext4/ext4_jbd2.c      |   2 +-
 fs/ext4/super.c          |   3 -
 fs/f2fs/gc.c             |  12 +-
 fs/f2fs/segment.c        |   6 +-
 fs/fscache/main.c        |   2 +-
 fs/gfs2/glock.c          |   6 +-
 fs/gfs2/glops.c          |   2 +-
 fs/gfs2/log.c            |   2 -
 fs/gfs2/main.c           |   4 +-
 fs/gfs2/quota.c          |   2 -
 fs/gfs2/super.c          |  11 +-
 fs/gfs2/sys.c            |  12 +-
 fs/gfs2/util.c           |   7 +-
 fs/ioctl.c               |  14 ++-
 fs/jbd2/journal.c        |  54 ++++-----
 fs/jffs2/background.c    |   3 +-
 fs/jfs/jfs_logmgr.c      |  11 +-
 fs/jfs/jfs_txnmgr.c      |  31 ++----
 fs/ksmbd/connection.c    |   3 -
 fs/ksmbd/transport_tcp.c |   2 -
 fs/lockd/clntproc.c      |   1 -
 fs/lockd/svc.c           |   3 -
 fs/nfs/callback.c        |   4 -
 fs/nfsd/nfssvc.c         |   2 -
 fs/nilfs2/segment.c      |  48 ++++----
 fs/quota/quota.c         |   4 +-
 fs/super.c               | 232 ++++++++++++++++++++++++++++++++-------
 fs/ubifs/commit.c        |   4 -
 fs/xfs/xfs_log.c         |   3 +-
 fs/xfs/xfs_log_cil.c     |   2 +-
 fs/xfs/xfs_mru_cache.c   |   2 +-
 fs/xfs/xfs_pwork.c       |   2 +-
 fs/xfs/xfs_super.c       |  14 +--
 fs/xfs/xfs_trans.c       |   3 +-
 fs/xfs/xfs_trans_ail.c   |   3 -
 include/linux/fs.h       |  53 ++++++++-
 kernel/power/process.c   |  15 ++-
 45 files changed, 393 insertions(+), 229 deletions(-)

-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

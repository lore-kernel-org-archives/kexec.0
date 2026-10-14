Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FC2CA9EBD
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 03:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=js/e1ndjE4YknrvPw7rPrmCq/UssefpiXbufbqKGf20=; b=jrtH0swqrt/4wvB65HVFydHoPt
	/VUMScgnB5hoIQgbOIjpTxOjMhVQ0sGMiPz7dPzwBNiXc0Ga7zcT0mhGm38lQYM4nLsKvUEk+7GXr
	QihuHVgy7osUyvbO2FEJy84RskIES6v02ECa4CaWj+DLQ/ZiD7+5e2Rb75fJ6y1xm9OyJVVMXr2XT
	ap2Fq3Ail0riz46WcgFsajcVpcUYTu9J4Sb84uX1Ixj9Us4m/3yWFF+ZIqppWElmve9U63JeRmVMR
	oDhmAtqYInnzcbA8EFJ3eO7oikugZL69LNlTdAdKVcl0/QUG/DS11xkYpWwlOwcCY/SqTL08kepwk
	uh05rYQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGq3M-0000000ESYk-3bog;
	Wed, 14 Oct 2026 03:53:20 +0000
Received: from m16.mail.163.com ([117.135.210.3])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGq3K-0000000ESXS-0Vrj
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 03:53:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=js
	/e1ndjE4YknrvPw7rPrmCq/UssefpiXbufbqKGf20=; b=ZQbRvVAjWcwUXEIzj8
	mbo36WFaiGadHLgyGEsd4wNmgHabubfyPGd5XA9O1B+Ag0LuQFXRw3Egvyp8zlq8
	0tfUwN9xnFfJC4jdhCPHdVaUAC8NPQTrCs83AO+7PBN4u3DWkiaNI2pU+YRPTZut
	eSuWscwxY84i4rUg5crr5g0dA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBncnaF_M5qUtfjEQ--.37990S2;
	Wed, 14 Oct 2026 11:52:38 +0800 (CST)
From: Haolong Wang <18766350203@163.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] mm/memfd_luo: preserve the sealed exec-bit state; reject kernel-private shmem files
Date: Wed, 14 Oct 2026 11:52:25 +0800
Message-ID: <20261014035228.473825-1-18766350203@163.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgBncnaF_M5qUtfjEQ--.37990S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw47Zr18Cr18KFWrZw1rXrb_yoW3AFW7pr
	Z8Kwn8Cw4kGFyIv3yxAw10vFyrAw4fAF4YgrsFgr18Can8WFnIqFyI9a4j9FyUArsaga42
	qF4Uury8Ca1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFE__UUUUU=
X-Originating-IP: [2408:8418:c22:8000:1bbd:2550:438b:167e]
X-CM-SenderInfo: jpryllawtvijiqt6il2tof0z/xtbC1Aivd2rO-IhOZgAA38
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_205318_537978_814D6DBC 
X-CRM114-Status: GOOD (  24.70  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Previous revisions:
  https://lore.kernel.org/all/20261014003558.357783-1-18766350203@163.com/
  https://lore.kernel.org/all/20261014031254.432582-1-18766350203@163.com/

Sashiko reviewed v2: the folio-release patch came back clean ("no issues.
It looks great!"), while the exec-bit patch got one report that holds up.
The handler's can_preserve() accepts any unlinked shmem file, and SysV SHM
segments are unlinked shmem files -- a segment descriptor obtained through
/proc/<pid>/map_files/ goes straight into the preservation path.  That
matters because preservation updates shmem_inode_info.flags under the inode
lock, while SHM_LOCK and SHM_UNLOCK update SHMEM_F_LOCKED in the same word
through shmem_lock(), serialized by ipc_lock_object() instead: two
read-modify-write cycles on one word with no common lock, so either the
frozen bits or SHMEM_F_LOCKED can be lost.  The mismatch is older than this
series (the pre-existing SHMEM_F_MAPPING_FROZEN bit has it too), so v3
starts with a small preparatory patch that rejects kernel-private
(S_PRIVATE) shmem inodes; real memfds are created without that flag.  The
other two patches are unchanged from v2.

Patch 1 is the new one: can_preserve() now also requires
!IS_PRIVATE(inode).  shmem_kernel_file_setup() is what marks kernel-private
objects, which covers SysV SHM, big_key payloads, the XFS buffer and scrub
files and the anonymous /dev/zero mapping file, so the check drops exactly
those.  It deliberately does not narrow the handler to memfd_create()
objects: unlinked non-private shmem files stay eligible, they are simply
not part of the race, because SHMEM_F_LOCKED is only maintained for SysV
segments.

Patch 2 carries the user/group/other execute bits in the record and takes
the final sample -- execute mask, seals and file position -- in freeze()
under the inode lock, freezing that state against shmem_setattr(),
shmem_set_acl() and memfd_add_seals() until the transition is committed or
rolled back, and it rejects records with flag bits this version does not
know.  The record version becomes "memfd-v3" and a read-only "memfd-v2"
reader is registered next to it.

Patch 3 releases the preserved folios when retrieve() fails, by sharing the
cleanup with memfd_luo_finish().  It predates the exec-bit work and carries
a Fixes tag of its own.

Changes since v2:
 - new patch 1/3: reject S_PRIVATE shmem inodes in can_preserve(), which
   removes the handler's exposure to the flags read-modify-write race with
   SHMEM_F_LOCKED (reported by Sashiko AI review)
 - patch 2/3 and 3/3 are unchanged from v2

Changes since v1:
 - Record the user/group/other execute bits separately instead of one "some
   execute bit was set" flag: an execute mask of 0100 was restored as 0111,
   inverting the guarantee this series is about.
 - Take the final sample of the execute mask and the seals in freeze(),
   under the inode lock, and freeze that state for the rest of the
   transition.
 - Reject records with flag bits this version does not know.
 - Bump the record version to "memfd-v3" and keep reading "memfd-v2"
   records through a read-only handler.
 - Release the preserved folios when retrieve() fails (now patch 3/3).
 - selftest: an execute mask of 0100 with its full 0x3e seal set, a memfd
   without execute bits (MFD_NOEXEC_SEAL: mask 0000, seal set 0x20, still
   writable), and a skip when vm.memfd_noexec forbids MFD_EXEC.

On record versions.  The flags cannot tell "the execute bits were clear"
apart from "the writer did not know about the flags", so records written
before the flags existed have to be told apart by the version string, which
is compared with strcmp().  The version is therefore bumped and a read-only
handler for "memfd-v2" is registered next to the current one:

  record writer   reading kernel and handler     result
  old v2          old kernel, v2 handler         default executable mode
  old v2          new kernel, legacy v2 reader   no execute bits
  new v3          new kernel, v3 handler         exact exec mask and seals
  new v3          old kernel                     no handler, -ENOENT

The legacy handler only reads records written by an older kernel: its
.can_preserve() always returns false, so it is never selected for an
outgoing preservation and every new record is serialized as "memfd-v3"; a
"memfd-v3" record is never handed to it either, because the compatible
strings have to match exactly.  If registration of the legacy v2 reader
fails, the already registered v3 handler is unregistered as well, so the
kernel never ends up with only one of the two handlers registered.

Row two is a one-time behaviour change for records written by a kernel
without these flags: an executable memfd preserved by such a kernel comes
back without execute bits.  That is the safe reading, but it is not what
the old reader did -- it never looked at the flags at all, it restored the
default (executable) mode -- so the change applies to every such record,
not only to the ones that were sealed with F_SEAL_EXEC.  Without the
version bump an old kernel would instead read a new record, ignore the
flags and restore the default executable mode, undoing exactly the
guarantee this series restores; with "memfd-v3" it has no matching handler
at all, so the deserialization of that session fails with -ENOENT instead
of the memfd being restored wrongly.

Two things I could not close here, both written down in the patches:

 - f_pos can still change after freeze().  The LUO file API has no global
   userspace quiescence before .freeze() runs, so this needs a
   framework-level answer rather than a memfd one.
 - If kho_restore_vmalloc() fails, the folio array cannot be walked and the
   folios stay reserved; that API is not failure-atomic and cannot be
   retried after a partial failure.  A KHO-side fix or an allocation-free
   discard/iterator API would close it.

Testing:
 - the kernel builds from this tree with the liveupdate selftest config
   (plus TMPFS_POSIX_ACL and TMPFS_XATTR, so that the new ACL path is
   compiled); mm/memfd_luo.o, mm/shmem.o and mm/memfd.o build without
   warnings
 - QEMU live-update round trip (preserve -> kexec -> retrieve) with the new
   selftest, on a kernel built from this revision: PASSED -- the memfd with
   execute mask 0100 and seal set 0x3e comes back with the same mask and
   seal set, and the memfd without execute bits comes back with mask 0000,
   seal set 0x20, data intact and writable
 - the same test against a kernel without the exec-bit change: "execute
   mask changed across kexec: 0111 != 0100"
 - the admission patch, measured on the same tree with
   CONFIG_CHECKPOINT_RESTORE and CONFIG_SYSVIPC enabled so that a SysV
   segment descriptor is reachable (memfd_luo is the only file handler
   registered in that configuration):

     kernel                SysV SHM fd        memfd     unlinked tmpfs
     without patch 1/3     accepted (0)       accepted  accepted
     with patch 1/3        -ENOENT (errno 2)  accepted  accepted

   the segment descriptor comes from /proc/self/map_files and reads back as
   "/SYSV00000000 (deleted)"; the memfd and the unlinked tmpfs file are the
   controls that show the ioctl path still works and that the check is
   limited to kernel-private files
 - checkpatch.pl --strict on the series: 0 errors, 0 warnings
 - not covered by the run: the freeze-time rejection (it happens inside the
   reboot() path, so userspace cannot observe it) and the ACL path at
   runtime

Haolong Wang (3):
  mm/memfd_luo: reject kernel-private shmem files
  mm/memfd_luo: carry the sealed exec-bit state in the preserved record
  mm/memfd_luo: release preserved folios when retrieve fails

 include/linux/kho/abi/memfd.h                 |  24 +-
 include/linux/shmem_fs.h                      |  20 ++
 mm/memfd.c                                    |   6 +
 mm/memfd_luo.c                                | 247 +++++++++++++++---
 mm/shmem.c                                    |  35 ++-
 .../selftests/liveupdate/luo_kexec_simple.c   | 208 +++++++++++++++
 6 files changed, 496 insertions(+), 44 deletions(-)

-- 
2.56.0



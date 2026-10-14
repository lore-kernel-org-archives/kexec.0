Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F5ACC6B1C
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 03:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GQ2NJ+XFehaoUKQh9K8T656Nb9kxKH0kwaVt8iqHl4=; b=LTVTDrEYEe2VPBMFCyBeEB7PAN
	R6L7BLqmRC058i3Ae+qH+xU57wmGapnMHIpBbhmiWo8jbF54dWOF5YCmw55lEr7vBAX1BIoyt/hBq
	pHt4wJe+a2SmixqsPn3/+4OZJTB78qMGn+I5KMpgkbD7eiTilK0wkycsZ/O1SAAoNvvpR3YQnPeVN
	JGoo5g4lwYqt+crwZwUtWvED6YY3BKNRtMPtyV5bJYNia8bYUqZzSyjIxjAy7qwWzZzZfuU4XG/de
	COtDW55pSUwa2q5PBbQi0YXI2MhIuBNf02NJp3t+Ekj0GFomwos7O7KBc3tggiZHX9ks2finfMpnR
	LwJDSCOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpQd-0000000EPpQ-41Mm;
	Wed, 14 Oct 2026 03:13:20 +0000
Received: from m16.mail.163.com ([117.135.210.4])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpQV-0000000EPof-2nHL
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 03:13:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7G
	Q2NJ+XFehaoUKQh9K8T656Nb9kxKH0kwaVt8iqHl4=; b=I/Ve6NtvlPGIqUL+ZA
	VubSUKBOj9Eh28JifaDZ2YLNsyeYTJB6el9RxdWWhxSUeyfcASGDdcSdR5iVAIDV
	bv15TNmCIUgBABh7MvzDaB61Bkmbe6cgRNx+WuvX8LKY7XAvnExoO1RyyBcrN2vo
	ti6xnEcYS9eTsWg/IGNcjw+Q8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB36cMq885qzbNoEA--.22532S2;
	Wed, 14 Oct 2026 11:12:43 +0800 (CST)
From: Haolong Wang <18766350203@163.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memfd_luo: carry the exec-bit state in the preserved record
Date: Wed, 14 Oct 2026 11:12:35 +0800
Message-ID: <20261014031235.432509-1-18766350203@163.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-170651@kernel.org>
References: <sashiko-outbox-170651@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgB36cMq885qzbNoEA--.22532S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4fJF13Gw48XrWfAr47Arb_yoWrtFyrpr
	Z8Kr1Yyw1kGa40vw4xZw1IqryrA3yIyF1rJFs8Kry7A3W5WF1SqFWFga4Y9FyUGrnaga42
	qa1j9348Za98Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uyq2_UUUUU=
X-Originating-IP: [2408:8418:c22:8000:1bbd:2550:438b:167e]
X-CM-SenderInfo: jpryllawtvijiqt6il2tof0z/xtbC1AxWHmrO8yxxJQAA3-
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_201315_446280_E2309780 
X-CRM114-Status: GOOD (  17.19  )
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

Thanks for the review.  Both findings were real.

On the exec-mode snapshot: the sample itself was atomic -- the mode is
read under inode_lock, in the same critical section that sets
SHMEM_F_MAPPING_FROZEN -- but it was taken far too early.  The frozen
mapping only rejects growing, shrinking and fallocate(); fchmod() of the
exec bits (until F_SEAL_EXEC is set) and F_ADD_SEALS are not checked on
that path at all, and freeze() refreshed only f_pos.  v2 closes this from
both ends: freeze() takes the final sample of the exec mask and the seals
under the inode lock and, in the same critical section, sets a new
SHMEM_F_SEAL_STATE_FROZEN inode flag before dropping the lock.  From
that point on shmem_setattr() rejects exec-bit changes, memfd_add_seals()
rejects new seals, and shmem_set_acl() rejects access-ACL updates.  The
flag is cleared by a new .unfreeze callback when the update is rolled
back, and defensively by unpreserve().

Two more things fell out of that work:

 - A single "some exec bit was set" flag was not enough: an execute mask
   of 0100 (mode 0700) came back as 0111, which is the inversion this
   series is about.  The record now carries the three execute bits
   separately, retrieve() restores the exact mask and rejects unknown flag
   bits, and luo_kexec_simple.c round-trips an execute mask of 0100 with
   its full 0x3e seal set, plus a memfd without execute bits
   (MFD_NOEXEC_SEAL: mask 0000, seal set 0x20, still writable), which is
   the state the original report was about.
 - An access ACL rewrites inode->i_mode without going through
   shmem_setattr(), so the frozen state has to cover that path too.
   Scope note: F_SEAL_EXEC itself is still bypassable by an access ACL
   write (posix_acl_update_mode() updates the mode directly, with no seal
   check anywhere on that path).  That is a pre-existing
   F_SEAL_EXEC/vm.memfd_noexec issue, deliberately not part of this
   series; I will report it separately with a minimal repro.

On the folio leak: also real.  retrieve() now releases the preserved
folios on every failure path by sharing the cleanup with
memfd_luo_finish().  The folio array is restored before the file is
allocated, so the later error paths (memfd_alloc_file(),
memfd_add_seals()) can release the folios directly instead of allocating
memory while already handling a failure, and memfd_luo_retrieve_folios()
takes ownership as soon as it runs, so nothing is released twice.  It
predates the exec-bit work, so it is a separate commit with a Fixes tag.

Two limitations I could not close here, both written down in the patches:

 - f_pos can still change after freeze().  The LUO file API has no global
   userspace quiescence before .freeze() runs, so this needs a
   framework-level answer rather than a memfd one.
 - If kho_restore_vmalloc() fails before consuming anything (for example
   its own kvmalloc() fails), the folio array cannot be walked at all and
   those folios stay reserved.  That API is not failure-atomic and cannot
   be retried after a partial failure, so it needs a KHO-side fix or an
   allocation-free discard/iterator API.

On record versions: the record is now written as "memfd-v3", and a
read-only "memfd-v2" handler is registered next to it.  The compatible
strings are matched exactly, so the matrix is:

  record writer   reading kernel and handler     result
  old v2          old kernel, v2 handler         default executable mode
  old v2          new kernel, legacy v2 reader   no execute bits
  new v3          new kernel, v3 handler         exact exec mask and seals
  new v3          old kernel                     no handler, -ENOENT

Rows two and four are both behaviour changes, and neither direction is
interoperable: an executable memfd preserved by an older kernel comes back
without execute bits (row two -- the safe reading; the old reader never
looked at the flags, it restored the default executable mode), and a new
record handed to an older kernel finds no matching handler at all, so the
deserialization fails with -ENOENT instead of the memfd being restored as
executable again (row four, which is why the version is bumped).  The
legacy handler only reads records written by an older kernel: its
.can_preserve() always returns false, so an outgoing preservation is
always serialized as "memfd-v3".

v2 will follow as a separate thread.

Both changes are covered by a QEMU live-update run (preserve -> kexec ->
retrieve) with the liveupdate selftest: the memfd with execute mask 0100
and seal set 0x3e round-trips exactly, the memfd without execute bits
comes back with mask 0000, seal set 0x20 and still writable, and the same
test against a kernel without the change reports "execute mask changed
across kexec: 0111 != 0100".  The numbers are in the v2 cover letter.



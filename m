Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD19CC6B1C
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 03:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QgDLweGJbcN+p8LbKPcNn2/Fq8wZFtiysyyozTFsl6I=; b=xZGwBTrBY5FimYZZSTqKE9cQ2e
	JD54Bg+ZD7kq74tQkLhIUuLU+yukPp2kEbiTj6IfeIvODAdTz6cwyIiFpB7A1sxr7PymCsItnmltR
	v9ugqKi/IjzM13FtL7WypEiCl3I87Sf37SLla5l4CWXP5CDDzbVxY99EmJR98sIKjS5AX/zy429Nq
	U5RKXHPrihVqHrIm9c1GxbC0UPRyN7GJrMZhTFDmehtZESWMK4RbxPksya/xTx+xQet5ZABLOtnsT
	Nwz702InpquvplKjZBbyB6dBMin4rSfQIGbNyxtPZs34sqcKISi6HTqxKqmVmd9SuadlSTh2SvdLf
	Iu68ntbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpRM-0000000EPxT-3Gz5;
	Wed, 14 Oct 2026 03:14:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpRK-0000000EPws-3Yh8
	for kexec@bombadil.infradead.org;
	Wed, 14 Oct 2026 03:14:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=QgDLweGJbcN+p8LbKPcNn2/Fq8wZFtiysyyozTFsl6I=; b=fMdgaBo0wKIqljJ4VN1JaUmb22
	avIjoPacX0W8KR2L6bHE26ZVKRyrvE8DZ+oDNCIFctm1WWwKceRrerTFWAVWELnWA1VJNVvVwJo3o
	zXH+l3EChMmHO5/CXhl+fhQMM3t1UpVA4b5srcbs8QfgGbMTWdwUPXq9r2UGdIK6TN6mdcitI5/q+
	IdTYrSdHbLezDaG8J49v8+L6t3E1Zd0wvUsUV+ex29VpSrJ1ZJdn7npkixLNIfbDGVbnO/CQ33/73
	5QBt50hK6OQS07JEzGaOwCDwvawCX9EFjM+TZP54JTq8CqoCW6hCvaA0Ange99GjL9LRr5U4rhQew
	fphsusaA==;
Received: from m16.mail.163.com ([117.135.210.5])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGpRE-0000000GI8s-1asy
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 03:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Qg
	DLweGJbcN+p8LbKPcNn2/Fq8wZFtiysyyozTFsl6I=; b=nW27Ss9qtXLqBTup6y
	sOtw6aW0wluKo3t/4JSS/Vc46dypJka8JcZyuCjyYygWEpMV0TC080091e9V8USF
	JW4pzxXO3GXeiN0W4R4q9z+l6rifplFumQLZP+bj68IBMcbUGomUhxW1sNo+DtdT
	RKlrhCeVMv6whVNCyth/ZgvLc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD330I_885q6IC7Eg--.21712S2;
	Wed, 14 Oct 2026 11:13:04 +0800 (CST)
From: Haolong Wang <18766350203@163.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/memfd_luo: preserve the sealed exec-bit state; fix retrieve() leaks
Date: Wed, 14 Oct 2026 11:12:52 +0800
Message-ID: <20261014031254.432582-1-18766350203@163.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD330I_885q6IC7Eg--.21712S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw47Kw4xCFyfCw4DuF1xZrb_yoW7Zw1Dpr
	Z8Kwn8A34DGFyIvw47Zw4IvFyrA3yfJF45JrsrKry8Cay5WFnaqFyS9ayY9FyUAw1Sg3ZF
	vF4UCw18uayDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFE__UUUUU=
X-Originating-IP: [2408:8418:c22:8000:1bbd:2550:438b:167e]
X-CM-SenderInfo: jpryllawtvijiqt6il2tof0z/xtbC9gFbI2rO80FOCwAA3c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_041358_920705_17A6636D 
X-CRM114-Status: GOOD (  22.53  )
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

v1: https://lore.kernel.org/all/20261014003558.357783-1-18766350203@163.com/

Sashiko reviewed v1 and reported two issues, both of them real: the execute
bits were sampled long before the memfd stopped being usable, so the record
could be stale by the time it was handed to the next kernel, and retrieve()
leaked the preserved folios on its error paths.  Both are fixed here, together
with a third problem that the same reasoning exposes (the record carried a
single "some execute bit was set" flag, so a partially executable memfd was
restored with execute bits it never had).

Changes since v1:

 - Record the user/group/other execute bits separately instead of one "some
   execute bit was set" flag: an execute mask of 0100 was restored as 0111,
   inverting the guarantee this series is about.
 - Take the final sample of the execute mask and the seals in freeze(), under
   the inode lock, and freeze that state for the rest of the transition.
   shmem_setattr() (chmod), shmem_set_acl() (an access ACL rewrites the mode
   without going through shmem_setattr()) and memfd_add_seals() all reject
   changes from that point on, and a new .unfreeze callback clears the state
   when the update is rolled back.
 - Reject records with flag bits this version does not know.
 - Bump the record version to "memfd-v3" and keep reading "memfd-v2" records
   through a read-only handler, so that a record is never restored by a kernel
   that does not understand its flags.
 - Release the preserved folios when retrieve() fails, by sharing the cleanup
   with memfd_luo_finish().  This one predates the exec-bit work and is a
   separate patch with a Fixes tag.
 - selftest: an execute mask of 0100 with its full 0x3e seal set, a memfd
   without execute bits (MFD_NOEXEC_SEAL: mask 0000, seal set 0x20, still
   writable), and a skip when vm.memfd_noexec forbids MFD_EXEC.
 - Document the execute bits the record carries and the restrictions that
   apply once the update is committed to.

On record versions.  The flags cannot tell "the execute bits were clear" apart
from "the writer did not know about the flags", so records written before the
flags existed have to be told apart by the version string, which is compared
with strcmp().  The version is therefore bumped and a read-only handler for
"memfd-v2" is registered next to the current one:

  record writer   reading kernel and handler     result
  old v2          old kernel, v2 handler         default executable mode
  old v2          new kernel, legacy v2 reader   no execute bits
  new v3          new kernel, v3 handler         exact exec mask and seals
  new v3          old kernel                     no handler, -ENOENT

The legacy handler only reads records written by an older kernel: its
.can_preserve() always returns false, so it is never selected for an outgoing
preservation and every new record is serialized as "memfd-v3"; a "memfd-v3"
record is never handed to it either, because the compatible strings have to
match exactly.  If registration of the legacy v2 reader fails, the already
registered v3 handler is unregistered as well, so the kernel never ends up with
only one of the two handlers registered.

Row two is a one-time behaviour change for records written by a kernel without
these flags: an executable memfd preserved by such a kernel comes back without
execute bits.  That is the safe reading, but it is not what the old reader did
-- it never looked at the flags at all, it restored the default (executable)
mode -- so the change applies to every such record, not only to the ones that
were sealed with F_SEAL_EXEC.  Without the version bump an old kernel would
instead read a new record, ignore the flags and restore the default executable
mode, undoing exactly the guarantee this series restores; with "memfd-v3" it
has no matching handler at all, so the deserialization of that session fails
with -ENOENT instead of the memfd being restored wrongly.

Two things I could not close here, both written down in the patches:

 - f_pos can still change after freeze().  The LUO file API has no global
   userspace quiescence before .freeze() runs, so this needs a framework-level
   answer rather than a memfd one.
 - If kho_restore_vmalloc() fails, the folio array cannot be walked and the
   folios stay reserved; that API is not failure-atomic and cannot be retried
   after a partial failure.  A KHO-side fix or an allocation-free
   discard/iterator API would close it.

Testing:
 - the kernel builds from this tree with the liveupdate selftest config (plus
   TMPFS_POSIX_ACL/TMPFS_XATTR, so that the new ACL path is compiled);
   mm/memfd_luo.o, mm/shmem.o and mm/memfd.o build without warnings
 - QEMU live-update round trip (preserve -> kexec -> retrieve) with the new
   selftest: PASSED -- the memfd with execute mask 0100 and seal set 0x3e
   comes back with the same mask and seal set, and the memfd without execute
   bits comes back with mask 0000, seal set 0x20, data intact and writable
 - the same test against a kernel without this change: "execute mask changed
   across kexec: 0111 != 0100"
 - checkpatch.pl --strict on the series: 0 errors, 0 warnings
 - not covered by the run: the freeze-time rejection (it happens inside the
   reboot() path, so userspace cannot observe it) and the ACL path at runtime

Haolong Wang (2):
  mm/memfd_luo: carry the sealed exec-bit state in the preserved record
  mm/memfd_luo: release preserved folios when retrieve fails

 include/linux/kho/abi/memfd.h                 |  24 +-
 include/linux/shmem_fs.h                      |  20 ++
 mm/memfd.c                                    |   6 +
 mm/memfd_luo.c                                | 240 +++++++++++++++---
 mm/shmem.c                                    |  35 ++-
 .../selftests/liveupdate/luo_kexec_simple.c   | 208 +++++++++++++++
 6 files changed, 490 insertions(+), 43 deletions(-)


base-commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
-- 
2.56.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59514C53219
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 21:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=weL9cSnhARyHvpxmIUUADdy3slllDboHT4zVVeCC/vc=; b=OXLvfOD3V/YKWvTO9ypZ6SXDeR
	nkWgcKCB5ffZWcN+92qDB9KAFurlXHpWJyBPP5UxaJJo75UwHp6kRrUFitum4mvaPjpxcl9a36P8R
	9jlyMT33YSIUHAvlqcQ5cV7l/J4yLf+cQFX1uI+lKQbtmdlnrLOjyE/5GjRbU7DnKWFTvIBM/5mtL
	PVSsQSfZvLzUaBIbWiILBWTOto/foBPWOxiHRZtor793FhnUe9KquOzdtHobvp1NqpkaYU+rsmeav
	2GorSPWrNdV10mevfuGNCFxUyn8H8wBUE0B+B3Wlay+0hr6y76KF/7vl8g/YKB73OOmd9mrGjmrNJ
	7G9FTFoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnjZJ-00000000iIR-02sA;
	Sat, 25 Jul 2026 21:06:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnjZE-00000000iIK-2G9u
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 21:05:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9676260A91;
	Sat, 25 Jul 2026 21:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DFD1F000E9;
	Sat, 25 Jul 2026 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013554;
	bh=weL9cSnhARyHvpxmIUUADdy3slllDboHT4zVVeCC/vc=;
	h=From:To:Cc:Subject:Date;
	b=K+PVY6huvhgrRDyHRLiBH5YfjTXWPqU7zNgPDzB+6HOP8qLHnTSzTpLRpNKOjW72O
	 shvXHJiDIQksFCwvmaFhltPQgCF2kypDPKJgQWoCzRdI/Tqjs0xOgOHePWHQqORcgi
	 rXdSCH3Kv3+59e8PsvzywdOmAN01CUNtTuGJIqzYc80lZZPQ79/uTnnpDYk4NysMAB
	 +wN7ypp7wLddsRr0UnTWbA9sEdf7fDboRFrFB6vQhJERwHwSHHqFVxCA7FIfIsjvXg
	 aVLZYmPt9/6lEheogyw7MyO9vs75RDIniiOBl49do2BhpN63tawc3KSMAPWSFe5Tsq
	 qFH83/xxD7srQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	kexec@lists.infradead.org,
	driver-core@lists.linux.dev
Subject: [PATCH v2 0/3] mm,kernfs,proc: Unmap mmaps of removed files via file->f_mapping
Date: Sat, 25 Jul 2026 21:05:46 +0000
Message-ID: <20260725210549.3716546-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello,

The PCI resource files in sysfs and the /proc/bus/pci device files swap
their f_mapping to the shared iomem address space at open time, so that
revoke_iomem() can unmap userspace mappings when a driver claims a
region, see commit 636b21b50152 ("PCI: Revoke mappings like devmem").

Their VMAs are therefore attached to the shared address space, which
neither removal path reaches: kernfs_drain_open_files() unmaps the
sysfs inode's own mapping, which contains none of them, and
proc_entry_rundown() does not unmap anything at all.

As a result, userspace mappings of PCI BARs survive device removal,
and also survive a BAR resize on the sysfs side, keeping stale PTEs
into physical address space that the kernel may have reassigned since.
A mapping made before the device is removed still returns the previous
register value after the device has been released, through both
interfaces.

This series adds unmap_mapping_file(), which unmaps the pages of the
VMAs created through a given file, rather than a page offset window of
an address space, and then uses it in the kernfs drain and in the
procfs rundown.  Mappings of unrelated files on the shared address
space are left intact, and the claim-time revocation through
revoke_iomem() keeps working, as the VMAs stay on the shared address
space.

For kernfs this restores the behaviour these files had before
the f_mapping swap was introduced.  For procfs the unmapping is new
behaviour, which matches kernfs.  Besides /proc/bus/pci, only
/proc/vmcore, the ALSA information entries and /proc/powerpc/systemcfg
set a proc_mmap() hook.  Mappings of /proc/vmcore are now also removed
when the entry goes away, while the ALSA proc_mmap() hook calls a
per-entry callback that no entry implements, so these cannot be mapped.
The systemcfg entry has no proc_release() hook, so it is not tracked
and is not affected.

A BAR resize is covered by the same path on the sysfs side, as the
resize removes the resource groups and thus drains the open files.
Mappings of the same BAR made through /dev/mem are left alone, as
these are unmapped by physical range when a driver claims the region.

	Krzysztof

---
Changes in v2:
  https://lore.kernel.org/linux-pci/20260721185252.1670958-1-kwilczynski@kernel.org/

  - Moved the handling of files with and without a swapped f_mapping
    inside unmap_mapping_file(), so that callers no longer need to
    tell the two apart, as per David Hildenbrand's feedback.
  - Updated the kernel-doc for unmap_mapping_file() to describe
    unmapping folios within the VMAs, rather than unmapping the mmaps
    and VMAs themselves, as per David Hildenbrand's feedback.
  - Dropped the EXPORT_SYMBOL_GPL() for unmap_mapping_file(), as both
    callers are built-in and there is no modular user.
  - Added a should_zap_file_vma() helper to select the VMAs to zap,
    following the existing should_zap_cows() and should_zap_folio()
    convention.
  - Added a WARN_ON_ONCE() to skip HugeTLB VMAs, as zapping those
    takes i_mmap_rwsem for write in hugetlb_zap_begin() and would
    deadlock against the read lock held over the walk.
  - Added a cond_resched() to the walk, as the VMAs skipped by the
    filter do not reach the reschedule point in the zap path.
  - Added a new patch to unmap the mappings made through the
    /proc/bus/pci device files, as these also survive device removal,
    along with a new pde_is_removed() helper used to tell a rundown
    from a regular close().
  - Updated the commit logs across the series, so that each patch
    describes the f_mapping swap and its effect the same way.
  - Added the /proc/vmcore and ALSA maintainers to the list of
    recipients for visibility.

Krzysztof Wilczyński (3):
  mm: Add unmap_mapping_file() helper
  kernfs: Unmap mmaps of removed files via file->f_mapping
  proc: Unmap mmaps of removed files via file->f_mapping

 fs/kernfs/file.c   |  4 +---
 fs/proc/generic.c  |  4 ++--
 fs/proc/inode.c    |  2 ++
 fs/proc/internal.h |  5 +++++
 include/linux/mm.h |  2 ++
 mm/memory.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.55.0



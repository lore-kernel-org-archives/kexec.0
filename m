Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH2KC-0005jx-32
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 07:51:01 +0000
Received: by mail-pf1-f193.google.com with SMTP id a15-v6so3602099pfn.0
 for <kexec@lists.infradead.org>; Mon, 29 Oct 2018 00:50:49 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 0/2] makedumpfile: Allow 'info->page_offset' calc via
 VMCOREINFO in '/proc/kcore'
Date: Mon, 29 Oct 2018 13:20:29 +0530
Message-Id: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, Baoquan He <bhe@redhat.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>

This two patch series, tries to introduce an architecture independent
method to calculate the 'info->page_offset' value for x86_64
and arm64 architectures, by reading the VMCOREINFO note in
'/proc/kcore'.

Since linux kernel commit 23c85094fe1895caefdd
["proc/kcore: add vmcoreinfo note to /proc/kcore"]), '/proc/kcore'
contains a new PT_NOTE which carries the VMCOREINFO information.

If the same is available, one can use it in user-land to
retrieve machine specific symbols or strings being appended to the
vmcoreinfo even for live-debugging of the primary kernel as a
standard interface exposed by kernel for sharing machine specific
details with the user-land.

I understand that there might be some reservations about exporting
such machine-specific details in the vmcoreinfo, but to unify
the implementations across user-land and archs, perhaps this would be
good starting point to start a discussion.

Here are brief details of the patches in this patchset:
- PATCH 1/2: Calculates 'info->page_offset' for arm64 arch via
  vmcoreinfo note inside '/proc/kcore'.
- PATCH 2/2: Calculates 'info->page_offset' for x86_64 arch via
  vmcoreinfo note inside '/proc/kcore', thus fixing a makedumpfile
  '--mem-usage' breakage with latest kernels on x86_64.

Cc: Baoquan He <bhe@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>

Bhupesh Sharma (2):
  makedumpfile/arm64: Use VMCOREINFO inside '/proc/kcore' (if available)
  makedumpfile/x86_64: Add 'page_offset_base' reading capability from
    VMCOREINFO

 arch/arm64.c   | 114 +++++++++++++++++++++++++++++++++++++++++++--------------
 arch/x86_64.c  |  17 +++++++++
 makedumpfile.c |  69 +++++++++++++++++++++++++++++++---
 makedumpfile.h |   3 +-
 4 files changed, 169 insertions(+), 34 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

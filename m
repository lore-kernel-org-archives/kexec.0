Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjMEq-00011V-TC
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 08:37:30 +0000
Received: by mail-pf0-f176.google.com with SMTP id x66so20141564pfb.3
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 00:37:04 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v3 0/7] Fix --mem-usage /proc/kcore
Date: Thu,  2 Mar 2017 14:06:45 +0530
Message-Id: <cover.1488443170.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com


`makedumpfile --mem-usage /proc/kcore` has been broken after kaslr specific
modifications. Kernel commit commit 464920104bf7 (/proc/kcore: update
physical address for kcore ram and text) provides now valid physical
address for direct mapped regions and invalid (-1) for other areas.  This
helps to fix the issue in makedumpfile for both the case of kaslr enabled
and disabled.

Changes since v2:
 - Fixed a memory leak issue and updated man page and usage info
Changes since v1:
 - One more patch..Now mem-usage with older kernel (< 4.11) will only work
   when that has been rightly patched and -f has been used in makedumpfile
   command line.


Baoquan He (2):
  makedumpfile: Correct the calculation of kvaddr in
    set_kcore_vmcoreinfo
  makedumpfile: Discard process_dump_load

Pratyush Anand (5):
  show_mem_usage(): calculate page offset after elf load
  initial(): call cach_init() a bit early
  x86_64: check physical address in PT_LOAD for none direct mapped
    regions
  elf_info: kcore: check for invalid physical address
  mem-usage: allow to work only with -f for kernel version < 4.11

 arch/x86_64.c  |  6 ++++--
 elf_info.c     | 25 +++++--------------------
 makedumpfile.8 |  9 ++++++++-
 makedumpfile.c | 18 ++++++++++++------
 print_info.c   |  3 ++-
 5 files changed, 31 insertions(+), 30 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

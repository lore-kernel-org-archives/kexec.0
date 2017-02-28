Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ciaih-0006Wv-AF
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 05:53:10 +0000
Received: by mail-pf0-f173.google.com with SMTP id x66so1185172pfb.3
 for <kexec@lists.infradead.org>; Mon, 27 Feb 2017 21:52:45 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v2 0/7] Fix --mem-usage /proc/kcore
Date: Tue, 28 Feb 2017 11:22:34 +0530
Message-Id: <cover.1488260510.git.panand@redhat.com>
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
modifications. A kernel patch has been ACKed by Andrew Morton and has been
sent to Linus now [0]. This kernel patch helps to fix the issue for both
the case of kaslr enabled and disabled.

[0] http://marc.info/?l=linux-mm-commits&m=148823497215968&w=2

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
 makedumpfile.c | 18 ++++++++++++------
 3 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

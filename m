Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cai7j-000205-Ga
 for kexec@lists.infradead.org; Mon, 06 Feb 2017 12:10:25 +0000
Received: by mail-pg0-f49.google.com with SMTP id v184so28294580pgv.3
 for <kexec@lists.infradead.org>; Mon, 06 Feb 2017 04:10:03 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch 0/6] Fix --mem-usage /proc/kcore
Date: Mon,  6 Feb 2017 17:31:45 +0530
Message-Id: <cover.1486381805.git.panand@redhat.com>
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
modifications. I have proposed a kernel patch [0] which has been ACKed by
Andrew Morton and is available in next-2017020 now. Hopefully, it should be
part of upstream in v4.10 release. This kernel patch helps to fix this
issue for both the case of kaslr enabled and disabled.

To seek other's feedback, I am sending makedumpfile patches before kernel
patch hits upstream.

[0] http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?h=next-20170206&id=c9d4e5d7b7fd6c74e134ca44df8a5386efbc561c

Baoquan He (2):
  makedumpfile: Correct the calculation of kvaddr in
    set_kcore_vmcoreinfo
  makedumpfile: Discard process_dump_load

Pratyush Anand (4):
  show_mem_usage(): calculate page offset after elf load
  initial(): call cach_init() a bit early
  x86_64: check physical address in PT_LOAD for none direct mapped
    regions
  elf_info: kcore: check for invalid physical address

 arch/x86_64.c  |  6 ++++--
 elf_info.c     | 25 +++++--------------------
 makedumpfile.c | 12 ++++++------
 3 files changed, 15 insertions(+), 28 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

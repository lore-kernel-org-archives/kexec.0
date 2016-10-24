Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byiRM-0003NO-CG
 for kexec@lists.infradead.org; Mon, 24 Oct 2016 16:49:41 +0000
Received: by mail-qk0-f179.google.com with SMTP id w69so3500336qka.4
 for <kexec@lists.infradead.org>; Mon, 24 Oct 2016 09:49:15 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized base
 enabled
Date: Mon, 24 Oct 2016 22:18:41 +0530
Message-Id: <cover.1477327674.git.panand@redhat.com>
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

Patch 1/4 fixes page_offset calculation, so that it is correctly calculated
on KASLR enabled kernel as well.
Patch 2/4 simplifies VA to PA translation. New code has been benchmarked
against old code on a 4T system.
Patch 3/4 and 4/4 is removal of (now) unnecessary code.

I think, we should find a way to kill find_vememmap() as well, so that
VMEMMAP_START can be removed. I have very limited idea about x86, so unable
to do that as of now.

Pratyush Anand (4):
  x86_64: Calculate page_offset from pt_load
  x86_64: translate all VA to PA using page table values
  x86_64: kill is_vmalloc_addr_x86_64()
  x86_64: kill some unused initialization

 arch/x86_64.c  | 84 ++++++++++++++++++++--------------------------------------
 makedumpfile.h |  9 +++----
 2 files changed, 32 insertions(+), 61 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

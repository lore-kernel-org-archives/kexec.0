Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDhvT-0005ar-20
 for kexec@lists.infradead.org; Thu, 25 May 2017 01:50:56 +0000
Received: by mail-pf0-f181.google.com with SMTP id n23so152029665pfb.2
 for <kexec@lists.infradead.org>; Wed, 24 May 2017 18:50:34 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH v3 0/2] Fix refiltering when kaslr enabled
Date: Thu, 25 May 2017 07:20:27 +0530
Message-Id: <cover.1495619809.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, bhe@redhat.com, kexec@lists.infradead.org, xlpang@redhat.com, d.hatayama@jp.fujitsu.com, dyoung@redhat.com

Hi All,

We came across another failure in makedumpfile when kaslr is enabled. This
failure occurs when we try re-filtering. We try to erase some symbol from a
dumpfile which was copied/compressed from /proc/vmcore using makedumpfile.

We have very limited symbol information in vmcoreinfo. So symbols to be
erased may not be available in vmcoreinfo and we look for it in vmlinux.
However,  symbol address from vmlinux is a static address which differs
from run time address with KASLR_OFFSET. Therefore, reading any "virtual
address of vmlinux" from vmcore is not possible. 

These patches finds runtime  KASLR offset and then calculates run time
address of symbols read from vmlinux.

Hatayama Daisuke also found some issue [1] when he was working with a
sadump and virsh dump of a none kaslr kernel. Patch 2/2 of this series has
been improved to take care of those issues as well.

[1]http://lists.infradead.org/pipermail/kexec/2017-May/018833.html

Thanks

~Pratyush

v1->v2:
 - reading KERNELOFFSET from vmcoreinfo now instead of calculating it from
   _stext
v2->v3:
 - Fixed initialization of info->file_vmcoreinfo
 - Improved page_offset calculation logic to take care of different dump
   scenarios.


Pratyush Anand (2):
  makedumpfile: add runtime kaslr offset if it exists
  x86_64: calculate page_offset in case of re-filtering/sadump/virsh
    dump

 arch/x86_64.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 erase_info.c   |  1 +
 makedumpfile.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h | 16 +++++++++++++
 4 files changed, 135 insertions(+), 7 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

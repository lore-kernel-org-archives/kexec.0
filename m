Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d90X0-0002u0-0O
 for kexec@lists.infradead.org; Fri, 12 May 2017 02:42:16 +0000
Received: by mail-pf0-f172.google.com with SMTP id n23so17868461pfb.2
 for <kexec@lists.infradead.org>; Thu, 11 May 2017 19:41:48 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH v2 0/2] Fix refiltering when kaslr enabled
Date: Fri, 12 May 2017 08:11:36 +0530
Message-Id: <cover.1494556339.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com, xpang@redhat.com


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

Since, I am not an expert of x86, and these patches touch x86 part of
makedumpfile, therefore I have CCed x86 experts. Please, provide your
review comment and let me know if you think there could have been a better
way to resolve this issue.

thanks

~Pratyush

v1->v2:
 - reading KERNELOFFSET from vmcoreinfo now instead of calculating it from
   _stext

Pratyush Anand (2):
  makedumpfile: add runtime kaslr offset if it exists
  x86_64: calculate page_offset in case of re-filtering

 arch/x86_64.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 erase_info.c   |  1 +
 makedumpfile.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h | 16 ++++++++++++++++
 4 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

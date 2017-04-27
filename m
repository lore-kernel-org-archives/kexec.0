Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3cqu-0002SS-5j
 for kexec@lists.infradead.org; Thu, 27 Apr 2017 06:24:33 +0000
Received: by mail-pf0-f174.google.com with SMTP id v14so16778866pfd.2
 for <kexec@lists.infradead.org>; Wed, 26 Apr 2017 23:24:11 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH 0/2] Fix refiltering when kaslr enabled
Date: Thu, 27 Apr 2017 11:45:14 +0530
Message-Id: <cover.1493272570.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, keescook@chromium.org, bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, yinghai@kernel.org, mingo@kernel.org

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

Pratyush Anand (2):
  makedumpfile: add runtime kaslr offset if it exists
  x86_64: calculate page_offset in case of re-filtering

 arch/x86_64.c  | 45 +++++++++++++++++++++++++++++++++++++++++++--
 erase_info.c   |  1 +
 makedumpfile.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h | 15 +++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

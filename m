Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fg1jQ-0003ZN-Hm
 for kexec@lists.infradead.org; Thu, 19 Jul 2018 05:44:05 +0000
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so3082273pgq.5
 for <kexec@lists.infradead.org>; Wed, 18 Jul 2018 22:43:51 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 0/2] arm64, makedumpfile: A couple of KASLR related fixes
Date: Thu, 19 Jul 2018 11:13:39 +0530
Message-Id: <1531979021-31780-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, k-hagio@ab.jp.nec.com

This patchset contains a couple of patches which provide important
arm64 fixes for KASLR boot cases:

PATCH 1 -> Addresses the issue with 'info->page_offset' calculation for
           KASLR cases.
PATCH 2 -> Addresses the issue with filtering not able to translate
           symbol address from vmlinux to kernel run time address in
	   case of KASLR boot.

Bhupesh Sharma (2):
  arm64: Get 'info->page_offset' from PT_LOAD segments to support KASLR
    boot cases
  arm64: Add runtime kaslr offset if it exists

 arch/arm64.c   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 common.h       |  1 +
 makedumpfile.h |  4 +++-
 3 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7dHZ-0007F9-VR
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 10:21:59 +0000
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51974C007351
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 10:21:57 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id b18so10375720pgg.8
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 03:21:57 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 0/2] Fix a compilation warning and a static check error
Date: Tue, 10 Sep 2019 15:51:48 +0530
Message-Id: <20190910102150.7229-1-bhsharma@redhat.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, horms@verge.net.au

This patchset fixes two kexec-tools issues:
 - Fixes a shifting error reported by cppcheck inside
   'vmcore-dmesg/vmcore-dmesg.c'.
 - Fixes a compilation warning in 'i386/kexec-mb2-x86.c'.

Bhupesh Sharma (2):
  vmcore-dmesg/vmcore-dmesg.c: Fix shifting error reported by cppcheck
  i386/kexec-mb2-x86.c: Fix compilation warning

 kexec/arch/i386/kexec-mb2-x86.c | 2 --
 vmcore-dmesg/vmcore-dmesg.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

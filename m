Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ96u-005OT3-HN
 for kexec@lists.infradead.org; Sat, 09 Oct 2021 09:57:45 +0000
Received: by mail-pf1-f199.google.com with SMTP id
 4-20020a620504000000b0044be2cfac9bso5329816pff.0
 for <kexec@lists.infradead.org>; Sat, 09 Oct 2021 02:55:09 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
Subject: [PATCH v2 0/2] use more system keyrings to verify arm64 kdump kernel
 image signature
Date: Sat,  9 Oct 2021 17:54:56 +0800
Message-Id: <20211009095458.297191-1-coxu@redhat.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>

This patch set allows arm64 to use more system keyrings to verify kdump 
kernel image signature by making the existing code in x64 public.

v2:
 - only x86_64 and arm64 need to enable PE file signature check [Dave]

Coiby Xu (2):
  kexec, KEYS: make the code in bzImage64_verify_sig public
  arm64: kexec_file: use more system keyrings to verify kernel image
    signature

 arch/arm64/kernel/kexec_image.c   |  4 +---
 arch/x86/kernel/kexec-bzimage64.c | 13 +------------
 include/linux/kexec.h             |  3 +++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 4 files changed, 22 insertions(+), 15 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

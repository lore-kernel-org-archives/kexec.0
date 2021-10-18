Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcO3d-00Edd1-Rb
 for kexec@lists.infradead.org; Mon, 18 Oct 2021 08:31:47 +0000
Received: by mail-pf1-f198.google.com with SMTP id
 y41-20020a056a00182900b0044d43d31f20so8740473pfa.11
 for <kexec@lists.infradead.org>; Mon, 18 Oct 2021 01:31:42 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
Subject: [PATCH v3 0/3] use more system keyrings to verify arm64 kdump kernel
 image signature
Date: Mon, 18 Oct 2021 16:31:34 +0800
Message-Id: <20211018083137.338757-1-coxu@redhat.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>

This patch set allows arm64 to use more system keyrings to verify kdump 
kernel image signature by making the existing code in x64 public.

v3:
 - s/arch_kexec_kernel_verify_pe_sig/kexec_kernel_verify_pe_sig [Eric]
 - clean up arch_kexec_kernel_verify_sig [Eric]

v2:
 - only x86_64 and arm64 need to enable PE file signature check [Dave]


Coiby Xu (3):
  kexec: clean up arch_kexec_kernel_verify_sig
  kexec, KEYS: make the code in bzImage64_verify_sig generic
  arm64: kexec_file: use more system keyrings to verify kernel image
    signature

 arch/arm64/kernel/kexec_image.c   |  4 +--
 arch/x86/kernel/kexec-bzimage64.c | 13 +-------
 include/linux/kexec.h             |  7 +++--
 kernel/kexec_file.c               | 51 ++++++++++++++++++-------------
 4 files changed, 37 insertions(+), 38 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

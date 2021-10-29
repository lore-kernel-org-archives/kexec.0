Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgMFt-00A1aE-DO
 for kexec@lists.infradead.org; Fri, 29 Oct 2021 07:24:50 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] x86/kexec: fix memory leak of elf header buffer
Date: Fri, 29 Oct 2021 15:24:21 +0800
Message-Id: <20211029072424.9109-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, dyoung@redhat.com, akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>

The memory leak is reported by kmemleak detector, has been existing
for very long time. It could casue much memory loss on large machine
with huge memory hotplug which will trigger kdump kernel reloading
many times, with kexec_file_load interface.

And in patch 2, 3, clean up is done to remove unnecessary elf header
buffer freeing and unneeded arch_kexec_kernel_image_load().

Baoquan He (3):
  x86/kexec: fix memory leak of elf header buffer
  x86/kexec: remove incorrect elf header buffer freeing
  kexec_file: clean up arch_kexec_kernel_image_load

 arch/x86/kernel/machine_kexec_64.c | 23 +++++++++--------------
 include/linux/kexec.h              |  1 -
 kernel/kexec_file.c                |  9 ++-------
 3 files changed, 11 insertions(+), 22 deletions(-)

-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPzVf-00464o-T9
 for kexec@lists.infradead.org; Tue, 14 Sep 2021 03:53:29 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH v2 0/5] kexec-tools: multiboot2: Accept x86-64 images
Date: Mon, 13 Sep 2021 20:51:37 -0700
Message-Id: <20210914035142.251818-1-hello@zhaofeng.li>
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
Cc: Zhaofeng Li <hello@zhaofeng.li>, Simon Horman <horms@verge.net.au>

Hi Simon,

Thanks for your review! In this patchset I have addressed your comments
and included an extra fix.

Zhaofeng

--

This patch series adds support for loading x86-64 ELF images with
the multiboot2 header and fixes a couple of related issues.

Changes since v1:
- Coding style fixes
- Fixed one more occurrence of mhi.rel_tag in rel_min/rel_max patch
- Added a patch to address code duplication in elf_x86_64_probe
- Added a patch to address the case where add_buffer tried to
  allocate at 0x0.

Zhaofeng Li (5):
  x86: Consolidate elf_x86_probe routines
  multiboot2: Correct MBI size calculation
  multiboot2: Use rel_min and rel_max for buffer destinations
  multiboot2: Avoid first 0x500 bytes
  multiboot2: Accept x86-64 images

 kexec/arch/i386/kexec-elf-x86.c      | 44 +++++++++++++++++++++++-----
 kexec/arch/i386/kexec-mb2-x86.c      | 29 ++++++++++++------
 kexec/arch/i386/kexec-x86.h          |  1 +
 kexec/arch/x86_64/kexec-elf-x86_64.c | 28 ++----------------
 kexec/arch/x86_64/kexec-x86_64.c     |  4 +--
 5 files changed, 62 insertions(+), 44 deletions(-)

-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

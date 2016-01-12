Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aIrGh-0004uV-U1
 for kexec@lists.infradead.org; Tue, 12 Jan 2016 05:13:21 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC V2 0/2] kexec: arm64: purgatory: cache support
Date: Tue, 12 Jan 2016 10:42:49 +0530
Message-Id: <cover.1452572612.git.panand@redhat.com>
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
Cc: geoff@infradead.org, takahiro.akashi@linaro.org, horms@verge.net.au, james.morse@arm.com, jk@ozlabs.org, scottwood@freescale.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

This patch series adds support to enable cache during sha-256 verification
in purgatory. Until --enable-dcache is passed to kexec(), these patches
does not affect existing purgatory functionality. 

Patches have been tested with Seattle and Mustang for normal kexec and
kdump. It took hardly a second to verify SHA256 when kernel and initramfs
segment sizes were 0x01030000 and  0x01130000 respectively.

Patches are still being sent as RFC, because these are dependent on Geoff's
kexec-tools patches. These patches along with other dependent patches are
also available here:
https://github.com/pratyushanand/kexec-tools.git (HEAD commit 062475cf4f3f)

RFC V1 was here:
http://lists.infradead.org/pipermail/kexec/2015-May/013678.html

Changes since RFC V1:
There had been many changes, I would say rather that code has been
reimplemented. I am listing some of the significant changes here:
-- By default D-cache would be disabled now.
-- Most part of implementation has been moved from asm to c code.
-- Proper synchronization barrier and tlb invalidation
-- Now we can have print during MMU enabled as well, since UART area is
also identity mapped.
-- Supports 64K and 4K page table. If a HW supports 64K then it uses 64K
page implementation, else it checks if 4K is supported and then uses 4K
page table. 16K is not yet supported.


Pratyush Anand (2):
  arm64: Add enable/disable d-cache support for purgatory
  arm64: Pass RAM boundary and enable-dcache flag to purgatory

 kexec/arch/arm64/include/arch/options.h |   6 +-
 kexec/arch/arm64/include/types.h        |  16 ++
 kexec/arch/arm64/kexec-arm64.c          |  24 ++-
 purgatory/arch/arm64/Makefile           |   2 +
 purgatory/arch/arm64/cache-asm.S        | 228 ++++++++++++++++++++++
 purgatory/arch/arm64/cache.c            | 333 ++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/cache.h            |  83 ++++++++
 purgatory/arch/arm64/entry.S            |  15 ++
 purgatory/arch/arm64/purgatory-arm64.c  |  10 +-
 9 files changed, 714 insertions(+), 3 deletions(-)
 create mode 100644 kexec/arch/arm64/include/types.h
 create mode 100644 purgatory/arch/arm64/cache-asm.S
 create mode 100644 purgatory/arch/arm64/cache.c
 create mode 100644 purgatory/arch/arm64/cache.h

-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

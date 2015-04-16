Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yimy2-0008CD-GV
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 16:48:43 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 0/6] Various fixes for purgatory and ARM64
Date: Thu, 16 Apr 2015 22:17:23 +0530
Message-Id: <cover.1429201849.git.panand@redhat.com>
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
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
To: kexec@lists.fedoraproject.org, kexec@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>

These patches can be applied on top of Geoff's Kexec [1] and Takahiro's
Kdump [2] patches and are available in my tree [3].

First two patches are for purgatory. 1st patch is a very important fix
for sha verification.  2nd patch is good to have.

Rest all patches are fixes and addon for ARM64.

These patchset adds three extra command line options for ARM64.

 --page-offset: Needed for binary image only. Default value is
0xfffffe0000000000.

 --port-lsr: It is UART's Line status register address. Normally for a
UART based on 8250, 16450 or 16550 should have value as --port's value +
0x14.

 --port-lsr-val: It is the SET value of LSR register for TX buffer to be
empty. Normally for above UARTs it should be 0x60 

[1] git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git
: master
[2] git://git.linaro.org/people/takahiro.akashi/kexec-tools.git :
kdump/v0.10
[3] https://github.com/pratyushanand/kexec-tools.git : master
(6c8a63f701e9)

Pratyush Anand (6):
  purgatory: Fix memcmp for src address increment
  purgatory: No need to sha256 update if ptr->len is zero
  arm64: allocate memory for other segments after kernel
  arm64: support reuse-cmdline option
  arm64: Add support for binary image
  arm64: wait for transmit completion before next character transmission

 kexec/arch/arm64/crashdump-arm64.c      |  3 +-
 kexec/arch/arm64/crashdump-arm64.h      |  1 +
 kexec/arch/arm64/include/arch/options.h | 21 +++++++++++--
 kexec/arch/arm64/kexec-arm64.c          | 28 ++++++++++++++++-
 kexec/arch/arm64/kexec-arm64.h          |  2 ++
 kexec/arch/arm64/kexec-image-arm64.c    | 54 ++++++++++++++++++++++++++++++---
 purgatory/arch/arm64/entry.S            | 10 ++++++
 purgatory/arch/arm64/purgatory-arm64.c  | 22 +++++++++++++-
 purgatory/purgatory.c                   |  2 ++
 purgatory/string.c                      |  2 ++
 10 files changed, 135 insertions(+), 10 deletions(-)

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

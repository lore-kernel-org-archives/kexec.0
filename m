Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vi1eur04on0717.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::717]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fb3nf-0005oG-Vp
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 12:55:58 +0000
From: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
Subject: [PATCH 0/3] arm64: add support for loading kernel from FITimage
Date: Thu,  5 Jul 2018 14:55:32 +0200
Message-Id: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org

Hi all,

FITimages are an image format used by U-boot, allowing to embed a kernel with
the associated device tree and initramfs into a single file, using the device
tree file format.
Unfortunately, for now kexec doesn't recognize the FITimage format.

This patchset adds a generic FITimage loader & parser, and implements loading
a kernel/dtb/initrd for the ARM64 architecture.

Arnaud Ferraris (3):
  kexec: Move zlib buffer decompression function
  kexec: fitImage: Add fitImage parser and loader
  kexec: arm64: Add fitImage support

 include/Makefile                        |   1 +
 include/kexec-fitImage.h                |  18 +++
 kexec/Makefile                          |   4 +
 kexec/arch/arm64/Makefile               |   2 +
 kexec/arch/arm64/kexec-arm64.c          |  15 ++-
 kexec/arch/arm64/kexec-arm64.h          |   4 +
 kexec/arch/arm64/kexec-fitImage-arm64.c |  40 ++++++
 kexec/kexec-fitImage.c                  | 223 ++++++++++++++++++++++++++++++++
 kexec/kexec-uImage.c                    | 100 +-------------
 kexec/kexec-zlib.h                      |   1 +
 kexec/kexec.h                           |   4 +
 kexec/zlib.c                            | 100 ++++++++++++++
 12 files changed, 413 insertions(+), 99 deletions(-)
 create mode 100644 include/kexec-fitImage.h
 create mode 100644 kexec/arch/arm64/kexec-fitImage-arm64.c
 create mode 100644 kexec/kexec-fitImage.c

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

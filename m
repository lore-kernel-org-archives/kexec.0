Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOt5h-00EAiv-J6
 for kexec@lists.infradead.org; Sat, 11 Sep 2021 02:50:07 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH 0/3] kexec-tools: multiboot2: Accept x86-64 images
Date: Fri, 10 Sep 2021 19:48:57 -0700
Message-Id: <20210911024900.1899877-1-hello@zhaofeng.li>
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

This patch series adds support for loading x86-64 ELF images with
the multiboot2 header and fixes a couple of related issues.

Tested by loading a custom research OS kernel. Thank you for your
review!

Zhaofeng

Zhaofeng Li (3):
  multiboot2: Correct MBI size calculation
  multiboot2: Use rel_min and rel_max for mbi destination
  multiboot2: Accept x86-64 images

 kexec/arch/i386/kexec-mb2-x86.c  | 51 +++++++++++++++++++++++++++-----
 kexec/arch/x86_64/kexec-x86_64.c |  4 +--
 2 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

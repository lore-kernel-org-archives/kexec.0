Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lZP1R-00DKHr-DL
 for kexec@lists.infradead.org; Thu, 22 Apr 2021 02:24:55 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH v2 0/4] mips: Fix related problems in kdump operation
Date: Thu, 22 Apr 2021 10:24:30 +0800
Message-Id: <1619058274-6996-1-git-send-email-tangyouling@loongson.cn>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Baoquan He <bhe@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jinyang He <hejinyang@loongson.cn>, kexec@lists.infradead.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

1. Fix the "mem=" parameter parsing problem.
2. Solve the problem that panic may be triggered due to insufficient memory
when entering the capture kernel.
3. Fix the problem that the captured production kernel data may be destroyed.

Youling Tang (4):
  MIPS: Fix cmdline "mem=" parameter parsing
  mips: kdump: Capture kernel should be able to see old memories
  mips: kdump: Reserve extra memory for crash dump
  mips: kdump: Reserve old memory to avoid the destruction of production
    kernel data

 arch/mips/kernel/setup.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

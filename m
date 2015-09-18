Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.windriver.com ([147.11.1.11])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcqK2-0000Pc-Oi
 for kexec@lists.infradead.org; Fri, 18 Sep 2015 07:43:07 +0000
From: <yanjiang.jin@windriver.com>
Subject: [V2 PATCH] mips: vmcore: forced convert 'hdr' in elf_check_arch()
Date: Fri, 18 Sep 2015 15:42:50 +0800
Message-ID: <1442562171-21307-1-git-send-email-yanjiang.jin@windriver.com>
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
To: akpm@linux-foundation.org, mhuang@redhat.com
Cc: jinyanjiang@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, chaowang@redhat.com, yanjiang.jin@windriver.com

From: Yanjiang Jin <yanjiang.jin@windriver.com>

V1->V2: According to Minfei's suggestion, coverting in the Macro rather
than in vmcore.c.

Already verified this patch on a MIPS64 cavium octeon board: CN78XX.

This patch is to eliminate the compile warning only, has no side effect in run-time.

Yanjiang Jin (1):
  mips: vmcore: forced convert 'hdr' in elf_check_arch()

 arch/mips/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

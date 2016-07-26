Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRsf0-0000re-CO
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 03:03:59 +0000
From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Tue, 26 Jul 2016 10:59:52 +0800
Message-ID: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 0/3] Fix dump-capture kernel hangs with notsc
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
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, xpang@redhat.com, joro@8bytes.org, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, kernel@kyup.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Wei Jiangang <weijg.fnst@cn.fujitsu.com>

v2:
Just about the commit ("x86/apic: Improved the setting of interrupt
 mode for bsp")

- Unify the name
  s/virtual_wire_via_*/virt_wire_through_*
- Add check for PIC mode
  suggested-by Baoquan He <bhe@redhat.com>
- Add check enable/disable flag for IO-APIC
  suggested-by Xunlei Pang <xpang@redhat.com>
- Update comments

v1:
The goal is to fix dump-capture kernel with notsc option hangs
in calibrate_delay_converge()

Wei Jiangang (3):
  x86/apic: Remove "focus disabled" for 64bit case
  x86/apic: Update comment about disabling processor focus
  x86/apic: Improved the setting of interrupt mode for bsp

 arch/x86/include/asm/io_apic.h |  5 ++++
 arch/x86/kernel/apic/apic.c    | 63 +++++++++++++++++++++++++++++++++++++++---
 arch/x86/kernel/apic/io_apic.c | 28 +++++++++++++++++++
 3 files changed, 92 insertions(+), 4 deletions(-)

-- 
1.9.3




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

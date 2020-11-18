Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfEGz-0008Si-86
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 03:36:46 +0000
Received: by mail-pf1-x442.google.com with SMTP id b63so517430pfg.12
 for <kexec@lists.infradead.org>; Tue, 17 Nov 2020 19:36:43 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 0/3] use soft lockup to detect irq flood
Date: Wed, 18 Nov 2020 11:36:15 +0800
Message-Id: <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <87tuueftou.fsf@nanos.tec.linutronix.de>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
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
Cc: Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, kexec@lists.infradead.org, Pingfan Liu <kernelfans@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>

The chipset's pins are often multi-used because greedy usage compares to a
finite pin number. This requests a carefully configuration in firmware or OS.
If not, it may contribute to most of irq flood cases, which appears as a soft
lockup issue on Linux. 
 
Strictly speaking, soft lockup and irq flood are different things to overcome.
And it is helpful to make users aware of that situation for prime time.

This series shows the irq statistics when soft lockup. The statistics can be
used to evaluate the possibility of irq flood and as a rough evaluated input to
the kernel parameter "irqstorm_limit" in [1].
 
It is not easy to find a common way to work around irq flood, which may be
raised by different root cause. To now, it is still a open question.
Thomas and Guilherme suggested patches to suppress the odd irq in different
situation. [1].[2]

[1]: https://lore.kernel.org/lkml/87tuueftou.fsf@nanos.tec.linutronix.de/
[2]: https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com/


Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org


Pingfan Liu (3):
  x86/irq: account the unused irq
  kernel/watchdog: make watchdog_touch_ts more accurate by using
    nanosecond
  kernel/watchdog: use soft lockup to detect irq flood

 arch/x86/kernel/irq.c       |  1 +
 include/linux/kernel_stat.h |  1 +
 kernel/watchdog.c           | 37 ++++++++++++++++++++++++++-----------
 3 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

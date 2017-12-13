Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eOxAm-00033x-3S
 for kexec@lists.infradead.org; Wed, 13 Dec 2017 02:53:30 +0000
Date: Wed, 13 Dec 2017 10:52:56 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Regression: kexec/kdump boot hangs with x86/vector commits
Message-ID: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, kexec@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Arjan van de Ven <arjan@linux.intel.com>, Rui Zhang <rui.zhang@intel.com>

Hi,

Kexec reboot and kdump has broken on my laptop for long time with
4.15.0-rc1+ kernels. With the patch below an early panic been fixed:
https://patchwork.kernel.org/patch/10084289/

But still can not get a successful reboot, it looked like graphic
issue, but after bisecting the kernel, I got below:

[dyoung@dhcp-*-* linux]$ git bisect good
There are only 'skip'ped commits left to test.
The first bad commit could be any of:
2db1f959d9dc16035f2eb44ed5fdb2789b754d6a
4900be83602b6be07366d3e69f756c1959f4169a
We cannot bisect more!

These two commits can no be reverted because of code conflicts, thus
I reverted the whole series from Thomas (below commits), with those
x86/vector changes reverted, kexec reboot works fine.

Could you help to take a look, any thoughts?  I can do the test
if you have some debug patch to try.

commit 90ad9e2d91067983f3328e21b306323877e5f48a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Sep 13 23:29:49 2017 +0200

    x86/io_apic: Reevaluate vector configuration on activate()

commit 2db1f959d9dc16035f2eb44ed5fdb2789b754d6a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Sep 13 23:29:50 2017 +0200

    x86/vector: Handle managed interrupts proper

commit 4900be83602b6be07366d3e69f756c1959f4169a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Sep 13 23:29:51 2017 +0200

    x86/vector/msi: Switch to global reservation mode

commit 464d12309e1b5829597793db551ae8ecaecf4036
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Sep 13 23:29:52 2017 +0200

    x86/vector: Switch IOAPIC to global reservation mod

commit 2cffad7bad83157f89332872015f4305d2ac09ac
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Sep 13 23:29:53 2017 +0200

    x86/irq: Simplify hotplug vector accounting

commit d6ffc6ac83b1f9f12652d89b9cb5bcbfbea7796c
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Sep 13 23:29:54 2017 +0200

    x86/vector: Respect affinity mask in irq descriptor

commit 02edee152d6ea325c88898f3a702f5db2d78de7a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Oct 12 11:05:28 2017 +0200

    x86/apic/vector: Ignore set_affinity call for inactive interrupts

commit 0696d059f23c05f2dbc3b19ef50e5bdd175b782b
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Oct 16 16:16:19 2017 +0200

    x86/vector: Use correct per cpu variable in free_moved_vector()
----------------

BTW, my git HEAD is below:
commit 43570f0383d6d5879ae585e6c3cf027ba321546f (origin/master, origin/HEAD, bisect)
Merge: 43f462f1c2e1 c14ca8386539
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Nov 28 16:22:10 2017 -0800

    Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6



Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

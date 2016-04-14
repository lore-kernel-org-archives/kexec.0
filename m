Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqnSt-0005EY-9b
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 20:02:12 +0000
Date: Thu, 14 Apr 2016 20:59:38 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/3] Initial Kexec patches
Message-ID: <20160414195938.GV19428@n2100.arm.linux.org.uk>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Eric,

Here are some initial patches from my stack to bring functional kexec
support to the TI Keystone 2 platform.  These are relatively independent
of that work, but I believe are useful changes in their own regard.
Each patch is independent of each other; these do not really comprise
a strict series.

The first fixes an obscure problem - if we try to allocate the control
page, and we're unable to allocate a page within the memory region we
want, we end up killing processes, trying to gain that page.  In the
case where there is no memory located within the desired range, this
results in the OOM killer killing off many processes rather than a
graceful failure.  The patch changes the behaviour to allow a graceful
failure instead without invoking the OOM killer.

The second patch fixes a missing check in the kexec code, where the
user could supply a start and size address for a segment which causes
the calculation to wrap.  Eg, the case where segment[0].mem = 0xffff0000,
segment[0].memsz = 0x10000 would pass this check.  This patch adds an
explicit check for cases such as these.

The third patch allows the vmcoreinfo note data to be located above
4GB in physical memory space.  Since kexec tools only use this value
when opening /dev/mem, having this located above 4GB physical is not
a problem - kexec tools even expect this to potentially be a 64-bit
value already.  Making this change means there is one less area which
becomes Keystone 2 specific.

 arch/ia64/kernel/machine_kexec.c | 2 +-
 include/linux/kexec.h            | 4 ++--
 kernel/kexec_core.c              | 4 +++-
 kernel/ksysfs.c                  | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

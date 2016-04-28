Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aviED-0003io-JP
 for kexec@lists.infradead.org; Thu, 28 Apr 2016 09:27:22 +0000
Date: Thu, 28 Apr 2016 10:26:44 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 00/12] Fixing TI Keystone2 kexec
Message-ID: <20160428092644.GX19428@n2100.arm.linux.org.uk>
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
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Jonathan Corbet <corbet@lwn.net>, Ian Campbell <ijc+devicetree@hellion.org.uk>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, Vivek Goyal <vgoyal@redhat.com>

These changes are required for TI Keystone2 kexec to be functional.  TI
Keystone2 has the run-time view of physical memory above 4GiB, but with
a boot time alias below 4GiB which can only be used during the early
boot.

This means we need to translate run-time physical addresses (which the
kernel uses) to boot-time physical addresses, which, having discussed
with Eric, is what the kexec tools and kexec kernel API requires.

We publish a special set of boot time resources in /proc/iomem, which
the (modified) kexec tools look for in preference to the normal resources.
Hence, if these are found, the kexec tools make use of these resources,
and thus kexec tools use the boot-time view of physical memory.

The first three patches have been sitting in linux-next for a while.
I'm going to put the next ARM specific three into linux-next next week.

I've sent Eric over a month ago all the patches, including the kexec
tools patches, but I've heard nothing back.  I'm at a loss how to
make progress on these patches - and as I'm being hassled about this,
I'm going to be hassling the community about it, possibly with regular
re-posts until there is some progress.

 Documentation/kdump/kdump.txt     | 13 ++------
 arch/arm/boot/dts/keystone.dtsi   |  8 +++++
 arch/arm/include/asm/kexec.h      | 24 +++++++++++++++
 arch/arm/include/asm/memory.h     | 38 ++++++++++++++++++-----
 arch/arm/kernel/machine_kexec.c   |  2 +-
 arch/arm/kernel/setup.c           | 65 +++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-keystone/keystone.c |  7 +----
 arch/arm/mm/idmap.c               |  2 +-
 arch/ia64/kernel/machine_kexec.c  |  2 +-
 include/linux/kexec.h             | 42 +++++++++++++++++++++++--
 kernel/kexec.c                    |  3 +-
 kernel/kexec_core.c               | 30 +++++++++---------
 kernel/ksysfs.c                   |  4 +--
 13 files changed, 193 insertions(+), 47 deletions(-)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

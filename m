Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBb6V-0007yT-2b
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 19:56:31 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: x86: Add /sys/firmware/memmap
Date: Wed, 25 Jun 2008 21:57:04 +0200
Message-Id: <1214423826-12628-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, yhlu.kernel@gmail.com

This patch series adds a new interface /sys/firmware/memmap
to export the BIOS (Firmware) provided memory map via sysfs
for usage with kexec.

While the first patch adds the generic interface, the second
patch implements that interface for E820 on x86. EFI is on the TODO
list, and other architectures can be added later.

This patch is RFC. It has been tested on x86-64 and i386 and
replaces my previous attemt that adds such an interface via
procfs.


Signed-off-by: Bernhard Walle <bwalle@suse.de>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

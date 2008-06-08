Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5LDb-0003i1-VT
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 13:46:00 +0000
Message-Id: <20080608134628.757299158@halley.suse.de>
Date: Sun, 08 Jun 2008 15:46:28 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 0/3] [x86] Fix crashkernel reservation on NUMA machines
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
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

This patch series fixes the crashkernel reservation on NUMA machine. The
regression was discovered by Dave Anderson <anderson@redhat.com>.

The background is that on NUMA machines, reserve_bootmem_generic() is required
instead of reserve_bootmem(). To achieve that, it's necessary to make a few
API changes.

The patches are against latest linux-2.6 git. They should still go into 2.6.26
since it's only bug fixing. For 2.6.27, we should unify crashkernel reservation
for i386 and x86-64.

Tested on both i386 and x86-64. Compilation was tested with both kexec disabled
and enabled. The change is x86 only, so no need to test on other architectures.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Maintenance

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

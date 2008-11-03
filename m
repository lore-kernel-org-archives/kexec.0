Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx7Ry-0002aV-0c
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 21:59:06 +0000
Received: id: bigeasy by Chamillionaire.breakpoint.cc authenticated by bigeasy
	with local (easymta 1.00 BETA 1) id 1Kx7Rv-0000D1-QO
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 22:59:03 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: kexec support for ppc32 (v2)
Date: Mon,  3 Nov 2008 22:58:59 +0100
Message-Id: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
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

The patches:
 1: not ppc32 related, noticed while I tried to load dtb/kernel from an ubi
    device node.
 2: the second version of purgatory & dtb support for ppc32.
    Changelog:
    v1: removed run time change between dreamcast and device tree aware
        arch and switched to ifdef
 3: libfdt. This library is used for device tree handling and is not
    packaged. I'm not sure if upstream wants to support shared libraries
    and maintain a stable api. This whole patch has 109KiB and is
    available at [1] I did not want to spam the list.
    PPC64 is creating the nodes by hand and they can't replaces nodes.
 4: Uses the libfdt to replaces some nodes. Usually the bootloader sets
    some properties which are auto enabled like clock speed or MAC
    address. This patch allows to take an almost complete device tree and
    update the missing nodes from the actual device tree.

[1] http://download.breakpoint.cc/0003-powerpc32-pull-in-libfdt.patch    

Sebastian



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

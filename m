Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qv8WW-0002Vz-Oy
	for kexec@lists.infradead.org; Sun, 21 Aug 2011 13:57:13 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
	(dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
	id S1592038Ab1HUNu3 (ORCPT <rfc822;kexec@lists.infradead.org>);
	Sun, 21 Aug 2011 15:50:29 +0200
Date: Sun, 21 Aug 2011 15:50:29 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: [PATCH 0/4] kexec-tools: Xen fixes and cleanups
Message-ID: <20110821135029.GA17323@router-fw-old.local.net-space.pl>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: konrad.wilk@oracle.com, ian.campbell@citrix.com, vgoyal@redhat.com, horms@verge.net.au, olaf@aepfle.de, kexec@lists.infradead.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org

Hi,

I am sending some Xen specific fixes and cleanups for kexec-tools.
These patches applies to current kexec-tools git tree.

Full list of fixes and cleanups:
  - xen: Take into account Xen control interface changes since Xen Ver. 4.1,
  - kexec: Export compare_ranges() function from firmware_memmap.c module,
  - kexec/arch/i386: Rename fixup_memory_ranges_sysfs() to fixup_memory_ranges(),
  - kexec/arch/i386: Add get_memory_ranges_xen() function.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

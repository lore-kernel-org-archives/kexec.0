Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSTyE-0000sK-Mw
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 16:12:59 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 16:12:36 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D41A11B0805F
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 16:12:25 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PGCLCv1245450
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 16:12:21 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PHCWja025514
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 11:12:33 -0600
Date: Tue, 25 Mar 2014 17:12:31 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 0/2] makdumpfile: Add "mem=" handling for physical memory dumps
Message-ID: <20140325171231.6cbaa2e5@holzheu>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

There are dump mechansims like s390 stand-alone dump or KVM virsh dump
that write the physical memory of a machine and that are not aware of the
dumped operating system. If for the Linux kernel of the dumped system the
"mem=" kernel parameter has been specified, the "max_mapnr" that
makedumpfile gets from the ELF header can be bigger than the maximum page
frame number used by the dumped Linux kernel. This can lead to makedumpfile
errors on s390x and can also lead to extended dump times and sizes.

The following two patches for version 1.5.5 fix these issues:

Michael Holzheu (2):
  makedumpfile: Fix zero checking of get_mm_sparsemem()
  makedumpfile: Use max_pfn from mem_map array

 makedumpfile.c |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMQQt-0002OB-LC
	for kexec@lists.infradead.org; Tue, 17 May 2011 19:59:57 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4HJxlSG030571
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 01:29:47 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4HJxlT74550760
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 01:29:47 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4HJxkP4008812
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 05:59:46 +1000
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to filter out
	kernel data from vmcore
Date: Wed, 18 May 2011 01:29:06 +0530
Message-ID: <20110517195751.12740.97565.stgit@mars.in.ibm.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Dave Anderson <anderson@redhat.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi All,

Please find the version 2 of makedumpfile enhancement patchset that introduces
a data filtering feature which enables makedumpfile to filter out desired kernel
symbol data and it's members from the specified VMCORE file. The data to be
filtered out is poisoned with character 'X' (58 in Hex).

This feature will be very useful for the customers who wants to erase the
customer sensitive data like security keys and other confidential data, in
DUMPFILE before sending it to support team for analysis.

This feature introduces a filter config file where, using filter commands,
user can specify desired kernel data symbols and it's members that need to be
filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
provided in the makedumpfile.conf(8) man page.

The first 4 patches prepares the base work for filtering framework. The
patches 5 and 6 implements the generic filtering framework to erase desired
kernel data. The last two patches implements inclusion of eraseinfo data into
o/p dumpfile (kdump as well as ELF). The eraseinfo data contains the
effective lines from configuration files.

I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
kernel. The feature supports filtering data from ELF as well as
kdump-compressed formatted dump.

Change in v2:
- Changes in patch 5 and inclusion of new patches 7 & 8
- Re-named filter.conf file to makedumpfile.conf and some cleanup work.
- Introduced last two patches that implements inclusion of eraseinfo data
  into kdump compressed as well as ELF formatted dumpfile.

Please review the patchset and let me know your comments.

Thanks,
-Mahesh.
---

Mahesh Salgaonkar (8):
      makedumpfile: Add '--config' option to specify filter config file.
      makedumpfile: Apply relocation while loading module debuginfo.
      makedumpfile: Load the module symbol data from vmcore.
      makedumpfile: Introduce routines to get type name from debuginfo.
      makedumpfile: Read and process filter commands from config file.
      makedumpfile: Read and process 'for' command from config file.
      makedumpfile: Add erased information in compressed kdump file
      makedumpfile: Add erase information in ELF formatted dumpfile


 IMPLEMENTATION      |    6 
 Makefile            |    8 
 diskdump_mod.h      |    2 
 makedumpfile.8      |   20 
 makedumpfile.c      | 2747 ++++++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.conf   |  149 +++
 makedumpfile.conf.8 |  419 ++++++++
 makedumpfile.h      |  199 ++++
 8 files changed, 3394 insertions(+), 156 deletions(-)
 create mode 100644 makedumpfile.conf
 create mode 100644 makedumpfile.conf.8

-- 
Signature

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

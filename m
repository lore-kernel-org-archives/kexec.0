Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PxxKx-0004wY-Ed
	for kexec@lists.infradead.org; Fri, 11 Mar 2011 08:04:41 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p2B84X5G012257
	for <kexec@lists.infradead.org>; Fri, 11 Mar 2011 13:34:33 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2B84XUR2359330
	for <kexec@lists.infradead.org>; Fri, 11 Mar 2011 13:34:33 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2B84XSw032110
	for <kexec@lists.infradead.org>; Fri, 11 Mar 2011 19:04:33 +1100
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter out
	kernel data from vmcore
Date: Fri, 11 Mar 2011 13:34:32 +0530
Message-ID: <20110311075647.14587.50626.stgit@mars.in.ibm.com>
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

Please find the makedumpfile enhancement patchset that introduces a data
filtering feature which enables makedumpfile to filter out desired kernel
symbol data and it's members from the specified VMCORE file. The data to be
filtered out is poisoned with character 'X' (58 in Hex).

This feature will be very useful for the customers who wants to erase the
customer sensitive data like security keys and other confidential data, in
DUMPFILE before sending it to support team for analysis.

This feature introduces a filter config file where, using filter commands,
user can specify desired kernel data symbols and it's members that need to be
filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
provided in the filter.conf(8) man page.

The first 4 patches prepares the base work for filtering framework. The last 2
patches implements the generic filtering framework to erase desired kernel
data.

I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
kernel. The feature supports filtering data from ELF as well as
kdump-compressed formatted dump.

Please review the patchset and let me know your comments.

Thanks,
-Mahesh.

---

Mahesh Salgaonkar (6):
      makedumpfile: Add '--config' option to specify filter config file.
      makedumpfile: Apply relocation while loading module debuginfo.
      makedumpfile: Load the module symbol data from vmcore.
      makedumpfile: Introduce routines to get type name from debuginfo.
      makedumpfile: Read and process filter commands from config file.
      makedumpfile: Read and process 'for' command from config file.


 Makefile       |    8 
 filter.conf    |  149 ++++
 filter.conf.8  |  419 +++++++++++
 makedumpfile.8 |   20 +
 makedumpfile.c | 2113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.h |  152 ++++
 6 files changed, 2782 insertions(+), 79 deletions(-)
 create mode 100644 filter.conf
 create mode 100644 filter.conf.8

-- 
Signature

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

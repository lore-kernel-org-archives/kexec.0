Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Py30t-0007Kh-2I
	for kexec@lists.infradead.org; Fri, 11 Mar 2011 14:08:20 +0000
Date: Fri, 11 Mar 2011 09:07:50 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110311075647.14587.50626.stgit@mars.in.ibm.com>
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Reinhard <BUENDGEN@de.ibm.com>



----- Original Message -----
> Hi All,
> 
> Please find the makedumpfile enhancement patchset that introduces a data
> filtering feature which enables makedumpfile to filter out desired kernel
> symbol data and it's members from the specified VMCORE file. The data to be
> filtered out is poisoned with character 'X' (58 in Hex).
> 
> This feature will be very useful for the customers who wants to erase the
> customer sensitive data like security keys and other confidential data, in
> DUMPFILE before sending it to support team for analysis.
> 
> This feature introduces a filter config file where, using filter commands,
> user can specify desired kernel data symbols and it's members that need to be
> filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
> provided in the filter.conf(8) man page.
> 
> The first 4 patches prepares the base work for filtering framework.  The last 2
> patches implements the generic filtering framework to erase desired kernel
> data.
> 
> I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
> kernel. The feature supports filtering data from ELF as well as kdump-compressed
> formatted dump.
> 
> Please review the patchset and let me know your comments.
> 
> Thanks,
> -Mahesh.

Hi Mahesh,

Is there any notation in the filtered ELF kdump or compressed kdump file
that filtering has been done?  Given that there may be potential ramifications
in crash utility behavior (or outright failure?), the crash utility should
display a warning message early on during invocation.

Thanks,
  Dave

 
> ---
> 
> Mahesh Salgaonkar (6):
> makedumpfile: Add '--config' option to specify filter config file.
> makedumpfile: Apply relocation while loading module debuginfo.
> makedumpfile: Load the module symbol data from vmcore.
> makedumpfile: Introduce routines to get type name from debuginfo.
> makedumpfile: Read and process filter commands from config file.
> makedumpfile: Read and process 'for' command from config file.
> 
> 
> Makefile | 8
> filter.conf | 149 ++++
> filter.conf.8 | 419 +++++++++++
> makedumpfile.8 | 20 +
> makedumpfile.c | 2113
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> makedumpfile.h | 152 ++++
> 6 files changed, 2782 insertions(+), 79 deletions(-)
> create mode 100644 filter.conf
> create mode 100644 filter.conf.8
> 
> --
> Signature

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

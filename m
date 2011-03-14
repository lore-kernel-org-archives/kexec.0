Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pyxq8-00059x-55
	for kexec@lists.infradead.org; Mon, 14 Mar 2011 02:49:01 +0000
Date: Mon, 14 Mar 2011 11:44:57 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
Message-Id: <20110314114457.7e252f0d.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
References: <20110311075647.14587.50626.stgit@mars.in.ibm.com>
	<1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Dave, Mahesh,

On Fri, 11 Mar 2011 09:07:50 -0500 (EST)
Dave Anderson <anderson@redhat.com> wrote:
> > 
> > Please find the makedumpfile enhancement patchset that introduces a data
> > filtering feature which enables makedumpfile to filter out desired kernel
> > symbol data and it's members from the specified VMCORE file. The data to be
> > filtered out is poisoned with character 'X' (58 in Hex).
> > 
> > This feature will be very useful for the customers who wants to erase the
> > customer sensitive data like security keys and other confidential data, in
> > DUMPFILE before sending it to support team for analysis.
> > 
> > This feature introduces a filter config file where, using filter commands,
> > user can specify desired kernel data symbols and it's members that need to be
> > filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
> > provided in the filter.conf(8) man page.
> > 
> > The first 4 patches prepares the base work for filtering framework.  The last 2
> > patches implements the generic filtering framework to erase desired kernel
> > data.
> > 
> > I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
> > kernel. The feature supports filtering data from ELF as well as kdump-compressed
> > formatted dump.
> > 
> > Please review the patchset and let me know your comments.
> > 
> > Thanks,
> > -Mahesh.
> 
> Hi Mahesh,
> 
> Is there any notation in the filtered ELF kdump or compressed kdump file
> that filtering has been done?  Given that there may be potential ramifications
> in crash utility behavior (or outright failure?), the crash utility should
> display a warning message early on during invocation.

That is a good point.

How about adding new members (like offset_eraseinfo, size_eraseinfo)
into the sub header in compressed kdump file, and setting version 5
in the header version (disk_dump_header.header_version) ?
These members show the erased information like the following:

struct kdump_sub_header {
        unsigned long   phys_base;
        int             dump_level;     /* header_version 1 and later */
        int             split;          /* header_version 2 and later */
        unsigned long   start_pfn;      /* header_version 2 and later */
        unsigned long   end_pfn;        /* header_version 2 and later */
        off_t           offset_vmcoreinfo;/* header_version 3 and later */
        unsigned long   size_vmcoreinfo;  /* header_version 3 and later */
        off_t           offset_note;      /* header_version 4 and later */
        unsigned long   size_note;        /* header_version 4 and later */
+       off_t           offset_eraseinfo; /* header_version 5 and later */
+       unsigned long   size_eraseinfo;   /* header_version 5 and later */
};

The erased information contains only effective lines in the
configuration file. 
In case of ELF kdump file, how about adding a ELF note section
which also show the erased information ?

The crash utility will be able to know the name list of the
erased symbols from the information.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

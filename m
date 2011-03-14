Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pz1sr-00060V-FJ
	for kexec@lists.infradead.org; Mon, 14 Mar 2011 07:08:06 +0000
Date: Mon, 14 Mar 2011 16:05:28 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
Message-Id: <20110314160528.943d9149.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4D7DB32B.9030705@linux.vnet.ibm.com>
References: <1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<4D7DB32B.9030705@linux.vnet.ibm.com>
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>, Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>


Hi Mahesh,

On Mon, 14 Mar 2011 11:48:19 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > 
> > 
> > ----- Original Message -----
> >> Hi All,
> >>
> >> Please find the makedumpfile enhancement patchset that introduces a data
> >> filtering feature which enables makedumpfile to filter out desired kernel
> >> symbol data and it's members from the specified VMCORE file. The data to be
> >> filtered out is poisoned with character 'X' (58 in Hex).
> >>
> >> This feature will be very useful for the customers who wants to erase the
> >> customer sensitive data like security keys and other confidential data, in
> >> DUMPFILE before sending it to support team for analysis.
> >>
> >> This feature introduces a filter config file where, using filter commands,
> >> user can specify desired kernel data symbols and it's members that need to be
> >> filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
> >> provided in the filter.conf(8) man page.
> >>
> >> The first 4 patches prepares the base work for filtering framework.  The last 2
> >> patches implements the generic filtering framework to erase desired kernel
> >> data.
> >>
> >> I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
> >> kernel. The feature supports filtering data from ELF as well as kdump-compressed
> >> formatted dump.
> >>
> >> Please review the patchset and let me know your comments.
> >>
> >> Thanks,
> >> -Mahesh.
> > 
> > Hi Mahesh,
> > 
> > Is there any notation in the filtered ELF kdump or compressed kdump file
> > that filtering has been done?  Given that there may be potential ramifications
> > in crash utility behavior (or outright failure?), the crash utility should
> > display a warning message early on during invocation.
> 
> Hmm... I did not think about it. I am thinking of following approach:
> 
> - Set a bit in dump_level (DL_FILTER_KERNEL_DATA => 0x800) that will
> denote that filtering has been done.
> - For compressed kdump file we anyway have dump_level available in kdump
> sub header
> - For ELF kdump, currently we do not have any way to convey dump_level
> info to crash utility (Ken'chi, correct me if I am wrong). How about
> introducing an additional ELF note (NT_DUMP_LEVEL) that will include
> dump_level info.

On your above approach, a member of support team for analysis cannot
know what symbols are erased.
And he/she will not believe the received dumpfile from a customer site.

I have one question, do you think it is better not to inform support
team of the erased symbols ?
Is also the list of the erased symbols secret ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

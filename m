Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzMp7-0006NZ-FP
	for kexec@lists.infradead.org; Tue, 15 Mar 2011 05:29:38 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p2F5TSl3008130
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 16:29:28 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2F5TXB32285674
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 16:29:33 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2F5TW0p020605
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 16:29:33 +1100
Message-ID: <4D7EF934.3090008@linux.vnet.ibm.com>
Date: Tue, 15 Mar 2011 10:59:24 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
References: <20110311075647.14587.50626.stgit@mars.in.ibm.com>
	<1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<20110314114457.7e252f0d.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110314114457.7e252f0d.oomichi@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>, Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Hi Ken'chi,

On 03/14/2011 08:14 AM, Ken'ichi Ohmichi wrote:
> 
> Hi Dave, Mahesh,
> 
> On Fri, 11 Mar 2011 09:07:50 -0500 (EST)
> Dave Anderson <anderson@redhat.com> wrote:
>>>
>>> Please find the makedumpfile enhancement patchset that introduces a data
>>> filtering feature which enables makedumpfile to filter out desired kernel
>>> symbol data and it's members from the specified VMCORE file. The data to be
>>> filtered out is poisoned with character 'X' (58 in Hex).
>>>
>>> This feature will be very useful for the customers who wants to erase the
>>> customer sensitive data like security keys and other confidential data, in
>>> DUMPFILE before sending it to support team for analysis.
>>>
>>> This feature introduces a filter config file where, using filter commands,
>>> user can specify desired kernel data symbols and it's members that need to be
>>> filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
>>> provided in the filter.conf(8) man page.
>>>
>>> The first 4 patches prepares the base work for filtering framework.  The last 2
>>> patches implements the generic filtering framework to erase desired kernel
>>> data.
>>>
>>> I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
>>> kernel. The feature supports filtering data from ELF as well as kdump-compressed
>>> formatted dump.
>>>
>>> Please review the patchset and let me know your comments.
>>>
>>> Thanks,
>>> -Mahesh.
>>
>> Hi Mahesh,
>>
>> Is there any notation in the filtered ELF kdump or compressed kdump file
>> that filtering has been done?  Given that there may be potential ramifications
>> in crash utility behavior (or outright failure?), the crash utility should
>> display a warning message early on during invocation.
> 
> That is a good point.
> 
> How about adding new members (like offset_eraseinfo, size_eraseinfo)
> into the sub header in compressed kdump file, and setting version 5
> in the header version (disk_dump_header.header_version) ?
> These members show the erased information like the following:
> 
> struct kdump_sub_header {
>         unsigned long   phys_base;
>         int             dump_level;     /* header_version 1 and later */
>         int             split;          /* header_version 2 and later */
>         unsigned long   start_pfn;      /* header_version 2 and later */
>         unsigned long   end_pfn;        /* header_version 2 and later */
>         off_t           offset_vmcoreinfo;/* header_version 3 and later */
>         unsigned long   size_vmcoreinfo;  /* header_version 3 and later */
>         off_t           offset_note;      /* header_version 4 and later */
>         unsigned long   size_note;        /* header_version 4 and later */
> +       off_t           offset_eraseinfo; /* header_version 5 and later */
> +       unsigned long   size_eraseinfo;   /* header_version 5 and later */
> };
> 
> The erased information contains only effective lines in the
> configuration file.

Do you mean the info would contain symbol name/expression, resolved
symbol/vmalloc addresses and its sizes that got filtered out?

What I mean by symbol expression is, user can ask makedumpfile to erase
a data referred by a member from the symbol variable of structure type.
e.g.
	struct S1 {
		int a;
	};
	struct S2 {
		struct S1 *mystruct1;
	};

	struct S2 mystruct2;

	#Filter command
	erase mystruct2.mystruct1.a

So the erase information in kdump header would contain:

-----------------------------------
Symbol Name: mystruct2.mystruct1.a
Filter Addr: &mystruct2.mystruct1->a
Filter Size: 4	(sizeof type int)
-----------------------------------

For erase commands in loop construct we will have multiple Filter addresses.

Please let me know your comment on the above format.

Hi Dave,

Do you think the above information would be enough for crash utility to
interpret?

Thanks,
-Mahesh.

> In case of ELF kdump file, how about adding a ELF note section
> which also show the erased information ?
> 
> The crash utility will be able to know the name list of the
> erased symbols from the information.
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

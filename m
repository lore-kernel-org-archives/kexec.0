Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PzVSl-0001w3-62
	for kexec@lists.infradead.org; Tue, 15 Mar 2011 14:43:09 +0000
Date: Tue, 15 Mar 2011 10:43:01 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2104293694.426816.1300200181206.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4D7EF934.3090008@linux.vnet.ibm.com>
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Reinhard <BUENDGEN@de.ibm.com>


----- Original Message -----
>
>Hi Ken'chi,
>
>On 03/14/2011 08:14 AM, Ken'ichi Ohmichi wrote:
>> 
>> Hi Dave, Mahesh,
>> 
>> On Fri, 11 Mar 2011 09:07:50 -0500 (EST)
>> Dave Anderson <anderson at redhat.com> wrote:
>>>>
>>>> Please find the makedumpfile enhancement patchset that introduces a data
>>>> filtering feature which enables makedumpfile to filter out desired kernel
>>>> symbol data and it's members from the specified VMCORE file. The data to be
>>>> filtered out is poisoned with character 'X' (58 in Hex).
>>>>
>>>> This feature will be very useful for the customers who wants to erase the
>>>> customer sensitive data like security keys and other confidential data, in
>>>> DUMPFILE before sending it to support team for analysis.
>>>>
>>>> This feature introduces a filter config file where, using filter commands,
>>>> user can specify desired kernel data symbols and it's members that need to be
>>>> filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
>>>> provided in the filter.conf(8) man page.
>>>>
>>>> The first 4 patches prepares the base work for filtering framework.  The last 2
>>>> patches implements the generic filtering framework to erase desired kernel
>>>> data.
>>>>
>>>> I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
>>>> kernel. The feature supports filtering data from ELF as well as kdump-compressed
>>>> formatted dump.
>>>>
>>>> Please review the patchset and let me know your comments.
>>>>
>>>> Thanks,
>>>> -Mahesh.
>>>
>>> Hi Mahesh,
>>>
>>> Is there any notation in the filtered ELF kdump or compressed kdump file
>>> that filtering has been done?  Given that there may be potential ramifications
>>> in crash utility behavior (or outright failure?), the crash utility should
>>> display a warning message early on during invocation.
>> 
>> That is a good point.
>> 
>> How about adding new members (like offset_eraseinfo, size_eraseinfo)
>> into the sub header in compressed kdump file, and setting version 5
>> in the header version (disk_dump_header.header_version) ?
>> These members show the erased information like the following:
>> 
>> struct kdump_sub_header {
>>         unsigned long   phys_base;
>>         int             dump_level;     /* header_version 1 and later */
>>         int             split;          /* header_version 2 and later */
>>         unsigned long   start_pfn;      /* header_version 2 and later */
>>         unsigned long   end_pfn;        /* header_version 2 and later */
>>         off_t           offset_vmcoreinfo;/* header_version 3 and later */
>>         unsigned long   size_vmcoreinfo;  /* header_version 3 and later */
>>         off_t           offset_note;      /* header_version 4 and later */
>>         unsigned long   size_note;        /* header_version 4 and later */
>> +       off_t           offset_eraseinfo; /* header_version 5 and later */
>> +       unsigned long   size_eraseinfo;   /* header_version 5 and later */
>> };
>> 
>> The erased information contains only effective lines in the
>> configuration file.
>
>Do you mean the info would contain symbol name/expression, resolved
>symbol/vmalloc addresses and its sizes that got filtered out?
>
>What I mean by symbol expression is, user can ask makedumpfile to erase
>a data referred by a member from the symbol variable of structure type.
>e.g.
>	struct S1 {
>		int a;
>	};
>	struct S2 {
>		struct S1 *mystruct1;
>	};
>
>	struct S2 mystruct2;
>
>	#Filter command
>	erase mystruct2.mystruct1.a
>
>So the erase information in kdump header would contain:
>
>-----------------------------------
>Symbol Name: mystruct2.mystruct1.a
>Filter Addr: &mystruct2.mystruct1->a
>Filter Size: 4	(sizeof type int)
>-----------------------------------
>
>For erase commands in loop construct we will have multiple Filter addresses.
>
>Please let me know your comment on the above format.
>
>Hi Dave,
>
>Do you think the above information would be enough for crash utility to
>interpret?

To clarify -- I have *no* plans to *interpret* the filter data.  I just
want to know that filtering has been done, and to display a WARNING 
message early on during crash invocation that it has been done.  And
when things subsequently break, at least the user knows why, and I don't
get a bunch of unexplainable bug reports.

So about as far as I would take it in the crash utility would be for the
"help -n" output to display the filter data strings that are appended to
the dumpfile or stored in an ELF note -- much the same way that VMCOREINFO
data can be dumped.

Dave




>Thanks,
>-Mahesh.
>
>> In case of ELF kdump file, how about adding a ELF note section
>> which also show the erased information ?
>> 
>> The crash utility will be able to know the name list of the
>> erased symbols from the information.
>> 
>> 
>> Thanks
>> Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pz16q-0005jM-A4
	for kexec@lists.infradead.org; Mon, 14 Mar 2011 06:18:30 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p2E6IOKF016294
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 17:18:24 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2E6IOar2064474
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 17:18:24 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2E6INZh016646
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 17:18:24 +1100
Message-ID: <4D7DB32B.9030705@linux.vnet.ibm.com>
Date: Mon, 14 Mar 2011 11:48:19 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
References: <1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Reinhard <BUENDGEN@de.ibm.com>

On 03/11/2011 07:37 PM, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
>> Hi All,
>>
>> Please find the makedumpfile enhancement patchset that introduces a data
>> filtering feature which enables makedumpfile to filter out desired kernel
>> symbol data and it's members from the specified VMCORE file. The data to be
>> filtered out is poisoned with character 'X' (58 in Hex).
>>
>> This feature will be very useful for the customers who wants to erase the
>> customer sensitive data like security keys and other confidential data, in
>> DUMPFILE before sending it to support team for analysis.
>>
>> This feature introduces a filter config file where, using filter commands,
>> user can specify desired kernel data symbols and it's members that need to be
>> filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
>> provided in the filter.conf(8) man page.
>>
>> The first 4 patches prepares the base work for filtering framework.  The last 2
>> patches implements the generic filtering framework to erase desired kernel
>> data.
>>
>> I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
>> kernel. The feature supports filtering data from ELF as well as kdump-compressed
>> formatted dump.
>>
>> Please review the patchset and let me know your comments.
>>
>> Thanks,
>> -Mahesh.
> 
> Hi Mahesh,
> 
> Is there any notation in the filtered ELF kdump or compressed kdump file
> that filtering has been done?  Given that there may be potential ramifications
> in crash utility behavior (or outright failure?), the crash utility should
> display a warning message early on during invocation.

Hmm... I did not think about it. I am thinking of following approach:

- Set a bit in dump_level (DL_FILTER_KERNEL_DATA => 0x800) that will
denote that filtering has been done.
- For compressed kdump file we anyway have dump_level available in kdump
sub header
- For ELF kdump, currently we do not have any way to convey dump_level
info to crash utility (Ken'chi, correct me if I am wrong). How about
introducing an additional ELF note (NT_DUMP_LEVEL) that will include
dump_level info.

Any other suggestions are welcome.

Thanks,
-Mahesh.
> 
> Thanks,
>   Dave
> 
> 
>> ---
>>
>> Mahesh Salgaonkar (6):
>> makedumpfile: Add '--config' option to specify filter config file.
>> makedumpfile: Apply relocation while loading module debuginfo.
>> makedumpfile: Load the module symbol data from vmcore.
>> makedumpfile: Introduce routines to get type name from debuginfo.
>> makedumpfile: Read and process filter commands from config file.
>> makedumpfile: Read and process 'for' command from config file.
>>
>>
>> Makefile | 8
>> filter.conf | 149 ++++
>> filter.conf.8 | 419 +++++++++++
>> makedumpfile.8 | 20 +
>> makedumpfile.c | 2113
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>> makedumpfile.h | 152 ++++
>> 6 files changed, 2782 insertions(+), 79 deletions(-)
>> create mode 100644 filter.conf
>> create mode 100644 filter.conf.8
>>
>> --
>> Signature


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

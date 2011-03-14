Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pz1EV-0005ky-Gg
	for kexec@lists.infradead.org; Mon, 14 Mar 2011 06:26:25 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p2E6QFxx023044
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 17:26:15 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2E6QJWR2367592
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 17:26:19 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2E6QJJD005888
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 17:26:19 +1100
Message-ID: <4D7DB509.5070107@linux.vnet.ibm.com>
Date: Mon, 14 Mar 2011 11:56:17 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
References: <20110311075647.14587.50626.stgit@mars.in.ibm.com>
	<20110314105545.547fbac8.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110314105545.547fbac8.oomichi@mxs.nes.nec.co.jp>
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
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

On 03/14/2011 07:25 AM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Fri, 11 Mar 2011 13:34:32 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
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
>> The first 4 patches prepares the base work for filtering framework. The last 2
>> patches implements the generic filtering framework to erase desired kernel
>> data.
>>
>> I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
>> kernel. The feature supports filtering data from ELF as well as
>> kdump-compressed formatted dump.
>>
>> Please review the patchset and let me know your comments.
> 
> This patchset is interesting, and I start reviewing.
> I haven't reviewed the code yet, and this is a quick review.
> 
> * About the filename of configuration.
>   Is filter.conf only for makedumpfile command ?
>   If so, I feel filter.conf is too generic file name.
>   How about makedumpfile.conf ?

:-) I initially started with that name. But since it was only for
filtering purpose I went for filter.conf. However, I am ok with the name
makdumpfile.conf
> 
>   If makedumpfile.conf, it is clear that the file is only for
>   makedumpfile, and we will be able to use the file for not only
>   erasing secret data but also other purpose.
>   (ex: specifying the other options like -d 31 in the file)

Agree, Makes sense.
> 
> 
> Thanks
> Ken'ichi Ohmichi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

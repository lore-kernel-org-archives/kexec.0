Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWfjX-0002T0-J7
 for kexec@lists.infradead.org; Mon, 08 Aug 2016 08:16:28 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u788EuHF135068
 for <kexec@lists.infradead.org>; Mon, 8 Aug 2016 04:16:06 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nb6wtssc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 04:16:06 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 13:46:02 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0D3733940060
 for <kexec@lists.infradead.org>; Mon,  8 Aug 2016 13:46:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u788G0le40173612
 for <kexec@lists.infradead.org>; Mon, 8 Aug 2016 13:46:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u788Fvbv003871
 for <kexec@lists.infradead.org>; Mon, 8 Aug 2016 13:46:00 +0530
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
 <87h9b0g953.fsf@concordia.ellerman.id.au>
 <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 8 Aug 2016 13:45:50 +0530
MIME-Version: 1.0
In-Reply-To: <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
Message-Id: <be3ba9ef-278e-63cd-8569-2d8228f83aac@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au, ebiederm@xmission.com, vgoyal@redhat.com, linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>



On Friday 05 August 2016 12:23 AM, Hari Bathini wrote:
>
> On Thursday 04 August 2016 03:15 PM, Michael Ellerman wrote:
>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>> ...
>>>   /**
>>>    * fadump_calculate_reserve_size(): reserve variable boot area 5% 
>>> of System RAM
>>>    *
>>> @@ -212,12 +262,17 @@ static inline unsigned long 
>>> fadump_calculate_reserve_size(void)
>>>   {
>>>       unsigned long size;
>>>   +    /* sets fw_dump.reserve_bootvar */
>>> +    parse_fadump_reserve_mem();
>>> +
>>>       /*
>>>        * Check if the size is specified through fadump_reserve_mem= 
>>> cmdline
>>>        * option. If yes, then use that.
>>>        */
>>>       if (fw_dump.reserve_bootvar)
>>>           return fw_dump.reserve_bootvar;
>>> +    else
>>> +        printk(KERN_INFO "fadump: calculating default boot size\n");
>>>         /* divide by 20 to get 5% of value */
>>>       size = memblock_end_of_DRAM() / 20;
>> The code already knows how to reserve 5% based on the size of the 
>> machine's
>> memory, as long as no commandline parameter is passed. So why can't we
>> just use that logic?
>
> Hi Michael,
>
> That is the default value reserved but not a good enough value for
> every case. It is a bit difficult to come up with a robust formula
> that works for every case as new kernel changes could make the
> values obsolete. But it won't be all that difficult to find values that
> work for different memory ranges for a given kernel version.
> Passing that as range based input with "fadump_reserve_mem"
> parameter would work for every memory configuration on a
> given system, which is what this patch is trying to provide..
>

Hi Michael,

You want me to add this to the changelog on respin?

Thanks
Hari

> Thanks
> Hari
>
>
>> cheers
>>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

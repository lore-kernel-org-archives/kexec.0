Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6EKo-0005SY-AX
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 10:17:55 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEAEQ8Z046496
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2016 05:17:32 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26q5u6xhfk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2016 05:17:32 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 15:47:29 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6B81A125805C
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2016 15:48:20 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAEAHRKW26935454
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2016 15:47:27 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAEAHPhc007930
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2016 15:47:26 +0530
Subject: Re: [PATCH 1/3] crash: move crashkernel parsing and vmcore related
 code under CONFIG_CRASH_CORE
References: <147877899077.31483.3740501843050856595.stgit@hbathini.in.ibm.com>
 <147877904646.31483.2251653505359017982.stgit@hbathini.in.ibm.com>
 <20161114053627.GC19995@x1>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 14 Nov 2016 15:47:14 +0530
MIME-Version: 1.0
In-Reply-To: <20161114053627.GC19995@x1>
Message-Id: <bb361dbd-e5ad-fae3-39db-e0a39b6b0fc5@linux.vnet.ibm.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com



On Monday 14 November 2016 11:06 AM, Baoquan He wrote:
> On 11/10/16 at 05:27pm, Hari Bathini wrote:
>> Traditionally, kdump is used to save vmcore in case of a crash. Some
>> architectures like powerpc can save vmcore using architecture specific
>> support instead of kexec/kdump mechanism. Such architecture specific
>> support also needs to reserve memory, to be used by dump capture kernel.
>> crashkernel parameter can be a reused, for memory reservation, by such
>> architecture specific infrastructure.
>>
>> But currently, code related to vmcoreinfo and parsing of crashkernel
>> parameter is built under CONFIG_KEXEC_CORE. This patch introduces
>> CONFIG_CRASH_CORE and moves the above mentioned code under this config,
>> allowing code reuse without dependency on CONFIG_KEXEC. While here,
>> removing the multiple definitions of append_elf_note() and final_note()
>> for one defined under CONFIG_CONFIG_CORE. There is no functional change
>> with this patch.
> Can't think of a reason to object.
>
> Could it be that do the moving from kexec_core.c to crash_core.c only,
> then do the arch specific clean up in another patch?

Right. Will move arch specific code into a separate patch, on the
next version..

> Besides there's already a file crash_dump.h, can we reuse that?

Did think about it. But as it is meant for dump capture kernel
(CONFIG_CRASH_DUMP) and CONFIG_KEXEC_CORE being
independent, didn't pursue it..

Thanks
Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

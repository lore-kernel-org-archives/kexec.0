Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cPC4O-000208-R7
 for kexec@lists.infradead.org; Thu, 05 Jan 2017 17:43:22 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05HdqFj133373
 for <kexec@lists.infradead.org>; Thu, 5 Jan 2017 12:43:00 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ssphay8p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 05 Jan 2017 12:42:59 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 23:12:55 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BEBFBE0045
 for <kexec@lists.infradead.org>; Thu,  5 Jan 2017 23:13:48 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05Hgpfm40697932
 for <kexec@lists.infradead.org>; Thu, 5 Jan 2017 23:12:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05Hgohb020347
 for <kexec@lists.infradead.org>; Thu, 5 Jan 2017 23:12:51 +0530
Subject: Re: [PATCH v3 1/5] crash: move crashkernel parsing and vmcore related
 code under CONFIG_CRASH_CORE
References: <148336637462.25358.5151364413645288219.stgit@hbathini.in.ibm.com>
 <148336641471.25358.1234744226675502511.stgit@hbathini.in.ibm.com>
 <20170105061745.GA9679@dhcp-128-65.nay.redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 5 Jan 2017 23:12:41 +0530
MIME-Version: 1.0
In-Reply-To: <20170105061745.GA9679@dhcp-128-65.nay.redhat.com>
Message-Id: <551a6147-98a2-8d08-8800-192d4d28fba0@linux.vnet.ibm.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, vgoyal@redhat.com

Hi Dave,


On Thursday 05 January 2017 11:47 AM, Dave Young wrote:
> Hi, Hari
>
> On 01/02/17 at 07:43pm, Hari Bathini wrote:
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
>> allowing code reuse without dependency on CONFIG_KEXEC. There is no
>> functional change with this patch.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> ---
>>
>> Changes from v2:
>> * Used CONFIG_CRASH_CORE instead of CONFIG_KEXEC_CORE at
>>    appropriate places in printk and ksysfs.
>>
>>
>>   arch/Kconfig               |    4
>>   include/linux/crash_core.h |   65 ++++++
>>   include/linux/kexec.h      |   57 ------
>>   include/linux/printk.h     |    4
>>   kernel/Makefile            |    1
>>   kernel/crash_core.c        |  445 ++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/kexec_core.c        |  404 ----------------------------------------
>>   kernel/ksysfs.c            |    8 +
>>   kernel/printk/printk.c     |    6 -
>>   9 files changed, 531 insertions(+), 463 deletions(-)
>>   create mode 100644 include/linux/crash_core.h
>>   create mode 100644 kernel/crash_core.c
>>
> [snip]
>
>>   #ifndef CONFIG_TINY_RCU
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 8b26964..d0dfebd 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -32,7 +32,7 @@
>>   #include <linux/bootmem.h>
>>   #include <linux/memblock.h>
>>   #include <linux/syscalls.h>
>> -#include <linux/kexec.h>
>> +#include <linux/crash_core.h>
>>   #include <linux/kdb.h>
>>   #include <linux/ratelimit.h>
>>   #include <linux/kmsg_dump.h>
>> @@ -951,7 +951,7 @@ const struct file_operations kmsg_fops = {
>>   	.release = devkmsg_release,
>>   };
>>   
>> -#ifdef CONFIG_KEXEC_CORE
>> +#ifdef CONFIG_CRASH_CORE
>>   /*
>>    * This appends the listed symbols to /proc/vmcore
>>    *
>> @@ -960,7 +960,7 @@ const struct file_operations kmsg_fops = {
>>    * symbols are specifically used so that utilities can access and extract the
>>    * dmesg log from a vmcore file after a crash.
>>    */
>> -void log_buf_kexec_setup(void)
>> +void log_buf_crash_setup(void)
> I can not think of any better name about the CONFIG_CRASH_CORE though I
> feel it is not excellent so personally I can live with it.
>
> But for this function name log_buf_crash_setup is too general, I can not get
> what it is doing from the name, how about change it to log_buf_vmcoreinfo_setup

log_buf_vmcoreinfo_setup is appropriate.  Also dropped hard-coded values
for DIV_ROUND_UP().
Posted v4 with these changes..

Thanks
Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

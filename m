Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1drKZl-0002oP-50
 for kexec@lists.infradead.org; Mon, 11 Sep 2017 09:00:30 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8B8x1OF072121
 for <kexec@lists.infradead.org>; Mon, 11 Sep 2017 04:59:55 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cwcybrnjs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 11 Sep 2017 04:59:55 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 11 Sep 2017 18:59:52 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8B8xpnw35651774
 for <kexec@lists.infradead.org>; Mon, 11 Sep 2017 18:59:51 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8B8xhrP014618
 for <kexec@lists.infradead.org>; Mon, 11 Sep 2017 18:59:43 +1000
Subject: Re: [Makedumpfile PATCH] book3s/ppc64: Lower the max real address to
 53 bits for kernels >= v4.11
References: <1504845625-27408-1-git-send-email-bhsharma@redhat.com>
 <20170911013522.GA2704@dhcp-128-65.nay.redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 11 Sep 2017 14:29:45 +0530
MIME-Version: 1.0
In-Reply-To: <20170911013522.GA2704@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
Message-Id: <41ff60d5-7010-87f4-b861-6e83e374b0c8@linux.vnet.ibm.com>
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
To: Dave Young <dyoung@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, piliu@redhat.com, bhe@redhat.com


On Monday 11 September 2017 07:05 AM, Dave Young wrote:
> Cc more people.
>
> On 09/08/17 at 10:10am, Bhupesh Sharma wrote:
>> Kernel commit 2f18d533757da3899f4bedab0b2c051b080079dc lowered the
>> max real address on ppc64 to 53 bits.
>>
>> Make similar changes in makedumpfile (on basis of the underlying kernel
>> version), without which the makedumpfile will fail to create a dumpfile
>> and instead throw a SEGV fault as shown below on kernels >= v4.11:
>>
>>   # makedumpfile --split -d 31 -x vmlinux vmcore dumpfile_{1,2,3} 2>&1
>>
>>   The kernel version is not supported.
>>   The makedumpfile operation may be incomplete.
>>   [ 1196.252094] makedumpfile[2367]: unhandled signal 11 at
>>   00000100f7011ca8 nip 000000001001eecc lr 000000001001f3c0 code 30001
>>   Segmentation fault

I have not hit the above problem, but for the sake of correctness,
this patch is needed for >= 4.11.0 kernels. So..

Acked-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   makedumpfile.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 7d81bbcf2234..142753d84e8d 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -684,8 +684,9 @@ unsigned long get_kvbase_arm64(void);
>>   #define PMD_MASKED_BITS_64K_4_6  0xc0000000000000ffUL
>>   
>>   #define PTE_RPN_MASK_DEFAULT  0xffffffffffffffffUL
>> -#define PTE_RPN_SIZE_L4_4_6   (info->page_size == 65536 ? 41 : 45)
>> -#define PTE_RPN_MASK_L4_4_6   (((1UL << PTE_RPN_SIZE_L4_4_6) - 1) << info->page_shift)
>> +#define PAGE_PA_MAX_L4_4_6    (info->kernel_version >= KERNEL_VERSION(4,11,0) ? 53 : 57)
>> +#define PTE_RPN_MASK_L4_4_6   \
>> +	(((1UL << PAGE_PA_MAX_L4_4_6) - 1) & ~((1UL << info->page_shift) - 1))
>>   #define PTE_RPN_SHIFT_L4_4_6  info->page_shift
>>   
>>   #define PGD_MASKED_BITS_4_7  0xc0000000000000ffUL
>> -- 
>> 2.7.4
>>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

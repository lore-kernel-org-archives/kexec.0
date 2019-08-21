Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0FBZ-0006RG-EZ
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 01:13:14 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7L1CW6T075466
 for <kexec@lists.infradead.org>; Tue, 20 Aug 2019 21:13:12 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ugsqwvrn6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 20 Aug 2019 21:13:12 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Wed, 21 Aug 2019 02:13:11 +0100
References: <20190715082702.27308-1-svens@stackframe.org>
 <20190715082702.27308-5-svens@stackframe.org>
 <87v9urmixq.fsf@morokweng.localdomain>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] kexec_elf: remove PURGATORY_STACK_SIZE
In-reply-to: <87v9urmixq.fsf@morokweng.localdomain>
Date: Tue, 20 Aug 2019 22:13:01 -0300
MIME-Version: 1.0
Message-Id: <87o90jmici.fsf@morokweng.localdomain>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Sven Schnelle <svens@stackframe.org> writes:
>
>> It's not used anywhere so just drop it.
>>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>>  kernel/kexec_elf.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
>> index effe9dc0b055..70d31b8feeae 100644
>> --- a/kernel/kexec_elf.c
>> +++ b/kernel/kexec_elf.c
>> @@ -8,8 +8,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>  
>> -#define PURGATORY_STACK_SIZE	(16 * 1024)
>> -
>>  #define elf_addr_to_cpu	elf64_to_cpu
>>  
>>  #ifndef Elf_Rel
>
> Can you remove it from the file in arch/powerpc as well?

Sorry, forgot to add:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

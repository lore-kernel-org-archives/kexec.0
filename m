Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFwqy-00030E-Rm
 for kexec@lists.infradead.org; Thu, 03 Oct 2019 08:52:54 +0000
Subject: Re: [PATCH] kexec-tools: Fix conversion overflow when compiling on
 32-bit platforms
References: <20191001151416.GA25667@ls3530.fritz.box>
 <20191003081406.5qmzlmlpwobydfok@verge.net.au>
From: Helge Deller <deller@gmx.de>
Message-ID: <2ac17dd1-99ef-3528-a05e-d51f8af01c95@gmx.de>
Date: Thu, 3 Oct 2019 10:52:37 +0200
MIME-Version: 1.0
In-Reply-To: <20191003081406.5qmzlmlpwobydfok@verge.net.au>
Content-Language: en-US
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
To: Simon Horman <horms@verge.net.au>
Cc: Sven Schnelle <svens@stackframe.org>, kexec@lists.infradead.org

On 03.10.19 10:14, Simon Horman wrote:
> On Tue, Oct 01, 2019 at 05:14:16PM +0200, Helge Deller wrote:
>> When compiling kexec-tools on a 32-bit platform, assigning an
>> (unsigned long long) value to an (unsigned long) variable creates
>> this warning:
>>
>> elf_info.c: In function 'read_phys_offset_elf_kcore':
>> elf_info.c:805:14: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295'
>>    805 |  *phys_off = UINT64_MAX;
>>        |              ^~~~~~~~~~
>>
>> Fix it by casting UINT64_MAX to (unsigned long) before storing it to *phys_off.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
>> index 2bce5cb..4d16983 100644
>> --- a/util_lib/elf_info.c
>> +++ b/util_lib/elf_info.c
>> @@ -802,7 +802,7 @@ int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
>>   {
>>   	int ret;
>>
>> -	*phys_off = UINT64_MAX;
>> +	*phys_off = (unsigned long) UINT64_MAX;
>
> This seems to mask the problem that UINT64_MAX is not the right
> initialiser for unsigned long values on 32-bit platforms.
> Could we consider using UINT64_MAX from limits.h instead?

UINT64 means it is a 64bit value, while "unsigned long" is either 32-bit,
64bit (or maybe in the future even 128bit?).
Even assigning UINT32_MAX on a 32bit platform might be wrong.
So I think the cast above is probably the best solution.

Helge

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

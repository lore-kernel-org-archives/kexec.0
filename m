Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dAyQS-0002iT-Dk
 for kexec@lists.infradead.org; Wed, 17 May 2017 12:51:38 +0000
Subject: Re: [PATCH] Handle additional e820 memmap type strings
References: <1494432217-26092-1-git-send-email-eric.devolder@oracle.com>
 <20170515140711.GB21797@x1>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <ff7c75d3-2b12-fe7a-8ede-ec04a6161665@oracle.com>
Date: Wed, 17 May 2017 07:51:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170515140711.GB21797@x1>
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
To: Baoquan He <bhe@redhat.com>
Cc: andrew.cooper3@citrix.com, daniel.kiper@oracle.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com



On 05/15/2017 09:07 AM, Baoquan He wrote:
> On 05/10/17 at 11:03am, Eric DeVolder wrote:
>> Keep pace with changes to linux arch/x86/kernel/e820.c to
>> function e820_type_to_string(). With this change, the following
>> messages from kexec are eliminated (and allows kexec to load):
>>
>>   Unknown type (Reserved) while parsing /sys/firmware/memmap/8/type.
>>   Please report this as bug. Using RANGE_RESERVED now.
>>
>>   Unknown type (Unknown E820 type) while parsing /sys/firmware/memmap/4/type.
>>   Please report this as bug. Using RANGE_RESERVED now.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   kexec/firmware_memmap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
>> index 4d84f00..1ee214a 100644
>> --- a/kexec/firmware_memmap.c
>> +++ b/kexec/firmware_memmap.c
>> @@ -164,6 +164,10 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
>>   		range->type = RANGE_RESERVED;
>>   	else if (strcmp(type, "reserved") == 0)
>>   		range->type = RANGE_RESERVED;
>> +	else if (strcmp(type, "Reserved") == 0)
>> +		range->type = RANGE_RESERVED;
>> +	else if (strcmp(type, "Unknown E820 type") == 0)
>> +		range->type = RANGE_RESERVED;
> 
> Should we change the "reserved" one to "Reserved" so that we don't need
> to have "reserved" and "Reserved" at the same time?

The lower-case "reserved" has been in use by the kernel for quite a long 
while, and upper-case "Reserved" has been recently introduced. I think 
removing lower-case "reserved" would result in problems with existing, 
older, kernels that still would be using "reserved".

> 
>>   	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
>>   		range->type = RANGE_ACPI_NVS;
>>   	else if (strcmp(type, "Uncached RAM") == 0)
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

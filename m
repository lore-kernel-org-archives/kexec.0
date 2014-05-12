Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wjhwp-0005hb-3e
 for kexec@lists.infradead.org; Mon, 12 May 2014 04:34:44 +0000
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 12 May 2014 10:04:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id F31AF1258059
 for <kexec@lists.infradead.org>; Mon, 12 May 2014 10:03:17 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4C4YQcI11338202
 for <kexec@lists.infradead.org>; Mon, 12 May 2014 10:04:26 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4C4YGHd019067
 for <kexec@lists.infradead.org>; Mon, 12 May 2014 10:04:16 +0530
Message-ID: <53704F48.1030903@linux.vnet.ibm.com>
Date: Mon, 12 May 2014 10:04:16 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/ppc64: Handle reserved memory ranges exported by
 OPAL firmware.
References: <20140209165544.29624.91745.stgit@mars>
 <20140510235144.GK31760@verge.net.au>
In-Reply-To: <20140510235144.GK31760@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>

On 05/11/2014 05:21 AM, Simon Horman wrote:
> On Sun, Feb 09, 2014 at 10:25:45PM +0530, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> OPAL based system exports reserved memory ranges through /proc/device-tree
>> for the regions that are reserved by OPAL firmware. Traverse
>> /proc/device-tree/reserved-ranges and add them to exclude_ranges[] and
>> reserve them.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> I apologise that this seems to have slipped through the cracks.
> Manesh, is this patch still needed?

Yup. We need this also.

 If so, is it possible for
> someone on the power side of things to review it?
> 
>> ---
>>  kexec/arch/ppc64/kexec-ppc64.c |   44 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
>> index 5956836..6e79f52 100644
>> --- a/kexec/arch/ppc64/kexec-ppc64.c
>> +++ b/kexec/arch/ppc64/kexec-ppc64.c
>> @@ -31,6 +31,7 @@
>>  #include "../../kexec.h"
>>  #include "../../kexec-syscall.h"
>>  #include "kexec-ppc64.h"
>> +#include "../../fs2dt.h"
>>  #include "crashdump-ppc64.h"
>>  #include <arch/options.h>
>>  
>> @@ -314,6 +315,47 @@ static int sort_ranges(void)
>>  	return 0;
>>  }
>>  
>> +void scan_reserved_ranges(unsigned long kexec_flags, int *range_index)
>> +{
>> +	char fname[256], buf[16];
>> +	FILE *file;
>> +	int i = *range_index;
>> +
>> +	strcpy(fname, "/proc/device-tree/reserved-ranges");
>> +
>> +	file = fopen(fname, "r");
>> +	if (file == NULL) {
>> +		if (errno != ENOENT) {
>> +			perror(fname);
>> +			return;
>> +		}
>> +		errno = 0;
>> +		/* File not present. Non PowerKVM system. */
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Each reserved range is an (address,size) pair, 2 cells each,
>> +	 * totalling 4 cells per range.
>> +	 */
>> +	while (fread(buf, sizeof(uint64_t) * 2, 1, file) == 1) {
>> +		uint64_t base, size;
>> +
>> +		base = be64_to_cpu(((uint64_t *)buf)[0]);
>> +		size = be64_to_cpu(((uint64_t *)buf)[1]);
>> +
>> +		exclude_range[i].start = base;
>> +		exclude_range[i].end = base + size;
>> +		i++;
>> +		if (i >= max_memory_ranges)
>> +			realloc_memory_ranges();
>> +
>> +		reserve(base, size);
>> +	}
>> +	fclose(file);
>> +	*range_index = i;
>> +}
>> +
>>  /* Get devtree details and create exclude_range array
>>   * Also create usablemem_ranges for KEXEC_ON_CRASH
>>   */
>> @@ -339,6 +381,8 @@ static int get_devtree_details(unsigned long kexec_flags)
>>  		return -1;
>>  	}
>>  
>> +	scan_reserved_ranges(kexec_flags, &i);
>> +
>>  	while ((dentry = readdir(dir)) != NULL) {
>>  		if (strncmp(dentry->d_name, "chosen", 6) &&
>>  			strncmp(dentry->d_name, "memory@", 7) &&
>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

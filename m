Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWNUX-0002xA-7H
 for kexec@lists.infradead.org; Wed, 16 Oct 2013 09:34:10 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 10:33:47 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 77E6A17D8057
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 10:34:09 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G9XWKX61997246
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 09:33:32 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G9XiOg012432
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 03:33:44 -0600
Message-ID: <525E5D77.8090109@linux.vnet.ibm.com>
Date: Wed, 16 Oct 2013 11:33:43 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/fs2dt: fix endianess conversion
References: <20131015170528.10192.71185.stgit@nimbus>
 <20131016072826.GC29696@verge.net.au>
In-Reply-To: <20131016072826.GC29696@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 16/10/2013 09:28, Simon Horman wrote:
> On Tue, Oct 15, 2013 at 07:05:28PM +0200, Laurent Dufour wrote:
>> While reviewing fs2dt.c in the common kexec directory, in order to use it to
>> support little endian ppc64 architecture, I found some endianess
>> conversion's issues.
>>
>> In dt_reserve, dt_base is a pointer and thus should not be converted.
>>
>> In checkprop, values read from the device tree are big endian encoded and
>> should be converted if CPU is running in little endian mode.
>>
>> In add_dyn_reconf_usable_mem_property__, fix extraneous endianess conversion
>> of rlen which should be natively used to increase the dt pointer.
> 
> These changes seem logical to me.
> 
> However, I'm unsure how the code might have worked as-is.
> In particular I'm pretty sure ARM was running in little endian
> mode when I worked on DT support for it. Perhaps these code
> paths were not executed. Or the errors cancelled themselves out somehow?

I've to admit that I don't know how this has worked for ARM.
I run this patch with a set of change I'm working on to support PPC64
little endian architecture. My tests were done with kexec-tools built in
little endian mode, using this fs2dt.c file and I need this fix to build
a valid device tree.

The fix is dt_reserve is hit unless the device tree is large enough. I
had to reduce INIT_TREE_WORDS to hit it.

I think the ones in checkprop, add_dyn_reconf_usable_mem_property__  are
Power specific since RTAS and 'ibm,dynamic-memory' are required to hit them.

This may explain why this issue are not seen in ARM mode.

This being said, I wondering if the files fs2dt.c defined in the
arch/ppc64 and arch/ppc directories need to be kept. What do you think
about removing those files and belong on the common kexec/fs2dt.c file
for all the supported architecture ?

Cheers,
Laurent.

>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  kexec/fs2dt.c |   19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
>> index 242a15e..5d774ae 100644
>> --- a/kexec/fs2dt.c
>> +++ b/kexec/fs2dt.c
>> @@ -84,7 +84,7 @@ static void dt_reserve(unsigned **dt_ptr, unsigned words)
>>  		offset = *dt_ptr - dt_base;
>>  		dt_base = new_dt;
>>  		dt_cur_size = new_size;
>> -		*dt_ptr = cpu_to_be32((unsigned)dt_base + offset);
>> +		*dt_ptr = dt_base + offset;
>>  		memset(*dt_ptr, 0, (new_size - offset)*4);
>>  	}
>>  }
>> @@ -112,19 +112,22 @@ static void checkprop(char *name, unsigned *data, int len)
>>  	if ((data == NULL) && (base || size || end))
>>  		die("unrecoverable error: no property data");
>>  	else if (!strcmp(name, "linux,rtas-base"))
>> -		base = *data;
>> +		base = be32_to_cpu(*data);
>>  	else if (!strcmp(name, "linux,tce-base"))
>> -		base = *(unsigned long long *) data;
>> +		base = be64_to_cpu(*(unsigned long long *) data);
>>  	else if (!strcmp(name, "rtas-size") ||
>>  			!strcmp(name, "linux,tce-size"))
>> -		size = *data;
>> +		size = be32_to_cpu(*data);
>>  	else if (reuse_initrd && !strcmp(name, "linux,initrd-start"))
>>  		if (len == 8)
>> -			base = *(unsigned long long *) data;
>> +			base = be64_to_cpu(*(unsigned long long *) data);
>>  		else
>> -			base = *data;
>> +			base = be32_to_cpu(*data);
>>  	else if (reuse_initrd && !strcmp(name, "linux,initrd-end"))
>> -		end = *(unsigned long long *) data;
>> +		if (len == 8)
>> +			end = be64_to_cpu(*(unsigned long long *) data);
>> +		else
>> +			end = be32_to_cpu(*data);
>>  
>>  	if (size && end)
>>  		die("unrecoverable error: size and end set at same time\n");
>> @@ -267,7 +270,7 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
>>  	pad_structure_block(rlen);
>>  	memcpy(dt, ranges, rlen);
>>  	free(ranges);
>> -	dt += cpu_to_be32((rlen + 3)/4);
>> +	dt += (rlen + 3)/4;
>>  }
>>  
>>  static void add_dyn_reconf_usable_mem_property(struct dirent *dp, int fd)
>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

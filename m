Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0VMy-0000C8-Ix
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 19:34:37 +0000
Subject: Re: [RESEND PATCH v5 06/11] ppc64/kexec_file: restrict memory usage
 of kdump kernel
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579231812.5790.16096865978767385505.stgit@hbathini>
 <875za77o05.fsf@mpe.ellerman.id.au>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <23c4e7a2-6fbc-8007-5e9a-35c3a4d3898b@linux.ibm.com>
Date: Wed, 29 Jul 2020 01:04:22 +0530
MIME-Version: 1.0
In-Reply-To: <875za77o05.fsf@mpe.ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>



On 28/07/20 7:14 pm, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>> index 2df6f4273ddd..8df085a22fd7 100644
>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -17,9 +17,21 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/libfdt.h>
>> +#include <linux/of_device.h>
>>   #include <linux/memblock.h>
>> +#include <linux/slab.h>
>> +#include <asm/drmem.h>
>>   #include <asm/kexec_ranges.h>
>>   
>> +struct umem_info {
>> +	uint64_t *buf; /* data buffer for usable-memory property */
>> +	uint32_t idx;  /* current index */
>> +	uint32_t size; /* size allocated for the data buffer */
> 
> Use kernel types please, u64, u32.
> 
>> +	/* usable memory ranges to look up */
>> +	const struct crash_mem *umrngs;
> 
> "umrngs".
> 
> Given it's part of the umem_info struct could it just be "ranges"?

True. Actually, having crash_mem_range *ranges + u32 nr_ranges and 
populating them seems better. Will do that..

>> +		return NULL;
>> +	}
> 
> 	um_info->size = new_size;
> 
>> +
>> +	memset(tbuf + um_info->idx, 0, MEM_RANGE_CHUNK_SZ);
> 
> Just pass __GFP_ZERO to krealloc?

There are patches submitted to stable fixing a few modules that use 
krealloc with __GFP_ZERO. Also, this zeroing is not really needed.
I will drop the memset instead..

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

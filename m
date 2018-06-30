Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fZMtH-00034y-Ry
 for kexec@lists.infradead.org; Sat, 30 Jun 2018 20:54:45 +0000
Received: by mail-pf0-f196.google.com with SMTP id h20-v6so3807274pfn.4
 for <kexec@lists.infradead.org>; Sat, 30 Jun 2018 13:54:33 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-ops: Add helper API to dump fdt blob
References: <1529576678-14615-1-git-send-email-bhsharma@redhat.com>
 <1529576678-14615-2-git-send-email-bhsharma@redhat.com>
 <20180627120205.w64fzgcaydyip6x3@verge.net.au>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <7b256358-34b1-6558-27a8-ade5a2788481@redhat.com>
Date: Sun, 1 Jul 2018 02:24:24 +0530
MIME-Version: 1.0
In-Reply-To: <20180627120205.w64fzgcaydyip6x3@verge.net.au>
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
Cc: dyoung@redhat.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org, james.morse@arm.com, takahiro.akashi@linaro.org

Hi Simon,

Thanks for the review. Please see my comments inline.

On 06/27/2018 05:32 PM, Simon Horman wrote:
> On Thu, Jun 21, 2018 at 03:54:37PM +0530, Bhupesh Sharma wrote:
>> At several occasions it would be useful to dump the fdt
>> blob being passed to the second (kexec/kdump) kernel
>> when '-d' flag is specified while invoking kexec/kdump.
>>
>> This allows one to look at the device-tree fields that
>> is being passed to the secondary kernel and accordingly
>> debug issues.
>>
>> This can be specially useful for the arm64 case, where
>> kexec_load() or kdump passes important information like
>> 'linux,usable-memory' ranges to the second kernel, and
>> the correctness of the ranges can be verified by
>> looking at the device-tree dump with '-d' flag specified.
>>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   kexec/dt-ops.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   kexec/dt-ops.h |   1 +
>>   2 files changed, 142 insertions(+)
>>
>> diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
>> index 915dbf55afd2..80ebfd31b4b6 100644
>> --- a/kexec/dt-ops.c
>> +++ b/kexec/dt-ops.c
>> @@ -8,6 +8,10 @@
>>   #include "kexec.h"
>>   #include "dt-ops.h"
>>   
>> +#define ALIGN(x, a)	(((x) + ((a) - 1)) & ~((a) - 1))
>> +#define PALIGN(p, a)	((void *)(ALIGN((unsigned long)(p), (a))))
>> +#define GET_CELL(p)	(p += 4, *((const uint32_t *)(p - 4)))
>> +
> 
> I see the above in scripts/dtc/util.c in the kernel tree, which is licensed
> GPL v2, whereas this file is licensed GPL v2 or later. Is there is
> also a published GPL v2 or later version somewhere?

Indeed, it is published in several places.
libfdt is GPL/BSD dual-licensed, i.e., it may be used
either under the terms of the GPL, or under the terms of the 2-clause
BSD license (aka the ISC license). See 
<https://github.com/dgibson/dtc/blob/master/README.license> for details.

I am not sure if we will have licensing issues with including a GPL/BSD 
dual-licensed code in a GPL v2 or later code. I think it should be ok, 
but IANAL :)

Do you see any possible licensing conflicts here?

>>   static const char n_chosen[] = "/chosen";
>>   
>>   static const char p_bootargs[] = "bootargs";
>> @@ -143,3 +147,140 @@ int dtb_delete_property(char *dtb, const char *node, const char *prop)
>>   
>>   	return result;
>>   }
>> +
>> +static uint64_t is_printable_string(const void* data, uint64_t len)
> 
> uint64_t seems to be a strange return type. Perhaps bool would be best.
> 
>> +{
>> +	const char *s = data;
>> +	const char *ss;
> 
> I think naming s as str and ss as start would enhance
> code readability.

Sure, will fix this in v5.

>> +
>> +	/* Check for zero length strings */
>> +	if (len == 0)
>> +		return 0;
>> +
>> +	/* String must be terminated with a '\0' */
>> +	if (s[len - 1] != '\0')
>> +		return 0;
>> +
>> +	ss = s;
>> +	while (*s)
>> +		s++;
>> +
>> +	/* Traverse till we hit a '\0' or reach 'len' */
>> +	if (*s != '\0')
>> +		return 0;
> 
> The two conditions above are: while s is not 0; if s != 0.
> How can the if condition ever be true?
> 
> Also, do you want to check that the characters traversed are printable?
> If not perhaps the name of the function should change.

Ok.

>> +
>> +	if ((s + 1 - ss) < len) {
>> +		/* Handle special cases such as 'bootargs' properties
>> +		 * in dtb which are actually strings, but they may have
>> +		 * a format where (s + 1 - ss) < len remains true.
>> +		 *
>> +		 * We can catch such cases by checking if (s + 1 - ss)
>> +		 * is greater than 1
>> +		 */
>> +		if ((s + 1 - ss) > 1)
>> +			return 1;
> 
> Is this covering the case where null-terminated strings are imeded in 'data'?
> And ensuring that the is at least one non-null byte in the first string?
> If so, I think the comment could be improved, explaining things in terms of
> multiple strings. And I'm not sure you need the outermost if condition.

Yes, I can improve the comment to explain the condition you mentioned above.

>> +
>> +		return 0;
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +static void print_data(const char* data, uint64_t len)
>> +{
>> +	uint64_t i;
>> +	const char *p_data = data;
>> +
>> +	/* Check for non-zero length */
>> +	if (len == 0)
>> +		return;
>> +
>> +	if (is_printable_string(data, len)) {
>> +		dbgprintf(" = \"%s\"", (const char *)data);
>> +	} else if ((len % 4) == 0) {
>> +		dbgprintf(" = <");
>> +		for (i = 0; i < len; i += 4) {
>> +			dbgprintf("0x%08x%s",
>> +					fdt32_to_cpu(GET_CELL(p_data)),
>> +					i < (len - 4) ? " " : "");
>> +		}
>> +		dbgprintf(">");
> 
> Is there a performance benefit of using fdt32_to_cpu()
> that justifies the extra complexity here?

Yes, I see that fdt32_to_cpu() is considerably faster as compared to 
other implementations I tried.

>> +	} else {
>> +		dbgprintf(" = [");
>> +		for (i = 0; i < len; i++)
>> +			dbgprintf("%02x%s", *p_data++,
>> +					i < len - 1 ? " " : "");
>> +		dbgprintf("]");
>> +	}
>> +}
>> +
>> +void dump_fdt(void* fdt)
>> +{
>> +	struct fdt_header *bph;
>> +	const char* p_struct;
>> +	const char* p_strings;
>> +	const char* p_data;
>> +	const char* s_data;
>> +	uint32_t off_dt;
>> +	uint32_t off_str;
>> +	uint32_t tag;
>> +	uint64_t sz;
>> +	uint64_t depth;
>> +	uint64_t shift;
> 
> Can they type of depth and shift be int?
> It would avoid the (int) casting below.

Hmm. I am not sure, but I can try and use 'int' in v5, if things work 
fine during local checks.

>> +	uint32_t version;
>> +
>> +	depth = 0;
>> +	shift = 4;
>> +
>> +	bph = fdt;
>> +	off_dt = fdt32_to_cpu(bph->off_dt_struct);
>> +	off_str = fdt32_to_cpu(bph->off_dt_strings);
>> +	p_struct = (const char*)fdt + off_dt;
>> +	p_strings = (const char*)fdt + off_str;
>> +	version = fdt32_to_cpu(bph->version);
>> +
>> +	p_data = p_struct;
>> +	while ((tag = fdt32_to_cpu(GET_CELL(p_data))) != FDT_END) {
>> +		if (tag == FDT_BEGIN_NODE) {
>> +			s_data = p_data;
>> +			p_data = PALIGN(p_data + strlen(s_data) + 1, 4);
>> +
>> +			if (*s_data == '\0')
>> +				s_data = "/";
>> +
>> +			dbgprintf("%*s%s {\n", (int)(depth * shift), " ", s_data);
>> +
>> +			depth++;
>> +			continue;
>> +		}
>> +
>> +		if (tag == FDT_END_NODE) {
>> +			depth--;
>> +
>> +			dbgprintf("%*s};\n", (int)(depth * shift), " ");
>> +			continue;
>> +		}
>> +
>> +		if (tag == FDT_NOP) {
>> +			dbgprintf("%*s// [NOP]\n", (int)(depth * shift), " ");
>> +			continue;
>> +		}
>> +
>> +		if (tag != FDT_PROP) {
>> +			dbgprintf("%*s ** Unknown tag 0x%08x\n",
>> +					(int)(depth * shift), " ", tag);
>> +			break;
>> +		}
>> +
>> +		sz = fdt32_to_cpu(GET_CELL(p_data));
>> +		s_data = p_strings + fdt32_to_cpu(GET_CELL(p_data));
>> +		if (version < 16 && sz >= 8)
>> +			p_data = PALIGN(p_data, 8);
>> +
>> +		dbgprintf("%*s%s", (int)(depth * shift), " ", s_data);
>> +		print_data(p_data, sz);
>> +		dbgprintf(";\n");
>> +
>> +		p_data = PALIGN(p_data + sz, 4);
>> +	}
>> +}
>> diff --git a/kexec/dt-ops.h b/kexec/dt-ops.h
>> index e70d15d8ffbf..25b9b569f2b7 100644
>> --- a/kexec/dt-ops.h
>> +++ b/kexec/dt-ops.h
>> @@ -9,5 +9,6 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
>>   	const char *prop, const void *value, int value_len);
>>   
>>   int dtb_delete_property(char *dtb, const char *node, const char *prop);
>> +void dump_fdt(void *fdt) ;
>>   
>>   #endif
>> -- 
>> 2.7.4
>>

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVNxH-0003TG-HW
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 19:05:20 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74J4Eh3056403
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 15:04:58 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkahces0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 04 Aug 2016 15:04:58 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 05:04:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 385CE3578052
 for <kexec@lists.infradead.org>; Fri,  5 Aug 2016 05:04:53 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74J4rr922413534
 for <kexec@lists.infradead.org>; Fri, 5 Aug 2016 05:04:53 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74J4q4Z013297
 for <kexec@lists.infradead.org>; Fri, 5 Aug 2016 05:04:53 +1000
Subject: Re: [RESEND][PATCH v2 1/2] kexec: refactor code parsing size based on
 memory range
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025276793.29229.17307767327276387636.stgit@hbathini.in.ibm.com>
 <20160804092654.GA23001@dhcp-128-65.nay.redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 5 Aug 2016 00:34:48 +0530
MIME-Version: 1.0
In-Reply-To: <20160804092654.GA23001@dhcp-128-65.nay.redhat.com>
Message-Id: <219ccf59-df37-e9ee-d339-71f57c30a700@linux.vnet.ibm.com>
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
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, ebiederm@xmission.com, vgoyal@redhat.com

Hi Dave


Thanks for the review..


On Thursday 04 August 2016 02:56 PM, Dave Young wrote:
> Hi Hari,
>
> On 08/04/16 at 01:03am, Hari Bathini wrote:
>> crashkernel parameter supports different syntaxes to specify the amount
>> of memory to be reserved for kdump kernel. Below is one of the supported
>> syntaxes that needs parsing to find the memory size to reserve, based on
>> memory range:
>>
>>          crashkernel=<range1>:<size1>[,<range2>:<size2>,...]
>>
>> While such parsing is implemented for crashkernel parameter, it applies
>> to other parameters, like fadump_reserve_mem=, which could use similar
>> syntax. This patch moves crashkernel's parsing code for above syntax to
>> to kernel/params.c file for reuse. Two functions is_param_range_based()
>> and parse_mem_range_size() are added to kernel/params.c file for this
>> purpose.
>>
>> Any parameter that uses the above syntax can use is_param_range_based()
>> function to validate the syntax and parse_mem_range_size() function to
>> get the parsed memory size. While some code is moved to kernel/params.c
>> file, there is no change functionality wise in parsing the crashkernel
>> parameter.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> ---
>>
>> Changes from v1:
>> 1. Updated changelog
>>
>>   include/linux/kernel.h |    5 +++
>>   kernel/kexec_core.c    |   63 +++-----------------------------
>>   kernel/params.c        |   96 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 106 insertions(+), 58 deletions(-)
>>
>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>> index d96a611..2df7ba2 100644
>> --- a/include/linux/kernel.h
>> +++ b/include/linux/kernel.h
>> @@ -435,6 +435,11 @@ extern char *get_options(const char *str, int nints, int *ints);
>>   extern unsigned long long memparse(const char *ptr, char **retptr);
>>   extern bool parse_option_str(const char *str, const char *option);
>>   
>> +extern bool __init is_param_range_based(const char *cmdline);
>> +extern unsigned long long __init parse_mem_range_size(const char *param,
>> +						      char **str,
>> +						      unsigned long long system_ram);
>> +
>>   extern int core_kernel_text(unsigned long addr);
>>   extern int core_kernel_data(unsigned long addr);
>>   extern int __kernel_text_address(unsigned long addr);
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 5616755..3a74024 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -1104,59 +1104,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
>>   	char *cur = cmdline, *tmp;
>>   
>>   	/* for each entry of the comma-separated list */
>> -	do {
>> -		unsigned long long start, end = ULLONG_MAX, size;
>> -
>> -		/* get the start of the range */
>> -		start = memparse(cur, &tmp);
>> -		if (cur == tmp) {
>> -			pr_warn("crashkernel: Memory value expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur = tmp;
>> -		if (*cur != '-') {
>> -			pr_warn("crashkernel: '-' expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur++;
>> -
>> -		/* if no ':' is here, than we read the end */
>> -		if (*cur != ':') {
>> -			end = memparse(cur, &tmp);
>> -			if (cur == tmp) {
>> -				pr_warn("crashkernel: Memory value expected\n");
>> -				return -EINVAL;
>> -			}
>> -			cur = tmp;
>> -			if (end <= start) {
>> -				pr_warn("crashkernel: end <= start\n");
>> -				return -EINVAL;
>> -			}
>> -		}
>> -
>> -		if (*cur != ':') {
>> -			pr_warn("crashkernel: ':' expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur++;
>> -
>> -		size = memparse(cur, &tmp);
>> -		if (cur == tmp) {
>> -			pr_warn("Memory value expected\n");
>> -			return -EINVAL;
>> -		}
>> -		cur = tmp;
>> -		if (size >= system_ram) {
>> -			pr_warn("crashkernel: invalid size\n");
>> -			return -EINVAL;
>> -		}
>> -
>> -		/* match ? */
>> -		if (system_ram >= start && system_ram < end) {
>> -			*crash_size = size;
>> -			break;
>> -		}
>> -	} while (*cur++ == ',');
>> +	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
>> +	if (cur == cmdline)
>> +		return -EINVAL;
>>   
>>   	if (*crash_size > 0) {
>>   		while (*cur && *cur != ' ' && *cur != '@')
>> @@ -1293,7 +1243,6 @@ static int __init __parse_crashkernel(char *cmdline,
>>   			     const char *name,
>>   			     const char *suffix)
>>   {
>> -	char	*first_colon, *first_space;
>>   	char	*ck_cmdline;
>>   
>>   	BUG_ON(!crash_size || !crash_base);
>> @@ -1311,12 +1260,10 @@ static int __init __parse_crashkernel(char *cmdline,
>>   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>   				suffix);
>>   	/*
>> -	 * if the commandline contains a ':', then that's the extended
>> +	 * if the parameter is range based, then that's the extended
>>   	 * syntax -- if not, it must be the classic syntax
>>   	 */
>> -	first_colon = strchr(ck_cmdline, ':');
>> -	first_space = strchr(ck_cmdline, ' ');
>> -	if (first_colon && (!first_space || first_colon < first_space))
>> +	if (is_param_range_based(ck_cmdline))
>>   		return parse_crashkernel_mem(ck_cmdline, system_ram,
>>   				crash_size, crash_base);
>>   
>> diff --git a/kernel/params.c b/kernel/params.c
>> index a6d6149..84e40ae 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
> /lib/cmdline.c is a better place for this?

True. Will change accordingly..

>> @@ -268,6 +268,102 @@ char *parse_args(const char *doing,
>>   	return err;
>>   }
>>   
>> +/*
>> + * is_param_range_based - check if current parameter is range based
>> + * @cmdline: points to the parameter to check
>> + *
>> + * Returns true when the current paramer is range based, false otherwise
>> + */
> It is not necessary to be range specific? Maybe is_colon_in_param or
> something else. If it is range based we need know what is the range
> like.

Hmmm.. I prefer to rename it to is_colon_in_param() and avoid
adding anymore checks here..

>> +bool __init is_param_range_based(const char *cmdline)
>> +{
>> +	char    *first_colon, *first_space;
>> +
>> +	first_colon = strchr(cmdline, ':');
>> +	first_space = strchr(cmdline, ' ');
>> +	if (first_colon && (!first_space || first_colon < first_space))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +/*
>> + * parse_mem_range_size - parse size based on memory range
>> + * @param:  the thing being parsed
>> + * @str: (input)  where parse begins
>> + *                expected format - <range1>:<size1>[,<range2>:<size2>,...]
> There should be detail example about the range format, especially about
> the "-" separator.
>

Sure..

>> + *       (output) On success - next char after parse completes
>> + *                On failure - unchanged
>> + * @system_ram: system ram size to check memory range against
>> + *
>> + * Returns the memory size on success and 0 on failure
>> + */
>> +unsigned long long __init parse_mem_range_size(const char *param,
>> +					       char **str,
>> +					       unsigned long long system_ram)
>> +{
>> +	char *cur = *str, *tmp;
>> +	unsigned long long mem_size = 0;
>> +
>> +	/* for each entry of the comma-separated list */
>> +	do {
>> +		unsigned long long start, end = ULLONG_MAX, size;
>> +
>> +		/* get the start of the range */
>> +		start = memparse(cur, &tmp);
>> +		if (cur == tmp) {
>> +			printk(KERN_INFO "%s: Memory value expected\n", param);
>> +			return mem_size;
>> +		}
>> +		cur = tmp;
>> +		if (*cur != '-') {
>> +			printk(KERN_INFO "%s: '-' expected\n", param);
>> +			return mem_size;
>> +		}
>> +		cur++;
>> +
>> +		/* if no ':' is here, than we read the end */
>> +		if (*cur != ':') {
>> +			end = memparse(cur, &tmp);
>> +			if (cur == tmp) {
>> +				printk(KERN_INFO "%s: Memory value expected\n",
> s/Memory/memory?

I haven't changed the content of print messages while moving them around.
Probably I should..

- Hari

>> +					param);
>> +				return mem_size;
>> +			}
>> +			cur = tmp;
>> +			if (end <= start) {
>> +				printk(KERN_INFO "%s: end <= start\n", param);
>> +				return mem_size;
>> +			}
>> +		}
>> +
>> +		if (*cur != ':') {
>> +			printk(KERN_INFO "%s: ':' expected\n", param);
>> +			return mem_size;
>> +		}
>> +		cur++;
>> +
>> +		size = memparse(cur, &tmp);
>> +		if (cur == tmp) {
>> +			printk(KERN_INFO "%s: Memory value expected\n", param);
> Ditto.
>
>> +			return mem_size;
>> +		}
>> +		cur = tmp;
>> +		if (size >= system_ram) {
>> +			printk(KERN_INFO "%s: invalid size\n", param);
>> +			return mem_size;
>> +		}
>> +
>> +		/* match ? */
>> +		if (system_ram >= start && system_ram < end) {
>> +			mem_size = size;
>> +			*str = cur;
>> +			break;
>> +		}
>> +	} while (*cur++ == ',');
>> +
>> +	return mem_size;
>> +}
>> +
>>   /* Lazy bastard, eh? */
>>   #define STANDARD_PARAM_DEF(name, type, format, strtolfn)      		\
>>   	int param_set_##name(const char *val, const struct kernel_param *kp) \
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> Thanks
> Dave
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

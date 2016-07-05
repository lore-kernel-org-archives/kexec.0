Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKKVJ-0000Fh-GZ
 for kexec@lists.infradead.org; Tue, 05 Jul 2016 07:10:46 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6579LT3094790
 for <kexec@lists.infradead.org>; Tue, 5 Jul 2016 03:10:23 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23x9rmc5r4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 05 Jul 2016 03:10:23 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 5 Jul 2016 17:10:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8B3172BB0059
 for <kexec@lists.infradead.org>; Tue,  5 Jul 2016 17:10:03 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u657A38d9044414
 for <kexec@lists.infradead.org>; Tue, 5 Jul 2016 17:10:03 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u657A3DJ019394
 for <kexec@lists.infradead.org>; Tue, 5 Jul 2016 17:10:03 +1000
Subject: Re: [v2,1/2] refactor code parsing size based on memory range
References: <3rbRd54y9Vz9t0p@ozlabs.org>
 <52b513d4-16a2-ca16-975e-a755b7a5ea8d@linux.vnet.ibm.com>
 <87twg4br3q.fsf@@concordia.ellerman.id.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 5 Jul 2016 12:40:00 +0530
MIME-Version: 1.0
In-Reply-To: <87twg4br3q.fsf@@concordia.ellerman.id.au>
Message-Id: <626eae51-9e4a-573e-9ae5-6417315522f1@linux.vnet.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>



On 07/05/2016 10:48 AM, Michael Ellerman wrote:
>> On 06/24/2016 10:56 AM, Michael Ellerman wrote:
>>> On Wed, 2016-22-06 at 19:25:26 UTC, Hari Bathini wrote:
> ...
>> While the code is moved to kernel/params.c file, there is no change in logic
>> for crashkernel parameter parsing as the moved code is invoked with function
>> calls at appropriate places.

Hi Michael,

> Are you sure that's true?

Yes. I tested it.

>
> The old code would return -EINVAL from parse_crashkernel_mem() for any
> error, regardless of whether it had already parsed some of the string.
>
> eg:
>
>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>> index 56b3ed0..d43f5cc 100644
>>>> --- a/kernel/kexec_core.c
>>>> +++ b/kernel/kexec_core.c
>>>> @@ -1083,59 +1083,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
>>>>    	char *cur = cmdline, *tmp;
>>>>    
>>>>    	/* for each entry of the comma-separated list */
>>>> -	do {
>>>> -		unsigned long long start, end = ULLONG_MAX, size;
>>>> -
>>>> -		/* get the start of the range */
>>>> -		start = memparse(cur, &tmp);
>>>> -		if (cur == tmp) {
>>>> -			pr_warn("crashkernel: Memory value expected\n");
>>>> -			return -EINVAL;
>>>> -		}
>>>> -		cur = tmp;
>>>> -		if (*cur != '-') {
>>>> -			pr_warn("crashkernel: '-' expected\n");
>>>> -			return -EINVAL;
>>>> -		}
>>>> -		cur++;
>>>> -
>>>> -		/* if no ':' is here, than we read the end */
>>>> -		if (*cur != ':') {
>>>> -			end = memparse(cur, &tmp);
>>>> -			if (cur == tmp) {
>>>> -				pr_warn("crashkernel: Memory value expected\n");
>>>> -				return -EINVAL;
>>>> -			}
> So eg, if I give it "128M-foo" it will modify cur, and then error out here ^

It does modify cur (local variable) but that would have no bearing on 
parsing logic
as we are returning immediately..

> You've changed that to:
>
>>>> +	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
>>>> +	if (cur == cmdline)
>>>> +		return -EINVAL;
> Which only returns EINVAL if cur is not modified at all.

I think the confusion is with the same local variable cur in 
parse_crashkernel_mem()
& parse_mem_range_size() functions.

We modified cur (local variable) in parse_mem_range_size() but the 
output parameter (char **str)
remains unchanged unless we find a match.

Thanks
Hari

> And looking below:
>
>>>> diff --git a/kernel/params.c b/kernel/params.c
>>>> index a6d6149..84e40ae 100644
>>>> --- a/kernel/params.c
>>>> +++ b/kernel/params.c
> ...
>>>> +unsigned long long __init parse_mem_range_size(const char *param,
>>>> +					       char **str,
>>>> +					       unsigned long long system_ram)
>>>> +{
>>>> +	char *cur = *str, *tmp;
>>>> +	unsigned long long mem_size = 0;
>>>> +
>>>> +	/* for each entry of the comma-separated list */
>>>> +	do {
>>>> +		unsigned long long start, end = ULLONG_MAX, size;
>>>> +
>>>> +		/* get the start of the range */
>>>> +		start = memparse(cur, &tmp);
>>>> +		if (cur == tmp) {
>>>> +			printk(KERN_INFO "%s: Memory value expected\n", param);
>>>> +			return mem_size;
>>>> +		}
>>>> +		cur = tmp;
>>>> +		if (*cur != '-') {
>>>> +			printk(KERN_INFO "%s: '-' expected\n", param);
>>>> +			return mem_size;
>>>> +		}
>>>> +		cur++;
>>>> +
>>>> +		/* if no ':' is here, than we read the end */
>>>> +		if (*cur != ':') {
>>>> +			end = memparse(cur, &tmp);
>>>> +			if (cur == tmp) {
>>>> +				printk(KERN_INFO "%s: Memory value expected\n",
>>>> +					param);
>>>> +				return mem_size;
> If we error out here for example, we have modified cur, so the code above
> *won't* return EINVAL.

>
> Which looks like a behaviour change to me?
>
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0NpA-0002uC-Eb
 for kexec@lists.infradead.org; Mon, 26 Mar 2018 08:49:53 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2Q8ndva016162
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2018 04:49:41 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gxvebu2ym-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2018 04:49:40 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 09:49:34 +0100
Subject: Re: [PATCH] kexec/ppc64: leverage kexec_file_load support
References: <152010365000.15494.15072043690885225651.stgit@hbathini.in.ibm.com>
 <87y3inhp14.fsf@morokweng.localdomain>
 <20180326071903.r2ce5tigwgc3o4tm@verge.net.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 14:19:28 +0530
MIME-Version: 1.0
In-Reply-To: <20180326071903.r2ce5tigwgc3o4tm@verge.net.au>
Content-Language: en-US
Message-Id: <1f041adb-5f93-d71f-ea53-833dc504b00e@linux.vnet.ibm.com>
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
To: Simon Horman <horms@verge.net.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>



On Monday 26 March 2018 12:49 PM, Simon Horman wrote:
> On Mon, Mar 19, 2018 at 03:57:11PM -0300, Thiago Jung Bauermann wrote:
>> Hello Hari,
>>
>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>
>>> PPC64 kernel now supports kexec_file_load system call. Leverage it by
>>> enabling that support here. Note that loading crash kernel with this
>>> system call is not yet supported in the kernel and trying to load one
>>> will fail with '-ENOTSUPP' error.
>>>
>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>>> ---
>>>   kexec/arch/ppc64/kexec-elf-ppc64.c |   84 ++++++++++++++++++++++++++++++++++++
>>>   kexec/kexec-syscall.h              |    3 +
>>>   2 files changed, 87 insertions(+)
>> Thanks for implementing this! Looks good to me, just one nit below.
>> Regardless of that:
>>
>> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Thanks for reviewing..

>>> diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
>>> index ddd3de8..2742cd6 100644
>>> --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
>>> +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
>> <snip>
>>
>>> @@ -117,6 +196,9 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>>>   	uint32_t my_run_at_load;
>>>   	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
>>>
>>> +	if (info->file_mode)
>>> +		return elf_ppc64_load_file(argc, argv, info);
>>> +
>>>   	/* See options.h -- add any more there, too. */
>>>   	static const struct option options[] = {
>>>   		KEXEC_ARCH_OPTIONS
>> This is placing executable code between variable declarations. It may be
>> fine for gcc but it's more idiomatic C to put it after all variable
>> declarations. But perhaps the kexec-tools style is fine with it?
> I'd rather we avoid proliferating this style in the kexec code.
> Hari, could you respin this patch?
>

Posted v2 with the necessary change...

Thanks
Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

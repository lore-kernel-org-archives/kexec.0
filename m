Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6591CCFA18
	for <kexec@archiver.kernel.org>; Wed, 12 Nov 2025 03:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IFgiDP1K2ISQ1s0YrCV2FiyN7JViLkO+JSusQJ5otQ=; b=pFDLng+rWLlnJcfouEl+C7sEgI
	86MBXFfmd7h3oRUDk9PcGQWsZ0Ve9XfLo+hCeD+Mmte8agoCMtPcGvkOqVvIchoSg778YnUKujYFl
	1sycyTizUEPyhKr/IMKjiwgokPVhXbjuWJZ7P8OvPPXWixqtApL2aD+gKwgPpL5UeTpDdTjYKadOt
	XwJJHx0qt/6rWHzIS9SJURbg2sL+72i2nnS4ph4nv7SN4YR8+dBdUDwsNgGIBZZ8f2DK/v4JPL85I
	tCQnc7qRY2irrkm0NdoUXN3gMC5L9FLGemv4F/D/JndW46fs+klYYMYoZ1AhB5zQ3tpnNfa5Gm5QS
	52tkSeeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ1Bz-000000083TU-0BtI;
	Wed, 12 Nov 2025 03:06:43 +0000
Received: from out-179.mta1.migadu.com ([95.215.58.179])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ1Bv-000000083Rz-3NyZ
	for kexec@lists.infradead.org;
	Wed, 12 Nov 2025 03:06:41 +0000
Message-ID: <50fa479e-5514-4b5a-a0b8-a264ba23a005@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762916784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IFgiDP1K2ISQ1s0YrCV2FiyN7JViLkO+JSusQJ5otQ=;
	b=vt8RmKwICON8GluO+jnXZDbRazuiOn0EO8GMxrh7OUAVG6p5tyHsuQ3c4mlODeCNzl3i3N
	VNrDRbHk71AlNaN3cdH3xQAhIxRj7HNcu7QxE25JV+KIpT2v3BorulGa2Y1zEkdCwUaKqi
	OX6j6yjiShUo5eYOnRhcMJobiR6QNuw=
Date: Wed, 12 Nov 2025 11:05:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] LoongArch: Refactor command line processing
To: Simon Horman <horms@kernel.org>
Cc: Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>,
 kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250925063241.337897-1-youling.tang@linux.dev>
 <20250925063241.337897-2-youling.tang@linux.dev>
 <CALu+AoT_DMoFRWO464RSK267wkec917NaLPZ2vOwe1Kw6fvoaA@mail.gmail.com>
 <5ec31e96-7157-4300-af36-daec2cee5831@linux.dev>
 <CALu+AoQa=17vhPydQ2e+UO20CZPLMOYp2Qs+gUaZ29QyrMrZ7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <CALu+AoQa=17vhPydQ2e+UO20CZPLMOYp2Qs+gUaZ29QyrMrZ7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_190640_233494_0C8B1E1E 
X-CRM114-Status: GOOD (  26.46  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi, Simon

Currently, it is passed through command-line parameters (fdt has not been
used yet), but the readability of the existing command-line parameters is
too poor. By rewriting it to be consistent with the kernel implementation
and using hexadecimal, the readability will be better.

Can Patch2 be applied alone (please ignore Patch1)?

Thanks,
Youling.
On 9/25/25 18:23, Dave Young wrote:
> On Thu, 25 Sept 2025 at 17:52, Youling Tang <youling.tang@linux.dev> wrote:
>> On 9/25/25 17:22, Dave Young wrote:
>>
>> On Thu, 25 Sept 2025 at 14:33, Youling Tang <youling.tang@linux.dev> wrote:
>>
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Refactor the cmdline_add_xxx code flow, and simultaneously display
>> the content of parameters such as initrd in hexadecimal format to
>> improve readability.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   kexec/arch/loongarch/kexec-loongarch.c | 138 ++++++++++---------------
>>   1 file changed, 55 insertions(+), 83 deletions(-)
>>
>> diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
>> index 240202f..c2503de 100644
>> --- a/kexec/arch/loongarch/kexec-loongarch.c
>> +++ b/kexec/arch/loongarch/kexec-loongarch.c
>> @@ -35,83 +35,49 @@
>>   #define _O_BINARY 0
>>   #endif
>>
>> -#define CMDLINE_PREFIX "kexec "
>> -static char cmdline[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
>> +/* Add the "kexec" command line parameter to command line. */
>> +static void cmdline_add_loader(unsigned long *cmdline_tmplen, char *modified_cmdline)
>> +{
>> +       int loader_strlen;
>> +
>> +       loader_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "kexec ");
>> +       *cmdline_tmplen += loader_strlen;
>> +}
>>
>> Not sure why this is needed,  I guess it is to distinguish the new
>> kernel and original kernel?   As replied in another reply I would
>> suggest adding an extra cmdline in scripts instead of hard coded here,
>>    you need to remove the fake param each time otherwise it will make
>> the cmdline longer and longer after many kexec reboot cycles.
>>
>>
>> In arch_process_options(), the "kexec" parameter will be removed when
>> reusing the current command line.
>>
>> -/* Adds "initrd=start,size" parameters to command line. */
>> -static int cmdline_add_initrd(char *cmdline, unsigned long addr,
>> -               unsigned long size)
>> +/* Add the "initrd=start,size" command line parameter to command line. */
>> +static void cmdline_add_initrd(unsigned long *cmdline_tmplen, char *modified_cmdline,
>> +                              unsigned long initrd_base, unsigned long initrd_size)
>>   {
>> -       int cmdlen, len;
>> -       char str[50], *ptr;
>> -
>> -       ptr = str;
>> -       strcpy(str, " initrd=");
>> -       ptr += strlen(str);
>> -       ultoa(addr, ptr);
>> -       strcat(str, ",");
>> -       ptr = str + strlen(str);
>> -       ultoa(size, ptr);
>> -       len = strlen(str);
>> -       cmdlen = strlen(cmdline) + len;
>> -       if (cmdlen > (COMMAND_LINE_SIZE - 1))
>> -               die("Command line overflow\n");
>> -       strcat(cmdline, str);
>> +       int initrd_strlen;
>>
>> -       return 0;
>> +       initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
>> +                               initrd_base, initrd_size);
>> +       *cmdline_tmplen += initrd_strlen;
>>   }
>>
>> -/* Adds the appropriate "mem=size@start" options to command line, indicating the
>> - * memory region the new kernel can use to boot into. */
>> -static int cmdline_add_mem(char *cmdline, unsigned long addr,
>> -               unsigned long size)
>> +/*
>> + * Add the "mem=size@start" command line parameter to command line, indicating the
>> + * memory region the new kernel can use to boot into.
>> + */
>> +static void cmdline_add_mem(unsigned long *cmdline_tmplen, char *modified_cmdline,
>> +                           unsigned long mem_start, unsigned long mem_sz)
>>   {
>> -       int cmdlen, len;
>> -       char str[50], *ptr;
>> -
>> -       addr = addr/1024;
>> -       size = size/1024;
>> -       ptr = str;
>> -       strcpy(str, " mem=");
>> -       ptr += strlen(str);
>> -       ultoa(size, ptr);
>> -       strcat(str, "K@");
>> -       ptr = str + strlen(str);
>> -       ultoa(addr, ptr);
>> -       strcat(str, "K");
>> -       len = strlen(str);
>> -       cmdlen = strlen(cmdline) + len;
>> -       if (cmdlen > (COMMAND_LINE_SIZE - 1))
>> -               die("Command line overflow\n");
>> -       strcat(cmdline, str);
>> +       int mem_strlen = 0;
>>
>> -       return 0;
>> +       mem_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "mem=0x%lx@0x%lx ",
>> +                            mem_sz, mem_start);
>> +       *cmdline_tmplen += mem_strlen;
>>   }
>>
>> Ditto for the mem= param and other similar cases, can this be done out
>> of the kexec-tools c code? it will be more flexible.
>>
>>
>> Currently, we will maintain passing this parameter through the command line, not
>> via FDT like ARM64. In the future, we may consider whether it can be passed through
>> the FDT table in efisystab (but that approach may not be friendly to ELF kernels).
>>
> If the kexec boot depends on the customized mem layout, ideally it
> should be passed with fdt or other method.
> it is reasonable to keep it for the time being.  But the "kexec" extra
> cmdline should not be hard coded in my opinion.
>
> Thanks
> Dave
>


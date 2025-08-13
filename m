Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8043DCA0EC4
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 02:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMss20SDGbXY1dMDpG7fyXCbHMpQ4bsQAbINwnsqRUk=; b=wTprkL5I5oNub2azl0ZADG5wk5
	wUm8lXuUw9gG/FbCf9VJkmY3uWJeiaHBt35mtEeB0kOIWLiiILzc/aWkFkAD5ovTUrnRjx7ZgNBpK
	OMsmiz2uLg4zg0iY3v4TnH1l01lSg43cI/WBfQ5SlQkxjLfO1yuEG+zuHzZAf/1WQmEpLmnoIeSBD
	d8EOfwzT/pwBCOFx2IvNXfIdii68EGAT7mD1zpdtMDtuH/jORVV7u+VWyvIZPgUuIKEN+r+ocLpz3
	3upQyiNNPskdP1sN2szoqKNsDTTIkL6Xfta1+a6dwBmU6ZtvafbC2JBEOFES5aeEWAyGtDvyDcRtN
	yaNqphJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um15A-0000000COtH-1sdm;
	Wed, 13 Aug 2025 02:19:16 +0000
Received: from out-173.mta0.migadu.com ([91.218.175.173])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um153-0000000COsP-32wm
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 02:19:11 +0000
Message-ID: <27513334-3086-4353-bf6c-fdee082a8ce8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755051545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMss20SDGbXY1dMDpG7fyXCbHMpQ4bsQAbINwnsqRUk=;
	b=IVFGGoMYVDBJ/itT32notwts4Tsq6ydD6JQ45HSQ6xmLgXBPG7MeIB3uTKEfv9N2Ag/SSM
	lg2gL/PtD4wdZt5iJpBJrVUYMvifKRpR9ShWuG0MAm+niPM0J4Mngr7ak7Uguoq7FoH+Ck
	IQqfivki9GyuYP6E7H++OwkL5+w/m68=
Date: Wed, 13 Aug 2025 10:18:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev> <aJojDiHWi8cgvA2W@pie>
 <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
 <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev> <aJsGg8__ppyBrkfL@pie>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <aJsGg8__ppyBrkfL@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_191910_430608_5FFEA5C9 
X-CRM114-Status: GOOD (  33.70  )
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

Hi, Yao
On 2025/8/12 17:43, Yao Zi wrote:
> On Tue, Aug 12, 2025 at 03:06:23PM +0800, Youling Tang wrote:
>> On 2025/8/12 14:15, Youling Tang wrote:
>>> Hi, Yao
>>> On 2025/8/12 01:06, Yao Zi wrote:
>>>> On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>>
>>>>> This patch adds support for kexec_file on LoongArch.
>>>>>
>>>>> The image_load() as two parts:
>>>>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>>>>> - the second part loads other segments (eg: initrd, cmdline)
>>>>>
>>>>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images
>>>>> are supported,
>>>>> but ELF format is not supported.
>>>>>
>>>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>>>> ---
>>>>>    arch/loongarch/Kconfig                     |   8 ++
>>>>>    arch/loongarch/include/asm/image.h         |  18 ++++
>>>>>    arch/loongarch/include/asm/kexec.h         |  12 +++
>>>>>    arch/loongarch/kernel/Makefile             |   1 +
>>>>>    arch/loongarch/kernel/kexec_image.c        | 112
>>>>> +++++++++++++++++++++
>>>>>    arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>>>>    arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>>>>>    7 files changed, 219 insertions(+), 11 deletions(-)
>>>>>    create mode 100644 arch/loongarch/kernel/kexec_image.c
>>>>>    create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> ...
>
>>>>> diff --git a/arch/loongarch/kernel/kexec_image.c
>>>>> b/arch/loongarch/kernel/kexec_image.c
>>>>> new file mode 100644
>>>>> index 000000000000..fdd1845b4e2e
>>>>> --- /dev/null
>>>>> +++ b/arch/loongarch/kernel/kexec_image.c
> ...
>
>>>>> +    /*
>>>>> +     * The location of the kernel segment may make it
>>>>> impossible to satisfy
>>>>> +     * the other segment requirements, so we try repeatedly to find a
>>>>> +     * location that will work.
>>>>> +     */
>>>>> +    while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>>>>> +        /* Try to load additional data */
>>>>> +        kernel_segment = &image->segment[kernel_segment_number];
>>>>> +        ret = load_other_segments(image, kernel_segment->mem,
>>>>> +                      kernel_segment->memsz, initrd,
>>>>> +                      initrd_len, cmdline, cmdline_len);
>>>>> +        if (!ret)
>>>>> +            break;
>>>>> +
>>>>> +        /*
>>>>> +         * We couldn't find space for the other segments; erase the
>>>>> +         * kernel segment and try the next available hole.
>>>>> +         */
>>>>> +        image->nr_segments -= 1;
>>>>> +        kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>>>>> +        kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>>> +    }
>>>>> +
>>>>> +    if (ret) {
>>>>> +        pr_err("Could not find any suitable kernel location!");
>>>>> +        return ERR_PTR(ret);
>>>>> +    }
>>>>> +
>>>>> +    kernel_segment = &image->segment[kernel_segment_number];
>>>>> +
>>>>> +    /* Make sure the second kernel jumps to the correct
>>>>> "kernel_entry". */
>>>>> +    image->start = kernel_segment->mem + h->kernel_entry -
>>>>> text_offset;
>>>> A non-relocatable loongarch kernel cannot be loaded to arbitrary
>>>> address. Thus this loading function seems to only work for relocatable
>>>> kernels, maybe it's better to leave a comment indicating the limitation.
>>>>
>>>> For now, we don't seem to have a way to find out whether the kernel is
>>>> relocatable (for example, a flag in kernel image header), so it's
>>>> impossible to point out whether the loaded kernel boots fine with
>>>> arbitrary loading address...
>>> LoongArch enables the relocation of the kernel when the kdump
>>> feature is enabled.
>>>
>>> config ARCH_SELECTS_CRASH_DUMP
>>>          def_bool y
>>>          depends on CRASH_DUMP
>>>          select RELOCATABLE
>>>
> This only means the currently-running kernel is relocatable, not the one
> being exec'ed, right?
No.
>> When enabling KEXEC_FILE, the RELOCATABLE configuration should
>> also be enabled. Both kexec and kdump require this.
> I'm not sure whether you're talking about the running kernel or the one
> that is going to be exec'ed. This method of kernel loading requires the
> exec'ed kernel being relocatable, not the currently running one.
>
> And I think it's totally reasonable to use KEXEC_FILE for non-crash-dump
> purpose, for example, linuxboot. It'll be confusing to the user if the
> system just hangs after booting a non-relocatable kernel, which is hard
> to debug.
>
> Thus IMHO we should ideally refuse to load non-relocatable kernels, or
> add a FIXME comment to indicate the situation that it's impossible to
> determine whether the exec'ed image is relocatable.
The first kernel and the second kernel are generally the same kernel
(the same image). When KEXEC_FILE is enabled and RELOCATEABLE
is enabled by default, it has been forcibly guaranteed that both the
first kernel and the second kernel are relocatable kernels regardless
of kexec/kdump operations.

Unless the second kernel it loads is an older version of the kernel (the
older version of the kernel does not use the default configuration, with
CONFIG_KEXEC enabled but CONFIG_CRASH_DUMP disabled, this is not acorrect
usage).

Thanks,
Youling.
>> Youling.
>>> After enabling the relocation, LoongArch is the PIE kernel. For
>>> more details, please refer to commit d8da19fbdedd ("LoongArch:
>>> Add support for kernel relocation")
> Best regards.
> Yao Zi


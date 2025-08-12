Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64282CA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBKYKsRpkFn4IgKj6ShKVJvxeOJHa9l2mWxrzZCMV7Q=; b=Ud9uuQcz0R9sHRv9FU8zfFP7z3
	vU8/pWndXAE0ZHO1Ulh5YzEyy6NRYjGb3rTV6uMllwiI+2JRNIzkwgePOHybGraLrJmTGLk2xk72Q
	i2tgy02suGXUMMBuNdF9TItEAfwLAb5tmqet+3EIRYmlmxS84ouB5Ra99htm1JtWHSufOCprYRu49
	+SZnJURGdsS8dqfr/gWjBTRl3oVn/Yt7A6cfn4hiRs8o4+lPkL8M659Id8TEpk42eG8j678o+1umc
	H8awCiMogM3C6wuwyFEAYRSQN/ll1K2E4lqTdjEzD2FnKqdWG0Z7VhEhoZXL3ACoOl/bSD/9Jjw/R
	EHk7cYSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulgHA-00000009lfM-0I4m;
	Tue, 12 Aug 2025 04:06:16 +0000
Received: from out-185.mta0.migadu.com ([2001:41d0:1004:224b::b9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulgH7-00000009leE-2IvA
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 04:06:15 +0000
Message-ID: <0767b8fe-7c04-4e73-9235-ee326ee058cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754971570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBKYKsRpkFn4IgKj6ShKVJvxeOJHa9l2mWxrzZCMV7Q=;
	b=qhuHlinEYuRlBDjMI4MbGx0/KxiYdhdqOPfLP0oqsPpOj0jhFjA54EiI3M8GXC6Pk8EVb2
	/qR3qQmpSiB5bweQlDPHRe22e6PYfTC+EImtk1BWutMGnco8opavqMnN7zPSLplYoArMLo
	oySeWvOUlkHDpU7+xZL/bAN7td1TSM8=
Date: Tue, 12 Aug 2025 12:05:30 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev> <aJovKIKFqX6xi9ra@pie>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <aJovKIKFqX6xi9ra@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_210614_172843_26458D5E 
X-CRM114-Status: GOOD (  27.35  )
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
On 2025/8/12 01:58, Yao Zi wrote:
> On Mon, Aug 11, 2025 at 05:26:56PM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Add inird loading support and pass it to the second kernel via the
>> cmdline 'initrd=start,size'.
> I think This won't work if the exec'ed kernel enables
> CONFIG_CMDLINE_FORCE. Is it possible to mimic libstub's behavior of
> installing a configuration table LINUX_EFI_INITRD_MEDIA_GUID?
The command line passed by kexec to the second kernel has no effect if
CONFIG_CMDLINE_FORCE is enabled, which is not quite suitable for the
kexec scenario.

Currently, the initrd, elfcorehdr, and mem parameters will all be passed
through the command line to maintain consistency with the implementation
behavior of kexec-tools. It is possible that the content of systab will
be modified in the future and some parts will be integrated into systab
(the current cmdline mode will be better compatible with the elf kernel).
>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
>> index bc91ae0afa4c..e1240644f529 100644
>> --- a/arch/loongarch/kernel/machine_kexec_file.c
>> +++ b/arch/loongarch/kernel/machine_kexec_file.c
>> @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>   	return kexec_image_post_load_cleanup_default(image);
>>   }
>>   
>> +/* Adds the "initrd=start,size" command line parameter to command line. */
>> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
>> +				char *modified_cmdline, unsigned long initrd)
>> +{
>> +	int initrd_strlen;
>> +
>> +	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
> modified_cmdline is allocated as COMMAND_LINE_SIZE bytes, thus I think
> it's possible to overflow the buffer.
At this point, modified_cmdline can clearly know that it only stores
the additional commands we add (initrd,mem,elfcorehdr), and will not
exceed COMMAND_LINE_SIZE.
>
>> +		initrd, image->initrd_buf_len);
>> +	*cmdline_tmplen += initrd_strlen;
>> +}
>> +
>> +/*
>> + * Tries to add the initrd to the image. If it is not possible to find
>> + * valid locations, this function will undo changes to the image and return non
>> + * zero.
>> + */
>>   int load_other_segments(struct kimage *image,
>>   			unsigned long kernel_load_addr,
>>   			unsigned long kernel_size,
>>   			char *initrd, unsigned long initrd_len,
>>   			char *cmdline, unsigned long cmdline_len)
>>   {
>> +	struct kexec_buf kbuf;
>> +	unsigned long orig_segments = image->nr_segments;
>> +	char *modified_cmdline = NULL;
>> +	unsigned long cmdline_tmplen = 0;
>> +	unsigned long initrd_load_addr = 0;
>> +	int ret = 0;
>> +
>> +
>> +	kbuf.image = image;
>> +	/* not allocate anything below the kernel */
>> +	kbuf.buf_min = kernel_load_addr + kernel_size;
>> +
>> +	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
>> +	if (!modified_cmdline)
>> +		return -EINVAL;
>> +
>> +	/* Ensure it's nul terminated */
>> +	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
>> +
>> +	/* load initrd */
>> +	if (initrd) {
>> +		kbuf.buffer = initrd;
>> +		kbuf.bufsz = initrd_len;
>> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +		kbuf.memsz = initrd_len;
>> +		kbuf.buf_align = 0;
>> +		/* within 1GB-aligned window of up to 32GB in size */
>> +		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
>> +						+ (unsigned long)SZ_1G * 32;
>> +		kbuf.top_down = false;
>> +
>> +		ret = kexec_add_buffer(&kbuf);
>> +		if (ret)
>> +			goto out_err;
>> +		initrd_load_addr = kbuf.mem;
>> +
>> +		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
>> +
>> +		/* Add the initrd=start,size parameter to the command line */
>> +		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
>> +	}
>> +
>> +	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> It's too later to check for overflowing here, where the data after
> modified_cmdline may already be overwritten.
At this point, we append the original command line to modified_cmdline,
so it is appropriate to determine whether the command line length exceeds
the limit.
>
>> +		pr_err("Appending kdump cmdline exceeds cmdline size\n");
> I think load_other_segments could be invoked without kdump involved. If
> that's correct, this message is inaccurate.
Yes, it should be corrected.


Thanks,
Youling.
>
>> +		ret = -EINVAL;
>> +		goto out_err;
>> +	}
> Regards,
> Yao Zi
>
>> +	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
>> +	cmdline = modified_cmdline;
>>   	image->arch.cmdline_ptr = (unsigned long)cmdline;
>>   
>>   	return 0;
>> +
>> +out_err:
>> +	image->nr_segments = orig_segments;
>> +	kfree(modified_cmdline);
>> +	return ret;
>>   }
>> -- 
>> 2.34.1
>>
>>


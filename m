Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EEBCA0ED1
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 02:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+V6JNn1qTclk48lL6vZFHUSkocWBaeAf2PNn/YVMcWo=; b=PHbm68QeB/FrvD3+eQbNn9HHa6
	Bs/uWjOM8UE5KR99H8MoKXboXwo2fxm9Ri1ORoXgwAeavxRM1A//nxF/ztFKtWxXe//Q2uVy0LqCd
	zAq7d4Ljj768Pwdpk9KkIMO7tVbcx1Jm6vZsXqpA56sveExRR+dWBWTIvc7uoyh1iBrhrDAWBHMbl
	ajWqRdmMZs9SXlhEz4DZr4lBSpXE8sVDgOJWOqWmNp8DLfkSTHCnkzuxKlg2s79EvpMFa6ij2DTkx
	y40zMAlbRKi7zx33w1ohEwujG6HKI++F3uzJdGOvVE3fy+S3cm8V+zbm216Ezcd2JzPtooHDD7a5O
	nu1WrDWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uleua-00000009cT7-2Anw;
	Tue, 12 Aug 2025 02:38:52 +0000
Received: from out-174.mta1.migadu.com ([95.215.58.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uleuY-00000009cSl-0MUu
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 02:38:51 +0000
Message-ID: <15fdef37-f380-4b5c-85bb-24482e883dcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754966327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V6JNn1qTclk48lL6vZFHUSkocWBaeAf2PNn/YVMcWo=;
	b=Ozjxrm75yxPx1BIPykdr+lWI04fhVMMGxHIm1EP3iR0ODmrvMKkAwitPgr8eNsEibYwjw7
	ENdHH61wWWA0lwkKDzTh7EBfdRJF5ij86bwcNIVOIOh8DQQbF5rLjFLk+o74pavqvtb/5i
	8RXwAriihep/XeC2IFajtYOj7Ko768s=
Date: Tue, 12 Aug 2025 10:38:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev>
 <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_193850_512040_5AA0C125 
X-CRM114-Status: GOOD (  19.87  )
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

Hi, Huacai
On 2025/8/11 22:12, Huacai Chen wrote:
> Hi, Youling,
>
> On Mon, Aug 11, 2025 at 5:28 PM Youling Tang <youling.tang@linux.dev> wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Add inird loading support and pass it to the second kernel via the
>> cmdline 'initrd=start,size'.
> I think Patch-3 and Patch-5 should be merged into Patch-2.
Not all cases require loading initrd, so Patch-2 is a runnable basic patch.
Separating it into different patches makes it easier to understand and
review the code.

Patch-5 coming out separately can better illustrate the role of "mem"
parameters in capturing the kernel.

Youling.
>
> Huacai
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
>>          return kexec_image_post_load_cleanup_default(image);
>>   }
>>
>> +/* Adds the "initrd=start,size" command line parameter to command line. */
>> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
>> +                               char *modified_cmdline, unsigned long initrd)
>> +{
>> +       int initrd_strlen;
>> +
>> +       initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
>> +               initrd, image->initrd_buf_len);
>> +       *cmdline_tmplen += initrd_strlen;
>> +}
>> +
>> +/*
>> + * Tries to add the initrd to the image. If it is not possible to find
>> + * valid locations, this function will undo changes to the image and return non
>> + * zero.
>> + */
>>   int load_other_segments(struct kimage *image,
>>                          unsigned long kernel_load_addr,
>>                          unsigned long kernel_size,
>>                          char *initrd, unsigned long initrd_len,
>>                          char *cmdline, unsigned long cmdline_len)
>>   {
>> +       struct kexec_buf kbuf;
>> +       unsigned long orig_segments = image->nr_segments;
>> +       char *modified_cmdline = NULL;
>> +       unsigned long cmdline_tmplen = 0;
>> +       unsigned long initrd_load_addr = 0;
>> +       int ret = 0;
>> +
>> +
>> +       kbuf.image = image;
>> +       /* not allocate anything below the kernel */
>> +       kbuf.buf_min = kernel_load_addr + kernel_size;
>> +
>> +       modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
>> +       if (!modified_cmdline)
>> +               return -EINVAL;
>> +
>> +       /* Ensure it's nul terminated */
>> +       modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
>> +
>> +       /* load initrd */
>> +       if (initrd) {
>> +               kbuf.buffer = initrd;
>> +               kbuf.bufsz = initrd_len;
>> +               kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +               kbuf.memsz = initrd_len;
>> +               kbuf.buf_align = 0;
>> +               /* within 1GB-aligned window of up to 32GB in size */
>> +               kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
>> +                                               + (unsigned long)SZ_1G * 32;
>> +               kbuf.top_down = false;
>> +
>> +               ret = kexec_add_buffer(&kbuf);
>> +               if (ret)
>> +                       goto out_err;
>> +               initrd_load_addr = kbuf.mem;
>> +
>> +               kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +                             initrd_load_addr, kbuf.bufsz, kbuf.memsz);
>> +
>> +               /* Add the initrd=start,size parameter to the command line */
>> +               cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
>> +       }
>> +
>> +       if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
>> +               pr_err("Appending kdump cmdline exceeds cmdline size\n");
>> +               ret = -EINVAL;
>> +               goto out_err;
>> +       }
>> +       memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
>> +       cmdline = modified_cmdline;
>>          image->arch.cmdline_ptr = (unsigned long)cmdline;
>>
>>          return 0;
>> +
>> +out_err:
>> +       image->nr_segments = orig_segments;
>> +       kfree(modified_cmdline);
>> +       return ret;
>>   }
>> --
>> 2.34.1
>>


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B8ECAC5A7
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 01:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5rlNsSgS15aFR1u3Y7StKp/YbzfTbHTA/Z7lHl49PV4=; b=1m7PEDc/6PhWMLJfv2Z5fD2VYp
	QH9MRA88tz9jJpPQkloPSJndH99kE+NAqSmTGDP/IJ4KJECNHeDjRTT6bJb2JpOptYN1095xcqUnX
	eCJ6hMc6T8R+XEHx1fMzCZf7rKMeoDDA42dULuF6vTEDDCL4pN90cxeXr/HcsZTYgzN5LsYHXdt0n
	zINXvX/slCthZN0JCk6yflLZrl5W2c40WdhThYn6D93N/3gOr6ZWcXtGzYwKDX6MFkqScL6hEDdKy
	wkbaHKYI6fwYyEkL0JMaabc1ZR2bR5aPoF//08j5VvgrrZAlQaYOpLJJ3GL0OD5mz84GDsPgFOnIp
	s1CmoPXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0rqf-0000000C13L-2r8H;
	Tue, 23 Sep 2025 01:29:41 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0rqd-0000000C12m-3XPh
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 01:29:41 +0000
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-330469eb750so5690590a91.2
        for <kexec@lists.infradead.org>; Mon, 22 Sep 2025 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758590979; x=1759195779; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rlNsSgS15aFR1u3Y7StKp/YbzfTbHTA/Z7lHl49PV4=;
        b=l5xTgT9PVHk1qntRnpHnUJuz0YjnFjSlPqEvPNhepefgSsGN4rmDOiE9gonMGf4Olp
         fxxrq+h5ZJOUUG5rzZpeAwYLyRhacN9Qk6zlkA2kd1pi4q2gsJvjxzr7bEVWGQlBtK7L
         ah2tZazEKkb3/77Yi8COSgoY26P3CehNxnaQtQymOaQmumy1thraMPGyqEDTftJ1Rl0x
         fN0X6DCMqKknqrFpKuaT/8cVWqhQH7VrW7Sw3hI013EfDn2PX74FXvXLUhL6yxz0XMj5
         AUN6jTjnOw5u4NhbXzzv+A97PD8B3J75qe2sS3XNgNc6xsXA9RBtThsGdmIjyJmotWOS
         Vp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590979; x=1759195779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rlNsSgS15aFR1u3Y7StKp/YbzfTbHTA/Z7lHl49PV4=;
        b=tHg+ReICBH+UftOtDGlx3+8N73cuMtwQECds9WIyzG++Wshya8G5m0aNL6CzCoQTtw
         tHP8p1klNtYk+nYq8DwSZrV8L6dqtzvagvKTyOEGZ8xxc2W2b4ctPpMSpl2wdQww0o0M
         v23shl9yIVXzw7OAWpeobEtc7tZdC7o7mOWcR2UQuS6cFuVLSNkNpu8WssMtVez+NxXg
         qJJ3a3ptv4yksUnTzW6jqZq9J75JhN+sH+c4LQANNXzOCuP2xUfWhU8wf5CWBeEsUFwU
         +X2D1vgGQDCS+EYxWiet/ayLMAdv5oS62ZDnurNGRJksOcQ2FyiogBSBwdytS3iIOpbb
         7iyg==
X-Gm-Message-State: AOJu0YyZrC/eVpryZsTQLIQEhyPK/+Dzcovx3S7tOvjqpKq40rlb32WM
	mzNAkflKWZJgi16cAXCUoOtemjfldrhwIr9+I2MV7L/p1cMzZPxD0xfSTFGGu1iMcPKEJQ==
X-Gm-Gg: ASbGncswQ3wfNOHTdku2rnKw1ZwTJl0BLBolq8dLaO1DMOdtn7PcPQ0T6WzplXqsRy5
	vRGKrJugTxV2e20WcsuQoA/djEx5kGIGhfALWxFFSaLhNYAnZEmFMyWk4zA8uOGFrUXb4nZ00Al
	sYF0Ld/zwXFFtwtSf0JG69FM82eU+I3L7/wt+NDeLK3jlNQxkFAU5UvNk2sOCsLMJtFmSW/k39X
	EfUVr7CtRiPd8Y40rz6VkbXjyTCNbbOlBg+2nrbEs7+2VQZUbQ0A/d1EHfqSRqZgsa31zCP1CDc
	wSDE+bJAXKqEs5/DUAug7tWFXC4IveANUZ0sypOo24CYtPL5uHVS/XOkww3HQukfhWt1q8MNvuT
	mYIG6AsJ77xQLVsd1JZ31vCaOF56IdJuUk8T5GCRH
X-Google-Smtp-Source: AGHT+IGbkCM3o6k1u3FU0cszaH1li4+QeK05dVmg+eX6MDyu04GIRfZqe/0Jg8uMDo1lVgofdYPJnw==
X-Received: by 2002:a17:90b:544e:b0:332:8133:b377 with SMTP id 98e67ed59e1d1-332a95376b9mr1251078a91.15.1758590978670;
        Mon, 22 Sep 2025 18:29:38 -0700 (PDT)
Received: from [10.125.192.50] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5523f5ea3esm9599182a12.40.2025.09.22.18.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 18:29:38 -0700 (PDT)
Message-ID: <17eadb48-0fbb-4aea-92d1-58e382359451@gmail.com>
Date: Tue, 23 Sep 2025 09:29:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/crashdump-arm64: Fix makedumpfile error caused by
 fail to get _text address
To: Pingfan Liu <piliu@redhat.com>, horms@verge.net.au
Cc: kexec@lists.infradead.org, zhaomeijing@lixiang.com
References: <20250919073522.1840036-1-chenwandun@lixiang.com>
 <CAF+s44SDWTAkivXhh1=Nhw9wyp+mN8X+Z6OFUyy4mqayHcNukw@mail.gmail.com>
From: Chen Wandun <chenwandun1@gmail.com>
In-Reply-To: <CAF+s44SDWTAkivXhh1=Nhw9wyp+mN8X+Z6OFUyy4mqayHcNukw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_182939_889897_44413E7B 
X-CRM114-Status: GOOD (  21.91  )
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



On 9/22/25 12:38 PM, Pingfan Liu wrote:
> Hi Chen,
>
> On Fri, Sep 19, 2025 at 3:35 PM Chen Wandun <chenwandun1@gmail.com> wrote:
>> I encountered the following error while makedumpfile without enableing
>> kernel CONFIG_PROC_KCORE and CONFIG_KALLSYMS_ALL, this error only exists
>> before commit 29fe506 (kexec: make -a the default), this commit change
>> from kexec_load to kexec_file_load.
>>
>> read_from_vmcore: Can't seek the dump memory(/proc/vmcore). (offset: ffff800084f4c000) Invalid argument
>> readpage_elf: Can't read the dump memory(/proc/vmcore).
>> readmem: type_addr: 1, addr:41f29800, size:8
>> vaddr_to_paddr_arm64: Can't read pgd
>> readmem: Can't convert a virtual address(ffff800082edf8a0) to physical address.
>> readmem: type_addr: 0, addr:ffff800082edf8a0, size:390
>> check_release: Can't get the address of system_utsname.
>>
>> Although several error messages appear when loading second kernel using kexec without
>> kernel CONFIG_PROC_KCORE and CONFIG_KALLSYMS_ALL, but kexec return 0.
>>
>> Can't open (/proc/kcore).
>> Can't get the symbol of _text to calculate page_offset.
>> Can't get the symbol of _text to calculate page_offset.
>>
>> If kexec unable to get the _text address, it will result in elf_info.kern_paddr_start
>> to be a large value, and also phdr->p_filesz/phdr->p_offset to be a large value, such as:
>>
>> readelf -l /proc/vmcore
>> Program Headers:
>>    Type           Offset             VirtAddr           PhysAddr
>>                   FileSiz            MemSiz              Flags  Align
>>    NOTE           0x0000000000001000 0x0000000000000000 0x0000000000000000
>>                   0x0000000000001a44 0x0000000000001a44         0x4
>>    LOAD           0x0000000000003000 0xffffffffffffffff 0x00007fffc0200000
>>                   0xffff800083020000 0xffff800083020000  RWE    0x0
>>    LOAD           0xffff800083023000 0x0000000000000000 0x0000000040000000
>>                   0x00000001e6e00000 0x00000001e6e00000  RWE    0x0
>>    LOAD           0xffff800269e23000 0x00000001f6e00000 0x0000000236e00000
>>                   0x0000000009200000 0x0000000009200000  RWE    0x0
>>
>> This patch avoiding makedumpfile failure by ending the kexec process and explicitly
>> notifying error.
>>
> I'm afraid I cannot agree with your proposed fix. The makedumpfile
> works on /proc/vmcore. In my opinion, if there isn't enough
> information for makedumpfile to work properly, you should try to fix
> and supplement it in the first kernel.
Yes, you're right, and that's also how this patch is done;

Without this patch:
If kexec can't get the address of _text, kexec will finish “normally” 
with returning 0,
but will fail when makedumpfile. This is not what we expected.

With this patch:
kexec will abort if can't get the address ot _text and explicitly 
notifying error, and
first kernel should provide correct info based on error message.

Thanks,
Wandun

>
> Thanks,
>
> Pingfan
>
>> Reported-by: Zhao Meijing <zhaomeijing@lixiang.com>
>> Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
>> ---
>>   kexec/arch/arm64/crashdump-arm64.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
>> index 73cb611..8629610 100644
>> --- a/kexec/arch/arm64/crashdump-arm64.c
>> +++ b/kexec/arch/arm64/crashdump-arm64.c
>> @@ -94,9 +94,11 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>>                   * For compatibility, deduce by comparing the gap "__init_begin - _stext"
>>                   * and the res size of "Kernel code" in /proc/iomem
>>                   */
>> -               if (kva_text_end - kva_stext == length)
>> +               if (kva_text_end - kva_stext == length) {
>> +                       if (!kva_text)
>> +                               die("Cannot get kernel _text symbol address\n");
>>                          elf_info.kern_paddr_start = base - (kva_stext - kva_text);
>> -               else
>> +               } else
>>                          elf_info.kern_paddr_start = base;
>>          }
>>          else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
>> --
>> 2.25.1
>>



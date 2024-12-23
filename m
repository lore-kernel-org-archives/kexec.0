Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5FDE77188
	for <kexec@archiver.kernel.org>; Mon, 23 Dec 2024 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zC8Bc6w9WJr/WEAON4Ex8GuQVmEH/4UDW4KwmMSoHUQ=; b=bxALSho9DvP1nM29zZA+EXoL1y
	+hLJtbMetafCw+ewfwfA7I+4ztJJItvOKeYeQ0xZZSXDwlf1T2LGIMFA7687qpl41u8IZScQ9nnLT
	h3X2KLt0luGslYwhE82cD8v3BHePo2T/nlAiAAECsXmBCVNGdz0v6lFhZBls8Q+WNjnoyoaiq4uD7
	FgOXKIzxiCFHkFsRAYQ1UaitxDcJpOToS2iYPgPjc0vw9Mnz4QbZ4No5+Ucpc1tfbbcwXymNZslVp
	Ec08C+w8+kq07+6vvLMPt9DE9F4+T8B5/ZSlnCFmCCiNBX7BNFc75AMD46eZwojBeU8YNWxD45QCg
	8LEz7UqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPXH2-000000094rq-3DRd;
	Mon, 23 Dec 2024 01:30:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPXH0-000000094rU-2uSl
	for kexec@lists.infradead.org;
	Mon, 23 Dec 2024 01:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734917417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zC8Bc6w9WJr/WEAON4Ex8GuQVmEH/4UDW4KwmMSoHUQ=;
	b=iISluc8wgNp3cNOMfm9yQwvwGFcIp9WZPv7Ai1AtY2m1cpQf0tb/2NBwxGjkbyaMvm6hS1
	tIkEis2uHap778o/lzGTY9nnRVUSnPUd3u5QcGNhDeDB7Yp9DUWjpswlHqJUC9xNyY7iY+
	PtPOSLgIZOIllwplW7hMFTFAoLYlJuI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-cGb29iZUMWeCjKA5f40jCg-1; Sun, 22 Dec 2024 20:30:14 -0500
X-MC-Unique: cGb29iZUMWeCjKA5f40jCg-1
X-Mimecast-MFC-AGG-ID: cGb29iZUMWeCjKA5f40jCg
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fd481e3c0bso2282490a12.0
        for <kexec@lists.infradead.org>; Sun, 22 Dec 2024 17:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734917414; x=1735522214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC8Bc6w9WJr/WEAON4Ex8GuQVmEH/4UDW4KwmMSoHUQ=;
        b=LVxhZyZu7i141QFWepwxErcWGZ9J12x34KVHDTTkjoYiCVAi7QohcyY+fVBXRqOfIp
         XuDDQsMXeysJo/WswnmIcrYeHYOBEF4VhNHOMjPwLEKlitcfYgysTka+/cODZxaW1P8n
         eNeI0eA+Jy6jdDueBjlTBZyoYIADRmsE7gCdeVLpX5dX0HXv+Q9E9I2rKiO/t2450pAp
         B6ovk7ZCMdaaoR0ifpVklzmXM1K3EIUX5IWuTUeb8viEDNMutK36o0zrVQHOIQW9+OX2
         1l01qGKe959HBcupIjh+YxSPPScyIUulNWUW+X03uUg0FMqxUEISHUBVI2lyT0GAr93i
         q3Wg==
X-Gm-Message-State: AOJu0Yz/KOTKrb079CRKQdpAdEbMLXjdw559xiFZu6N1sbCmW4Qe6lWr
	Q5WZv4I0nmxHdAwAHXvChc3h4hn8q0XtXVHYoEQ7jtjjqFhrUvFQePRgFFA2p0foDQXCjgSBlAu
	KSHy0xhRPrFw15tSUFZGWWemq3TVzg3+RKESe1i2t8LHfilOljkP+GAM23w==
X-Gm-Gg: ASbGncvcDTgkbA/N9l7fjF12dqc1hgN+itGg9c1iW1RivZlm/1seEN8uYaXaH9N6J0A
	Wq7nq6PjfB0UWyytjmYhUTCMOKex8lGBb0evx0BPHgVASKY2tumIUmROWZRNZvSDJtU6fTJURa/
	0qUtxUT3HwzeHrMOfLHzc6lAPHb+mnk6bh5Kj1XN/Tx0atOFfps7JnwhGKhNqUqPcAAvSO3Cake
	MxrotTx1N8D5bHvCLe1iiB+RZDOQjSrVOU+TKNbRZZkY2Lo
X-Received: by 2002:a17:903:1301:b0:216:6283:5a8c with SMTP id d9443c01a7336-219e6f0e6a1mr130499075ad.39.1734917413650;
        Sun, 22 Dec 2024 17:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpjpN1e9i5efxat2ayYcT+3fqtNPUVcLy7x/Gjqcy1I+1VFQ9ws/o99RZ+9YTOwWgfVvePjw==
X-Received: by 2002:a17:903:1301:b0:216:6283:5a8c with SMTP id d9443c01a7336-219e6f0e6a1mr130498775ad.39.1734917413339;
        Sun, 22 Dec 2024 17:30:13 -0800 (PST)
Received: from localhost ([180.109.216.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm62758665ad.41.2024.12.22.17.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 17:30:12 -0800 (PST)
Date: Mon, 23 Dec 2024 09:16:48 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <pe6aibukdppy2p762d2qakuvxafg3ra4n7geind7w6kohaf4t6@kuzkekrbyhcn>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-7-coxu@redhat.com>
 <Z1mL2KBcRskFlffk@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z1mL2KBcRskFlffk@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6foFm2PUsQItWzhe4XW0jCz5VFUUKoC3uSjQaLgMhc8_1734917414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_173018_822042_080FCFEB 
X-CRM114-Status: GOOD (  25.11  )
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

On Wed, Dec 11, 2024 at 08:55:52PM +0800, Baoquan He wrote:
>On 10/29/24 at 01:52pm, Coiby Xu wrote:
>> 1st kernel will build up the kernel command parameter dmcryptkeys as
>> similar to elfcorehdr to pass the memory address of the stored info of
>> dm crypt key to kdump kernel.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/crash.c           | 20 ++++++++++++++++++--
>>  arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 340af8155658..99d50c31db02 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -278,6 +278,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>>  				 unsigned long long mend)
>>  {
>>  	unsigned long start, end;
>> +	int ret;
>>
>>  	cmem->ranges[0].start = mstart;
>>  	cmem->ranges[0].end = mend;
>> @@ -286,22 +287,37 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>>  	/* Exclude elf header region */
>>  	start = image->elf_load_addr;
>>  	end = start + image->elf_headers_sz - 1;
>> -	return crash_exclude_mem_range(cmem, start, end);
>> +	ret = crash_exclude_mem_range(cmem, start, end);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Exclude dm crypt keys region */
>> +	if (image->dm_crypt_keys_addr) {
>> +		start = image->dm_crypt_keys_addr;
>> +		end = start + image->dm_crypt_keys_sz - 1;
>> +		return crash_exclude_mem_range(cmem, start, end);
>> +	}
>> +
>> +	return ret;
>>  }
>>
>>  /* Prepare memory map for crash dump kernel */
>>  int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>  {
>> +	unsigned int max_nr_ranges = 3;
>
>Define a macro and add code comment to explain why this value is taken?

Good suggestion! While drafting the reason for max_nr_ranges=3, I
realize max_nr_ranges=2 is sufficient. I also notice the fill_up_crash_elf_data
function in the same source file has similar comment. So next version
I'll add the following change,


      int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
      {
     +       unsigned int nr_ranges = 0;
             int i, ret = 0;
             unsigned long flags;
             struct e820_entry ei;
             struct crash_memmap_data cmd;
             struct crash_mem *cmem;
      
     -       cmem = vzalloc(struct_size(cmem, ranges, 1));
     +       /*
     +        * Using random kexec_buf for passing dm crypt keys may cause a range
     +        * split. So use two slots here.
     +        */
     +       nr_ranges = 2;
     +       cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
             if (!cmem)
                     return -ENOMEM;
      
     +       cmem->max_nr_ranges = nr_ranges;
     +       cmem->nr_ranges = 0;

>
>>  	int i, ret = 0;
>>  	unsigned long flags;
>>  	struct e820_entry ei;
>>  	struct crash_memmap_data cmd;
>>  	struct crash_mem *cmem;
>>
>> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
>> +	cmem = vzalloc(struct_size(cmem, ranges, max_nr_ranges));
>>  	if (!cmem)
>>  		return -ENOMEM;
>>
>> +	cmem->max_nr_ranges = max_nr_ranges;
>> +
>>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>>  	cmd.params = params;
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index 68530fad05f7..9c94428927bd 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
>>  	if (image->type == KEXEC_TYPE_CRASH) {
>>  		len = sprintf(cmdline_ptr,
>>  			"elfcorehdr=0x%lx ", image->elf_load_addr);
>> +
>> +		if (image->dm_crypt_keys_addr != 0)
>> +			len += sprintf(cmdline_ptr + len,
>> +					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
>>  	}
>>  	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
>>  	cmdline_len += len;
>> @@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>>  		ret = crash_load_segments(image);
>>  		if (ret)
>>  			return ERR_PTR(ret);
>> +		ret = crash_load_dm_crypt_keys(image);
>> +		if (ret)
>> +			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
>
>If it's error, do we need change ti to pr_debug?

Thanks for raising the concern! I think it's OK to let
crash_load_dm_crypt_keys fail since disk encryption may not be used for
kdump, thus pr_debug is sufficient. Or have I misunderstood your comment?

>>  	}
>>  #endif
>>
>> --
>> 2.47.0
>>
>

-- 
Best regards,
Coiby



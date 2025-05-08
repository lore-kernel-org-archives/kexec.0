Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED6EC3ABCD
	for <kexec@archiver.kernel.org>; Thu,  8 May 2025 04:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLAUCa9/J6OHKEUzuX+nr9ajJWmHw/KD5J8lJAPWSNo=; b=VuuJwgk124xPj/fMx7FMrVItRm
	M5ybdJQZ2pDQOvwJ1KBQb1Ee610/0Ik84TuPZAl3yjlrFJGS+KC8eCfrlLj6bDMW4nvKjWBbKOIBb
	giSedfCICTXCaAYvFkpEvblUEAXXHuWnNiKd4VkBkuQQrlCusIfQ8/rISk5E0WAV1jy6c/BcB8TYS
	jDc1E5Gw9hM1F1YbvTgVPlZn7O9240hC1DEi8xaSLt/G8yfAYkFPrCI2kR2MEtlwghNbJLtsyt/4J
	g0spizdC4R+muG+w/yTaLB20Ys43gRoNA2J8V/ZyBtdGMVe3WXIeV1ku0TNhdeX28AcTuB57EgZjX
	gyHxZ7cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCsqB-0000000HHh1-0eMK;
	Thu, 08 May 2025 04:26:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCsq6-0000000HHgX-3LM1
	for kexec@lists.infradead.org;
	Thu, 08 May 2025 04:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746678388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLAUCa9/J6OHKEUzuX+nr9ajJWmHw/KD5J8lJAPWSNo=;
	b=hZRRNxzSL5BFH4Ss/4mayjptWy1aqkOwsgX5DmFBdIA2ituxrtS2piZe4d7rSzZgZwJvE3
	o/iN4O8eH/+1bAoe3bD0kM0FtEGN5MwjkSy7NY6uUROCmtR5RBn/7Zte8JjEkVsWug8dXS
	+WbtUDSSqj6JpVdaEziMuNifpcL66b0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-zJHNiZ7sMrO3a_PgHvgbcA-1; Thu, 08 May 2025 00:26:27 -0400
X-MC-Unique: zJHNiZ7sMrO3a_PgHvgbcA-1
X-Mimecast-MFC-AGG-ID: zJHNiZ7sMrO3a_PgHvgbcA_1746678386
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224347aef79so8378855ad.2
        for <kexec@lists.infradead.org>; Wed, 07 May 2025 21:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746678386; x=1747283186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLAUCa9/J6OHKEUzuX+nr9ajJWmHw/KD5J8lJAPWSNo=;
        b=FiDOJYnZP1pzjs4a46vqBQMzkGihirkvvekKcc3FM691IhZ5tleSTdB6ZXD2s85B0e
         j7VYw5PvZH4MNzYg2XsoD5/Rwdd4C97/O/G4jtYo56o965GVkITIIyhjCaukpwGxiIRN
         W1cSUHyf/c376dJj9v18d68U5bP2hd799zuJUccTNdxYrCnFIwn1r4qjFLh1bzt2+eim
         pFFf1xyWRVVr8uRFubVw7FyOLb4ogttxAuBhb+5b+Fviz5xEKcJi/C7GX1VZWkSRhkXv
         V6XdOxPwbdarSA50n3Q95a7kkXpM53EJ/I2PQmrdd6DnU9d4atfSB21bhhzE3J6YkMa2
         e6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXCb9Og6oQF9xgTAZf1eZYFbbouQaqpnFpjfcxod7USGtWbBRhcbPzovYGA26buJCcSEXIyVg==@lists.infradead.org
X-Gm-Message-State: AOJu0YykKjJfkpEDIFnizZVGXJpTlGIq5zq1iRtbNX2zQ+zCAzKPzXJz
	BGQo169Yut6aaI0r9S04/RiQpGPOd1RlJWeCvLBJvoUFDkm1oejInKqDlPhpB1SA6oNCtHE8Af4
	JBD7Om+ZlfETnA88WCJwX5rQU7bJxvB4XsRZeD7YufWNs+/Vb+J12CJ5GuQ==
X-Gm-Gg: ASbGnctXjKEoBJzE5mTidIg+uqGCE2ckP83lN0h44y8yWrIYDndPv5R7Vcc+TlacDBS
	u7oFy1yr5C8Zpx7aWlePSDFM9G7zkoXrmvgDo7UqENpJEA7sKn5Qt/am3kvdD/KL+yG+JLfHbBS
	QOwo33buTrmHfbrZesDo9dfbdJ4mAq5g42flEbyYIFPfRQx3ANnZKAqvkiQ8CQJmf8txAU17bIz
	/ZgJm/VCBxBVHGXCSHPixSlm6BuGvc64Ur2/nlTttVTeR4ohQXwd5YBUTm32qwdn4r7UjN2UgvR
	X6c=
X-Received: by 2002:a17:903:32c1:b0:223:90ec:80f0 with SMTP id d9443c01a7336-22e5ea7b7acmr103098575ad.22.1746678384817;
        Wed, 07 May 2025 21:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFQJmTOFP6CcLmvwuaAgLBrGYws4/2eAlX7bBXjQnhZUyoMlhf/Nvdm6+O1CKjSazsfFSbRQ==
X-Received: by 2002:a17:903:32c1:b0:223:90ec:80f0 with SMTP id d9443c01a7336-22e5ea7b7acmr103098275ad.22.1746678384406;
        Wed, 07 May 2025 21:26:24 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fa41f4387sm3334235ad.91.2025.05.07.21.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 21:26:24 -0700 (PDT)
Date: Thu, 8 May 2025 12:25:15 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org
Cc: fuqiang wang <fuqiang.wang@easystack.cn>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
 <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2GTe7TAZ_72onwlW8AGCPqVDMjcKrQmoBTvfh7_hv1w_1746678386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_212630_914489_9BEE4D94 
X-CRM114-Status: GOOD (  22.31  )
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

On Tue, Jan 09, 2024 at 11:46:15AM +0800, Baoquan He wrote:
>On 01/08/24 at 09:06pm, fuqiang wang wrote:
>> In memmap_exclude_ranges(), elfheader will be excluded from crashk_res.
>> In the current x86 architecture code, the elfheader is always allocated
>> at crashk_res.start. It seems that there won't be a new split range.
>> But it depends on the allocation position of elfheader in crashk_res. To
>> avoid potential out of bounds in future, add a extra slot.
>>
>> The similar issue also exists in fill_up_crash_elf_data(). The range to
>> be excluded is [0, 1M], start (0) is special and will not appear in the
>> middle of existing cmem->ranges[]. But in cast the low 1M could be
>> changed in the future, add a extra slot too.
>>
>> Previously discussed link:
>> [1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
>> [2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
>> [3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/
>>
>> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
>> ---
>>  arch/x86/kernel/crash.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index b6b044356f1b..d21592ad8952 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -149,8 +149,18 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>>  	/*
>>  	 * Exclusion of crash region and/or crashk_low_res may cause
>>  	 * another range split. So add extra two slots here.
>> +	 *
>> +	 * Exclusion of low 1M may not cause another range split, because the
>> +	 * range of exclude is [0, 1M] and the condition for splitting a new
>> +	 * region is that the start, end parameters are both in a certain
>> +	 * existing region in cmem and cannot be equal to existing region's
>> +	 * start or end. Obviously, the start of [0, 1M] cannot meet this
>> +	 * condition.
>> +	 *
>> +	 * But in order to lest the low 1M could be changed in the future,
>> +	 * (e.g. [stare, 1M]), add a extra slot.
>>  	 */
>> -	nr_ranges += 2;
>> +	nr_ranges += 3;
>>  	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
>>  	if (!cmem)
>>  		return NULL;
>> @@ -282,9 +292,16 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>  	struct crash_memmap_data cmd;
>>  	struct crash_mem *cmem;
>>
>> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
>> +	/*
>> +	 * In the current x86 architecture code, the elfheader is always
>> +	 * allocated at crashk_res.start. But it depends on the allocation
>> +	 * position of elfheader in crashk_res. To avoid potential out of
>> +	 * bounds in future, add a extra slot.
>> +	 */
>> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>>  	if (!cmem)
>>  		return -ENOMEM;
>> +	cmem->max_nr_ranges = 2;
>
>LGTM, thx
>
>Acked-by: Baoquan He <bhe@redhat.com>

Hi Andrew,

It seems this patch was missed. Will you pick it up? Without this patch,
kdump kernel will fail to be loaded by the kexec_file_load,

  [  139.736948] UBSAN: array-index-out-of-bounds in arch/x86/kernel/crash.c:350:25
  [  139.742360] index 0 is out of range for type 'range [*]'
  [  139.745695] CPU: 0 UID: 0 PID: 5778 Comm: kexec Not tainted 6.15.0-0.rc3.20250425git02ddfb981de8.32.fc43.x86_64 #1 PREEMPT(lazy) 
  [  139.745698] Hardware name: Amazon EC2 c5.large/, BIOS 1.0 10/16/2017
  [  139.745699] Call Trace:
  [  139.745700]  <TASK>
  [  139.745701]  dump_stack_lvl+0x5d/0x80
  [  139.745706]  ubsan_epilogue+0x5/0x2b
  [  139.745709]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
  [  139.745711]  crash_setup_memmap_entries+0x2d9/0x330
  [  139.745716]  setup_boot_parameters+0xf8/0x6a0
  [  139.745720]  bzImage64_load+0x41b/0x4e0
  [  139.745722]  ? find_next_iomem_res+0x109/0x140
  [  139.745727]  ? locate_mem_hole_callback+0x109/0x170
  [  139.745737]  kimage_file_alloc_init+0x1ef/0x3e0
  [  139.745740]  __do_sys_kexec_file_load+0x180/0x2f0
  [  139.745742]  do_syscall_64+0x7b/0x160
  [  139.745745]  ? do_user_addr_fault+0x21a/0x690
  [  139.745747]  ? exc_page_fault+0x7e/0x1a0
  [  139.745749]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [  139.745751] RIP: 0033:0x7f7712c84e4d

Thanks!

-- 
Best regards,
Coiby



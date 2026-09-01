Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4814FC61DFD
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 01:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86qIo5v7jjY4HW3fkGNEhrjgiOH2gQXAnQ/w3mZCYX4=; b=VXW8L4PpNs1Qp7E88h9BCzDRZ/
	J/vWxkGpdp/hV1JBfh2t5mJKPmHs5YtPfNKGoC5wmiEdxA5Jd4rvI8MQSxSLDAnuZIR7FEYl5D+RB
	2PLah70PVqiMFcFCTU1vqctlNbdbxBeB8/Kb+RsDatPDI1cQqX06yD1T7N9uMZucN0Hk7Yu205V41
	Q5Q9aDgWuahej0VOg2U7splFn16MTwO8XEr9Y4qGYRzlBzTLkpgPGiyAEXL+fsM1Jt4N++4yn6Ppn
	AoFwshkXBjGT37dznqsIx+DZD87X466aQXqFJFo9ylxRS+zneFaNnFkva42MRzdgZRaUEeHqT1/jO
	bKBNAk8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1DQT-0000000AoMH-0E8D;
	Tue, 01 Sep 2026 01:36:37 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1DQP-0000000AoLT-3ELA
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 01:36:35 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=86qIo5v7jjY4HW3fkGNEhrjgiOH2gQXAnQ/w3mZCYX4=;
	b=Qjj5KFSWecCIt6dholXauErXASvKGekw610GO6dhVENlL/2e0knDpsbbOGR8vDKBV0lg8FPbE
	TVFTeFCcakARlI56/Xq4+OQFB2l6FLeB4IllFRlEEyP/hIoTey8/EDltuPkC/jpuIqwKkmsOJCY
	QpfQnD6mCb/v6wOxaHWhr+4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hYp886mTNzcb0f;
	Tue,  1 Sep 2026 09:25:28 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 326E340561;
	Tue,  1 Sep 2026 09:36:12 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Sep 2026 09:36:11 +0800
Message-ID: <dbfbccf8-8344-4893-a93f-ef6d316e0f7b@huawei.com>
Date: Tue, 1 Sep 2026 09:36:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coiby.xu@gmail.com>
CC: <kexec@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-2-coiby.xu@gmail.com>
 <76f634e3-9adb-4ae2-b2b0-a7e13a2f93c3@huawei.com> <apWEBBMz6aFBeefa@Rk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <apWEBBMz6aFBeefa@Rk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_183634_197211_3BF2B0A9 
X-CRM114-Status: GOOD (  22.94  )
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



在 2026/8/31 21:44, Coiby Xu 写道:
> On Mon, Aug 31, 2026 at 03:39:35PM +0800, Jinjie Ruan wrote:
>>
>>
>> 在 2026/8/28 16:48, Coiby Xu 写道:
>>> If kexec_add_buffer somehow fails, keys_header will be freed. Depending
>>> on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>> following two problems if the kexec_file_load syscall is called again,
>>>   1. Double free of keys_header if reuse=false
>>>   2. UAF of keys_header if reuse=true
>>>
>>> To address these problems and also make it easier to reason about the
>>> code, keep two invariants,
>>>   1. keys_header will always be freed at the end of kexec_file_load
>>>      syscall except during kdump image unloading for CPU/memory
>>>      hot-plugging support
>>>   2. There will always be valid keys_header if reuse=true
>>>
>>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump
>>> reserved memory")
>>> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/
>>> memory hot-plugging")
>>> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>> ---
>>>  include/linux/kexec.h        |  6 ++++
>>>  kernel/crash_dump_dm_crypt.c | 66 ++++++++++++++++++++++++++----------
>>>  kernel/kexec_file.c          |  2 ++
>>>  3 files changed, 56 insertions(+), 18 deletions(-)
>>>

[...]

>>> @@ -369,9 +387,6 @@ static int build_keys_header(void)
>>>      struct config_key *key;
>>>      int i, r;
>>>
>>> -    if (keys_header != NULL)
>>> -        kvfree(keys_header);
>>> -
>>>      keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>>      if (!keys_header)
>>>          return -ENOMEM;
>>> @@ -415,8 +430,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>          .top_down = false,
>>>          .random = true,
>>>      };
>>> -    int r;
>>> -
>>> +    int r = 0;
>>>
>>>      if (key_count <= 0) {
>>>          kexec_dprintk("No dm-crypt keys\n");
>>> @@ -424,14 +438,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>      }
>>>
>>>      if (!is_dm_key_reused) {
>>> -        image->dm_crypt_keys_addr = 0;
>>>          r = build_keys_header();
>>> -        if (r) {
>>> -            pr_err("Failed to build dm-crypt keys header, ret=%d\n",
>>> r);
>>> -            return r;
>>> -        }
>>> +        if (r)
>>> +            goto out;
>>>      }
>>>
>>> +    /*
>>> +     * keys_header will be copied to reserver memory later and then be
>>> +     * cleaned up at the end of kexec_file_load syscall
>>> +     */
>>>      kbuf.buffer = keys_header;
>>>      kbuf.bufsz = get_keys_header_size(key_count);
>>>
>>> @@ -441,18 +456,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>      r = kexec_add_buffer(&kbuf);
>>>      if (r) {
>>>          pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>> -        kvfree((void *)kbuf.buffer);
>>> -        return r;
>>> +        goto out;
>>>      }
>>> +
>>>      image->dm_crypt_keys_addr = kbuf.mem;
>>>      image->dm_crypt_keys_sz = kbuf.bufsz;
>>>      kexec_dprintk(
>>>          "Loaded dm crypt keys to kexec_buffer bufsz=0x%lx
>>> memsz=0x%lx\n",
>>>          kbuf.bufsz, kbuf.memsz);
>>>
>>> +out:
>>> +    is_dm_key_reused = false;
>>
>> I think there's still a bug for arm64 here.
>>
>> When is_dm_key_reused set to true, the outer while loop prematurely
>> clears the is_dm_key_reused flag at the end of
>> crash_load_dm_crypt_keys() in the very first iteration.
>>
>> Consequently, subsequent re-entrant calls to crash_load_dm_crypt_keys()
>> falsely perceive the keys as not reused, forcing a redundant execution
>> of build_keys_header() which overwrites the global keys_header pointer;
>>
>> This induces a silent kernel memory leak.
> 
> Thanks for reviewing this patch and raising the concern! Unless I miss
> something, I don't think the global keys_header will be overwritten
> because kexec_file_post_load_cleanup_dm_crypt will called to free the
> memory during the end of kexec_file_load syscall.

Hi Coiby,

Not really on arm64, as below:

kexec_file_load syscall
-> kimage_file_alloc_init()
   -> kimage_file_prepare_segments()
      -> kexec_image_load_default()
         -> arm64 image_load()
            -> load_other_segments() while retry loop
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
               -> crash_load_dm_crypt_keys()  -> May be called
repeatedly!!! Memory leak bug here as I described above,

      -> kimage_file_post_load_cleanup()

> 
>>
>> 92 >-------/*
>> 93 >------- * The location of the kernel segment may make it impossible
>> to satisfy
>> 94 >------- * the other segment requirements, so we try repeatedly to
>> find a
>> 95 >------- * location that will work.
>> 96 >------- */
>> 97 >-------while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>> 98 >------->-------/* Try to load additional data */
>> 99 >------->-------kernel_segment = &image-
>> >segment[kernel_segment_number];
>> 100 >------->-------ret = load_other_segments(image, kernel_segment->mem,
>> 101 >------->------->------->------->-------  kernel_segment->memsz,
>> initrd,
>> 102 >------->------->------->------->-------  initrd_len, cmdline);
>> 103 >------->-------if (!ret)
>> 104 >------->------->-------break;
>> 105
>> 106 >------->-------/*
>> 107 >------->------- * We couldn't find space for the other segments;
>> erase the
>> 108 >------->------- * kernel segment and try the next available hole.
>> 109 >------->------- */
>> 110 >------->-------image->nr_segments -= 1;
>> 111 >------->-------kbuf.buf_min = kernel_segment->mem +
>> kernel_segment->memsz;
>> 112 >------->-------kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> 113 >-------}
> 
> Btw, I assume the above text is not related to the discussion, right?

The code closely related to my description above — the arm64
crash_load_dm_crypt_keys() — is exactly called within the
load_other_segments() in the while loop mentioned earlier. Therefore,
crash_load_dm_crypt_keys() may be called repeatedly before
kexec_file_post_load_cleanup_dm_crypt().

We can refer to the arm64 commit 108aa503657e ("arm64: kexec_file: try
more regions if loading segments fails") , which introduced the retry loop.

Best regards,
Jinjie

> [...]
> 



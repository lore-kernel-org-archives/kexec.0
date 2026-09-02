Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AC2C61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=28GLq6NNTuabDAm8b5PyzUlgoNa+fBPwUe8jszYCNbg=; b=UWMa78jDA7u6Bm5rntar50onft
	ZS43vFCF1XTsiZNHpjLrnhB/wn2IcaYBur1cvgpsJLDk4MWYqEYpVsh/nMVHnupU9kJBNygDOgq+b
	k8ElfvYuZbCIgxvobxG4NlBf8d1USS/avFWPFp64XL6+g3HjpdUa+Y4sX35vU9rPfFyTgyeshnN+l
	NbAEwb2jLm9ioC0INaJ6cSQ8wB2RLn3WDltmYICHl8PopYhtSgJWhRq0py2hC3mxceml8o0R7hb4E
	l+RX3R/xf7hYB2ijldqvap6g23pV1+rqd4HaBRqDjbOjC6qnjljWNx9AYqlVXfqJa0DzYFIE84UoS
	JNneNwdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1klO-0000000Em4W-1YW3;
	Wed, 02 Sep 2026 13:12:26 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1klL-0000000Em3z-3tNx
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 13:12:24 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-84864086bfeso859619b3a.1
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788354743; x=1788959543; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=28GLq6NNTuabDAm8b5PyzUlgoNa+fBPwUe8jszYCNbg=;
        b=j1ARbSB1LTlM/bq8GHo0bx1blXWfFCSrX64Vw/alf+ovW5ocJrsdqKBEGxb9MCzBRX
         ce7tV2XoHQe6eBRf/X/1+Dp8xsijfeL9TwoC38rGuyNntsp/UyuUJ6ISXlBR4Lteg7ee
         mtlD2+clvXJddLLmrm/OfDrpPHmkuaqYkayddupvBE484p+EqxLQ2XCPymH3I8HrhF/8
         D0bytuNvVVvx6bwaPCso+usMrrYSlNrO/U1HPYvTGdqjMvxHprXZOykXKbIV2b5czD4h
         ju9jDff6gcECXJ2XSowbWAyNFe9DlGOzCWkKxdfPJTojDbEZmoeB9P7tlLns8rdnsEsC
         NQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354743; x=1788959543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=28GLq6NNTuabDAm8b5PyzUlgoNa+fBPwUe8jszYCNbg=;
        b=hoN8BG9MKRCJFtUFFn61F8MH82ANm2ifRHC4MqfhwQo0ChJE8FOd27ehPZavsVmDd3
         nOQjffLJsdFgoTeLgk34RPcNR5EjaEXhYoWBhQISOUPrzdOaF+DwEdsZJiWZEmGno82c
         6n578UqDJhMSok7XYH8W9GvB42tWbho24FZ2Z0UAiIiDSD9zG6EburQcmHNwl7ICxeqO
         vnS/RHItIWZeP/arPKghehObm55rZ3MWjXtytwFjT2zwacxoW5Oj/TbLFHfQX+e+Xvu4
         8Rtj/5jR7T0XI8VNAzxPee5lM0OV8yDXUwYyhP+1Pc4eqH0w1IclIQTnqa3jB4PGLmC1
         ujWQ==
X-Gm-Message-State: AFuF++m7KaN0Ri4VI3dxdiCwuxyVZpkayVzmbkQqUJXd0vOvsQX0kGLk
	n6nVjP4V79Iv+3rC5q8abvrAU5MCG6kmm0K7/X5cRmVt0+40u0ptHJas
X-Gm-Gg: AYBFou03M6noy4u/TikLGuT6wh7BPpsL24vQakndCD3j/Cu17+w7mFzICtS8fIXvgoD
	7BrZFGSmAA69xV2TCMvvmYpIpiNpuugXuZN5nfiHJ2LFKNaRULJYrTovm8sQhQBLooIlRpshlv+
	+9Wp/c3pac7KkP+D8ykmy1BF6UAkMFwMS16TEOUID7oibXXkkg2ptefDOfbZjIXjNpDiB8C0kgL
	4G8v3MDF5/AHBsdsfYKQawHRJYeSea6KW0DPuFD3QsgnMuS6y+D4BsRmEAH2N5stQdX1/V0Au4q
	cb63YTiB8/mcyA860ReSp9g23hNsgEh4N/HmZlkV/vpfMAjqu4A4wZf0evAlIKgB9d3VmrEy7bd
	ibkUGq+4nezDB5E/B4VujB5LFxvkL8/JLe5FztoNj39/mGBzl8rTsG9R9ZJT09nikoK0WXLHFzX
	HTkqMkpIUS7ni0+KoyPQqq3yIAI0F4j8G3Oy3C9X9M4dPt+fR2KmbLuLTH
X-Received: by 2002:a05:6a00:1307:b0:848:3f07:c5a2 with SMTP id d2e1a72fcca58-85ed1d08ca3mr5963021b3a.4.1788354742377;
        Wed, 02 Sep 2026 06:12:22 -0700 (PDT)
Received: from localhost ([45.112.46.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc003a8fbsm1329126b3a.35.2026.09.02.06.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:12:21 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 2 Sep 2026 20:53:51 +0800
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>, 
	Dave Young <ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <apgYPxG3VjhColxZ@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-2-coiby.xu@gmail.com>
 <76f634e3-9adb-4ae2-b2b0-a7e13a2f93c3@huawei.com>
 <apWEBBMz6aFBeefa@Rk>
 <dbfbccf8-8344-4893-a93f-ef6d316e0f7b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbfbccf8-8344-4893-a93f-ef6d316e0f7b@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_061223_979006_733CF210 
X-CRM114-Status: GOOD (  28.84  )
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

On Tue, Sep 01, 2026 at 09:36:10AM +0800, Jinjie Ruan wrote:
>
>
>在 2026/8/31 21:44, Coiby Xu 写道:
>> On Mon, Aug 31, 2026 at 03:39:35PM +0800, Jinjie Ruan wrote:
>>>
>>>
>>> 在 2026/8/28 16:48, Coiby Xu 写道:
>>>> If kexec_add_buffer somehow fails, keys_header will be freed. Depending
>>>> on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>>> following two problems if the kexec_file_load syscall is called again,
>>>>   1. Double free of keys_header if reuse=false
>>>>   2. UAF of keys_header if reuse=true
>>>>
>>>> To address these problems and also make it easier to reason about the
>>>> code, keep two invariants,
>>>>   1. keys_header will always be freed at the end of kexec_file_load
>>>>      syscall except during kdump image unloading for CPU/memory
>>>>      hot-plugging support
>>>>   2. There will always be valid keys_header if reuse=true
>>>>
>>>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump
>>>> reserved memory")
>>>> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/
>>>> memory hot-plugging")
>>>> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>>> ---
>>>>  include/linux/kexec.h        |  6 ++++
>>>>  kernel/crash_dump_dm_crypt.c | 66 ++++++++++++++++++++++++++----------
>>>>  kernel/kexec_file.c          |  2 ++
>>>>  3 files changed, 56 insertions(+), 18 deletions(-)
>>>>
>
>[...]
>
>>>> @@ -369,9 +387,6 @@ static int build_keys_header(void)
>>>>      struct config_key *key;
>>>>      int i, r;
>>>>
>>>> -    if (keys_header != NULL)
>>>> -        kvfree(keys_header);
>>>> -
>>>>      keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>>>      if (!keys_header)
>>>>          return -ENOMEM;
>>>> @@ -415,8 +430,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>>          .top_down = false,
>>>>          .random = true,
>>>>      };
>>>> -    int r;
>>>> -
>>>> +    int r = 0;
>>>>
>>>>      if (key_count <= 0) {
>>>>          kexec_dprintk("No dm-crypt keys\n");
>>>> @@ -424,14 +438,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>>      }
>>>>
>>>>      if (!is_dm_key_reused) {
>>>> -        image->dm_crypt_keys_addr = 0;
>>>>          r = build_keys_header();
>>>> -        if (r) {
>>>> -            pr_err("Failed to build dm-crypt keys header, ret=%d\n",
>>>> r);
>>>> -            return r;
>>>> -        }
>>>> +        if (r)
>>>> +            goto out;
>>>>      }
>>>>
>>>> +    /*
>>>> +     * keys_header will be copied to reserver memory later and then be
>>>> +     * cleaned up at the end of kexec_file_load syscall
>>>> +     */
>>>>      kbuf.buffer = keys_header;
>>>>      kbuf.bufsz = get_keys_header_size(key_count);
>>>>
>>>> @@ -441,18 +456,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>>      r = kexec_add_buffer(&kbuf);
>>>>      if (r) {
>>>>          pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>>> -        kvfree((void *)kbuf.buffer);
>>>> -        return r;
>>>> +        goto out;
>>>>      }
>>>> +
>>>>      image->dm_crypt_keys_addr = kbuf.mem;
>>>>      image->dm_crypt_keys_sz = kbuf.bufsz;
>>>>      kexec_dprintk(
>>>>          "Loaded dm crypt keys to kexec_buffer bufsz=0x%lx
>>>> memsz=0x%lx\n",
>>>>          kbuf.bufsz, kbuf.memsz);
>>>>
>>>> +out:
>>>> +    is_dm_key_reused = false;
>>>
>>> I think there's still a bug for arm64 here.
>>>
>>> When is_dm_key_reused set to true, the outer while loop prematurely
>>> clears the is_dm_key_reused flag at the end of
>>> crash_load_dm_crypt_keys() in the very first iteration.
>>>
>>> Consequently, subsequent re-entrant calls to crash_load_dm_crypt_keys()
>>> falsely perceive the keys as not reused, forcing a redundant execution
>>> of build_keys_header() which overwrites the global keys_header pointer;
>>>
>>> This induces a silent kernel memory leak.
>>
>> Thanks for reviewing this patch and raising the concern! Unless I miss
>> something, I don't think the global keys_header will be overwritten
>> because kexec_file_post_load_cleanup_dm_crypt will called to free the
>> memory during the end of kexec_file_load syscall.
>
>Hi Coiby,

Hi Jinjie,

>
>Not really on arm64, as below:
>
>kexec_file_load syscall
>-> kimage_file_alloc_init()
>   -> kimage_file_prepare_segments()
>      -> kexec_image_load_default()
>         -> arm64 image_load()
>            -> load_other_segments() while retry loop
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>               -> crash_load_dm_crypt_keys()  -> May be called
>repeatedly!!! Memory leak bug here as I described above,

Thanks for providing the stack trace to help me understand the problem!
Now I see what I missed. I also notice your 
"[PATCH v3 04/17] arm64: kexec_file: Fix elf_headers memory leak in retry loop" 
is addressing the same problem for the elf_headers. I'll have a careful
look at related patches and re-think the solution.

>
>      -> kimage_file_post_load_cleanup()
>
>>
>>>
>>> 92 >-------/*
>>> 93 >------- * The location of the kernel segment may make it impossible
>>> to satisfy
>>> 94 >------- * the other segment requirements, so we try repeatedly to
>>> find a
>>> 95 >------- * location that will work.
>>> 96 >------- */
>>> 97 >-------while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>>> 98 >------->-------/* Try to load additional data */
>>> 99 >------->-------kernel_segment = &image-
>>> >segment[kernel_segment_number];
>>> 100 >------->-------ret = load_other_segments(image, kernel_segment->mem,
>>> 101 >------->------->------->------->-------  kernel_segment->memsz,
>>> initrd,
>>> 102 >------->------->------->------->-------  initrd_len, cmdline);
>>> 103 >------->-------if (!ret)
>>> 104 >------->------->-------break;
>>> 105
>>> 106 >------->-------/*
>>> 107 >------->------- * We couldn't find space for the other segments;
>>> erase the
>>> 108 >------->------- * kernel segment and try the next available hole.
>>> 109 >------->------- */
>>> 110 >------->-------image->nr_segments -= 1;
>>> 111 >------->-------kbuf.buf_min = kernel_segment->mem +
>>> kernel_segment->memsz;
>>> 112 >------->-------kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>> 113 >-------}
>>
>> Btw, I assume the above text is not related to the discussion, right?
>
>The code closely related to my description above — the arm64
>crash_load_dm_crypt_keys() — is exactly called within the
>load_other_segments() in the while loop mentioned earlier. Therefore,
>crash_load_dm_crypt_keys() may be called repeatedly before
>kexec_file_post_load_cleanup_dm_crypt().
>
>We can refer to the arm64 commit 108aa503657e ("arm64: kexec_file: try
>more regions if loading segments fails") , which introduced the retry loop.

Thanks for the explanation and also pointing me to the reference commit!

>
>Best regards,
>Jinjie
>
>> [...]
>>
>

-- 
Best regards,
Coiby


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2EECCF9E3
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-version:References:Message-ID:Date:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/V8SB8wmxGRLK9NXekCk5M/b8yuKeNKq7vKtXV2cr44=; b=21F+x0VMqAqIN6ZEFmSqFklz/6
	WIdsPTnaP5GPZpD+/FoT9XXK5ZjkYHD6Qxb/zZCtO4VG3YMHLlu/eNmCptP4w27T/0BKKjT5Gx/6W
	J7IGJWivz1jzBEzqlJ/i9zWzqdVzzMilUvrgQhVZDfdLeJhaCRg7w7F2lxrhuyFpkIgZ2iD7Ag+Yd
	+1dbbxGBa+1p/hCHutGBHVdcbLvrhkT621Fi+Q5lAIUGP4ZBKSqLXyNYp6jDy6snpkRDqlU1HDZqr
	lCV0Up8QkHpT43c7nbAC8O901+S70EOpEIi/6pWK2tS/pKHMiqzWjcxI8zVOTeijleB5MLuR1QE/o
	ZhqluULw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEbk-0000000BerP-1lyy;
	Tue, 04 Nov 2025 10:49:48 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEbh-0000000BeqK-3CJn
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 10:49:46 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4755457a12.3
        for <kexec@lists.infradead.org>; Tue, 04 Nov 2025 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762253384; x=1762858184; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/V8SB8wmxGRLK9NXekCk5M/b8yuKeNKq7vKtXV2cr44=;
        b=UHR2CxAcl3LvL4+8DVagZXLSuX5DZEGmErmDRo6v+nxRJMNipe3uajp7HjjFNHz4t6
         mgG8hZp3xhC0GwfUlIvuEfIoMnK0HMvBNYUBlHu+8mwYqxPPaYAwCEtgaiYnb5ByTpgn
         l8kRztZ8PADT0R15YRV+YeGdmHxKzg4XaoX80xRzLUgI5EhRSwCHCVIK+ZOKVmByDW5G
         skfXhcuRQnFhC77/Zm5yRK02sHKfmaQ2ZHFpjxcHZm2qJAJOS8VGK13QB8QJGw/xDH22
         IY8LclmGGCbsNGuFke7/K91DQWUKOLprivced5jwlNBxuhpk/Lo4bWb5QlbGSRpZirjy
         6yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253384; x=1762858184;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V8SB8wmxGRLK9NXekCk5M/b8yuKeNKq7vKtXV2cr44=;
        b=ka513RLcsfiRY92lYGSd23IxuaGY5dVzv6QLEVrD7ea7sZaay3HdLhDVEgju1B4hDo
         GNcIcYno8fJ/qmeWghXY+iv+UypwpKma8RiaDLDtQf/5RfE82n5h0YcoWwPcPJfdhWn/
         bLlwNewnQ+wz8l1B+cpyoKKkdRaYTRwz1ea5irrUe/jfHUGpB4qISkUaNaLRa+R+efkW
         9yO8Qq9NvIyhfvw/dyQ4OvQtTPXhDneWunUgHIWbHzFUXDnlcGHENGRUlCIq6vV90Xdx
         cHWDDQKFWKThtzFny6ZK6VmAQ0M5ndqiPeUfIuEPPf3Y/QqR6lRENq6DQekgTbByn6nq
         Q3wg==
X-Forwarded-Encrypted: i=1; AJvYcCVbNQl3uOmxDX3m2TY14y0PCh1Qqdzy4g5Io6jrSoOrJrX/OoVbg5imObw5wVpjDq/IsAAXPg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxa5ysbu/axz9k9wMIJK/ZNWygK+8k+BbxkEeTWYqoE9pWTJpQ6
	5WBX2zJlCxl8LPi0Y+Yd5ZHBx6OAp4ojaZp/scl4qRbB8TwJrxHCXZsXJffSWaTz
X-Gm-Gg: ASbGncuSsVOxcBXqBK8OCg5Pd2Mmp95e/nZv/pxfVx+9okNzX3D+uUUTeLGGsCLiW1/
	aIqnKO5PdW+xslGcYqER0WqnKq0BqeRIvnpoteE5/UNutCN7Rz4QGh6wv0M6G6UuhlYtSNiUxW0
	SH9yWz/Xbkad9ktEvCgVK49Uj9Dk9ej/dt/GVuv84YbGU1/vcD0Q8hBpTwUZaogWDJ5zsLK57e0
	+qYsB8oc/+e78EAmuo+m59IrOwE2Ca7M/Ukd+Uo8WvJ6GHhfVrdgStltnGa7T951qpZ3nwuUS8i
	rxclNlJcjEULAEu9tEDc//bwKGwGQLrHJ+4LFUZk3Fnw+vRQQllZw3tk0uKF6sSSLmFK6kQHUZ6
	R5sgrvgXLer1Q7DLAt2CesYpNpbnJElATnwhY4v0atYe3iQJ7HiydSTQn9u7xKICHafruCg==
X-Google-Smtp-Source: AGHT+IEagjfzqDQ2E+D55TWI8za2FrJkZx2pQcUSw191Qy4tAKklb54PYaJ30Q+8E39qVOw+FKMedw==
X-Received: by 2002:a05:6a20:9389:b0:334:9b5d:388e with SMTP id adf61e73a8af0-348cac871bemr23688992637.26.1762253383649;
        Tue, 04 Nov 2025 02:49:43 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1e7983986sm2078634a12.0.2025.11.04.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:49:42 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Baoquan he <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v5] powerpc/kdump: Add support for crashkernel CMA reservation
In-Reply-To: <ea44849c-9d0f-43cc-9476-42bc619728f6@linux.ibm.com>
Date: Tue, 04 Nov 2025 15:54:44 +0530
Message-ID: <87v7jq3xjn.ritesh.list@gmail.com>
References: <20251103043747.1298065-1-sourabhjain@linux.ibm.com> <87y0on4ebh.ritesh.list@gmail.com> <7957bd55-5bda-406f-aab3-64e0620bd452@linux.ibm.com> <ea44849c-9d0f-43cc-9476-42bc619728f6@linux.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_024945_808110_DF780229 
X-CRM114-Status: GOOD (  30.26  )
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On 04/11/25 10:48, Sourabh Jain wrote:
>>
>>
>> On 03/11/25 15:40, Ritesh Harjani (IBM) wrote:
>>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>>
>>>> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
>>>> crashkernel= command line option") and commit ab475510e042 ("kdump:
>>>> implement reserve_crashkernel_cma") added CMA support for kdump
>>>> crashkernel reservation.
>>>>
>>>> Extend crashkernel CMA reservation support to powerpc.
>>>>
>>>> The following changes are made to enable CMA reservation on powerpc:
>>>>
>>>> - Parse and obtain the CMA reservation size along with other 
>>>> crashkernel
>>>>    parameters
>>>> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump
>>>> - Include the CMA-reserved ranges in the usable memory ranges for the
>>>>    kdump kernel to use.
>>>> - Exclude the CMA-reserved ranges from the crash kernel memory to
>>>>    prevent them from being exported through /proc/vmcore.
>>>>
>>>> With the introduction of the CMA crashkernel regions,
>>>> crash_exclude_mem_range() needs to be called multiple times to exclude
>>>> both crashk_res and crashk_cma_ranges from the crash memory ranges. To
>>>> avoid repetitive logic for validating mem_ranges size and handling
>>>> reallocation when required, this functionality is moved to a new 
>>>> wrapper
>>>> function crash_exclude_mem_range_guarded().
>>>>
>>>> To ensure proper CMA reservation, reserve_crashkernel_cma() is called
>>>> after pageblock_order is initialized.
>>>>
>>>> Update kernel-parameters.txt to document CMA support for crashkernel on
>>>> powerpc architecture.
>>>>
>>>> Cc: Baoquan he <bhe@redhat.com>
>>>> Cc: Jiri Bohac <jbohac@suse.cz>
>>>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>>>> Cc: kexec@lists.infradead.org
>>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>> ---
>>>> Changlog:
>>>>
>>>> v3 -> v4
>>>>   - Removed repeated initialization to tmem in
>>>>     crash_exclude_mem_range_guarded()
>>>>   - Call crash_exclude_mem_range() with right crashk ranges
>>>>
>>>> v4 -> v5:
>>>>   - Document CMA-based crashkernel support for ppc64 in 
>>>> kernel-parameters.txt
>>>> ---
>>>>   .../admin-guide/kernel-parameters.txt         |  2 +-
>>>>   arch/powerpc/include/asm/kexec.h              |  2 +
>>>>   arch/powerpc/kernel/setup-common.c            |  4 +-
>>>>   arch/powerpc/kexec/core.c                     | 10 ++++-
>>>>   arch/powerpc/kexec/ranges.c                   | 43 
>>>> ++++++++++++++-----
>>>>   5 files changed, 47 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>> index 6c42061ca20e..0f386b546cec 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -1013,7 +1013,7 @@
>>>>               It will be ignored when crashkernel=X,high is not used
>>>>               or memory reserved is below 4G.
>>>>       crashkernel=size[KMG],cma
>>>> -            [KNL, X86] Reserve additional crash kernel memory from
>>>> +            [KNL, X86, ppc64] Reserve additional crash kernel 
>>>> memory from
>>> Shouldn't this be PPC and not ppc64?
>>>
>>> If I see the crash_dump support...
>>>
>>> config ARCH_SUPPORTS_CRASH_DUMP
>>>     def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
>>>
>>> The changes below aren't specific to ppc64 correct?
>>
>> The thing is this feature is only supported with KEXEC_FILE and which 
>> only supported on PPC64:
>>
>> config ARCH_SUPPORTS_KEXEC_FILE
>>     def_bool PPC64
>>
>> Hence I kept it as ppc64.
>>

I am not much familiar with the kexec_load v/s kexec_file_load
internals. Maybe because of that I am unable to clearly understand your
above points.

But let me try and explain what I think you meant :)

We first call "get_usable_memory_ranges(&umem)" which updates the usable
memory ranges in "umem". We then call "update_usable_mem_fdt(fdt, umem)"
which updates the FDT for the kdump kernel's fdt to inform about these
usable memory ranges to the kdump kernel.

Now since your patch only does that in get_usable_memory_range(), this
extra CMA reservation is mainly only useful when the kdump load happens
via kexec_file_load(), (because get_usable_memory_range() only gets
called from kexec_file_load() path)

Is this what you meant here?


>> I think I should update that in the commit message.
>>
>> Also do you think is it good to restrict this feature to KEXEC_FILE?
>
> Putting this under KEXEC_FILE may not help much because KEXEC_FILE is 
> enabled
> by default in most configurations. Once it is enabled, the CMA 
> reservation will
> happen regardless of which system call is used to load the kdump kernel
> (kexec_load or kexec_file_load).
>

What I understood from the feature was that, on the normal production
kernel this feature crashkernel=xM,cma allows to reserve an extra xMB of
memory as a CMA region for kdump kernel's memory allocations. But this
CMA reservation would happen in the normal kernel itself during
setup_arch() -> kdump_cma_reserve().. 

And this CMA reservation happens irrespective of whether the kdump
kernel will get loaded via whichever system call.

> However, not restricting this feature to KEXEC_FILE will allow the kexec 
> tool to
> independently add support for this feature in the future for the kexec_load
> system call.

Sure.

>
> With that logic, I think if we do not restrict this feature to 
> KEXEC_FILE, the support
> will be available for ppc and not limited to ppc64.
>

Yes, that make sense.

If one doesn't want to make the CMA reservation, then we need not pass
the extra cmdline argument and no reservation will be made. So, no need
to restrict this to PPC64 by making it available only for KEXEC_FILE.


-ritesh


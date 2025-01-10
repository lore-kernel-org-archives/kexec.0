Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DE5E7719C
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ve3lNtLuYnUEedIKyQHjHUym+uf/AdZFMUlHp8J/SPs=; b=IBpKEeHrR4GY74tcc03ejGdqPf
	5JbU9/7Z+r6pdRW8+fHOHig89qh31cAeY9/KEt5XpHEDykuB7hZiHEYQIkbs7HMktn/p6lggF8wb2
	CWzgu7Qc/4KL4++KG0DcdTonhfWy0lvWhg4y6yAY0wHC4iOLe9OweD5/HC0v1d7n4c9Uine1axHdn
	1oWysy1DSAF41W9grqD1OcGW5c+ChNm+jrPE1E7h9ckbzjd9qvehZ3sYgspQx+DohbrizZQkvTSVl
	vRXW8uJzQQ0HIksbKOOel57D0RbrpjPKJ9l1tBDQZvrdGKWvYXCCFyWDHZa4nXvPl1ECmFy/GFr6x
	vxu1uyAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWCif-0000000F2Jk-0mUZ;
	Fri, 10 Jan 2025 10:58:25 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWCeL-0000000F1Zh-1qU2
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 10:53:58 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso3097251a12.1
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 02:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736506435; x=1737111235; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve3lNtLuYnUEedIKyQHjHUym+uf/AdZFMUlHp8J/SPs=;
        b=BDNly1OLwgkQXo3SujRQmgHwnBpfOIQt1wRyFMlCC2SCvWgzvz8sWo0LW0zCxsJgjO
         FRATW+4S27j8AjWYMbxiCkDq2tNI1XhYaHdqH6ckzlKOfUEQY3ROQMxu/zikLz1IgYm9
         Ftl2HM+MO5Dp6WB6hPiaWqnuo7yiksNU8SLwF5HY8DXbYDd6sxfBS/34XDyt56pkMpPK
         fIdpGiVvO0YPsf/j89FY/K4XUAe4tfZjnq/VplwrqMCb6yABv13xzrVSYzQBHQLA+Hat
         S8/olnK9Mc5cpLwQJq03MotLi6uO0wcbfGk0Y6iDS/txKcI7U/kdAPh515gkLQrKubjt
         c6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506435; x=1737111235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve3lNtLuYnUEedIKyQHjHUym+uf/AdZFMUlHp8J/SPs=;
        b=H0YbDyN6wEpRmzo8fXmkmsh1aI5X/GGZO2HNMAyDdw1J35tG+bU+2k3BCjnqPNnl4D
         gb0qnGyXCr3TniqSy+/B0v1HOvLocr/h1XNpIeYlsPm0ErMdiO3NPglB5fDfLU2otJlO
         mIdyI0pCYKkwfjHz8Pn0i3lqMc6NfJnPTb9UFM6l6GyRPl+ESN5MKThz9YrgIPSZFKKW
         sm6K26YvdAgP5c2e2u60qYlKS+BKHsJK57aFn1kRhxRyi70V4fENYy/uVhroLVXX+hp0
         1KgM279CSwgu0PIQtXhnDMKdetJ5HiEJvQK6Ewyln2DXprqs+YVuzTXMDqNTu7G8RRdP
         ToOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOi7GKqHaDWol06SSBtuvX5Y43VVRx8lcPjq7nvswtKc7StEArNCx8dVgMRfZ987+RsR337Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1XAD7V3GTTcbEHuodZKfi9HoaX4laH1ofsfATSw9y0Jhi9ZWw
	1vn78obkAB5tZoqmAyN5yrPdjdT34V9mhq0jS3kekfcjcL7DPtrH
X-Gm-Gg: ASbGncssea6G4ulH1ajGgttUdFJAFMV3ej0TGcbuiG04KXvkCzewBXX4UarCqzsmzff
	amcdPvLhsi9VD+33pd5NGjJ1eO/dx3GJwbKmMd4sZ8r4U55WRIRYhEhryopF3oxvl9dWSvwHMq3
	f9Gb5KjUPRIxozibbplHaqbbrqRE0D0WBcaUvOFGa19w7wNPsDG4yAfFxGniw62mUcM+p6/BEoY
	FCC49p1C+mMhO8FP6cdJgoQ+pPmmiEIeKetXnG8HMICAxC8b8BSMeACqTl5P3DgaZmHqHxaosES
	rf0c5cyS/sELd2KTwCxtD+6J9Ugc
X-Google-Smtp-Source: AGHT+IHUoKF5CCleTB2jU9vLsvOAEPHxoqMfeJizDfgZZl9x+zXjW5TDWSL8oHA1WM8ocRBnyA/UtQ==
X-Received: by 2002:a05:6402:2347:b0:5d2:729f:995f with SMTP id 4fb4d7f45d1cf-5d972e6f957mr8778390a12.29.1736506435017;
        Fri, 10 Jan 2025 02:53:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:e213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d98fe8f68csm1544698a12.0.2025.01.10.02.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:53:54 -0800 (PST)
Message-ID: <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
Date: Fri, 10 Jan 2025 10:53:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_025357_482660_E962FBE6 
X-CRM114-Status: GOOD (  23.72  )
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



On 10/01/2025 07:21, Ard Biesheuvel wrote:
> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>> constant, but it changes during late boot.
>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>> kexec boot.
>>>>
>>>> This is best explained with an exampled. At cold boot, for a test
>>>> machine:
>>>> efi.memmap.nr_map=91,
>>>> memory_attributes_table->num_entries=48,
>>>> desc_size = 48
>>>> Hence, the check introduced in [1] where 3x the size of the
>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>> table is valid.
>>>>
>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>> efi.memmap.nr_map:
>>>> - efi_map_regions which reduces the `count` of map entries
>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>   in efi.memmap by __efi_memmap_init.
>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>> paramaters that are compared are:
>>>> efi.memmap.nr_map=9,
>>>> memory_attributes_table->num_entries=48,
>>>> desc_size = 48
>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>
>>>> A more appropriate check is to see if the description size reported by
>>>> efi and memory attributes table is the same.
>>>>
>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>
>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>
>>>
>>> The more I think about this, the more I feel that kexec on x86 should
>>> simply discard this table, and run with the firmware code RWX (which
>>> is not the end of the world).
>>
>>
>> By discard this table, do you mean kexec not use e820_table_firmware?
> 
> No, I mean kexec ignores the memory attributes table.
> 
>> Also a very basic question, what do you mean by run with the firmware RWX?
>>
> 
> The memory attributes table is an overlay for the EFI memory map that
> describes which runtime code regions may be mapped with restricted
> permissions. Without this table, everything will be mapped writable as
> well as executable, but only in the EFI page tables, which are only
> active when an EFI call is in progress.
> 

Thanks for explaining!

So basically get rid of memattr.c :)

Do you mean get rid of it only for kexec, or not do it for any
boot (including cold boot)?
I do like this idea! I couldn't find this in the git history,
but do you know if this was added in the linux kernel just
because EFI spec added support for it, or if there was a
specific security problem?

Thanks!


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4332CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4N4VN4U8dWKYBPdGLpmGB0dN8xMC6v/gON67oih3Zak=; b=UKEhziGLZB4GoxjJozdfAqLP+R
	tGuNs0ZnIs2VcJlY/adLTNj++zn2HF/JMAvpMIeq2DbQzM3fMxJTBE8ZEzGeDT4mCbnQu/sCmVYie
	Pb/crbN86L4nktxf905Ks8I6RCN52nRq8vHzvNRh8lxDJqKlDEelIor8m0lL4r6VkJdwIybD8K5yT
	0TZlg/4dAvbYS5O0M6pbPLG8LnKRc6NsAhwCO+NgZeBMxFkHVmivE0EY8DWanfyl5v+KOxEc44x6K
	87C1uhhgZbnGXxs1dpHJ0OAs+51hEflvh8Z9ewlAfoFvXoVbzdnTK2t5cIvQ2cp7RumaA5h0D0aUB
	WBYF6k/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYy5J-0000000DWki-39iA;
	Mon, 15 Jun 2026 03:34:01 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYy5G-0000000DWjN-2PUQ
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 03:34:00 +0000
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-c85b2139015so750304a12.2
        for <kexec@lists.infradead.org>; Sun, 14 Jun 2026 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781494437; x=1782099237; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N4VN4U8dWKYBPdGLpmGB0dN8xMC6v/gON67oih3Zak=;
        b=cPTzYIHdKjqkZupaBHV1pLHoJKoGfWGZ//Js7rf7j0h3gwPUJxTgFGGVLruyHWbSEa
         GD02hgNomiq/99S1jftY0PRDG1yMoPjvX0oHA+0WSnvxQIvxGLkSXtTXCoIVcE/VTBsW
         OpA5ytTySBG9pakfLL4E7yf3FBVJzk8GYvZp/dCap9twnSD+Hai637X7aP0uzm29cYWp
         OROavm2CpoOyAHsSK1S4Bk4zuXLs33DAPCYtup1dciX86cXV97ogDOUzWciFoLAqB9Fk
         z/gHTou0vodja2hAtBNCQyQrQT1/o5QeZWlwPunj6ZITrbO5B465jGXHOUuPf3ll+s57
         RQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781494437; x=1782099237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N4VN4U8dWKYBPdGLpmGB0dN8xMC6v/gON67oih3Zak=;
        b=F+/NDnkG5tC1bsh4TIaX9aJUpVRJU5JNu0yzSk6ZpptQFSGiiOWY1gMkh+13j9o+HF
         0ANgChta5c57Hl54DQDxh6LR3xNrx7c9I6/693l0Q8nMxxvClgnKXfJiXG/92PevL+vh
         X0IMCCh7WqWtOXcjUZmBSYYjTmbIbmm7dhNoLRezfG7Zhc0JQvew8n6CagSayyq8Cj+m
         WBfoOpyrjE/Ui7DINNbXQdGNueGEnEC7jT7+L3S+U6rdx9Ce4IhMxMqzTDB2vPTqwipI
         9w9EQc00aqP2y7/VvLPKs/Ocx9UHcYkOhg/8HVWEwoUqBjYKBZXHUSfxt1axw5uSoZ8R
         FnOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/B9OwhtofTmPHS3nLSTGQbD4ewaCNLrvYNNmsilsXKFk/N1GcRmuMGQO2Cge7uWqYpgfj/fg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzIp7ux2LLS4v6yvae+7ZMLWLfBGvRfnlv74OUts/8WU2069aZK
	C8Zv9dQvOpm5aMk+90iUIZIpSRedmTVChTjjzCiizFgC5Dw+GxvhJgLd
X-Gm-Gg: Acq92OF1uYPLLFWBwPGnEwvro/O7/l4ga1sgvbAlJt3Y1wD0/SMDyZvAoed3vtcIHWO
	nLMdBY7cvJnf5F7YiLtcMc2r3tAoUNRad4jexYyQY4J2DxAlFjriSstKj1shQVpr5yv3fbIS1Jg
	Z6TdwB9havhGZTi59jTQ+2f+vwOmXkzHpQR55ln8qZLzd5TUXiA78Tn+ZUDO6fZ2Fc5TJx1zB8m
	M9FJy6zWLGoJJ5jQNMl9aMrT5aOpJ0CBjsyK9DpS5T67iIhlgfI7xTYfLZGuywGhldAbUWqsJAU
	POoEzIHJU8kRmYyk8mkxcZy8Yzittku/py1KFdiqiTt0R8ofvCbD6BYHDgqfYdRbwN/7emfLl4Z
	IPWCqFd5WMQqHw0DSAMkRsrhm7jxhiA/7cO2wF7P9K9x3nDt5r59QYn79FqT8OBaj1h0pk19yBk
	F+32fiZgV+3ZgRvADWe6Nb0HLMSCBDlOoUQxkSZ788Eg==
X-Received: by 2002:a05:6a21:6813:b0:3a2:d629:16a2 with SMTP id adf61e73a8af0-3b783b757e9mr14493609637.10.1781494436758;
        Sun, 14 Jun 2026 20:33:56 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b035ce6sm8650381b3a.49.2026.06.14.20.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 20:33:56 -0700 (PDT)
Message-ID: <894d7c33-8e14-4ba5-b774-14062ece39f2@gmail.com>
Date: Mon, 15 Jun 2026 11:33:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] of: reserved_mem: split
 alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, catalin.marinas@arm.com,
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com,
 quic_obabatun@quicinc.com
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-6-chenwandun1@gmail.com>
 <20260612144122.GA974326-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260612144122.GA974326-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_203358_625922_98456585 
X-CRM114-Status: GOOD (  21.44  )
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



On 6/12/26 22:41, Rob Herring wrote:
> On Wed, May 27, 2026 at 11:29:11AM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> Prepare for storing /memreserve/ entries in the reserved_mem array.
>> alloc_reserved_mem_array is skipped if the device tree lacks a
>> /reserved-memory node, pointer 'reserved_mem' continues to reference
>> the reserved_mem_array which lives in __initdata, storing
>> /memreserve/ entries into reserved_mem_array would result in metadata
>> loss, and an out-of-bounds memory access will occur if the device
>> tree contains more than MAX_RESERVED_REGIONS /memreserve/ entries.
>>
>> So split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late(),
>> and call alloc_reserved_mem_array() whether or not there is a
>> /reserved-memory node.
>>
>> No functional change.
>> The actual /memreserve/ population is added in a follow-up patch.
>>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> ---
>>  drivers/of/fdt.c             | 7 +++++--
>>  drivers/of/of_private.h      | 1 +
>>  drivers/of/of_reserved_mem.c | 6 +-----
>>  3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 82f7327c59ea..83a2a474831e 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1284,8 +1284,11 @@ void __init unflatten_device_tree(void)
>>  {
>>  	void *fdt = initial_boot_params;
>>  
>> -	/* Save the statically-placed regions in the reserved_mem array */
>> -	fdt_scan_reserved_mem_late();
>> +	/* Attempt dynamic allocation of a new reserved_mem array */
>> +	if (fdt && alloc_reserved_mem_array()) {
>> +		/* Save the statically-placed regions in the reserved_mem array */
>> +		fdt_scan_reserved_mem_late();
> 
> Can we make this just:
> 
> alloc_reserved_mem_array();
> fdt_scan_reserved_mem_late();
> 
> We already check !fdt in fdt_scan_reserved_mem_late().

Thanks for you review, Rob.

The reason I kept the fdt check is that total_reserved_mem_cnt is wrong
when fdt is NULL, early_init_fdt_scan_reserved_mem() returns early in
that case, so fdt_scan_reserved_mem() never runs, and
total_reserved_mem_cnt stays at MAX_RESERVED_REGIONS. Calling
alloc_reserved_mem_array() unconditionally would allocate unnecessarily
memory.

A better fix might be to make total_reserved_mem_cnt always correct, add
a !fdt check at the top of fdt_scan_reserved_mem() that sets
total_reserved_mem_cnt to 0, and let early_init_fdt_scan_reserved_mem()
call it even when initial_boot_params is NULL. Then
alloc_reserved_mem_array() could naturally skip allcation when that
count is 0, and we can drop the outer fdt guard.


There is still separate UAF issue (fixed in patch3) if we don't check
the return value of alloc_reserved_mem_array().


With the fdt_scan_reserved_mem() fix for total_reserved_mem_cnt, the
call site in unflatten_device_tree() becomes:

if (alloc_reserved_mem_array()) {
        fdt_scan_reserved_mem_late();
}

How does that sound?


Best regards,
Wandun

> 
> Rob



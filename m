Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D64CA1013
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+i9iHMrfZSNqoivyx67SGEamkAUPDlF91tqODtRDok=; b=rVSdo0DbvElkBSEQHgf82rvSFp
	ERGbtj/lhLNf4zrAUGxu8qXXaHcvYwXJ5jKBE1uic7/H9G7pS7JH/X/VN3tnGfuxktloPhV/PSGOG
	Prw0eqViXhA/Wx97gj53iWW50Fg6iUK9Wi2IVYhep1OMNynC0lpDoekS+WnVIlQX9csiqwGMfF5lh
	ivxafXcbyrePMZT7ZB0QJMo0gqnVBSGTJ82s0IL9/nPfzevAndMQivgR6NHKkoSpq7ujvpX2kmQ/a
	Bjz8RA/Z093+nxTG95TCHp5GG0wTFIXGzjDbnnnphxHBY2nGCrE4+TiorzP08EXvAjJLEjoCdzrBS
	8cEyDzDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzJs2-00000000x59-1gZB;
	Thu, 18 Sep 2025 19:00:42 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzJrz-00000000x3q-2dv7
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 19:00:40 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-45ddfe0b66dso2492715e9.3
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758222038; x=1758826838; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+i9iHMrfZSNqoivyx67SGEamkAUPDlF91tqODtRDok=;
        b=TFL54bxsD/ZCY8qTyGkK+SJr4wnszjHSDJcyIt7ssqdkkHfvu0e8swNc/iyWoshqu1
         84vgO2CMjEULVRny3CV+AAAYOu/hZmMMiEPuvI7HLuFrHmo6hnCMJ3R/HZLT6Dl4Yejg
         nRpQC1TwmzZi+wOWgH/PQPjgkfoID8zT/3R9AgFv7qj7+UY3kb19AXrwXQXtcPxf/1qB
         LXRHvQCEfSnXwpHbhzn9RdMn6tyLNN9UL3UXck+BurPkXRcySS+VRGXzgylSgjcKiMUl
         +Bu2EMs6PkCHPo/bSJieTs7C2rzXK++PDCv3ZU1eX0rZdZNidN21lCB+jPzIOCFaEPga
         jvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758222038; x=1758826838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+i9iHMrfZSNqoivyx67SGEamkAUPDlF91tqODtRDok=;
        b=D+zxTwyYOaDvczcLDNWJQXDyIfJgAaiOHkQCahGyAAYWge9olZsMpo+h0kbHHuNWFf
         xEWXpAhkcsDKuuQy3J4OaKBY8dTTrBBBnXLNXUAxnGv0fbMSI+kA3GTYUNOwqcXn2wzD
         eziSdBkE9TXcBB9gGPB6+F5wJTm/ZJ5v5OiP17AinTKfGIqpRvg2H2JmpL2B4gqH2XO9
         Yqie/zw1H4NFzVpJC+dAAwp28pLAOD0KiL9a9lMje9D+2ZbuOq6HI3om2YA+tZQS8oWd
         z4tpbvXQWcM8Q8JU7Vs9SoTjX2ZGcjhfdtuNsmMXBeyf1dFDMLRojsxA4f8Oqix8DgeQ
         yKDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Bi/B/2MuN7kVBUqcCyfD1anu9z3OJhNTgtmR1JAOL4Dwt6ErF2ZPB2WOM75A8Nkv8O7AuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxH3veA8l5glhthoyCNTx58dsmnlXbqN1EaTpdRDvJ8POp1P8Kp
	WknJYjyuCdh1uiow2/jbfF1WSLypltp43bQgUAiNCKvPztdlo0jCvmCiU0Eei7cNrhA=
X-Gm-Gg: ASbGncuZa0t93nkLjBAko8qMTruHGBgPvKwbx3nNmJZzn1TxsLxME5aEkHmqRQpaToH
	MKhaURnmUq1MfMm3kzIuFdWKxiO+bsCCrZrGOnepZJpPbmthRMKjRmkgYlbRQ3h+2oLCnMZFD9u
	7oafG/DD59Y+GrXG+xj5UvIubIbFZ8g9P7jVxGy1I/hY49Byvun9nUQJq/Rjqz9clUl+Ijtnk+M
	GnBSLHZkXXdOzZskbPZ/EiAb1dbcYGiM5YX2m345Hw3LPsmfEXXFrvP0RBJdcI1nVSM4EKLXjQT
	A9iN6DTQ5GzbAeMCQ6IaxjtIu9dCD4LmJAueWHeu/IghCbulXNkJs6D5p+WsoWxtnELLSeiaAg9
	KcfvfUQrT8p5e7Gwz6T7PZ6Zg+hBghzErjOIMUQxKFIgP4rAKPkWKAC9D50mOP6tP6LnomfI2Dt
	2aexo+6ZDa
X-Google-Smtp-Source: AGHT+IEufi4ClRY4a9e7yea8huaXiy4yZ519x4gYdFB4Nd6ggMP2w+e76/E+j0H8SZ+HE/JV9NrWKw==
X-Received: by 2002:a5d:5f95:0:b0:3e9:559c:13f6 with SMTP id ffacd0b85a97d-3ee81959333mr151172f8f.2.1758222037501;
        Thu, 18 Sep 2025 12:00:37 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-151-62.dynamic.sbb.rs. [94.189.151.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f5387sm4558160f8f.1.2025.09.18.12.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:00:37 -0700 (PDT)
Message-ID: <893401bc-4754-4c67-a82a-0c49c8e7f447@gmail.com>
Date: Thu, 18 Sep 2025 21:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] mm/memblock: Use KSTATE instead of kho to preserve
 preserved_mem_table
To: Jason Gunthorpe <jgg@nvidia.com>, Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Ashish.Kalra@amd.com, William Tu <witu@nvidia.com>,
 David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-7-arbn@yandex-team.com>
 <20250915114707.GB1024672@nvidia.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250915114707.GB1024672@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_120039_696218_EF3F4C97 
X-CRM114-Status: GOOD (  19.31  )
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



On 9/15/25 1:47 PM, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 10:14:41PM +0200, Andrey Ryabinin wrote:
>> +static int kstate_preserve_phys(struct kstate_stream *stream, void *obj,
>> +				const struct kstate_field *field)
>> +{
>> +	struct reserve_mem_table *map = obj;
>> +
>> +	return kho_preserve_phys(map->start, map->size);
>> +}
>> +
>> +struct kstate_description kstate_reserve_mem = {
>> +	.name = "reserved_mem",
>> +	.id = KSTATE_RESERVED_MEM_ID,
>> +	.fields = (const struct kstate_field[]) {
>> +		KSTATE_BASE_TYPE(name, struct reserve_mem_table,
>> +				char[RESERVE_MEM_NAME_SIZE]),
>> +		KSTATE_BASE_TYPE(start, struct reserve_mem_table, phys_addr_t),
>> +		KSTATE_BASE_TYPE(size, struct reserve_mem_table, phys_addr_t),
>> +		{
>> +			.name = "phys_range",
>> +			.flags = KS_CUSTOM,
>> +			.save = kstate_preserve_phys,
>> +		},
>> +		KSTATE_END_OF_LIST(),
>> +	},
>> +};
>>  
>>  static int __init reserve_mem_init(void)
>>  {
>>  	int err;
>> +	int i;
>>  
>>  	if (!kho_is_enabled() || !reserved_mem_count)
>>  		return 0;
>>  
>> +	for (i = 0; i < reserved_mem_count; i++) {
>> +		struct reserve_mem_table *map = &reserved_mem_table[i];
>>  
>> +		err = kstate_register(&kstate_reserve_mem,
>> +				map, crc32(~0, map->name, RESERVE_MEM_NAME_SIZE));
>> +		if (err)
>> +			goto out;
>>  	}
> 
> As I've said to the other proposals, this doesn't seem to be bringing
> that much value compared to just using a normal struct:

We expect to have many such ABI maps across the kernel.
These maps will share common elements - simple types, folios, and preserved
regions.

With the approach you're suggesting, we'd need to re-implement the same
preserve/unpreserve/recover logic, error handling, and unwind code for
every individual ABI map. That quickly becomes repetitive and error-prone.

By contrast, KSTATE centralizes this logic. It avoids duplicating code
and lets us express the preservation details declaratively instead
of re-implementing them per struct.


> 	for (i = 0; i < reserved_mem_count; i++) {
> 		struct reserve_mem_table *map = &reserved_mem_table[i];
> 		struct khoser_reserve_mem_table abi_map = {.name = map->name. .start = map->start, .size = map->size};
> 
> 		err = kho_preserve_phys(map->start, map->size);
> 		if (err)
> 		    return err; // Should unwind the other preservations!
> 		
> 		luo_preserve_key(luo_obj, map->name, &abi_map, sizeof(abi_map), VERSION_0);


On the versioning side:
With this approach, introducing a new ABI version (say, abi_map_v1)
would require us to maintain restore logic for each supported version,
and carefully handle upgrades between them.

With KSTATE, versioning is built in. For example, adding a new field can
simply be expressed as:
 	KSTATE_BASE_TYPE_V(new_field, struct reserve_mem_table, int, 1);
This way, the framework handles compatibility, and we don’t need to manually
write version-specific restore paths for each ABI map.



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CD7CA0ECA
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R19bM/dvmRkwCYHJvva9FHSIR7N3EoqeU0N1iQKZ3Fk=; b=Oz2hgUIYxSrHIc
	lFy6ogA4VvRhK1LVMHsAmR4d1gW9TWatqksn/cheYGljNhumWwWp5/Py7bWw9OUDJasaiGpev1PQT
	pU2UNCX7+G/C/+AJiC2nQAYQUUitrACkmO1ZVSty4qKDBRKcOCBVASNlG2qSVl6T9mzk8izY83mId
	g2tEdNVKOb6u8YJtH4017ttqFMHR04fwpcbCYy+3KZqPHmNE40xW4LYZNbDLuXpzsfuK7mgZvWosF
	8Op590Y/ucUNtmoubiRR6Grm6V2C5ud3efxx6XXykw6qaJuHl7HQsG5YZVv887S0xEk2D5EQUbCKV
	MyPpysI0/o50GqH4nJ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxfR-002NGB-2T;
	Tue, 12 Sep 2023 07:18:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxfP-002NFH-2H
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 07:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694503114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OodWnETEUgz5EFst9JGpxDf54xHXqhw04bLaPZH7zA=;
	b=CfJufZ0+jnXUOpY16coEfCS98QFO6LyZiJN9ZQMEe4HxCEEczHeF8QRji3hYNbeDMVubLi
	gHqDdWxKeZudQiHsUd87wPqpjxK1HDtphR7kFywyJrwBO45UzoqF2qdoKhL9doH/MrBHQR
	2veEcmGi/Pw8q2Awo+KXC6QZ231lHVg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-udRNoAnKMNiyaJwdKoqkUw-1; Tue, 12 Sep 2023 03:18:33 -0400
X-MC-Unique: udRNoAnKMNiyaJwdKoqkUw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso42409865e9.2
        for <kexec@lists.infradead.org>; Tue, 12 Sep 2023 00:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503112; x=1695107912;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OodWnETEUgz5EFst9JGpxDf54xHXqhw04bLaPZH7zA=;
        b=p7Nu2dupa7l1GeJ+fjNRNl1J5EFRkoxsciP0Sg9xoRUp2nKt6sbFsRty1U8YKtk83Y
         jBm9+rIHv8+EJn1IBTCDcWvnF32orauQpSGA/R8m8K5sbiuQdIpUjfgkcdw2WelacEr5
         UMPZyhexa+LthOIFU4mIamFLeNlVCMqEkck78fFJll1/3l+dg0DahIJ4Ox8EOodDZg6d
         LCAvc9MFJQTtwdxQdBYxBwWq8LzOp/eOe7LFgG3wY74ybYWV5OAzBIC4A9Kr/pYB+9Db
         7q3AzZHmrBupAUmWATx7hDvMp0PPqSrdEnDV7FYfv62kg7HRHfci6xdPRSIp1A98JXqR
         KEOw==
X-Gm-Message-State: AOJu0YwuM7ALLg9HAhSNBI3/EIH7r5sXQkwpwDDKAh3psOOs9BTRbA8F
	pp775ppIWJvbl5NNa1dWcGWHSwcP7nSieHmT5EwNIvj5qIN9ZdJyV8IYsDEUaSOYzcmNzUTjwQS
	Ok2wvJwEHzHfMDV92Bp0Y
X-Received: by 2002:a7b:c853:0:b0:401:db82:3edf with SMTP id c19-20020a7bc853000000b00401db823edfmr9908949wml.39.1694503112136;
        Tue, 12 Sep 2023 00:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQr59YxQoahIdt2pGpOn3n/3cyfcIn7qrajZoDiICpNrmoOnS/ynh5Tia67CgdCYHJ/KD0yA==
X-Received: by 2002:a7b:c853:0:b0:401:db82:3edf with SMTP id c19-20020a7bc853000000b00401db823edfmr9908928wml.39.1694503111718;
        Tue, 12 Sep 2023 00:18:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fed630f560sm12028942wmj.36.2023.09.12.00.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:18:31 -0700 (PDT)
Message-ID: <7f4881dc-885a-a8f5-47a5-0dd23886a416@redhat.com>
Date: Tue, 12 Sep 2023 09:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
To: Adrian Hunter <adrian.hunter@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911112114.91323-2-adrian.hunter@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_001835_813688_5B8966D3 
X-CRM114-Status: GOOD (  15.49  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11.09.23 13:21, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
> need to accept memory before it can be used.
> 
> Do not let /proc/vmcore try to access unaccepted memory because it can
> cause the guest to fail.
> 
> For /proc/vmcore, which is read-only, this means a read or mmap of
> unaccepted memory will return zeros.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

[...]

> +static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
> +{
> +	phys_addr_t paddr = pfn << PAGE_SHIFT;
> +
> +	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
> +}
> +
>   #endif /* _LINUX_MM_H */

As stated, if the relevant table is not already properly populated with 
information about unaccepted memory by the first kernel, this probably 
logically belongs into Kirills series.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAFBC27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Z6NsSZTkB8+aa3byigi8hKTHcpiUDoFhCwvSyQEOvA=; b=xWy9uFWIIb3wBwRnEouDl79nQO
	FhYONE5MxfmpbE0be+zigVPte74YXl1HuYGpqWPrPgyrH4SvRdVt8VQrsawvRerIh5B0X2uAyhW6p
	SR+43SzIHQYr0HKTIps01t/QwHbhwAqzRYTIDqfdkn7vdpT7nT8ZGzuYAF2KtUAHO2/9QFv/V7qII
	0LfAWMz+8XLF2ZJReA3UNH75wwFAQgqJVPUdmTT06jZxm1Vl/z3MpNjsbqWy+o3QrsZbR1Mhb6IZe
	F21UsHmDqBC3EK4hmbwDzdXY6xXicb1drNbFQkuxOZhH3oAd4d8Svqd+MHvmDwT5Uw4ZWqLGMRmfi
	f63LLF7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhv-0000000DvVE-0YWC;
	Fri, 07 Jun 2024 12:28:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhs-0000000DvSl-10Xg
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=He3juNVz7+g3hFu6GqowX6vOVAQdnb+Nrnrk3E6C7kg=;
	b=AO+G4K1TKz2gK0R0pqtOFBQX6onHl98wIbPyiRfhHVxxkyFNhUIYy3IoUNP9/mGxz82KKj
	WSmR/Xs2s7evk/LbG+hk2n+E5u9XPiXkGtFhSQil/6GsE74C/WbqLq+0sKhCLORHuotMZx
	h01a/uArvEpTyBGNoLBYyM/Wh0OWQzI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ufgq7E4bM965eexWWnl1Og-1; Fri, 07 Jun 2024 08:28:29 -0400
X-MC-Unique: ufgq7E4bM965eexWWnl1Og-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-68197de746fso1984743a12.2
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763308; x=1718368108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He3juNVz7+g3hFu6GqowX6vOVAQdnb+Nrnrk3E6C7kg=;
        b=di3sXtj7NoRhbYmZFqfVDi5ylIvQLc+w61Qce9r1DEC7O4FI1azOt0mGoTbmyA4PVZ
         rGu//pGEFjVLjpz+koK7E04fAXMcH0/JhyOBh2rFaQ1/OVttnwSMfDDNWc7yHx3Pz2Wd
         4xsPhpsVpUaOyFV4s1j+UXvyHNUwrpz2CM2Zesfe9B+0HXg0n/ekTJBlDDGTu/UciOUR
         GtlRuDTw4Jkr75BG/3fJxQYGs83todWnKM6Lw1nAJfUZJU9HHRfgu70h0D0ts2d/qG9z
         tpVVVai3oojGODfujYDpFR365lW74ABZELpEkot0nnzVS1ybX64hOxG0BYFC325vijw8
         nGtQ==
X-Gm-Message-State: AOJu0YxEb/2vade6XCnInko+Cx82sJBk2yTKE/QqpNMYBxbiKlX8iHn/
	dlaC8xhillsgHwKggqd55V/Andvc7TDdFzTa/CclzqoKYlon22Gcar42PuE7Um3XAAKjBHPNyh5
	2kmLiA7wFlG5/nqxvcgFgI2f2kmOfah0HadgjYaVrrykAuPU/n/Ubd7Jg2w==
X-Received: by 2002:a05:6a20:5509:b0:1b2:b688:8823 with SMTP id adf61e73a8af0-1b2f9ccbbf4mr2067792637.54.1717763307804;
        Fri, 07 Jun 2024 05:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+eTCa/N3Ta5x54zKKmmxUaASggmCvFDY6W9QdUswmmuERq2DgCNCpJ0Fqi3DwJXnyUNChUg==
X-Received: by 2002:a05:6a20:5509:b0:1b2:b688:8823 with SMTP id adf61e73a8af0-1b2f9ccbbf4mr2067761637.54.1717763307117;
        Fri, 07 Jun 2024 05:28:27 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd530d25sm2478986b3a.213.2024.06.07.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:26 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:15 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052832_403986_8F6D9687 
X-CRM114-Status: GOOD (  18.72  )
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

On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>.....
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> new file mode 100644
>> index 000000000000..78809189084a
>> --- /dev/null
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
[...]
>> +
>> +static unsigned int key_count;
>> +static size_t keys_header_size;
>
>These two global variables seems not so necessary. Please see comment at
>below.

Thanks for the comment! But I think it's better to keep these two static
variables for reasons as will be explained later. 

>
>> +
>> +struct dm_crypt_key {
>> +	unsigned int key_size;
>> +	char key_desc[KEY_DESC_LEN];
>> +	u8 data[KEY_SIZE_MAX];
>> +};
>> +
>> +static struct keys_header {
>> +	unsigned int key_count;
>                     ~~~~~~~~
>                     This is the max number a system have from init();
>You can add one field member to record how many key slots have been
>used.
>> +	struct dm_crypt_key keys[] __counted_by(key_count);
>> +} *keys_header;
>
>Maybe we can rearrange the keys_header like below, the name may not be
>very appropriate though.
>
>static struct keys_header {
>	unsigned int max_key_slots;
>	unsigned int used_key_slots;
>	struct dm_crypt_key keys[] __counted_by(key_count);
>} *keys_header;

Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
maximum number of dm crypt keys 2) we only need to let the kdump kernel
now how many keys are saved, so I simply use total_keys instead of
key_count in struct keys_header in v5,

static struct keys_header {
	unsigned int total_keys;
	struct dm_crypt_key keys[] __counted_by(total_keys);
} *keys_header;

Hopefully this renaming will improve code readability.

>
>>
>
>> +
>> +static size_t get_keys_header_size(struct keys_header *keys_header,
>> +				   size_t key_count)
>> +{
>> +	return struct_size(keys_header, keys, key_count);
>> +}
>
>I personally don't think get_keys_header_size is so necessary. If we
>have to keep it, may be we can remove the global variable
>keys_header_size, we can call get_keys_header_size() and use local
>variable to record the value instead.

Thanks for the suggestion! But the kdump kernel also need to call
get_keys_header_size in later patches. 

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

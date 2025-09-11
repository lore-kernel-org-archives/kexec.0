Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76503CAC587
	for <kexec@archiver.kernel.org>; Thu, 11 Sep 2025 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=69yPHnIsLNbjSOnGkb91deN9ujmIDIbQEy9l+ZyKWrc=; b=iGDf9osAsVlCe6V3kGdWSlPQk+
	oB8hRUGoilr51ar797LJakATJTVCXEn8JxZsu+BiVms1Jj4udaIaOT31+BmVjj9AOGh53m9K91Fm3
	eXLPD5/1Q/BZ+Dk6zSs7a+TbM7M5CEDOZZTGFhfuwohaWT3MERIyi2mlIwKBZn09yfbyANL8n4sjf
	adqU4p55AVXXz6grQExuNSPeO/BtN+ryNoIpk4l+h27nTmrDWHNJqXVQIO+dRTEAXb+G3Y+TvDzxk
	+elW+Eyuh/508SHtKkqBnQ2OUwQH0hOM5M3XgTCHqAFUcQJ8MZEQNJzxIDyWUaWC3nYff69U0jxZZ
	8yuJnMPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkfD-00000004LVQ-1ZpM;
	Thu, 11 Sep 2025 17:00:51 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkfA-00000004LTh-0qQx
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 17:00:49 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-57000066899so45544e87.2
        for <kexec@lists.infradead.org>; Thu, 11 Sep 2025 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757610046; x=1758214846; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69yPHnIsLNbjSOnGkb91deN9ujmIDIbQEy9l+ZyKWrc=;
        b=m3fS+WlsAO8jTLlVcd8xft1z3lcKMHiLLy0p0v/raD4Xv7tvTnR6FWWRFG3cnTBs26
         YI6L78Yqy6YyXtLYkjgzO565RR1KjWd4v+ng5eLrxACNV/8kwFyDQGH+J4qrFIn3L0rf
         3JnzoOtn5H4+j7MlF1HB0ABYJskwwA4qckGxMxAdNozpYkPaiTk5t3fCGWYDFF3/U/pZ
         0Li5O4kK6yQRtwNvcc+ajF99kysuROZ4wlkZ0LxjuIz0DXtd6LPO73Ov80e1645c8++U
         OK2f58I1//4P6lABSKzmzUlFBvCEggBMAXV7Vh8ItDVJxS1y1oFfQdKN7f6KjmpLSzOB
         SUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610046; x=1758214846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69yPHnIsLNbjSOnGkb91deN9ujmIDIbQEy9l+ZyKWrc=;
        b=QyhuJkL3/VLKojb5NqAyQfe6u+ncCh9tlV5Iu0TFEjLsjOV8upmvpFriGvNQTYx3F/
         pePY+2H/IA5XiNYtoaE7MZdxpmcyar7hnuomXwAm2wQHeXpZswcQi5LqCsvuvD5Ody1i
         OHNtB7A3x33xgtA1s90oUC6ddW6MMINgG3UH/dz7Lq2ztN/p6tSpXP+QrzFhUAPtGoSR
         1UUxb/ssAMZeQ+4A6gJBD3SlG0de3Htzh+uReBKyAjT3WoqQ0be3f/eNXNwc/WKXeDWn
         Ft6/8EgQjvl+NAVb0GvLcNLLdmbXrTj+AVxVzyH+rE7Mgo5/QNM742aFhvzoUjaohupf
         beLg==
X-Forwarded-Encrypted: i=1; AJvYcCVluYE7ewx5QW6zsuIqWhogSlH0X0Y7qlL9wSHldMWgqWo7mMKy+gU1IqJxKqlO14VJ66+xsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxpDUMPGLFamt4C/W88eMEERzjl/xlZFWIcgaLErFMzZpOw8VBr
	xcqqDoZCGCaaBELWGmaEYnLhaCQ2Wx1cAMfZQayz1nTK2iJY2XKO20m0
X-Gm-Gg: ASbGncu/nnVCC2tHYKEy1kEu4ki6ZYB3tEbhaFkrv21XhSLCWfYSUstOgks4+UKhlHo
	TmEiFeXLON1unLXcwner9w0rgM3r5yZaJ4HAfzOXtsDKp7GNS4I94XNxeOpXP4puXBSpbc0Ic8a
	hAaHfj651up4FcKDeqabpnlmRbmJ5BIrIqy/ryZSR/dZI0EjU5Vj9EP2vfuP6r38xrzuyFgoBxe
	M+QtJX9qGYJAsr/ZRcA3i7XKTbgarqZrZGU075S8IyIv36tt9Yw7slsA/oQYvjqU2CSonn/t1H0
	NhLBW1txrrvwhxDMdqVvGGKouYLUlgDd1LTMI9IaummcDb+TnVrWTNLiD4LCOIy4K453Q6Zy10H
	7i2ndZTazbS2AlkZClRmsTkJSc8pxDy1fLZz2fBQ=
X-Google-Smtp-Source: AGHT+IHnjKPKaFzoMDps2A1lwwHuk+aMxy5X6+2P1DS5X0ZAITIfcYgwM13XJrpIiuwwI6P6z7dSYA==
X-Received: by 2002:a05:6512:3da1:b0:553:252f:adf4 with SMTP id 2adb3069b0e04-57051f3c81cmr19486e87.10.1757610045703;
        Thu, 11 Sep 2025 10:00:45 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm523403e87.103.2025.09.11.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 10:00:45 -0700 (PDT)
Message-ID: <9f548efd-babf-45f2-99bb-e013c810ef72@gmail.com>
Date: Thu, 11 Sep 2025 19:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] kstate, test: add test module for testing kstate
 subsystem.
To: Randy Dunlap <rdunlap@infradead.org>,
 Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 James Gowans <jgowans@amazon.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Ashish.Kalra@amd.com, William Tu <witu@nvidia.com>,
 David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-6-arbn@yandex-team.com>
 <1c79b3c7-5847-4960-9454-0c70d02a6441@infradead.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <1c79b3c7-5847-4960-9454-0c70d02a6441@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_100048_264573_F864CFAB 
X-CRM114-Status: GOOD (  15.37  )
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



On 9/10/25 2:33 AM, Randy Dunlap wrote:
> 
> 
> On 9/9/25 1:14 PM, Andrey Ryabinin wrote:
>> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
>> index b6ea861006bf..af9a25bdcd6e 100644
>> --- a/kernel/liveupdate/Kconfig
>> +++ b/kernel/liveupdate/Kconfig
>> @@ -69,6 +69,14 @@ config KSTATE
>>  	  state, save it into the memory and restore the state after kexec
>>  	  in new kernel.
>>  
>> +config KSTATE_TEST
>> +	bool "KSTATE test code"
>> +	help
>> +	  Build a simple test/playground code that is useful for kstate
> 
> 	  Build simple
> 
>> +	  subsystem development. It contains some structure with different
> 
> 	                                          structures
> ?
> 
>> +	  kind of data which migrated across kexec to the new kernel
> 
> 	  kinds        which are migrated
> 
>> +	  using KSTATE.
>> +
> 

Thanks, Randy. I'll fix this up, and the documentation as well.


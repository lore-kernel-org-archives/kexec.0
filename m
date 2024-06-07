Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB1C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iw/YVDQi4jjWTmfwhWceJVgDPiccHy2t4aoSTHKEJzk=; b=YVoRtPB82zZyMRt67XHzVevfI0
	qrApc4N72dKXtjeUW1imhk/nnv1zDAoTQ79GhVX1COOTiNGCx6/8SN8CvJnGHQgbTzCrswPr8YsH8
	62Eb2wjf33jCkG/41+DExZeY2OCDeBBUG4AEt/8rLjFAz981fdOthjsNvMCuC3l9ageQIBDa120or
	eHfVd8uzgV6vcejYpuXHlbfODDJ/fucyUdoc3bWjW5lruEEGXYd3o1ltqMhsuQmFlIf3HXfnZBFQb
	bHUuO9tG9IOJmJVmdRyBh9uluT5s1OQPlf2V2GOKmz//+xT9phAfJ42jXez345CLLWiiOUl9nqN82
	XOBts0jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYi0-0000000DvXv-3ort;
	Fri, 07 Jun 2024 12:28:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhy-0000000DvWS-3ATy
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwPDz8occ/dQmTW/xROoDQYZ478DOM3gjpOPNBITyCU=;
	b=TP9qxzxdJjghiPPDda5tyIbQw3+07RnuBRTlXPXW++/9/AHrgaUHEK4rGEs+bsDlKzpRYe
	yhwkM3xmH15OlX9tRoTWLRzgnC3th0rBsWL4+5lo0SVkkVg4Ih/Vy+y3N1ujiTMkK9nxbD
	slrRNaYsjjhSiUsm4mY8umWhllpIzZI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-3QtYuuHCMDyKTgrE9YtJ3w-1; Fri, 07 Jun 2024 08:28:34 -0400
X-MC-Unique: 3QtYuuHCMDyKTgrE9YtJ3w-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70241b2ffd1so1285770b3a.2
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763313; x=1718368113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwPDz8occ/dQmTW/xROoDQYZ478DOM3gjpOPNBITyCU=;
        b=Yq6VomAczSEHMDXBgSJjVYoJLH3UJcCaJv2Kc7eR1crKjZBm/8xnNRwwkwZnob3F9H
         tSdxY8SOFUnOQEKjbjCrQXkdPr/iytT+t2VxDzfv2/z41cE+Owbo+YbFFhAQgYZoqw3v
         qN1jhyOETIbMcsaQF3MDSByqKx8Alp4VRhZkZ7ybiXKl4+eLUyAM2zDBz1EW4Yh7hYqc
         hRpUK8nrnhlxi+bCXXM3J1qgmoYAiWjzuVQzxiegiccDv8lN1/7vjj3q6ejcrKRoQSdW
         l6PLEVAR5mTnDAQQBXA3ptfGRKQLfm5jgZR9Q+QPpI1fkBV1henTX+1LSwl5VqoF9Fxb
         e1sQ==
X-Gm-Message-State: AOJu0YyefRykR3tJr8Iv76NYim34VnI7zWw4lXkoULpdcHegkzeC6dnJ
	0+xv0pCpDwBC55dbD5RtL/fTwBtzwdKmknX2AJ6q304PEspL4M45kmxFhk4hbxsiRpWcopw7bh4
	p9H2BNwdhboGqMH1S5vge0TGFre0Ix4Kq6kEDzOk+ST4ozy6gBJuDnNQBVQ==
X-Received: by 2002:a05:6a21:9991:b0:1b4:772d:288f with SMTP id adf61e73a8af0-1b4772d29f8mr495348637.11.1717763313199;
        Fri, 07 Jun 2024 05:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG150Tip3wkIFyTvRDBUO16odC1xEzwii3bObBikg46Rh/1H1mVAdbqe3agN71+jfxDsLeANw==
X-Received: by 2002:a05:6a21:9991:b0:1b4:772d:288f with SMTP id adf61e73a8af0-1b4772d29f8mr495313637.11.1717763312430;
        Fri, 07 Jun 2024 05:28:32 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806cfa57sm5344667a91.49.2024.06.07.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:32 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:21 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <qzyj55v7umimqgq265ya4jds4kvzabeq7wg3eah6ppc3a6eygh@4fid6x2vp35d>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-7-coxu@redhat.com>
 <ZmLZkvYRJvdRVqwr@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmLZkvYRJvdRVqwr@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052838_985820_CE65C623 
X-CRM114-Status: GOOD (  18.31  )
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

On Fri, Jun 07, 2024 at 05:57:38PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> 1st kernel will build up the kernel command parameter dmcryptkeys as
>> similar to elfcorehdr to pass the memory address of the stored info of
>> dm crypt key to kdump kernel.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/crash.c           | 15 ++++++++++++++-
>>  arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index f06501445cd9..74b3844ae53c 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>>  				 unsigned long long mend)
>>  {
>>  	unsigned long start, end;
>> +	int r;
>            ~?
>
>r is only to contain the returned value? Then you can call it ret as
>many do in kernel code.

Applied to v6, thanks for the suggestion!

>
>>
>>  	cmem->ranges[0].start = mstart;
>>  	cmem->ranges[0].end = mend;
>> @@ -274,7 +275,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>>  	/* Exclude elf header region */
>>  	start = image->elf_load_addr;
>>  	end = start + image->elf_headers_sz - 1;
>> -	return crash_exclude_mem_range(cmem, start, end);
>> +	r = crash_exclude_mem_range(cmem, start, end);
>> +
>> +	if (r)
>> +		return r;
>> +
>> +	/* Exclude dm crypt keys region */
>> +	if (image->dm_crypt_keys_addr) {
>> +		start = image->dm_crypt_keys_addr;
>> +		end = start + image->dm_crypt_keys_sz - 1;
>> +		return crash_exclude_mem_range(cmem, start, end);
>> +	}
>
>You need adjust the array length of cmem->ranges[], I believe you will
>cause the array overflow because the keys are randomly set and mostly
>will be in the middle of crashkernel region.

Yes, you are absolutely right. I've fixed in v6.


-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

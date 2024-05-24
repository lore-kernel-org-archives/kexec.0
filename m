Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A23C25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6xPZvLHPJi5ETVFM89i0yKV/IqyQ5B+IdpIFbaGsKE=; b=CbgVn86ErJdjJB8y4WMHKdLnjc
	bYClaWHY3T0qtMNKOL/ZTR665CHU8lWKRf0GWnbPy/Na+t+kHsBvmyfYj54s5WnUF2D9UWvka5bnC
	tTVV+E664U2xuh1VaxzxhlE5n7M7MUZ25NWzZQZcDRmyu/Orio6Jc0DSPzNLGN/1JghOf6fSm1tci
	LGXUkjWrJNS2lERAMVndKRzbmeboDPXOaOjTxvgYld7YEuFtOZiqwe4WVW1FlWjj9fPiZAMlr1k6i
	37XtjVNLi0LyfwOSusecI4mqFyA0WRp0LUiQ+9m7jEGIOmIz+GWsuL+Rx22X6EU5adnxGuK7pnfP3
	QAt4uGkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPch-00000008Itn-2V4w;
	Fri, 24 May 2024 07:45:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPcf-00000008It7-24VM
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 07:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3tXMXab6M77eKvUSzxZo4mXzYc0uhowQ0ZNcQeUMTs=;
	b=dWnMbQUO9MQttcEqR5GHyNScjwb6yw0JSA0A195VxupIQK7ZuQG6UdDjDM4nDmJuadh5s+
	FXF/7TtIzx1KkSg2Gt8GCRpTNGYDSCzCHIe3Au0dAffL5SC/2VItSrog4aI3yERL5bDD97
	jUkuMpEgQ3nyjLLYvuOqAhJ/isHR4WU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-AdaN9lrAOCG4k2_yY1SpcQ-1; Fri, 24 May 2024 03:45:48 -0400
X-MC-Unique: AdaN9lrAOCG4k2_yY1SpcQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f449ed1867so4833315ad.0
        for <kexec@lists.infradead.org>; Fri, 24 May 2024 00:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536747; x=1717141547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3tXMXab6M77eKvUSzxZo4mXzYc0uhowQ0ZNcQeUMTs=;
        b=dqZkTpQk/wsQHQhRTsiT2IXfdJLI9u0rlPMkuTeAGq3uwKIDtKb52NEl9+4ZSaCPgD
         4KIQJRZv4Ys9Rd7qXT2BSQFiDs5rQVacFLZ+V7FKvq9aqm/kdMK+0CHdjpjvyeghUwxS
         iFQFpTZsPoSrMPhfYmVTiNay1/z05miMJpPOVGUnbLSviYo0WWy1mlSv1BG6KEFBsfm3
         SifYTfOr5HtGFzZLuIg0Pl++eT+txs/IRIGK4OnnOMRNLKOgYSvHYbh5LeDhyNToD4uF
         n/VF64gXRZj+LR3xUN5g1/YvsLCLaue40wSzXALDhMOwHRlUTEuHV5ovB52Zd7wZTPXO
         pOdg==
X-Gm-Message-State: AOJu0YztgnFU0PCXyzpcOgLDC0PsX0fh4egVgL4yQFZNBG5xJsZrnUml
	StKM+htpia0A/nglRCSQC6MW0XhlAsQ+MQt6R9y3QMtdrBx6p+zs08vEo4EqVD9smLvALvclNSB
	U6XV1z6RmxX8Qvuf+uBp8ZIMJeKBSzxu0BvhTShwuRVWHNQYxm+C4+Foc7g==
X-Received: by 2002:a17:903:2445:b0:1eb:5222:7b8e with SMTP id d9443c01a7336-1f448160c7amr23116655ad.17.1716536746799;
        Fri, 24 May 2024 00:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1aJYXjax+8GTKPwvYRs1B8LMFH0sILZ/bVMDAGOOSLXHhLZ7EJHda1gAWcPVxmY0C6kEKMw==
X-Received: by 2002:a17:903:2445:b0:1eb:5222:7b8e with SMTP id d9443c01a7336-1f448160c7amr23116155ad.17.1716536745907;
        Fri, 24 May 2024 00:45:45 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c971012sm7604975ad.173.2024.05.24.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:45:45 -0700 (PDT)
Date: Fri, 24 May 2024 15:40:27 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <c5xg5akvf5ikphio4osdbg2giclzvxu5dbsivrvtht6rxbgs52@hriqkr6kdui5>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-5-coxu@redhat.com>
 <ZkwZfcfTOL1UGKJb@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZkwZfcfTOL1UGKJb@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_004553_632502_BB7456FE 
X-CRM114-Status: GOOD (  16.93  )
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

On Tue, May 21, 2024 at 11:48:49AM +0800, Baoquan He wrote:
>On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> When there is CPU/memory hot-plugging, the kdump kernel image and initrd
>> will be reloaded. The user space can write the "reuse" command to
>> /sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.
>>
>> Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
>> hotplug support")) and ppc (WIP) supports the new infrastructure
>> (commit 247262756121 ("crash: add generic infrastructure for crash
>> hotplug support")). If the new infrastructure get extended to all arches,
>> this patch can be dropped.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index b9997fb53351..6ac1fabdb6cb 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -10,12 +10,13 @@
>>  // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
>>  #define KEY_DESC_LEN 48
>>
>> -static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
>> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
>>  enum STATE_ENUM {
>>  	FRESH = 0,
>>  	INITIALIZED,
>>  	RECORDED,
>>  	LOADED,
>> +	REUSE,
>>  } state;
>>
>>  static unsigned int key_count;
>> @@ -90,12 +91,31 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
>>  	return 0;
>>  }
>>
>> +static void get_keys_from_kdump_reserved_memory(void)
>> +{
>> +	struct keys_header *keys_header_loaded;
>> +
>> +	arch_kexec_unprotect_crashkres();
>
>I don't see the corresponging arch_kexec_protect_crashkres() in the
>following flow. Aren't they a pair when used?

Thanks for raising the concern! The user space is supposed to load the
kdump kernel as next step. But for code readability and security, it's
better to add arch_kexec_protect_crashkres.


-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

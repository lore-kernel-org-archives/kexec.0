Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F66C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okn7LPAUzl4gzEG1l3pJdfuV8D0MuBi8Ri0Up66oncM=; b=uyZ6H8xFQv+xMe3uaGiECEzzc7
	GZkq19e1mq2n/zvu5rt9UK7MLh6uBf93TN3p6mrCCiL0tqOm3pwGx+PR/fMAlMwsHCPmX09oZ2rbj
	bvzL9lq5mMrvcv4DiU4zkL/OZql9/mbdJ9SuDdKS7Zo+zFDtrx1AajUtPeodzZd/HcxxpdByam88K
	hQdB3b+0s9suH7R4W9bHUkTMyjXMckSDyes/K7eWlMDiT/g7m29H1+BuD7l3Ly5G0zw9E4V9zlYnt
	++hpdFp3WX0OxAtqDtZSv7vmaKQ82/UQcTeMBQX+1L50FfeiQJkERZpmxFbAe+RLZ1mG8twFZxTPf
	vS7taqCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYi9-0000000Dve6-364W;
	Fri, 07 Jun 2024 12:28:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYi7-0000000Dvbf-0CHP
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/skENtQAWrkOdc+P7nTP93U1ahaXb/Psh6M3WjuH5Y=;
	b=ZeTaM/+pCyniCH8blduTiC5WjM75I0+i9VdH/TgvPHa34XcM3UR4GLhEW7baVJv7YRZTDY
	6ykt8V1vaNMT1AWfJPEOBQ6CmCquLBxEyJSP/qRzq3a/8WU9fiv1GfIc8+/BbfOQsiubad
	iwBFa05gGWrVL7p2D01JDHMubfXwn2U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-qnt82Wu2Og2GRha9yKkGzg-1; Fri, 07 Jun 2024 08:28:45 -0400
X-MC-Unique: qnt82Wu2Og2GRha9yKkGzg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f65539265dso20609875ad.2
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763324; x=1718368124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/skENtQAWrkOdc+P7nTP93U1ahaXb/Psh6M3WjuH5Y=;
        b=vgboAIFt8mjVWiGjca6YYTnF7uBPbuMgUJ4rB7GER77tjXl/402ooCv/T9FObuO2zr
         mClaY8rFG3KyOqmpa0uxS0PP0D+NZyDvZOKM7fDi1ahVKZLbH9fEN8lWufHwMQ6f/NxS
         1wlLGspL7dJ6JhVwlLzJtgxCFaLh55/gc9tIc7wFzKqs3vC1F0Z8FvwzR6VlpsEQ4cSy
         SjJ6OcYWtuZakF2TZcyyESwAro0myGFbH9Sk1Xk1I1OhyWX9kKLfQcEe7DIiu8/yYsKa
         fg3MgGELk1fErvQ9V/dnbpd6R/QHXJsMjumAyWJftMVPyrCPRJt4l+tzo7rEa4FZPCuI
         9Z6A==
X-Gm-Message-State: AOJu0YyNtUA6lOpocmm6Juwp3ZCAQqhYnbliaBB5kBektfpOmNtIg9YR
	eErO7ykG2qyBaMF5LQh8sgf8o9BrE42/uueqCPYtPLRgMPObl8rrO+vbFAq8Aweir4yLxHuYgxc
	S4a22RYXhNMnx0Jt04TAJHQx19y9WsnziAfxNcO2D+jEaA05u/NKlaiWLyQ==
X-Received: by 2002:a17:902:f548:b0:1f2:f986:595d with SMTP id d9443c01a7336-1f6d0398b8bmr31905605ad.66.1717763323525;
        Fri, 07 Jun 2024 05:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6Nq3NON3nNYPSqkTit6b/3ffna0pt3lQ5eki8qMVQI7KM999+GAG3L/ilgwmwBjMln1kHGg==
X-Received: by 2002:a17:902:f548:b0:1f2:f986:595d with SMTP id d9443c01a7336-1f6d0398b8bmr31905045ad.66.1717763322707;
        Fri, 07 Jun 2024 05:28:42 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd778259sm33012775ad.117.2024.06.07.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:42 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:42 +0800
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
Subject: Re: [PATCH v4 7/7] x86/crash: make the page that stores the dm crypt
 keys inaccessible
Message-ID: <et3x72uwqo3vdhzcmpq2ptiyrzyjnzauy2mihzfu2phmr5iqgx@klkkai3em2fe>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-8-coxu@redhat.com>
 <ZmLaTJA6Vq1a9x5z@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmLaTJA6Vq1a9x5z@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052847_201517_16DD7B01 
X-CRM114-Status: GOOD (  17.57  )
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

On Fri, Jun 07, 2024 at 06:00:44PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> This adds an addition layer of protection for the saved copy of dm
>> crypt key. Trying to access the saved copy will cause page fault.
>>
>> Suggested-by: Pingfan Liu <kernelfans@gmail.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index b180d8e497c3..fc0a80f4254e 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -545,13 +545,34 @@ static void kexec_mark_crashkres(bool protect)
>>  	kexec_mark_range(control, crashk_res.end, protect);
>>  }
>>
>> +static void kexec_mark_dm_crypt_keys(bool protect)
>> +{
>> +	unsigned long start_paddr, end_paddr;
>> +	unsigned int nr_pages;
>> +
>> +	if (kexec_crash_image->dm_crypt_keys_addr) {
>> +		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
>> +		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
>> +		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
>> +		if (protect)
>> +			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
>> +		else
>> +			__set_memory_prot(
>> +				(unsigned long)phys_to_virt(start_paddr),
>> +				nr_pages,
>> +				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
>> +	}
>> +}
>> +
>>  void arch_kexec_protect_crashkres(void)
>>  {
>>  	kexec_mark_crashkres(true);
>> +	kexec_mark_dm_crypt_keys(true);
>
>Isn't crashkernel region covering crypt keys' storing region? Do we need
>mark it again specifically? Not sure if I miss anything.

kexec_mark_crashkres only makes the page read-only whereas
kexec_mark_dm_crypt_keys makes the memory inaccessible. I've added a
comment for this function in v5 and hopefully no one will be confused by
it.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

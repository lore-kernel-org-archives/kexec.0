Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72B4C3ABBE
	for <kexec@archiver.kernel.org>; Wed,  7 May 2025 03:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDP5SJyu1HM2jy5Jk+I9deDo8NdSHT65dpnO1OhhUms=; b=sDOsz0QWaBqlefZxliuSShflHP
	ZrbLLZXOlEBwUvlRn+2OGkYXCTJi/JN2BSrUuOCEV6JtTAb8lHFenFO6yYYaC/S5cy2ntriW3/Xc/
	wrv6mYi3fPOk5bacAD8jmb/pH2+TNHsQl0DlDPgWB8Aa/t971uSm+KEBzHBA8tzcrEaODtxDi7v1H
	G3hZ3RGs4G2/96xF4qhHxJXF9hehDk8Ee+hL1dOgV7f0ixTogpRVuwkCxofEMpLU8UXEwOeKAq2jc
	uy5U1076fpalcLorpZLAfUuNYRCyvUXgZ2qjatoxvDf6VY5KTkYxThr9HA9Q0WvhutNLADNdL5as8
	V3/Iw8KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCVBI-0000000E2oQ-2HAP;
	Wed, 07 May 2025 03:10:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCVBF-0000000E2mC-3SXP
	for kexec@lists.infradead.org;
	Wed, 07 May 2025 03:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746587445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDP5SJyu1HM2jy5Jk+I9deDo8NdSHT65dpnO1OhhUms=;
	b=OY0lCZNqH4gFdgWxhwePg1l3Il4NuSu9znjaUFUDW3BMv3sA918PVVT9eJjbOeNCNMvmQC
	L2HThMvpI/8cHu/p8yo9DWMOajlMkrg4zqBe22t2wzukl7dhz4QtJeS8JOEMDu3Rfn9MqQ
	Xhxs+TlEBY1zxrca0ery+K4dAqdKFN4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-YoGIpXawOtagT12cJ3B6EQ-1; Tue, 06 May 2025 23:10:40 -0400
X-MC-Unique: YoGIpXawOtagT12cJ3B6EQ-1
X-Mimecast-MFC-AGG-ID: YoGIpXawOtagT12cJ3B6EQ_1746587440
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22e3abea7e8so14698205ad.2
        for <kexec@lists.infradead.org>; Tue, 06 May 2025 20:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746587440; x=1747192240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDP5SJyu1HM2jy5Jk+I9deDo8NdSHT65dpnO1OhhUms=;
        b=ILW5PXCFzrThzvn7tOGPxoaYxw6ELicImkidMf00/CHSiNLg0bZgibtwpJnqCMC7rr
         LXPLglfhYd9IWhkmTjBJmmhzZrLQA6qTt/JVMiwESJku2nOUw3EjGvCScTRGWVrU1deC
         vvYxWgi7XN5JW1YCwYAMe0tgzQqAzS9J4h4vTqiwryCCTxB6GAGabsdmfpSOzjr2tLEj
         Sc3VzyGXW+dpDdCAdpMvxkr5BdIJBICV2oJEG7EZn8K3pzYA0qXb/cjPBARD1tloNxP9
         BFH67h5iZorEwFG0pkrGqbbVYoJ6ZuhsN4hK3/pwSsTNyLqQvU+93RW/ED0MCLJvvsY6
         texA==
X-Gm-Message-State: AOJu0Yxmb1miIMUelhUOAvqxfqVuCN4uWFuMwtljNfgWhJ74YgIGAGWf
	5HOJie761aKTc2MbnJ6P0sdSWGVeVkfGlwuH/FRM7HFV0jc0Nxxuxh69OlX9mO5m+tn5sY4L1Hx
	9Mz0ZRg8UE8GZiiS+P/TveP6oXw3vewRN+b3FuCQ2q9R4Thndf9qDHVQ6HA==
X-Gm-Gg: ASbGncvZ5ODgsQXODTVDhOgPTYu7gZlZda9THj1y07HDFqNa8ooB3F0LdiFqSujtvpB
	+iorUXYJLH3SujgYWaP7N53kHXR2HoogLD7cpQlyvJcxmztyD2YmRKwxLNT5QknCxiQfXxrKrkt
	IU5GbSQ3Jt8NtYZMhFrHfDB/CwQoh4iT+oYb3S5c5k/2AbAGwp2RvYwb+BO9dWx+xB1jOWSr+nb
	MppZTkU8pE1B0bC0jP7yH3og07gQzlLVW8jTqtAuXTyGj9l/9LLPjtSpepOOSW0mIW5N4BA1xD4
	M9g=
X-Received: by 2002:a17:902:f789:b0:224:1001:6787 with SMTP id d9443c01a7336-22e5ea2e466mr24846825ad.4.1746587439734;
        Tue, 06 May 2025 20:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0UfEi+55Sr/HmVL17k/pyRle1Z4csFmmJpk2KYXZvLlD0HVZ1oUcDI55EPbEuyt069E4aHg==
X-Received: by 2002:a17:902:f789:b0:224:1001:6787 with SMTP id d9443c01a7336-22e5ea2e466mr24846475ad.4.1746587439348;
        Tue, 06 May 2025 20:10:39 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e98d0sm82766195ad.80.2025.05.06.20.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:10:39 -0700 (PDT)
Date: Wed, 7 May 2025 11:05:27 +0800
From: Coiby Xu <coxu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 6/8] Revert "x86/mm: Remove unused __set_memory_prot()"
Message-ID: <idxxt5vwxx65n73rau2pr72bnw4nopyxi67otivqdzrlnt6tnn@7uygzqael66u>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-7-coxu@redhat.com>
 <20250503234605.94d954b6ca70ea09c0aa8004@linux-foundation.org>
MIME-Version: 1.0
In-Reply-To: <20250503234605.94d954b6ca70ea09c0aa8004@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EbBNrcVzuOGKNfMOipMtBMSqOC0CaltKTHBAvuAl10M_1746587440
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_201045_933962_FB3EE737 
X-CRM114-Status: GOOD (  13.59  )
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

On Sat, May 03, 2025 at 11:46:05PM -0700, Andrew Morton wrote:
>On Fri,  2 May 2025 09:12:40 +0800 Coiby Xu <coxu@redhat.com> wrote:
>
>> This reverts commit 693bbf2a50447353c6a47961e6a7240a823ace02 as kdump
>> LUKS support (CONFIG_CRASH_DM_CRYPT) depends on __set_memory_prot.
>>
>
>x86_64 allmodconfig:
>
>In file included from drivers/gpu/drm/i915/gt/intel_ggtt.c:6:
>./arch/x86/include/asm/set_memory.h:40:57: error: unknown type name 'pgprot_t'
>   40 | int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
>      |                                                         ^~~~~~~~
>
>I did this:
>
>
>From: Andrew Morton <akpm@linux-foundation.org>
>Subject: revert-x86-mm-remove-unused-__set_memory_prot-fix
>Date: Sat May  3 11:38:32 PM PDT 2025
>
>x86 set_memory.h needs pgtable_types.h for pgprot_t.  Obtain it via the
>higher-level pgtable.h.
>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Coiby Xu <coxu@redhat.com>
>Cc: "Daniel P. Berrange" <berrange@redhat.com>
>Cc: Dave Hansen <dave.hansen@intel.com>
>Cc: Dave Young <dyoung@redhat.com>
>Cc: Jan Pazdziora <jpazdziora@redhat.com>
>Cc: Liu Pingfan <kernelfans@gmail.com>
>Cc: Milan Broz <gmazyland@gmail.com>
>Cc: Ondrej Kozina <okozina@redhat.com>
>Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>---
>
> arch/x86/include/asm/set_memory.h |    1 +
> 1 file changed, 1 insertion(+)
>
>--- a/arch/x86/include/asm/set_memory.h~revert-x86-mm-remove-unused-__set_memory_prot-fix
>+++ a/arch/x86/include/asm/set_memory.h
>@@ -4,6 +4,7 @@
>
> #include <asm/page.h>
> #include <asm-generic/set_memory.h>
>+#include <asm/pgtable.h>
>
> #define set_memory_rox set_memory_rox
> int set_memory_rox(unsigned long addr, int numpages);
>_

Thanks for catching this issue and providing a clean fix! I'll make sure
future patches pass allmodconfig. And also thanks for pulling the patch
set into -mm tree!

-- 
Best regards,
Coiby



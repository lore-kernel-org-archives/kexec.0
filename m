Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A2DC4332F
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIuN+qvc99tQySvIMdeOD1SF4W3nHm84nwpj7cikow4=; b=mmQ2WbIRzDnUvrf1jgw9aaRbgs
	uPzw+iaK39eaM9nGKvq5FK6wXgaR4zX7QUEDosUcvNxWHYQiL2ZBKK81U0q3pVdSgexsxAFlCwSjO
	PUnEZhgr/vCXIyaz4c3otdPvbU6a0WpN9MSTYfRwCcLaZsg3E5Xql/9rzC8jkyEwOW5dt1udQz56f
	Y8nDHoJlVKGCxYX/6o93twCOFY5hcaH3qc4amZH91MBVliHWVWQZE2gQmTk7gZtt38W/vJeJWAUnv
	V0tiFpWfIlxCLyVKxJf9CU3ZZI0V2lFObYsxsJufV4oswLuHsExAKIO5h73hvLBOz1uQlWCfbUhtw
	1OnGYiyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os0G7-00E8gm-8d; Mon, 07 Nov 2022 11:25:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os0G2-00E8fF-78
	for kexec@lists.infradead.org; Mon, 07 Nov 2022 11:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667820335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCVCpPKMqtN5wnk1UeEtAp45DPD5WDdi+08rU7HtVp0=;
	b=K9BKU0x3EslvbNoYfThNTZk70nyufgLxXg2rEssxhQsW/fBBdTkRqGdRFHKNodRSX4h5fq
	KZaOV/CEB7dqCRlSABoGcuKH9Erx1WaJn9yppXv27fIgo9bbF5SFsW+EF/CrmZ5JHD4R24
	sQSStRIO+z8YdjWX6mLYVcF8hKsMKH8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-UItgox1IO1aAaZNL2fx-Fg-1; Mon, 07 Nov 2022 06:25:34 -0500
X-MC-Unique: UItgox1IO1aAaZNL2fx-Fg-1
Received: by mail-pf1-f200.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso5363190pfi.7
        for <kexec@lists.infradead.org>; Mon, 07 Nov 2022 03:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCVCpPKMqtN5wnk1UeEtAp45DPD5WDdi+08rU7HtVp0=;
        b=ph7dHKGpgN8f8IjaVOwy0wfRRLZsXPzx9nDijE+aTh68HVE+FVBW6PVKC1hw6FodA+
         6OK9wbD/UlCofCvGz+loB0iSuAPE/nFUpYAjFy/lqKXpULOLjZeJR87qbeGgVo6sjVqO
         rLqDUffc3ZaKvn54vE1PzKXcAwQTtTiLOTsk+GGNYGfpJtVQvnqPxpMuXkMVmJ2BmXps
         gFk5YzzfsTPyCRDBwJnEK63tsLdWtLc5apGKK+6OONOyDfz6m3CVZHIHiN4wb0fcaGLQ
         XGcFCEQyXhk32Rrja8mJGiuCdVTvGk4Rm1NYjLZGnqVHs/tJMyBVaIvTvQXix3QpqJsy
         +qXA==
X-Gm-Message-State: ACrzQf0p5JNAd/rVw8oHs5bFDczfxv8Iq38vYeUb3X+DVfPnx9rwF19D
	DoZaJxfVyEqQrk3Oc8Svk8DLIyrE+hGqNuAHYeV4ooLUDFjhZAEZZNckU/CrZrSLDvBogok5V1A
	Qabzf1BMD/dUvsgXLE5TE
X-Received: by 2002:a17:90b:378a:b0:213:803d:3389 with SMTP id mz10-20020a17090b378a00b00213803d3389mr59863668pjb.115.1667820333144;
        Mon, 07 Nov 2022 03:25:33 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4kRlWD2TrlfQwcFjYkARJTFCe1a+ZyHxdAcDHlQVxS+84+J4PGUG5doWP7ysunIg0QVPRwjw==
X-Received: by 2002:a17:90b:378a:b0:213:803d:3389 with SMTP id mz10-20020a17090b378a00b00213803d3389mr59863627pjb.115.1667820332821;
        Mon, 07 Nov 2022 03:25:32 -0800 (PST)
Received: from localhost ([240e:3a1:313:8350:fe71:9f84:6361:a65b])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78f21000000b005613220346asm4210353pfr.205.2022.11.07.03.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 03:25:32 -0800 (PST)
Date: Mon, 7 Nov 2022 19:20:34 +0800
From: Coiby Xu <coxu@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>, Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com, Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC v2 4/5] x86/crash: make the page that stores the LUKS
 volume key inaccessible
Message-ID: <20221107112034.dxfembsprd2wwnpf@Rk>
References: <20221104113000.487098-1-coxu@redhat.com>
 <20221104113000.487098-5-coxu@redhat.com>
 <1c9a1b86-efef-fa56-4451-ac3348b678bf@intel.com>
MIME-Version: 1.0
In-Reply-To: <1c9a1b86-efef-fa56-4451-ac3348b678bf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_032538_353609_4A7B4609 
X-CRM114-Status: GOOD (  15.77  )
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

Hi Dave,

Thanks for the quick review!

On Fri, Nov 04, 2022 at 07:38:17AM -0700, Dave Hansen wrote:
>On 11/4/22 04:29, Coiby Xu wrote:
>> +	if (kexec_crash_image->luks_volume_key_addr) {
>> +		start = kexec_crash_image->luks_volume_key_addr;
>> +		end = start + kexec_crash_image->luks_volume_key_sz - 1;
>> +		page = pfn_to_page(start >> PAGE_SHIFT);
>> +		nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
>> +		set_memory_np((unsigned long)page_address(page), nr_pages);
>> +	}
>
>Why does this go pfn -> page -> vaddr?  What good does having the page
>do? 

Sorry it's an imitation of kexec_mark_crashkres.

> Can you just do phys_to_virt() on the start address?  Maybe:
>
> 	start_paddr = kexec_crash_image->luks_volume_key_addr;
> 	end_paddr   = start_paddr + kexec_crash_image->luks_volume_key_sz - 1;
> 	nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/
>PAGE_SIZE;
> 	set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);

Thanks for suggesting a smarter implementation! I'll apply it to next
version.

>
>Also, if you resend this, please just cc the x86 folks on the series.
>The other patches and cover letter have desperately needed context
>around this.

Sure, I'll cc the x86 list the complete patch set next time. Sorry
you'll have to go to
https://lore.kernel.org/lkml/20221104113000.487098-5-coxu@redhat.com/t/
to read related emails for now.


>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

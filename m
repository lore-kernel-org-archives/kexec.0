Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8319CD11BF
	for <kexec@archiver.kernel.org>; Sun, 24 Mar 2024 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7WpoD4ayQ4zPuslFn1RTTLwevVEv+bG/a4awJCGlTMw=; b=G0i/5zV+TkVKv3
	Fx8DNRmfdBbySVvhw56kvpoqyIW0gvgxMGsXas31E0pYpHP5aBBMkphqpxiznsDEkL5JB/AmnFDz5
	0+Z0y7yI51umBIhuuBuD0e0DhqSGv40QXLhPBckvhxr8cIoutEYWeVwG26YB3VVDpoTt8ufNSv8YJ
	3WFndqAwVCtT7abmUb/iOC1rpKyVQW3+uKOHvLGKDeWhfzqJ6w91F6jZXQ9amLDvwUFnrFAwa4RlA
	sdBUis1ANGzMkXRntMcx09RoLGKSpcKBxnJP4vXrGt3NV4quAUQ0QaqF297Bf8gIncDDeSLo0gNAw
	6uVY6NXVggabEDYvQlAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roL55-0000000CKqg-3f98;
	Sun, 24 Mar 2024 10:27:59 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roL52-0000000CKo5-2GbF
	for kexec@lists.infradead.org;
	Sun, 24 Mar 2024 10:27:59 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-515a97846b5so266361e87.2
        for <kexec@lists.infradead.org>; Sun, 24 Mar 2024 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711276068; x=1711880868; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bauhf/2rjBkok/hrNxsx2Lp6yFKty71agj7qYN59Fb4=;
        b=OpUDiz7mLIK2nURkfKcgcQPin10opL0tmVO+IJbFE1X/gyJGImHu2nI8M0vhJ9JmB/
         p6EPMkx2cigvsdn2JnjCc5nrFAHPVyUY3v8VVU4PQU9Gtw2rpx5MiJjFum5GeEQd62M5
         +RIptjI9iKANniElTap5Wmo63NcIFagA5EAbk89fEAiQse8aUNdureh36U1QS+BpTj80
         jZ9xyUDrOc6dFPG+wXy2gYnXwlN/WIGuUbNg34nx7tQuv+zvCzQ4lMK+91HXxwHAzMwj
         vb16Dmorg+4Dv8YSYeb8hv6R99U+JWaQ2vUe6UoIygRrb2DB/TOSoyg7O81VZqGSrlL/
         QFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711276068; x=1711880868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bauhf/2rjBkok/hrNxsx2Lp6yFKty71agj7qYN59Fb4=;
        b=iImXblGx6Hz6cJHx9/JUtfMmSPCp/wZ91rJYvjNghLOwDWPS3JKp4gw1Fn9JO6g+HE
         5l7FE5hR7l8HDd4swAs9IKclTLqKt6ZuHeF9o4RNlIYZLNPHK5yeGvhQnsjIHvxKqROJ
         4QaHG05nnjD12QiIGDTOfK0P5Ird657vTuvXd6A9ndiG08KJgbx3arsFOlD1c49YrFw4
         EtcbZZuaGT4GlGIYao2zFZ+L3XVKWMZ/8CTfIDGeF6eF4RA0Pi0epaAjUJOySv+V2BfX
         +Z9LXapB6UgNXFQmtRuBIDePgarKeR+UfasaezF/N5bgyO8qK2348trsHviCeFKFZiYg
         Yv2w==
X-Gm-Message-State: AOJu0Yz8iO2jqZ3HQpzA9ONqZyBHZBYSkZJqkMvoaapwJ6yXWKcU1ASk
	gmDQgtblbTuBVb3nKJJKLpGLCgi9oAgI90Ofle0plPtR2kMHMA1M
X-Google-Smtp-Source: AGHT+IFqkThVpXulVzVhNJekNUYVHumLnBKOTdbzFKyjcLlJN4lf7UbH8vVeWJuT2lsfD35b007Cug==
X-Received: by 2002:ac2:4643:0:b0:513:4705:a4f3 with SMTP id s3-20020ac24643000000b005134705a4f3mr2753394lfo.65.1711276067486;
        Sun, 24 Mar 2024 03:27:47 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00414808dea22sm1107606wmq.0.2024.03.24.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 03:27:46 -0700 (PDT)
Date: Sun, 24 Mar 2024 11:27:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <ZgAAIB6H+7+t7YpW@gmail.com>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <Zf+m4YtKtmdrjw4Q@gmail.com>
 <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_032757_316243_36D16AA5 
X-CRM114-Status: GOOD (  16.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


* Baoquan He <bhe@redhat.com> wrote:

> On 03/24/24 at 05:06am, Ingo Molnar wrote:
> > 
> > * Baoquan He <bhe@redhat.com> wrote:
> > 
> ......snip
> > > ---
> > >  arch/x86/include/asm/crash_reserve.h | 2 ++
> > >  kernel/crash_reserve.c               | 7 +++++++
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> > > index 152239f95541..4681a543eba3 100644
> > > --- a/arch/x86/include/asm/crash_reserve.h
> > > +++ b/arch/x86/include/asm/crash_reserve.h
> > > @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
> > >  #endif
> > >  }
> > >  
> > > +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> > > +
> > 
> > Any reason for that stray space?
> 
> No clear reason. I saw stray space was added for macro definning when my
> below patch was merged, not sure if this is preferred.

No, it's not preferred - and I don't see any stray spaces added in the 
code added by:

> commit 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")

Anyway, please just remove it.

> And there are a lot of "# define " when searching with 'git grep "# 
> define " arch/x86/include/'.

The overwhelming majority of those are not standalone defines like 
yours, but nested/conditional defines where the space is justified:

#ifdef CONFIG_X86_32
# define MAX_IO_APICS 64
# define MAX_LOCAL_APIC 256
#else
# define MAX_IO_APICS 128
# define MAX_LOCAL_APIC 32768
#endif

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

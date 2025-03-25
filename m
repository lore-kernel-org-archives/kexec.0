Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507E1C36012
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bXwOjnHMzxUdXRa1xbPJFsVQQAIPiDayu2d6sm6acno=; b=LhnCcauwLOA8tqJA5nagp2yRqW
	mCSZnk8KywyRSj77DdXZBiNWUan3QLLbWhL4Pwf3EKPkv2C1iCp+9HnEBubhBJ+aioEuDHxPlBNuT
	KJCJDgegvQ3XZTvLwqb9JVWV/6U2saAg44AYjndwFi2UYIE/oqwRcU0v/myPJ7NXKP0/TX+K4jIkG
	EQLXRUpmHc0J2loJ/oXTXlT4GUnHhy03N8zrVYcyF0q36nFwy5shmtUEbc/9AE1dnOCrz7IObSoW3
	BElsrmRdrx63U4iCAgdl+Hgjn4HdlomQVErvsjsWalCPKW5qWyijP0aG35+FdxMhoRpCLg/qsAUcR
	xUA2MltQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTv-0000000B66t-46K8;
	Thu, 27 Mar 2025 13:41:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twzlW-00000005D4w-1LJm
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 08:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742891763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXwOjnHMzxUdXRa1xbPJFsVQQAIPiDayu2d6sm6acno=;
	b=XfLjqI8nqqnCKjQoi71MLE1vs/XNLRcgxmwZITzzzCBAh3HsB24rxP6loqtD1tt7iJQMQS
	QoXpFYpYciukOK5wUn1TbDF0MjIIwF/vTBosDHALGI1PO6/qVO0N6oLmWZKcAF86xg/fHY
	r8FEa4Dcmw9Ppqpd6ojGyxkiMt2luxE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-lsEej6amMGuOwya_ngNhOQ-1; Tue, 25 Mar 2025 04:36:02 -0400
X-MC-Unique: lsEej6amMGuOwya_ngNhOQ-1
X-Mimecast-MFC-AGG-ID: lsEej6amMGuOwya_ngNhOQ_1742891761
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d44a3882a0so50087055ab.1
        for <kexec@lists.infradead.org>; Tue, 25 Mar 2025 01:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742891761; x=1743496561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXwOjnHMzxUdXRa1xbPJFsVQQAIPiDayu2d6sm6acno=;
        b=qtZNSG6M52Lu3oP4ivcipL52PidMBjg9QzqhYqgzWZoAq3aNrb5aqR7M6knyRDGOPT
         N16qcglLISX9AUxDQOgYIQpylYZiZ2BPFfFW02BptNYiQtd07wl7B90cflWnhaTfWMSX
         GuexM2giHFaENXXtzkQCl0K2UWMaFdvwI6V5fXzJkix16Q8Az7zbRgC3YMPb23ojRnm8
         m4qNCwHTfwMX2ywhxsezY+zyhc3xqXzIm2xQmMor+R+rt2ARYIiyhqhmKG7XJG319/x7
         Pptg99jzRip58VOyJaFh3P42BmTkLa9NkvtfTFO7T/NSpqeVGcC28dImh0HlEV1AW+Ut
         YNTg==
X-Forwarded-Encrypted: i=1; AJvYcCXc3orFftUWtEccH7ogwV5k1A//UU5ozToBa5KZjSeTIUheWVIlYweS0XTFxvS1AJTj//1Kyw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyfpnsQ2mi5q/AuJM0LEJSHdymC8kN4JGibZ0YRwSrFsbFZHekx
	LFJjbPoohMyIZhV0bygHleaR6yfwjs75xMJqa73pU87J7m+SDZDy6lxf3CoItCkW8JghkMk8hJh
	d2YD9yiBZ8BktBcjrm/skJAzorm7RMCbMiOW2n0TT45jg7uGKbrSpGeI3dAmOyfkn6Z5lsgZyAR
	aWU1KXlZDc5xykB/HvojrtTk/8KU1f0Q3A
X-Gm-Gg: ASbGncuTiFFmaKIcNOxJaaj/REtc11du3l5OsCnnYwq9enufdaAQgrJG7gfbMzRFTT3
	0nYFCGPuzNlauREavvzg8uSzzllnczYgv262UGSNq/S2JluFdq8jG9ISn9m0qXH3LyluP2paWSw
	==
X-Received: by 2002:a05:6e02:12c9:b0:3d1:4a69:e58f with SMTP id e9e14a558f8ab-3d58e81374emr209274305ab.2.1742891761211;
        Tue, 25 Mar 2025 01:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9E4/EucEBc/+iE2lWu+YyJiDtrud2DOWwH9Ttz3ALKtbFpsWVzZCuYuuSTYSC3OfYElupM2e2tE7hTWgAmd4=
X-Received: by 2002:a05:6e02:12c9:b0:3d1:4a69:e58f with SMTP id
 e9e14a558f8ab-3d58e81374emr209274145ab.2.1742891760802; Tue, 25 Mar 2025
 01:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
In-Reply-To: <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 25 Mar 2025 16:36:22 +0800
X-Gm-Features: AQ5f1JqjFlzQ1M_D50CQArcQW8YwNNz0vfJYofXBEYquREvaq-g04uQRlGUrUgs
Message-ID: <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Baoquan He <bhe@redhat.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, graf@amazon.com, 
	akpm@linux-foundation.org, luto@kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HuPXcsd6isEhEi0xMrEV3I8PpZNLhKVtOcKKYXNr_5k_1742891761
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_013606_430441_E32AFD68 
X-CRM114-Status: GOOD (  12.87  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

> >
> > Have you tested kdump?  In my mind there are two issues,  one is with
> > CMA enabled, it could cause kdump crashkernel memory reservation
> > failures more often due to the fragmented low memory.  Secondly,  in
>
> kho scracth memorys are reserved much later than crashkernel, we may not
> need to worry about it.
> ====================
> start_kernel()
>   ......
>   -->setup_arch(&command_line);
>      -->arch_reserve_crashkernel();
>   ......
>   -->mm_core_init();
>      -->kho_memory_init();
>
> > kdump kernel dump the crazy scratch memory in vmcore is not very
> > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > so please disable this option for kdump.

Ok,  it is fine if this is the case, thanks Baoquan for clearing this worry.

But the other concerns are still need to address, eg. KHO use cases
are not good for kdump.
There could be more to think about.
eg. the issues talked in thread:
https://lore.kernel.org/lkml/Z7dc9Cd8KX3b_brB@dwarf.suse.cz/T/



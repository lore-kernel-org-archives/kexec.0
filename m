Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5741C4345F
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nimeTXRqvTM5ocw8rOPOFa/Haqbx+QOXXLygbPlo8lM=; b=OfKLWnDwutxXQ9
	ZXL2x1EvO351RmAO4EqnCtJthNzL1A6nyB+CPzojIkR1oeSBJMcuMzloMSnbvWrykN/ls6GFPvBtI
	S6P6FV6SyEsL2v2wLgWK4WGWWdzuVHPotynYMR9TU8guKiRsm2iEFsuenmVX41D2na2eDwsqwT0Of
	dYiQ5mlunodmSMtp2g8C8DqUrkOfoYh7nfO5vvMoSdmypFa+W8/LulZJi1OZksxBZ7i2xSfbyPVjj
	SUUGa1xzSyvj5GLQJLu/a0lwxmUPA/X1IL3u81toakWv+4eXVNnZYrnymgeDhpiKzLYcG3ULWnY7J
	2RfxCiGtKfL2smyGLfcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2VPz-0000000Cd7B-19HD;
	Thu, 02 May 2024 12:20:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2VPw-0000000Cd6A-1dsc
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 12:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714652402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0ouXWVXMSsia+jkf8WQfP89YFxtqAKEOm2AuOhT3gc=;
	b=GlPGQ1UYpeY7jUmR0caiGG2ZHVF1SCzJZvCm4GrdNb1VfsW+mMsoKWwjR6Zd/RS9o/JkCf
	H5wKQudzr51MIY0yMKT4GjV18Jun6oZKBha4H7zOZUa0p0faDBLH/lpC/m7reKDdc1mo/4
	CymusQd9B2qg19nS0JQJ0w08L1MGuJY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544--r5t2xbcPVyLHg6REkuqqA-1; Thu, 02 May 2024 08:18:13 -0400
X-MC-Unique: -r5t2xbcPVyLHg6REkuqqA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d87b880861so68363741fa.1
        for <kexec@lists.infradead.org>; Thu, 02 May 2024 05:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714652292; x=1715257092;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0ouXWVXMSsia+jkf8WQfP89YFxtqAKEOm2AuOhT3gc=;
        b=GGJvm+M1k46Oix7H0pGfesUyGtDMD+GxNxd+gh7XiHbTu6kTbiY8B/K9rnSM8fu9Uk
         tYLPnkXaNP5+x2Ab9SI/2ogGvppYG0oGT6IAD+ooTzjZV3z3pKH4RMmIOrETaOE1k/ZP
         3j+hb7y27tGTN5aRc7XFYmw2MYLLeLxUyCOH2Ti/3vFi7QsdTgmdFk163cHIL83Tt+a0
         jXEeXfxLo5Kk0xBJzVjGD8S/ZnlEqnK/HnP8Ebk5m/i3KJyJLncfstUVi+iYbRxrGlUs
         S29T5GHS/GBlwoK+kR6HV+P+2XaMwV8hYEsxgm5QA2BAAlaHchC+qB1QSBa0yl0B+wIP
         AUgw==
X-Forwarded-Encrypted: i=1; AJvYcCVQiXC6u/GnYwzgQr8zKCgj+UxmozVeZs/bkUSGngxV47BFo2iKOAArgsXbV3P19ozuXiV8DJnJKApxbKWMSoO9mw7svob7VKH/
X-Gm-Message-State: AOJu0Yx69tq1tcQo0wc4Xc4JEoCViM7s3DrPsfdPc3BRrVRVLNpLNBns
	YZWF8RtX6G21XYnrBfawxLzNQGlXm/KTHqAkNjD+YwwWWAWkYtlKY+vZ7mj90ioHmgQwkJE3H/x
	u+Rkoeqi0GpzCRJZfWblFqePX37fzBhigtyFYlN7985TSQzEQPlcZvc9yeA==
X-Received: by 2002:a05:651c:54b:b0:2df:8ce6:96ae with SMTP id q11-20020a05651c054b00b002df8ce696aemr1459346ljp.7.1714652291922;
        Thu, 02 May 2024 05:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHLEzhel3J+Iky5AXISUEMehzZpROpO7wE4GfujUAp2fZWvLcpFCcbsttf2lwNUdXPb4hkug==
X-Received: by 2002:a05:651c:54b:b0:2df:8ce6:96ae with SMTP id q11-20020a05651c054b00b002df8ce696aemr1459319ljp.7.1714652291458;
        Thu, 02 May 2024 05:18:11 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b0041bde8ddce9sm5535635wmo.36.2024.05.02.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 05:18:10 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Alexander Graf <graf@amazon.com>, Ashish Kalra <Ashish.Kalra@amd.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, dionnaglaze@google.com,
 anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
In-Reply-To: <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
 <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
Date: Thu, 02 May 2024 14:18:09 +0200
Message-ID: <87msp8mmpq.fsf@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_052004_599820_D4E2413E 
X-CRM114-Status: GOOD (  18.86  )
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

Alexander Graf <graf@amazon.com> writes:

> Hey Ashish,
>
> On 09.04.24 22:42, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> The patchset adds bits and pieces to get kexec (and crashkernel) work on
>> SNP guest.
>
>
> With this patch set (and similar for the TDX one), you enable the 
> typical kdump case, which is great!
>
> However, if a user is running with direct kernel boot - which is very 
> typical in SEV-SNP setup, especially for Kata Containers and similar - 
> the initial launch measurement is a natural indicator of the target 
> environment. Kexec basically allows them to completely bypass that: You 
> would be able to run a completely different environment than the one you 
> measure through the launch digest. I'm not sure it's a good idea to even 
> allow that by default in CoCo environments - at least not if the kernel 
> is locked down.

Isn't it the same when we just allow loading kernel modules? I'm sure
you can also achieve a 'completely different environment' with that :-)
With SecureBoot / lockdown we normally require modules to pass signature
check, I guess we can employ the same mechanism for kexec. I.e. in
lockdown, we require signature check on the kexec-ed kernel. Also, it
may make sense to check initramfs too (with direct kernel boot it's also
part of launch measurements, right?) and there's UKI for that already).

Personally, I believe that if we simply forbid kexec for CoCo in
lockdown mode, the feature will become mostly useless in 'full stack'
(which boot through firmware) production envrironments.

-- 
Vitaly


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

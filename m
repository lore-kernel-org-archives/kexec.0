Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDCDC3ABC9
	for <kexec@archiver.kernel.org>; Sun, 11 May 2025 02:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWCzDenG4YMv82lLqXoIzRJttzc7mSVDjw13b5sAeGU=; b=y7IpyUV1yfpECzVrsdAjFrWyQK
	1UjtnDAkwdFM2UnL+4yd8O/H/zL6jIPP8dmxf/3Eui6uqUnwlNPSIc2/Am5LIre5yuyJH+MCS9hoM
	IzOgWBApoqEqVMHLhEgkJLnzz9no3fBlCnaRyvHsrGbus29eZCPzx0/Ex+38zY8cuN+F5J6rTALXL
	Mwvr19zSSAt39mWRdSFWIIavd3eBFvaEq9F5fBuU1TFJO2DkTWFMCyR337bJ3NA5DtL4NOMeGW81x
	/Y3/LG5Ia8lZzeUJaXip3cVfg5Ec3oirCjQb1mqfw/N72iZWuLt1nO5+0VYX1cJcT66jkPuXvrwP7
	misBBgOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDwJU-00000006doI-23ct;
	Sun, 11 May 2025 02:21:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDwJP-00000006dnZ-1Ffm
	for kexec@lists.infradead.org;
	Sun, 11 May 2025 02:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746930066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWCzDenG4YMv82lLqXoIzRJttzc7mSVDjw13b5sAeGU=;
	b=YJlXynYPKQVF4ud5Vnj/KZM0SpL6JNTgi/DBFBYmPccpusHXVXhvOCjro/EiSTVKyXdXN8
	U8EHkStfpBQSh07eBHZ1/tZyROC8xe4oRf4JlpJTSrvHpq3/4sxDJ0aJZCW3n5NntaDjIc
	mc7nPrRByWHw0s8M4z/Q2RHiAXl6RhU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-yk9M40PNM3GSmRiCFW_nTg-1; Sat, 10 May 2025 22:21:04 -0400
X-MC-Unique: yk9M40PNM3GSmRiCFW_nTg-1
X-Mimecast-MFC-AGG-ID: yk9M40PNM3GSmRiCFW_nTg_1746930063
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22e5a558bfaso77588655ad.0
        for <kexec@lists.infradead.org>; Sat, 10 May 2025 19:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746930063; x=1747534863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWCzDenG4YMv82lLqXoIzRJttzc7mSVDjw13b5sAeGU=;
        b=kkn++sfuhkc8iVFTg0JzdJI0vAvQouytMbQVvZaGiixF1lEb1fC8EkjCmZdUD8zgKN
         1XS4IUMtUV+eigYpbA1i3PBvqvxaQhAWK/Y48a7iyCM83uBKX8dX1sWMUNm3dHG0Evav
         Fc9USb42ua0M2F53lGImJsb+AHOcqD3C4nOYooITY/IxR550nm10wqKI65X7YX4wCNuz
         dIafU6qivVi1R/GQ9aCTTsTYsS5Wsi0JFFAN8w2Kl0/zB0YfsD5oGTqunCa9xOstAbiG
         K+Gp4rU/CXHVgYW0kO2FqDoEUvv26jEFUmvLFeUVHcJnUg5t/Rgph5KEZdozfM0W2Spi
         pyiw==
X-Forwarded-Encrypted: i=1; AJvYcCXFMqRtCfZdtWXatIOEFAfeW5IUUlqdI78xgre+GspZOlXCzE904rEBU5CPp5qXiDM1CYKpgA==@lists.infradead.org
X-Gm-Message-State: AOJu0YydcIeBrmj1ktIFtaEvCO5ZDdWOahyGnru/Y++Bl5zKoKLCYZ3t
	IEJ97gKrfLISf6W6traHZaw+ayKbCo0BRj0TPzGqTrwlX6qbmc7Xo8JE7CRJlpdGZW2HH9kWwM0
	G3mNU+5PAjbgTPhIWLM3r+9B5eHwfSKmY2VpVMRIcsPiEZDCSZ8Oyrnjkqw==
X-Gm-Gg: ASbGncuChX6RvdTIAhON10V+4DTGobP/XAlSsD2FZETu3ZY2xe63SrXNkxBl3+Xv0ac
	ndI1AkU2yMSPnWD6JXwIoJAhmbwQdW/d9RAe3T/9tGC1Ae5mnJyk02GCVModlFfu/mRVYCTwwcT
	L2QmBkHlQMeR8MPWHinU8DvECaz1IJo9axciq9UHvDrn/0y5zXyOYDToI/N9RjWYQuuO41Fsb52
	2oMBR2Zg9df6qsqcN0SasOuM/3ByplfWjyNN+mBlG1DOvPqNz63ke/3D6XTLJTVAGcDGuunIc6W
	6jQ=
X-Received: by 2002:a17:902:f606:b0:21f:f3d:d533 with SMTP id d9443c01a7336-22fc8b0fb59mr110678485ad.2.1746930063451;
        Sat, 10 May 2025 19:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHopMLru+6d0HG82g8HqTfh28pTOXbR5UK+YON5WLsX22f9UgYDAWtg0wHNgVG28emunjMy5g==
X-Received: by 2002:a17:902:f606:b0:21f:f3d:d533 with SMTP id d9443c01a7336-22fc8b0fb59mr110678325ad.2.1746930063076;
        Sat, 10 May 2025 19:21:03 -0700 (PDT)
Received: from localhost ([114.222.253.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm39552485ad.20.2025.05.10.19.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 19:21:02 -0700 (PDT)
Date: Sun, 11 May 2025 10:19:13 +0800
From: Coiby Xu <coxu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, fuqiang wang <fuqiang.wang@easystack.cn>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
 <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
 <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
 <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
 <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
MIME-Version: 1.0
In-Reply-To: <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HkNL3-630t-PCkaUK4PjCU34xxrfUob_M5kAyyd7eb8_1746930063
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_192107_529375_200FA4C2 
X-CRM114-Status: GOOD (  22.73  )
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

On Fri, May 09, 2025 at 06:35:18PM -0700, Andrew Morton wrote:
>On Fri, 9 May 2025 17:58:01 +0800 Baoquan He <bhe@redhat.com> wrote:
>
>> > The bad commit was introduced in 2021 but only recent gcc-15 supports
>> > __counted_by. That's why we don't see this UBSAN warning until this
>> > year. And although this UBSAN warning is scary enough, fortunately it
>> > doesn't cause a real problem.
>> >
>> > >
>> > > Baoquan, please re-review this?
>> > >
>> > > A -stable backport is clearly required.  A Fixes: would be nice, but I
>> > > assume this goes back a long time so it isn't worth spending a lot of
>> > > time working out when this was introduced.
>> >
>> > So I believe the correct fix should be as follows,
>>
>> Thanks for testing and investigation into these. Could you arrange this
>> into formal patches based on your testing and analysis?
>>
>> It would be great if you can include Fuqiang's patch since it has
>> conflict with your LUKS patch. This can facilitate patch merging for
>> Andrew. Thanks in advance.
>
>Yes please, I'm a bit lost here.
>x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch is not
>presently in mm.git and I'd appreciate clarity on how to resolve the
>conflicts which a new version of
>x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch will produce.

I'll resolve any conflict between these patches. Before that, I'm not 
sure if a separate patch to fix the UBSAN warnings alone is needed to Cc
stable@vger.kernel.org because 
1) the UBSAN warnings don't mean there is a real problem;
2) both Fuqiang's patch and my kdump LUKS support patches fix the UBSAN
warnings as a by-product.

It seems the answer largely depends on if the stable tree or longterm
trees need it. Currently, only longterm tree 6.12.28 and the stable tree
6.14.6 have the UBSAN warnings if they are compiled with gcc-15 or
clang-18. Any advice will be appreciated! Thanks!


-- 
Best regards,
Coiby



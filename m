Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F85FC54756
	for <kexec@archiver.kernel.org>; Tue, 20 May 2025 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTiw4lyKryoPf9LERb5T4xsi4Hrz2SvWTm/GDO7hgYA=; b=r5WY0vTTqUBeLYMNELWm9x7L2+
	wDgMh6yx/s9195AZfNfz+8t8mQLAHmK/ild1fyH/6/7cTq1jcxOp5kqT8Hih4Q8MPyiLs6pcdSfyj
	n3aad3TIemB8H0Sj6/REPL2UsIFHZRvXHt/cpPFS9r0uVFsgkEYn2c/e1uAjEJ6NXshGpCZno77dg
	brJ6mXExJ4YGQauEHajdGeBeC1pg1l7krQ/BpBGrsT7n+PHvyALbMHdRIok9nS82jbI8STfG35iNx
	NkhsYe4Ir8OXkJz9aGGOmpcaBmBiE3j6m55L4oq6e4btTJ7QJEdiimgfBisDP4dP+8qTeljLaHIAZ
	kQt9R4kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHK5S-0000000CJvA-2buT;
	Tue, 20 May 2025 10:20:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHJcl-0000000CFxj-0RSX
	for kexec@lists.infradead.org;
	Tue, 20 May 2025 09:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zTiw4lyKryoPf9LERb5T4xsi4Hrz2SvWTm/GDO7hgYA=;
	b=KxvOVO1avfrZenr0MY6jx8mw31gPj7OA9QWH/+NZXRB4JEx+tUrDyXjRZblZigcNd/Fx88
	V6pY1qv6g9HgVqM/xv3DHuwoTffahFw0xPaQww1IFYCrCAOHNx7npFCReLFvl09Ec8lgHb
	C8WfyvfOOa20JntZScuZ8pAy2TUmbI4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-EBEa1ORcNZKj7lzsiKH4Yg-1; Tue, 20 May 2025 05:51:00 -0400
X-MC-Unique: EBEa1ORcNZKj7lzsiKH4Yg-1
X-Mimecast-MFC-AGG-ID: EBEa1ORcNZKj7lzsiKH4Yg_1747734659
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23201f062afso23428915ad.1
        for <kexec@lists.infradead.org>; Tue, 20 May 2025 02:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734659; x=1748339459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTiw4lyKryoPf9LERb5T4xsi4Hrz2SvWTm/GDO7hgYA=;
        b=UWn/+IRNGNzGpwAH2psWI8uTyFNqGV4dKDTe12LrPoQE1rBncW/SF/GwhgsyW1ynIP
         SPy2hfWqNgXVkYzPQi7JqzRt0mYgGtc0v4pNPXTXvPw9pJK0DEjOZ0PFPKNJWPMfRhRs
         3ABODZJ9hsABaZB8aUlbRLO5n9vP5bUFH/Zrzyxd/v3xmx2BSmCqMLU7a15nU4/KrgQB
         tLib3Jyrx/1e2UyhbOhuBQ206irGRGIwBNIgPtj7dwO3R3Yj8BF8gqwpqsAes5texO+W
         vpgLa6Ol1KWQR9Tiu1RCuw9gLND2OmxoNuslHchYzo/xSj6cVoPW+P6TNsseMDGRkbow
         LdLg==
X-Forwarded-Encrypted: i=1; AJvYcCVnPBRvIJQcjcnfjDnFNrKCb9R0pxgmH4dxbDI77PpTF89TQw4o9Tbw4YjSHYniWT7wAgR/Ew==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVR06ZNOxFKqo3/DxNz0ZJnG0gtmveI3fbEA5wupms2oomSgde
	Hqslrpl9oJtEvfEz17T3xpFvxmrNB1rk2EPtcTbYzGi3l6lRczqY2rdCmIMsr+5Vrne10dm2XxI
	2GqJ7EITF4NZVRiKQl4iayMvbJ/i3E8QjXb4ZRxx+o5OkNgQ8N7WFPtf7sG0ITw==
X-Gm-Gg: ASbGncvGSQHTDdvJKQL0yAjm0C4rtpUMTIKxZt2XHU2ceeDQq7T3uHhPKNeBK91hTZU
	h0oH6Lv4Kt8jSI2lvKPDT3cIuLfSasCyM9DfmsF4gwEGwZgVOP+Kd3aXcLO3fWyUovqkToSfRNW
	x6nBNFNOKAof3hm8fFjMdcjZDxzPcg5aFFhEmg+SVNyT3BZPK26Wr23eeOcNX73meydORIUpaoO
	0RLVVewbQHmUaV/u2ZPeiOlo0ThUdQzwsA9s5DYYz7mjUxhXhBtlroNgE3i68YHZun2GJEdQBG6
	yPE=
X-Received: by 2002:a17:903:8c4:b0:232:1d89:722f with SMTP id d9443c01a7336-2321d8974ecmr137737495ad.15.1747734659361;
        Tue, 20 May 2025 02:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEno06e7jSgKAhzMm60z1T/aLIr0ix0aDT7+vIpT5BSIJlcRDdsZIfL1WhZTx/cthL8P9yHmg==
X-Received: by 2002:a17:903:8c4:b0:232:1d89:722f with SMTP id d9443c01a7336-2321d8974ecmr137737245ad.15.1747734658974;
        Tue, 20 May 2025 02:50:58 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebb121sm73239025ad.202.2025.05.20.02.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:50:58 -0700 (PDT)
Date: Tue, 20 May 2025 17:50:42 +0800
From: Coiby Xu <coxu@redhat.com>
To: Kees Cook <kees@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	fuqiang wang <fuqiang.wang@easystack.cn>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <g3zehuem3e4qqh3g7qfiquv2iwe52xo5z2pwrq3vaip2cpjche@nyjw4xbsf6vc>
References: <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
 <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
 <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
 <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
 <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
 <aCaycGEtgNvynjNQ@MiWiFi-R3L-srv>
 <202505161616.F4C1BCCF6A@keescook>
 <aCksAsgAw1jsGBL9@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <aCksAsgAw1jsGBL9@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _iQmiocsBtw4-QwOFpY6JBug63Wk6Pk9qCRaKPiHKy8_1747734659
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_025103_222217_1970BD85 
X-CRM114-Status: GOOD (  34.83  )
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

On Mon, May 19, 2025 at 09:22:30AM +0800, Baoquan He wrote:
>On 05/16/25 at 04:20pm, Kees Cook wrote:
[...]
>> > > I'll resolve any conflict between these patches. Before that, I'm not sure
>> > > if a separate patch to fix the UBSAN warnings alone is needed to Cc
>> > > stable@vger.kernel.org because 1) the UBSAN warnings don't mean there is a
>> > > real problem;
>> > > 2) both Fuqiang's patch and my kdump LUKS support patches fix the UBSAN
>> > > warnings as a by-product.
>> > >
>> > > It seems the answer largely depends on if the stable tree or longterm
>> > > trees need it. Currently, only longterm tree 6.12.28 and the stable tree
>> > > 6.14.6 have the UBSAN warnings if they are compiled with gcc-15 or
>> > > clang-18. Any advice will be appreciated! Thanks!
>> >
>> > I personally think UBSAN warning fix is not necessary for stable kernel.
>> >
>> > Hi Kees, Andrew,
>> >
>> > Could you help answer Coiby's question about whether we need post a
>> > standalone patch to fix the UBSAN warning fix so that it can be back
>> > ported to stable kernel?
>>
>> I went back through the thread and the referenced threads and I can't
>> find any details on the USBAN splat. Can that please get reproduced in a
>> commit log? That would help understand if it's a false positive or not.
>
>
>The original patch is trying to fix a potential issue in which a memory
>range is split, while the sub-range split out is always on top of the
>entire memory range, hence no risk.
>
>Later, we encountered a UBSAN warning around the above memory range
>splitting code several times. We found this patch can mute the warning.
>
>Please see below UBSAN splat trace report from Coiby:
>https://lore.kernel.org/all/4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at/T/#u
>
>Later, Coiby got the root cause from investigation, please see:
>https://lore.kernel.org/all/2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei/T/#u
>
>>
>> Also, referencing the commit would be good. I assume this is discussing
>> commit 15fcedd43a08 ("kexec: Annotate struct crash_mem with __counted_by")?
>
>Right.
>
>>
>> > In the case exposed during reviewing this patch, the code UBSAN warned
>> > is not risky.
>>
>> Given that this makes things work correctly with newer compilers, I
>> would say it should be backported to whatever -stable kernels have the
>> "counted_by" annotation. (Hence the request to add a "Fixes" line so
>> that it will happen automatically.)
>
>Got it, then Coiby can post a standalone patch to fix commit 15fcedd43a08
>("kexec: Annotate struct crash_mem with __counted_by") and CC stable, then
>post a new version of this patch on top.
>
>Thanks a lot for confirming.

Yes, thank Kees for the confirmation and thank Baoquan for providing the
context and links! I'll send a standalone patch referencing
15fcedd43a08. But I don't think commit 15fcedd43a08 itself introduced
any bug so I shouldn't assign a Fixes tag to it. It's commit
5849cdf8c120 ("x86/crash: Fix crash_setup_memmap_entries() out-of-bounds
access") which forgot to set crash_mem->max_nr_ranges.
crash_mem->max_nr_ranges should always be set to make sure
crash_exclude_mem_range will work as expected. If
crash_mem->max_nr_ranges=0, crash_exclude_mem_range will return -ENOMEM
if there a range split. So if there is no objection, I will include 
   Fixes: 5849cdf8c120 ("x86/crash: Fix crash_setup_memmap_entries() out-of-bounds access")

A preview of to-be-sent patch is available via 
https://github.com/torvalds/linux/commit/43c5a68f3d01b2e065cbb8686279224710cba682

-- 
Best regards,
Coiby



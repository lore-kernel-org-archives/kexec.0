Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47D606B1F9
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i+i8mf7Q;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=dvDaz3he;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tH8lv++p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f61a/DEp6A2hm2rkE7XwudvGQ0m98AaZhEeJm5iO0+E=; b=i+i8mf7QubcWJASgOtw4DzKIdp
	icMpMTnajAkZjVKfEQuqXc3sKY9tNqbD5Vbv7/8u+3nvO4IdUGQL0MsT2qasdeS/i1ozUW5ONHBf2
	z3b9JfD2mEv/87N4TnWGXdSHZzbITaUfXZcCmhqB21QN/r3hXeni2xxM3UYdvGrfegms4xj15+onc
	1BrzHJabphGh9nwiwTv7bjW7bl0sKYWyzol5ymshTNbk7h1hnBPUhnkbWKq3RANngSkeCkymb8Od6
	trpkiv978tiV6Koe8QLE1XDwEqx4rR0QF3XV66+0igD+pxBNydvhKm+ItA+7bFWkXgmu8x6NFEaZD
	bKPWmmkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRmgc-0000000C3z2-2UEN;
	Fri, 13 Nov 2026 08:31:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRmgb-0000000C3yQ-0IZQ
	for kexec@bombadil.infradead.org;
	Fri, 13 Nov 2026 08:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Message-ID:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f61a/DEp6A2hm2rkE7XwudvGQ0m98AaZhEeJm5iO0+E=; b=dvDaz3hePcdrQofY8+smaaF6rS
	TXEqyz7FJJV3btDMxzSd9wvyXHuvo/rTK5sUntv2kqnwg/FltVuuEXSr7ttl8HdFlGBso0MYkPzLM
	8j8zj0PY+qu9GGVMHUc1CsWIyuHzqH3R7sH8dYUiQ0WbBNNBSRAow4ISUBbrwaeeqRqMBajWBp8tz
	q9HIalY/DRsfOUEJBBvB/hUo1ht8ES2N/AkgqfVHC28mmtlrdXljvfePsClk9pbWu2ZTQq+83TzTv
	kRa6OxQ09mB9i31UF7Q6skS+FZwK/hYdLHQ8NcqeJuWcCjd8L3xE01E3kNdQorAr+IOVoU3FOV4On
	RihcDfsw==;
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRmgY-0000000B4OV-0cP5
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 08:31:03 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2e987a2ba0cso3417105ad.3
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794558659; x=1795163459; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f61a/DEp6A2hm2rkE7XwudvGQ0m98AaZhEeJm5iO0+E=;
        b=tH8lv++pBLGWuVuW5QAipxKLBCx7LD0rJAEmG/jODxilqVLx8uDGj3In/A4NLg/Y2s
         aHELU4DGYYHkw32+TZLH3X8i/YoMOhkEEXPjQpMSCO7tJvfvP+CEY7VBiOPHfgdIBSxt
         8uEZy4bIgTNfNYA2tWRH4wu7za/ynindebNAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794558659; x=1795163459;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f61a/DEp6A2hm2rkE7XwudvGQ0m98AaZhEeJm5iO0+E=;
        b=iMveKw0FNnkDdnHjGN3li+Ckna5+Q3je7l50xh7Nxy4p2IozBqpIFBi7azkiz9sHjo
         RACyZISOHp9TXakCNcxf/y/a1dpTQoIzYE5sDnhbAITk8jJ0E+6ORPy9d1gV+7QPyJeA
         kXfgJfXajibGO6mEIVV0QUh2PUTr+Qi+QfumyHZm6MOL8OKnR3ZzFc4nq8NEBKFFGJjK
         Yrf60NuAtLka7oD0pfQYBKtUn81s42RyRlnqGBt4qfXqmpEk6diq0fJv1yjJatzVd6vg
         wUg3eVh9/Ad7NwozPmydwo8hD67rQ2X3IxJd2w3q3SYrvIKio8K7X2bJFHGxB/OZjM+H
         /zAQ==
X-Forwarded-Encrypted: i=1; AL+hErE9mvE0o93ZceZ3iWBeZdaXW0VbE84xpRao+/d+dgJPxsdFn9Iq/l+GM+sU00nwRdQ6mBBRHg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8q6Be2RcTZdx7fnc1hBY8EcrOHJ76tEC5TZi7+goUYBbwFx/jl
	qh+gGBMdnZdauWSN8t5qmbItkEHtMxGWi03jpiZ1Aix1WEsl1yzFc3hfdkCxDoIBK2E=
X-Gm-Gg: AYBFou3ZV+4pNSSnMvn/pvBmUWq+2PHM3fjIOWlWmP2SSMzmXbruyDOkdfjQsuqrY52
	/ldX1ArxFkP0o7OXUHn26Xx1z9rJxIEEN9HiiR3R7Qs7XeRJkjGqrL5FJyVMItd94nwAjAGTX/j
	x1tb7Ptc4LyE183qaHy6cuKUUxDpEeSGshnNAZJU03Du5THpbKrYxdikBrFbmbnIpJSTltHasvr
	KTaVXgRjdMXIFdusKJPJFeFNvvO2wnSmrmbMcdC4/xdwVPIeDHF51k71vtww6STTbl0Of0AhSYt
	oZwyylrbeuQYYOnsBg+gLHTv54z4/OqJChJfs9b6ts8xacWT1nuiCKHNI8eCXmks1IsVS6Ge04Y
	qFr6wXk0HTxtIOVTvXvkIIzL4lLdZ3R+LTE78g0Re4B7aJJ9FjgxaoLTGATJt8dAwoe73QyLKKi
	4wHIPNPDCti5w/T4EWqk5dM7X3QiQgj6UJ54V75Z68nR6kRhOUnGHN4oBxvNPV5w/bnzwZB9g1l
	1iM0hgOVVW0izO2+b/5kO4/whgZusIb6tplaSO8WI54abXRdeKlY4vmhC+L3AQV6EyoO/OYggOA
	wsiu77EXdqXozq21GNQHO4Y0/1ku2T4lp+TVHW1S5VB2h0Aq4pPLMukqx6fbtnCqF1gKi4MrMwU
	w7fpWsofoGzkPcCmiWuaFd6yEaJvkxWNC9qNlhlA9RtdmFUA1npBWjjyWc/1aZIVVdicHbsHQ9I
	ngtcCTAYtqoWwBwDrAZvMvwBR7q30B0AA/JeTm1vmh+WRVxUf4tQZgNfviXX4=
X-Received: by 2002:a17:903:228e:b0:2e8:18ca:5f46 with SMTP id d9443c01a7336-2ee0da7bf97mr17781095ad.14.1794558659559;
        Fri, 13 Nov 2026 00:30:59 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f868217sm6442615ad.52.2026.11.13.00.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:30:58 -0800 (PST)
Date: Fri, 13 Nov 2026 00:30:53 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/9] kho: Reclaim the metadata page left reserved after kexec
In-Reply-To: <179443616043.2329176.17166425351392983946.b4-review@b4>
References: <cover.1794383544.git.chris@chrisdown.name> <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name> <179443616043.2329176.17166425351392983946.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113003053.1c951f5a678d35e3@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_083102_198670_DC60DD20 
X-CRM114-Status: UNSURE (   7.12  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.2 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pasha,

Pasha Tatashin writes:
>> Fixes: 76aa46b9e404 ("kho: kexec-metadata: track previous kernel chain")
>
>Do we really need to apply this to stable? It behaves correctly, and
>your patch performs a minor optimization by releasing a single page back
>to the system.

No, I don't think it's worth a backport, since it's only one page per boot.
I'll drop the Fixes tag in v2.

Thanks for the review!

Chris


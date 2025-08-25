Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCC7CA0EED
	for <kexec@archiver.kernel.org>; Mon, 25 Aug 2025 01:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EN6ZzdP3i0zcjEggG2p78XDuwapKqNbwvZSSMTRqchw=; b=1vP73ykRVPc0Fkisgr8BjhJWUC
	V4myo6X+dX7xHpdqNVs4TZYAPh3dkIL6tqvVeBwfIBfUotZqgf6f6E1XDU75lfxVedtEPRS7+ZWSz
	tZhfyTMq+kp8Wblx3mqSOLkswGBluSDTOKpwemIgf+XNK4nH2Q53b58zBrKkz0BYIfzk5IVCfBQYQ
	Had9TY+xSsiVoM89XVClsTWOmD5FOEhGoxSk7lJdZDUStPvqO2EbYg1zk6Q0SnS8tN/P19syiZ3vz
	AarbJedEP1Wmj0J7d6UZdf8JEKjcYe4naXljuQ6CCZGXm5gUIojkA6orJ8+rLWc+8hUAV8qWVfMDt
	qnbk2tIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqLtV-00000006g7a-3jSA;
	Mon, 25 Aug 2025 01:21:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqLtQ-00000006g6j-2qNQ
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 01:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756084861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EN6ZzdP3i0zcjEggG2p78XDuwapKqNbwvZSSMTRqchw=;
	b=fv8poAOP09ePEOam6WkJGJ4hNWiI150mce3H47cnYXSugmppI2tFBUBrp5qKWsIwiHEKoC
	9BorRQ0ro6RjTIVBDvdBAh3CzjIrOWItGyVmYYWMeGJ9cM3JKiFNKTFNtjDQ9Dl3rLNVZC
	0wi4iMJZaNfJHBM7VIWPRwTUUh/mMeQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-JPYJJhLIMwWAMeSLnV6KJQ-1; Sun, 24 Aug 2025 21:20:59 -0400
X-MC-Unique: JPYJJhLIMwWAMeSLnV6KJQ-1
X-Mimecast-MFC-AGG-ID: JPYJJhLIMwWAMeSLnV6KJQ_1756084858
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b474d5ff588so2963316a12.2
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 18:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756084858; x=1756689658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN6ZzdP3i0zcjEggG2p78XDuwapKqNbwvZSSMTRqchw=;
        b=e/bDG0aS1nGZrfMmmxIoJFYea8CT+MrpjXdV49AW57Icu4yDGhRZcdZLghJDu9uh/o
         56EgUnwRTpVFkJ0zndF16Hf3ugoQRfG53mB5Pu2+AYBLT0l2Wn2qsZC+RBb5tYWTq45j
         dnV6B9Q+7UYVfzNZXFZMqAUY/yumHBelqtLEBDvEDpxzMp8v8dVAx17WYIPB84X1stx2
         +7U/9+2jVYUTVllDxQrTZHw+zIABVL0uvwpw1rdExu8ZLjC2SJtGCozz+1yPlgb4P7OP
         3kwmlc+8w5BEyoTaUIMCWu26SC8YYvivTVJCcm/7M9tblP12E3o7g3ZgNWYeYHt5lbf9
         GsPw==
X-Gm-Message-State: AOJu0YxtXWew9WuS83Bu/A2NCXfTiJ4C5dC6FkmooPX4LBj1IYCOTeQi
	/BuqZKCdOWC39Y77PByYTeUQgsrRq4InIIO7r38VJqoDuPMwWD5/AEFQq+3V8HA1VWLbjTdb8rM
	kn1OXV9BArLXUpCX9dh4CA4aRjXAdGclN6Bh4yWaoQKchmY6vDOSdMoXVho+1xA==
X-Gm-Gg: ASbGncuMXFeSSw+16vHav4pOuGD7462/lJKCG1OPj9J7i7TuUwif3mmtE847GJ064Yc
	OlGxo79M75kc7wONlTD1Yc1oZIDBhB8e1vyRfElAymN6C9uxpW0gYw9nNpxrCvf1815+GEQ+aJt
	Imdg6NJsHtD1eIVhybkidPEbT/Bi9oGnANquNe++3T0SbLyjIJiHs3Em0sVMAWPg0h3PtP2C8Nr
	BEeTLp3OjnYyjVszuyL0YMPBDnLp97gxHmJQ5/CxE5h58WgA2dS+VFEIM3ygJ3b95hemLhCd8m4
	y0YK75xEyjHGu3hHYrIT8xaS8m8uK90=
X-Received: by 2002:a05:6a20:7d9d:b0:240:387:cee with SMTP id adf61e73a8af0-2434081ccd3mr14767780637.0.1756084858449;
        Sun, 24 Aug 2025 18:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ52vj5/0XeOFHIZn6b33Fi9CgvtFLe7y13b+QMfcBUf40D3kWJXZtVu67hRZNEFoDn1nUGA==
X-Received: by 2002:a05:6a20:7d9d:b0:240:387:cee with SMTP id adf61e73a8af0-2434081ccd3mr14767754637.0.1756084858035;
        Sun, 24 Aug 2025 18:20:58 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb98e8asm5143369a12.38.2025.08.24.18.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:20:57 -0700 (PDT)
Date: Mon, 25 Aug 2025 09:18:53 +0800
From: Coiby Xu <coxu@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-ID: <yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-2-coxu@redhat.com>
 <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
MIME-Version: 1.0
In-Reply-To: <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4-0e_NL2KCCJRmbkRuK-DHijUBu0wynJOcZ28jOyirk_1756084858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_182105_132231_7EADCE14 
X-CRM114-Status: GOOD (  20.27  )
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

On Thu, Aug 21, 2025 at 04:15:53AM -0700, Breno Leitao wrote:
>Hello Coiby,

Hi Breno,

>
>On Fri, May 02, 2025 at 09:12:35AM +0800, Coiby Xu wrote:
>> +static inline void kexec_random_range_start(unsigned long start,
>> +					    unsigned long end,
>> +					    struct kexec_buf *kbuf,
>> +					    unsigned long *temp_start)
>> +{
>> +	unsigned short i;
>> +
>> +	if (kbuf->random) {
>> +		get_random_bytes(&i, sizeof(unsigned short));
>> +		*temp_start = start + (end - start) / USHRT_MAX * i;
>> +	}
>> +}
>
>On arm64, I am getting the following UBSAN warning when accessing
>kbuf->random:
>
>[   32.362428] ------------[ cut here ]------------
>[   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>[   32.362649] load of value 252 is not a valid value for type '_Bool'
>
>and line 210 is your `if (kbuf->random)`.
>
>Basically kbuf was not initialized in arm hosts, and probably has
>garbage.

Thank for explaining the problem to me!

>
>I am wondering if we should have something like , while the support for arm64 is
>not done:
>
>commit 2608bd8c26b62a9a7cc50106e93d3a1ffb1e1188
>Author: Breno Leitao <leitao@debian.org>
>Date:   Thu Aug 21 04:11:21 2025 -0700
>
>    Initialize the random field of kbuf to zero in the ARM64 kexec image loader
>
>    Ads an explicit initialization for the random member of the kbuf
>    structure within the image_load function in
>    arch/arm64/kernel/kexec_image.c. Setting kbuf.random to zero ensures
>    a deterministic and clean starting state for the buffer used during
>    kernel image loading, avoiding this UBSAN issue later, when kbuf.random
>    is read.
>
>            [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>            [   32.362649] load of value 252 is not a valid value for type '_Bool'
>
>    Signed-off-by: Breno Leitao <leitao@debian.org>
>
>diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>index 532d72ea42ee8..287b25e674d76 100644
>--- a/arch/arm64/kernel/kexec_image.c
>+++ b/arch/arm64/kernel/kexec_image.c
>@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
> 	kbuf.buf_min = 0;
> 	kbuf.buf_max = ULONG_MAX;
> 	kbuf.top_down = false;
>+	kbuf.random = 0;
>
> 	kbuf.buffer = kernel;
> 	kbuf.bufsz = kernel_len;
>

And also thanks for posing a fix! The patch LGTM. Can you add a Fixes
tag 'Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf
randomly")' and then send it to kexec@lists.infradead.org? Thanks!

-- 
Best regards,
Coiby



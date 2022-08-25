Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD5BC04AA5
	for <kexec@archiver.kernel.org>; Thu, 25 Aug 2022 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:
	To:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RcUYxhI04+82B+JaVKaajh81y40mOnFKv3JLkgraYVk=; b=Jjmx6NjGrIC9CR
	Gdz7ImBiUM0kDCOeV2gE/jsBBjp68T62ZGyUJ5KInwO7ew/AbaaSfElPDoxLlpFa4MgrZQx2wKOGg
	JvWrLEpZde9VuILt23lTHkNAt2+4CSykTVoJ28x4x1HSoi+SXRID2mz1TjFaVEB9IO8RPmZdgXCJw
	i8zvDu3l4WmTPaEuyaQrXsiFxTpmlSUhpyzT8Bt7ttZOKp10/HRy8accREYVGXKulFQyS/7yTQmKG
	p4Wha6pWyJ1D8RtLW0LOEaMlwgwp9UqKr2RUMUqFhu8IvtQqA27RWRVVluv0WT5So3mve16FU7h3M
	65jNLSggHQ7fa7fPKaqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBjJ-00DWCB-Bi; Thu, 25 Aug 2022 12:13:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBjF-00DW7x-C7
	for kexec@lists.infradead.org; Thu, 25 Aug 2022 12:12:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661429575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8i+ljzn6MB/eBmFGfmQrAmtwmX21MBronF2Ff991Uq0=;
	b=SzinkmFmGkFc2ydu1HNk8I0qNFl+wl9dskglRrHNNvvY57smqMXlCeoj9zAmKpSvG2xKWh
	tLmRrt5hTsZeg/taYVBsdlli2xhq5tQf/X/p1nFf/Wb+EQpyP6mc4cCW4MguaR7yIECbBB
	nOcskuJr7UAaqQHy2NfG6qwMAAmamfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215--UTtQG-BNH67y-E_IGo9jw-1; Thu, 25 Aug 2022 08:12:54 -0400
X-MC-Unique: -UTtQG-BNH67y-E_IGo9jw-1
Received: by mail-wr1-f71.google.com with SMTP id v17-20020adfa1d1000000b0022574d4574aso740567wrv.22
        for <kexec@lists.infradead.org>; Thu, 25 Aug 2022 05:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=8i+ljzn6MB/eBmFGfmQrAmtwmX21MBronF2Ff991Uq0=;
        b=FT9alGi5A+jSPgPyCDgJKsnxDrL/hDhLm2Bu/P78ucaZvjJj8oXsXFO2/02Nd4bK9C
         1BYV8vJTfvMJi7KcZ5IdCkM3oCwEFyzp409kBCDVPHKyceLNo6iqBoRoqhynyAXo043W
         JaAQUMmp4pTkEBLBjNx2cLZ3d1vjPB9vm2mB6cj/Oze9825HyObdyCrmmhm/9Np62G8f
         lWpG/Sq4FGX3F/aQFHvw26/1SBg0wX/TeG+3WQ1dWXIh3qer4dS3PdkvjynADkwsUmz1
         iDpDjLHtXmmY1HtwdUfCx4gw9h6EEX054duUQ28H/OpM7bKMUF5tpjX+mPcmWn2k0P3C
         fsJw==
X-Gm-Message-State: ACgBeo3X9n9e8FUADndWxOO/EJiNp41PMRTIbi+VWmmzyu8/rbsmyWxf
	vAMB4MWPxgKAu7FRqhztJYDFFHCUug+Vb13ohra09APUktRVDmYEjpReSUOX+rDC4T6vXzKUaQx
	PTpPIh7+1oIiHIa0YQPi1
X-Received: by 2002:a05:6000:250:b0:225:624b:13 with SMTP id m16-20020a056000025000b00225624b0013mr2006735wrz.127.1661429572666;
        Thu, 25 Aug 2022 05:12:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4XU9Thjdw3dtY8hDYFZgZjn5H98wAmkQlzCVmgXAIYgtj8pToIYo+QGnxLFtQp8Qh/i6f5kw==
X-Received: by 2002:a05:6000:250:b0:225:624b:13 with SMTP id m16-20020a056000025000b00225624b0013mr2006717wrz.127.1661429572383;
        Thu, 25 Aug 2022 05:12:52 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003a601a1c2f7sm5259554wmq.19.2022.08.25.05.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:12:51 -0700 (PDT)
Message-ID: <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
Date: Thu, 25 Aug 2022 14:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
In-Reply-To: <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_051257_522531_18B66A25 
X-CRM114-Status: GOOD (  29.43  )
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

On 24.08.22 23:59, John Hubbard wrote:
> On 8/24/22 09:30, David Hildenbrand wrote:
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index 03eb53fd029a..a6d81ff578fe 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -1186,6 +1186,33 @@ expression used.  For instance:
>>  	#endif /* CONFIG_SOMETHING */
>>  
> 
> I like the idea of adding this documentation, and this is the right
> place. Naturally, if one likes something, one must immediately change
> it. :) Therefore, here is an alternative writeup that I think captures
> what you and the email threads were saying.
> 
> How's this sound?

Much better, thanks! :)

> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 03eb53fd029a..32df0d503388 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1185,6 +1185,53 @@ expression used.  For instance:
>         ...
>         #endif /* CONFIG_SOMETHING */
>  
> +22) Do not crash the kernel
> +---------------------------
> +
> +Use WARN() rather than BUG()
> +****************************
> +
> +Do not add new code that uses any of the BUG() variants, such as BUG(),
> +BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
> +WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not required
> +if there is no reasonable way to at least partially recover.

I'll tend to keep in this section:

"Unavoidable data corruption / security issues might be a very rare
exception to this rule and need good justification."

Because there are rare exceptions, and I'd much rather document the
clear exception to this rule.

> +
> +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
> +**************************************************
> +
> +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it is
> +common for a given warning condition, if it occurs at all, to occur multiple
> +times. (For example, once per file, or once per struct page.) This can fill up

I'll drop the "For example" part. I feel like this doesn't really need
an example -- most probably we've all been there already when the kernel
log was flooded :)

> +and wrap the kernel log, and can even slow the system enough that the excessive
> +logging turns into its own, additional problem.
> +
> +Do not WARN lightly
> +*******************
> +
> +WARN*() is intended for unexpected, this-should-never-happen situations. WARN*()
> +macros are not to be used for anything that is expected to happen during normal
> +operation. These are not pre- or post-condition asserts, for example. Again:
> +WARN*() must not be used for a condition that is expected to trigger easily, for
> +example, by user space actions. pr_warn_once() is a possible alternative, if you
> +need to notify the user of a problem.
> +
> +Do not worry about panic_on_warn users
> +**************************************
> +
> +A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> +available kernel option, and that many users set this option. This is why there
> +is a "Do not WARN lightly" writeup, above. However, the existence of
> +panic_on_warn users is not a valid reason to avoid the judicious use WARN*().
> +That is because, whoever enables panic_on_warn has explicitly asked the kernel
> +to crash if a WARN*() fires, and such users must be prepared to deal with the
> +consequences of a system that is somewhat more likely to crash.

Side note: especially with kdump() I feel like we might see much more
widespread use of panic_on_warn to be able to actually extract debug
information in a controlled manner -- for example on enterprise distros.
... which would then make these systems more likely to crash, because
there is no way to distinguish a rather harmless warning from a severe
warning :/ . But let's see if some kdump() folks will share their
opinion as reply to the cover letter.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

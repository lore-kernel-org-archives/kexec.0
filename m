Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9ADC7EE29
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cvvhVYIGX3VRrwh0ph9oLA91G3N/OkpEF2QF3VqFGo0=; b=BPJ2c9a9jSDUOp
	0DJVc+4D07cERfAQd1z/C9Njaq69A+pEm2e74QdG242H2UpbLAeDLrGC+fecYwCRHbXUecYPrQdW1
	kU+XZkfNT8mf0yBtLh0rj+nZlpkBHuwIs0lfc2lD5OS+oQa3daFXe/2r2VaJlO3VsB3sOveJ5jU2e
	eSxKjspe/hVBTpN8GruLUGCRR9jr9wWw2dtGzSpHt48WvsE1Fitayjbv+18vEyu+DtVNjn5SW2gcI
	Ls61eVBwKflQtOW7P7aVXU/ICCDVOG4SHZmOKguobugrAidmU3eHnxaw8lAn/p7xkzlSbf4xM5mi4
	wLW7eHvCb2B09vNX6Czw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7D3J-008tTc-0T;
	Thu, 08 Jun 2023 10:39:37 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7D3G-008tO3-0G
	for kexec@lists.infradead.org;
	Thu, 08 Jun 2023 10:39:35 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso642790a12.2
        for <kexec@lists.infradead.org>; Thu, 08 Jun 2023 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220769; x=1688812769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wgec4tfIWdnEhpMr6ykg9xNvcCtcxWUQ6Om3tn4cEU=;
        b=Jzu6MtqgjH4ZproiCgJgfX3WoIOd9YRTOe+yXyjdFcEaO+nd7lkAaB8Yjqrko+keSC
         /yacB0AffOxXZuZIVJe3FLLrZS/P9rVZoFIh8usEjaPdcNVjIf1rAMNTJGXkrf+sl5Nd
         GLRuFtKIt5GHSnGdU6jpB+DqUmjw5r4IdUqCTSJC2dF787mZ/u4vZVNgJzurEvPDkoXG
         RKdeiRVKyvg73DiVVZpbD5ZR2Z77Wd39/d9u0XIltYqA5GN0XoBznZ7a03LkIFu8pbse
         l2Dn3oAY5hueFhsldblYXjKgJhkaPvmV6cd9PyYS5ZIJ4Z2mAWAve6fqSkJ0Yxerrnk5
         juMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220769; x=1688812769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wgec4tfIWdnEhpMr6ykg9xNvcCtcxWUQ6Om3tn4cEU=;
        b=ai6SbYN5DyWSPbGIj4CXAzNE8J+LYWsU5MTx0O/xJa4siuj2j41Zn2G7Ye5fkhlgFk
         xjW8+QB5Q61FF29sStE9vtTT6RIQNXOXIgBsFRXC8FqF7Yda44eKdUAsnMl3nAhs7+0t
         tu+kx/g+r0muATIDHHIM+dVg85J2b6A5diJBW6ArR0TAQ/7PEA5BWHeyzw+/8MTw6UM/
         mde/gZFAXPGo2U1oYHYRXl054SuVgr5CtmMm07HvuzDMzAWY44vux5p8ja1p1TjjBh1S
         bpjgdLN/tCvAuQfLVxU3TKQjNASPNpknremq7MJOrP2uZQgupYnrj1EBFXXpO5NvM58Y
         XcUg==
X-Gm-Message-State: AC+VfDwSh9y72lZbk9H4xTVTEAPVC7Unhl1H6EDQLCF0yo58KJbaCtXF
	+JNriU/To1dWmoWIaDxtMqE=
X-Google-Smtp-Source: ACHHUZ4ytm/M/a+Iwv6nZciUDlVTlAht7v/lQ5uBsyjdfFH4TWUuLUvl3T6ueNXwjFKIgWOf3yY0ng==
X-Received: by 2002:a05:6402:31ef:b0:514:8e14:7f1b with SMTP id dy15-20020a05640231ef00b005148e147f1bmr6910012edb.12.1686220768883;
        Thu, 08 Jun 2023 03:39:28 -0700 (PDT)
Received: from [147.251.42.107] (nbbroz2.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c50b000000b00516a1fa0e60sm384205edq.89.2023.06.08.03.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:39:28 -0700 (PDT)
Message-ID: <f7a1a20c-bee8-c7a4-4c49-b66415f556f9@gmail.com>
Date: Thu, 8 Jun 2023 12:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Content-Language: en-US
To: Coiby Xu <coxu@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, kexec@lists.infradead.org,
 Baoquan He <bhe@redhat.com>, x86@kernel.org, dm-devel@redhat.com,
 Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Kairui Song <ryncsn@gmail.com>,
 Jan Pazdziora <jpazdziora@redhat.com>, Thomas Staudt <tstaudt@de.ibm.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Dave Young <dyoung@redhat.com>,
 Ondrej Kozina <okozina@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
 <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
 <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
 <88581a3c-8bd3-f7b2-064c-c809a2152ed3@gmail.com>
 <maamg4udo7visvgzp4m4qkfcds6djyiga236lb2mwtjasi6pvj@zmqzb2lijegj>
From: Milan Broz <gmazyland@gmail.com>
In-Reply-To: <maamg4udo7visvgzp4m4qkfcds6djyiga236lb2mwtjasi6pvj@zmqzb2lijegj>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_033934_141242_80B56E60 
X-CRM114-Status: GOOD (  20.29  )
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

On 6/7/23 14:39, Coiby Xu wrote:
...
>> I do not think you need any cryptsetup patches, all you need is to write
>> decrypted volume key from LUKS metadata with
>>   cryptsetup luksDump ---dump-volume-key -volume-key-file <out> <device>
>> (or any code equivalent with libcryptsetup), am I correct?
> 
> Correct me if I'm wrong, but I don't think there will be a safer way to
> preserve key without patching cryptsetup. Actually the --dump-volume-key
> approach has been proposed before and I agree with your conclusion [1]
> on that approach i.e. "passing volume key this way is quite insecure".
> Without patching cryptsetup, even if I save the volume key in the memory
> reserved for the kdump kernel, I need to retrieve this key in the
> userspace to unlock the LUKS device which may lead to quite a security
> vulnerability.

Hm, where are the patches for cryptsetup, then? I am afraid we do not want
to add such specific things there.

But we are just going to merge a patchset that changes how we use keyring
where you can tell cryptsetup to store/link key under some specific name
and to specific keyring
(see https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/492)
(Please talk to Red Hat cryptsetup maintainers for more info,
I just mentioned this mail to them today.)

> I respect the efforts from you and the cryptsetup community to make LUKS
> as secure as possible. And kdump is used in product environment. Kdump
> is to a server as a black box is to an aircraft. So by no means I want
> to reverse the used security measures and patching cryptsetup can allow
> to keep the security measures. One concern raised by you against "FRC
> v1" was a copy of the LUKS volume key for the kdump kernel creates an
> attack vector. I took this feedback seriously and have sought advice
> from my colleagues to implement the countermeasures ([PATCH 1/5] and
> [Patch 4/5]).
> 
> [1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/

Yes, I appreciate that. And it is perfectly ok if your customers accept
the trade-off and security risk of handling the key this way.

Anyway, I feel we are going in circles here, and as it seems to be my fault,
I do not want to sound grumpy as I am perhaps missing some context.

Could you please talk to internal RH cryptsetup maintainers first and discuss
your solution? They know what we can do here can help to find an acceptable
solution. (I added cc to Ondra.)

Thanks,
Milan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

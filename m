Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B86C7EE23
	for <kexec@archiver.kernel.org>; Mon,  5 Jun 2023 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P/cegld0ODID3OHu6mpsYLAN1OaGPcB7flI88t2pIow=; b=ZERI3YgBjt9F7K
	w4OfcfoDw0qyFwV8b6J+lFZ1QqhxjQSrtrfBDc8CoixROl/A/km3W8w/5DXw1lMKG5pD9h+cSYHwd
	oOBVNOyXhf1ww+LR0s7vl4/krPOpDnBgXKABLYbI/BrxFW+ZK0ID7OW37XtL6CZFzaeR9SDBV0c4r
	3mITvZB2pxRRtQheCILnmoAfeeRXjkvdHmUlS9EUiRyoBoxJaiCAuyK1quXK/3+26Y7a2P4oXuTf+
	nAxfzJkQu3MzBMxK4UxdsbgDoMYEqTvTARID+f2oBtF1S68McO4nDAQ9OQLoofMLyFbB4PrCmDNI4
	DSHnycMzsCRC8IBEmajg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q64Lk-00EVNT-31;
	Mon, 05 Jun 2023 07:09:56 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q64Lh-00EVMM-0h
	for kexec@lists.infradead.org;
	Mon, 05 Jun 2023 07:09:54 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so6894988a12.2
        for <kexec@lists.infradead.org>; Mon, 05 Jun 2023 00:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685948991; x=1688540991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40CnV0seHNA+3J+ZtxxY5lWq8+DP/bF+vwPGX6memA4=;
        b=nQjOn8M6P984wlmWjWHri0pDo+/njmcKrLFh66hG0uR6pU7+aTHjw36bUCRinAxJii
         KbN3vxAxQMp3KiIyTnDQ/rTQTJZqn6YD7UMNlbPdL+9Np2mqiZU7dfYcVfVNOjHt7TC7
         Sj26M8ZF2kraEKuMLqCzPxbSDwvMk7zuzYhWnUxNEqf/TX72tiT0VtqfxeWfYR5nEvaW
         9ZskfIiLmy0GivRZ36V1afjVWrN7LpyEQGfWq9m7a/zN0/f6bTFSq7NkhsIcjhTvBsdu
         ylVE2XTULgISjxu6NhkgbFzojQhE0qDGaINB/O2Q0HjbD1FFberFqTUCk8UlMuYH59sM
         +gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685948991; x=1688540991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40CnV0seHNA+3J+ZtxxY5lWq8+DP/bF+vwPGX6memA4=;
        b=Bc28h9pEOxQ0+mFr1ScQQsFl9+Q6LtohkTehdpfXPay6rqyN2T1U/VtvK6VBx309mU
         cbJpCvAvUjnoZffaOmrS7Fz81fIrRbvyK2s4ODm97Q/yy8C2MOXXKmBKP+mP+cLTBlzp
         8zKf/ghCxO0J7Qs3wh/I1mnzlN9iwKdkVGv8ToSbhWd3FCyU5M2VJ4mffCSORqnlLTvR
         t02RGa4fYC+C4rFxmiXfA4+AF/kcZReIEWe/L2z2V9sGHmtBHeFQMFq4Wct0UII9zEyl
         ZcsUlWo7eBML58p9Ko0oKyCJgoNNj5RrzuMaW1Fjh+Oifrdg7A0e4bWP697RLTAW7n/D
         dUag==
X-Gm-Message-State: AC+VfDw1FikzmWzSe2o37Htj9SPWdod8mamWKiQERS5Q+otDGxgZ1HzZ
	IYh7AWFN127iLfC9H0YnBDo=
X-Google-Smtp-Source: ACHHUZ4avov38OYLaR3Bj09ogtbzgAw+IJvsxh/+I2jNWLZnteyosL/g2MigG3R1N70vvHtsLvmoLg==
X-Received: by 2002:a05:6402:659:b0:516:642e:f92b with SMTP id u25-20020a056402065900b00516642ef92bmr783879edx.1.1685948991066;
        Mon, 05 Jun 2023 00:09:51 -0700 (PDT)
Received: from [147.251.42.107] (nbbroz2.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id b13-20020a056402138d00b00516654bf182sm334943edv.41.2023.06.05.00.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 00:09:50 -0700 (PDT)
Message-ID: <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
Date: Mon, 5 Jun 2023 09:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Content-Language: en-US
To: Coiby Xu <coxu@redhat.com>, Eric Biggers <ebiggers@kernel.org>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, x86@kernel.org,
 dm-devel@redhat.com, Pingfan Liu <kernelfans@gmail.com>,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>,
 Thomas Staudt <tstaudt@de.ibm.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Dave Young <dyoung@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
From: Milan Broz <gmazyland@gmail.com>
In-Reply-To: <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_000953_253964_A933D794 
X-CRM114-Status: GOOD (  27.25  )
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

On 6/5/23 04:31, Coiby Xu wrote:
> Hi Eric and Milan,
> 
> On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>> On 6/2/23 23:34, Eric Biggers wrote:
>>> On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>> [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>>
>>> The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>> happens to use.  But LUKS is a userspace concept.
>>>
>>> This is a kernel patchset, so why does it make sense for it to be talking about
>>> LUKS at all?  Perhaps you mean dm-crypt?
>>
>> Exactly.
> 
> Thanks for raising the above concern! The use cases like CoreOS and
> Confidential VMs explicitly want kdump to work for LUKS. And correct me
> if I'm wrong, I think the two problems addressed by this patch set only
> apply to LUKS so the kdump part of the kernel only cares about the LUKS
> case. If there are use cases where similar approach is needed, I'll be
> happy to make the solution more generic.
> 
>>
>> I had the same comment almost a year ago... and it still applies:
>> https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>>
>> Anyway, please fix the naming before this patchset can be read or reviewed!
>>
>> LUKS is user-space key management only (on-disk metadata); the kernel has
>> no idea how the key is derived or what LUKS is - dm-crypt only knows the key
>> (either through keyring or directly in the mapping table).
>>
>> Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
>> is used in many other mappings (plain, bitlocker, veracrypt, ...)
>> Just use the dm-crypt key, do not reference LUKS at all.
> 
> Thanks for the reminding! That comment was on the first RFC version. But
> starting with "RFC v2", there is no longer any interaction with dm-crypt
> (to save a copy of the LUKS volume key for the kdump kernel) and now I
> make cryptsetup talks to the kdump part of the kernel via the sysfs to
> reuse the volume key. So only the kdump part of the kernel needs to know
> LUKS which is what it cares. Thus I don't think there is any kernel
> namespace pollution now.

Hi,

I am sorry if I did understand correctly, but I thought that kdump is part
of the kernel.

I am trying to say that kernel generally has no concept of LUKS;
this is a userspace abstraction for key management.

Even the cryptsetup dm-crypt configuration mapping table generated from LUKS
has nothing LUKS special in it (only in DM-UUID as a name prefix).

So I do not understand why you need to mention LUKS even in kdump part.
Perhaps it is still only a naming problem, nothing more.

All you need is to preserve key and configuration parameters (for dm-crypt).
If it is set by cryptsetup, dmsetup, or any other way is not important - on this
kernel layer, it has nothing to do with LUKS key management metadata.

No problem if you support only LUKS in userspace, but really, all this machinery
should work for any dm-crypt devices. Perhaps your patch even works for it already.

Milan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

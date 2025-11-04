Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F40CCF9E3
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 11:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-version:References:Message-ID:Date:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ab6XclKIAeufIonZjTLz/qxdfnGFmorsfm6jfN5F/GU=; b=2Gri+zBu4Lm16I6aYFhtaJl7LY
	vN1AFxCewS+BLdBug3PtIhlXj3G3Lnv8YfKwbDUKqxEHB52Tb4CN+vzh1vC0xSY+vOe/ZO4mn4TfJ
	TnvdymKVef8CbGuBcZyhI+M/bPo+9kIDLNm09SkSCN9Cl6NZlrAKkuLtUbGObLU7bDEGerJbKWC+a
	jXeN64eUmaJM6wN/54o5t0REs2xVpv/t+bOO+QfUORHBfJxqDpdCUscvdXXjHHOzfqMa1kAMejap5
	7CHZ+KZHx2qTFqHoqJjh1mZDApiDpm8rWSxP0wBNX0yKp5MOCXo2VQk+x05hv+E93iQZFN5MBdwTH
	RZe8Emgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEn1-0000000BgCL-3lkq;
	Tue, 04 Nov 2025 11:01:27 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEmz-0000000BgBz-26L5
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 11:01:26 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3401314d845so7198901a91.1
        for <kexec@lists.infradead.org>; Tue, 04 Nov 2025 03:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762254084; x=1762858884; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab6XclKIAeufIonZjTLz/qxdfnGFmorsfm6jfN5F/GU=;
        b=LoXwfEmjHtjYLK+dSVh1ezs/WM7nJMU8IksIKoaaKtVoWmRyhNyjiIV9OHyxJSN1U6
         LxJSqIxifyBceIwSAL7RYc3lN1YpBIxVoMunUZVVzIH/PjK70vdWm3seRVvG9DJUB+b3
         qq8WbKVDWuoLw5liymMSHRsYRwaiKuJWlF2LL8soUtjxdr7+1wAKx4J2hVQDTNpkcRFu
         Oion/ZncBvZLMCAO2Yo+Gl+ZVwAy2pgqLNsrcogciCHx84/1CokaieN68uTAEP+VJ8cS
         5Ie7Wd5rm6k92mY4Rotsh9FqEQVcDT3Fbp2DaMtn05JKzGF98UyRfWboFKArqz58DANz
         WZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762254084; x=1762858884;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab6XclKIAeufIonZjTLz/qxdfnGFmorsfm6jfN5F/GU=;
        b=wzGtwCukdhS9rscpGokbdw+2DPHVbC8DyvHFYGoLIyPqByn5Sn0G7Mk/Hf4CiNU/9M
         T4oYqLRvOsB/cKzG61d0ijLoFtKSOlZS4VFYHirJ01jP/55YsLOjoeyqwaaVI/QQW07x
         ja+doE3frI7fd79N8vkLsmv9S+lIR8y5+Yv7XZO90oFiToOsnejZTFC/2PRwP7NzVvXf
         6kMkFLmWDtmBjrEcnFtvYab1YGqiHgeLgWDkA5+/GwkoeU9Sfc+vLE6mi4Sf9Qdf5HoZ
         o7fKB3tzZiNZjgXcGKn6+WWanOYFInKS7VjElTlCDrGCMDQaI8NyhH//Ie3aaDmH93IA
         L2vA==
X-Forwarded-Encrypted: i=1; AJvYcCUH7Ih7A2FVKFhrQwadbmtACVskm/0LibSFYxjtgo2/r1Ge8wnPCltxOIP8NCNh3+0b7OJ36g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzPcgljAgG5LA4fqkrAmQyqMnoIzKHakg8ejQshSSJ/6PgrbOE7
	RyemSCM1O0+X/bQK7O+xfOjj1ZgfPpzs0JmlIkoR36zzEKHF0f9l6AU8Z3XHCLRf
X-Gm-Gg: ASbGnctHeMfMMy5uqTQG30hbuFf81vxWaTaILAsnmhwmX7zy6bp1gGXphSSXWBbm/f0
	eOG8ubbzt8NCXgXpbzl2hc+PgGYn8Sn20u0I8C3/QHRaYpTSEbV5DuRLP+rUV94CYHCMCUXnkvp
	88DWc7hF0AoJarHS5Skb2SEVXoaEEdi1bf6DoQI2ewhAl30iv0ZdZJTkKLOjNS4jnlgjaSCyASf
	Y5jzOevvI45qYdjdGoiEoZnl7apE6c0gguW1eiAlho5uKJGJy1NcSBqt7ixZwtIYS5Ca04sg4DN
	SAz35mrX/AsoU27wIsx1RGQM/H4/LjdCus8bJ3qeJqqOx3nrBNppuymCiseGoX6aVQW46lwuXwa
	lAlFs2MICzWIEer/1V5Rjyk4vHkMIN5KSkqxk2oRqeSBQOi9ZtzILLTt+ykmZCZkbWj44hA==
X-Google-Smtp-Source: AGHT+IFhUFljNIpr0jYIPpg9DdgdyO4OfzVThDxcWuiPhHq2YUsCvhITskWN98lDONqYdPsc2uu0Gg==
X-Received: by 2002:a17:90b:57e5:b0:341:3ea2:b615 with SMTP id 98e67ed59e1d1-3413ea2c334mr7908860a91.15.1762254083595;
        Tue, 04 Nov 2025 03:01:23 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm4191556a91.18.2025.11.04.03.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:01:22 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Baoquan he <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v5] powerpc/kdump: Add support for crashkernel CMA reservation
In-Reply-To: <722d72b5-cebf-48f2-8ad5-558ccd3c30f4@linux.ibm.com>
Date: Tue, 04 Nov 2025 16:21:41 +0530
Message-ID: <87tsza3waq.ritesh.list@gmail.com>
References: <20251103043747.1298065-1-sourabhjain@linux.ibm.com> <87y0on4ebh.ritesh.list@gmail.com> <7957bd55-5bda-406f-aab3-64e0620bd452@linux.ibm.com> <87wm463xtj.ritesh.list@gmail.com> <722d72b5-cebf-48f2-8ad5-558ccd3c30f4@linux.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_030125_563072_D505FDB3 
X-CRM114-Status: GOOD (  14.98  )
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On 04/11/25 15:48, Ritesh Harjani (IBM) wrote:
>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>
>>
>>> I would like to keep kdump_cma_reserve() as is it because of two reasons:
>>>
>>> - It keeps setup_arch() free from kdump #ifdefs
>> Not really.
>>
>> Instead of kdump_cma_reserve(crashk_cma_size), one could call
>>
>> reserve_crashkernel_cma(crashk_cma_size) directly in setup_arch().
>
>
> reserve_crashkernel_cma() is not available unless the kernel is built 
> with CONFIG_CRASH_RESERVE.
> So, wouldn’t calling reserve_crashkernel_cma() directly from 
> setup_arch() lead to a build failure? Or
> am I missing something?
>

OOps.. I was assuming the #else CRASHKERNEL_CMA definition should get
called, but all of that logic itself is protected in
CONFIG_CRASH_RESERVE :(

Right to avoid #ifdef or IS_ENABLED in setup_arch..
it's better to have kdump_cma_reserve()

Thanks for pointing that out.


<snip>
obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o

kernel/crash_reserve.c

#ifdef CRASHKERNEL_CMA
int crashk_cma_cnt;
void __init reserve_crashkernel_cma(unsigned long long cma_size)
{
        ... 
}
#else /* CRASHKERNEL_CMA */
void __init reserve_crashkernel_cma(unsigned long long cma_size)
{
	if (cma_size)
		pr_warn("crashkernel CMA reservation not supported\n");
}
#endif

-ritesh


>>
>>> - In case if we want to add some condition on this reservation it would
>>> straight forward.
>>>
>> Make sense.
>>
>>> So lets keep kdump_cma_reserve as is, unless you have strong opinion on
>>> not to.
>>>
>> No strong opinion, as I said it was a minor nit. Feel free to keep the
>> function kdump_cma_reserve() as is then.
>>
>> -ritesh
>>


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705B5C55179
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xri95HxWWHQhvW9BuZBsF19Q6k7n+JZ6FN4+B6v5Sz0=; b=xp5Y18MvAI28ezzsMHmgOk6bCd
	jrQzDVKwRG0D5gwaaFCXZZmIR5ykzRdli+QROVghGoEY4/EPKRlK8vX4TNEahQIa1kjl0aU8EpNba
	eeu0HiDuKG51nFXl0bkshhSSfBkhE6uLkvLD3VqxtpOqCu7/Bz8d7vMH3iE/dI6NqFLWS874YdQcY
	U9RhCx+QJEMj5slVDaYHkHEujBkrdmPmQECd8PIatkNc8oUfcsqdcSmvml42C1FZUOlSlWXvBrfjj
	4wHMzuAJVoVbEWvXLciqwMNGZbOZ742CJ5Ac5WpDcjDfSP6c6Hu4HEyh06h5QJovxY/zwn9xKTw5x
	hUmZqhcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqrYp-0000000H09U-2rxZ;
	Mon, 03 Aug 2026 12:14:27 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqrYm-0000000H094-2RkG
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 12:14:26 +0000
Message-ID: <ab46b71a-9f8d-48c4-89be-e15ce50aa8c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785759260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xri95HxWWHQhvW9BuZBsF19Q6k7n+JZ6FN4+B6v5Sz0=;
	b=FzYjT2I44jBLuUUeCvzQl6e0VW3AvRXowFAr+gnT7aMEJCzMo7XlqdR/xiXXtBVzlHsj3X
	HOYYUxckQSsYo5h102eGGFKinriCQDXOFbvZZMQ7wigLm2B2WMl2CTQCNW7hALBadhCIcx
	E/q3ddOqn8GXb0/C5uHmuxpiuU35fPo=
Date: Mon, 3 Aug 2026 20:12:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
To: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <contact@jaseg.de>,
 Baoquan He <baoquan.he@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Coiby Xu <coxu@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 keyrings@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 Tao Liu <ltao@redhat.com>
References: <20260731154608.153258-1-linux@jaseg.de>
 <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
 <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
 <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
 <e9523b5a-6623-49ea-9ba3-cddae1a9ce7e@jaseg.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dave Young <ruirui.yang@linux.dev>
In-Reply-To: <e9523b5a-6623-49ea-9ba3-cddae1a9ce7e@jaseg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_051424_969998_F09EA096 
X-CRM114-Status: GOOD (  29.32  )
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

On 8/2/26 6:20 PM, Jan Sebastian Götte wrote:
> On 8/2/26 07:08, Dave Young wrote:
>> On 8/2/26 12:31 AM, Jan Sebastian Götte wrote:
>>> On 8/1/26 16:03, Baoquan He wrote:
>>>> Note that we usually dont' want to run a lot of work after panic and
>>>> before jumping into kdump kernel.
>>>
>>> I understand. For this reason, I think it's best to keep this default-off. As-is, the notifier list call is timed and on the (slow) ARM64 target I'm using, it takes about 3-5 ms to run. I took the "try lock, skip if locked" approach to keep the risk of this code crashing during panic minimal. In my application, the kdump payload is code that then does a full wipe, taking a couple hundred milliseconds.
>>
>> Not only about the time used, the panicked kernel is not reliable, any more extra logic can make it even not reliable, any pre-kdump extra logic is not a good idea unless it is a must to ensure kdump working.
>>
>> Cleaning up secret data can be done with makedumpfile + eppic scripts (see the manual of makedumpfile), or it is even possible to do so in kdump kernel with Tao Liu's improvments for makedumpfile previously  (I don't know the status, probably dropped for the time being, but it is possible, cced him).
> 
> Thank you for the pointer!
> 
> There's two scenarios worth considering. First, in the standard scenario where you enable this option, then drop into a standard kdump kernel, I don't think it makes a big difference *when* you do this cleanup since someone is going to have to dereference these pointers. IMHO a good reason to do it in the old kernel is that there, the code knows about the layout of all the data structures. To retroactively do this in the kdump kernel is much more complicated, since there you have to reconstruct the structure layouts from symbols or hardcoded struct layouts, and you have to keep this symbol/layout information perfectly in sync with the running kernel.


I know that this is the usual reason people want to do things in 1st
kernel :)   Like the crash_kexec_post_notifiers which was introduced for
people to use at their own risk.  Is it doable for your case to use
crash_kexec_post_notifiers?


> 
> The second scenario is what I'm working on here: I'm not using a normal kdump kernel, but instead a custom payload that wipes all RAM from start to end. This payload will wipe all these keys too, but my critical concern is speed: On the embedded SoCs I'm targeting, the full memory wipe takes too long (hundreds of ms) for an HSM application, so I want to do a targeted wipe of just the keys first. The old kernel I think is the natural place to do this. Adding to that, in my scenario the most likely trigger of a panic is not something like memory corruption, but a trigger of the system's tamper alarms, which would leave the old kernel relatively stable during panic.
> 
> I can imagine several possible mitigations for the stability concerns beyond the default off config option:
> 
> * Since the wipe handlers are all really simple, it would be possible to manually guard every memory access there to ensure they can't fail and that they don't write to sensitive areas like the dump kernel or the remaining panic'ing stack. Doing that would only rely on information (more or less intact stack pointer, kdump kernel area boundaries) that would be necessary for kdump to succeed anyway.
> 
> * And/Or I could extend the patchset to include a mechanism similar to that in Bradley Morgan's patchset that catches segfaults during wipe, and then skips the handler causing the fault.
> 
> * A last option would be to have the alive kernel prepare some kind of "wipe this first" structure in its memory during normal operation that the dump kernel then can pick up to do the actual dirty work. I disfavor that since it adds double bookkeeping to a lot of places, some of which could be performance critical.
> 
> I've also picked up that I should remove the timing logic since that could cause instability.
> 
> Thanks,
> Jan Sebastian


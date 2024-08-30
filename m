Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF386CA0EFD
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YAGgvPa6gsfZfFbPEuSl1v9X3FdCAfRq9y4pPvSm9bg=; b=gHPBpPJOpv+yTj
	NsNJZdyA9AxeqTfocEoz+J8++7gqg0AERUi38eBC9lTaHxM5+/MxgxB3Epx2cr9sD2Nrp7MyEwn/o
	VWAokzwTzUE5j0noGYcpBVBqiJksSqYDzSxsztPB1WaxHCPnnG36wfHxXuI5T07d4Dhd1Mrz98oYw
	fqWUNJgJdAEmORUJQN/D+EjN/aHVsHFBwJsDDe+FjHAlEtO872NneoDzRjU8mU0Ea6cs2mM/DLHf5
	eZ0tZW5mg3ty4cvWi2ObZLpmM1lmyWTnKJ4BaCojtyAWnhqvyUClSueS364Z+GA/NSg2Nx6JutjWJ
	InbRByN9dEyM5B+QtpHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk6Hs-00000007K4p-0v10;
	Fri, 30 Aug 2024 18:23:56 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk6Hp-00000007K3q-2erd
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 18:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hh4itEyLDnEMzZxAwF6jQr2sg6SqyVA/UmRTj4Gm508=; b=OysKoZ1J6RJLGm/5sQNsgBNmAi
	cWsUb0ASJzvLxJVJ1pTqh+H5c4mewYkOHgpNMpGWLyU418tHS9D1CuevL9L8IT2VgJ1QBqtxYHACl
	POm9m7uEsiB9DTix716yXedCWUxSAEJ0PnWM6qnir2OIfvwaHQdesUw8FZsWn69i+nV4nzKB5fRGc
	Qhwa3O7MJ2zxTOnbTPLX6AYe8R1yhcdnKbAPucmn+k0ieduQOzs37ihHRL8ZLzIHJX8ON269yjz7A
	54lChbOTh932aSKts8QAE3/aQ0ZtgV2JDSyl5sXG89hmgzjgpFD33DWCx7hKnujMRoENk2byfWMMB
	rdTFK+cQ==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sk6Ho-007FYO-3c; Fri, 30 Aug 2024 20:23:51 +0200
Message-ID: <ffe4b1ac-926e-7f99-900b-707384f09462@igalia.com>
Date: Fri, 30 Aug 2024 15:23:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20240830140401.458542-1-gpiccoli@igalia.com>
 <87ed66q6d5.fsf@oracle.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87ed66q6d5.fsf@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_112353_705944_9653BE1A 
X-CRM114-Status: GOOD (  10.52  )
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

On 30/08/2024 14:15, Stephen Brennan wrote:
> [...]
> 
> This is definitely clearer and an improvement! But I didn't (and still
> don't) love the phrase "users who doubt kdump will succeed" because I
> think that implies user error or silly beliefs.
> 
> What if these two sentences read something like:
> 
> In configurations where kdump may not be reliable, running the panic
> notifiers can allow collecting more data on dmesg, like stack traces
> from other CPUS or extra data dumped by panic_print.
> 
>> Notice that some code
>> +			enables this option unconditionally, like Hyper-V,
>> +			PowerPC (fadump) and AMD SEV.
> 
> Yes, great addition.
> 
> With or without my suggestions it's an improvement, so:
> 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 

Thanks Stephen, I agree - your wording sounds better.
I've incorporated that in the just sent V2.
Cheers,


Guilherme


P.S. I'll be OOO some days, so expect a bit of delay in case there are
more reviews/interactions.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

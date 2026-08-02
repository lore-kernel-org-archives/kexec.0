Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25553C55162
	for <kexec@archiver.kernel.org>; Sun,  2 Aug 2026 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWXStCMoW6WCbh77+QZYpryjqAzaULEhXUbNrcfh4rw=; b=vg+iFWUUVC5IqzgZkpETGLfXr4
	V5NznizfpJQJZHn62o+I61pKBzZH1P07jMx4yH5+eSJuFs77AFFcZ892hrAx/Ftx2TdRlhdo7n1L1
	7VcNaC5ThtsZdp2FLQhk4qlUq2bGgCaGE8bMv9pX4TxoPQEMzZYnljgoselIpCM7I6YGI/w7UbKTx
	DLOWrIDiRycRBaQ35lh/zSYSN6JxvpZcLvUMzkR9FHJAuw9ihpQm276GQFJQIOnDEFLvTsCrUFcNb
	0nFiHYwRnqrRVMXxlitB8M+Z5ZTduVhAVjWi/YI3XACAGsKjxZTCI/5NFf6/fUovYkzTAHsr+O5BH
	eRXM8fRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqTJ2-0000000FXtT-0rg7;
	Sun, 02 Aug 2026 10:20:32 +0000
Received: from flow-b1-smtp.messagingengine.com ([202.12.124.136])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqTIz-0000000FXt7-26jh
	for kexec@lists.infradead.org;
	Sun, 02 Aug 2026 10:20:30 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id C146E1300093;
	Sun,  2 Aug 2026 06:20:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 02 Aug 2026 06:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785666025;
	 x=1785673225; bh=UWXStCMoW6WCbh77+QZYpryjqAzaULEhXUbNrcfh4rw=; b=
	iZwnkVSosBHNE8xpbW2/uRGeqmvdP7MUygil9KGnZUB9Xa9IDAA3U9JSiOogjVZW
	1tt40D75cLDZGnVWkY/D1TQ9ySN8s8gC0Kt4wucww+TjSW92baCAn0jWAFnOseqf
	665uGt8+/SISS2/7yCCSd4HUubsKgeQScQ9rwmFmHx/mir4+2gm/5YcCAmvxHtuh
	4RQl0CiwQCX7bpzunx+GL0QyNagk1fHODyy6Lit3UYDOE2hsEGfw09C78ob6jmzi
	H5e4opGZuvhLa4uVttC4T19BCT9ek1z/vd8/8VDDMQgBVzk4XjZxDzDCQULOnhwg
	Mz1ZckZsqogahodGV4DnzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785666025; x=
	1785673225; bh=UWXStCMoW6WCbh77+QZYpryjqAzaULEhXUbNrcfh4rw=; b=B
	DnxRYHiYO7+nhj2tcTfTdom1aUBnsbDb6AsS19aAl8kFmxkJFcG9td2FJSvD39Ov
	FVS1gE5m9WqCd5JeQOy0Om5Je52Ch9bb1CLMvR/OHjJJIeTXIbxSQASWE/DyqhI9
	8wG9ABtJE/f4e9LyB8f37qM5dMQutALMBkK6YWd1r0rUNdfaRIJZ4CctmbHWt88u
	0P9Wgj9tmgzhDorOx5ORgUByFzJDmgq9/iAQYp69Xf7YPeAQUZE+kJ1fGlI4kUVJ
	fN379P1wnb8s8FMuviiW7LXoVQ8xol/W6lHsdcYOySxxE+cT9COWm6GMQp4BE+ik
	SbTHY5w24nMvleifrql1w==
X-ME-Sender: <xms:6BlvauWuSlb2vA2ojV38iW8G58GBzSEiPw8bC2jhukWRngUmvDPRKw>
    <xme:6BlvamtkrADkPVjhXoiU00XKp0dJCvTdBxzmBQUXLXuS6uIvo5kqOOcyMkg_xXbW-
    GpZWa_tTmVxNkdmqVqGSS0ROk9T0d9UuLB23MFnGyO4sgWtwwDZ>
X-ME-Received: <xmr:6BlvauMvjbDStu_vTDXfjJnxpxBHJLHiN0DbxdfoYoS-y_wwcEeywDcWljp7KkFROVrcEIq_m0YFLptS6UIzHOM>
X-ME-Proxy-Cause: dmFkZTGkWVqRDKxcHXed4G2Im/dKcKeNjOvDOtoNYff23UD3/wEy+brhhk2RbqYNFArYft
    yxG2GBFuo/j13wt08UgFKzWNJHXB1MYtyl0OJ+p3c+LmNt9xDuYa0828krvA9AU4dW3MVc
    Z5n9mgmxq8A45aZYLVP40RS7oHZFHK4FWE7Hl0BBpELs6vISpMoZS716y4r/pXgHw7dGVE
    HtZba2b+c323q/EucToLYsxPoAnfhDRiAWZPJ7sHTC70DdV/mF+iHA3pcAliftaH98HxlF
    dWAU7NICZgRrE7g1GmWLChsHoNRsXBqeNgzRXezEKkEnCA25hSbCTGx1gy57PKPdifSkM2
    1+ciZ2GlZM3GF80LlZuK77cxGBAdgbTWk8lgzFXdVtOY2danDcL3KQC3YDVBYv+d46w1le
    kGqPJu6c2rOE4768YKbMvJs+9Jg+FP+SBbO1ftDchUC2tp7rAam/eBslVM9sjgVmzu0hC1
    1IUP9pcqlFQ6gF2IZSlnI9D6R+BByUpikFCkdDbaQQmNibFVbiC/AEi09VwXv7+gdrH1CT
    aE0mQD3qPQ+8j840mFjrWAmHsPz8NG7CivCMwnImvW95JZUIwrUtLboE28YsF76BJGmPeY
    mGIb/QFKZI6gXrQsBHX/uuM35J6LeeDUpZn8B7mofvk3AJFfMows3UuAjWFA
X-ME-Proxy: <xmx:6Blvaurww5cxUbuXjvHc-NXLfEZZhhcv-ak2IEiADLlMH6SivIkRWQ>
    <xmx:6BlvaouAlqlGvoFhSUugZLwmA1jy3sUUn0WT_H6Y5-aX9y0cU9AKkA>
    <xmx:6BlvauiSJND0xIkfHxP_JkZ4QPVNk_JsDHQCPGPvYm-1237I_qjUAA>
    <xmx:6Blvas1Z2x02fdspsIPFFjRYIlBl41Sv55VojK-VZw7_z07Q1H-f2Q>
    <xmx:6RlvavMS61OqS3oEGaKid47bE1XwBqD-7dwbctrl5oElNq6wolknVEnH>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 06:20:20 -0400 (EDT)
Message-ID: <e9523b5a-6623-49ea-9ba3-cddae1a9ce7e@jaseg.de>
Date: Sun, 2 Aug 2026 12:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
To: Dave Young <ruirui.yang@linux.dev>, Baoquan He <baoquan.he@linux.dev>
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
Content-Language: en-US
From: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <contact@jaseg.de>
In-Reply-To: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260802_032029_774544_42A3B30D 
X-CRM114-Status: GOOD (  24.49  )
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

On 8/2/26 07:08, Dave Young wrote:
> On 8/2/26 12:31 AM, Jan Sebastian Götte wrote:
>> On 8/1/26 16:03, Baoquan He wrote:
>>> Note that we usually dont' want to run a lot of work after panic and
>>> before jumping into kdump kernel.
>>
>> I understand. For this reason, I think it's best to keep this default-off. As-is, the notifier list call is timed and on the (slow) ARM64 target I'm using, it takes about 3-5 ms to run. I took the "try lock, skip if locked" approach to keep the risk of this code crashing during panic minimal. In my application, the kdump payload is code that then does a full wipe, taking a couple hundred milliseconds.
> 
> Not only about the time used, the panicked kernel is not reliable, any more extra logic can make it even not reliable, any pre-kdump extra logic is not a good idea unless it is a must to ensure kdump working.
> 
> Cleaning up secret data can be done with makedumpfile + eppic scripts (see the manual of makedumpfile), or it is even possible to do so in kdump kernel with Tao Liu's improvments for makedumpfile previously  (I don't know the status, probably dropped for the time being, but it is possible, cced him).

Thank you for the pointer!

There's two scenarios worth considering. First, in the standard scenario 
where you enable this option, then drop into a standard kdump kernel, I 
don't think it makes a big difference *when* you do this cleanup since 
someone is going to have to dereference these pointers. IMHO a good 
reason to do it in the old kernel is that there, the code knows about 
the layout of all the data structures. To retroactively do this in the 
kdump kernel is much more complicated, since there you have to 
reconstruct the structure layouts from symbols or hardcoded struct 
layouts, and you have to keep this symbol/layout information perfectly 
in sync with the running kernel.

The second scenario is what I'm working on here: I'm not using a normal 
kdump kernel, but instead a custom payload that wipes all RAM from start 
to end. This payload will wipe all these keys too, but my critical 
concern is speed: On the embedded SoCs I'm targeting, the full memory 
wipe takes too long (hundreds of ms) for an HSM application, so I want 
to do a targeted wipe of just the keys first. The old kernel I think is 
the natural place to do this. Adding to that, in my scenario the most 
likely trigger of a panic is not something like memory corruption, but a 
trigger of the system's tamper alarms, which would leave the old kernel 
relatively stable during panic.

I can imagine several possible mitigations for the stability concerns 
beyond the default off config option:

* Since the wipe handlers are all really simple, it would be possible to 
manually guard every memory access there to ensure they can't fail and 
that they don't write to sensitive areas like the dump kernel or the 
remaining panic'ing stack. Doing that would only rely on information 
(more or less intact stack pointer, kdump kernel area boundaries) that 
would be necessary for kdump to succeed anyway.

* And/Or I could extend the patchset to include a mechanism similar to 
that in Bradley Morgan's patchset that catches segfaults during wipe, 
and then skips the handler causing the fault.

* A last option would be to have the alive kernel prepare some kind of 
"wipe this first" structure in its memory during normal operation that 
the dump kernel then can pick up to do the actual dirty work. I disfavor 
that since it adds double bookkeeping to a lot of places, some of which 
could be performance critical.

I've also picked up that I should remove the timing logic since that 
could cause instability.

Thanks,
Jan Sebastian


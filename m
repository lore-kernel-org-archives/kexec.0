Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BD9C55171
	for <kexec@archiver.kernel.org>; Sun,  2 Aug 2026 05:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hd4cL7pghs+u2caiYGxcAzT0GxJfEgZpykZQLSOMKeI=; b=bJnTFju5GZgcmah3dhdDUkakJi
	Yv7hYg/0/350981h/oB6BJZJZFzbDmnH/CIxgYBqSNvSaz6bLxpqbAasmvAgYBCpaJq/HGB3pLGy8
	YB9wmYC4PPHsk2qYQUb1S08+Jj8k0na8Ms3syZ1mNWtuYP50gY5YgLOI0QtoPvyLCm5atkGXnZa/I
	nAC+4yrY6JPRa2V4n+W+8/H/HxZWkOnWvA5ZzefGEXkOWKer7kPkzkxjSrAJdbMn8s0NXdWZ4gzLb
	+8Q/Ht+lRd5IEl09ElpzsbPsprQm4COH5B8iBrpDH3dYpR/hYFlMHWfJUkSLQvLVuo8iKz/1g+VXa
	X0ARj9kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqOSZ-0000000FMk1-3XHw;
	Sun, 02 Aug 2026 05:10:03 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqOSW-0000000FMj6-2MBp
	for kexec@lists.infradead.org;
	Sun, 02 Aug 2026 05:10:02 +0000
Message-ID: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785647390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd4cL7pghs+u2caiYGxcAzT0GxJfEgZpykZQLSOMKeI=;
	b=RVJxx1S5DRBGBvjVn4pgA6hw3XqP4M3aArDWpSdUWbhITIKpirzqFnYKE0ULdaBQR9D5Kq
	m6JkrqIjl2xpZoauRX3BuZJw5k3oj8Kog59W0gmvGdlMmtvX7gd+Do7FeQp92bxWQEttOH
	Qx9cTu8lprDDh5cmN0cTG6d4wSItD+E=
Date: Sun, 2 Aug 2026 13:08:21 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
To: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dave Young <ruirui.yang@linux.dev>
In-Reply-To: <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_221000_812305_317487AF 
X-CRM114-Status: GOOD (  25.23  )
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

On 8/2/26 12:31 AM, Jan Sebastian Götte wrote:
> Hi there,
> 
> On 8/1/26 16:03, Baoquan He wrote:
>> On 07/31/26 at 05:46pm, Jan Sebastian Götte wrote:
>>> Add CONFIG_CRASH_ZEROIZE (default off), which when enabled makes various
>>> subsystems handling secret data do a quick, targeted wipe of these
>>> secrets before kdump. This behavior might also be interesting in cases
>>> where you run a normal kdump kernel but you still want to keep things
>>> like fde crypto keys out of these dumps.
>>
>> Please check below patchset, you both seem to have the similar
>> requirement. Please go there to discuss.
>>
>> [RFC PATCH 0/4] panic: a pre kdump notifier list for hypervisor upcalls
> 
> Thank you for the pointer. That's indeed similar, but I think this patchset here makes sense as an independent patchset.
> 
> * The two notifier chains run at different points, and theirs runs inside panic independent of kdump. This one here has to be run after machine_crash_shutdown(), and so makes most sense inside __crash_kexec(). The wipe code in this patchset must be one of the last things to run before the kexec since the wiped data structures could easily lead to problems if something tried using them later.
> 
> * I think this patch series here is a bit cleaner. I don't think this needs a custom notifier implementation.
> 
> * Since there's lots of places that may need wiping after crash, I think it makes sense to have an explicit notifier list for that purpose, and to not mix these with other things like hypercalls. I think ordering is important here: The wiping should be the last thing before the kexec jump. Having it on a generic notifier chain risks that later, other callbacks get added that when interleaved could cause problems.
> 
> * Since a good fraction of users may not care about wiping secrets, I think it should be gated behind an explicit enable setting.
> 
>> Note that we usually dont' want to run a lot of work after panic and
>> before jumping into kdump kernel.
> 
> I understand. For this reason, I think it's best to keep this default-off. As-is, the notifier list call is timed and on the (slow) ARM64 target I'm using, it takes about 3-5 ms to run. I took the "try lock, skip if locked" approach to keep the risk of this code crashing during panic minimal. In my application, the kdump payload is code that then does a full wipe, taking a couple hundred milliseconds.

Not only about the time used, the panicked kernel is not reliable, any more extra logic can make it even not reliable, any pre-kdump extra logic is not a good idea unless it is a must to ensure kdump working.

Cleaning up secret data can be done with makedumpfile + eppic scripts (see the manual of makedumpfile), or it is even possible to do so in kdump kernel with Tao Liu's improvments for makedumpfile previously  (I don't know the status, probably dropped for the time being, but it is possible, cced him).

Thanks
Dave

> 
> Let me know what you think.



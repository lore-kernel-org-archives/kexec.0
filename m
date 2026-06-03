Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EFCCD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DiMi2AOkr41lLQQ8lkXK5ScVvrndiW+3Zkpi2ThCMg8=; b=E4bCw2Wxb4u/ZXODuokvSXTPmq
	5TEiYhdAreDGqcUvoMAaYk2E/MMVBqDhPPFZPmyCVBSY4q5RK6h67wPj95s0T1cUmNyej2eI64mke
	P+CrHVAxpXEnpY5GRKC31yuweSmdUj3JVQWT6DShIkP1rwdmY2qwWncK47yQO23zFEmTvAqJ+ZdVN
	wQblO8OQWf8JxkAuce9YASy1+bE224N/Jh9+H88NlDLkgLWF0A+6Mj5FEL1wst5aMS4J8H/43+03l
	iWymUrwj2sEAPs5+7irWBfGduyPH9+jH1oD0zSl2i7z1aurfc89mElbMhDLqaiK8uc7++RLhcouE4
	+Hl7N9Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUpM9-0000000FZoZ-13eB;
	Wed, 03 Jun 2026 17:26:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUpM6-0000000FZnd-1FB6;
	Wed, 03 Jun 2026 17:26:15 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 928E120B7168; Wed,  3 Jun 2026 10:25:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 928E120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780507558;
	bh=DiMi2AOkr41lLQQ8lkXK5ScVvrndiW+3Zkpi2ThCMg8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EnMUBUXndkm6H+8pw74uuRu7AaBF6Y2P5UHSn671EYJ6AHspLIGBAjxTK0YnC63tg
	 a9gWzTZ1uhg3OfJ+IGfN+QTusX0nyLn1rYJxr/vxFjCDx91PproYwVJZZfVSXuq4sc
	 rr0JK382f+sPSDMf6vulEDPlcs/vBEF43JAe1mGA=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 903BE307050F;
	Wed,  3 Jun 2026 10:25:58 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:25:58 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Mike Rapoport <rppt@kernel.org>
cc: linux-hyperv@vger.kernel.org, linux-mm@kvack.org, 
    kexec@lists.infradead.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
    Jason Miu <jasonmiu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
    Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
    Justinien Bouron <jbouron@amazon.com>, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, Pingfan Liu <piliu@redhat.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
    linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
In-Reply-To: <ah_z3GV55RY3ZnT-@kernel.org>
Message-ID: <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com> <ahxrc4pTvVU20RTX@kernel.org> <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com> <ah_z3GV55RY3ZnT-@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_102614_369071_C296EBF7 
X-CRM114-Status: GOOD (  10.22  )
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



On Wed, 3 Jun 2026, Mike Rapoport wrote:

> On Mon, Jun 01, 2026 at 01:09:41PM -0700, Jork Loeser wrote:
>> On Sun, 31 May 2026, Mike Rapoport wrote:
>>
>>>> Patch 19:      Export kexec_in_progress for modules
>>>
>>> Isn't there another way to differentiate kexec reboot?
>
> There's that "kexec reboot" string passed as the cmd to the reboot
> notifier.
> Maybe we can make it somehow more well defined API and use it?

A string? Dear my - the compiler won't flag it on an API change then, not 
ideal clearly. What's wrong with exporting kexec_in_progress()?

Best,
Jork


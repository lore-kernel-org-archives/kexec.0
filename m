Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF8CCD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eDXJ86FB/Xnvqi9RF8rrZVf1GrIi8kltJ1EOvKoDwfg=; b=PbabZxkEiDLRxY5KNzVKihA6QC
	7VjGzlxP0HvyIHwop3iVClNbgBDA/5zgiyH1vZhB4VqvxJUiok6WhwV+WcUP34AZPILsIc7TKY1bs
	5QdD2QMTU1NSnWsX3dY2Aw3j0phBeC24u3+Ed7fCy65r7+aza6uFEPlxn2ymdndf5dEIWj9dl0V/L
	gVObvY59cvkKIikgSEg5NRbsy20yvRORGGRY0BURiSsuYa9o6AZAGklizXRixVHMN8HhEIXIKm16+
	2uILWcQG39TU0KNgnIMktUqVDePwWBaOI+NSKUyuHxswC3A6WmjUcjZMiT+ASjRi4D/92X0TT/rUC
	/xYoVGog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8xS-0000000BktP-3dud;
	Mon, 01 Jun 2026 20:09:58 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8xQ-0000000Bksz-42Tn;
	Mon, 01 Jun 2026 20:09:58 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 7E93A20B7166; Mon,  1 Jun 2026 13:09:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E93A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780344581;
	bh=eDXJ86FB/Xnvqi9RF8rrZVf1GrIi8kltJ1EOvKoDwfg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HJp+sRV7Z+MPOGir5B+cVGDJgSKPlmbFixBaKBsui3oAaZjlZBs+SpoXYgUhogRkt
	 2V69j+/mhNBX90+hxId+3srtlmItfZ4xvOVH6zQix9CSW4B3cF4dMKO1vETTdCKdTk
	 t0hko/RYjtgxX/S0C1zWqVZwqNlBNpYmi1ctKyps=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 7B665307029C;
	Mon,  1 Jun 2026 13:09:41 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:09:41 -0700 (PDT)
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
In-Reply-To: <ahxrc4pTvVU20RTX@kernel.org>
Message-ID: <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com> <ahxrc4pTvVU20RTX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_130957_056144_FCC9124B 
X-CRM114-Status: GOOD (  17.03  )
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



On Sun, 31 May 2026, Mike Rapoport wrote:

> Hi Jork,

>>  - A freeze mechanism to lock the tree before serializing for kexec
>>    (patch 13).
>
> There were a lot of effort to make KHO stateless and drop the requirement
> for finalization/freeze.
>
> Why is this necessary to add a freeze mechanism to kho_radix_tree?
> If it's a hard requirement of mshv maybe the freeze part should be handled
> there?

Good feedback. It's a safety-net so we do not accidentally donate pages 
without being able to track them. Thought it might be a good generic 
feature. Let me keep it in the MSHV driver.

>> Patch 13:      Radix tree freeze and del_key() error reporting
>
> del_key() error reporting sounds like something we'd want to avoid.
> del_key() is called on "freeing" path and during error handling, it would
> be hard if at all possible to deal with errors from del_key().

I hear you. Stating "yeah, it can only really fail if the key isn't there, 
or it's frozen, but not due to other things, so don't bother to check the 
return code if you are sure" is an odd contract. With the freeze-logic 
moving into MSHV, will revert to no-error.

>> Patch 19:      Export kexec_in_progress for modules
>
> Isn't there another way to differentiate kexec reboot?

I could not find one, unfortunately.

> Sincerely yours,
> Mike.

Best,
Jork


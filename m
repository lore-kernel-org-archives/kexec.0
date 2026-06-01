Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B3CD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 20:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i8NBTcO9HEOzTK8eQah5j9/dFbH36DIcHsxmT2YF1Qc=; b=RzDVlyPfK31NnAPdlAMVFAuDH5
	eLjSN1wZgB4JticIP8ntkvjObWVMJ+UOaFsCzg8ZVsT3HmHGUoF/2tw3xX60M0mJR9Rwq3MulJjRW
	R1QBIFeupAIV3VHjlL4Axy/qwqUJxXApvufwXAd9zRns9urP6YJ6nRxZn0lh3yQBjO2Mf6/Pglmcv
	ah3n/sBsjLysb3Fxe1nO0UABVdbwmoNhIpGIMYax6JNPyBXg6d3k6m5aw8wRnljuqlu2K/iFvaVa6
	18TApeWCMzyiDSILpc/4N52P+aZV7W1hIwEdBKkJ+f3IqVK7RweZBTn5R/Vx2hZjlEAHS8UwdJ9Bl
	1y/5kWYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU92l-0000000BlJ2-2lnl;
	Mon, 01 Jun 2026 20:15:27 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU92j-0000000BlIc-2AG6;
	Mon, 01 Jun 2026 20:15:26 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id C8C6B20B7167; Mon,  1 Jun 2026 13:15:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8C6B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780344911;
	bh=i8NBTcO9HEOzTK8eQah5j9/dFbH36DIcHsxmT2YF1Qc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N4fFVqdpnNKdfAbjqncbFZwC2cL0SqneHkeBwmGFomr8pp0NRNUByLEUbqgl8CJ8N
	 vY6qbZwhRR9MwgL5+zUBwQimuhzzrZM/WE/HOOB8z/Dme678HYaDRiKwCDmVLKYqQV
	 OjG4scG03Yvz67ic0ko8L1MxjUf3zZKekJ1EavqM=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id C62FA307029C;
	Mon,  1 Jun 2026 13:15:11 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:15:11 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: Mike Rapoport <rppt@kernel.org>, linux-hyperv@vger.kernel.org, 
    linux-mm@kvack.org, kexec@lists.infradead.org, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
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
In-Reply-To: <ah2eBxaBnVs_1j5n@google.com>
Message-ID: <4172d271-21b4-346-924e-406baef179a1@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com> <ahxrc4pTvVU20RTX@kernel.org> <ah2eBxaBnVs_1j5n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_131525_611256_655AAC43 
X-CRM114-Status: GOOD (  12.66  )
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



On Mon, 1 Jun 2026, Pasha Tatashin wrote:

> On 05-31 20:10, Mike Rapoport wrote:

>>>  - A freeze mechanism to lock the tree before serializing for kexec
>>>    (patch 13).
>>
>> There were a lot of effort to make KHO stateless and drop the requirement
>> for finalization/freeze.
>
> Yes, using KHO directly here is incorrect. The state machine is provided
> by LUO, so we should use LUO here. MSHV should provide a file that
> userspace adds to LUO, and all state machine management would be the
> same as for all other clients participating in LU.

The thing is, there is no file handle to rely on. Even once partitions are 
all removed, Hyper-V might hang onto pages (and won't return them even if 
asked). However, these pages very much must be excluded from Linux 
post-kexec, or the system will crash. We cannot rely on UM to ensure 
integrity of memory management.

Contrast that to standard LUO use: If you drop individual file handles, or 
even skip the LUO phase entirely, the worst that will happen is that the 
objects will be gone post-kexec. The MM itself will still be consistent. 
For MSHV & page donation, this is different.

(And yes, partition preservation will very much tie into LUO)

Best,
Jork



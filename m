Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8B7E732FE
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m1WyEMompkbaerIHUFT+eHCbn3a5jlgTYPg5m6JUfH4=; b=t4Xo3ItxOEOVUx
	4fviu0aBuOXUvLKJhaVkfWHqi1vbiyYEukZnPPflAgRLmPhC0UBmgYQG/XHqYBAIpb0Z6OeEyKSw7
	7jKBrf8EthtGJAfb/SV9W08yoMSPFZN0WSxMQI007rCicWMc7kUyWFj8scZMSigDw9ur6BQyFIUvc
	hRqA1YgZibD/6hfjKSa6IIvhcEqcCE8UF9bbqQfPi879Eo7SiLjTANV/8pUQ7N0wWDQUPlM6Eg8GB
	G5iDD0Z5Jc8TBbFKQIZmmvTWNOE4sHg6LOQd1foAa4vyKfSwXsQ+mh9B3ykxb2q+4PY5qoUAj5tRz
	2zuSJcVMjK9gYn5n/K/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qluZW-006P1V-0w;
	Thu, 28 Sep 2023 17:13:06 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qluZS-006P0j-2K
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 17:13:04 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3105020B74C0;
	Thu, 28 Sep 2023 10:13:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3105020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695921181;
	bh=WHD7w8p4ig6hZvJ2HDlS2yknFytIbx+O5dBVV0TdS9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN+O+Hzs4pIM424F5eKC0n/EsDjESogGkGqVZh9mS53ithFDLcEae9I207mN3piB3
	 iYLiX52ica6itYY25Bf8TDkXOeQEX15tNQ+E7se//LrdKtJXjlQSNI+CXpZI1sl4IS
	 Bj+9f33ilTHKzi/UIx20ACz8Wa6bWPz2ig9ieBRU=
Date: Wed, 27 Sep 2023 16:25:48 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230927232548.GA20221@skinsburskii.>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_101303_484837_D4FA3A5C 
X-CRM114-Status: GOOD (  15.54  )
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

On Thu, Sep 28, 2023 at 06:22:54AM -0700, Dave Hansen wrote:
> On 9/27/23 09:13, Stanislav Kinsburskii wrote:
> > Once deposited, these pages can't be accessed by Linux anymore and thus
> > must be preserved in "used" state across kexec, as hypervisor state is
> > unware of kexec.
> 
> If Linux can't access them, they're not RAM any more.  I'd much rather
> remove them from the memory map and move on with life rather than
> implement a bunch of new ABI that's got to be handed across kernels.

Could you elaborate more on the new ABIs? FDT is handled by x86 already,
and passing it over kexec looks like a natural extension.
Also, adding more state to it also doens't look like a new ABI.
Or does it?

Let me also comment on removing this regions from the memory map. The
major peculiarity here is that hypervisor distinguish between the pages,
deposited for guests to rnu and the pages deposited for the Linux root
partition to keep the guest-related portion of hypervisor state in the
root partition. And the latter is the matter in question.

We can indeed isolate and deposit a excessive amount of memory upfront
in hope that hypervisor will never get into the situation, when it needs
more memory.
However, it's not reliable, as the amount of memory will always be an
estimation, depending on the number of expected guests, guest-attached
devices, etc. And this becomes even a bigger problem when most of the
memory is already removed from the memory map to host guest partitions.
It's also not efficient as the amount of memory required by hypervisor
can grow or shrink depending on the use case or host configuration, and
deposting excessive amount of memory will be a waste.

But, actually, the idea of removing the pages from memory map was
reflected to some extent in the first version of this proposal,
so let me elaborate on it a bit.

Effectively, instead of reserving and depositing a lot of memory to
hypervisor upfront, the memory can be allocated from kernel memory when
needed and then returned back when unused.
This would still require pages removal from the memory map upon kexec,
but that's another problem.

Thanks,
Stanislav


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5C5E732FD
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sqRTBF9ovQsXArRtNteV1T8N4MuanLwEQb6s3d56Wrc=; b=YhwUhlsMWmpEmk
	x1kNyjcv4KlaszeKq5TYuLwfZ0i+o9vGt3+0jHDuAQCNsz5hRnklWIrjke8qKjnJNiZjJ+l1Yu+Iq
	b031mXkCVeu4TRNqWsznBDXeKLT9Pso35NmpRfI2Mh5x40PhEzI3OCaPMRwtpn2x/YNByD3Zgpvpx
	lH+Ua83kky01ONB3WcDSu/s5c3ugv5GKxjPkM5+QdJqKh26wBtoJHXBBG6lovCh1lmSK0ukIP7OWz
	9MRHDATbUSgI5mRlVJoypgi9jvmIaTXGGHO81/Wf16SH2GYcMMTc1SW+xozMR9VgwwNuQ3wLGneUg
	xy80T3qbxUYFoEN2EI7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlupW-006Qem-1X;
	Thu, 28 Sep 2023 17:29:38 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlupT-006Qe7-10
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 17:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695922175; x=1727458175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+i5DZweb1DmFnq+1NXhKYb+RqfLnbbybywHY7SzT/fw=;
  b=HkknTCjGeumkpRpT2F5Z70j2LhlgXr5ewAKVm1oRk5hKrVeLNtmNZQfh
   011PVcl8zRa6TCBVlLvIuKoIwv/g7GQKkovXYWwu+uQE2sGvYUI/riIKl
   EzMBUH5kKbBaYfd3DwM5Zw2JYFp3UrttEHTbunvXKR0H47EFnnvpooC0L
   nBTGJzuNHimkhi1yCtXueQr9tLvTnmsP0tIVndJ7dIWSv4FlX+QWJZTUX
   VtREdkMHj8MCwUKRIIBz2ZJmI/vebTNbPlXseIiJP73UXK2cWOAg949KV
   /T1/Ac0af7rnB5J9WPXlltVtsbGszm43usReJ9p7H4hoykLyod78JbnmE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="384939685"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="384939685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="743149449"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="743149449"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:29:33 -0700
Message-ID: <b684d339-991d-be85-692c-75f21679ca69@intel.com>
Date: Thu, 28 Sep 2023 10:29:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230927232548.GA20221@skinsburskii.>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_102935_390043_16F19405 
X-CRM114-Status: GOOD (  26.77  )
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

On 9/27/23 16:25, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 06:22:54AM -0700, Dave Hansen wrote:
>> On 9/27/23 09:13, Stanislav Kinsburskii wrote:
>>> Once deposited, these pages can't be accessed by Linux anymore and thus
>>> must be preserved in "used" state across kexec, as hypervisor state is
>>> unware of kexec.
>>
>> If Linux can't access them, they're not RAM any more.  I'd much rather
>> remove them from the memory map and move on with life rather than
>> implement a bunch of new ABI that's got to be handed across kernels.
> 
> Could you elaborate more on the new ABIs? FDT is handled by x86 already,
> and passing it over kexec looks like a natural extension.
> Also, adding more state to it also doens't look like a new ABI.
> Or does it?

FDT makes it easier to pass arbitrary data around, but you're still
creating a new "default_pmpool" device tree node on one end and
consuming it on the other.  That's a new ABI in my book.

> Let me also comment on removing this regions from the memory map. The
> major peculiarity here is that hypervisor distinguish between the pages,
> deposited for guests to rnu and the pages deposited for the Linux root
> partition to keep the guest-related portion of hypervisor state in the
> root partition. And the latter is the matter in question.
> 
> We can indeed isolate and deposit a excessive amount of memory upfront
> in hope that hypervisor will never get into the situation, when it needs
> more memory.
> However, it's not reliable, as the amount of memory will always be an
> estimation, depending on the number of expected guests, guest-attached
> devices, etc. And this becomes even a bigger problem when most of the
> memory is already removed from the memory map to host guest partitions.
> It's also not efficient as the amount of memory required by hypervisor
> can grow or shrink depending on the use case or host configuration, and
> deposting excessive amount of memory will be a waste.
> 
> But, actually, the idea of removing the pages from memory map was
> reflected to some extent in the first version of this proposal,
> so let me elaborate on it a bit.
> 
> Effectively, instead of reserving and depositing a lot of memory to
> hypervisor upfront, the memory can be allocated from kernel memory when
> needed and then returned back when unused.
> This would still require pages removal from the memory map upon kexec,
> but that's another problem.

Let's distill this down a bit.

I agree that it's a waste to reserve an obscene amount of memory up
front for all guests for rare cases.  Having the amount of consumed
memory grow is a nice feature.

You can also quite easily *shrink* the amount of memory on a given
kernel without new code.  Right?

The problem comes when you've grown the footprint of hypervisor-donated
memory, kexec, and *THEN* want to shrink it.  That's what needs new
metadata to be communicated over to the new kernel.

1. Boot some kernel
2. Grow the deposited memory a bunch
3. Kexec
4. Shrink the deposited memory

Right?

That's where you lose me.

Can't the deposited memory just be shrunk before kexec?  Surely there
aren't a bunch of pathological things consuming that memory right before
kexec, which is basically a reboot.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

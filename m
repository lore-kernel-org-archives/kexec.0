Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F13CD6E6E
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tcDaEhePlIudWCcnW0SAhasLmYK5dwxdEw+RSf4P8c=; b=J8mLB9MWDR9ovX5wF8qOv5io66
	/iYN56Ry36P+Auiy1uHMfPpFHy2EaNWg+11wsofOtGwN33/WXoJfO5Knb3OcOgMQ+HAVVmS8PPjlS
	S06Ra3QEUJNoYboohfEdRmT1CajzejJA/H27oxH+IN3q++8b38YYUeXdTpU5gLMA7jReeIIDQOUXA
	2SHxxoP6PopoXzHO+vbws4YvVRBKkrxtFGTYpobGi2ehtjbQuhXDeyb8RSz8P5jtenfG+hgTc6zwg
	ZXHNTcTDZqFI71sdDnyiDB6GYasAyUaYdkMilFRYVXHGBJHSLD16zcbeb7zJPGAx4rQkgU4XF+Zzd
	ItIxcQQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV70z-0000000GhsO-2RGN;
	Thu, 04 Jun 2026 12:17:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV70y-0000000Ghs3-0GcR;
	Thu, 04 Jun 2026 12:17:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 68D8E43FA4;
	Thu,  4 Jun 2026 12:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7A51F00893;
	Thu,  4 Jun 2026 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780575455;
	bh=6tcDaEhePlIudWCcnW0SAhasLmYK5dwxdEw+RSf4P8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eJT1W+a7yBFj5f0F08Rf3p+a5QNdyb2ZOlFDLriNmO2DidwrP1SwEKpexjiYGbXtI
	 mrg493otE2WPbKmxOLVcQEDVxAX81TPqkPR+YF4hP2pW2devqPit639cMGJgjtMQU2
	 AG5qUsLs7SRJ21lXhntgVzwUiRdBV+CiXRLXYlK6qyIFJt6HP6BjhjpLKcTCpN1C2j
	 MdccibZC2LGohJqgT2WVSxIER2+5wQcA79GHLyl16IhYbrBbCKfylMKEou3aoGT+1W
	 lAJpv/fbjL+hlGx0tzVtdTaV/qtZTay37HLuxRbIdBk7BuKOR6T5UqLLfSh4toAoP4
	 y4lbtqS/nGtOA==
Date: Thu, 4 Jun 2026 15:17:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
	kexec@lists.infradead.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
Message-ID: <aiFs0OLJQWtIbJEF@kernel.org>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
 <ahxrc4pTvVU20RTX@kernel.org>
 <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
 <ah_z3GV55RY3ZnT-@kernel.org>
 <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>
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

On Wed, Jun 03, 2026 at 10:25:58AM -0700, Jork Loeser wrote:
> 
> 
> On Wed, 3 Jun 2026, Mike Rapoport wrote:
> 
> > On Mon, Jun 01, 2026 at 01:09:41PM -0700, Jork Loeser wrote:
> > > On Sun, 31 May 2026, Mike Rapoport wrote:
> > > 
> > > > > Patch 19:      Export kexec_in_progress for modules
> > > > 
> > > > Isn't there another way to differentiate kexec reboot?
> > 
> > There's that "kexec reboot" string passed as the cmd to the reboot
> > notifier.
> > Maybe we can make it somehow more well defined API and use it?
> 
> A string? Dear my - the compiler won't flag it on an API change then, not
> ideal clearly. What's wrong with exporting kexec_in_progress()?

The policy in general is avoid exports unless strictly necessary.
A string can be declared as const char *KEXEC_REBOOT = "kexec reboot" and
used in both kexec and mshv. Not ideal, but still better.

No strong feelings from my side, just EXPORT_SYMBOL there felt a bit off.
 
> Best,
> Jork

-- 
Sincerely yours,
Mike.


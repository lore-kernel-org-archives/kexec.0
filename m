Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1BFCD6E6A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YKYxaewRvA3lfBC/tETR3ZEPA7XYWmFAA/XZnPbico=; b=JDGtKULgA8ZonmhHn1EIBenqOK
	GN5N9quZw47GeldJETeJ00Y6n9qO9NT2nl8e9FUSjqnGXkTJPvYVCSeUNqsQxG5iC7TTS9MPmTlhF
	AlUY3Bu/HhHrdRveEmQnu8m3ye1fSvYZnBaygoDhMHVdwoqUQxHbz2eU9h7Sk1Y88dfpWXTkS5bbv
	CIsfK7uWOA+FTy76tCzpe6gzqTBpw/884l/6xR8Ih0/3bUsP54mefpW4FGlICOq2WQRqJl8tJT/bE
	/lZs6OQ1boMp0d6E1oC3mg08kprlTZBdouQB87+twzr4JYMEiNqOqbpihh3ViwIdeXaQjDye/VTgn
	wyJ5h4qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUhuY-0000000Ehxb-38vZ;
	Wed, 03 Jun 2026 09:29:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUhuW-0000000Ehwc-0RbU;
	Wed, 03 Jun 2026 09:29:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E648D4430D;
	Wed,  3 Jun 2026 09:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B8A1F00893;
	Wed,  3 Jun 2026 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780478954;
	bh=0YKYxaewRvA3lfBC/tETR3ZEPA7XYWmFAA/XZnPbico=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aROTsNtP0NwcPyhOGg9EN7SaKgxWgmBik4nkTEgxduPxK5HRWw3N84c9Y+ACmVTN1
	 wgGQ5LmSO16hd/kW00Z44oqbucTBUZSCI5qkU4XBMgLuDQlQoPU5Q7drqrxWizzv3f
	 rrWFolACkQfVjWy8P7nyYRfKI3cGxZO78QELntbROjZh2g+LwBwdTl5Zzy83wMh8Ah
	 +jsOcKbtZk9aA7P96fnDV/449Ef6mxs1KgAP+RaMN8fr1epn59jCUIuT3pzqyXrl2/
	 Cty+iU235/fJlfaqEQKiPp5aeuN6LGB+fM5/HMK485/qyjL0EeNknVF9PU08lbGj8F
	 jYzXoc72/R2Ow==
Date: Wed, 3 Jun 2026 12:29:00 +0300
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
Message-ID: <ah_z3GV55RY3ZnT-@kernel.org>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
 <ahxrc4pTvVU20RTX@kernel.org>
 <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_022916_164891_EBD14BF6 
X-CRM114-Status: GOOD (  11.67  )
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

On Mon, Jun 01, 2026 at 01:09:41PM -0700, Jork Loeser wrote:
> On Sun, 31 May 2026, Mike Rapoport wrote:
> 
> > > Patch 19:      Export kexec_in_progress for modules
> > 
> > Isn't there another way to differentiate kexec reboot?

There's that "kexec reboot" string passed as the cmd to the reboot
notifier.
Maybe we can make it somehow more well defined API and use it?
 
> I could not find one, unfortunately.
> 
> > Sincerely yours,
> > Mike.
> 
> Best,
> Jork

-- 
Sincerely yours,
Mike.


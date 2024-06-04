Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC30C27C52
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WeVA6z6hkF4UU/4ZyHxeHmjDT7LZfNKWlR0WbyCH0Do=; b=Urq5uzHp0SQrxo
	eohpa3u1xUmsmKc6d0D+GSufZ5GVAuhf5CSmKM8IBcnoGBE5T+yXWJeMk0hG8x4Sl4836BB/SDZ0G
	Om7wTt6kU50PN8bBla1pBvr2h5XBo1rcfxsvskPpAzpiYO1XrG6oVHxcBIZZ/RwoeA7BtbqZFV75f
	2WIz7Gqh8tC+inowmpca7tvEh5mI3pamd52RnYwgzyuAUjfjd8szuxICN+XISwOV/0MyifE/fvF7N
	clRF69AXYEDMRU0YBzGtQrea2XzDQskGRionC+q18nQoASQJ3i6rE17azRGdqLuBtwXzZnbDLNW6V
	v7PsioHi7p1CE2D/PWbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYUm-00000003PJJ-0rj9;
	Tue, 04 Jun 2024 18:02:52 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYUj-00000003PHW-17ez
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 18:02:51 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1992040E016E;
	Tue,  4 Jun 2024 18:02:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cMhfAxGU5kPl; Tue,  4 Jun 2024 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717524163; bh=GWrStZRjxuM92GFSBVDFKrufEIiFs1jygww4NQi9psE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLU+I6SnPlxE3Vi8Wxe3ScNZB3EkLajXpOeoexSJ3FsF11DOmq/kF7mUQWCTh2ZZU
	 9zC+xV6TAt4Ah13vFL2KhnpeImQh5VqXLrXNCRxgdqmPuwF/2lM+rMy/J4yj4Iozin
	 ZxTnySap2CgtkGMC9pdh3ly0va5Ab2W92LnO+AaAjUsYECWulD852NoRmi59uFRFfU
	 72PgimdmMwcBk0tvmwsfVjcFEczVP9MQnuu4DKwdb8Sc7lOB+dIw/7406ijBYvLDS3
	 b07CVT9qArX/RZjTB+qzs9rI0AfKYtNuRqP+YF+HaJPYra36zyWQ2mAMZE0hpL/ZAc
	 BPWBKnbypK0uhFRN23NWzm/KCqpEWOShUSmPDaIGJebyCKUafVrsVelPv36dLxzxH7
	 uvDy4Lm1OXwjTEnCvLQVj+3ePXJ1qXVcnsEE4Ie0oO0I0A7dhS1FRyuHujx94CEY+p
	 ZlAsAnS98zWsf5NoLQSrMoJ548mt0Hu8T6gCJN1CLkwqcX5ErL2aTWMb8iIXGlZpxQ
	 DTTlQ7UKT4e2wsy/0C9wHlbpIynoCuu3EpPYAu9jiQvD8OWDe3+nypU5dr7ChFcwLp
	 eg1R8UeQgPrdpM4heVAXU4L3nloB0w/+1MUkg/RNSYuKWIjoRUPTgMUrp2BvirSN17
	 C96SzSZAINkxGsML4ERfHRHc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B340740E016A;
	Tue,  4 Jun 2024 18:02:13 +0000 (UTC)
Date: Tue, 4 Jun 2024 20:02:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
 <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_110249_473967_2226C2FD 
X-CRM114-Status: UNSURE (   8.83  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jun 04, 2024 at 07:09:56PM +0800, Dave Young wrote:
> Anyway there is not such a helper for all cases.

But maybe there should be...

This is not the first case where the need arises to be able to say:

	if (am I a kexeced kernel)

in code.

Perhaps we should have a global var kexeced or so which gets incremented
on each kexec-ed kernel, somewhere in very early boot of the kexec-ed
kernel we do

	kexeced++;

and then other code can query it and know whether this is a kexec-ed
kernel and how many times it got kexec-ed...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

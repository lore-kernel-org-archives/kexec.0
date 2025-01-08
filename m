Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F9EE77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUnPsKgtfCLP8/mvdYAfN7xgpNnrdA4BcrGL+u8Fii4=; b=BK7D0oN2LntrmsC0TCJLc6VuhS
	nqV1CF/rKpibu/wbyVfmPLAdCoMvUO2RKIrYKZp+2dk6kHqijhtV/PbtqxlzcDplIg6x5jafQSUUq
	K/ISJALjeyyj0xaQG2FuQZ2CY3KtechUrmaEnD8RczE+OgvdO2cH5pG3iGkNL5tEAc/uPFGXrDzsz
	ezs4lnuhCIDQh/088ges5mjzHD8GzKqx6XjwMH47FWe2tQc+sIrfTE1t25C+IvLAnXwuMy4PyFp6P
	rN7KtmH+yWsrZDlhdesNvAj4L+NYjrHKH8QfjyeOzVgMG+H7JjpZzKfogRW3g9TADt2FTQJDkYhHw
	3yZcV2xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVWS2-00000008gNJ-0GsR;
	Wed, 08 Jan 2025 13:50:26 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVWRx-00000008gMA-1pzc
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 13:50:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CFA13D5;
	Wed,  8 Jan 2025 05:50:48 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 179663F673;
	Wed,  8 Jan 2025 05:50:16 -0800 (PST)
Date: Wed, 8 Jan 2025 13:50:14 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
Message-ID: <Z36Cljsz2p0hYsFd@e133380.arm.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
 <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_055021_520577_2FB4B571 
X-CRM114-Status: GOOD (  14.71  )
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

On Wed, Jan 08, 2025 at 01:53:51PM +0900, Akihiko Odaki wrote:
> On 2025/01/08 1:17, Dave Martin wrote:
> > Hi,
> > 
> > On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
> > > Use note name macros to match with the userspace's expectation.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
> > >   1 file changed, 23 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> > 
> > [...]

> > > +#define NT_INIT(buf, type, desc) \
> > > +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))

[...]

> > (Note also, the outer parentheses and the parentheses around (buf)
> > appear redundant -- although harmless?)
> 
> They only make a difference in trivial corner cases and may look needlessly
> verbose.

(In case there was a misunderstanding here, I meant that some
parentheses can be removed without affecting correctness:

#define NT_INIT(buf, type, desc) \
	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type))

It still doesn't matter though -- and some people do prefer to be
defensive anyway and err on the side of having too many parentheses
rather than too few.)

[...]

Cheers
---Dave


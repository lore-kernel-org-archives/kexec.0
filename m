Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAECE77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YVgIS/5ZlAwoAZTi+PHEKdEfNzJGY2kEocFY8AfogE=; b=urCtcWYqWLe5pnrxNYErNhU+Rl
	Fk6klMj2sgUWZ8eFzafhEhP08EimYqItPRruI6dauW9nyYsRxs9wwNLzp47sm+mJ9kYlnDSYjL0Vq
	P6f4QIkU4p+jfUZrdeCONmdnJUP3DA7XipY7lEO38FaVDC2hPi7rXFGDc60x8Sxzy6liZLeyYRbub
	Q18S7zJzzhL3p3Z8WRMYki/raDCAuqWTW3E45/3iVa8SHud3nCK1J3tljUsI+56tAvTTqy4ZVHiv1
	hjwwlF4YkzUDpMBZDD6fX0mZojCGOMjUf+0GJwKhabc7fi6/9/dp7NsZ4Kh5+tD+QQlwNlvPu1V8T
	6gDIlc9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVrKj-0000000Bo2x-437n;
	Thu, 09 Jan 2025 12:08:17 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVrKf-0000000Bo2S-0LzM
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 12:08:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABC712FC;
	Thu,  9 Jan 2025 04:08:37 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD483F673;
	Thu,  9 Jan 2025 04:08:06 -0800 (PST)
Date: Thu, 9 Jan 2025 12:08:04 +0000
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
Message-ID: <Z3+8JGoiUyPFYGE8@e133380.arm.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
 <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
 <Z36Cljsz2p0hYsFd@e133380.arm.com>
 <2ad7234d-bfc5-49e3-abe6-7a85d992329d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad7234d-bfc5-49e3-abe6-7a85d992329d@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_040813_183325_93BA88EE 
X-CRM114-Status: GOOD (  23.14  )
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

Hi,

On Thu, Jan 09, 2025 at 02:29:19PM +0900, Akihiko Odaki wrote:
> On 2025/01/08 22:50, Dave Martin wrote:
> > On Wed, Jan 08, 2025 at 01:53:51PM +0900, Akihiko Odaki wrote:
> > > On 2025/01/08 1:17, Dave Martin wrote:
> > > > Hi,
> > > > 
> > > > On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
> > > > > Use note name macros to match with the userspace's expectation.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > ---
> > > > >    arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
> > > > >    1 file changed, 23 insertions(+), 39 deletions(-)
> > > > > 
> > > > > diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> > > > 
> > > > [...]
> > 
> > > > > +#define NT_INIT(buf, type, desc) \
> > > > > +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> > 
> > [...]
> > 
> > > > (Note also, the outer parentheses and the parentheses around (buf)
> > > > appear redundant -- although harmless?)
> > > 
> > > They only make a difference in trivial corner cases and may look needlessly
> > > verbose.
> > 
> > (In case there was a misunderstanding here, I meant that some
> > parentheses can be removed without affecting correctness:
> > 
> > #define NT_INIT(buf, type, desc) \
> > 	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> > 
> > It still doesn't matter though -- and some people do prefer to be
> > defensive anyway and err on the side of having too many parentheses
> > rather than too few.)
> 
> Well, being very pedantic, there are some cases where these parentheses have
> some effect.
> 
> If you omit the outer parentheses, the following code will have different
> consequences:
> a->NT_INIT(buf, PRSTATUS, desc)
> 
> The parentheses around buf will make difference for the following code:
> #define COMMA ,
> NT_INIT(NULL COMMA buf, PRSTATUS, desc)
> 
> But nobody will write such code.

Ah, it looks like you're right on both!

Apologies for the noise.

(I must try find a neat use for these...)

Cheers
---Dave


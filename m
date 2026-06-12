Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80166CD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xNfxQa1vwlWCvaXRQjFfS1B0XulfLE64TNHTVCMhrdo=; b=VBtsl5dQUyUb3QqhPKJbsw+4wf
	6PHx4UeRv7RqQWPHYw/T6IOg5BLChIlH4JonUcLPIQ/L08AQrakEhQhd1xwTjNtuMHV4GaMkPl5Rr
	EbMKW+MyDislMBRApc6L1cTbBhGihtnk5ep3T9lOlvPXSGxW7l9sB91q3OkzxjeyDbebk31OCMaY1
	TWuydpzCxfR179wxE8dRECjP4dGrrq32/91fOS9iLqkBzaqVKkfAqPJuB6KFlYs9TYwAwSuDXzge6
	S5Ip30iM1gvE3bunCM/3ehL4F7+ju4GTpbEmcTNmPZkBE8gs+8A0YMCnrpO/7n1fDfBDO6wcXIgXT
	mV+Nm3ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXvtm-0000000ARzn-1ZBH;
	Fri, 12 Jun 2026 07:01:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXvtl-0000000ARzW-2P7w
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 07:01:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EA7643A4E;
	Fri, 12 Jun 2026 07:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390011F000E9;
	Fri, 12 Jun 2026 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781247708;
	bh=xNfxQa1vwlWCvaXRQjFfS1B0XulfLE64TNHTVCMhrdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k1E2EpB1k5J7CBcJb6cpSck/EYkFoXJ/XOO8TUkLoNokPwku9IASWmksUIjVGuaRH
	 Sij34V1NILT409NuiOjlzlPDCOF6WV5EPJzJoL1kBnHa9F0FmprR92wqyJZDi09Ir7
	 94eMUFLAmJRdhzNRpiPMevc2+a4sqlCWfkh0ad0B7H1CBFM7wbDYuOqlpb5+ciBe2a
	 AL8VsQs40bUw6r7aiXBtZzfjX7RfbFq/dn4cfFzq/hXbtb9FbFDu5ZI92fvM3n5OMa
	 OfpmLLwptq4WD9EWd9O/znlGB1UnsWh/GDlyLkYy5ehoDsF8692YWhg900C28x+Ya+
	 YQ4V0+5oJNb5w==
Date: Fri, 12 Jun 2026 10:01:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
Message-ID: <aiuu1QzAk_pkQKNV@kernel.org>
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
 <aiqso7rkpX6oMer7@kernel.org>
 <2vxzmrx1qjuf.fsf@kernel.org>
 <airGIioUmTtU9326@kernel.org>
 <air5ho0LOIEKVzRG@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <air5ho0LOIEKVzRG@plex>
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

On Thu, Jun 11, 2026 at 06:11:13PM +0000, Pasha Tatashin wrote:
> On 06-11 17:28, Mike Rapoport wrote:
> > On Thu, Jun 11, 2026 at 03:37:12PM +0200, Pratyush Yadav wrote:
> > > On Thu, Jun 11 2026, Mike Rapoport wrote:
> > > 
> > > > On Thu, Jun 11, 2026 at 10:30:03AM +0000, Tarun Sahu wrote:
> > > >> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> > > >> on args->serialized_data before checking if the physical address is valid.
> > > >> Since physical address 0 does not map to virtual NULL (due to direct
> > > >> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> > > >> catching a missing serialized_data, leading to unsafe dereferences later.
> > > >> 
> > > >> Validate that args->serialized_data is non-zero before calling
> > > >> phys_to_virt().
> > > >> 
> > > >> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> > > >> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> > > >> ---
> > > >>  mm/memfd_luo.c | 10 ++++++----
> > > >>  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >> 
> > > >> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> > > >> index 59de210bee5f..10f3983b0060 100644
> > > >> --- a/mm/memfd_luo.c
> > > >> +++ b/mm/memfd_luo.c
> > > >> @@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
> > > >>  	if (args->retrieve_status)
> > > >>  		return;
> > > >>  
> > > >> -	ser = phys_to_virt(args->serialized_data);
> > > >> -	if (!ser)
> > > >> +	if (!args->serialized_data)
> > > >
> > > > We really should make args->serialized_data a KHOSER_PTR
> > > 
> > > Hmm, that would also be a good idea. I suppose then it would be a better
> > > to directly convert to using KHOSER_PTR() instead of this patch?
> > 
> > Makes sense.
> 
> I think we should systematically cover all  phys_to_virt  conversions 
> and add  KOSHER_PTR() , instead of an ad-hoc approach of adding it as we 
> go. So, let's take this patch and do a series where we properly convert 
> everything and provide guidance for others to use going forward.

It's too late for this patch for -rc1. So let's systematically convert all
4 or 5 direct phys_to_virt() conversions in the next cycle and be done with
it.

We have enough time to make it by -rc2.
 
> Pasha

-- 
Sincerely yours,
Mike.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B00ECA0EE5
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXAZlCNvGhjj0PAqYX6z5I/kzH1X3h8hNhZCWturzEE=; b=vHWKrwyFql9XCs8Wfxh9722GoS
	Css8w93xUN/0obLKOiRZJKYMZwi40Jpf0oQyWUDooNtDwAaXZMZ6QXDFMArXs3s+IWAPf/+EUA0hh
	ha3ItqPtXdQQQHOgU7GEh2qlmOQeK6hhJsKy0DjIOr/bDbtxzvobi7F8mpa9muawltNPdPo+zVDsi
	CGnRqi2dnTVqw30T13VQmirfp9IlDaeWQjuTMrFDja0ETBbjFa6kGqOuzP4Jd/AitPi4cZaErbcqH
	BSXNA4XFH2B1PNiR4C4EsLQthH1IN0oeLg9SjPVnGQEZlESRS5dxvOv3QuNhM5cMANU1tXgFR6q4U
	s2RDxuJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umCMP-0000000DtbS-2DZV;
	Wed, 13 Aug 2025 14:21:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umC8n-0000000DsOB-3S2b
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 14:07:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4555A601F3;
	Wed, 13 Aug 2025 14:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74674C4CEEB;
	Wed, 13 Aug 2025 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755094065;
	bh=zcy05gnuZEZXeY7AcRHHwUP4PLtQj6zb6GUfETiaQHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGLp84KU+EeT4RVlZZn1mxWiEgYlbumqzXI8nKzbJxjlVREp+Zs6ALnfyvnMfFErF
	 31fMPzmEx4EHqHpO6Wu+CvDMTmtPDQeTuasIg9iW97uzRuAkFrD3HVlkLpkJtdUC0l
	 ISlqWHNAoicN7z74YGHwCmCT5XmgE13ppqLFcXudAJlJePhowH/MHE5zDptawuAka/
	 PGrwr9CP1+eBvTPWXq0sof73YzBVS30gLU2D1l7w1WTv2nEV7hmDkoo9ZjYPVRVx+v
	 Z3z3FIshqVLGS6KWgkksnaZeqt4mLN6fbPaYtpbZk+O1/boH4govioIDHsln6O521V
	 nqV9cl+peU80A==
Date: Wed, 13 Aug 2025 17:07:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Weischuh <linux@weissschuh.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] kho: allow scratch areas with zero size
Message-ID: <aJycKRCEqbW0pgwR@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
 <20250811082510.4154080-2-rppt@kernel.org>
 <mafs0349vwd1i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0349vwd1i.fsf@kernel.org>
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

On Wed, Aug 13, 2025 at 03:45:29PM +0200, Pratyush Yadav wrote:
> On Mon, Aug 11 2025, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Parsing of kho_scratch parameter treats zero size as an invalid value,
> > although it should be fine for user to request zero sized scratch area
> > for some types if scratch memory, when for example there is no need to
> > create scratch area in the low memory.
> 
> Can the system boot with 0 per-node memory? If not, then perhaps we
> should only allow lowmem scratch to be zero?

In most cases yes because most of boot time allocations have fallback to
"any node".
And there's also an option to omit the "global" scratch and boot with only
per-node scratch areas, so I'd keep the possibility of setting any of these
to 0.

> > Treat zero as a valid value for a scratch area size but reject
> > kho_scratch parameter that defines no scratch memory at all.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  kernel/kexec_handover.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index e49743ae52c5..c6ac5a5e51cb 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
> >  {
> >  	size_t len;
> >  	unsigned long sizes[3];
> > +	size_t total_size = 0;
> >  	int i;
> >  
> >  	if (!p)
> > @@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
> >  		}
> >  
> >  		sizes[i] = memparse(p, &endp);
> > -		if (!sizes[i] || endp == p)
> > +		if (endp == p)
> >  			return -EINVAL;
> >  		p = endp;
> > +		total_size += sizes[i];
> >  	}
> >  
> > +	if (!total_size)
> > +		return -EINVAL;
> > +
> 
> Looks good. BTW, unrelated to this patch, but should we also check that
> p == '\0' here to make sure the whole argument was consumed?

Care to send a patch? ;-) 
 
> >  	scratch_size_lowmem = sizes[0];
> >  	scratch_size_global = sizes[1];
> >  	scratch_size_pernode = sizes[2];
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


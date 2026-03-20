Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FF8108B8ED
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBBrP+dJlC8xCC1p9KU1pC4ESzqrQhTEbPEnQfQ8Eyw=; b=WGd8Pn2LfoMC/Jbm81/SxIFUtB
	Og/UZ8CLhSEHVQCFlzoqKN5WWKBBUwkzLU9tmJqZGW3GLpKPp/GaPLYYIfpXkFpPLobJoPTOo9BcG
	kxoeFh0j1iljN3nWhieiolUuqKIEHOJkICieNts+xNJpXP6Z0nkkjZ3KFZ2rXsGPFFkYEzOhVbZlg
	OANNJ0H6vpkgXCvhTiewlmb6Xoy8tZaGFc2b2Ctxs/t5JzrHGAM9Y9SdMtKqvUIbXW36uEjKsOjl6
	awOQ23LVS1VVJ657eskn3LxaVn05c1FNLFqE/w8ajfoA1TjQSuHIyd4yeOR6IJWxuqximPG9rXlI2
	o2HIBLAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3X1a-0000000Ca9T-2BBp;
	Fri, 20 Mar 2026 10:24:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3X1Z-0000000Ca9E-2WkH
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 10:24:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B837660126;
	Fri, 20 Mar 2026 10:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF9C4CEF7;
	Fri, 20 Mar 2026 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774002252;
	bh=Wn5jstUr6dOBAVU09O9JpAI9Bd4XixCEsjnU1Cfj78w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L9ltC+2PmAsjD6RD3FhjaLQ88mtFPqKCZ5e5wnXlbMD0IE9ci1RMSYc2iX7AMzX2x
	 FjYVkT+gjdl/yDn4ixlebZZ+2qW2aDJguNj3A/VBCQP9agUS4lHl8yk0KWw9VvMIXO
	 J7vr5Wg3QsfH7xzwVn0AgUtwCcaD/g2GsqkxKns3rKpMmSp2LxSdLI2Z4E9rk+133W
	 JG7fXKrDdeY4Z1Ksm/FRtx1S1+r14I/wUqQVqO6Ge7JvNdImtPHqNsEPwMm2rZUfJv
	 uOkHS/OYVXSHVS3P/53PHq+FigYnABJvBNjGBfIb924tCSOAW91pKd6lCAKkX/1ygE
	 hJ3HQ35zk27RA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: drop restriction on maximum page order
In-Reply-To: <abk1L_gpK7Ys4TK5@kernel.org> (Mike Rapoport's message of "Tue,
	17 Mar 2026 13:04:15 +0200")
References: <20260309123410.382308-1-pratyush@kernel.org>
	<20260309123410.382308-2-pratyush@kernel.org>
	<aa_zglmh3AU2_RA0@kernel.org> <2vxzo6kmddl8.fsf@kernel.org>
	<abk1L_gpK7Ys4TK5@kernel.org>
Date: Fri, 20 Mar 2026 10:24:08 +0000
Message-ID: <2vxzy0jmajef.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Mar 17 2026, Mike Rapoport wrote:

> On Tue, Mar 17, 2026 at 09:12:19AM +0000, Pratyush Yadav wrote:
>> On Tue, Mar 10 2026, Mike Rapoport wrote:
>> 
>> > On Mon, Mar 09, 2026 at 12:34:07PM +0000, Pratyush Yadav wrote:
>> >> KHO currently restricts the maximum order of a restored page to the
>> >> maximum order supported by the buddy allocator. While this works fine
>> >> for much of the data passed across kexec, it is possible to have pages
>> >> larger than MAX_PAGE_ORDER.
>> >> 
>> >> For one, it is possible to get a larger order when using
>> >> kho_preserve_pages() if the number of pages is large enough, since it
>> >> tries to combine multiple aligned 0-order preservations into one higher
>> >> order preservation.
>> >> 
>> >> For another, upcoming support for hugepages can have gigantic hugepages
>> >> being preserved over KHO.
>> >> 
>> >> There is no real reason for this limit. The KHO preservation machinery
>> >> can handle any page order. Remove this artificial restriction on max
>> >> page order.
>> >> 
>> >> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> >
>> > One SOB should be enough ;-)
>> 
>> Hmm, I figured the unemployed me (who originally wrote the patch) and
>> the employed-by-google me (who is doing this new version) would count as
>> two separate entities and there should be a S-o-b for both.
>
> Maybe than something like:
>
> Signed-off-by: Pratyush Yadav (Hobbyist) <pratyush@kernel.org>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>  
> ;-)
>
Yeah, that works too :-)

I'll use that when I redo some of the HugeTLB patches too

-- 
Regards,
Pratyush Yadav


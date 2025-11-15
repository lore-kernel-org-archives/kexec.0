Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF03CEB2C7
	for <kexec@archiver.kernel.org>; Sat, 15 Nov 2025 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hI9GPURT1FrsbraIOg+c5sfJwIq07JD/MQ/pZOvc0Io=; b=FBYt7YhlBFy5qIU8DxPb2VhniS
	B63iwb6CNDw+7OBBuV3po4hMmoC+SJJsVVB7fMSAOefEZa3pkMbTwFRNwDcjXkKWixov4P3yfyfmH
	nVETXUuyFgPo8n4ojfd3m5nuMlT6B5R4jOuUn3v67oNjoAwwUdoi7SVyhZJvoNa2bEhoTG406GPWe
	gVjxZ1mLuIPPhRYwq/wtjpQhAd6SqfDOxndrA69B+P3IFPAk2OWAnSq18k9F+ykpNNMT/oAKnX2Re
	gW1UiPByOxDA24kq/lfio/Vq+GQAG6y412kV2G476+u6hOqetJRfIrKqZ09FJwkI6jjYLcCsOpAri
	RpMVnEkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKCnL-0000000DexT-3Kxr;
	Sat, 15 Nov 2025 09:42:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKCnJ-0000000Dex3-2GC7
	for kexec@lists.infradead.org;
	Sat, 15 Nov 2025 09:42:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0724D43880;
	Sat, 15 Nov 2025 09:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D638C113D0;
	Sat, 15 Nov 2025 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763199727;
	bh=5TLcwJDDFiBtj7lJVJ9lPhvDhUna9We8VbF9X0zLOfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVE7FFfcnStH8/zqhoWCvqwopCxelotqfG4sYk/BiaxyZy1UEJbCr94sYXbNJHav4
	 Y3x4oN5eUZmh/GhUDL2b28zkgS2SIu05fnQ6STStSprGS+E1o2ohQ4DaRgT9bZ1eg2
	 oV2Fh+N/VH2TdbPJcobloEaC3F6G4cMn1Feev7xyebN+UmwsMLWWj/Up8lenQsdTFn
	 twFkMiK5B9gfWBoXnKKn8hQcW0k4WwcoqJZV14JAxtpvPKCQKm9iMdmwObnqo5HSV0
	 991oTRVul8vfpew05xw2F3A5UQbwRWcUrl4F4alp0931iG8fkbF5OnAuro2wJNSzIB
	 Q9J0OECjcwi+g==
Date: Sat, 15 Nov 2025 11:42:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, graf@amazon.com, pratyush@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
Message-ID: <aRhK6dBs6ZwEz9Md@kernel.org>
References: <20251110180715.602807-1-pasha.tatashin@soleen.com>
 <aRbag7qR9OVNAQXN@kernel.org>
 <CA+CK2bD+ZseJ_6GUMV7d=8xpUcWW6jzJBdJRy7kQmez_2sMYUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bD+ZseJ_6GUMV7d=8xpUcWW6jzJBdJRy7kQmez_2sMYUQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_014209_598103_B4C42EF1 
X-CRM114-Status: GOOD (  12.42  )
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

On Fri, Nov 14, 2025 at 09:13:01AM -0500, Pasha Tatashin wrote:
> On Fri, Nov 14, 2025 at 2:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Nov 10, 2025 at 01:07:15PM -0500, Pasha Tatashin wrote:
> > > Upcoming LUO requires KHO for its operations, the requirement to place
> > > both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
> > > by default.
> >
> > I though more about this and it seems too much of a change. kho=1 enables
> > scratch areas and that significantly changes how free pages are distributed
> > in the free lists.
> >
> > Let's go with a Kconfig option we discussed of-list:
> > (this is on top of the current mmotm/mm-nonmm-unstable)
> 
> I will include this into the KHO simplification series

Please add Alex's Reviewed-by as well.

-- 
Sincerely yours,
Mike.


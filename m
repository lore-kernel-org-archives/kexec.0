Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF18CD6E44
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mak8BcDRmJI9QTAk7PBzShu7AY5kBLAAqcpwHsNXbNo=; b=YsHqOc8jOGyrlwc39RU7+xPo0+
	ufockQ6RpdW3sqqhtn9D99NXvWAlwVzPfjdh6KmOORMC4tn41dOdOkaxrD9LPMrP9pTXADuKfe4JC
	A6SU3OOfLI/qC5IoirB/eYRO+8O8B31gzxrxKreMBsWG9w/YByac0AboMW3L2LHU0pwXezDFw4LyM
	PrH269REdd5r+PdwLVfrM3eJPzN9r/Pyy/TMombWhuR7h24ki1rKge5l3Egzib9As/zkpd2cV0dLa
	ocY8JLA1pYQsjqVZYgFpPYpx1SGpK0VwLFj7JLL3HNVAW6Adyq9XI+KNLud0dwkPgB7ZC93v7AoDj
	8ddGtAKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSc5X-00000005skK-2LyC;
	Thu, 28 May 2026 14:51:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSc5U-00000005sjb-2tik
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 14:51:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 048E940B55;
	Thu, 28 May 2026 14:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC81F000E9;
	Thu, 28 May 2026 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779979915;
	bh=mak8BcDRmJI9QTAk7PBzShu7AY5kBLAAqcpwHsNXbNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uwp9VVVlovjSGtHdqmf9FDdQqQcGbFNt+BgKqZ+lBhGJS8evJUIMk6guf3KfKHcg3
	 UfiNS+sgaTVfYr9eIcBK3aDZy1MFXYN/Bi/+vaeF8GYN94P7oafAntf0JS3KUf+JER
	 tI0H2Ida5sJmysfH1nljjpNMpOxFH1/LXYiS9K0Axpmhqob5+vwIwjK7NuGkIGDQsM
	 7jsVEp+iFtvZACdjK0tjg0ECdgYGaA9isRlBhzIHbrA/R1XUpiLW+e0P0TV0kk7row
	 jP1MbP+/8xMwhNyuqvGJcCtFjWJEUWtBgd42uoWcjc9LSDKT7GwPlKwSLbWfNqHAUl
	 GxAMXX2OD/jiA==
Date: Thu, 28 May 2026 17:51:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, sourabhjain@linux.ibm.com,
	jbouron@amazon.com, akpm@linux-foundation.org, error27@gmail.com,
	bhe@redhat.com, linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com, piliu@redhat.com,
	kexec@lists.infradead.org, skhawaja@google.com, graf@amazon.com,
	mario.limonciello@amd.com
Subject: Re: [PATCH v6 3/5] liveupdate: block session mutations during reboot
Message-ID: <ahhWgyYC-OJwBYgq@kernel.org>
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
 <20260527202737.1345192-4-pasha.tatashin@soleen.com>
 <2vxzv7c739a2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzv7c739a2.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_075156_750453_2A34D1B1 
X-CRM114-Status: GOOD (  18.50  )
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

On Thu, May 28, 2026 at 04:20:53PM +0200, Pratyush Yadav wrote:
> On Wed, May 27 2026, Pasha Tatashin wrote:
> 
> > During the reboot() syscall, user processes may still be running
> > concurrently and attempting to mutate sessions (e.g., creating,
> > retrieving, or releasing sessions). To prevent this, introduce
> > luo_session_serialize_rwsem to synchronize mutations with the
> > serialization process.
> >
> > All session mutation operations (create, retrieve, release, ioctl) take
> > the read lock. The serialization process (luo_session_serialize) takes
> > the write lock and holds it indefinitely on success. This effectively
> > freezes the LUO session subsystem during the transition to the new
> > kernel. If serialization fails, the lock is released to allow recovery.
> >
> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> > Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/luo_session.c | 56 +++++++++++++++++++++++++++++++--
> >  1 file changed, 53 insertions(+), 3 deletions(-)
> >  
> > +/*
> > + * Protects session mutations during serialization. All session mutation
> > + * operations must hold the read lock. The serialization process holds the write
> > + * lock indefinitely on success to block all concurrent and future mutations.
> > + */
> 
> Nit: this comment is redundant now. I guess you can remove this when
> applying.

Done :)
 
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> 
> > +static DECLARE_RWSEM(luo_session_serialize_rwsem);
> > +
> >  /**
> >   * struct luo_session_header - Header struct for managing LUO sessions.
> >   * @count:      The number of sessions currently tracked in the @list.
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6021BC3DA41
	for <kexec@archiver.kernel.org>; Tue,  9 Jul 2024 07:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7yZcMHVftyOPiO7YiKUyGbmjTIkYWaAe+hIVu5j0CoI=; b=qeANABZxvnpKot
	Kz8UBGapE/li6/cOfuqUQKXw6jwvKIGThVKnu4Tum0HCKUnY26jrn328eeFZpZFJBWhUy9PvysEIT
	ixM1r33RahHCcJM6YLQ4XoMxAs+rX9Wo0KYxKSnDlAFDlBV69QL0Gi1cYBq8vaEVJlBQqZ78+yJH+
	5HIkEXdmqZl0b1RdV7w1BvRo9pQ8qTXZy4RjWUhO9swFjmYFY2jjZyUPuWD8tHvDRQw8A7LQj4X4+
	cPcxWQRGUOQLoeNq1h/cK0XJI0dYKqTZFY3NgMCVoBxK15PwfVl7tEyrHsOfCVb707A3Tcu+DI0AD
	6zD/K5OqTJQMs3+vS+uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR5Bx-00000006DlG-25cE;
	Tue, 09 Jul 2024 07:23:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR5Bt-00000006Dki-0nkQ
	for kexec@lists.infradead.org;
	Tue, 09 Jul 2024 07:23:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3F70A60F3E;
	Tue,  9 Jul 2024 07:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE38C3277B;
	Tue,  9 Jul 2024 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720509787;
	bh=NxNRYtDnVXEWtZR/Hk5E/9vVJXMuEtLaY/D1HoPqNJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsDylTz3Fm7AF/PShtN/tRTfrZNZcleNGucR4idntNkgYIf9/G1biDIqWLXi+hQca
	 HbXTHcNAyVErZKKlvaj50VWTpSH2wlgldY9VuLxS6Ar94fvgjgiCr5wSnnHu9zMCXj
	 A89cXyelI+l2qrz8NkkVjnSoP6oQJLOvS+vP235PX6p2b91z2gDcts/XYBRW3i4X/v
	 d3PBMssJ8PmM7FFo9nYBLvQ0QBAH7fz0ZUXzc6xsFwKNdP8tLthfABAuJ2HBNEwHXN
	 XUnYm8V5ATmWbpA3KCPj4zpj7TFzCXMtTZbfOCsAW9G8zytoLGLdey50+jXkmhuNtV
	 b1JLP3hj56nSA==
Date: Tue, 9 Jul 2024 08:23:04 +0100
From: Simon Horman <horms@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [ANNOUNCE] kexec-tools v2.0.29 preparation
Message-ID: <20240709072304.GA346094@kernel.org>
References: <20240704121517.GA1088210@kernel.org>
 <f0f36b28-c229-40ca-a10c-cbf0ebade4a3@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0f36b28-c229-40ca-a10c-cbf0ebade4a3@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_002309_312862_657E856D 
X-CRM114-Status: GOOD (  13.26  )
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

On Sun, Jul 07, 2024 at 09:00:18PM +0530, Sourabh Jain wrote:
> Hello Simon,
> 
> On 04/07/24 17:45, Simon Horman wrote:
> > Hi all,
> > 
> > I am planning to release kexec-tools v2.0.29 in the next two weeks
> > to roughly coincide with the release of the v6.10 kernel.
> > 
> > I would like to ask interested parties to send any patches they would like
> > included in v2.0.29 within one week so they can be considered for inclusion
> > in an rc release.
> 
> It would be helpful if we could consider the below patch series for the
> v2.0.29 release.
> https://lore.kernel.org/all/20240707152456.87899-1-sourabhjain@linux.ibm.com/

Sure, will do.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

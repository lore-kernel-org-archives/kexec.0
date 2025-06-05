Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AD0C5B543
	for <kexec@archiver.kernel.org>; Thu,  5 Jun 2025 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hLwMfR1Aa87ykuWu5Baq3mYoZv/8fuiFeJBcWscS13g=; b=NZ7hP+VDhAH7mrokFLXAqJYohg
	pgB2xhV6wf7Tj+X2m3CAJ+sitkB6D+2T3M5rR037AVBj9K0zoCBxaVK4LBJ24mR1RARbmVecxtLZ7
	Dsi62aFCjnXkpKcEQ4z6FfOGVaHJGtplsiIKTbyWApHClUb8fF52GERKPk6cb2E9Q1Pr03f+Xpkki
	a0oi3IdD3uIdJFjdJdZ6oleRyENFzPCkMMTTnBT6S0G9dSxrhQYKZDZnbXkmOHoyFcgroHWOk9LGU
	Ac9UTWFz2c1d/aeeliGd6R2nIqOq+fzTMJaYwbqXRqpCqdVk5Miotk7zX3MR81aj5qW6wTnAEmEOs
	pKRoNC4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNGyJ-0000000GZcI-3WyI;
	Thu, 05 Jun 2025 20:13:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNGyH-0000000GZbu-2Pa7
	for kexec@lists.infradead.org;
	Thu, 05 Jun 2025 20:13:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 420365C418C;
	Thu,  5 Jun 2025 20:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C96BC4CEE7;
	Thu,  5 Jun 2025 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749154432;
	bh=ZMhXG3ijLnG2wlKkqX2hbJc9K+bPFna5WC+U9pMyo5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=taQLEAK8GC6OoDR+R6i4qOHPp1PQGGb9NU3CWa8ZHX0tKCq4HOknxwH7ATYrW09fD
	 RxvF3qXGoapEdwnccpFhegiNxBSSa3xKK8kA02HahjWsGpc2/fPYf3cDrKeNWGQckN
	 ndvCSN9zcRyv9RqyZm2c0OJPqmwuqHF5CX67wcJg=
Date: Thu, 5 Jun 2025 13:13:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Pratyush Yadav
 <ptyadav@amazon.de>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
Message-Id: <20250605131351.1500f8b434e4c99ce8803e39@linux-foundation.org>
In-Reply-To: <20250605171143.76963-1-pratyush@kernel.org>
References: <20250605171143.76963-1-pratyush@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_131353_666084_EC6F7187 
X-CRM114-Status: UNSURE (   8.52  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu,  5 Jun 2025 19:11:41 +0200 Pratyush Yadav <pratyush@kernel.org> wrote:

> Side note: get_maintainers.pl for KHO only lists kexec@ as the mailing list.
> Since KHO has a bunch of MM bits as well, should we also add linux-mm@ to its
> MAINTAINERS entry?

I think so.  Please send a patch?


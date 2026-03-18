Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D618BFF6E9A
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 00:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2oVu9ksQNj/e5JgdTWpYKPNwUPUtNRXv9Wg/HKvtX4I=; b=2yJ++4wrq4Qnb80w22rybGVbw1
	sPjX54yVGoxfu87gRNQdfDPMpEsAMkb3l4/1kvmFuF+P1dwm3Rce2jY/ujIPjobgde28T3T9wqw4O
	ZU82z/AtOZDcxYHmqwzeejqNk2x14Z6ctqiXxMAqCGaHWKVq0l4esoq+K1JOkTIG4ua7wON1ibDEh
	uCQ4EGAFk694BWzqkC/qzEPLEF43BY6Iv3R24awwVfcpIh+18mHJ+7cekyWelKVsByrT8/Zs5WxFg
	Cl0kwFHf8m4O4Le1xGFHwVR+kaTxkOys25oc2ug8XCApUS5FJHELwO3a+YtwQ7JqDh/u16/iP/5Zs
	e3qDZOMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2egt-00000007V9H-3EkF;
	Wed, 18 Mar 2026 00:23:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2egr-00000007V8w-0cvw
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 00:23:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E5D8B42AFD;
	Wed, 18 Mar 2026 00:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCB3C4CEF7;
	Wed, 18 Mar 2026 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773793391;
	bh=7txtIWm0nG5xhM6ymroYqRbe51RMny5/Qco9N396igY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GwXgaV/DzwK5YTkMorJ91BlomO7YkdU7t7HMqUgBB8kNUQOK4IuavJVA/BGelsYLh
	 TviRFPmuC83Z35byGY68gc21sS1Gm64Blj9+oAsKgS75n8AdQom6UDI7pv15WESJV6
	 yCWgltJXZrVCtL6Gn3QbjdeclLWiilEBnVYLObIo=
Date: Tue, 17 Mar 2026 17:23:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Michal Clapinski
 <mclapinski@google.com>, Evangelos Petrongonas <epetron@amazon.de>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>,
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
 Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Message-Id: <20260317172310.b99ca4afcd0e7f1c380c2798@linux-foundation.org>
In-Reply-To: <20260318000817.130248-1-sj@kernel.org>
References: <abniW3D8wbGQcB5T@fedora>
	<20260318000817.130248-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_172313_226059_1B25049C 
X-CRM114-Status: GOOD (  10.36  )
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

On Tue, 17 Mar 2026 17:08:15 -0700 SeongJae Park <sj@kernel.org> wrote:

> >  error: ‘MIGRATE_CMA’ undeclared (first use in this function); did you mean ‘MIGRATE_SYNC’?
> >   557 |                 migratetype = MIGRATE_CMA;
> >       |                               ^~~~~~~~~~~
> >       |                               MIGRATE_SYNC
> > 
> > >From what I can tell, MIGRATE_CMA is only defined if CONFIG_CMA is
> > enabled (for x86 defconfig its disabled).
> 
> I also got the same issue, and was about to report.

Thanks.  I dropped this series and repushed.


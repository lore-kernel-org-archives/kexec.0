Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDADFC98306
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 22:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=10bHbMQGfL9J/pVjYQIJGwAO4YiTpvJwKw3dRcyaupc=; b=bakeGNRuz2sFqIGDZDY6Pvpou3
	rwOziojWIRa0W+rCiEIk3scQwdH41akZJ0gnlU6d/3EvEt5fRrRUOlHeWIClynXg2dU0EOTBCIMzu
	SxmdxtICpvweKM+kvJUHYUcxHUJDxSc7rubFEfmeIQi5co+4ZlMZkiCewpugVaqOkz5w8ypXmYkof
	Yob9xNrMIzugI5833kaLEALnAbk2c2TxEgiwVTMotw7ZmmHQLQqdVrMNcS7rSo8kJpmY40QzOTn1C
	RUNDgevLGic1QRF6PN+7XPgYbUmNJcImy0pc7f8ee/EcUVw/f3aSj8MWyE+Po9CbEikBGakQ+NDEi
	mxnEuynQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgsHA-0000000EyTB-44Ac;
	Fri, 16 Jan 2026 22:26:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgsH8-0000000EySn-0fs5
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 22:26:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F0A743C89;
	Fri, 16 Jan 2026 22:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E7C116C6;
	Fri, 16 Jan 2026 22:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768602396;
	bh=jISp/PQERBVoxIY52JwSB/f2SYh+cfCMvfV1bJllKhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zueuGgvOAnyooFyM3JlhrCN8Vj4JWFvldvWHUoVt6mtr0glNxpnRaiavAjfHPvm1a
	 WzKd3iwUjgVFuD60vkb13F/uS85XMXhUzoBlNETV+vEoxMbBSTi7kavoHnL/on7GfP
	 6uR7WjAkCgcoRXBEaVcDzjgFURfCjbZ03D6/ZdnE=
Date: Fri, 16 Jan 2026 14:26:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: [PATCH v2 1/2] kho: use unsigned long for nr_pages
Message-Id: <20260116142635.b90464ed9772c146a9842370@linux-foundation.org>
In-Reply-To: <20260116112217.915803-2-pratyush@kernel.org>
References: <20260116112217.915803-1-pratyush@kernel.org>
	<20260116112217.915803-2-pratyush@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_142638_239786_AD6A1C2D 
X-CRM114-Status: UNSURE (   8.30  )
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

On Fri, 16 Jan 2026 11:22:14 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:

> With 4k pages, a 32-bit nr_pages can span up to 16 TiB. While it is a
> lot, there exist systems with terabytes of RAM. gup is also moving to
> using long for nr_pages. Use unsigned long and make KHO future-proof.

We can expect people to be using LTS kernel five years from now,
perhaps much longer.  Machines will be bigger then!

IOW, shouldn't we backport this?



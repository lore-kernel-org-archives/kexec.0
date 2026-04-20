Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E72BF36C49
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 07:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kK+co6oi7OJL6AdCRJzKMKk7CVCzuI1If0cbhdqxXNc=; b=v0c9sT2XR68ZhkI1/sLGBiB4B4
	SzJKrg7rvwvLayF9pwPETn5Kd+6pVFGx4WwBhyJqVAPWNfrRORd7rtjoXuGHx2QWNlHHfkrzMvB85
	iJguUu4Y2IQrMB/hCimoSLcHv2tucYFBn+AWTm/0l5SLLVAiqh9uTtJrXpM7N27wP5zHJc5L7PWlf
	SjKggjj1X+erFeLvy5U9Na7yV6zpYvQazN9ahS5sfnxP3M+rM6cZSQFmlPZklNDCMJrzaIk2Q9WJq
	ycCRNlEo9VrPHjWzgFhjmhGjGRE6MVY9FO/RKE/PyaRc9xG5nfMA2KjW32nTV1zX6h9xvOA5BIfbT
	bFdaZzlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEjLl-00000006Z1t-091u;
	Mon, 20 Apr 2026 07:47:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEjLj-00000006Z1n-2pFH
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 07:47:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A520F60055;
	Mon, 20 Apr 2026 07:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EFEC19425;
	Mon, 20 Apr 2026 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776671238;
	bh=agb+sgSiSYKFVQT9I2o8YMrHn6TQc/1PqXRh14+ZJVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZn3hqC9GA4j71Xo5OkIfUZn8nGPyLyVDcfSo3KQT5Vr/B9asz9/eBj1rwRff6/7Y
	 vDdxjyt3h9KQh/xQJSTHFTjY+P93rdLj1gSNitrQeglfT6C4EKSmaNy/CUCFhE/vEk
	 /83eYHWjCf3g8tcI5p9kP9ziFaJ5wIOiIRuu4HvZdOnQUqviRUcv6jVappWaOCp8an
	 g0LJ0MlOKAiRlkMijOpFY2SwX2nrmVeOyvlPqrpoRj6zgQwI81n/PSbCR+Mh7MyKW2
	 IKxqinKEd7odlIKQ1HGhrszfFOJzX7mV37cN7HVXeIP3edXB7N1tZH5f/a6rBYh9gy
	 SK6Rcr3phUU7Q==
Date: Mon, 20 Apr 2026 10:47:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v8 0/2] kho: add support for deferred struct page init
Message-ID: <aeXZ_YvsSNDWcC0S@kernel.org>
References: <20260416110654.247398-1-mclapinski@google.com>
 <aeD5kboEdzwuR4P_@kernel.org>
 <CAAi7L5dFaxwoU5dho8sJJ41+SSwgrmXW_NjQZnn7UPzj0zoowg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5dFaxwoU5dho8sJJ41+SSwgrmXW_NjQZnn7UPzj0zoowg@mail.gmail.com>
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

Hi Michal,

On Thu, Apr 16, 2026 at 05:23:32PM +0200, Michał Cłapiński wrote:
> >
> > Any chance you can clean that monster and send it as patch 3?
> 
> I fear that would delay this series somewhere into v15, which I would
> like to avoid. Can I clean it up and send it separately?

If the test is public, a link to a repo would be also useful, even before
the cleanup.
 
-- 
Sincerely yours,
Mike.


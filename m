Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE21C41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EsSy5b9HSxMVOGA/WGGw2uPUOWmfwA96QxX9mPvmj0Y=; b=Kc69e6ESGkF6av
	zPBDRIjL+lM/8iYUsXGHjGbFFNk2PDR5t2vZatrXAjADeKmNh6sYeRbOSaOJqnygmQmjn+2By+O1d
	3JLL9bKOnB0rOk9E+yrgtM1gvubj38QzTlVscj2LeJD3q0nM4kjqSLlzKIQjVCvR/HacPz9wzFgny
	tbjAmMTYDQl6C7pGAVn1UxmCwzyPZxO5NmiiIW8iOynS1nBxnOhcfSGk4+70qZlkWE0kFrUf14Kbq
	Cpj6kC9vHFQhE2gXfrGYaPgWN816Y5M34mASXh/dNJn7a2A7Dsp6t8rMZr9pRmiNJHCSmjcFzh4CK
	VX1DSREvcH6axBOJfYng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFbtV-00EX6q-1r;
	Tue, 19 Dec 2023 15:20:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFbtS-00EX64-13
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 15:20:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702999223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WfTNJwj//YkFPylflsdGo75lRRl7XtZBhKo06vZ6XCA=;
	b=GtlJgnuZiLXIm4uliTyOfzn4yMBZ+Rlw1fymvLQRuWuh059WLrt+dTenZ74Qts9CpBtVvf
	muAK68U9NDIfK8JY7KKSpqhRNzXg3jkhq16x9QmUebiKq19jEUcnLQJiFQIZyMoj00HQOR
	kXPCs1tDKMOXlcHTkqfNPaU5B7q149Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-tux3UORQNpKtXtYnVTkRMA-1; Tue, 19 Dec 2023 10:20:19 -0500
X-MC-Unique: tux3UORQNpKtXtYnVTkRMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D124185A785;
	Tue, 19 Dec 2023 15:20:19 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0ABA91C060AF;
	Tue, 19 Dec 2023 15:20:17 +0000 (UTC)
Date: Tue, 19 Dec 2023 16:20:16 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>, Jiri Bohac
 <jbohac@suse.cz>, Michal Hocko <mhocko@suse.com>, Baoquan He
 <bhe@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC 0/3] kdump: Check mem_map of CMA area in kdump
Message-ID: <20231219162016.451bd2fa@rotkaeppchen>
In-Reply-To: <20231218052325.20982-1-kernelfans@gmail.com>
References: <20231218052325.20982-1-kernelfans@gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_072026_455246_F42D93DA 
X-CRM114-Status: GOOD (  24.48  )
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

Hi Pingfan,

On Mon, 18 Dec 2023 13:23:22 +0800
Pingfan Liu <kernelfans@gmail.com> wrote:

> From: Pingfan Liu <piliu@redhat.com>
> 
> 
> First of all, this series is only for proof of concept. It only passes compilation.
> 
> For years, CMA is proposed to be used as crashkernel reserved memory.
> But DIO prevent us to follow it since DMA may be in-flight and ruin the
> kdump kernel.
> 
> This series exports the crash kernel's CMA area information through
> device-tree, and kdump kernel skips any page, which refcnt!=mapcount and
> has a potential DMA activity.
> 
> The exported information include:
> 	u64 kdump_cma_pfn;
> 	u64 kdump_cma_pg_cnt;
> 	u64 kdump_cma_pg_paddr;
> 
> And they should be filled with Jiri's series "[PATCH 0/4] kdump:
> crashkernel reservation from CMA"
> 
> After the conjunction of two series, the CMA used for kdump has only the
> following risk, where the following conditions:
> 	-1.a wrong code forges _refcnt and mapcount to the same value
> 	-2.the page is also used by DIO
> 
> 
> Is it acceptable, or any rescue e.g. CRC on page?
> 
> Please share your thoughts.

I don't think your approach will work as intended. The problem is that
we are dealing with two separate kernels and there is no guarantee that
both kernels are identical. So you cannot rely on the definition of
struct page in the crash kernel to be identical to the one in the
panicked kernel. Meaning check_poison_page from the crash kernel cannot
simply operate on the struct pages from the panicked kernel.

To get this approach to work I see three possible "fixes"

1) enforce in kexec that only the currently running kernel can be
loaded as crash kernel.

2) pass all required "debuginfo" to the crash kernel so it can parse
the required data reliably from the dump. This also requires to have
all the mm helper functions to be reimplemented to work in
check_poison_page.

3) the required information is passed via a new data structure which
is designed in a way that it can easily be passed in between different
kernels. But this would require the mm subsystem to maintain the page
states in the CMA in two separate data structures.

Personally I don't think that any of the three "fixes" is desirable.

Thanks
Philipp

> Thanks,
> 
> Pingfan
> 
> 
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> To: kexec@lists.infradead.org
> ---
> Pingfan Liu (3):
>   crash_dump: Parse the CMA's mem_map in kdump
>   of: kexec: Set up properties for reusing CMA in kdump
>   of: fdt: Parse properties of reusing CMA in kdump
> 
>  drivers/of/fdt.c      | 43 +++++++++++++++++++++++
>  drivers/of/kexec.c    | 14 ++++++++
>  include/linux/kexec.h |  5 +++
>  init/main.c           |  4 +++
>  kernel/crash_dump.c   | 80 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 146 insertions(+)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBD0FA0C33
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 06:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJb5FPZyu4hDDwC8etnZx87RPu1GrnGIrB8MDPSAnB0=; b=lSHZzkJtM+u4/pPO5DmFtFPNdl
	WfxkD2praXmru/QRAfi+0CWjwYK5CBAHW5qJelBiNSediSiVAfz2fx5SAuL24uFm0+ekYfkFCt9bc
	iNWytUijzjHsosR3ybj46K7o/+PGVDLpatlKdtdYZC3lXDnktWipmv0dlSDLVV7Sh3znTOMcugulk
	Lb+xeh2RG1ZhjOv9z6m8OeVWzAhIAGAKgmyn0uPiHp6h7pryaiz3teF8+v+KLZqWbuqHSRHDZdU1e
	FCVpo8yjk9ydOvLQmQ4ePx0I/0NBpUj65RJi1hfqsga2n9Dr/r9ZkgSTLh0QzFOkcg2E4N7rmL06W
	P07MRzQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCtQr-00000000d7C-0AGu;
	Wed, 15 Apr 2026 06:09:01 +0000
Received: from out-186.mta0.migadu.com ([91.218.175.186])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCtQn-00000000d6g-3v0b
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 06:08:59 +0000
Date: Wed, 15 Apr 2026 14:09:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776233333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJb5FPZyu4hDDwC8etnZx87RPu1GrnGIrB8MDPSAnB0=;
	b=swBb8mfa2odx3mFftzw63QfyJlcIED78CQpke1aEszMgUIwq2xdzd1Jk/VSkAtP5UxRDUw
	7MD/EwsVeQEvvBGIUrblFx4DihmmTI+95+TeutHVBLeR4ipse10PCphQlcnzVDVI8mWyL8
	UgQKq0bMTYmEQRCUCt0dGOMLeKth8bw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dave Young <ruirui.yang@linux.dev>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Dead link in kdump section of MAINTAINERS file
Message-ID: <ad8rrO55DGZqSyZy@darkstar.users.ipa.redhat.com>
References: <e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_230858_118190_C2D27D0F 
X-CRM114-Status: GOOD (  10.51  )
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

Hi Sourabh,

On Wed, Apr 15, 2026 at 10:26:20AM +0530, Sourabh Jain wrote:
> Hi all,
> 
> Noticed a dead link in the kdump section of the MAINTAINERS file:
> 
> W: http://lse.sourceforge.net/kdump/
> 
> The URL no longer seems to be accessible. Could this be updated
> or replaced with a valid reference?
> 

I have no idea about the old link, I suggest to remove it if nobody
knows.

> - Sourabh Jain

Thanks
Dave


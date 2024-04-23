Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95624C4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bM5zDucCn4MYCEPJbskpneebK3i+/oTj3PudqAr32LQ=; b=rQZwoPQxs2a+AW
	LixmJrNDoTbfUmFlwsBl/tSfPN43IEthWJ+1yNu/zrRhLkmNOebJXN3MsI+l5L3eMv9gVP95hXbFW
	FwfDSbko3JC+ngSGdsYen7I/TaNVSTa6SD1Jcv15HI4v/Km6ZLUZ3DGwWWszKfpwDuuofN1ZYqmcd
	tauNBMZVLD0plwAgWTWZqTaZ7mi0D88qI5W/+5+d0w+GnIUf1rn7FKmHnq43OHZ0oe0nGq5fz3rqC
	/oVhZbRBlfUozoEzDAYfm4mTWsRmfzOTDXhPEO/jyIPkqvivp4taXBim8zeV6OvGQ7enWKxWYn+HG
	ZiRIpmb9B+vDsHUAo/ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzDFu-0000000GolZ-0Y92;
	Tue, 23 Apr 2024 10:20:06 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzDFp-0000000GokW-3StM
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 10:20:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1F636CE0174;
	Tue, 23 Apr 2024 10:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AC9C2BD11;
	Tue, 23 Apr 2024 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867597;
	bh=+GC2D/BDHQGrO3k1zjxQXoMB49rddODzP+4Ol59rrAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8vkH+3QVtNWGEyS/3ybyjIlyEomfs/2jOymirobykIDh3AJABIzF3dDlmu8Df6x2
	 U5lyZRDH/LdjiEz8aWpJ5IOKtmbpWQ983CcxZRMQSqBE0jm96P3t+Hw1zpy4XHWwJ7
	 lCIEBqZL/D5hQEZN4dUHc3nW5IV75RMNN3y9vQb6NnBn01bKSjImQo4AmyWyWAkOJV
	 B3qL/CT7kuA//QS/L8v4taLrlii6ojbA42W/WRLe3AFUrVGzhcytZu2f64wEdPDLPL
	 rH0JkM4TKqeL8WFWE6QMZ3zMLfx8+WzoQ7FPJe+talyEYVEyOZY9nqIdC9Gea94EPJ
	 TX+nycP0t4AuQ==
Date: Tue, 23 Apr 2024 11:19:54 +0100
From: Simon Horman <horms@kernel.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] Fix incorrect Free Software Foundation address in the
 license
Message-ID: <20240423101954.GJ42092@kernel.org>
References: <20240408063755.942088-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240408063755.942088-1-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_032003_170611_BD103DBD 
X-CRM114-Status: GOOD (  11.43  )
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

On Mon, Apr 08, 2024 at 02:37:55PM +0800, Coiby Xu wrote:
> As detected by rpmlint,
>     kexec-tools.x86_64: E: incorrect-fsf-address /usr/share/licenses/kexec-tools/COPYING
>     The Free Software Foundation address in this file seems to be outdated or
>     misspelled. Ask upstream to update the address, or if this is a license file,
>     possibly the entire file with a new copy available from the FSF.
> 
> Replace current one with
> https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
> to fix this issue.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

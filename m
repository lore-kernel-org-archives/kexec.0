Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B8DC282C6
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cEbGwc6l9VNyk8uqeQErnSNAMsXtfPwdweqT8cO8i0=; b=mtqwOD7dtsHhqcq1TOUn0mLh3P
	qNtSlx+MEsClt34BY/zDX2zwKw79X6NT60Pc7GOjRXx/d+CEbu1VfVLinO6bV0hCdvg/kexIAPtYw
	nyfxNg8YYNmHcJasOXTPGPuP5NM5irFDw7H0rFbPxBU0u35FB3fIwfzT/MXnpLZ57mZe4Rnn35mFO
	qh52sGUqYEKL6075F0MydO+GNObeNaHngodI15H2wuJc+hTKOYky67A5WwRdhOHv2neyR6vlXw8Go
	Wci3hUIfT+Am3GVy2yOsTdHiVHluEfDjeGIHjl805jruZrdQEpBlLoe0KaJtzGvQkOH8Fq85Etb9c
	aHNy2IGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tovEv-0000000GwIB-3KTO;
	Mon, 03 Mar 2025 02:09:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tovEs-0000000GwFi-17fh
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 02:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740967741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cEbGwc6l9VNyk8uqeQErnSNAMsXtfPwdweqT8cO8i0=;
	b=HEMiC7IaiQsBMd+AGuGFLtNz2eXYHlGt56QmXYsf/GDjVqLsz1sug3mVwwbLeD3h7M2Mzt
	K5wcefmL1D6pKEOgrGG4YzBUV8QOxnTbCXrdeNzP573UXDpz/PSeONdjGCIHSrGOB6YDXg
	IUIT27K2fKBmn8dkkiUdEpReXnbKYRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-OBS1U2UDMGWtX0EnlUI9Lg-1; Sun,
 02 Mar 2025 21:08:46 -0500
X-MC-Unique: OBS1U2UDMGWtX0EnlUI9Lg-1
X-Mimecast-MFC-AGG-ID: OBS1U2UDMGWtX0EnlUI9Lg_1740967725
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88DBF1800268;
	Mon,  3 Mar 2025 02:08:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABE981800361;
	Mon,  3 Mar 2025 02:08:38 +0000 (UTC)
Date: Mon, 3 Mar 2025 10:08:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <Z8UPIYFqAgiH8s6R@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_180902_373999_86B0185D 
X-CRM114-Status: GOOD (  20.53  )
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

On 02/20/25 at 05:48pm, Jiri Bohac wrote:
......snip... 
> ---
> Changes since v1:
> 
> The key concern raised in the v1 discussion was that pages in the
> CMA region may be pinned and used for a DMA transfer, potentially
> corrupting the new kernel's memory. When the cma suffix is used, kdump
> may be less reliable and the corruption hard to debug
> 
> This v2 series addresses this concern in two ways:
> 
> 1) Clearly stating the potential problem in the updated
> Documentation and setting the expectation (patch 3/5)
> 
> Documentation now explicitly states that:
> - the risk of kdump failure is increased
> - the CMA reservation is intended for users who can not or don't
>   want to sacrifice enough memory for a standard crashkernel reservation
>   and who prefer less reliable kdump to no kdump at all
> 
> This is consistent with the documentation of the
> crash_kexec_post_notifiers option, which can also increase the
> risk of kdump failure, yet may be the only way to use kdump on
> some systems. And just like the crash_kexec_post_notifiers
> option, the cma crashkernel suffix is completely optional:
> the series has zero effect when the suffix is not used.

Thanks for the effort to investigate and add clear note about the
potential risk in document. Except of the 1 second waiting for short
term pined page for DMA, the whole series looks good to me. Hope other
people can also give comment to evaluate the risk of waiting, I will
wait another week to add my personal ACK.

Thanks
Baoquan

> 
> 2) Giving DMA time to finish before booting the kdump kernel
>    (patch 4/5)
> 
> Pages can be pinned for long term use using the FOLL_LONGTERM
> flag. Then they are migrated outside the CMA region. Pinning
> without this flag shows that the intent of their user is to only
> use them for short-lived DMA transfers. 
> 
> Delay the boot of the kdump kernel when the CMA reservation is
> used, giving potential pending DMA transfers time to finish.
> 
> Other minor changes since v1:
> - updated for 6.14-rc2
> - moved #ifdefs and #defines to header files
> - added __always_unused in parse_crashkernel() to silence a false
>   unused variable warning
>  
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 
> 



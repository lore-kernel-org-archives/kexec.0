Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5FDC38150
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 01:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bGZOKGd6T52QnKrN+hFpoCfUYQkTv0Scm2zT1fmLMXA=; b=X7OPtVieF1cF1E
	DRk5PzOPE1e2hZYxPVUigzogVSicAKAPAqStcHSN1qQWhKQXJJJu4ZoWz8fWlUjP07ymQ1txet8/x
	3lujuE4YGB1TDS1fsKaitqI+xGqWV7Pg1scs5wM47i+bGvWc3lmJ/rAUHUtkXfvF49/21kN6PAdJC
	xWhDV9VJ5A1G87vThtNGaw3XVWc34nhI9WKA6y3dfaa8Cs2E8DSS2vqaz0B15bYwYs4r62VXNdqXD
	5fyq/l6OCxpDgl/4QhXkQgUPd8UiOG2uqcp2Wvmx7GUfcSGLS0hYLV0IlQx8F93FXEgfhQUMfa3jh
	YBx+qMN03q8kQDyr72UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQdLk-00000002YMX-3qG0;
	Mon, 08 Jul 2024 01:39:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQdLi-00000002YLd-1eJ4
	for kexec@lists.infradead.org;
	Mon, 08 Jul 2024 01:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720402764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iBnIhy88zvpWUJ8du43SP9wxo4TnhIUB5LyJISbylCM=;
	b=QUXLBUfYZJaC6fpSWiMDlzncrPbuXNAOu5uv6hzAG/xeeh9Ym34nJ6uCEKOx5H39pGme2h
	QDkcgRSW1GFZh2lqC3RZV3NyRbRNEPjxQQL+mFcKcMom/XxJXjrQKKcWCZlsPDKZ9RSYFA
	KS9TTaLZPwjkonYurz1X0jCvJmju7vk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-2-XrHAlUMQiiM6s4XxB-2w-1; Sun,
 07 Jul 2024 21:39:20 -0400
X-MC-Unique: 2-XrHAlUMQiiM6s4XxB-2w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C237195609D;
	Mon,  8 Jul 2024 01:39:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B2721955F3B;
	Mon,  8 Jul 2024 01:39:17 +0000 (UTC)
Date: Mon, 8 Jul 2024 09:39:11 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
Message-ID: <ZotDP0JtnyRIx2dm@MiWiFi-R3L-srv>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
 <20240707152456.87899-2-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240707152456.87899-2-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_183926_531543_B0B11572 
X-CRM114-Status: GOOD (  16.37  )
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

Hi Sourabh,

On 07/07/24 at 08:54pm, Sourabh Jain wrote:
> Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
> support) has introduced a new kexec flag to generalize hotplug support.
> The newly introduced kexec flags for hotplug allow architectures to
> exclude all the required kexec segments from SHA calculation so that
> the kernel can update them on hotplug events. This was not possible
> earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
> only for the elfcorehdr segment.
> 
> To enable architectures to control the list of kexec segments to exclude
> when hotplug support is enabled, add a new architecture-specific
> function named arch_do_exclude_segment. During the SHA calculation, this
> function gets called to let the architecture decide whether a specific
> kexec segment should be considered for SHA calculation or not.
> 
> Note: To avoid breaking backward compatibility, the new kexec flag
> KEXEC_CRASH_HOTPLUG_SUPPORT is not used for x86 for now.

For x86, both KEXEC_UPDATE_ELFCOREHDR and KEXEC_CRASH_HOTPLUG_SUPPORT
should be OK for kexec_file_load. Your change will make a difference
between kexec_load and kexec_file_load. But I agree with you on the
backward cmpatibility with KEXEC_CRASH_HOTPLUG_SUPPORT flag.

Anyway, if it's in a hurry to catch up with Simon's new release, this is
fine, we can change it later. Otherwise, we may be better to remove the
difference, namely, not making x86 only be able to accept
KEXEC_UPDATE_ELFCOREHDR flag on kexec_load. My personal opinion.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

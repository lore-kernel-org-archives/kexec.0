Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91091CFA466
	for <kexec@archiver.kernel.org>; Fri, 21 Nov 2025 03:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6+6N9+a6Rle5k9y2X7Rh5H8fLanRq0TwohIxyV0JFM=; b=oj9W3c8ohtb+TToIZWJUGGPbQj
	o9T18tVu6WtWdHiXD1BgJMxyFU087ivNqYEz5qiQ2riYWQisiIP7T+6uRR/566NUa423X5XpKjFdI
	8fhgRGVmsA5rsU74oL0PN2xIHwgPH+mHYuDWMLnzZtb2eeMl6glvBPxnVhEePw1cmdm0IDX62y6hC
	FinegWYwEKjcWc1p/N4Fg60Oi0pAHZeW1Ak07NO5/10T9LYN+26mTq1h/Z1fOrIGTWl728QTM1NI6
	eSR3j0DezxXKMcCOsfw2kKa+VNaW86mEM/qJ8UX7MtOqeShCfIC5Hc6Q7EXuBTf/K0iGHWlAyECXa
	wfGGGRGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMHk7-00000007lHk-2qJb;
	Fri, 21 Nov 2025 03:23:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMHk2-00000007lHF-04RN
	for kexec@lists.infradead.org;
	Fri, 21 Nov 2025 03:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763695400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6+6N9+a6Rle5k9y2X7Rh5H8fLanRq0TwohIxyV0JFM=;
	b=hcF3Rx6o1ipMLuaJLjDPcfF/s1z3X5jQyFNmc2AgKSt/vmNKL+rLntH2Yk4CroGXXBfafa
	BuADBE343TGHCuK2uabZuHP/gZeK2s4Rx0U2u3pOr+4BNDZ71FUumSSOMgqRqM9P2OkIfp
	ye++/LdgieXIfpTSWi2z617VbZvR6GM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-Ux9GdJjnMkqHNIR-ISlWWg-1; Thu,
 20 Nov 2025 22:23:18 -0500
X-MC-Unique: Ux9GdJjnMkqHNIR-ISlWWg-1
X-Mimecast-MFC-AGG-ID: Ux9GdJjnMkqHNIR-ISlWWg_1763695396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61774195423A;
	Fri, 21 Nov 2025 03:23:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D0E1800451;
	Fri, 21 Nov 2025 03:23:11 +0000 (UTC)
Date: Fri, 21 Nov 2025 11:23:07 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Aditya Gupta <adityag@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v6 0/3] kexec: reorganize kexec and kdump sysfs
Message-ID: <aR/bG4MCKGpunwe4@MiWiFi-R3L-srv>
References: <20251118114507.1769455-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118114507.1769455-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_192322_478681_8F2F054D 
X-CRM114-Status: GOOD (  16.95  )
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

On 11/18/25 at 05:15pm, Sourabh Jain wrote:
> All existing kexec and kdump sysfs entries are moved to a new location,
> /sys/kernel/kexec, to keep /sys/kernel/ clean and better organized.
> Symlinks are created at the old locations for backward compatibility and
> can be removed in the future [01/03].
> 
> While doing this cleanup, the old kexec and kdump sysfs entries are
> marked as deprecated in the existing ABI documentation [02/03]. This
> makes it clear that these older interfaces should no longer be used.
> New ABI documentation is added to describe the reorganized interfaces
> [03/03], so users and tools can rely on the updated sysfs interfaces
> going forward.
> 
> Changlog:
> ---------
> 
> v4 -> v5:
>  https://lore.kernel.org/all/20251114152550.ac2dd5e23542f09c62defec7@linux-foundation.org/
>  - Splitted patch series from the above patch series
> 
> v5 -> v6:
>  - Move /sys/kernel/kexec_crash_cma_ranges also to new /sys/kernel/kexec node
>  - Update commit messages
> 
> Note:
> This patch series is dependent on the patches:
> https://lore.kernel.org/all/20251117035153.1199665-1-sourabhjain@linux.ibm.com/
> https://lore.kernel.org/all/20251118071023.1673329-1-sourabhjain@linux.ibm.com/

To the series,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
> 
> Sourabh Jain (3):
>   kexec: move sysfs entries to /sys/kernel/kexec
>   Documentation/ABI: mark old kexec sysfs deprecated
>   Documentation/ABI: new kexec and kdump sysfs interface
> 
>  .../ABI/obsolete/sysfs-kernel-kexec-kdump     |  71 +++++++++
>  .../ABI/testing/sysfs-kernel-kexec-kdump      |  26 ++--
>  kernel/kexec_core.c                           | 141 ++++++++++++++++++
>  kernel/ksysfs.c                               |  89 +----------
>  4 files changed, 230 insertions(+), 97 deletions(-)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
> 
> -- 
> 2.51.1
> 



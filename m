Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EF8C0218A
	for <kexec@archiver.kernel.org>; Sat,  1 Feb 2025 04:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Ig6TH7qnMW9vqfBPnMTJLnOHwh56eOqpsqPuSlb7kQ=; b=e4Z/9xD2VdWLQAucR7NWde8S2k
	u2mM29Y6rnw1t99+Kur/6HKvGz/PbHaBXXfI8tB2TKju7eoi/GWi5JZ7zvSTxzBykxg+WVvRI1Y8L
	tf0mpYCsBFNFxprEk0sGHWnpd1e4tTr0qyghp6szaRW7FbOXhwgO/k8X10u/5cNKfmM/f6XqFwvev
	3pVMWKhegr7bTWgG43yAv7bNWTHwC+ap7j11pdbklzSXJIjh/RE3dOalug2jtiP5OPxsWT/Sd/lIA
	AjQfL+WA26gRml28wFN7c0vwdu4RYzn3vlmTj5SV+twJXA0oPbQb+3h2lOOu1+v7WzwgwGK3jA/YF
	tGO0yCyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1te51d-0000000BsCo-42UF;
	Sat, 01 Feb 2025 04:22:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1te51X-0000000BsC9-1c3j
	for kexec@lists.infradead.org;
	Sat, 01 Feb 2025 04:22:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738383744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ig6TH7qnMW9vqfBPnMTJLnOHwh56eOqpsqPuSlb7kQ=;
	b=I+N2TDfCGfl0T5/KHUG2hKuzxZx3niXtBJRjTh/mtnF7CHxgqZylkdLgRAEL8VBYYprQl0
	4UbZlGNp+HqPX7RbIInnY3ED7VKKSFp7EojuCG8fzSKyimDbZs4tPfG1SPTpTYj2FpIsag
	NrBvScUrkY3tUkxcnjjHkrnT8mx90tM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-zf_HO1DfMT-xwtjDhBfBdQ-1; Fri,
 31 Jan 2025 23:22:19 -0500
X-MC-Unique: zf_HO1DfMT-xwtjDhBfBdQ-1
X-Mimecast-MFC-AGG-ID: zf_HO1DfMT-xwtjDhBfBdQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F38A180036E;
	Sat,  1 Feb 2025 04:22:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA93D180035E;
	Sat,  1 Feb 2025 04:22:14 +0000 (UTC)
Date: Sat, 1 Feb 2025 12:22:09 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] crash: Let arch decide usable memory range in
 reserved area
Message-ID: <Z52hUz5/nZhzTUb4@fedora>
References: <20250131113830.925179-1-sourabhjain@linux.ibm.com>
 <20250131113830.925179-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131113830.925179-4-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_202227_504164_57A028D0 
X-CRM114-Status: GOOD (  14.55  )
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

On 01/31/25 at 05:08pm, Sourabh Jain wrote:
> Although the crashkernel area is reserved, on architectures like
> PowerPC, it is possible for the crashkernel reserved area to contain
> components like RTAS, TCE, OPAL, etc. To avoid placing kexec segments
> over these components, PowerPC has its own set of APIs to locate holes
> in the crashkernel reserved area.
> 
> Add an arch hook in the generic locate mem hole APIs so that
> architectures can handle such special regions in the crashkernel area
> while locating memory holes for kexec segments using generic APIs.
> With this, a lot of redundant arch-specific code can be removed, as it
> performs the exact same job as the generic APIs.
> 
> To keep the generic and arch-specific changes separate, the changes
> related to moving PowerPC to use the generic APIs and the removal of
> PowerPC-specific APIs for memory hole allocation are done in a
> subsequent patch titled "powerpc/crash: Use generic APIs to locate
> memory hole for kdump.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  include/linux/kexec.h |  9 +++++++++
>  kernel/kexec_file.c   | 12 ++++++++++++
>  2 files changed, 21 insertions(+)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>



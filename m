Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172ECC3271E
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hGe7iG8vAU2Ykfwb2l4iyBvJPaGndLQfyqruAWSnEB8=; b=WrWrKJXv7x/2H0
	RR8rwghinuzg7mMKkkvgjwKxMsoaSgVQYb/we1cf72qzOQwGi+TqDeg4qm5iw5bUr8RBxv+WQbILt
	V8looyyrsbxAmTVHsKf/LcFMaNoobpYMDVsY3RmrcrqIqnZM0GXOaVjb9+meh2bIb8Bp29WkMjBIt
	ohFkvwV7Cr+VLCthCNOgdwcAoI5ZuZ+A/XTwz3gLvvPPWHiDg/XLKmTeNm1IwanzmqcBdBwotOa30
	PWRYEDoWnffPAKS4YF3s2CXjZH9TnGXHNsxCuHZfGYXXKpLN3+vFV2FPlm0DW+s5YRnlkR2reEKxA
	rnEZ92tpkHzkv8FsVc4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQlbR-00000003Rqt-2OP8;
	Mon, 08 Jul 2024 10:28:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQlbN-00000003Rp0-45cX
	for kexec@lists.infradead.org;
	Mon, 08 Jul 2024 10:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720434488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cwzLc3ovW5C9FYoPvUJ71FhZ1hoAJmxKbA+fm1IOCZ0=;
	b=aGBmSvftXE4Au80c+TN7h5NWjLe1RlqwT2difDa+edWHV9zwfaZW602K7qrBt/6KGDZYMf
	gl2eP4UNOWYr2lorjr8e4hRncJmv7PDVNEJXhEcxSkXwlHNUoDlrEq7zatI6HQqkn1rj02
	T5Ea12Efx7MFCWTK0KeJAtDMSLXmUDA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-p1emsD0yOP-8bdzAnriE1w-1; Mon,
 08 Jul 2024 06:28:05 -0400
X-MC-Unique: p1emsD0yOP-8bdzAnriE1w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F96B1955F3B;
	Mon,  8 Jul 2024 10:28:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 715F01955E8C;
	Mon,  8 Jul 2024 10:28:00 +0000 (UTC)
Date: Mon, 8 Jul 2024 18:27:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
Message-ID: <Zou/LO4+HguiyGZh@MiWiFi-R3L-srv>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
 <20240707152456.87899-2-sourabhjain@linux.ibm.com>
 <ZotDP0JtnyRIx2dm@MiWiFi-R3L-srv>
 <102546c9-ccb9-49cd-8c58-ff4a218812bd@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <102546c9-ccb9-49cd-8c58-ff4a218812bd@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_032810_108337_DFEAC715 
X-CRM114-Status: GOOD (  40.35  )
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

On 07/08/24 at 01:25pm, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 08/07/24 07:09, Baoquan He wrote:
> > Hi Sourabh,
> > 
> > On 07/07/24 at 08:54pm, Sourabh Jain wrote:
> > > Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
> > > support) has introduced a new kexec flag to generalize hotplug support.
> > > The newly introduced kexec flags for hotplug allow architectures to
> > > exclude all the required kexec segments from SHA calculation so that
> > > the kernel can update them on hotplug events. This was not possible
> > > earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
> > > only for the elfcorehdr segment.
> > > 
> > > To enable architectures to control the list of kexec segments to exclude
> > > when hotplug support is enabled, add a new architecture-specific
> > > function named arch_do_exclude_segment. During the SHA calculation, this
> > > function gets called to let the architecture decide whether a specific
> > > kexec segment should be considered for SHA calculation or not.
> > > 
> > > Note: To avoid breaking backward compatibility, the new kexec flag
> > > KEXEC_CRASH_HOTPLUG_SUPPORT is not used for x86 for now.
> > For x86, both KEXEC_UPDATE_ELFCOREHDR and KEXEC_CRASH_HOTPLUG_SUPPORT
> > should be OK for kexec_file_load.
> 
> Do we even need these flags for kexec_file_load at all?
> My understanding is that these flags are only needed for the kexec_load
> system call.

Oh, sorry, my bad, I must have mixed this with KEXEC_FILE_DEBUG I
earlier added when I checked this patchset. I think everything is
like what you said.
> 
> 
> > Your change will make a difference
> > between kexec_load and kexec_file_load.
> 
> I am confused by the above statement.
> 
> Given that we don't even send any of the above flags for kexec_file_load, I
> am not
> sure how these changes make a difference between the two system calls.
> 
> > But I agree with you on the
> > backward cmpatibility with KEXEC_CRASH_HOTPLUG_SUPPORT flag.
> > 
> > Anyway, if it's in a hurry to catch up with Simon's new release, this is
> > fine, we can change it later.
> 
> It would be great if we could consider this patch series for the next
> release, but not at
> the cost of breaking any backward compatibility for x86. If you think these
> changes are
> breaking anything for any kernel version, I would prefer to update my patch
> series.
> 
> > Otherwise, we may be better to remove the
> > difference, namely, not making x86 only be able to accept
> > KEXEC_UPDATE_ELFCOREHDR flag on kexec_load. My personal opinion
> 
> On x86, passing the KEXEC_CRASH_HOTPLUG_SUPPORT kexec bit to kernel versions
> 6.5 to 6.9
> with the kexec_load system call will fail with -EINVAL. However, from kernel
> 6.10 onward,
> both KEXEC_UPDATE_ELFCOREHDR and KEXEC_CRASH_HOTPLUG_SUPPORT kexec bits are
> acceptable for x86.
> 
> My proposal is to use KEXEC_UPDATE_ELFCOREHDR on x86 for some time (maybe a
> couple of kernel releases),
> and eventually switch to KEXEC_CRASH_HOTPLUG_SUPPORT for x86 as well.
> 
> This proposal of shifting to the KEXEC_CRASH_HOTPLUG_SUPPORT kexec bit for
> x86 is also mentioned in the
> comment for the get_hotplug_kexec_flag function.
> 
> Please let me know your opinion.

It sounds like a good plan, thanks for the effort.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

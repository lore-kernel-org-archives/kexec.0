Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45690CCF9F8
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 03:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=khlr+nqfqO8zkgfz4nPt9sJu1gGHQI2iFDjbcvasM4k=; b=OpPn+UlR9nK/dfSBIHlfnWcTLI
	kLqY7BTHTZGgFrhvj+gU3P3J95cp5pkXYuafyQNEfszvKGVkZQfAsvPN4uwjUwlc/PBXtiGIo1wIn
	j+bziArEynrbb9KKiehhNz69q+46rfFbB42CDhycG0jswjArwqXDx9UYJ2CUM2uiJ8DjMJIGqLYuE
	4c4jNDCqhPmuV8GABblKXKEAIu9xhZrVicI/gXh+iRnONR2VLBEIqInpGSPcwRv/bR1EreWzX09jp
	3mV3AX7VbGftdLJ7XK2TfLMSFnSb3fbj4GSgfSnHv6JgCBKbEioJktxLfKwpVRziXyzBkhqeGhq8R
	4ikLfWVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGU0M-0000000CweT-3Gr9;
	Wed, 05 Nov 2025 03:16:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGU0J-0000000Cwe6-1xIS
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 03:16:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762312570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khlr+nqfqO8zkgfz4nPt9sJu1gGHQI2iFDjbcvasM4k=;
	b=YDuD4MQMyHyus1o3xNtjMlsGVtzZRH7S044EEyc6i78MKyZfcbAZ8N4qqJBHIWMU+KNGMs
	dGS/cIsZyBuWtVON+gI25S5SjGps9NfGj034wnbkCwqVZb89QXm3GrE545HEgwn2px8QPp
	3HRQamEZGOmtengf4/me8KT3ys+7hok=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-pcTzoig4Oy65rcC08Sm5fw-1; Tue,
 04 Nov 2025 22:16:06 -0500
X-MC-Unique: pcTzoig4Oy65rcC08Sm5fw-1
X-Mimecast-MFC-AGG-ID: pcTzoig4Oy65rcC08Sm5fw_1762312565
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41CD319560B2;
	Wed,  5 Nov 2025 03:16:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8CB11956056;
	Wed,  5 Nov 2025 03:16:01 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:15:57 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/2] Export kdump crashkernel CMA ranges
Message-ID: <aQrBbYVEQleExjpk@MiWiFi-R3L-srv>
References: <20251103035859.1267318-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103035859.1267318-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_191611_581985_B0B44F4E 
X-CRM114-Status: GOOD (  19.46  )
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

On 11/03/25 at 09:28am, Sourabh Jain wrote:
> /sys/kernel/kexec_crash_cma_ranges to export all CMA regions reserved
> for the crashkernel to user-space. This enables user-space tools
> configuring kdump to determine the amount of memory reserved for the
> crashkernel. When CMA is used for crashkernel allocation, tools can use
> this information to warn users that attempting to capture user pages
> while CMA reservation is active may lead to unreliable or incomplete
> dump capture.
> 
> While adding documentation for the new sysfs interface, I realized that
> there was no ABI document for the existing kexec and kdump sysfs
> interfaces, so I added one.
> 
> The first patch adds the ABI documentation for the existing kexec and
> kdump sysfs interfaces, and the second patch adds the
> /sys/kernel/kexec_crash_cma_ranges sysfs interface along with its
> corresponding ABI documentation.
> 
> *Seeking opinions*
> There are already four kexec/kdump sysfs entries under /sys/kernel/,
> and this patch series adds one more. Should we consider moving them to
> a separate directory, such as /sys/kernel/kexec, to avoid polluting
> /sys/kernel/? For backward compatibility, we can create symlinks at
> the old locations for sometime and remove them in the future.

That sounds a good idea, will you do it in v2? Because otherwise the
kexec_crash_cma_ranges need be moved too.


> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
> 
> Sourabh Jain (2):
>   Documentation/ABI: add kexec and kdump sysfs interface
>   crash: export crashkernel CMA reservation to userspace
> 
>  .../ABI/testing/sysfs-kernel-kexec-kdump      | 53 +++++++++++++++++++
>  kernel/ksysfs.c                               | 17 ++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> 
> -- 
> 2.51.0
> 



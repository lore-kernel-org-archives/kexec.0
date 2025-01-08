Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C344BE77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 11:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3oLpbTsd6NEyHY2cucU9ZqZfMt3d6F1y8ObsntY47Ys=; b=aAZ4ZNQ6MzVm8vmPiMiIs0q/cN
	cQDpRPuPBevIlDAFC4Q/ropONoemXVi2HJe03BhywlEvVQzmRdoRPmULqKxbUFUrUlrFBGxHrpkUK
	7K5KlrwO6KDfUwYjdGvbsqdE+B/mqLAr5WBU9F2RktPTdBRs24jxCxHl59obbhhMJgB2sOjKaAamD
	MopKy72Y3WTiiPlIOPHhJKuZjRMMjI62cEPW+PBWyTRZ8blYUyaCklxD8tE5cm3NGDfz7qYXurqSA
	kYp1KqA3IgdjO8ZlIFxkAQ9qg2aB1wIOGVkccVVuTbSavHH/NHWTIpVw6+CO2iE6wJMxEASWczl7f
	7uwXc40w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUBo-00000008BvJ-3XOG;
	Wed, 08 Jan 2025 11:25:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUBj-00000008BuQ-0Ktd
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 11:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736335525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oLpbTsd6NEyHY2cucU9ZqZfMt3d6F1y8ObsntY47Ys=;
	b=GZMeTtcYepmEg1lLX7JgRyvb1VSoi1lXnTbuSzITs0PTDCYz7F3OiTrgUGYWU4ZHleJoBT
	3mfRQnKzb8JESVJlodAmU8GcUMyrrUERmPJ1g4go/TgF9++nGgjBKkVRyE4h+SCFZkRHzn
	RrGxQM08e+wrW04JK1+A2eAZ8NikLg4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-DaA2zA7kN2O5kv6i9Gj8QA-1; Wed,
 08 Jan 2025 06:25:24 -0500
X-MC-Unique: DaA2zA7kN2O5kv6i9Gj8QA-1
X-Mimecast-MFC-AGG-ID: DaA2zA7kN2O5kv6i9Gj8QA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C71F19560BD;
	Wed,  8 Jan 2025 11:25:22 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1A53300018D;
	Wed,  8 Jan 2025 11:25:20 +0000 (UTC)
Date: Wed, 8 Jan 2025 19:25:16 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v1 2/5] crash: let arch decide crash memory export
 to iomem_resource
Message-ID: <Z35gnO2N/LFt1E7E@MiWiFi-R3L-srv>
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-3-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108101458.406806-3-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_032530_155560_56193C37 
X-CRM114-Status: GOOD (  13.42  )
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

Hi,

On 01/08/25 at 03:44pm, Sourabh Jain wrote:
> insert_crashkernel_resources() adds crash memory to iomem_resource if
> generic crashkernel reservation is enabled on an architecture.
> 
> On PowerPC, system RAM is added to iomem_resource. See commit
> c40dd2f766440 ("powerpc: Add System RAM to /proc/iomem").
> 
> Enabling generic crashkernel reservation on PowerPC leads to a conflict
> when system RAM is added to iomem_resource because a part of the system
> RAM, the crashkernel memory, has already been added to iomem_resource.
> 
> The next commit in the series "powerpc/crash: use generic crashkernel
> reservation" enables generic crashkernel reservation on PowerPC. If the
> crashkernel is added to iomem_resource, the kernel fails to add
> system RAM to /proc/iomem and prints the following traces:
> 
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc2+
> snip...
> NIP [c000000002016b3c] add_system_ram_resources+0xf0/0x15c
> LR [c000000002016b34] add_system_ram_resources+0xe8/0x15c
> Call Trace:
> [c00000000484bbc0] [c000000002016b34] add_system_ram_resources+0xe8/0x15c
> [c00000000484bc20] [c000000000010a4c] do_one_initcall+0x7c/0x39c
> [c00000000484bd00] [c000000002005418] do_initcalls+0x144/0x18c
> [c00000000484bd90] [c000000002005714] kernel_init_freeable+0x21c/0x290
> [c00000000484bdf0] [c0000000000110f4] kernel_init+0x2c/0x1b8
> [c00000000484be50] [c00000000000dd3c] ret_from_kernel_user_thread+0x14/0x1c
> 
> To avoid this, an architecture hook is added in
> insert_crashkernel_resources(), allowing the architecture to decide
> whether crashkernel memory should be added to iomem_resource.

Have you tried defining HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY in ppc to
add crashkernel region to iomem early? Now there are two branches in the
existing code, adding a hook will make three ways.



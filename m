Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE53CCF9E0
	for <kexec@archiver.kernel.org>; Sat, 25 Oct 2025 02:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QVyFmHun0tiZe+mZoklBcouNkx/P49NYMHYlwZrNpo=; b=jtlK81GIzIydTHxJa1pkSP1y7J
	sfiKKHbQWjslUI8fPTh3fAIyVB7l1GAJpb8Cqc6hPV3PLcUWCYRJAy4efkgd3cyHjUnb66JPnbhDT
	O7QNyEJdGlxWeEw5vVAiqifwl3R8M1yryajMTR5TJ9rouvn3ZCGg43ZiQKZ0ABGBSaRMQp9Z6qCX/
	WU8DQZBKXBtcNLj9Nikd16isk7u0sILEpsXeO4wyaRcc7YgJ6NZgPo+eytChPcJ/8Fkr25gs4rjVW
	9lFOQbe2OkPtDvf4sD1awzc1K2PihCFCS7IxIg73SKEfu6Z/fK08imMiL41ThYkLF24aDNX+NB7Nz
	ofV24gPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCTcx-0000000AoSG-0eN6;
	Sat, 25 Oct 2025 02:03:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCTcr-0000000AoRT-1Gp5
	for kexec@lists.infradead.org;
	Sat, 25 Oct 2025 02:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761357802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QVyFmHun0tiZe+mZoklBcouNkx/P49NYMHYlwZrNpo=;
	b=XW21JhTbmrX6D2kHQb0r4gmn5o4fbxG2/Wpg61X8/b1LtKWIkNs+LRPiPllZxfgQ6Ccmfk
	oJJUYTunGhFLpIaZU6+mu6coBtnmhzAomMFaAiFiSGOO5sjq6tXmH6XjVx/rOEL2fXQCBK
	1P21/4Jszm1ndecBgCVDaYZZJSaNwaA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-gL-LecEbN-yoll0AMy3tUw-1; Fri,
 24 Oct 2025 22:03:16 -0400
X-MC-Unique: gL-LecEbN-yoll0AMy3tUw-1
X-Mimecast-MFC-AGG-ID: gL-LecEbN-yoll0AMy3tUw_1761357794
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88EE6195608A;
	Sat, 25 Oct 2025 02:03:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDA7D180045B;
	Sat, 25 Oct 2025 02:03:10 +0000 (UTC)
Date: Sat, 25 Oct 2025 10:03:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Alexander Graf <graf@amazon.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH v3] kexec_core: Remove superfluous page offset handling
 in segment loading
Message-ID: <aPwv2QVddRseX8iK@MiWiFi-R3L-srv>
References: <20251024155009.39502-1-jbouron@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024155009.39502-1-jbouron@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_190325_424941_A38AE013 
X-CRM114-Status: GOOD (  20.32  )
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

On 10/24/25 at 08:50am, Justinien Bouron wrote:
> During kexec_segment loading, when copying the content of the segment
> (i.e. kexec_segment::kbuf or kexec_segment::buf) to its associated
> pages, kimage_load_{cma,normal,crash}_segment handle the case where the
> physical address of the segment is not page aligned, e.g. in
> kimage_load_normal_segment:
> ```
> 	page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
> 	// ...
> 	ptr = kmap_local_page(page);
> 	// ...
> 	ptr += maddr & ~PAGE_MASK;
> 	mchunk = min_t(size_t, mbytes,
> 		PAGE_SIZE - (maddr & ~PAGE_MASK));
> 	// ^^^^ Non page-aligned segments handled here ^^^
> 	// ...
> 	if (image->file_mode)
> 		memcpy(ptr, kbuf, uchunk);
> 	else
> 		result = copy_from_user(ptr, buf, uchunk);
> ```
> (similar logic is present in kimage_load_{cma,crash}_segment).
> 
> This is actually not needed because, prior to their loading, all
> kexec_segments first go through a vetting step in
> `sanity_check_segment_list`, which rejects any segment that is not
> page-aligned:
> ```
> 	for (i = 0; i < nr_segments; i++) {
> 		unsigned long mstart, mend;
> 		mstart = image->segment[i].mem;
> 		mend   = mstart + image->segment[i].memsz;
> 		// ...
> 		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
> 			return -EADDRNOTAVAIL;
> 		// ...
> 	}
> ```
> In case `sanity_check_segment_list` finds a non-page aligned the whole
> kexec load is aborted and no segment is loaded.
> 
> This means that `kimage_load_{cma,normal,crash}_segment` never actually
> have to handle non page-aligned segments and `(maddr & ~PAGE_MASK) == 0`
> is always true no matter if the segment is coming from a file (i.e.
> `kexec_file_load` syscall), from a user-space buffer (i.e. `kexec_load`
> syscall) or created by the kernel through `kexec_add_buffer`. In the
> latter case, `kexec_add_buffer` actually enforces the page alignment:
> ```
> 	/* Ensure minimum alignment needed for segments. */
> 	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
> 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
> ```
> 
> Signed-off-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
> Changes since v1:
> 	- Reworked commit message as requested by Baoquan He
> 	  <bhe@redhat.com>
> 	- Removed accidental whitespace change
> 	- v1 Link: https://lore.kernel.org/lkml/20250910163116.49148-1-jbouron@amazon.com/
> 
> Changes since v2:
> 	- Removed unused variable in kimage_load_cma_segment() which was
> 	  causing a warning and failing build with `make W=1`. Thanks
> 	  Andy Shevchenko for finding this issue
> 	- v2 Link: https://lore.kernel.org/lkml/20250929160220.47616-1-jbouron@amazon.com/
> ---
>  kernel/kexec_core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

LGTM, thanks.

Acked-by: Baoquan He <bhe@redhat.com>



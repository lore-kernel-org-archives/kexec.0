Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DD6CA0EE1
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PrBFm9KN1k8udVr7PX4kpGMG0V0UIL0fa5o6pxCVKL0=; b=dSLMWmxP/VV8ClQwRP1Sy5uHQJ
	8Chj7fLzMhB4ir4Dgp2XSefmvbfa5lqWVqNW6xT0AVEt++98dSKwQ+jslSJ1t5rWKUNIj4+VivmKn
	AxR/uAqLgIbmMZLY33aSXVKQVFPZt50JWrFMciGS3kJhcmriT68UYMw38vH0sZttf1UUjiXSJiMnA
	n+nDFwoig+y/EJ+SrGVycuB+IAn9Ojxcactgfpat0NjxdYG/9qM/E38qPA42nKr1NlMh2WnrvzVcf
	zvT5PxP9oNa+vbdSBiEoiF+lWGML+tdbG9tZYYpw+EEA7Giso4BxGuUm1WB90XGWAz0PFh5GBfS97
	pRM5Bgbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uluaj-0000000BmxO-3D32;
	Tue, 12 Aug 2025 19:23:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulqds-0000000B9JR-3twE
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 15:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755011423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrBFm9KN1k8udVr7PX4kpGMG0V0UIL0fa5o6pxCVKL0=;
	b=XsjQuubwmsiih146NSqb8faSruTHHTdth834QoQJ0hZC/tIsc2i3qV465hDdgVZfsafMZN
	ND/g/GgCB3OTxm96VX6dnHwAxI9eQYvVuWfBFC9BA0ujefHcli+7Buh3ayrBGj9IezmIqK
	9wgLqPiZTR9l6OuWeS3YeV8YrUCTlsI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-SghTwAjnNS-be_4HqIcxxA-1; Tue,
 12 Aug 2025 11:10:22 -0400
X-MC-Unique: SghTwAjnNS-be_4HqIcxxA-1
X-Mimecast-MFC-AGG-ID: SghTwAjnNS-be_4HqIcxxA_1755011419
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0E1D1808966;
	Tue, 12 Aug 2025 15:10:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E3871800290;
	Tue, 12 Aug 2025 15:10:09 +0000 (UTC)
Date: Tue, 12 Aug 2025 23:10:04 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aJtZTLPtHUfUsiuQ@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_081025_042170_069288AF 
X-CRM114-Status: GOOD (  13.69  )
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

On 08/12/25 at 08:49pm, Baoquan He wrote:
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
> 
> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
> 
> Changelog:
> ====
> v1->v2:
> - Add __ro_after_init for __ro_after_init, and remove redundant blank
                            ~~~~~~~~~~~~~ s/__ro_after_init/kasan_arg_disabled/
                            Sorry for typo here.
>   lines in mm/kasan/common.c. Thanks to Marco.



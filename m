Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41B0CA101F
	for <kexec@archiver.kernel.org>; Fri, 12 Sep 2025 06:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HNBcD/8+n0Gc4r0tfbcJk3JbRg5+y0i3aIdBUAR5FgQ=; b=b9eWOV4ujBjDb1HDNbKG9MZrKI
	hdsopZ0EGjwOHnfR6YpO9PzkkMFr8Z+qJuQHYFhXO97+PRrOT1EviJqXmxoEvR2NnGbGxE37bx208
	UkwH+CNDtIPVGJhw3BYbCdV30ycarfSYFRYiLJEmkfK53TvR+sspXg3h4FnV/5+Uwu7dl4UhYb1zR
	NATTDNXFbw+wqp4SFQYtR84xaLFzDwI+H5q3U8QJ9dtsI8FqRlmraIw4CHPxY34WlsA2iXLRWswb1
	Pwax7LzGgIS+Skh4roukEBOHllILdjxtYYLLhjExW2GFQQky9p+DZPu7S7RMuU+qCKdBtiXX7L/Jy
	ThPtjAGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwx0F-00000007KP8-2Tm6;
	Fri, 12 Sep 2025 06:11:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwx0C-00000007KO9-1sgv
	for kexec@lists.infradead.org;
	Fri, 12 Sep 2025 06:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757657479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNBcD/8+n0Gc4r0tfbcJk3JbRg5+y0i3aIdBUAR5FgQ=;
	b=JJa7xEf2RvMusDJeoQ6gImNji3E99PIKmXi1AwOvKTKKSuEo3HZ0CfM4I2W4GUg7FSGeFg
	HxBsNW/R7CSfFc2ASWiyLCESOepycJB5J8Bu7GHQi3JZX7kFq9qinVxlqIwZMv6SJPaoFt
	FWibygPzGY4O3sLzTXpww/r5zj2PAVA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-YeS2e8aMMqykZRPRk9ZpeQ-1; Fri,
 12 Sep 2025 02:11:13 -0400
X-MC-Unique: YeS2e8aMMqykZRPRk9ZpeQ-1
X-Mimecast-MFC-AGG-ID: YeS2e8aMMqykZRPRk9ZpeQ_1757657471
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71AC61955EA8;
	Fri, 12 Sep 2025 06:11:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D27B319560B1;
	Fri, 12 Sep 2025 06:11:08 +0000 (UTC)
Date: Fri, 12 Sep 2025 14:11:04 +0800
From: Baoquan He <bhe@redhat.com>
To: "Bouron, Justinien" <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Kudrjavets, Gunnar" <gunnarku@amazon.com>
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in
 segment loading
Message-ID: <aMO5eKSpvwYAtDtX@MiWiFi-R3L-srv>
References: <20250910163116.49148-1-jbouron@amazon.com>
 <aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
 <1659446A-F17C-4FF2-BE1B-3EC37520DDCB@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659446A-F17C-4FF2-BE1B-3EC37520DDCB@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_231120_560340_D58B5422 
X-CRM114-Status: GOOD (  15.27  )
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

On 09/11/25 at 03:30pm, Bouron, Justinien wrote:
> On 9/11/25, 02:42, "Baoquan He" <bhe@redhat.com <mailto:bhe@redhat.com>> wrote:
> > Do you mean we will adjust the memsz and buf_align to PAGE_SIZE aligned
> > in kexec_add_buffer()?
> That and mostly the fact that `sanity_check_segment_list()` explicitely rejects
> any segment that either does not start or end on a page boundary:

Ah, yes. I missed this one.

> 
> int sanity_check_segment_list(struct kimage *image)
> {
>     // ...
>     for (i = 0; i < nr_segments; i++) {
>         unsigned long mstart, mend;
> 
>         mstart = image->segment[i].mem;
>         mend   = mstart + image->segment[i].memsz;
>         if (mstart > mend)
>             return -EADDRNOTAVAIL;
>         if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
>             return -EADDRNOTAVAIL;
>         if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
>             return -EADDRNOTAVAIL;
>     }
>     // ...
> }
> 
> > That better be explained in log.
> Does it warrant a second revision to change the log?

I would appreciate it if we can tell the reason a little bit in patch
log. Because we have codes as below where people assign a non PAGE_SIZE
to kbuf.buf_align. With a general conclusion, people need explore code
to find out. At least that's what I do when I check this patch.

arch/x86/kernel/kexec-bzimage64.c:
static void *bzImage64_load(struct kimage *image, char *kernel,
                            unsigned long kernel_len, char *initrd,
                            unsigned long initrd_len, char *cmdline,
                            unsigned long cmdline_len)
{

	......
	        kbuf.buffer = params;
        kbuf.memsz = kbuf.bufsz;
        kbuf.buf_align = 16;
        kbuf.buf_min = MIN_BOOTPARAM_ADDR;
        ret = kexec_add_buffer(&kbuf);
        if (ret)
                goto out_free_params;
	......
}

Thanks
Baoquan



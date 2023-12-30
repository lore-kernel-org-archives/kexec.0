Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D2FC47073
	for <kexec@archiver.kernel.org>; Sat, 30 Dec 2023 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AhDS1APawjZ19ZdIxmd2FFvuz/nzZmAIbvRl7AIGjjc=; b=y0C2Xs0T6ugvF0
	AQnF87OxAKxD5QdAGkDCF+ztmJ9/Ir8A0YJ8XEbJ3c9LJ+VZ5jU5XwP2k7s4pLhEMVRwUzJmqamRB
	aaPBgQN6wWPoocz2GlI2S3H8RCbTrH+zonbm8Zz06uDsjZCuXrkyUhC4qGfUaqfy061XZ0pcSLx/4
	v7SYsq93W4enQmWZMHs+no59WMgaI+dQF19jKV1VhH7fouC8CZvi/lMOfJe6WK33h/5wtA7IWDQ+K
	WnSOslXRXTwm9F5QmY+grKpdSa+6TKT86GXlVM8xymSSCyYw5gA92gHTz7tn4BAU7Hli+z1/fBOMJ
	wDaiVGn96i9Gkd5/2dXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJWZn-002XUk-2l;
	Sat, 30 Dec 2023 10:28:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJWZk-002XUL-1j
	for kexec@lists.infradead.org;
	Sat, 30 Dec 2023 10:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703932095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aX1O++zYx1k3/mNIX5UfYhS34dL4AjJIqDFQMzvM7pA=;
	b=DpmXUBOgl6EtQObEnSkfxYvgBEgdPp8uWzf+Ns5vqQi99pKq5hJl1Zc/ZbFQ/kO57f2qJk
	e9NQh2leRsDEkjIaNTCB8dPqh2BtTS0iJAGuvFulObPe+0dzMpvwilqnPldx4YZXtcW9ik
	2lBi3GuwTRqEH0y3AsKHGOWsLhcl5pQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-mWMzJCyJOcSEIdihBIHiBA-1; Sat,
 30 Dec 2023 05:28:11 -0500
X-MC-Unique: mWMzJCyJOcSEIdihBIHiBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0E6529AA396;
	Sat, 30 Dec 2023 10:28:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.216])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B0C53C25;
	Sat, 30 Dec 2023 10:28:09 +0000 (UTC)
Date: Sat, 30 Dec 2023 18:28:06 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yuntao Wang <ytcoode@gmail.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, dyoung@redhat.com,
	hbathini@linux.ibm.com, hpa@zytor.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, seanjc@google.com,
	tglx@linutronix.de, tiwai@suse.de, vgoyal@redhat.com,
	x86@kernel.org
Subject: Re: [PATCH] crash_core: optimize crash_exclude_mem_range()
Message-ID: <ZY/wtvltzGR0CokV@MiWiFi-R3L-srv>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
 <20231219163418.108591-1-ytcoode@gmail.com>
 <20231229121014.fd090f8c616a34fbb45f7843@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231229121014.fd090f8c616a34fbb45f7843@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_022816_649001_86C1E133 
X-CRM114-Status: GOOD (  17.60  )
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

On 12/29/23 at 12:10pm, Andrew Morton wrote:
> On Wed, 20 Dec 2023 00:34:18 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > Because memory ranges in mem->ranges are stored in ascending order, when we
> > detect `p_end < start`, we can break the for loop early, as the subsequent
> > memory ranges must also be outside the range we are looking for.
> > 
> > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > ---
> > Hi Andrew,
> > 
> > Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
> > crash_exclude_mem_range()" can be ignored, use this patch instead.
> > 
> 
> Some reviewer input on this would be helpful please?


I suggested this in below discussion thread:
https://lore.kernel.org/all/ZYEOshALGbDKwSdc@MiWiFi-R3L-srv/T/#u

So it would be good if squashing this into patch 3 of another patch
thread you are asking:
[PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()

And I would suggest withdrawing Yuntao's below patch on your
mm-nonmm-unstable branch.

961c69e9f1bf x86/crash: fix potential cmem->ranges array overflow

Becase there's better one to fix the potential oob from fuqiang,
although fuqiang need improve his patch log.

[PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
https://lore.kernel.org/all/20231222121855.148215-1-fuqiang.wang@easystack.cn/T/#u

> 
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> >  		p_start = mstart;
> >  		p_end = mend;
> >  
> > -		if (p_start > end || p_end < start)
> > +		if (p_start > end)
> >  			continue;
> >  
> > +		if (p_end < start)
> > +			break;
> > +
> >  		/* Truncate any area outside of range */
> >  		if (p_start < start)
> >  			p_start = start;
> > -- 
> > 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

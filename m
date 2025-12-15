Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A7BD41D74
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 08:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqS8vgdM/pXRgmehW35ywc17iyd/2eXl+mmS1YO1Ya4=; b=o9N7EVNORNDkxY/SW5OPj4iVu1
	DmYk8bruIkEzYApLm5keXmbFbYPqCfz4aFfuAuqoZPEufR90449UmzNVFI9dXwqBx/4iuoWAyUYmn
	51249gp57offvaJbV1k7Hg/3qq6g1JEETBLlHBSEN46AFQDxMa9x6hWBam1+4WBWOAbFiGB6j2rTV
	/IzzxKYybLcg7zdd/JmxQ3Ct0FR34pKG71XlpfpEZLX7LtdWBvmbMTlQvaVTtDAUKjrkQ0QPoFuDY
	8Ue0GDz2SjeEKnv2tWuAyHPD4GAXXD/sdtgu3R6PXQGRU6UqLKK5k2SmqDKzqPkNgBNLEKAAYFTMy
	tp4hetNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV4Hs-00000003IgM-1191;
	Mon, 15 Dec 2025 08:50:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV4Hp-00000003Ifx-0cvU
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 08:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765788631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqS8vgdM/pXRgmehW35ywc17iyd/2eXl+mmS1YO1Ya4=;
	b=W30j/E+ewleUVRq+sYEP70FRC1YFiPUhOnjn9mB4N80GdqPsaiiY+oiFwFyhIyfhCAnswF
	rY1j1JAIyUdbfKZRQmusTsUZEVuHdvljtExyD6snMb33PEnnfOn5JGAQ5aJIJ9BVXSLVg3
	hzN29HrelgFZPP7NWP2mN+LuNQITCFY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-GK6b0kyxN5CKldTZLk9MoA-1; Mon,
 15 Dec 2025 03:50:29 -0500
X-MC-Unique: GK6b0kyxN5CKldTZLk9MoA-1
X-Mimecast-MFC-AGG-ID: GK6b0kyxN5CKldTZLk9MoA_1765788628
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CAB018001FE;
	Mon, 15 Dec 2025 08:50:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.95])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EB7819560A7;
	Mon, 15 Dec 2025 08:50:25 +0000 (UTC)
Date: Mon, 15 Dec 2025 16:50:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
Message-ID: <aT/LzbCZ2io2YBBX@MiWiFi-R3L-srv>
References: <20251212071656.834079-1-maqianga@uniontech.com>
 <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
 <84FB6FCADDAE5EBE+e11782ba-7483-40f4-8a40-a5e26f51183d@uniontech.com>
 <aT9h54lX3J+cO0gf@MiWiFi-R3L-srv>
 <C2FBF39E1F0503D4+8030be33-fd88-4f18-b631-a4fecaf62c5a@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C2FBF39E1F0503D4+8030be33-fd88-4f18-b631-a4fecaf62c5a@uniontech.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_005033_533532_1C92033A 
X-CRM114-Status: GOOD (  28.37  )
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

On 12/15/25 at 12:41pm, Qiang Ma wrote:
> 
> 在 2025/12/15 09:18, Baoquan He 写道:
> > On 12/14/25 at 07:35pm, Qiang Ma wrote:
> > > 在 2025/12/12 18:53, Baoquan He 写道:
> > > > On 12/12/25 at 03:16pm, Qiang Ma wrote:
> > > > > The image is initialized to NULL. Then, after calling kimage_alloc_init,
> > > > > we can directly goto 'out' because at this time, the kimage_free will
> > > > > determine whether image is a NULL pointer.
> > > > Rechecked the code flow, in kimage_alloc_init(), if anything wrong, the
> > > > allocated memory are all freed via out_free_control_pages and
> > > > out_free_image accordingly, any place missed? If no, I think the current
> > > > code is correctly handled.
> > > I rechecked the code and found no omissions.
> > Hmm, my bad, I didn't say my question clearly. I checked code, didn't
> > find anything wrong in the current code. In kimage_alloc_init(), the
> > allocated memory are all freed on failure, no memory leaked. Means you
> > are fixing correct code.
> Oh, I see. I recalled that this fix was in preparation for patch
> "kexec: add kexec flag to control debug printing" for kexec_dbg_print
> to be reset to false in kimage_free.
> 
> In that case, I don't think this patch should be posted separately.

If it's prepared for later patch, it should not be saying it's fixing
issue. People may be confused and try to add it to stable kernel.

> > 
> > > > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > > > ---
> > > > >    kernel/kexec.c | 4 +++-
> > > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > Acked-by: Baoquan He <bhe@redhat.com>
> > > > 
> > > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > > index 28008e3d462e..9bb1f2b6b268 100644
> > > > > --- a/kernel/kexec.c
> > > > > +++ b/kernel/kexec.c
> > > > > @@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > >    	unsigned long i;
> > > > >    	int ret;
> > > > > +	image = NULL;
> > > > > +
> > > > >    	/*
> > > > >    	 * Because we write directly to the reserved memory region when loading
> > > > >    	 * crash kernels we need a serialization here to prevent multiple crash
> > > > > @@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > >    	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
> > > > >    	if (ret)
> > > > > -		goto out_unlock;
> > > > > +		goto out;
> > > > >    	if (flags & KEXEC_PRESERVE_CONTEXT)
> > > > >    		image->preserve_context = 1;
> > > > > -- 
> > > > > 2.20.1
> > > > > 
> > 
> 



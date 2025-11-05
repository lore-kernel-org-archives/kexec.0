Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD24CCF9F8
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 06:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vk7GWEnRtGI2DGX3f0cxz4dFwcTmVgEkQ83OcqulT0c=; b=lSt17lzxNwK8j9E+/tMo2nRfqN
	pTHpj7jmcZwtaHDDf9Z6v3B/Vz/DLR/SDMma4enUstpCOpQPkyggwZeqOCry07feCw9l8UDlFGRMN
	XeZhK0AWVPNadzweKR8p9hWmi9sQZaU3MZYY+OYbaLBVbDh1mXLpqaZ4XrgW5u7YxyCRRG3MYKDyv
	uU9KUnFavNNmC/zLnLM1/rwGjCUbUh9pLufPFHDDdz+kllsf2L6wzO/JlLaDqpKOOg04qGCNtqzow
	yM9uS4za/ffNbWtKq80yPZ/bjpBYI+/JgUjs6peijckp4jvetkRDbjRbRFAByAd4YHP83s6ELoj5P
	mtzHvyeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXS2-0000000D6It-3OE1;
	Wed, 05 Nov 2025 06:57:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXRx-0000000D6II-32L3
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 06:57:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762325816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk7GWEnRtGI2DGX3f0cxz4dFwcTmVgEkQ83OcqulT0c=;
	b=IxwMqiNuaJal0cPv1ltB6XSVAK81otPc1sWZUPabPdhT40UWcEKJddTQ2+qFFprgJAGbxo
	njP2uFOyf9j14ch78lM8496Qarfa+xVw/nujlVl1Qb381i+qy5m+qAWsfxE4GUvXeFHB70
	k59iZRdAB1Q57/xwsqBpvHshd/fIgY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-GEAERZR7M_iBvWQLvt_nVA-1; Wed,
 05 Nov 2025 01:56:52 -0500
X-MC-Unique: GEAERZR7M_iBvWQLvt_nVA-1
X-Mimecast-MFC-AGG-ID: GEAERZR7M_iBvWQLvt_nVA_1762325810
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E5411956094;
	Wed,  5 Nov 2025 06:56:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D445B1800297;
	Wed,  5 Nov 2025 06:56:47 +0000 (UTC)
Date: Wed, 5 Nov 2025 14:56:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between
 loop variable types
Message-ID: <aQr1K/+I91RhVGuo@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
 <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
 <0C92443D3E2100AF+c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C92443D3E2100AF+c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_225658_185310_AB693DDE 
X-CRM114-Status: GOOD (  20.29  )
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

On 11/05/25 at 11:47am, Qiang Ma wrote:
> 
> 在 2025/11/5 11:05, Baoquan He 写道:
> > On 11/03/25 at 02:34pm, Qiang Ma wrote:
> > > The type of the struct kimage member variable nr_segments is unsigned long.
> > > Correct the loop variable i and the print format specifier type.
> > I can't see what's meaningful with this change. nr_segments is unsigned
> > long, but it's the range 'i' will loop. If so, we need change all for
> > loop of the int iterator.
> If image->nr_segments is large enough, 'i' overflow causes an infinite loop.

Please check kexec_add_buffer(), there's checking for the value which
upper limit is restricted to 16.

        if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
                return -EINVAL;

> > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > ---
> > >   kernel/kexec_file.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 4a24aadbad02..7afdaa0efc50 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >   	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
> > >   			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
> > >   	struct kimage **dest_image, *image;
> > > -	int ret = 0, i;
> > > +	int ret = 0;
> > > +	unsigned long i;
> > >   	/* We only trust the superuser with rebooting the system. */
> > >   	if (!kexec_load_permitted(image_type))
> > > @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >   		struct kexec_segment *ksegment;
> > >   		ksegment = &image->segment[i];
> > > -		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > > +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > >   			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> > >   			      ksegment->memsz);
> > > -- 
> > > 2.20.1
> > > 
> > 
> 



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2670CCF9FC
	for <kexec@archiver.kernel.org>; Thu, 30 Oct 2025 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/d/HRmDWcX+eRCc7ZcG6cq+zVaPfGqQhDVXjrBNobw=; b=Ckso1G0mcEZstcYSjPGm75YhCP
	jU3gzy8L4P/pqC7OB8A3+953/DsMlI5bjRRP7N0SJv7lbVggitT9y0c9tBJJSo3VQ28qAO0EOdpLp
	BWSyoSEothDlK3HnWo07+AeZ5gUyRRdOkm62vWhklk5c51EmYIWgbqo9mJRuHXFYpKf1oo6K/NF5h
	1jeYNnuDjr6MzlFIDqOj8r8DMy643+XkRkcyupKy3MSKDKKrvSb+sDDWiRTB9wLlgfW0eCFA4F2lr
	3v/33N3PUP/WO9Xc5w9//2tGsp/ARFVVbcyUP6DMnqTSi26eXL/5ZKrAPtmyiNSzScpKS1MEf+YPs
	2jdDG/0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vETBK-00000004Gfi-0On9;
	Thu, 30 Oct 2025 13:59:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vETBG-00000004Gf3-42so
	for kexec@lists.infradead.org;
	Thu, 30 Oct 2025 13:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761832749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/d/HRmDWcX+eRCc7ZcG6cq+zVaPfGqQhDVXjrBNobw=;
	b=JyVjL6tn+W8k3wEp96uEBYwq9guuphfZVT3pmQk75hQ30fft7nTwIoJcHoq/2MQWeaNvhV
	qtv/1Cnw3PyppOBthJvyid/6QojaXdVILHSmbzb4520w3dtSTt3BpaokzLgJE2cMsXmugq
	yXsWCmiIAFN55j8UssiCA9yhzDyAlqM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-qpABYTcGNOm8jOc1Acv_sg-1; Thu,
 30 Oct 2025 09:59:07 -0400
X-MC-Unique: qpABYTcGNOm8jOc1Acv_sg-1
X-Mimecast-MFC-AGG-ID: qpABYTcGNOm8jOc1Acv_sg_1761832743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2102019540E1;
	Thu, 30 Oct 2025 13:59:03 +0000 (UTC)
Received: from localhost (unknown [10.72.112.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07FA6300019F;
	Thu, 30 Oct 2025 13:59:00 +0000 (UTC)
Date: Thu, 30 Oct 2025 21:58:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
Message-ID: <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
 <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_065912_129245_9C0CE83D 
X-CRM114-Status: GOOD (  27.69  )
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

On 10/30/25 at 07:41pm, Qiang Ma wrote:
> 
> 在 2025/10/30 17:42, Baoquan He 写道:
> > On 10/30/25 at 03:33pm, Qiang Ma wrote:
> > > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > > if required") has added general code printing in kexec_file_load(),
> > > but not in kexec_load().
> > > 
> > > Especially in the RISC-V architecture, kexec_image_info() has been
> > > removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> > > message if required")). As a result, when using '-d' for the kexec_load
> > > interface, print nothing in the kernel space. This might be helpful for
> > > verifying the accuracy of the data passed to the kernel. Therefore, refer to
> > > this commit a85ee18c7900 ("kexec_file: print out debugging message
> > > if required"), debug print information has been added.
> > kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
> > doesn't work when you unset CONFIG_KEXEC_FILE.
> 
> Yes, I just actually tested it and it really doesn't work when unset
> CONFIG_KEXEC_FILE.
> 
> In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.

Hold on please, it may not need that highweight change. I will reply to
you tomorrow if I have other idea.

> 
> > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > ---
> > >   kernel/kexec.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index 28008e3d462e..02845a7499e9 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
> > >   	for (i = 0; i < nr_segments; i++) {
> > > +		struct kexec_segment *ksegment;
> > > +
> > > +		ksegment = &image->segment[i];
> > > +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > > +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> > > +			      ksegment->memsz);
> > > +
> > >   		ret = kimage_load_segment(image, i);
> > >   		if (ret)
> > >   			goto out;
> > > @@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> > > +		      image->type, image->start, image->head, flags);
> > > +
> > >   	/* Install the new kernel and uninstall the old */
> > >   	image = xchg(dest_image, image);
> > > -- 
> > > 2.20.1
> > > 
> > > 
> > 
> 



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B0ECCFA04
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ROFoOenJg5dQLwe7jDFuQ2CPZm8re5K1Y0RzrsdP5PY=; b=mD6MDPeXROXXfVU53NzMbgj9HI
	NVsGQ8uvci3xKqFdWc0P0rgySTNpwWkrYYAZ0Jv4WJqmevsIsw3Qh4BIU528vWVQVJFL5Bm8gskA6
	PczjAf+6RMdJrVIgF5vAcWymKyupWOnL038Z7nxCoogtnVsgaoN5EYTBWKnhvZKjRSNZEdbH7j3zR
	pOFcehlem4PwxtGmJfc+fwLRwr977svLTlq4dH3T8Atomrj2ojNQOThyzeZj/4sKGm/4B/dq4pcVI
	mYzwjwofN17qBljlhX5EZVr6Q3WRIfv19BPvYLS53n9IJUUDxMBGLPGUkgdAtaHVmQEanclcQeZ/w
	pZNZfUyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGYKd-0000000DEtk-1AxL;
	Wed, 05 Nov 2025 07:53:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGYKb-0000000DEsj-1Li7
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 07:53:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762329204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROFoOenJg5dQLwe7jDFuQ2CPZm8re5K1Y0RzrsdP5PY=;
	b=LckePZzKag9m5JdRzRB0wlyMnZuJ+6bS3E3wP1QLiI9RUTkFS7Aw0ldwNgvFsST3QVqGbL
	rMGMbWGQjA8KVLt/iypnh4NgObrpmyFQXKzgAOb8qf3elObJuHC20/dZW6oqi7UphTULkR
	/RQWR15Pp1HarmDMOXXywYzoh5WJwHo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-eoNnlLuxNJ6s1FfhmwnFUA-1; Wed,
 05 Nov 2025 02:53:22 -0500
X-MC-Unique: eoNnlLuxNJ6s1FfhmwnFUA-1
X-Mimecast-MFC-AGG-ID: eoNnlLuxNJ6s1FfhmwnFUA_1762329201
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 455171956059;
	Wed,  5 Nov 2025 07:53:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED60D3000198;
	Wed,  5 Nov 2025 07:53:17 +0000 (UTC)
Date: Wed, 5 Nov 2025 15:53:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aQsCaeTx0WduSjSz@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-4-maqianga@uniontech.com>
 <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
 <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_235325_434002_2A1EDACB 
X-CRM114-Status: GOOD (  28.98  )
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

On 11/05/25 at 11:41am, Qiang Ma wrote:
> 
> 在 2025/11/5 11:01, Baoquan He 写道:
> > On 11/03/25 at 02:34pm, Qiang Ma wrote:
> > > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > > if required") has added general code printing in kexec_file_load(),
> > > but not in kexec_load().
> > > 
> > > Especially in the RISC-V architecture, kexec_image_info() has been
> > > removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> > > message if required")). As a result, when using '-d' for the kexec_load
> > > interface, print nothing in the kernel space. This might be helpful for
> > > verifying the accuracy of the data passed to the kernel. Therefore,
> > > refer to this commit a85ee18c7900 ("kexec_file: print out debugging
> > > message if required"), debug print information has been added.
> > > 
> > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
> > > ---
> > >   kernel/kexec.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index c7a869d32f87..9b433b972cc1 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
> > >   	for (i = 0; i < nr_segments; i++) {
> > > +		struct kexec_segment *ksegment;
> > > +
> > > +		ksegment = &image->segment[i];
> > > +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > > +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> > > +			      ksegment->memsz);
> > There has already been a print_segments() in kexec-tools/kexec/kexec.c,
> > you will get duplicated printing. That sounds not good. Have you tested
> > this?
> I have tested it, kexec-tools is the debug message printed
> in user space, while kexec_dprintk is printed
> in kernel space.
> 
> This might be helpful for verifying the accuracy of
> the data passed to the kernel.

Hmm, that's not necessary with a debug printing to verify value passed
in kernel. We should only add debug pringing when we need but lack it. 
I didn't check it carefully, if you add the debug printing only for
verifying accuracy, that doesn't justify the code change.

> > > +
> > >   		ret = kimage_load_segment(image, i);
> > >   		if (ret)
> > >   			goto out;
> > > @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> > > +		      image->type, image->start, image->head, flags);
> > > +
> > >   	/* Install the new kernel and uninstall the old */
> > >   	image = xchg(dest_image, image);
> > > -- 
> > > 2.20.1
> > > 
> > 
> 



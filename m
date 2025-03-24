Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448FBC36002
	for <kexec@archiver.kernel.org>; Mon, 24 Mar 2025 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PS69gZ7L0QPn+MJNrvH0ZaDSrgaKGsoM7m8BjefV88=; b=sSm02QyqT6O3rvyCetoNxnFXyt
	Yg4OUuA/gNFp6ubpT4J9+xdwS6s+Jj+Zs2KD/zZomN+1kMOsLFIMJH67S8EX0aWZlkViW1oEuY5NQ
	1zIfE3VCvmCiiEmXtgRJE3e+3uXECJOEnSfpIp4t6gD4wihHuR4XavgbAOzBSv9BZAHN2+7jQOeBJ
	hIOZBDw50SdQu7AHVRJ1JDXEBrG1epCBJ3thgR4mX+Ri70E1MgvKAbHWNmKPZV/r/R5KzSLtOp99/
	+JaWskygc/mrlft3xUSyg0Ei4pdTkxXrYYdox2v6lEGgQA+DJGdpkti0y8jmMcZvCuM5NFpSx94mt
	fvL0kwhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twfZr-00000002uAL-1Uvn;
	Mon, 24 Mar 2025 11:02:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twfYK-00000002tzN-23TJ
	for kexec@lists.infradead.org;
	Mon, 24 Mar 2025 11:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742814066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PS69gZ7L0QPn+MJNrvH0ZaDSrgaKGsoM7m8BjefV88=;
	b=AN3M0QlXDNfhSoNzw4Il9YlZe4tTiwiGypkGd7gNQsWq8B/YAvFUd8Ya1FSAvxQMpoUGQ7
	I/airx1/33EvVydIm3Xj1vLjuQVYsxYWzPIc5bIeSqrl40hR2pUpGw9NaZBXMWO/9mUjfc
	hbqAoR75ZmLTyswgbNtV2ASm9D6RcBo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-uB3P39bgPWWtQdZfxMmeVA-1; Mon,
 24 Mar 2025 07:01:02 -0400
X-MC-Unique: uB3P39bgPWWtQdZfxMmeVA-1
X-Mimecast-MFC-AGG-ID: uB3P39bgPWWtQdZfxMmeVA_1742814060
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09060196B370;
	Mon, 24 Mar 2025 11:01:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC52719560AD;
	Mon, 24 Mar 2025 11:00:56 +0000 (UTC)
Date: Mon, 24 Mar 2025 19:00:47 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_040108_601835_ECE19B45 
X-CRM114-Status: GOOD (  17.80  )
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

On 03/21/25 at 09:23am, steven chen wrote:
> On 3/19/2025 7:06 PM, Baoquan He wrote:
> > On 03/17/25 at 06:04pm, steven chen wrote:
> > ...snip...
> > > ---
> > >   kernel/kexec_file.c                | 10 ++++++
> > >   security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
> > >   2 files changed, 40 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 606132253c79..ab449b43aaee 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
> > >   }
> > >   #endif
> > > +static void kimage_file_post_load(struct kimage *image)
> > > +{
> > > +#ifdef CONFIG_IMA_KEXEC
> > > +	ima_kexec_post_load(image);
> > > +#endif
> > > +}
> > > +
> > >   /*
> > >    * In file mode list of segments is prepared by kernel. Copy relevant
> > >    * data from user space, do error checking, prepare segment list
> > > @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >   	kimage_terminate(image);
> > > +	if (!(flags & KEXEC_FILE_ON_CRASH))
> > > +		kimage_file_post_load(image);
> > machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
> > we should use it to do things post load, but not introducing another
> > kimage_file_post_load().
> 
> Hi Baoquan,
> 
> Could you give me more detail about this?

I mean machine_kexec_post_load() is the place where post load operations
are done, including kexec_load and kexec_file_load. There's no need to
specifically introduce a kimage_file_post_load() to do post load
operaton for kexec_file_load.



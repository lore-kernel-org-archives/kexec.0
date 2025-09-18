Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73620CAC5A0
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6DJ2s18FdX+Nqa8e5WVMJEqWKLADAlvemQSEP0DBOU=; b=DGOYp6JmFEOp94LTZ6q0pTJqqE
	vTgPMtgXEFw1wyEP88Ad9Rmy+/qkmg4izqsHwxfps9wW/ks0OZWMnho2vKa20GigmSvMRSrfF6knt
	whfBDaXoKWtfstWBmeqGCfoA4QXHoDx/GcGZvWWKjMDlZMC5T8RwXrRp2+7qt3v27Vn8Xi0bkvc1A
	HkBYDkfTtQPnnYO9Jdk7SuXawKzdXjHgqBG5q78z8BOlImbaF6EXlv8bY6/KHvle/8OTpsQew4xXL
	XRp08eXihzgZpKWHPPaHo0cVqn9Co1KG2f5RScxYsJ4Sf5axcFst/AxQ0zwZ6CpC+wceSmyOEeem/
	70i1V7ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzEvi-0000000HaJa-1q3D;
	Thu, 18 Sep 2025 13:44:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzEvi-0000000HaJS-0HW8
	for kexec@bombadil.infradead.org;
	Thu, 18 Sep 2025 13:44:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=c6DJ2s18FdX+Nqa8e5WVMJEqWKLADAlvemQSEP0DBOU=; b=VG7jYAZsqeL/UrTRc0bZmlF2hU
	sxqCgiCGV3yc/AQsFzLh/nxEbFsH/FKAyZfQuaWkyT6xviYfi0pGb468y3TID3FMOE7s3uhuPDHrh
	jg7BZTCULLNocw2nx/zTJAxxlIOn55Omf3reoYDIPNW6knEgkLm0eoyas09iWLsteEkzJYo+6QKSR
	QQ5givzWku8YipQEUftVYe6sbHU89tkYopa6if91e3dG0PLjGi8yjqTmCz/LZb5ORGTMIyM2hWZWf
	aMD/BsC5W0q6YWznGguPiNuRc2+Pi+eh7EL2F9XqtKmhBOINs0QyEQhqTkirNa3ueB41mtYWr8wO1
	akzElAyg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzEvf-00000007c9P-0UD0
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 13:44:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758203039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6DJ2s18FdX+Nqa8e5WVMJEqWKLADAlvemQSEP0DBOU=;
	b=HOcqZEDQns+bg3TOZsYhEJa4PD9EfzOuW1nBjip+i5sKQCnuyIzHUTYPJ+BfNxdggSPFoX
	YJqY/Y5Ylel2aFaaihaI8950MmRTyOIuo9e5NQOCxyq0MLf9PCevUFpooXJrmaEO2BhpYg
	FJmHiqJVe1QCwXnt4kOFIdY76n0nDUo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758203046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6DJ2s18FdX+Nqa8e5WVMJEqWKLADAlvemQSEP0DBOU=;
	b=IcM5YNL8bH2b6ed+b/pcD/2/Ii9u3RNpTQ+NfclEDhcLJoVB6B7Vw/ZtyEREnAPQYrpy7A
	8PRql5GZ9LAcHGyZLGfOQuNjK5+9ZMbuj7wrs4LebaKFk1nmc6GP2D+XHOvu5RO3AJJIat
	Vm/KK96iwwmlVZlhAunrPcHeSivXAYY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-ptIdZqmxMSy0YJFQVGXz6Q-1; Thu,
 18 Sep 2025 09:43:56 -0400
X-MC-Unique: ptIdZqmxMSy0YJFQVGXz6Q-1
X-Mimecast-MFC-AGG-ID: ptIdZqmxMSy0YJFQVGXz6Q_1758203034
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54FCB1956054;
	Thu, 18 Sep 2025 13:43:53 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.225.227])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0ABDC300018D;
	Thu, 18 Sep 2025 13:43:45 +0000 (UTC)
Date: Thu, 18 Sep 2025 15:43:42 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon Horman
 <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr
 <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 06/12] kexec: Integrate with the introduced bpf kfuncs
Message-ID: <20250918154342.0589fd4b@rotkaeppchen>
In-Reply-To: <aMkJNuORiqSZfpok@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
	<20250819012428.6217-7-piliu@redhat.com>
	<20250901163042.721db92d@rotkaeppchen>
	<aMkJNuORiqSZfpok@fedora>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_144407_477237_A089F071 
X-CRM114-Status: GOOD (  37.11  )
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

Hi Pingfan,

On Tue, 16 Sep 2025 14:52:38 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> On Mon, Sep 01, 2025 at 04:30:42PM +0200, Philipp Rudo wrote:
> > Hi Pingfan,
> > 
> > 
> > On Tue, 19 Aug 2025 09:24:22 +0800
> > Pingfan Liu <piliu@redhat.com> wrote:
> >   
> > > This patch does two things:
> > > First, register as a listener on bpf_copy_to_kernel()
> > > Second, in order that the hooked bpf-prog can call the sleepable kfuncs,
> > > bpf_handle_pefile and bpf_post_handle_pefile are marked as
> > > KF_SLEEPABLE.
> > > 
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Philipp Rudo <prudo@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: bpf@vger.kernel.org
> > > To: kexec@lists.infradead.org
> > > ---
> > >  kernel/kexec_pe_image.c | 67 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 67 insertions(+)
> > > 
> > > diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> > > index b0cf9942e68d2..f8debcde6b516 100644
> > > --- a/kernel/kexec_pe_image.c
> > > +++ b/kernel/kexec_pe_image.c
> > > @@ -38,6 +38,51 @@ static struct kexec_res parsed_resource[3] = {
> > >  	{ KEXEC_RES_CMDLINE_NAME, },
> > >  };
> > >  
> > > +/*
> > > + * @name should be one of : kernel, initrd, cmdline
> > > + */
> > > +static int bpf_kexec_carrier(const char *name, struct mem_range_result *r)
> > > +{
> > > +	struct kexec_res *res;
> > > +	int i;
> > > +
> > > +	if (!r || !name)
> > > +		return -EINVAL;
> > > +
> > > +	for (i = 0; i < 3; i++) {
> > > +		if (!strcmp(parsed_resource[i].name, name))
> > > +			break;
> > > +	}
> > > +	if (i >= 3)
> > > +		return -EINVAL;  
> > 
> > Can you please replace the magic '3' by ARRAY_SIZE, just like you did
> > below when (un-)registering the listener.
> >   
> 
> Yes, I will introduce a macro KEXEC_RES_ARRAY_SIZE to unify all of them.

Why do you want to introduce a new macro? Why not simply use
ARRAY_SIZE(parsed_resource)?

Thanks
Philipp

> Thanks,
> 
> Pingfan
> 
> > Thanks
> > Philipp
> >   
> > > +
> > > +	res = &parsed_resource[i];
> > > +	/*
> > > +	 * Replace the intermediate resource generated by the previous step.
> > > +	 */
> > > +	if (!!res->r)
> > > +		mem_range_result_put(res->r);
> > > +	mem_range_result_get(r);
> > > +	res->r = r;
> > > +	return 0;
> > > +}
> > > +
> > > +static struct carrier_listener kexec_res_listener[3] = {
> > > +	{ .name = KEXEC_RES_KERNEL_NAME,
> > > +	  .alloc_type = 1,
> > > +	  .handler = bpf_kexec_carrier,
> > > +	},
> > > +	{ .name = KEXEC_RES_INITRD_NAME,
> > > +	  .alloc_type = 1,
> > > +	  .handler = bpf_kexec_carrier,
> > > +	},
> > > +	{ .name = KEXEC_RES_CMDLINE_NAME,
> > > +	  /* kmalloc-ed */
> > > +	  .alloc_type = 0,
> > > +	  .handler = bpf_kexec_carrier,
> > > +	},
> > > +};
> > > +
> > >  static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
> > >  
> > >  static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> > > @@ -159,6 +204,22 @@ __attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_c
> > >  	dummy += 2;
> > >  }
> > >  
> > > +BTF_KFUNCS_START(kexec_modify_return_ids)
> > > +BTF_ID_FLAGS(func, bpf_handle_pefile, KF_SLEEPABLE)
> > > +BTF_ID_FLAGS(func, bpf_post_handle_pefile, KF_SLEEPABLE)
> > > +BTF_KFUNCS_END(kexec_modify_return_ids)
> > > +
> > > +static const struct btf_kfunc_id_set kexec_modify_return_set = {
> > > +	.owner = THIS_MODULE,
> > > +	.set = &kexec_modify_return_ids,
> > > +};
> > > +
> > > +static int __init kexec_bpf_prog_run_init(void)
> > > +{
> > > +	return register_btf_fmodret_id_set(&kexec_modify_return_set);
> > > +}
> > > +late_initcall(kexec_bpf_prog_run_init);
> > > +
> > >  /*
> > >   * PE file may be nested and should be unfold one by one.
> > >   * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
> > > @@ -213,6 +274,9 @@ static void *pe_image_load(struct kimage *image,
> > >  	cmdline_start = cmdline;
> > >  	cmdline_sz = cmdline_len;
> > >  
> > > +	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> > > +		register_carrier_listener(&kexec_res_listener[i]);
> > > +
> > >  	while (is_valid_format(linux_start, linux_sz) &&
> > >  	       pe_has_bpf_section(linux_start, linux_sz)) {
> > >  		struct kexec_context context;
> > > @@ -250,6 +314,9 @@ static void *pe_image_load(struct kimage *image,
> > >  		disarm_bpf_prog();
> > >  	}
> > >  
> > > +	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> > > +		unregister_carrier_listener(kexec_res_listener[i].name);
> > > +
> > >  	/*
> > >  	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
> > >  	 * be updated to the new content.  
> >   
> 



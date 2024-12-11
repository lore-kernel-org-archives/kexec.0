Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B84E77182
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DEcDh+LdwGMntwkxIbCzkLoVBb89ABtlpvYyrYztn0=; b=iUMcXLdPPfk40mLL4Y5zyEeuaV
	0ljpKNPVbQ5zaANRlNv2yO0m7U8EFWGtSQVOmRF/gqlTGyhar3lMJMkwmvLM7EOZ789SEOIfYLm+l
	oE7xZ5BXqzS8WvFG6y3NMt8mSfMSLBvsRRM1YXxiWto7hVYK/6M4FtYt2A9S0rKgsTWNiBQHqRQAo
	4JzcYiG/f3LLJG3EWXYNroSi/b4Q86nod6CVRrDQEWtIjn/jHS2cUBt1PfL20c2jk33iMwcuQVvdp
	77wPtmlD2U5L5aVcMQ5skctWZ0uX6UkpwfVNky5LpLk6pj6aoX81en999xq2h+qqKtDWYbF3pFGxF
	1XS3q2ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLMNu-0000000EvCL-3N88;
	Wed, 11 Dec 2024 13:04:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLMIg-0000000Eu1K-3jNz
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 12:58:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733921925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DEcDh+LdwGMntwkxIbCzkLoVBb89ABtlpvYyrYztn0=;
	b=CvZRiIn43pzllFdN7DGuEroWhqo9wvog1nuXwDwV43wFTVvXobjcjVx78YymERmLhuYTdm
	RIIDQ3rTCUp/uFOxpc8otbSr8IA5RC3hJjezukgpB0b8B6zwXgC3FZ+7borY+bTBok4nfP
	etnVO8bOkIUOOxPReEuHIxc0+EP0u+I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-_hM7nGCVOMm_QIe9A0sMKw-1; Wed,
 11 Dec 2024 07:58:42 -0500
X-MC-Unique: _hM7nGCVOMm_QIe9A0sMKw-1
X-Mimecast-MFC-AGG-ID: _hM7nGCVOMm_QIe9A0sMKw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 905441956089;
	Wed, 11 Dec 2024 12:58:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29C59300018D;
	Wed, 11 Dec 2024 12:58:32 +0000 (UTC)
Date: Wed, 11 Dec 2024 20:58:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved
 memory
Message-ID: <Z1mMc+/dCk+mSahu@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-4-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-4-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_045846_996196_FFE58F25 
X-CRM114-Status: GOOD (  11.32  )
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

On 10/29/24 at 01:52pm, Coiby Xu wrote:
......
> +int crash_load_dm_crypt_keys(struct kimage *image)
> +{
> +	struct kexec_buf kbuf = {
> +		.image = image,
> +		.buf_min = 0,
> +		.buf_max = ULONG_MAX,
> +		.top_down = false,
> +		.random = true,
> +	};
> +	int r;
> +
> +
> +	if (key_count <= 0) {
> +		kexec_dprintk("No dm-crypt keys\n");
> +		return -EINVAL;
> +	}
> +
> +	image->dm_crypt_keys_addr = 0;
> +	r = build_keys_header();
> +	if (r)
> +		return r;
> +
> +	kbuf.buffer = keys_header;
> +	kbuf.bufsz = get_keys_header_size(key_count);
> +
> +	kbuf.memsz = kbuf.bufsz;
> +	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	r = kexec_add_buffer(&kbuf);
> +	if (r) {
> +		kvfree((void *)kbuf.buffer);
> +		return r;
> +	}
> +	image->dm_crypt_keys_addr = kbuf.mem;
> +	image->dm_crypt_keys_sz = kbuf.bufsz;

Wondering why not assigning kbuf.memsz, but bufsz.

> +	kexec_dprintk(
> +		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
> +		kbuf.bufsz, kbuf.bufsz);
> +
> +	return r;
> +}
> +
> +
>  static int __init configfs_dmcrypt_keys_init(void)
>  {
>  	int ret;
> -- 
> 2.47.0
> 



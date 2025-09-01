Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FE0CA0FFF
	for <kexec@archiver.kernel.org>; Mon,  1 Sep 2025 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUYaeq9idzhAgy3kGcN1jl7xeqJL2afaZsvOUDSXRMg=; b=PoguZ9FySSfYfVVS//L6j4T9Jl
	HMdVHySWgq1UAKNKPybuPtH10Ondo0nB1L93kk/BmWjXiMcTzIQ60A3SBdxt88V4rY1f92g9obWDA
	2BUwbNRrYuvoErK7ehTxHUrocY/ytGvzvrac7XJjYbXqolWF6TRRXe1IWgKVEXjzFmx+DnIXtiJS4
	ngdrBJqOANUimNx2FPqE6ipQzUp7jtzLqr5Lq/ltkaAXQYYBFcfTXKRa6+HhGDnOhB6qfcUvpJ8DI
	w1l+f2XnIaY6mOuBAnjR0cANOict29Gln5bnPefaFPheoBcpcPdxwB/5/TY4aCMf/snnw11QsQCmC
	tLkbHCUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut8gB-0000000DUyH-1kjN;
	Mon, 01 Sep 2025 17:50:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut5Yx-0000000CqSJ-0zQH
	for kexec@bombadil.infradead.org;
	Mon, 01 Sep 2025 14:31:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nUYaeq9idzhAgy3kGcN1jl7xeqJL2afaZsvOUDSXRMg=; b=kFjxFWJNvR4abY9RXunzLl+c/5
	el7KgrA8ozCkkDxQkCngjufnB9R5QJsoV8eARAU7YDCYV/g2d1rQXmC+owSD/Cs74drHm+C64P1vJ
	DDFRUs3svFumeYO6SmgNaJlXvF0UVvSrMNOTu1w1ErIQa2RBaqB3J2Zvw/cmomb+DPQiPzNtQztU6
	JUn19N4UgCcpb340NeKBEft6B80igZlzUkQ/g8scJUGlOVhP3iYwoy1+Uv2Qz9FSIMBbMlc6fyBmB
	4T68DUMor9iksQs9RrmVKTcGFNVzijIozN+E/NhOCqTgFi3NKTqRocMY1QJ9T1sSk8nOk0JNt2HRa
	4SEPjbhw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut5Yt-00000003lr9-3O5C
	for kexec@lists.infradead.org;
	Mon, 01 Sep 2025 14:31:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUYaeq9idzhAgy3kGcN1jl7xeqJL2afaZsvOUDSXRMg=;
	b=cfLLIo1OVNGhzHF6fOWMjwScgECOnIY9DIDLx4GUFGlXC4T9B1PHT8CamOthoAIYfWk4UZ
	FLZitOJIZ7UOswSYkX9oUzUhdMr2OYw75rlt8hpZhm1OUI0tzzZ45AInf455rHCxdQ67em
	7NkpMmxFwj1TXScUIMPIOq5BGhKPnCM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUYaeq9idzhAgy3kGcN1jl7xeqJL2afaZsvOUDSXRMg=;
	b=D1NTk2twpMOfW5kcXd0FUM9Q79dBOICow9EekkJabn8tliqHpxPv1HlFAZj8elLqgNuIot
	YS2sXFwaPyoDNX5kBXckEEfqB45484U7FbFfHKAiQlDYKa2FBGbdssPcJRk1HKur2W31wa
	x2koL76VF2NzsUq4fVgJyBZG4owUAUk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-4yFJwg86OrqM4rSjzQVR7w-1; Mon,
 01 Sep 2025 10:30:59 -0400
X-MC-Unique: 4yFJwg86OrqM4rSjzQVR7w-1
X-Mimecast-MFC-AGG-ID: 4yFJwg86OrqM4rSjzQVR7w_1756737057
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C460C19560B2;
	Mon,  1 Sep 2025 14:30:56 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.224.104])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EE3319560B4;
	Mon,  1 Sep 2025 14:30:46 +0000 (UTC)
Date: Mon, 1 Sep 2025 16:30:42 +0200
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
Message-ID: <20250901163042.721db92d@rotkaeppchen>
In-Reply-To: <20250819012428.6217-7-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
	<20250819012428.6217-7-piliu@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_153112_256090_19FCFD67 
X-CRM114-Status: GOOD (  30.32  )
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


On Tue, 19 Aug 2025 09:24:22 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> This patch does two things:
> First, register as a listener on bpf_copy_to_kernel()
> Second, in order that the hooked bpf-prog can call the sleepable kfuncs,
> bpf_handle_pefile and bpf_post_handle_pefile are marked as
> KF_SLEEPABLE.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: bpf@vger.kernel.org
> To: kexec@lists.infradead.org
> ---
>  kernel/kexec_pe_image.c | 67 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> index b0cf9942e68d2..f8debcde6b516 100644
> --- a/kernel/kexec_pe_image.c
> +++ b/kernel/kexec_pe_image.c
> @@ -38,6 +38,51 @@ static struct kexec_res parsed_resource[3] = {
>  	{ KEXEC_RES_CMDLINE_NAME, },
>  };
>  
> +/*
> + * @name should be one of : kernel, initrd, cmdline
> + */
> +static int bpf_kexec_carrier(const char *name, struct mem_range_result *r)
> +{
> +	struct kexec_res *res;
> +	int i;
> +
> +	if (!r || !name)
> +		return -EINVAL;
> +
> +	for (i = 0; i < 3; i++) {
> +		if (!strcmp(parsed_resource[i].name, name))
> +			break;
> +	}
> +	if (i >= 3)
> +		return -EINVAL;

Can you please replace the magic '3' by ARRAY_SIZE, just like you did
below when (un-)registering the listener.

Thanks
Philipp

> +
> +	res = &parsed_resource[i];
> +	/*
> +	 * Replace the intermediate resource generated by the previous step.
> +	 */
> +	if (!!res->r)
> +		mem_range_result_put(res->r);
> +	mem_range_result_get(r);
> +	res->r = r;
> +	return 0;
> +}
> +
> +static struct carrier_listener kexec_res_listener[3] = {
> +	{ .name = KEXEC_RES_KERNEL_NAME,
> +	  .alloc_type = 1,
> +	  .handler = bpf_kexec_carrier,
> +	},
> +	{ .name = KEXEC_RES_INITRD_NAME,
> +	  .alloc_type = 1,
> +	  .handler = bpf_kexec_carrier,
> +	},
> +	{ .name = KEXEC_RES_CMDLINE_NAME,
> +	  /* kmalloc-ed */
> +	  .alloc_type = 0,
> +	  .handler = bpf_kexec_carrier,
> +	},
> +};
> +
>  static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
>  
>  static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> @@ -159,6 +204,22 @@ __attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_c
>  	dummy += 2;
>  }
>  
> +BTF_KFUNCS_START(kexec_modify_return_ids)
> +BTF_ID_FLAGS(func, bpf_handle_pefile, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_post_handle_pefile, KF_SLEEPABLE)
> +BTF_KFUNCS_END(kexec_modify_return_ids)
> +
> +static const struct btf_kfunc_id_set kexec_modify_return_set = {
> +	.owner = THIS_MODULE,
> +	.set = &kexec_modify_return_ids,
> +};
> +
> +static int __init kexec_bpf_prog_run_init(void)
> +{
> +	return register_btf_fmodret_id_set(&kexec_modify_return_set);
> +}
> +late_initcall(kexec_bpf_prog_run_init);
> +
>  /*
>   * PE file may be nested and should be unfold one by one.
>   * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
> @@ -213,6 +274,9 @@ static void *pe_image_load(struct kimage *image,
>  	cmdline_start = cmdline;
>  	cmdline_sz = cmdline_len;
>  
> +	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> +		register_carrier_listener(&kexec_res_listener[i]);
> +
>  	while (is_valid_format(linux_start, linux_sz) &&
>  	       pe_has_bpf_section(linux_start, linux_sz)) {
>  		struct kexec_context context;
> @@ -250,6 +314,9 @@ static void *pe_image_load(struct kimage *image,
>  		disarm_bpf_prog();
>  	}
>  
> +	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> +		unregister_carrier_listener(kexec_res_listener[i].name);
> +
>  	/*
>  	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
>  	 * be updated to the new content.



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92933C3ABC0
	for <kexec@archiver.kernel.org>; Thu,  8 May 2025 07:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TZTevEtSixkUFIWAAgpBtf54+V/8lG/q2RrDnXwunY8=; b=DVxdC8r2QWHxCqaSfZ3SJJ7HGX
	7VH5cdt2ahXievjViLCFxRivv0Eud/nP2QBEYO/uhQOwXlhywG1CPinlQUAbB0jUhG7H6ul0FFeFU
	E41dSmRNFW8578N0mtZ185zo23nN9CifMAfcidH56+6cYjT1ClfRPeVVb8OeQyG1VWxO5hgjMJNpg
	h2TDFVhWiNDUP8y2E2eQb8+k3sb968S5PZOAhkZCB9hB0qb0ofUez7goo2QYEnK0QBaPgJ/lYN+TG
	0KIKB4+WZuvLcZEjjX4ijL7iuSGJ7yqlKACqh4xpkWkE4ECi1hY/aVLO2WIuDPlaWAUtsNfwEA47J
	SBmhJEVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvgb-0000000Hazl-2PR7;
	Thu, 08 May 2025 07:28:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvQx-0000000HYnA-3eil
	for kexec@lists.infradead.org;
	Thu, 08 May 2025 07:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746688362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZTevEtSixkUFIWAAgpBtf54+V/8lG/q2RrDnXwunY8=;
	b=WuAg50P6JWP9VMmVMOoHftzg47dyN3Mc8Ql3x4j8BCiKG4Y7DDGKzLnZdRkiY5Vauf9zuB
	JYuNQIAzMwfwQlIvaK2HqIwrvR+B3D9AJl6acRq44CYNH/8gvGOrzCJ4YQcSda0+kP6svJ
	/EYHUHjzT15bO5wBSQtJDxTyPk57+JE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-1vAZ0qsDO4-R41t-xROHMg-1; Thu,
 08 May 2025 03:12:37 -0400
X-MC-Unique: 1vAZ0qsDO4-R41t-xROHMg-1
X-Mimecast-MFC-AGG-ID: 1vAZ0qsDO4-R41t-xROHMg_1746688356
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ED751800370;
	Thu,  8 May 2025 07:12:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060A51953B85;
	Thu,  8 May 2025 07:12:32 +0000 (UTC)
Date: Thu, 8 May 2025 15:12:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Coiby Xu <coxu@redhat.com>, fuqiang wang <fuqiang.wang@easystack.cn>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <aBxZXMat4SRhDZsM@MiWiFi-R3L-srv>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
 <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
 <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_001243_986039_20EBAFB8 
X-CRM114-Status: GOOD (  29.02  )
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

On 05/07/25 at 10:59pm, Andrew Morton wrote:
> On Thu, 8 May 2025 12:25:15 +0800 Coiby Xu <coxu@redhat.com> wrote:
> 
> > >
> > >Acked-by: Baoquan He <bhe@redhat.com>
> > 
> > Hi Andrew,
> > 
> > It seems this patch was missed.
> 
> January 2024.  Yes, it's fair to assume that it was missed ;)
> 
> > Will you pick it up?
> 
> Sure.
> 
> > Without this patch,
> > kdump kernel will fail to be loaded by the kexec_file_load,
> > 
> >   [  139.736948] UBSAN: array-index-out-of-bounds in arch/x86/kernel/crash.c:350:25
> >   [  139.742360] index 0 is out of range for type 'range [*]'
> >   [  139.745695] CPU: 0 UID: 0 PID: 5778 Comm: kexec Not tainted 6.15.0-0.rc3.20250425git02ddfb981de8.32.fc43.x86_64 #1 PREEMPT(lazy) 
> >   [  139.745698] Hardware name: Amazon EC2 c5.large/, BIOS 1.0 10/16/2017
> >   [  139.745699] Call Trace:
> >   [  139.745700]  <TASK>
> >   [  139.745701]  dump_stack_lvl+0x5d/0x80
> >   [  139.745706]  ubsan_epilogue+0x5/0x2b
> >   [  139.745709]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
> >   [  139.745711]  crash_setup_memmap_entries+0x2d9/0x330
> >   [  139.745716]  setup_boot_parameters+0xf8/0x6a0
> >   [  139.745720]  bzImage64_load+0x41b/0x4e0
> >   [  139.745722]  ? find_next_iomem_res+0x109/0x140
> >   [  139.745727]  ? locate_mem_hole_callback+0x109/0x170
> >   [  139.745737]  kimage_file_alloc_init+0x1ef/0x3e0
> >   [  139.745740]  __do_sys_kexec_file_load+0x180/0x2f0
> >   [  139.745742]  do_syscall_64+0x7b/0x160
> >   [  139.745745]  ? do_user_addr_fault+0x21a/0x690
> >   [  139.745747]  ? exc_page_fault+0x7e/0x1a0
> >   [  139.745749]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >   [  139.745751] RIP: 0033:0x7f7712c84e4d
> > 
> 
> Do we know why this has appeared at such a late date?  The reporter
> must be doing something rare.
> 
> Baoquan, please re-review this?
> 
> A -stable backport is clearly required.  A Fixes: would be nice, but I
> assume this goes back a long time so it isn't worth spending a lot of
> time working out when this was introduced.

No need for stable kernel. The UBSAN only warns a potential risk, it
won't happen in reality. I am talking to Coiby, he got it wrong about
the testing result. He saw the UBSAN warning when UBSAN is enabled,
while vmcore is till saved successfully.

> 
> The patch needed a bit of work to apply to current code.  I did the
> below.  It compiles.
> 
> --- a/arch/x86/kernel/crash.c~x86-kexec-fix-potential-cmem-ranges-out-of-bounds
> +++ a/arch/x86/kernel/crash.c
> @@ -165,8 +165,18 @@ static struct crash_mem *fill_up_crash_e
>  	/*
>  	 * Exclusion of crash region and/or crashk_low_res may cause
>  	 * another range split. So add extra two slots here.
> +	 *
> +	 * Exclusion of low 1M may not cause another range split, because the
> +	 * range of exclude is [0, 1M] and the condition for splitting a new
> +	 * region is that the start, end parameters are both in a certain
> +	 * existing region in cmem and cannot be equal to existing region's
> +	 * start or end. Obviously, the start of [0, 1M] cannot meet this
> +	 * condition.
> +	 *
> +	 * But in order to lest the low 1M could be changed in the future,
> +	 * (e.g. [stare, 1M]), add a extra slot.
>  	 */
> -	nr_ranges += 2;
> +	nr_ranges += 3;
>  	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
>  	if (!cmem)
>  		return NULL;
> @@ -317,9 +327,16 @@ int crash_setup_memmap_entries(struct ki
>  	 * split. So use two slots here.
>  	 */
>  	nr_ranges = 2;
> -	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> +	/*
> +	 * In the current x86 architecture code, the elfheader is always
> +	 * allocated at crashk_res.start. But it depends on the allocation
> +	 * position of elfheader in crashk_res. To avoid potential out of
> +	 * bounds in future, add a extra slot.
> +	 */
> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>  	if (!cmem)
>  		return -ENOMEM;
> +	cmem->max_nr_ranges = 2;
>  
>  	cmem->max_nr_ranges = nr_ranges;
>  	cmem->nr_ranges = 0;
> _
> 



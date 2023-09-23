Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDCBCE7A81
	for <kexec@archiver.kernel.org>; Sat, 23 Sep 2023 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WzIudOVd8LUj+se8cn89uCYd4EPAMLBi8lKn6r5EM+o=; b=VbUQ7mI0LEWeOg
	dszBWAk990w0PfPh4xYXWvtIQlGYXC7Lt3bnms0SaDE/CL2ANG+6IhUB2L0v3+jiuw9e28y+fE+Z3
	tAx59RPmEOyoHUjqmOVLN+0GF9+cfa0DSk89RDl5wgVc+RSKCZLsDU5c2+fYadBfiKeKBC2G7Tcn6
	FkFKdxlC//ckN36I4bRpRe5PgqkqMz6FnbVJIE/4x5evg01Rt4avCpv2bl/MN/YvVU7vcSkHvAlOH
	/2vQfkWfwosDJl3yMJee/z7DHmF8jO5WO1Ypv78KeWTMWc5Y2HVQvFK+51bZYc17eF+bgo7dxdpIK
	fSzP5N9y3fBUbOg+wB/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjqnZ-00A3di-2L;
	Sat, 23 Sep 2023 00:47:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjqnW-00A3d6-16
	for kexec@lists.infradead.org;
	Sat, 23 Sep 2023 00:47:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695430015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFq6zMaaGytyLVjCRlM3YGZB/pczKiOV+8u9ckMtHlE=;
	b=G3vrTVVC1of69IpxZZuPPqUi+P5WnXPwduI0eWjoclZyr0X+S5ZU9zgV7vvtFAop58koAq
	LfyPQ//gY1F+PcbHfwfZm6hHVP42zwuP25aDSm3ET9r5yv6/g/7I8euN2wnMxPw9XHThUG
	N3om5xZRRnKAN/q7UY9KsdLllkyPKpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-UHzJRoO2NxSdEjhQPdTCeg-1; Fri, 22 Sep 2023 20:46:52 -0400
X-MC-Unique: UHzJRoO2NxSdEjhQPdTCeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CC3185A5BA;
	Sat, 23 Sep 2023 00:46:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DB10928FB;
	Sat, 23 Sep 2023 00:46:50 +0000 (UTC)
Date: Sat, 23 Sep 2023 08:46:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Message-ID: <ZQ41d5majBepW48Z@MiWiFi-R3L-srv>
References: <20230922175224.work.712-kees@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230922175224.work.712-kees@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_174702_475768_FDB93CF0 
X-CRM114-Status: GOOD (  18.55  )
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

On 09/22/23 at 10:52am, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct crash_mem.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/crash_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 3426f6eef60b..5126a4fecb44 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -131,7 +131,7 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
>  struct crash_mem {
>  	unsigned int max_nr_ranges;
>  	unsigned int nr_ranges;
> -	struct range ranges[];
> +	struct range ranges[] __counted_by(max_nr_ranges);

This __counted_by() only makes sense when there's a obvious upper
boundary, max_nr_ranges in this case. This heavily depends and isn't
much in kernel? E.g struct swap_info_struct->avail_lists[]. Just
curious, not related to this patch though.

>  };
>  
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

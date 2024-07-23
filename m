Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BBEC3DA49
	for <kexec@archiver.kernel.org>; Tue, 23 Jul 2024 05:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=belru9WIY8NGodk4edVkAyLxLctjvVval8mrc4KMl1M=; b=qSBScgY9dzcJLz
	+QOW1utY7JM2bT9nRNyqmRek5QofCoFtKpPu1tOqzSyCdmtcNwERJ2YZGx14V48FSZL0HiiMklolj
	vyvQNoPAlRgQiNH0yZwIPHWwCsjgszUxRTCLT5J9FgI1hMGs04KX8IcsxEp8ALRBVaEKEhqT7it0t
	q9ZXfXuv9K7u223BDEsKd5aZOLYOp1xOQaJwsJPRKws0KKVneI/RoJCrFEUPdVvQtcyP6UGaCDsFJ
	0e/ppDo01CvUGFSj/HYowC2MddOt1uh28ZVTgCT8G0BgEMtEWGJ3w3So0TQlI2ILjDH8lbJydBZ2H
	PqcgLEpwH0cJSAOatqaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW7us-0000000BMz6-3dmL;
	Tue, 23 Jul 2024 05:18:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW7uU-0000000BMua-3Ghv
	for kexec@lists.infradead.org;
	Tue, 23 Jul 2024 05:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721711879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wjPrxZzwd6kroJlcjWmsZZtN0tFwF+CbZxsLDbkBNxc=;
	b=UwVRbWHvEHDMUwJNNgo7sSmt0U+7I0eaop8D6VCiTZzUxThuukpuPjq/mYnz0z0Ts6e8yk
	HCGjubsJxrgHREZnTy+/TaNyJga3sFCQw+mj45V08dbocvQl1fJMcByH1YU0UkDGNCRYBE
	6ulR49vIbf+qZbYgSic84OjtVk4jbBM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-E4vIq6S1NYCY2eEmzso2mw-1; Tue,
 23 Jul 2024 01:17:54 -0400
X-MC-Unique: E4vIq6S1NYCY2eEmzso2mw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC39A1955D55;
	Tue, 23 Jul 2024 05:17:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.85])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CA7230001A0;
	Tue, 23 Jul 2024 05:17:31 +0000 (UTC)
Date: Tue, 23 Jul 2024 13:17:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, rppt@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] crash: Fix crash memory reserve exceed system memory
 bug
Message-ID: <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
References: <20240723020746.3945016-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723020746.3945016-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_221802_898192_99104223 
X-CRM114-Status: GOOD (  23.64  )
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

On 07/23/24 at 10:07am, Jinjie Ruan wrote:
> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
> as below:
> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
> 
> It's similar on other architectures, such as ARM32 and RISCV32.
> 
> The cause is that the crash_size is parsed and printed with "unsigned long
> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> which is 4 bytes in memblock_phys_alloc_range().
> 
> Fix it by checking if crash_size is greater than system RAM size and
> return error if so.
> 
> After this patch, there is no above confusing reserve success info.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Baoquan He <bhe@redhat.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>


My Suggested-by can be taken off because I suggested to check the parsed
value after parse_crashkernel(), Mike's suggestion is better.

For this version,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
> v5:
> - Fix it in common parse_crashkernel() instead of per-arch.
> - Add suggested-by.
> 
> v4:
> - Update the warn info to align with parse_crashkernel_mem().
> - Rebased on the "ARM: Use generic interface to simplify crashkernel
>   reservation" patch.
> - Also fix for riscv32.
> - Update the commit message.
> 
> v3:
> - Handle the check in reserve_crashkernel() Baoquan suggested.
> - Split x86_32 and arm32.
> - Add Suggested-by.
> - Drop the wrong fix tag.
> 
> v2:
> - Also fix for x86_32.
> - Update the fix method.
> - Peel off the other two patches.
> - Update the commit message.
> ---
>  kernel/crash_reserve.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index ad5b3f2c5487..5387269114f6 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -335,6 +335,9 @@ int __init parse_crashkernel(char *cmdline,
>  	if (!*crash_size)
>  		ret = -EINVAL;
>  
> +	if (*crash_size >= system_ram)
> +		ret = -EINVAL;
> +
>  	return ret;
>  }
>  
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

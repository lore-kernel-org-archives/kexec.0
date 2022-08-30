Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15CEECAAA1
	for <kexec@archiver.kernel.org>; Tue, 30 Aug 2022 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S36VEmF0Bu4p8aIfYxWFm2MvrhxqU0n/+dSgJlLS6+I=; b=kEXeNVNqvwLufr
	1UNLnPoUUoywXuJP3EVuMLgwzO4VuNmqWyw2Yv4ElZEmR0s3ln/wmFQbwZEeqKU2qtAfau4wLbvKr
	GQ/gul84TxanKK/6T6yCM5lhPaLxY1axf/o20/lQd+pxlxA5zg0akyYSd075ShXmRfK1ubyTUw+ma
	4+t1f1O8fqYzhg4xRXW6QNKIxigAJ/zQ2G/p2oeKuoHXhFj5br10ewlV8vV+4OQBf9s8q7h1HWhwh
	MItNnsGPFJUqOIZ2sr9CHriZ5k5rJ10jEQdMZKctlBoLKu5VXKAdCOWaM4eqfdjvdMFDFU5wwyFIC
	RbnchKkD1mxTma1CUymQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0e9-00GvUE-Th; Tue, 30 Aug 2022 12:47:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0dx-00GvJW-T8
	for kexec@lists.infradead.org; Tue, 30 Aug 2022 12:47:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661863621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UT54XJrekXL8c4mrX4vwvSpge6ZFyCM6o46RKlXL6s=;
	b=I0ZAWavqYpe+2dTsoxhw83Ca5seSoT3tyD1E9H8O5x1AJh3fvVcdCJmh98P9cv1YWqM8t+
	fKMXdezzjCIgncy4wn40kR5qvo5sp6fDsMCtj/SO0VoHXoH0z6h+9JwQF+ZzHiI/Sp/YUo
	fHyTKNoZjyLs8mwbhrKh6bYS1NbBy7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-XHXWHpWOP---uR8szXvu5Q-1; Tue, 30 Aug 2022 08:46:58 -0400
X-MC-Unique: XHXWHpWOP---uR8szXvu5Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EFE3185A7BA;
	Tue, 30 Aug 2022 12:46:57 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 431FB492C3B;
	Tue, 30 Aug 2022 12:46:55 +0000 (UTC)
Date: Tue, 30 Aug 2022 20:46:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Levi Yun <ppbuk5246@gmail.com>
Cc: will@kernel.org, catalin.marinas@arm.com, nramas@linux.microsoft.com,
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw4GvOh3UnnfTbbE@MiWiFi-R3L-srv>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220830092839.3197-1-ppbuk5246@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_054702_036072_A3F0028F 
X-CRM114-Status: GOOD (  16.01  )
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

On 08/30/22 at 06:28pm, Levi Yun wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem range slot in case of crashk_low_res is used.
                                             ~~^ should be removed.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 889951291cc0..a11a6e14ba89 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	u64 i;
>  	phys_addr_t start, end;
>  
> -	nr_ranges = 1; /* for exclusion of crashkernel region */
> +	nr_ranges = 2; /* for exclusion of crashkernel region */
>  	for_each_mem_range(i, &start, &end)
>  		nr_ranges++;
>  
> -- 
> 2.35.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

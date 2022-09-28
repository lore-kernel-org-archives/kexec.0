Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1C7C32771
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 06:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C16/+1P5P8lIk/NM2KlKUSBQvMnBs8LpI4aM9I8RwuU=; b=I1miiC010ofd1d
	KS+qffTkRkv2g6RUR4X8nFazAurMYukEsPOIRLDJIU2LJrlCPpex27qnn4BBEXoQZO/W6SU+hGs8j
	3Vd6c4Bix70A0F+FJYfrs7VImZSgdw96CXi8W1ZwTUT2nQjry/PjQ/QOngT57ghnwFvyADEXOcJod
	JrlHZ5AtWhAc8ZnbsR5+O7b6ydEQY/Khx62gCVPnfzZWG1xC2Pnaiu3TqS7tvK83l8n6Z/s3/jxMk
	Nt2fH0NQvQkEUODl+j/udKaJm/8zp9unSIY7T2wchleHXPClLDy7dlHQmKEkHE323HcNgCCLwXo3d
	hb+QYa89SADyDbg8uk7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQwQ-00ELwq-0E; Wed, 28 Sep 2022 06:53:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQw8-00ELos-Pz
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 06:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664347972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlaSZc33GONrE9IArKtEWlpurS3hEknJV/JTkyz5RZ0=;
	b=fMSi2p/Dxx1NLMA1zMoWp6v1pMcR0uJ3OttPFFrJ6ifrCOFab37ufz1BHJIaAy1x0vnHAn
	tIvjAc46BrmsNDfyVB5gkutgLmIUJ/kWjwVx2C3bZgrutqeAQlTiE7F3BTH11zgGNNyTvV
	cfLPOmvGC8CC/kh66Rb0pXlcP+JXzRw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-7yyPjbgSNVaEGE3qQ-_5FA-1; Wed, 28 Sep 2022 02:52:47 -0400
X-MC-Unique: 7yyPjbgSNVaEGE3qQ-_5FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C7FD185A79C;
	Wed, 28 Sep 2022 06:52:47 +0000 (UTC)
Received: from localhost (ovpn-13-211.pek2.redhat.com [10.72.13.211])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 772D5422A9;
	Wed, 28 Sep 2022 06:52:45 +0000 (UTC)
Date: Wed, 28 Sep 2022 14:52:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Chen Lifu <chenlifu@huawei.com>
Cc: linux@armlinux.org.uk, akpm@linux-foundation.org, pmladek@suse.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ARM: kexec: Make machine_crash_nonpanic_core()
 static
Message-ID: <YzPvOjGWHxdcGUjh@MiWiFi-R3L-srv>
References: <20220816074250.3991633-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220816074250.3991633-1-chenlifu@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_235252_925363_AC254CA9 
X-CRM114-Status: GOOD (  19.45  )
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

On 08/16/22 at 03:42pm, Chen Lifu wrote:
> This symbol is not used outside of the file, so mark it static.
> 
> Fixes the following warning:
> 
> arch/arm/kernel/machine_kexec.c:76:6: warning: symbol 'machine_crash_nonpanic_core' was not declared. Should it be static?
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/arm/kernel/machine_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index f567032a09c0..a2e9ac763a9f 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -71,11 +71,11 @@ int machine_kexec_prepare(struct kimage *image)
>  
>  void machine_kexec_cleanup(struct kimage *image)
>  {
>  }
>  
> -void machine_crash_nonpanic_core(void *unused)
> +static void machine_crash_nonpanic_core(void *unused)
>  {
>  	struct pt_regs regs;
>  
>  	crash_setup_regs(&regs, get_irq_regs());
>  	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has crashed\n",
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F34FC4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SoOmi3OoOv0jZZA1sqFhDMgUK3tQjC0W3qcoKf/wIg=; b=Yeeqa2FkM6xP2a
	rH3A53BaLZG/E+pXl6HRGeuvFkwInD/ahIFoK+OQ/9hingTDn/1/FdP2Wr2PV2+w2nlBKHAg/30Lb
	WFMiVUGWA9BRR4wUKvGDxxnOXHZD45qhO25/ywn4jAcV6KxZVhxzHMH8zmWNhh5k9nWNIknMozb/i
	eFCdutwOnVpvdXSnvY+gX59KrHgqtpy5l4HJvnRBDt2dPHlaaft7xSyW7oL+Qwbwi0wQc73bol5gU
	yb4UqgF4O9oJ+JDsxt2ucGWl1/ADumqe8/1WIuQ3ye5QCWng9Xmi6ud9kCXRtGT1N50EJCzGHjSxK
	OTtat49c8mjjcbBZvBCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Pn-003HCQ-2a;
	Mon, 04 Dec 2023 08:34:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Pj-003HAp-2r
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 08:34:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701678885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tcnzIexPrb0OUsvkaLGTMaO9LwJfJejgNnOdDmMeTA=;
	b=OG47XKa1BklctfdNYzS51Nxdrnl3EcPNK6ux3NuORWABTHGxsa66FBSNgBip5E3YaohOcO
	YEwM/ZFPZx7KlrjmwwoyIKjcn4CfkB2A2/Z5hlOpHMEr0PFyiH4E1BPwjTKfC9+9s32n03
	pn0Yh7ehm6BfrDM7iA5fAEE3t4F9DjY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-TP6E8WNAO9SqzRiAn5erpQ-1; Mon,
 04 Dec 2023 03:34:40 -0500
X-MC-Unique: TP6E8WNAO9SqzRiAn5erpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B4DD38476C0;
	Mon,  4 Dec 2023 08:34:40 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B38C1596F;
	Mon,  4 Dec 2023 08:34:38 +0000 (UTC)
Date: Mon, 4 Dec 2023 16:34:36 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
	akpm@linux-foundation.org, mick@ics.forth.gr, changbin.du@intel.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] riscv, kexec: fix the ifdeffery for
 AFLAGS_kexec_relocate.o
Message-ID: <ZW2PHF3HVUUH8+NV@MiWiFi-R3L-srv>
References: <20231201062538.27240-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231201062538.27240-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_003452_221080_73CAA1FD 
X-CRM114-Status: GOOD (  17.54  )
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

CC Andrew.

On 12/01/23 at 02:25pm, Baoquan He wrote:
> This was introduced in commit fba8a8674f68 ("RISC-V: Add kexec
> support").
> 
> It should work on CONFIG_KEXEC_CORE, but not CONFIG_KEXEC only, since
> we could set CONFIG_KEXEC_FILE=y and CONFIG_KEXEC=N, or only set
> CONFIG_CRASH_DUMP=y and disable both CONFIG_KEXEC and CONFIG_KEXEC_FILE.
> In these cases, the AFLAGS won't take effect with the current ifdeffery
> for AFLAGS_kexec_relocate.o.
> 
> So fix it now.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/riscv/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi RISC-V people,

I didn't test this, while believe this need be fixed. Please help check
if this is necessary.


Thanks
Baoquan
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fee22a3d1b53..82940b6a79a2 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -11,7 +11,7 @@ endif
>  CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
>  CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
>  
> -ifdef CONFIG_KEXEC
> +ifdef CONFIG_KEXEC_CORE
>  AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
>  endif
>  
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

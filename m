Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8136AC46CD2
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 04:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uNIibglfvPejuHarIZEgt2PI7MGAmvfwNwEx1s7dk8w=; b=Yjhl0Pt7OnxhK0
	8dp7whXTXqxiyeKnfpne6L41RywzI+vtFM1BhHy0c/t3Gyh34Psi7E8LvGhyAZqsHG44dkC84LMdw
	/zx7iNbvtWhZuqmP7kne00uq+Pj6q/srHX8VumLBmUOUXbVSxB+ScYTTNGtoOB9h3K6pZOKqai5Ep
	ZiHTf+6SO6Hw4qEMFkPqUp6H3sDuvsgWBlIGWPNTyiU9jEqfRYyA7O0f7IXHwR7BPr7Qf9ePLie30
	AvfarS94Wkf5ueDPrDtLsN+0W0D+kfcX43yFRREGdDXJPS5p4qzOSD9RU9XB3Rh4RY65p8tIEZDyA
	buiu1d3T15rtBZkfYBxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRcv-00Clhd-2C;
	Tue, 19 Dec 2023 04:22:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRcs-00ClgN-1n
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 04:22:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702959755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Igax5UgIuAw00YDf5GDEbl6lhbS7QUhnxvUBz1O2KrM=;
	b=crb4vRK1oo+D7sdeq3GwMxASsazWxUjk8etNRIL8jaums7Gw36w1Db9UMk6UleaFx/YVE3
	6yh1jjyXmiRoo6BOLjQ2PDJB7NQv1D2uE39CTjP5c8ZXSSVAff1SQYRZzAXtoVLAh9PL7C
	bQDWzb9WOX8JNQMT9tV2/z72Sv6/8Gc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-GwesIK5LNZ-Romlg7SDN4A-1; Mon,
 18 Dec 2023 23:22:29 -0500
X-MC-Unique: GwesIK5LNZ-Romlg7SDN4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BB573813F22;
	Tue, 19 Dec 2023 04:22:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F16F6492BF0;
	Tue, 19 Dec 2023 04:22:26 +0000 (UTC)
Date: Tue, 19 Dec 2023 12:22:22 +0800
From: Baoquan He <bhe@redhat.com>
To: James Gowans <jgowans@amazon.com>, akpm@linux-foundation.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Sean Christopherson <seanjc@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Pavel Machek <pavel@ucw.cz>,
	Sebastian Reichel <sre@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>, Alexander Graf <graf@amazon.de>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Message-ID: <ZYEafpms++a3a8ch@MiWiFi-R3L-srv>
References: <20231213064004.2419447-1-jgowans@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213064004.2419447-1-jgowans@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_202238_680869_C85047D6 
X-CRM114-Status: GOOD (  20.80  )
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

Add Andrew to CC as Andrew helps to pick kexec/kdump patches.

On 12/13/23 at 08:40am, James Gowans wrote:
......
> This has been tested by doing a kexec on x86_64 and aarch64.

Hi James,

Thanks for this great patch. My colleagues have opened bug in rhel to
track this and try to veryfy this patch. However, they can't reproduce
the issue this patch is fixing. Could you tell more about where and how
to reproduce so that we can be aware of it better? Thanks in advance.

Thanks
Baoquan

> 
> Fixes: 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
> 
> Signed-off-by: James Gowans <jgowans@amazon.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Alexander Graf <graf@amazon.de>
> Cc: Jan H. Schoenherr <jschoenh@amazon.de>
> ---
>  kernel/kexec_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..b926c4db8a91 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1254,6 +1254,7 @@ int kernel_kexec(void)
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
> +		syscore_shutdown();
>  
>  		/*
>  		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> -- 
> 2.34.1
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

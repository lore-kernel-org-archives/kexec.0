Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0A4C27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=15TJM+V4Z1DsjLOU3MJ1flkbBGfmLmnRtkCPwutxnQk=; b=147Whz//A3PvTQ
	bBNRi3g/qABRfIC54MW6po6TL5mg9bWxaSxaS4TRlXwarA3SroZGUEBz9hWWUewQGu6hUS0PQ0Pal
	Fbw6CzsFRETEwv1SB5IY2sfvCneF4LQbJWv9YltBocJfZjCQ/PV/zyoWmHl3o/QhwbbV4Bbg5u63r
	QNjLFidE4AswW3Y68hNRmuKbMFCwiGpFWZnOVlWfNnY6l0X5AUxImYpvoufqCrHxcmd5g4Ho5/w/4
	Yi8qfk7QKttQ1w/5N6QvtWB0DkfojGWc6tAsySwp9b8eJQXChr21eJVM81Cvv1rsL8BjoHA7WLO8S
	qujYQpdOvppixyfIoMMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWPF-0000000DQuW-2pmf;
	Fri, 07 Jun 2024 10:01:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWP7-0000000DQoZ-3QbL
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 10:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NH3oO20QFn673bgiV5dG3f+GU8g8vUS9TOFN0xj1Yvs=;
	b=bRLoT1epfTuBvnDWSQoZBokCtogXBSnWjLeP2zZvu21lJdMqGSOo4b09PMYjhKC/dCqR41
	ri07PEfxT2v/qNh2EDNoFbQBUWeq6YnqFiEfjWlVzAcGM7cyqx9or9S/NwDzXv+U3iUd3v
	UbzAM0uZgl0YTPMQYat0Ki1pClyDt4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-xgL2DSfJMR-vi7a64Cs1NA-1; Fri,
 07 Jun 2024 06:00:54 -0400
X-MC-Unique: xgL2DSfJMR-vi7a64Cs1NA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C312F1955F34;
	Fri,  7 Jun 2024 10:00:51 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B87A41956089;
	Fri,  7 Jun 2024 10:00:49 +0000 (UTC)
Date: Fri, 7 Jun 2024 18:00:44 +0800
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 7/7] x86/crash: make the page that stores the dm crypt
 keys inaccessible
Message-ID: <ZmLaTJA6Vq1a9x5z@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-8-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-8-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_030102_357443_A98AACBD 
X-CRM114-Status: GOOD (  17.99  )
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

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> This adds an addition layer of protection for the saved copy of dm
> crypt key. Trying to access the saved copy will cause page fault.
> 
> Suggested-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index b180d8e497c3..fc0a80f4254e 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -545,13 +545,34 @@ static void kexec_mark_crashkres(bool protect)
>  	kexec_mark_range(control, crashk_res.end, protect);
>  }
>  
> +static void kexec_mark_dm_crypt_keys(bool protect)
> +{
> +	unsigned long start_paddr, end_paddr;
> +	unsigned int nr_pages;
> +
> +	if (kexec_crash_image->dm_crypt_keys_addr) {
> +		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
> +		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
> +		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
> +		if (protect)
> +			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
> +		else
> +			__set_memory_prot(
> +				(unsigned long)phys_to_virt(start_paddr),
> +				nr_pages,
> +				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
> +	}
> +}
> +
>  void arch_kexec_protect_crashkres(void)
>  {
>  	kexec_mark_crashkres(true);
> +	kexec_mark_dm_crypt_keys(true);

Isn't crashkernel region covering crypt keys' storing region? Do we need
mark it again specifically? Not sure if I miss anything.

>  }
>  
>  void arch_kexec_unprotect_crashkres(void)
>  {
> +	kexec_mark_dm_crypt_keys(false);
>  	kexec_mark_crashkres(false);
>  }
>  #endif
> -- 
> 2.45.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D202CC27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=29ODNxLXISP0Q0Zaq4MFVx8mXg2J7QqdfcrQN3YktvM=; b=SE9D4LkKhOm7bB
	GD404WADHr/Kx4BQKiWgZoOubLT3J4eh9dd98H7HvZ8wSVG/rUuTdmb4b2b3Dgh0r3jd9kOchWTxt
	5GX4cNOt+R+IAV27s2HO5S/f9BHY1lsPuHwDcF6wzxYqESRPDyDmZTTsck3jcZ3hCCZKRdEcjg4Ig
	xfsSpTL9QD3gUPb+ED2iJ611/+PWBh6FpQyVSAh4Xo3mV9dd75tS6fOzpXtVUkvg8FswQKTMDg+SG
	4cB0xuzE4rquy6J+qbeGy3SVsxzSjzQpEveo7i0A3dCxcWRFH/wVFwWQZGRXRDfz5eC6k18/llRe6
	2kvPWHnNf2q4q/lO/8/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWMS-0000000DPo4-1jnc;
	Fri, 07 Jun 2024 09:58:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWMQ-0000000DPnS-1BHF
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 09:58:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYY4ZJyi1ZBeDq5DjfhbsKQZnYv0J07Ec85K0cG2tqA=;
	b=M8TAaFji78o/Qm5na9uJMeRXadLmFUSOmPOk059k6+RaPx+RLJ38mEqSHADzShoHI8abfM
	qPZI3GelAHxQXDng8WAfRNvyd7sDUksKZpywZR6EzbnF4LJq7zCE2+znx/2/BX044Or8kU
	TF8dnD6prUV7dFrtJ93iI01XPPdiGPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-ietjylPLPgGuBOoONC0jvQ-1; Fri,
 07 Jun 2024 05:57:58 -0400
X-MC-Unique: ietjylPLPgGuBOoONC0jvQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C10A1955E7F;
	Fri,  7 Jun 2024 09:57:56 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F42E19560AB;
	Fri,  7 Jun 2024 09:57:48 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:57:38 +0800
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
Subject: Re: [PATCH v4 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <ZmLZkvYRJvdRVqwr@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-7-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-7-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_025814_429510_0040AABF 
X-CRM114-Status: GOOD (  18.97  )
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
> 1st kernel will build up the kernel command parameter dmcryptkeys as
> similar to elfcorehdr to pass the memory address of the stored info of
> dm crypt key to kdump kernel.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/crash.c           | 15 ++++++++++++++-
>  arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index f06501445cd9..74b3844ae53c 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  				 unsigned long long mend)
>  {
>  	unsigned long start, end;
> +	int r;
            ~?

r is only to contain the returned value? Then you can call it ret as
many do in kernel code.

>  
>  	cmem->ranges[0].start = mstart;
>  	cmem->ranges[0].end = mend;
> @@ -274,7 +275,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  	/* Exclude elf header region */
>  	start = image->elf_load_addr;
>  	end = start + image->elf_headers_sz - 1;
> -	return crash_exclude_mem_range(cmem, start, end);
> +	r = crash_exclude_mem_range(cmem, start, end);
> +
> +	if (r)
> +		return r;
> +
> +	/* Exclude dm crypt keys region */
> +	if (image->dm_crypt_keys_addr) {
> +		start = image->dm_crypt_keys_addr;
> +		end = start + image->dm_crypt_keys_sz - 1;
> +		return crash_exclude_mem_range(cmem, start, end);
> +	}

You need adjust the array length of cmem->ranges[], I believe you will
cause the array overflow because the keys are randomly set and mostly
will be in the middle of crashkernel region.

> +
> +	return r;
>  }
>  
>  /* Prepare memory map for crash dump kernel */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

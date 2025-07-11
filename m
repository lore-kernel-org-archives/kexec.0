Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E9AC8303C
	for <kexec@archiver.kernel.org>; Fri, 11 Jul 2025 06:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9G+ZmLUkUIQU/PXNQ1CgccQAS24d13cPf68AHxjj7PY=; b=BwLxbNh0wvhsOqUZQ7PgQ8rEnQ
	sFikQyN3bZfv4HPqjAqP3qCCudv+uHsbXVkeYasiIGUH5Chh0DhGdL4Zxn6A7X0pXiNMHM5EzrBK4
	4kIhb2bOrEuCqnnJk5BblrludBU7Ngextsbw3jXY7SYHhqA+clXGp4l+agelCRURh2jZm+zWSqC+l
	ATkNvmJMB6opMdJFZV88RqyPDkIRiLFI4zBI5yGl0fdxgUWim5oUtsOs3OTPSfqndRuP2FDhfoG73
	ufCkF+nYyH272GawlLPK8Q3G+Fu1BTn5jGici/k4sNkOr5CRk+lpfMQrwx2AIsr39223DpupcMnC/
	7Te7XMOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua75E-0000000Dpqr-3Fos;
	Fri, 11 Jul 2025 06:18:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua75C-0000000Dppq-2yVG
	for kexec@lists.infradead.org;
	Fri, 11 Jul 2025 06:18:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752214685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9G+ZmLUkUIQU/PXNQ1CgccQAS24d13cPf68AHxjj7PY=;
	b=I7lcEwC4ccpQSkKJyDNxb1eilCiNKxmhEX5pw78iFbsn4hBYu8E7+y6pZEgRkKDnAnG4xH
	dGuELX9Gms3PAiMk8gVAbx0ELRAGBikpkBJgKrkWdkhrUGQzTHJ+DoFakwlnWvnMGXj+Ug
	EA13PvJOmlVhdN+faqVkZ8EbFtVUt3M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-5GExp0KkMX6CZNK4_rjbCA-1; Fri,
 11 Jul 2025 02:18:02 -0400
X-MC-Unique: 5GExp0KkMX6CZNK4_rjbCA-1
X-Mimecast-MFC-AGG-ID: 5GExp0KkMX6CZNK4_rjbCA_1752214681
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDD74195608E;
	Fri, 11 Jul 2025 06:18:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.59])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C7781956094;
	Fri, 11 Jul 2025 06:17:58 +0000 (UTC)
Date: Fri, 11 Jul 2025 14:17:55 +0800
From: Baoquan He <bhe@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v1 2/2] kexec_core: Drop redundant pm_restore_gfp_mask()
 call
Message-ID: <aHCskzYNOG5WNltA@MiWiFi-R3L-srv>
References: <5046396.31r3eYUQgx@rjwysocki.net>
 <1949230.tdWV9SEqCh@rjwysocki.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1949230.tdWV9SEqCh@rjwysocki.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_231806_822377_24B86262 
X-CRM114-Status: GOOD (  12.78  )
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

On 07/10/25 at 03:12pm, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop the direct pm_restore_gfp_mask() call from the KEXEC_JUMP flow in
> kernel_kexec() because it is redundant.  Namely, dpm_resume_end()
> called beforehand in the same code path invokes that function and
> it is sufficient to invoke it once.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/kexec_core.c |    1 -
>  1 file changed, 1 deletion(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1136,7 +1136,6 @@
>   Resume_devices:
>  		dpm_resume_end(PMSG_RESTORE);
>   Resume_console:
> -		pm_restore_gfp_mask();
>  		console_resume_all();
>  		thaw_processes();
>   Restore_console:
> 
> 
> 



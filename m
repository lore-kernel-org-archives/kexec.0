Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53743C30653
	for <kexec@archiver.kernel.org>; Wed,  3 Jul 2024 05:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=taX2PwnyWHnmtjqdFKuXs8jq/UJ9unfNTRqKXjESmwg=; b=0UzadmYH5wSSuO
	4Z9Q1xUqCeoLaj29x1N5IwOiubf5KIfluOk+3T7msEfz5IQR+T5IcvIy8qUrn9lVWbMsigzlZfzho
	dsFLhxrtaHHM6DebxNusTH6OCSKHOR3l6EwES4hTfLyzYlxXgyEdyaLUP5LS3ufCYWjw3sfQ7Xru/
	ij+UtNT4JHKKSFyA4phDlPRSfZ723xxZtiNCfuALiU3vlLbkWXL4lvuEdsVrS4/C2QHHs+IjSO9eF
	XQcpPeFNdWxAndLE1qkPeEZp5fdIwWbvC8ZVtqIQNHbXGRMndNg5tct2yPmt0U3MNaZ4gz5Qemjfn
	X3IIVq/Seu1xgIawRhfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsZq-000000093UI-2oI2;
	Wed, 03 Jul 2024 05:30:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsZn-000000093T3-3H89
	for kexec@lists.infradead.org;
	Wed, 03 Jul 2024 05:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719984642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CHwBnfWTzxsEWauSUtgh/TAfVfTPk1rrpes49CGNvnY=;
	b=J/9a8ihcWON0/uKRoTh5+Ru4YUX1fsR73Zxfhft69xVYv8JWMGQcQw0RGUEnMJRFwEvT4i
	7YSTQ92Y9N4GFh7thkugsRi96qunDf3wXyq1wbj8wV/gsS2aBagCnnBnkDHjUlSmby/KGU
	7oLUHjUMGxkLp3J+jvbm5lFqzYxeDuA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-FWjXFWk2NL2QDY1zvGo1Lw-1; Wed,
 03 Jul 2024 01:30:38 -0400
X-MC-Unique: FWjXFWk2NL2QDY1zvGo1Lw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA3F119560B1;
	Wed,  3 Jul 2024 05:30:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0B8C1954201;
	Wed,  3 Jul 2024 05:30:34 +0000 (UTC)
Date: Wed, 3 Jul 2024 13:30:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] doc/hotplug: update man and --help
Message-ID: <ZoTh9E8BJt+E3ctg@MiWiFi-R3L-srv>
References: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
 <20240702043057.200211-3-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240702043057.200211-3-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_223043_916693_CEBA35EB 
X-CRM114-Status: GOOD (  19.41  )
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

On 07/02/24 at 10:00am, Sourabh Jain wrote:
> Update the man page and --help option to make the description of the
> --hotplug option easier to understand.
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Simon Horman <horms@kernel.org>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
> 
> From v2 -> v3
>   - Updated --hotplug option description
> 
> ---
>  kexec/kexec.8 | 8 ++++----
>  kexec/kexec.c | 4 +++-
>  2 files changed, 7 insertions(+), 5 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index 9e995fe..793e876 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -140,10 +140,10 @@ Open a help file for
>  .BR kexec .
>  .TP
>  .B \-\-hotplug
> -Setup for kernel modification of the elfcorehdr. This option performs
> -the steps needed to support kernel updates to the elfcorehdr in the
> -presence of hot un/plug and/or on/offline events. This option only
> -useful for KEXEC_LOAD syscall.
> +Setup kexec segments such that kernel can safely update them on CPU/Memory
> +hot add/remove events. If this option is enabled, kernel does in-kernel
> +update of kexec segments on CPU/Memory hot add/remove events, thus avoiding
> +the need to reload kdump kernel.
>  .TP
>  .B \-i\ (\-\-no-checks)
>  Fast reboot, no memory integrity checks.
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 034cea6..9b7c34c 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1093,7 +1093,9 @@ void usage(void)
>  	       "                      back to the compatibility syscall when file based\n"
>  	       "                      syscall is not supported or the kernel did not\n"
>  	       "                      understand the image (default)\n"
> -	       " --hotplug            Setup for kernel modification of elfcorehdr.\n"
> +	       " --hotplug            Do in-kernel update of kexec segments on CPU/Memory\n"
> +	       "                      hot add/remove events, avoiding the need to reload\n"
> +	       "                      kdump kernel on online/offline events.\n"
>  	       " -d, --debug          Enable debugging to help spot a failure.\n"
>  	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
>  	       "                      0 if not.\n"
> -- 
> 2.45.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

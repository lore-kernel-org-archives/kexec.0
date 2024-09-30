Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB6FCF6499
	for <kexec@archiver.kernel.org>; Mon, 30 Sep 2024 03:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1dxRNP7WOW2cKcr/Jr5EzXVtpCRaZkLqpD91sxUdhFk=; b=zyiJuLFaA3yuqg
	R4XgwDfXU7bz7U6x5Hqd4w268x/Hf4DITCslK+uBxZmhVjl8FL1i4MWm0FMJzbKBfETSX9vnishmB
	HaqXHg290iij82wq1THqQ+oP9IXdapsmkaLRw2Pm+CqOuToFwG3Ziri3NIisewODsWsom9WTSRqfG
	1+l85wlMnq1ji09yWp3LodLK6/HXLgWL9PLUjK9xhyu0p0y3fL6g/7d0H1HtOViQFfDAajphcE2uZ
	g5XiB8KB7fsUN6bRpDSLNVLc4k71LJ9DHG2zo2lisVl5mkszOMVrkdyOsFTqyHCyOiIkxP/gwCUzh
	PLivgeq1+ZRKQkZAmBpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sv6ei-0000000FmDF-3Gcp;
	Mon, 30 Sep 2024 03:01:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sv6eg-0000000FmCe-0UJK
	for kexec@lists.infradead.org;
	Mon, 30 Sep 2024 03:01:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727665257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZM5NdSEWWxV+d7/NgptFaq3MVMQUll/nVFG6CmLrnI=;
	b=Upqjnu5OUi4ZMKyihNcMhbKJ1ZQQshXfgp6QhOfgfqetH71xWaDNCjUA8yNpmuy76efamn
	YFlyfAnTJaMOJoaLp6+dWZ8Gg8KZ1dq7/wKpo0e8a8O3OE/cvmqM4jUsINZPDE63mjirPD
	4dDhOOyMOdN0FMEAZxNTQ91ZkBcemeM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-zSa0gl6AMSaSWEkIjUVrkg-1; Sun,
 29 Sep 2024 23:00:54 -0400
X-MC-Unique: zSa0gl6AMSaSWEkIjUVrkg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFDFB19030A8;
	Mon, 30 Sep 2024 03:00:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F161D19541A2;
	Mon, 30 Sep 2024 03:00:50 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:00:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
Message-ID: <ZvoUXjWmojyNs6dx@MiWiFi-R3L-srv>
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240929_200058_597520_147AD6C5 
X-CRM114-Status: GOOD (  17.95  )
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

On 09/14/24 at 07:20pm, Dave Young wrote:
> The setup_data ranges are not reserved for kexec any more after
> commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table
> for setup_data"), so update the code comment here.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/e820.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-x86/arch/x86/kernel/e820.c
> ===================================================================
> --- linux-x86.orig/arch/x86/kernel/e820.c	2024-09-14 10:39:57.423551301 +0800
> +++ linux-x86/arch/x86/kernel/e820.c	2024-09-14 18:56:30.158316496 +0800
> @@ -36,10 +36,8 @@
>   *
>   * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
>   *   passed to us by the bootloader - the major difference between
> - *   e820_table_firmware[] and this one is that, the latter marks the setup_data
> - *   list created by the EFI boot stub as reserved, so that kexec can reuse the
> - *   setup_data information in the second kernel. Besides, e820_table_kexec[]
> - *   might also be modified by the kexec itself to fake a mptable.
> + *   e820_table_firmware[] and this one is that e820_table_kexec[]
> + *   might be modified by the kexec itself to fake a mptable.
>   *   We use this to:

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

>   *
>   *       - kexec, which is a bootloader in disguise, uses the original E820
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

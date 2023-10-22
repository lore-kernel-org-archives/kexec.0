Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA01CDB474
	for <kexec@archiver.kernel.org>; Sun, 22 Oct 2023 23:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tl/ZRnyJloMkUVIJjPeeaoqko4U2e9ExHfzsbbNGmnw=; b=ezd4WcglqwRVFz
	z1x6PBtUb5R1aVer0/OKUZPV/wEb4OUC1u6OiBp6/v3oGxdcX3WFbgnE4eJTOicz9jfcCgXcV/T9v
	OyoFLyRg1J8/zl8l39zdwxE8eCbg0GxaQnbIYaHhffTd+19EWoLIy5Kbvv8Ny0dmPP6Cme96oj5j6
	UePzNsj5a9Qsq4UNNlVeRIkoh2fzrktxkXGJE3Vf7gs7Gl6Ovnlc7BFWzE9e8eR5fZhujmX7G+0Mw
	Br4HvsNfc3aSkcnlY44AzkIlXb94p7zJeOaktn/BatJjrqoSqMnRJ+bztMG73WqhZ/NQmuD1qtEso
	fbAsxa5FL17uQ+TS+xWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quhib-0062LL-30;
	Sun, 22 Oct 2023 23:18:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quhiV-0062Ka-1d
	for kexec@lists.infradead.org;
	Sun, 22 Oct 2023 23:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698016719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jX1G92KJ9HaLCLXW5bUq4SsuwL/Pf25kDHN6JaMRMeE=;
	b=OiXtuHi4qV/bMRWG6qvG3e77Ful0PmMr52fl7XcwZVJBHDujv9LZxSp2Kcob6snyC/oi7P
	kDRupEoQVQ+DIFYuvM9/phW1ovc8t55fNreT6M/zsCgTYBPvwEEObtMW4+ub07VAPKaobG
	394NKLcR/6ASWIupQVcgA4E9FXxhd3o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-4n3qW8V3Pkmn-zUTc4khOg-1; Sun, 22 Oct 2023 19:18:35 -0400
X-MC-Unique: 4n3qW8V3Pkmn-zUTc4khOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BB0529AA2EF;
	Sun, 22 Oct 2023 23:18:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 343C3503B;
	Sun, 22 Oct 2023 23:18:33 +0000 (UTC)
Date: Mon, 23 Oct 2023 07:18:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] kdump: fix reference to nonexistent file
Message-ID: <ZTWtxzSojtHMwrHu@MiWiFi-R3L-srv>
References: <20231022190424.919982-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231022190424.919982-1-vegard.nossum@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231022_161843_666975_9564CEB3 
X-CRM114-Status: GOOD (  15.51  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 10/22/23 at 09:04pm, Vegard Nossum wrote:
> All the s390 docs were moved from Documentation/s390/ to
> Documentation/arch/s390/ but this reference didn't get updated. Fix it.
> =

> Fixes: 37002bc6b603 ("docs: move s390 under arch")
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Costa Shulyupin <costa.shul@redhat.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  kernel/Kconfig.kexec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> =

> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 9bfe68fe9676..7aff28ded2f4 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -110,7 +110,7 @@ config CRASH_DUMP
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  =

>  	  For s390, this option also enables zfcpdump.
> -	  See also <file:Documentation/s390/zfcpdump.rst>
> +	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>  =

>  config CRASH_HOTPLUG
>  	bool "Update the crash elfcorehdr on system configuration changes"
> -- =

> 2.34.1
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18AD58E4B
	for <kexec@archiver.kernel.org>; Mon,  2 Mar 2026 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=805Lu3EMapzlzEnavOwixZrJ0Hw2CqNoGnLSexCdNJg=; b=KfS8z5XLVOKLzm5+3K/gr9lGvl
	hY2lxEtCRTlFMBVu86Hq1R5L0K2Q0pBg2oVD7pidWIk8oUpzLXWyX8vu8xx0+bE02V/rU8BoJ8j1h
	h0o0l4/iz8M7W1dyl/DCU8Wn8Xt+/kDGP39pH34QFKUYEFGM1fnfGxs0eEFqLklqMqrU2uby9toiP
	teTFCrCYyA+kVrhjO3Op7kdBMEPKx0QQUujLSpShi2o/7ngbptyOEAunl6swEDWDcN6GLKIqtROw1
	JrPNygyjJRtzpoF6x/lQ2bkp0oyInQkOEAO/KhBf4MCTNgkrGaHgO9oFtNUF90H1tyHPhggQ8pNyU
	CgaqspJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtsG-0000000CArv-41Gk;
	Mon, 02 Mar 2026 03:23:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtsC-0000000CArO-2cJY
	for kexec@lists.infradead.org;
	Mon, 02 Mar 2026 03:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772421786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=805Lu3EMapzlzEnavOwixZrJ0Hw2CqNoGnLSexCdNJg=;
	b=C638m43QKy0OJukXI5RchLQJDBSs801FCCBeyTv6btUxbhIIEsgV6qkz4lmflazax31FYB
	KyYEeVIeLF2/nB1Kkum3sIhmIk9qTx5DTrTDWFMvayNa7JVSNOk1YPpSFXuO0+yG3L4oro
	X/j5CH3oZ8jxHp36wfMdXTsc0NdC+cI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-ZKMInV-7Ov60vBkvpA8OSQ-1; Sun,
 01 Mar 2026 22:23:05 -0500
X-MC-Unique: ZKMInV-7Ov60vBkvpA8OSQ-1
X-Mimecast-MFC-AGG-ID: ZKMInV-7Ov60vBkvpA8OSQ_1772421784
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E453D195608E;
	Mon,  2 Mar 2026 03:23:03 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA6A130001BB;
	Mon,  2 Mar 2026 03:23:02 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:22:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: use sysfs_emit in sysfs show functions
Message-ID: <aaUCkp7ndYDYHJd0@MiWiFi-R3L-srv>
References: <20260301125106.911980-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260301125106.911980-2-thorsten.blum@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ySmk6txRyVMNlhxcwCg6wm09NPZZ0RsU2Iq4W_csbJs_1772421784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_192308_752688_2A3CFF93 
X-CRM114-Status: GOOD (  13.62  )
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

On 03/01/26 at 01:51pm, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in sysfs show functions.
> sysfs_emit() is preferred for formatting sysfs output because it
> provides safer bounds checking.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/crash_dump_dm_crypt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 1f4067fbdb94..827572aa800b 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -6,6 +6,7 @@
>  #include <linux/cc_platform.h>
>  #include <linux/configfs.h>
>  #include <linux/module.h>
> +#include <linux/sysfs.h>
>  
>  #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
>  #define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
> @@ -189,7 +190,7 @@ static inline struct config_key *to_config_key(struct config_item *item)
>  
>  static ssize_t config_key_description_show(struct config_item *item, char *page)
>  {
> -	return sprintf(page, "%s\n", to_config_key(item)->description);
> +	return sysfs_emit(page, "%s\n", to_config_key(item)->description);
>  }
>  
>  static ssize_t config_key_description_store(struct config_item *item,
> @@ -265,7 +266,7 @@ static struct config_item *config_keys_make_item(struct config_group *group,
>  
>  static ssize_t config_keys_count_show(struct config_item *item, char *page)
>  {
> -	return sprintf(page, "%d\n", key_count);
> +	return sysfs_emit(page, "%d\n", key_count);
>  }
>  
>  CONFIGFS_ATTR_RO(config_keys_, count);
> @@ -274,7 +275,7 @@ static bool is_dm_key_reused;
>  
>  static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>  {
> -	return sprintf(page, "%d\n", is_dm_key_reused);
> +	return sysfs_emit(page, "%d\n", is_dm_key_reused);
>  }
>  
>  static ssize_t config_keys_reuse_store(struct config_item *item,
> @@ -321,7 +322,7 @@ static bool restore;
>  
>  static ssize_t config_keys_restore_show(struct config_item *item, char *page)
>  {
> -	return sprintf(page, "%d\n", restore);
> +	return sysfs_emit(page, "%d\n", restore);
>  }
>  
>  static ssize_t config_keys_restore_store(struct config_item *item,
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
> 
> 



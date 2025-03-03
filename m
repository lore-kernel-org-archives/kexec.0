Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C80BC19F32
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I1yl5l9g7tT6vgWjZQbaAGhUwvcUn0WerlHiF2w1V+s=; b=qUAWZSSvPKJ3hbodGDYWLLfRwT
	gK2aD3qyjkCo7ZElakVYEeNfIYfhgddFPj6OE2j4QV2iHKxyhJnAAAFxBJ+lXF/p24wxCIgdhbxs1
	JXFpbBQsTO1Y1M/BhU9fW7peVFMmVgsN9Wfqdn55lGuqs/jmofMrs/un01AT1vouwm00rbVoPVL83
	93xxUeCFKPqnwYPdm04bVm+4/+FIJqZTai1aM875elq8JCxuETwY2+lxc31xikiOqCPj0YLVlHeda
	GWWN33M++oCFgnM6CeJoPKA/N3kmcCwNTAQtBwqdrWrgwiwUg1aaVSS+8r1Ti1UVqx+exqx1kslR0
	CuPPOUbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1touyc-0000000GvKz-1RQd;
	Mon, 03 Mar 2025 01:52:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1touyY-0000000GvKd-3yrz
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 01:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740966728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1yl5l9g7tT6vgWjZQbaAGhUwvcUn0WerlHiF2w1V+s=;
	b=Cx9tBACj83JvtCndwIBhiPGk3ozkTDItaYBfrdj86K1HQo+MDnj2ZSu9S+iCu7isCdQO+v
	BLGkBV8LXborCsfb3Oap7nZntcpeULaa8Bm5nZkytZ0+bIt3LuDzJ7PknsfdG25EALYUIs
	ejs4zZwysAvpAqHfsFdUyTSVSMWXhMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-N64PRUnSOc6szdAmPXHY0Q-1; Sun,
 02 Mar 2025 20:52:04 -0500
X-MC-Unique: N64PRUnSOc6szdAmPXHY0Q-1
X-Mimecast-MFC-AGG-ID: N64PRUnSOc6szdAmPXHY0Q_1740966723
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 804D71954128;
	Mon,  3 Mar 2025 01:52:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34A02180035F;
	Mon,  3 Mar 2025 01:51:58 +0000 (UTC)
Date: Mon, 3 Mar 2025 09:51:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 1/5] Add a new optional ",cma" suffix to the
 crashkernel= command line option
Message-ID: <Z8ULOoFYpvxC6Ey3@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <Z7ddi3ShAoQR2FtM@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7ddi3ShAoQR2FtM@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_175211_060891_6D5B02D9 
X-CRM114-Status: GOOD (  11.42  )
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

On 02/20/25 at 05:51pm, Jiri Bohac wrote:
......snip...  
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index a620fb4b2116..e72a9c897694 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -172,17 +172,19 @@ static int __init parse_crashkernel_simple(char *cmdline,
>  
>  #define SUFFIX_HIGH 0
>  #define SUFFIX_LOW  1
> -#define SUFFIX_NULL 2
> +#define SUFFIX_CMA  2
> +#define SUFFIX_NULL 3
>  static __initdata char *suffix_tbl[] = {
> -	[SUFFIX_HIGH] = ",high",
> -	[SUFFIX_LOW]  = ",low",
> -	[SUFFIX_NULL] = NULL,
> +	[SUFFIX_HIGH]	= ",high",
> +	[SUFFIX_LOW]	= ",low",
> +	[SUFFIX_CMA]	= ",cma",
> +	[SUFFIX_NULL]	= NULL,
>  };

Seems the old style looks a little better.
......



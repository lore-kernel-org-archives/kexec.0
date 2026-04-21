Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF3F89253
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5DEfO3Om6MFWAZ2G+/mg4cy2D9H7hgXJ3pHTPPk1W80=; b=Cfs72vkP4jf+oCpmrzUu8Ytqzb
	p1U7sg+3ajin4MAj3uEpkQzDQKj1/0l73URbM+W+fmodHVzXYueLoNkQDfN1lpuFXk6pFtQ7U6AK6
	xqev7uigQGE0Dgw2ppzH51a0IxU6f/Vhz3lrDKbF8o0h132rocQEQl/nzsVnVweS9ibEt+Z4FML2Q
	UzcvI5XQf4TO7a2HtVmh4HpMNpQUKI1wISBHT98DY4qLsko2v5J0zrJ6+EL5wTHgjY8nvs5cs/B9Y
	Hmsm1Tw75OEoZ7g632Tmje8pZtnGe5Chzb+zyQZEDr3ZrrkABJLtXhieYrEIyyTABHcJr+2aCGyuC
	/rpc+5tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8QT-00000008RvX-0TtF;
	Tue, 21 Apr 2026 10:33:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8QQ-00000008Rum-1Mjf
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 10:33:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B103942ACA;
	Tue, 21 Apr 2026 10:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A342FC2BCB5;
	Tue, 21 Apr 2026 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767629;
	bh=+HYxyzzmrs8BA0f4ocV88SQtOQuD4Dh2f+8I1JsB5Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiaYdB/6a+Mmpo8s7JnI43D9v3kTtg0YWl0Ywx4jNX47uPO7NvVs5caHtJ8loMX40
	 QOP77tYBVIbUSxtHmAxPxkndq0Ai65F3GhP+7CBZ5aFRfi2gfdD7PuJFZZzeUg1npd
	 UcDZQjCzpEmieEiD/2DcrBZyExhMwVlRaDykIK4JIJESnesyofEMn8AaLYuc7PyMEy
	 HAuoPdFF4llpLEBFvlYKjSeki9rMcMlMVsDdGmZsspdA/dsPzZmVwzwf0KMORHs2b7
	 WjjyWbBfckfkdfVZh7b1KDCNp7xVMk3R9vi8RgWDFZFjrX5mEQRUf31A/ro5cUvLnS
	 CUtQpY8UDsWhw==
Date: Tue, 21 Apr 2026 13:33:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <aedSh8oA5_nXPZ8E@kernel.org>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
 <20260420141741.2688371-4-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420141741.2688371-4-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_033350_412613_10A2D5CE 
X-CRM114-Status: GOOD (  23.00  )
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

On Mon, Apr 20, 2026 at 03:15:11PM +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> In userspace when managing LUO sessions we want to be able to identify
> a FD as a LUO session, in order to be able to do the special handling
> that they require in order to function as intended on kexec.
> 
> Currently this requires scraping procfs and doing string matching on
> the prefix of the dname, which is not an ideal interface.
> 
> Add a singleton inode type with a magic value, so that we can
> programmatically identify a fd as a LUO session via fstatfs().
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/uapi/linux/magic.h       |  1 +
>  kernel/liveupdate/luo_core.c     | 10 +++-
>  kernel/liveupdate/luo_internal.h |  2 +
>  kernel/liveupdate/luo_session.c  | 91 ++++++++++++++++++++++++++++++--
>  4 files changed, 98 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 4f2da935a76c..4f51005522ff 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -105,5 +105,6 @@
>  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
>  #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
>  #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
> +#define LUO_SESSION_MAGIC	0x4c554f53	/* "LUOS" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index dda7bb57d421..f1a63ebe4fa4 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -197,9 +197,17 @@ static int __init luo_late_startup(void)
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> +	err = luo_session_fs_init();
> +	if (err) {
> +		luo_global.enabled = false;

Please use goto here and on luo_fdt_setup() failure to handle cleanup on error.

Other than that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


> +		return err;
> +	}
> +
>  	err = luo_fdt_setup();
> -	if (err)
> +	if (err) {
> +		luo_session_fs_cleanup();
>  		luo_global.enabled = false;
> +	}
>  
>  	return err;
>  }

-- 
Sincerely yours,
Mike.


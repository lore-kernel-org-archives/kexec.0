Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72063F8924C
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VXZpyDtX9d/kueOfhaeSDpVbnDg1k8zMD8iFb/+pE9U=; b=QA4Owf7B3w8bltsd+C8A2dDQxp
	pQMdffOzUprOfr6I5ZcpTIxO7zKu4c4S4soXb/L0f7xAQkO1Tt0IjV+HRBb9qPRT0d4GfLUklSB8K
	yNMNhv7AvB8NIsrBklC13B22znpCuQHIVvZEmXzb6DSgHfKVTSG8oqa5+Uj2C5VIf6wJbZG5Zxzg1
	zht5uXVqc6oXv+B++KvyU4JzdsRrhjDit++ZU26MP3vGxX2Pm0OssBegbc7m4ZwSKhZcY0lR6vFBb
	SzaRrMGVnI4iLSz9rwGzFPyN1HzEhFvLw8Z+ckTytvd+qST+QZ1/bZOeqUFpfEA7GKaGPHccSbo79
	16NQNWew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Hs-00000008Q4A-1yYQ;
	Tue, 21 Apr 2026 10:25:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Hq-00000008Q3n-2qRn
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 10:24:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B9B7B43E3B;
	Tue, 21 Apr 2026 10:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5223FC2BCB0;
	Tue, 21 Apr 2026 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767097;
	bh=firh9QIDguLTG6wgrGZbOOkBiLIhh3fjZnBwKL1kIv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCemAdshi4KHRisPS/RvA4gQfws3j/RpyxXKUV0Yegibkt/idynoXy6hFSxswaKj4
	 yIPog4pFxpsumS1Dzkt0wk2UNZa2ovd/UR1Lta1s4Hedl9r3tkfTF41yQbgCqmU0DZ
	 BGeA3mT3tF8ULSg2K01WZXOvDNheI+LpdNFt76wb5SEezuZck8GApCkjA9i5gxuNkV
	 Txlk3Yu9CkOA0rBQPV1OWF5pzbXtA2abcQYSE3FbOx+aJP4Q619/M6hlqrYxA78/t2
	 PqaRG6eFDhwal6MZKLRSf4F8WNAMknUFX7PgbzwdyLlndysLpFhheB+hn/2TTgwdaU
	 LTqt+RVzihJ5A==
Date: Tue, 21 Apr 2026 13:24:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] liveupdate: reject
 LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
Message-ID: <aedQc4djj8VvL9xv@kernel.org>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
 <20260420141741.2688371-2-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420141741.2688371-2-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_032458_735645_F9928FBC 
X-CRM114-Status: GOOD (  15.05  )
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

On Mon, Apr 20, 2026 at 03:15:09PM +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> A session name must not be an empty string, and must not exceed the
> maximum size define in the uapi header, including null termination.
> 
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/luo_session.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 25ae704d7787..5e316a4c5d71 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -382,9 +382,13 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
>  
>  int luo_session_create(const char *name, struct file **filep)
>  {
> +	size_t len = strnlen(name, LIVEUPDATE_SESSION_NAME_LENGTH);
>  	struct luo_session *session;
>  	int err;
>  
> +	if (len == 0 || len > LIVEUPDATE_SESSION_NAME_LENGTH - 1)
> +		return -EINVAL;
> +
>  	session = luo_session_alloc(name);
>  	if (IS_ERR(session))
>  		return PTR_ERR(session);
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.


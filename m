Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E5DCD98C5
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmKlnOdHqjNiU96gwk50EppMlrDvFXPS7Xmukl/T8Zs=; b=ER3RqhqFVsfAMoZjon14ib1f8S
	9ACk+1hbXQLQ6jUedSXAmrKUz7/GSlLH2DrCMmzSIl+fZxVrX6d9cWVFL/dq/JLTOfOL9H5oPZA8E
	t9DHAQYs/t+Wz+fgaRsoPTtCREP4CUEZrkXSycfCJn9jgRmZMUWrDTpjQ4tt/TPh25V1hVTMJOYcM
	G3T5YGP/FUMwaGTprUBtlGlI1ZiBXetMvWhFDAr3ulQ4ldAWp3XMO9OnFE4kkiqIhc3lIl14D1PIZ
	fwgK5x2pHxZuIWVTj50Em/3xr3VH/dlRfPijLlizwu4tgVueyvXGQpz/uDmtj2ydX7njh3InIYNZH
	5FDWzTvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWymb-00000005yV2-0Bht;
	Tue, 09 Jun 2026 15:54:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWymZ-00000005yUw-2zbS
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 15:54:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7847144579;
	Tue,  9 Jun 2026 15:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3083E1F00893;
	Tue,  9 Jun 2026 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020467;
	bh=bmKlnOdHqjNiU96gwk50EppMlrDvFXPS7Xmukl/T8Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FCCLI2U2SPrU+pm+d906hK32RXBqM3qMdXXLPhwztHqlJ60VL06KZzqm/31dUoKF1
	 ffgAYCDLbven+3j9WrH20VH5Xt/8ZRzDDqygbNjmMMiM+5hJ/IM2Jjq/1W3ARu/FwX
	 28ShegM38hUgJwkXBgvH3lrIQr3zc9veW+Rc4AYHmN0wpD3wFnvHBAFx7XNn1GDLlH
	 BqlT2/2DQWHSD8QTByN9VJPCFKT9QfM6KlH+3qbpY+X3qHj7KtkWSB2Zu8ilAwxP49
	 prGXgDIqgjqX2cOGM5dSHFhiXgjX4U6SUBu/hWsL7YRpaC2b4ujSvBwFnsBNXU5+EU
	 b5f/CkITWnlZA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  vipinsh@google.com
Subject: Re: [PATCH] liveupdate: Document that retrieve failure is permanent
In-Reply-To: <074445fc4964961f12171ea129f2a7690322a78a.1780944056.git.tarunsahu@google.com>
	(Tarun Sahu's message of "Mon, 8 Jun 2026 18:42:50 +0000")
References: <074445fc4964961f12171ea129f2a7690322a78a.1780944056.git.tarunsahu@google.com>
Date: Tue, 09 Jun 2026 17:54:24 +0200
Message-ID: <2vxzfr2vso9b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Jun 08 2026, Tarun Sahu wrote:

> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/uapi/linux/liveupdate.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> index 30bc66ee9436..a564d2bd05c1 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -168,7 +168,8 @@ struct liveupdate_session_preserve_fd {
>   * associated with the token and populates the @fd field with a new file
>   * descriptor referencing the restored resource in the current (new) kernel.
>   * This operation must be performed *before* signaling completion via
> - * %LIVEUPDATE_IOCTL_FINISH.
> + * %LIVEUPDATE_IOCTL_FINISH. Once retrieve call is failed, retrieve status
> + * is saved. So it is permanent failure and retry is pointless.

Perhaps the wording below is slightly better from a user perspective?

    If a retrieve of a token fails, subsequent attempts to retrieve the
    token fail with the same error code. Failed retrieves are not
    retried.

>   *
>   * Return: 0 on success, negative error code on failure (e.g., invalid token).
>   */
>
> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
> prerequisite-patch-id: 30753743cdfab5c3c5355ecde725b6648f1b7a17

-- 
Regards,
Pratyush Yadav


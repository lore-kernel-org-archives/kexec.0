Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3EDCD6E4A
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BW1Jb2lq0jvXU9cqHaR15Ee40aqegmEDFgHV902Wtbg=; b=MH/lxttuIMC2jyX6CPv/Ivgxzd
	x20QQSjghV56BozAKLdU5Zptu8uXbRAfF8S/VsQbCrBQ6v9jsmXb/37yYAYzfAsutpGfLRiosnh9q
	WaTA7EszK9OvVVFRpwAAu4ji18Ez1Y2XRUqcOv44YudgXK85cwUdrReo7qCoFWgGTNMg56vnJ9ySi
	BOoFcH7PndG71A/uSSob1n6wcbCSwAk7FJxbG3+DtI0y6bIRYTNGbJMtzeJ8jhhdqtb/f/8ffUhEz
	WMwJYxhIiS+gphia8xjDiWtwIiDuWhc2iXah9jEjXxx7zm5NH3dOm2UcHvxkJVaBM2hQ94bguajMD
	ywmCuQ1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKFw-0000000CXsN-2nUZ;
	Tue, 02 Jun 2026 08:13:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKFv-0000000CXs0-0vhq
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 08:13:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 541F460142;
	Tue,  2 Jun 2026 08:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34C81F00899;
	Tue,  2 Jun 2026 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388026;
	bh=BW1Jb2lq0jvXU9cqHaR15Ee40aqegmEDFgHV902Wtbg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=a5l423uqgUs0EnF17yDerxYDPl7bPFNzxgCv8msMDTwa01f/VlMfU7kcbBQbByAy+
	 ZwI32LGnWXeITmWZegZCxOgODqaUVPz/jW5kTsJQ2Mnli0wa9y01znNa3fQc6+MtMa
	 zyfgkW4jmI8FrFU7tn7XpS0RJqn1PJwZslDYp8Y4vSxwhG6RZOdHq5U2lArsPGX5GN
	 324Jl+5rfjq8um7r0h3M+aVRP3yd4xZMwbTIsWCuZJ6VGUmWUv4PAmIXFTK0zM/NoM
	 s4nstGFOtfzqOBMk0+1o8FxKpOqXV6yrrJpj2Ooj63CKKnDAgMnjfOBMY28ISAEI7E
	 JXXV591Qj/DFg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 02/13] liveupdate: avoid mixing cleanup guards with
 goto in luo_session_retrieve_fd
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260530221938.115978-3-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-3-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 11:13:34 +0300
Message-Id: <178038801485.119771.9514973100282773342.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Sat, 30 May 2026 22:19:27 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 146414933977..8d9201c25412 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -291,25 +291,24 @@ static int luo_session_retrieve_fd(struct luo_session *session,
>  	if (argp->fd < 0)
>  		return argp->fd;
>  
> -	guard(mutex)(&session->mutex);
> -	err = luo_retrieve_file(&session->file_set, argp->token, &file);
> -	if (err < 0)
> -		goto  err_put_fd;
> +	scoped_guard(mutex, &session->mutex) {
> +		err = luo_retrieve_file(&session->file_set, argp->token, &file);
> +		if (err < 0) {
> +			put_unused_fd(argp->fd);
> +			return err;

I don't like piling up error handling inside if (err) statements.

As we only need the lock only for luo_retrieve_file() I think it's better
drop the guard and use goto:


	mutex_lock(&session->mutex);
	err = luo_retrieve_file(&session->file_set, argp->token, &file);
	mutex_unlock(&session->mutex);
	if (err)
		...

-- 
Sincerely yours,
Mike.



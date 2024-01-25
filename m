Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B747C47258
	for <kexec@archiver.kernel.org>; Thu, 25 Jan 2024 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VKKWsNH1lklNanStZeDz1b8fKC1kczRQ9YtA8TT7xTc=; b=fcCm2o5BtMRUKe
	6tLxiHGY0G75aDPVzkIeJ3J0FkoToGN8LKGhOY//rsgUbH9frf09p8ZZOaOMesq879n6ilZkqNWce
	UJ4TGNBpx55QNl8msY9LW0r4s58SfC/mhu1bEggEnoqKXrtKhw5vdJbP0Jmw3MlMg8OPxlnzbBbIZ
	lQoi8j8GWW/5RSjlhB1FYaPCOoAa4/b4WWtApEeLJetXKbVeT/VXaREtCPxFqV1Dxejn4c9YarrEk
	R86QnTLSpxJhDAZBoCSXHa7SF/mnOAMnXf0M/PLXbuYxFXIXaixcODFYcV/m7bA47dRLe6HJqfiDD
	wHxzCVcaPCwQunGdnlyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT37u-000000012Di-2255;
	Thu, 25 Jan 2024 17:02:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT37r-000000012Ca-12jv
	for kexec@lists.infradead.org;
	Thu, 25 Jan 2024 17:02:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BA38D62203;
	Thu, 25 Jan 2024 17:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833FBC43390;
	Thu, 25 Jan 2024 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202170;
	bh=WOkz/xoyTrULLZzD7czoNOw7zB2IkoKfOl5Ao9nhrlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkJGUKNWBKD3uUnImc6DXYA7jzjoVgdSkZuZdVVBcc606cywHTZqag2LL+S4L+L0I
	 guBX33ov6AxADIfODLniGIJ0b5+7MvXTVDap6Z/Vl0jMYlrg2MJ9bnKWCATrSKn2vw
	 LlQqatprRqb3Gg8gb1nM0EezYZM09rYFpFwfQELpHrG6/7tNl7OCWV5cD1rGu+pWH9
	 sLM7zNeK0P00LulxO8+Q3hNQyt1gohjXwEQrmT5FikynrrIc4XrVlM8c8K0T6kc7zo
	 Wnas1Moa/05CMKdc2TqYA6S6x2NDQQy77yb0XGbyQDZsj1ROezOWjCkrByANYY4Jtf
	 o8K9cjo56mbCQ==
Date: Thu, 25 Jan 2024 17:02:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: don't use kexec_file_load on XEN
Message-ID: <20240125170245.GA245752@kernel.org>
References: <Zaa5dwoUi4WnrCMA@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zaa5dwoUi4WnrCMA@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_090251_374919_5D010741 
X-CRM114-Status: GOOD (  13.20  )
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

On Tue, Jan 16, 2024 at 06:14:31PM +0100, Jiri Bohac wrote:
> Since commit 29fe5067ed07 ("kexec: make -a the default")
> kexec tries the kexec_file_load syscall first and only falls back to kexec_load on
> selected error codes.
> 
> This effectively breaks kexec on XEN, unless -c is pecified to force the kexec_load
> syscall.
> 
> The XEN-specific functions (xen_kexec_load / xen_kexec_unload) are only called
> from my_load / k_unload, i.e. the kexec_load code path.
> 
> With -p (panic kernel) kexec_file_load on XEN fails with -EADDRNOTAVAIL (crash
> kernel reservation is ignored by the kernel on XEN), which is not in the list
> of return codes that cause the fallback to kexec_file.
> 
> Without -p kexec_file_load actualy leads to a kernel oops on v6.4.0
> (needs to be dubugged separately).
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> Fixes: 29fe5067ed07 ("kexec: make -a the default")

Thanks Jiri,

and sorry for the delay.
Applied to main.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

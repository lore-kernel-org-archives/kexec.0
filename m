Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61366CD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BmkfQzS4QFtlgAAV8A1uf20MFVhEVZ4oj0l+mXcz/5Q=; b=QF1G1DmTp9R+r71qdowDlx4ETl
	5LwubHhYZzZWRszzZqlBHnhPfLDwQ2vuY8PPDP7dRe84IKazUb+0P1jBNCiWfxexrfuG0reymW+FC
	csYLxgyclvyyBM/H4ijsOCTen3AmHT7hOsQocJvbCAf315VzRn9ZvQ0BHbvAyq+wod8+ImQZUO0Mj
	g+Kn9mMz7eBYuRt2adGFxLApVHAYB2wq0yWhRR+wdLXDcTPuQFohouFaLrMSl9iPtlbomO1sygpQw
	7K8W+SWAtug/3N9+ea1ONEKOut+gNH6pncFGGsSH504bRLoNPnbRtUq/tl8wpy1f0gDknwQq0NU5o
	aTlpAjLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtWT-0000000Eqkt-0vdx;
	Mon, 18 May 2026 08:40:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtWR-0000000Eqjt-2LVf
	for kexec@bombadil.infradead.org;
	Mon, 18 May 2026 08:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BmkfQzS4QFtlgAAV8A1uf20MFVhEVZ4oj0l+mXcz/5Q=; b=mceA+mrfz/TCvaVtvsiBCcKz+y
	hnQrzYZgwPzZ7cwzNxTImYN8bM/bDaSrev8Mj60kaTufVMO40Qjep9fW497VNsomAcQo61LyNIn8K
	KZgalb7hgFMSni6nwBoPXM7nGH+BIqH8VMVSnKbyJE4GhxybIvONY/cXr7oyT0/J/kBXOzMh6BsDo
	tDpUvivMafLnkwfTO10MHfUFka1IK9NyOnzMdWX6CwG0xwFpzK/QXKiPvs3sElCCi2FDv7JFnjB7Y
	d6Cstzqk6LmJoPIZZbV8bJC8/cOsvLa15c+S2jfXDNy5t/y2C9fwcp+PJrX+l9JfNn6pJ33qfOnNH
	jgFk0Z8Q==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtWN-0000000AQIc-0mOI
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 08:40:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5929D40B65;
	Mon, 18 May 2026 08:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43080C2BCF5;
	Mon, 18 May 2026 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779093617;
	bh=em2YNNKzh+qd+JnX5KScyjFt+cTn9m/viRNbzTHO3e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjwE1D9H0PsOXihBotrkvLZSSYUSvqty0q6+lnA7F0RlbDn74gA08plwiqxadnJLA
	 KyzE4NxF9dwWdxmHZTQWr/PQGu6HqbXqFuRFzNYCsRnVLX4tJgOfvQbnIfOpsTYdhf
	 r1iEPUIQ+RW3Hs0Cq6xwuRNTbyoMlTKPktrFJT9idse5DYkyFC/Y9gYQmsPAPvE+qJ
	 2PeTGPs1ABg/JZYjHS9czpYj8Y7VdSc1Bu14ka9H5F+BJNnNwxmlfX2JrdLtcBuFNW
	 MbGR4JSfb+x8tDB0+HfqdE/XH+wg0WgrppetlAtgXXjJIPrNYCB4WK2idXH/X0/hKi
	 LbaKzR1iIWmCw==
Date: Mon, 18 May 2026 11:40:08 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: sourabhjain@linux.ibm.com, jbouron@amazon.com,
	akpm@linux-foundation.org, bhe@redhat.com,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com, rafael.j.wysocki@intel.com, piliu@redhat.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com, mario.limonciello@amd.com
Subject: Re: [PATCH v4 3/5] liveupdate: block session mutations during reboot
Message-ID: <agrQaP22pgxOkR_j@kernel.org>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
 <20260517192650.1019314-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517192650.1019314-4-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_094020_183186_406D93D6 
X-CRM114-Status: GOOD (  18.05  )
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

On Sun, May 17, 2026 at 07:26:48PM +0000, Pasha Tatashin wrote:
> During the reboot() syscall, user processes may still be running
> concurrently and attempting to mutate sessions (e.g., creating,
> retrieving, or releasing sessions). To prevent this, introduce
> luo_session_serialize_rwsem to synchronize mutations with the
> serialization process.
> 
> All session mutation operations (create, retrieve, release, ioctl) take
> the read lock. The serialization process (luo_session_serialize) takes
> the write lock and holds it indefinitely on success. This effectively
> freezes the LUO session subsystem during the transition to the new
> kernel. If serialization fails, the lock is released to allow recovery.
> 
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_session.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 59b37d17db6b..6099213275d8 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -385,9 +394,12 @@ int luo_session_create(const char *name, struct file **filep)
>  	struct luo_session *session;
>  	int err;
>  
> +	down_read(&luo_session_serialize_rwsem);
>  	session = luo_session_alloc(name);

We can alloc outside the lock, will make error handling simpler.

sashiko complains about mixing down_read() with scoped_guard(), for this
function it would make sense to use plain mutex_{lock,unlock} around
luo_session_getfile()

> -	if (IS_ERR(session))
> -		return PTR_ERR(session);
> +	if (IS_ERR(session)) {
> +		err = PTR_ERR(session);
> +		goto err_unlock;
> +	}
>  
>  	err = luo_session_insert(&luo_session_global.outgoing, session);
>  	if (err)
> @@ -398,12 +410,16 @@ int luo_session_create(const char *name, struct file **filep)
>  	if (err)
>  		goto err_remove;
>  
> +	up_read(&luo_session_serialize_rwsem);
> +
>  	return 0;
>  
>  err_remove:
>  	luo_session_remove(&luo_session_global.outgoing, session);
>  err_free:
>  	luo_session_free(session);
> +err_unlock:
> +	up_read(&luo_session_serialize_rwsem);
>  
>  	return err;
>  }

-- 
Sincerely yours,
Mike.


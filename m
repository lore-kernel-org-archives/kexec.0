Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B337ECD98DA
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 06:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9D0UOD8hJI6j+cwdcFWcWcuB2014gIQar2UbjXkYl18=; b=T4i39gwqkq9exkcDnkGeQCjBXJ
	SW4oAc+KMMabnYySKfk6SzTpTO+9/yMACpaH1HEsrzwXoBSIOB+OmJVk3JXVawDwuwNtcRvfb5nY8
	tjBtbVpvqEg+7dbS4P+tqnVJfWJT5wvW89v8BmRverj72pkZtQZrNRnP5YtgH0kalKPtpD+tXLc7a
	vQFDaBRPFX8pmrTmmNOKgxgLb/O7pSxqDTwpkVi6H2tR+pEWITYRrqxQdQqXuauyYgMu4E/+0M7GY
	oUZyuUCCoQx/yw189NgqDUUMdy0/1N/psrFPy0l3sZH5Zt3jnXKuzP6wIgcu6QY0rbx2z+pLSnVSC
	EHMsmkYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZNXY-0000000FKOB-18uv;
	Tue, 16 Jun 2026 06:44:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZNXX-0000000FKNw-1OmN
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 06:44:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A20F141A1B;
	Tue, 16 Jun 2026 06:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E070D1F000E9;
	Tue, 16 Jun 2026 06:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781592290;
	bh=9D0UOD8hJI6j+cwdcFWcWcuB2014gIQar2UbjXkYl18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lLQcu3J5tA/7uWuT9KRhO3Be4GipsBASKfO4kB7LbHJMzGhMAyNmCM8AgriQ+eE7Q
	 YbzMy1LVJjVPpa8Sz5PKJEnPV5zuMuEVpUr9qBmTMs0zRjV1jrU0zpDc2DJmT62rjj
	 BGoQpV4ujL6xBM05kBId2xC9FarQdNhQdkMwKCBtSlOzz/IxjWthCSwPXRdY86orDZ
	 2Nh2apsO5+7oUCobWMjhktAX+m+SiRjQCcHGqiX9dAQwdixiFMUk44rmePoIZlvgen
	 SjwRKcIyM0lLsAAhKZN2RZsdLJs13eJ50lxziVHSrxLldvOsX4mEwbCxQzXV1ti+zl
	 PUoVJgFWW9Zeg==
Date: Tue, 16 Jun 2026 09:44:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/1] mm/memfd_luo: use KHOSER_PTR for serialized_data
 checks
Message-ID: <ajDw3DQ13ZpvW__D@kernel.org>
References: <cover.1781528022.git.tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781528022.git.tarunsahu@google.com>
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

Hi,

On Mon, Jun 15, 2026 at 01:05:04PM +0000, Tarun Sahu wrote:
> Use the KHOSER_PTR interface for serialized_data in memfd_luo to
> perform type-safe pointer conversions and checks.
> 
> I have tried to keep the changes minimal. So only changed
> the memfd_luo. Would love the suggestions for if we should be changing
> struct liveupdate_file_op_args like the following.
> 
> @@ -46,7 +47,7 @@ struct liveupdate_file_op_args {
>  	struct liveupdate_file_handler *handler;
>  	int retrieve_status;
>  	struct file *file;
> -	u64 serialized_data;
> +	DECLARE_KHOSER_PTR(serialized_data, void *);

Yes, this one please :)

>  	void *private_data;
>  };
> 
> Ofcourse, it will require change in liveupdate and luo_file.
> 
> Tarun Sahu (1):
>   mm/memfd_luo: use KHOSER_PTR for serialized_data checks
> 
>  mm/memfd_luo.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 

-- 
Sincerely yours,
Mike.


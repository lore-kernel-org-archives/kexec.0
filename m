Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBD5EE57F9
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 00:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IFqa7HK3Jo5bXinN8Pe8GulBzdJSBW7JXoaPhIaiXPQ=; b=OhE4NgNzzr88vx
	2PJ+5xJJKkEKJ5rt5wNLVfSOynlBf2RZBRBHSeW1p0D01BGL8vgg7jz0zUurbpQyoQK4UZWWCvZPY
	VkjVhMlFC/vNCWottrhZbcnmHCgE6n+9EVqoUSgpfyx3m7w1rx81JI0WazMayLgixlUpw/cdFWARP
	WXLsUF+yb20hrWX4rpdqHbDGqX6UuYdKKQuydNkdE83qUfHKKjyyXqo8YIqQ22NMJivklpafKfoEQ
	Sk+kZXdGzA/WJyS5IeikOxss76G58Ok81MTLTnHXMLMzStg474FAJWAgS3awAXNCt1wWOziChsM2W
	m9XLCO8+scG+CrOVFO9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soY6J-0000000BSf6-3mog;
	Thu, 12 Sep 2024 00:54:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soY6G-0000000BSei-3AXn
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 00:54:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726102459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b68u0e0/6l3aTcwgwyF4H+GXM1gl+kB/qAh1zau1jhw=;
	b=McZcCbfg5Nd7nNng1NNW0LxHndGbch2wfLdAdMGKRwvy9vf6MfmJrYr+val5XRcc2Vr8sR
	+On6Fd512aFCXKhvpNgNbsizlShd4CVJMxgRYwpy11dd94ICiZYY5EmX4hnrk9YOy2hBl4
	2pH/eb0rwcYSb2QnmQjhd/R2psIKwTk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-xjkabQI1MU-6C18y-nGYWQ-1; Wed,
 11 Sep 2024 20:54:15 -0400
X-MC-Unique: xjkabQI1MU-6C18y-nGYWQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 471501955F68;
	Thu, 12 Sep 2024 00:54:12 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF62F19560A3;
	Thu, 12 Sep 2024 00:54:07 +0000 (UTC)
Date: Thu, 12 Sep 2024 08:54:02 +0800
From: Baoquan He <bhe@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, vgoyal@redhat.com,
	dyoung@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Message-ID: <ZuI7qkE/6EVEGajs@MiWiFi-R3L-srv>
References: <20240830182219.485065-1-gpiccoli@igalia.com>
 <ZtUrX4n+HPYhyQ9z@MiWiFi-R3L-srv>
 <d954da78-87cf-d7d9-a620-0c2fae5dd242@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d954da78-87cf-d7d9-a620-0c2fae5dd242@igalia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_175420_893473_5C088786 
X-CRM114-Status: GOOD (  27.59  )
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

On 09/11/24 at 05:09pm, Guilherme G. Piccoli wrote:
> On 02/09/2024 05:05, Baoquan He wrote:
> > On 08/30/24 at 03:21pm, Guilherme G. Piccoli wrote:
> >> Be more clear about the downsides, the upsides (yes, there are some!)
> >> and about code that unconditionally sets that.
> >>
> >> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> >> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> >>
> >> ---
> >>
> >> V2: Some wording improvements from Stephen, thanks!
> >> Also added his review tag.
> >>
> >> V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/
> >>
> >>
> >>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index efc52ddc6864..351730108c58 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -913,12 +913,16 @@
> >>  			the parameter has no effect.
> >>  
> >>  	crash_kexec_post_notifiers
> >> -			Run kdump after running panic-notifiers and dumping
> >> -			kmsg. This only for the users who doubt kdump always
> >> -			succeeds in any situation.
> >> -			Note that this also increases risks of kdump failure,
> >> -			because some panic notifiers can make the crashed
> >> -			kernel more unstable.
> >> +			Only jump to kdump kernel after running the panic
> >> +			notifiers and dumping kmsg. This option increases the
> >> +			risks of a kdump failure, since some panic notifiers
> >> +			can make the crashed kernel more unstable. In the
> >> +			configurations where kdump may not be reliable,
> >> +			running the panic notifiers can allow collecting more
> >> +			data on dmesg, like stack traces from other CPUS or
> >> +			extra data dumped by panic_print. Notice that some
> >> +			code enables this option unconditionally, like
> >> +			Hyper-V, PowerPC (fadump) and AMD SEV.
> >                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > I know Hyper-V enable panic-notifiers by default, but don't remember how
> > PowerPC and AMD SEC behave in this aspect. While at it, can you add a
> > little more words to state them in log so that people can learn it?
> > Thanks.
> > 
> Hi Baoquan, tnx for the suggestion! You mean mention that in the commit
> message? If so, I can certainly do - will sent a new version soon(tm)
> and include it =)

You are right, thanks for the effort.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

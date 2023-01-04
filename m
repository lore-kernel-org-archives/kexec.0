Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D46AC4332F
	for <kexec@archiver.kernel.org>; Wed,  4 Jan 2023 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=loxUyvjO18GBJbmLH4MH1YRI+A1G1yHU7pkgBBmIvSM=; b=LUTogh2oc46dCq
	a2EFL0K+W82vr53F4wl4CMkhTq8k0qKhT7TDcvLs4XsLwnHbdPszCzzFCNjSIHuwIw+8fF/vdp1Jj
	2sMMgYmn5Pn8Y2/s3X92UlMbHnKwjPjjIL6fPCQFEzIg05L563jWyawoRMFNy7cVd+0tx+wVsfrGc
	ta3XgzQDSnE1AaT3ZQYz684/6JBn553IhRywEecIsXKGw9Jodu5Wmc2wAzGjkd5U7DJbfdHDIpJrE
	XFhYHg9Zz8GV1kIwpGaS6sPvIAQp6ciuaOV0+OnHdYOvJblGjZhCtrwlWJcvwt5oXK5CukIb1GXEH
	6zjwHGB/X3IX/elwjkKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD70S-00AVet-7p; Wed, 04 Jan 2023 16:52:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD5XH-00A2iu-M4
	for kexec@lists.infradead.org; Wed, 04 Jan 2023 15:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1672845512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oxfz6EhZocx3G6fE49e6Qs3NUMuCUPxRP9Iod/SdZ9I=;
	b=N+CvU3bk/qvYmtlSM1yV5866dDDrQaUaA2JDo2fvEtIFZWPQG+565bcmbPx1QScZcCS972
	PMiB3OUqEb1L7rc7INrsfHOf/Vq82Ri13/SF7BVjU4qQ839j/E89ms9hSc2ohQMU56Le/5
	/wK8Iq4IA/yuUc4iumIm3LgUQd4nbFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-f-EDafPjP6C2oW3RUXkaKw-1; Wed, 04 Jan 2023 10:18:31 -0500
X-MC-Unique: f-EDafPjP6C2oW3RUXkaKw-1
Received: by mail-wm1-f70.google.com with SMTP id j1-20020a05600c1c0100b003d99070f529so12632567wms.9
        for <kexec@lists.infradead.org>; Wed, 04 Jan 2023 07:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxfz6EhZocx3G6fE49e6Qs3NUMuCUPxRP9Iod/SdZ9I=;
        b=I4Fb+zHbdOloDLhBUH3tTUdgZBzKx0JH0PQRGkfPeIwC+C83TQXkWVW7+UVhzCNHtc
         k5zzb5fFOIvVNBCtf1R4F/YAOjOqm8yVjmOFevmwhfsSrTxIssG9vR0BTDU12jcNpbNJ
         gZ/lsx+zUk3fgUN4PrTsHiXPxzd2ZAIZGFSVIaRVXsDuD1Zeyyfkzl8zUMjGhZP5tEg7
         G3vpfHCt1h90mUrMFNe2Mxf6r6pF3Z1UmcRhj37LqQR/5nEWgcD6Gzb2SpH9Wg+NbDgu
         KjmEwiOJUDI/E2059GNxCXmdVVa1sZuklLM6N17b0zB4rjLPeRhnLce35Vu1NcSOiQg4
         jaHA==
X-Gm-Message-State: AFqh2kpi+zH1oA7leVbc/KRo6ALqIvpFkA+DDQBZBIiU5iGaqVV0mQze
	vwI4TWb6HNAS4q6EJ5rc7QsyGUrqEsxsptThhOqIRiSnstf/wOFOrq9R4hWDg21cV1VxXF7A03v
	ZNyQN3A+738ImneSQvHEx
X-Received: by 2002:adf:fe44:0:b0:27a:b72a:819c with SMTP id m4-20020adffe44000000b0027ab72a819cmr21717110wrs.58.1672845510303;
        Wed, 04 Jan 2023 07:18:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXue8bZ/xYiBM3ApJcVGTAae49bu2m91DgXeka06lAG4JzOIsCkrHQBAgy7fy2nQ18MRn4yCaA==
X-Received: by 2002:adf:fe44:0:b0:27a:b72a:819c with SMTP id m4-20020adffe44000000b0027ab72a819cmr21717096wrs.58.1672845510094;
        Wed, 04 Jan 2023 07:18:30 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm38279954wrs.82.2023.01.04.07.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 07:18:29 -0800 (PST)
Date: Wed, 4 Jan 2023 15:18:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Baoquan He <bhe@redhat.com>, pbonzini@redhat.com, mlevitsk@redhat.com
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y7WYw0YH27hdsD11@work-vm>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
 <Y6Gsz4mqnZCtC9rn@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Y6Gsz4mqnZCtC9rn@MiWiFi-R3L-srv>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_071835_981533_CB27BAE6 
X-CRM114-Status: GOOD (  18.50  )
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

* Baoquan He (bhe@redhat.com) wrote:
> On 12/20/22 at 12:38pm, Peter Zijlstra wrote:
> > On Tue, Dec 20, 2022 at 01:34:58PM +0800, Baoquan He wrote:
> > > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> > > 
> > > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > > Implement IPI shorthands support") can fix it.
> > > 
> > > The problem will disappear if removing 'nr_cpus=2' from normal kerne's
> > > cmdline.
> > 
> > And the root cause for this is... ? Does the kvm x2apic emulation
> > somehow get upset when we shorthand CPUs that haven't been initialized?
> 
> Thanks for checking.
> 
> I haven't figure out the root cause. I haven't read the apic code for
> long time, and not familiar with the kvm code. So raise the issue to
> upstream.
> 
> I can do testing if any suggestion.
> 
> Add our virt dev Dr. David Alan Gilbert to CC.

Hmm I don't know that code well enough; cc'ing Paolo and Maxim.

Dave
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

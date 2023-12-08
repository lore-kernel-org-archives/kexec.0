Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458BCC10DC3
	for <kexec@archiver.kernel.org>; Fri,  8 Dec 2023 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXs2cKOhcVViSEi6BovtMdeMNE///uXyRmbN4eDOYts=; b=42Ix11H6rxjZlx
	kMVcywVg7CQoa2zT8uFpsLSP/DYkeudYHCMp57CmleTcOdE8jprm6z1k5vcs1ry/O8bBAMfQbCx9q
	2n0FADLrqQaKFg0b9wcfV6qGFL6pLARm0xD2ngs6dGlmxsjtTNYQ1SXJB2PkJhiDNdSICscLbbQxj
	p2GaV/MX2+DUlQNjcNXLrx4zgZFZ2Ju0flCXs4Yhxa7yJPmBlp8H4UZRpNzyTeaei6u+sMSD01VmQ
	uKfMk+XD75PuUsmby5aZivSNSyMv9OC9/u2LGOzyGhGBkusF+OP7dQhxfTZDiJpk5svdre1/s8AJY
	zQMGp1oytrU7x2KSJVZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBQ5q-00EVBy-1G;
	Fri, 08 Dec 2023 01:55:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBQ5n-00EVAc-1W
	for kexec@lists.infradead.org;
	Fri, 08 Dec 2023 01:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702000547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0GlGocyqXMQn1E1f/sgzjFoxtiNjbFqYR2QABsm1pU=;
	b=Z6fLtOKzqoCwRFFKRpVyFhWDSvjLNDs1DDBcHDFmE9fDgl68dU5hfPGoHOFnzKP6P8+CEO
	aTVYqv2PVVbM/qwV8VOg7l83ImBHIFA67+wQFlNdJCebK8yHdW8a2uwijPyssUJoLv5WJP
	TST/0Qe1DH1xnchgkyGBq/PAnuOy4mY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-TebjmZGVN6ifQgtcoa-I8A-1; Thu,
 07 Dec 2023 20:55:43 -0500
X-MC-Unique: TebjmZGVN6ifQgtcoa-I8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C63D53806068;
	Fri,  8 Dec 2023 01:55:42 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 173841C060AF;
	Fri,  8 Dec 2023 01:55:41 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:55:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXJ3m4fPZXJnj29z@MiWiFi-R3L-srv>
References: <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
 <ZXGIeAgCcatUDa2h@tiehlicka>
 <20231207121314.50b8e4c4@rotkaeppchen>
 <ZXGyANwELvFKpysH@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXGyANwELvFKpysH@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_175551_611507_82C6EB4C 
X-CRM114-Status: GOOD (  38.66  )
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

On 12/07/23 at 12:52pm, Michal Hocko wrote:
> On Thu 07-12-23 12:13:14, Philipp Rudo wrote:
> > On Thu, 7 Dec 2023 09:55:20 +0100
> > Michal Hocko <mhocko@suse.com> wrote:
> > 
> > > On Thu 07-12-23 12:23:13, Baoquan He wrote:
> > > [...]
> > > > We can't guarantee how swift the DMA transfer could be in the cma, case,
> > > > it will be a venture.  
> > > 
> > > We can't guarantee this of course but AFAIK the DMA shouldn't take
> > > minutes, right? While not perfect, waiting for some time before jumping
> > > into the crash kernel should be acceptable from user POV and it should
> > > work around most of those potential lingering programmed DMA transfers.
> > 
> > I don't think that simply waiting is acceptable. For one it doesn't
> > guarantee that there is no corruption (please also see below) but only
> > reduces its probability. Furthermore, how long would you wait?
> 
> I would like to talk to storage experts to have some ballpark idea about
> worst case scenario but waiting for 1 minutes shouldn't terribly
> influence downtime and remember this is an opt-in feature. If that
> doesn't fit your use case, do not use it.
> 
> > Thing is that users don't only want to reduce the memory usage but also
> > the downtime of kdump. In the end I'm afraid that "simply waiting" will
> > make things unnecessarily more complex without really solving any issue.
> 
> I am not sure I see the added complexity. Something as simple as
> __crash_kexec:
> 	if (crashk_cma_cnt) 
> 		mdelay(TIMEOUT)
> 
> should do the trick.

I would say please don't do this. kdump jumping is a very quick
behavirou after corruption, usually in several seconds. I can't see any
meaningful stuff with the delay of one minute or several minutes. Most
importantly, the 1st kernel is in corruption which is a very
unpredictable state.
... 
> > Finally, let me question whether the whole approach actually solves
> > anything. For me the difficulty in determining the correct crashkernel
> > memory is only a symptom. The real problem is that most developers
> > don't expect their code to run outside their typical environment.
> > Especially not in an memory constraint environment like kdump. But that
> > problem won't be solved by throwing more memory at it as this
> > additional memory will eventually run out as well. In the end we are
> > back at the point where we are today but with more memory.
> 
> I disagree with you here. While the kernel is really willing to cache
> objects into memory I do not think that any particular subsystem is
> super eager to waste memory.
> 
> The thing we should keep in mind is that the memory sitting aside is not
> used in majority of time. Crashes (luckily/hopefully) do not happen very
> often. And I can really see why people are reluctant to waste it. Every
> MB of memory has an operational price tag on it. And let's just be
> really honest, a simple reboot without a crash dump is very likely
> a cheaper option than wasting a productive memory as long as the issue
> happens very seldom.

All the time, I have never heard people don't want to "waste" the
memory. E.g, for more than 90% of system on x86, 256M is enough. The
rare exceptions will be noted once recognized and documented in product
release.

And ,cma is not silver bullet, see this oom issue caused by i40e and its
fix , your crashkernel=1G,cma won't help either.

[v1,0/3] Reducing memory usage of i40e for kdump
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210304025543.334912-1-coxu@redhat.com/

======Abstrcted from above cover letter==========================
After reducing the allocation of tx/rx/arg/asq ring buffers to the
minimum, the memory consumption is significantly reduced,
    - x86_64: 85.1MB to 1.2MB 
    - POWER9: 15368.5MB to 20.8MB
==================================================================

And say more about it. This is not the first time of attempt to make use
of ,cma area for crashkernel=. In redhat, at least 5 people have tried
to add this, finally we gave up after long discussion and investigation.
This year, one kernel developer in our team raised this again with a
very long mail after his own analysis, we told him the discussion and
trying we have done in the past.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

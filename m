Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E93E743D0
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 23:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C9NH7eJBGzTmnAegeO7wPMv5rhPb3Rs80bPO2wyd1hk=; b=DBBFviUdSsRM+c
	BL3Hbk/0teCjGAZ75vOdIFr+zrMa3l2CLRbAEh8JpeacZuIMdlGv7Nmqq/9FrlmAiOGVRHYptK4Vl
	IHiictKUB5kP5i5w0a06OTXS8ph45tVAmkrCQXFRqQs/ntTyJ/iiJklqbhZyn3SXtW0ZcDb27suyG
	QPUZz8UczYFzPpQFr+D2H40yqOoEbnCuFSijxDa+a7hp987UTfzPKLdHS9jxlgh47GAi1BLMpmQFd
	/RGM2zrnYVb7MbgYC1MWRwP+knyoTSqZYnTLR4VvLI9FcgTDeP4tUzURFyC+k+V5XFMMbDwePRneW
	phHd5uIJzGOomBWa56IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qm0sG-006t4D-02;
	Thu, 28 Sep 2023 23:56:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qm0sC-006t3V-1V
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 23:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695945406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmH6ulJd+9yyiGz4CzogSJiZ2VjE+uu1xK5/kan0/PQ=;
	b=gMNZnEdqBCpz92+QkZfJj4rPT0zC8T6w7v8qOwiwPylXaf3lh8qPItsWMqeoIHqGvSqW2k
	xguxH9IVAmGWW9q51AFvB+ZY5KUcGUA+0N4kgctNhGMXli/ajWRTODxcYdFu9qPN79HYsE
	W0qE8yO3jLdc9nCt41aRVngFTLyd03k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440--9d5HYC4NbCzZbJc3VfQuQ-1; Thu, 28 Sep 2023 19:56:42 -0400
X-MC-Unique: -9d5HYC4NbCzZbJc3VfQuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9C693811F22;
	Thu, 28 Sep 2023 23:56:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1A440C6E76;
	Thu, 28 Sep 2023 23:56:39 +0000 (UTC)
Date: Fri, 29 Sep 2023 07:56:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ebiederm@xmission.com,
	akpm@linux-foundation.org, stanislav.kinsburskii@gmail.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org, kys@microsoft.com,
	jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <ZRYStfGZ0/FrRh8Z@MiWiFi-R3L-srv>
References: <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
 <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
 <64208.123092816192300612@us-mta-483.us.mimecast.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <64208.123092816192300612@us-mta-483.us.mimecast.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_165648_592724_981AD9EA 
X-CRM114-Status: GOOD (  55.83  )
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

On 09/27/23 at 07:46pm, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 12:16:31PM -0700, Dave Hansen wrote:
> > On 9/27/23 17:38, Stanislav Kinsburskii wrote:
> > > On Thu, Sep 28, 2023 at 11:00:12AM -0700, Dave Hansen wrote:
> > >> On 9/27/23 17:02, Stanislav Kinsburskii wrote:
> > >>> On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
> > >> ...
> > >>> Well, not exactly. That's something I'd like to have indeed, but from my
> > >>> POV this goal is out of scope of discussion at the moment.
> > >>> Let me try to express it the same way you did above:
> > >>>
> > >>> 1. Boot some kernel
> > >>> 2. Grow the deposited memory a bunch
> > >>> 5. Kexec
> > >>> 4. Kernel panic due to GPF upon accessing the memory deposited to
> > >>> hypervisor.
> > >>
> > >> I basically consider this a bug in the first kernel.  It *can't* kexec
> > >> when it's left RAM in shambles.  It doesn't know what features the new
> > >> kernel has and whether this is even safe.
> > >>
> > > 
> > > Could you elaborate more on why this is a bug in the first kernel?
> > > Say, kernel memory can be allocated in big physically consequitive
> > > chunks by the first kernel for depositing. The information about these
> > > chunks is then passed the the second kernel via FDT or even command
> > > line, so the seconds kernel can reserve this region during booting.
> > > What's wrong with this approach?
> > 
> > How do you know the second kernel can parse the FDT entry or the
> > command-line you pass to it?
> > 
> > >> Can the new kernel even read the new device tree data?
> > > 
> > > I'm not sure I understand the question, to be honest.
> > > Why can't it? This series contains code parts for both first and seconds
> > > kernels.
> > 
> > How do you know the second kernel isn't the version *before* this series
> > gets merged?
> > 
> 
> The answer to both questions above is the following: the feature is deployed
> fleed-wide first, and enabled only upon the next deployment.
> It worth mentioning, that fleet-wide deployments usually don't need to support
> updates to a version older that the previous one.
> Also, since kexec is initialited by user space, it always can be
> enlightened about kernel capabilities and simply don't kexec to an
> incompatible kernel version.
> One more bit to mention, that it real life this problme exists only
> during initial transition, as once the upgrade to a kernel with a
> feature has happened, there won't be a revert to a versoin without it.
> 
> > ...
> > >> I still think the only way this will possibly work when kexec'ing both
> > >> old and new kernels is to do it with the memory maps that *all* kernels
> > >> can read.
> > > 
> > > Could you elaborate more on this?
> > > The avaiable memory map actually stays the same for both kernels. The
> > > difference here can be in a different list of memory regions to reserve,
> > > when the first kernel allocated and deposited another chunk, and thus
> > > the second kernel needs to reserve this memory as a new region upon
> > > booting.
> > 
> > Please take a step back from your implementation for a moment.  There
> > are two basic design points that need to be considered.
> > 
> > First, *must* "System RAM" (according to the memory map) be persisted
> > across kexec?  If no, then there's no problem to solve and we can stop
> > this thread.  If yes, then some mechanism must be used to tell the new
> > kernel that the "System RAM" in the memory map is not normal RAM.
> > 
> > Second, *if* we agree that some data must communicate across kexec, then
> > what mechanism should be used?  You're arguing for a new mechanism that
> > only new kernels can use.  I'm arguing that you should likely reuse an
> > existing mechanism (probably the UEFI/e820 maps) so that *ALL* kernels
> > can consume the information, old and new.
> > 
> 
> I'd answer yes, "System MAP" must be persisted across kexec.
> Could you elaborate on why there should be a mechanism to tell the
> kernel anything special about the existent "System map" in this context?
> Say, one can reserve a CMA region (or a crash kernel region, etc), store
> there some data, and then pass it across kexec. Reserved CMA region will
> still be a part of the "System MAP", won't it?

Well, I haven't gone through all the discusison thread and clearly got
your intention and motivation. But here I have to say there's
misunderstanding. At least I am astonished when I heard the above
description. Who said a CMA region or a crahs kernel region need be
passed across kexec. Think kexec as a bootloader, in essence it's no
different than any other bootloader. When it jumps to 2nd kernel, the
whole system will be booted up and reconstructed on the system resources.
All the difference kexec has is it won't go through firmware to do those
detecting/testing/init. If the intentionn is to preserve any state or
region in 1st kernel, you absolutely got it wrong.

This is not the first time people want to put burden on kexec because
of a specifica scenario, and this is not the 2nd time, and not 3rd time
in the recent 2 years. But I would say please think about what is kexec
reboot, what we expect it to do, whether the problem be fixed in its own
side.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681BDEEB566
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yH7lzrhU+IoX5wig7CpArQjlfrfbQIIn9jO99l4JGd8=; b=4i3kVSvSdlmBYo
	16PB2ouGm1n5a+3aipW1QauRTyzzuNGVwpwDit5Ybi5Urm+LQiITX5KC1LB9TnhWaAIPqI1dMu/EP
	BXeqqg7F9z87pXdRoW1yhSZjhQ045eKfri8OKR/DgVq6fedYy1wWdMJRXrwHZhMqKVn9NgGSv9G+d
	Z9PEU9gjqLmtMMeQz/vRJvyaisoZAvy7aqcpGmJeuusN9i4Ta4+CxMT7yn3n1IIzyFqbL2YonovJ3
	Myxv2vBphSSE7S9Cga1W79/ARMcr7+D/tzFJllf0zEsx3vmYQjYUkwnpeWQl0Yyp2RxnJZmM7qI5r
	9ZnxyeYIM74TV3PDj4MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sofIb-0000000COaP-2R4e;
	Thu, 12 Sep 2024 08:35:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sofIS-0000000COZK-3TdJ
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 08:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726130122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8n8VSjvILIl7oYC7bobYUFaIgZoDIf7snFAjTE/j5ps=;
	b=M+F9or9WUds4utjYqhcWCoTV1PVvY3izHXxl2ClJICe35l5WtP+RPLCKri12xzdLmPJIxP
	ox4NDCpOwKkhTHFR3p9ja7lrDL8dHiRcmXbwlqy4cpmSl/zaHpZvWh960t+Nx6d4oRt3V+
	k31smEjeNYpka4a5+iFQN4hvwon46Aw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-2BlVXIOmMKqAuDa4ttDdxw-1; Thu,
 12 Sep 2024 04:35:21 -0400
X-MC-Unique: 2BlVXIOmMKqAuDa4ttDdxw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78FAF1955D47;
	Thu, 12 Sep 2024 08:35:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95D0119560A3;
	Thu, 12 Sep 2024 08:35:17 +0000 (UTC)
Date: Thu, 12 Sep 2024 16:35:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, akpm@linux-foundation.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v2] kexec/crash: no crash update when kexec in
 progress
Message-ID: <ZuKnwcqv9xQDNOrl@MiWiFi-R3L-srv>
References: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
 <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
 <f4dcb6b4-2da8-4355-9d89-8b41af30214d@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4dcb6b4-2da8-4355-9d89-8b41af30214d@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_013524_960587_CA37A6C8 
X-CRM114-Status: GOOD (  21.79  )
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

On 09/12/24 at 01:33pm, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 11/09/24 19:50, Baoquan He wrote:
> > On 09/11/24 at 04:51pm, Sourabh Jain wrote:
> > > The following errors are observed when kexec is done with SMT=off on
> > > powerpc.
> > > 
> > > [  358.458385] Removing IBM Power 842 compression device
> > > [  374.795734] kexec_core: Starting new kernel
> > > [  374.795748] kexec: Waking offline cpu 1.
> > > [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > > [  374.935833] kexec: Waking offline cpu 2.
> > > [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > > snip..
> > > [  375.515823] kexec: Waking offline cpu 6.
> > > [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > > [  375.695836] kexec: Waking offline cpu 7.
> > > 
> > > To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
> > > are offline are brought online during kexec. For more information, refer
> > > to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
> > > kexec"). Bringing the CPUs online triggers the crash hotplug handler,
> > > crash_handle_hotplug_event(), to update the kdump image. Since the
> > > system is on the kexec kernel boot path and the kexec lock is held, the
> > > crash_handle_hotplug_event() function fails to acquire the same lock to
> > > update the kdump image, resulting in the error messages mentioned above.
> > > 
> > > To fix this, return from crash_handle_hotplug_event() without printing
> > > the error message if kexec is in progress.
> > > 
> > > The same applies to the crash_check_hotplug_support() function. Return
> > > 0 if kexec is in progress because kernel is not in a position to update
> > > the kdump image.
> > LGTM, thanks.
> > 
> > Acked-by: Baoquan he <bhe@redhat.com>
> 
> Thank you for the Ack!
> 
> My understanding is that this patch will go upstream via the linux-next
> tree, as it is based on
> https://lore.kernel.org/all/20240902034708.88EC1C4CEC2@smtp.kernel.org/
> which is already part of the linux-next master branch. - Sourabh Jain

Then you should mark it as [PATCH linux-next] in subject.

Since this patch is in generic code, it needs Andrew's help to
pick it. Let's wait and see if Andrew need a new post to change
the subject.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

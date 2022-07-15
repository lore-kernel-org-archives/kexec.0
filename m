Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA121C43334
	for <kexec@archiver.kernel.org>; Fri, 15 Jul 2022 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nWWbwkxSns9pp5GHfFvDOPC91eP6EG+7httod83YCp0=; b=UuZVBsCIkkyTBR
	U8EB/WcCNRJFKKuUNCdUVq9whZTuoKoXCUgSVAp5ARC3uB4XFy2F8O42WA+FlG9wMcLTLa2lJdkBk
	mr2XM3H3FUVVlCmWU5qUTvgzmxziFTpfjYQLow0DSXienB+ler/DwEHgzHwkfowwsMdjqLkgSEUat
	l1RkJugFeXAnPTTV5jBcUumW0I1MENvyEL9pooDa8ETk7Do8XRP2kAI1hzVFNxzI/0YRbMCkSCWJN
	oyEhqQWOuputgAEjjsA0uPTTxUrnNi9p54QoeZfYrM7QySGKvP+rV8J56dAw8voUxbn53vL1JKoK8
	+iUUQOPTdyBChfdiQRVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCACt-003FfG-6X; Fri, 15 Jul 2022 01:33:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCACr-003Fbw-2k
	for kexec@lists.infradead.org; Fri, 15 Jul 2022 01:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657848802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/U2xaa/vsw5f/HwUYz7caI2/KRVjJ8EhiCQx4+NJbM=;
	b=Zv9xrIMWRPqY5iW1GDTU+jAAvo+/nFi3dNYm1IW/wE7JcBwnujcr34YzIRI0MDmoYADl6x
	KS7lYkBwcYjo21M0Tvyhgj8jkHH8szZRjj2NPyX6zyHJlgoUKWy+t71Zw0/HeafuKPdYe3
	YB5GP2nFXE6/s0XwixeMIu54lte5iDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-RiRW-v7BNY69kwk-8B8ToA-1; Thu, 14 Jul 2022 21:33:20 -0400
X-MC-Unique: RiRW-v7BNY69kwk-8B8ToA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FF26800124;
	Fri, 15 Jul 2022 01:33:19 +0000 (UTC)
Received: from localhost (ovpn-13-91.pek2.redhat.com [10.72.13.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B1C2166B26;
	Fri, 15 Jul 2022 01:33:16 +0000 (UTC)
Date: Fri, 15 Jul 2022 09:33:13 +0800
From: Baoquan He <bhe@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org
Subject: Re: Unstable tsc caused soft lockup in kdump kernel
Message-ID: <YtDD2WHLiFbceXuE@MiWiFi-R3L-srv>
References: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
 <bf57256f-127d-6f26-404a-b9cff6df70b3@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf57256f-127d-6f26-404a-b9cff6df70b3@igalia.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_183325_236142_27D53155 
X-CRM114-Status: GOOD (  25.59  )
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

On 07/14/22 at 04:34pm, Guilherme G. Piccoli wrote:
> On 29/06/2022 07:25, Baoquan He wrote:
> > Hi,
> > 
> > On a HP machine, after crash triggered via sysrq-c, kdump kernel will
> > boot and get soft lockup as below. And this can be always reproduced.
> > 
> > From log, it seems that unreliable tsc was marked as unstable in
> > clocksource_watchdog, then worker sched_clock_work was scheduled. And
> > this tsc unstable marking always happened after sysrq-c is triggered.
> > And the cpu where worker smp_call_function_many_cond is running won't
> > be stopped and hang there and keep locks, even though the cpu should be
> > stopped. While kdump kernel is running in a different cpu and boot, then
> > soft lockup happened because other workers or the relevant threads are
> > waiting for locks taken by the hang sched_clock_work worker.
> > 
> > Any idea or suggestion?
> > 
> > The normal kernel boot log and kdump kernel log, kernel config, are all
> > attached, please check.
> > 
> 
> Hi Baoquan, interesting issue! Do you happen to have a full kdump boot
> log with the issue? Maybe collected through serial console, etc.
> It seems the one attached is from a succeeding kdump by passing
> "tsc=unstable" to the kdump kernel right?

The attached kdump boot log is the one in which kdump kernel is hang.
The 'tsc=unstable' need be added to 1st kernel to work around it. Only
adding 'tsc=unstable' into kdump kernel doesn't change anything since
the clocksouce_watchdog work has been in a loop because of the unstable
tsc in 1st kernel.

> 
> Also, did you try to "forbid" tsc to get marked as unstable in the first
> kernel, before kdump? I mean like a hack code change, just prevent
> kernel doing that and seeing if it works. If that still fails, then it
> seems the cause of the issue is the same as the cause of TSC getting
> unstable - in other words, something would be causing both the kdump
> kernel lockup AND the TSC unstable marking in the first kernel...

As I added later that adding 'tsc=unstable' into 1st kernel's cmdline can work
around the issue. kdump works well with that.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

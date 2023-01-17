Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A31C3DA78
	for <kexec@archiver.kernel.org>; Tue, 17 Jan 2023 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yPyPVHFxpRbR+scH8lUdTWFEVIAyFnTUM82FGyvZe2A=; b=eJ2HNMsXf7KfJu
	AHScuqDCimAnH7jI+vXmMVIXJp4xZGHCjVXuzA7tjcfUf+nnzM2ClEDML1Gp+XJQHRwxRU1e2qysl
	eS1VIxyqWdEzDn9yZSBwVNSIzpHqrskaQZ0ASw4ZlCvBrB/csJ/JB//xnUGDY3V1IJcquCwawSnGN
	8w/5ay5EPMz7GHCP23/Zap9fyI2lDOieRu/G9d1fptP2QfLIrZmg4qT4vbUf1f/4bk5yWp+syCvKW
	8pJIQMxZgWxgo71tIZHCnE4R8t+lh9L5TNEUmMzGTFxgrS2EZuEpksBc4wYUDk7D0HdsZQkGJH+o9
	bFc7gZh0xDfbKTF2O/NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHhJg-00DJr7-8i; Tue, 17 Jan 2023 08:27:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHhJd-00DJq5-Fx
	for kexec@lists.infradead.org; Tue, 17 Jan 2023 08:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673944052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gg7qkv1C1Ou83J3gkN1LzeHJIr1iBZFQETY1qPldk9s=;
	b=fJZPnmMPOWTWwKtqO1CsaxfxQGLs1e0TOzo/7C2Nc7hJ994O/P/apAM1C7ITg1MIdRelkr
	bjqzUHC8uLaqRbOJORLwrBcA2FieEVC2QFRd1wGpxMvOGz3DWrnNCppLYdLHVIJXuG+mAy
	i7kSSIuJNg5BqhxqIqNIEIkofNgwqD0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-nESQqZ6lMb2BsRB0SL1EKg-1; Tue, 17 Jan 2023 03:27:28 -0500
X-MC-Unique: nESQqZ6lMb2BsRB0SL1EKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D6D2858F09;
	Tue, 17 Jan 2023 08:27:28 +0000 (UTC)
Received: from localhost (ovpn-12-229.pek2.redhat.com [10.72.12.229])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A5173C15BA0;
	Tue, 17 Jan 2023 08:27:27 +0000 (UTC)
Date: Tue, 17 Jan 2023 16:27:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y8Zb696MT1E1p2jZ@fedora>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <87k01vjrnt.ffs@tglx>
 <Y7zMZ8nCNtSt09kV@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y7zMZ8nCNtSt09kV@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_002733_623616_99BF363D 
X-CRM114-Status: GOOD (  17.99  )
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

On 01/10/23 at 10:24am, Baoquan He wrote:
> On 01/09/23 at 10:59pm, Thomas Gleixner wrote:
> > On Tue, Dec 20 2022 at 13:34, Baoquan He wrote:
> > > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> > >
> > > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > > Implement IPI shorthands support") can fix it.
> > 
> > Is there any output on the early console or hangs it silently?
> > 
> > If the latter, can you attach GDB to the guest and figure out where it
> > is stuck?
> 
> No any output on the ealry console. I will try gdb debugging. Thanks.

I rebase to the latest upstream kernel and tested, the stable kdump
kernel hang disappear. Seems I need do another round of bisect to see
on which commit it's made to fix that. Will update if any progress.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

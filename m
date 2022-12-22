Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46AFC4332F
	for <kexec@archiver.kernel.org>; Thu, 22 Dec 2022 04:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QmA2XAwHQ+yl2NlbDAtr2SGE5u8hvtb1y+sObpJWq+w=; b=MyIdq1+QvwH/ME
	cSz4Ot4o0iWumXsQ9U1tSmGqt/chMgE4yICwERweHsMCK7tJO4dtmKWtE8rgMuBQSIMEWHQ3bTQQC
	cNdQUs8i89ebfWKzAF79mUJGrg37rwSWmVPBh+/sBr79hFkmvoq3SfMIJKTN6rqqR/nGGz6CnRtqK
	YufhsAyiARCL2JYP5e+Q+PMulJuR3/hSlUL9mWXcBcgQxXHoySsfWhttZ3d9609eC902ch4PqcaNr
	3tPgIzy0BUXvoL88oS7qaQKwzmaiybpj2AP16U9mV4JU5sJ4IgEu0bsyQ58MfW7OTJ+irFbYb1Aqs
	EmkEuhl3ISZiUsOMMvKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8CtV-006hdl-O4; Thu, 22 Dec 2022 04:09:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8CtS-006hbv-7K
	for kexec@lists.infradead.org; Thu, 22 Dec 2022 04:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671682157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZyafQqgBt7zn6f3VZzK00nebPDqAfKuXzcWmeIT/HE=;
	b=Sss3xcZAifRQE1MVmny532vIAwsFjwzzFpu20UsBHe6oFwBh2B9bW5rIgEGbpnkyq/DJlN
	YiUhKJk8r/pqc5hTZz9+wgA9mD42GqM8tLBOwj90Oig86OEm4CqeFcPmaLXunT8nHu2Yd2
	dkqkJo9J8RHrrIMoHBlBC/6ElXf95Yc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-8zmO4qUJPZen_wuY0c0Plg-1; Wed, 21 Dec 2022 23:09:13 -0500
X-MC-Unique: 8zmO4qUJPZen_wuY0c0Plg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA7311C02D35;
	Thu, 22 Dec 2022 04:09:09 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1672151E5;
	Thu, 22 Dec 2022 04:09:08 +0000 (UTC)
Date: Thu, 22 Dec 2022 12:09:05 +0800
From: Baoquan He <bhe@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: x86@kernel.org, kexec@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: kdump kernel randomly hang with tick_periodic call trace on bare
 metal system
Message-ID: <Y6PYYUKXR2OCH3WG@MiWiFi-R3L-srv>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6FK++b4buO5EgjD@MiWiFi-R3L-srv>
 <Y6FNTFbH9DbhEogg@MiWiFi-R3L-srv>
 <efe7e25e-8b05-90e7-fc02-4f1dc84fe324@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efe7e25e-8b05-90e7-fc02-4f1dc84fe324@igalia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_200918_387063_9921A08C 
X-CRM114-Status: GOOD (  17.31  )
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

On 12/21/22 at 12:46pm, Guilherme G. Piccoli wrote:
> On 20/12/2022 02:51, Baoquan He wrote:
> > On 12/20/22 at 01:41pm, Baoquan He wrote:
> >> On one intel bare metal system, I can randomly reproduce the kdump hang
> >> as below with tick_periodic call trace. Attach the kernel config for
> >> reference.
> > 
> > Forgot mentioning this random hang is also caused by adding
> > 'nr_cpus=2' into normal kernel's cmdline, then triggering crash will get
> > kdump kernel hang as below kdump log shown.
> > 
> 
> The weird thing is that you seem to be using "nr_cpus=1" instead - this
> is the cmdline from the log:
> 
> "nr_cpus=2 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off
> numa=off udev.children-max=2 panic=10 acpi_no_memhotplug
> transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0
> hugetlb_cma=0 disable_cpu_apicid=16 [...]"
> 
> You seems to pass twice the "nr_cpus" thing, and I guess kernel pick the
> last one?

From the kdump kernel boot log, yes, the nr_cpus=1 is taken. The
parse_early_param() will parse the kernel parameters one by one, then
the last one will take effect. Here, the problem is not at nr_cpus=2 or
1, the bare metal system has 16 cpus, only 2 cpus is present, it seems
to be the halted 14 cpus get wrong message and behave incorrectly to
cause the issue.

> 
> Also, what is "disable_cpu_apicid=16"? Could this be related?

Not really. Please check disable_cpu_apicid in
Documentation/admin-guide/kdump/kdump.rst, it's bsp's apic id.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

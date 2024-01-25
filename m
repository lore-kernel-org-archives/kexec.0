Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9351BC47258
	for <kexec@archiver.kernel.org>; Thu, 25 Jan 2024 04:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Y7xd07nrY6vR9IKcY3NOCDdA3HHUjob6f5PeP2j7FM=; b=KQOOyGt6viFoAw
	UPqxcgMYG0mlOgEFoymk/jbj/707J+RTgp8PHAFEluS0rZ5AA4X6LJxy2se2i3qb2MCx+ZGASEMYk
	vZ6ej4q7lVcgkDxvvXAi/tba50d8EARZ6FWHoNbQOlJNBku2/xzbX4W4PLhCSFqdo7OJDseM+v7qe
	q1z/J+5eJk2Qpg4/VRyiXs76orFXfBWLl6XSXMaviqUl2n5oi31KD/hCKb0bvPjatMrU7p9msc9Si
	yBMYLy8ZoPcvRV5w1kOqwLaDUrJrOvRkrXVuoEi80oPoTFCudNBnlhr+kK9naU75PbR5ktFEWP717
	ZLfgqQGbSc6tDgfl4/KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSr3r-006CY7-1w;
	Thu, 25 Jan 2024 04:09:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSr3o-006CVF-08
	for kexec@lists.infradead.org;
	Thu, 25 Jan 2024 04:09:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706155786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWkqIM1QddKJmlHq/W4wKL7ORpJYC0uhF5yya8pqsJ8=;
	b=KnzFqjXfvgOwKfaeyy8s22EhbzCi9vt/aaOTuLS1OKTM30Dqriqqj26JL49EkWbE0fxEOb
	pGya8gGio+69UlhpY90RPmz18pqBraP9ARxcb47jgQiBNrw+5uhoKHOhtEPS/VVsLCxeCo
	5X+0NSsxNzqBScpxtYh6L17fea5z+ic=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-AvLrlMuiMWWq7ooKHP2nsQ-1; Wed,
 24 Jan 2024 23:09:41 -0500
X-MC-Unique: AvLrlMuiMWWq7ooKHP2nsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7936A38143C1;
	Thu, 25 Jan 2024 04:09:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F7F40C1430;
	Thu, 25 Jan 2024 04:09:39 +0000 (UTC)
Date: Thu, 25 Jan 2024 12:09:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"piliu@redhat.com" <piliu@redhat.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH linux-next v3 06/14] x86, crash: wrap crash dumping code
 into crash related ifdefs
Message-ID: <ZbHfACpwqi2U9vmK@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-7-bhe@redhat.com>
 <SN6PR02MB4157931105FA68D72E3D3DB8D47B2@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157931105FA68D72E3D3DB8D47B2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_200952_213709_8E84506D 
X-CRM114-Status: GOOD (  22.25  )
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

On 01/24/24 at 11:02pm, Michael Kelley wrote:
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c
> > b/arch/x86/kernel/cpu/mshyperv.c
> > index 01fa06dd06b6..f8163a59026b 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -210,6 +210,7 @@ static void hv_machine_shutdown(void)
> >  		hyperv_cleanup();
> >  }
> > 
> > +#ifdef CONFIG_CRASH_DUMP
> >  static void hv_machine_crash_shutdown(struct pt_regs *regs)
> >  {
> >  	if (hv_crash_handler)
> > @@ -221,6 +222,7 @@ static void hv_machine_crash_shutdown(struct
> > pt_regs *regs)
> >  	/* Disable the hypercall page when there is only 1 active CPU. */
> >  	hyperv_cleanup();
> >  }
> > +#endif
> >  #endif /* CONFIG_KEXEC_CORE */
> 
> Note that the #ifdef CONFIG_CRASH_DUMP is nested inside
> #ifdef CONFIG_KEXEC_CODE here, and in the other Hyper-V code
> just below.   It's also nested in xen_hvm_guest_init() at the bottom
> of this patch.  But the KVM case of setting crash_shutdown is
> not nested -- you changed #ifdef CONFIG_KEXEC_CORE to #ifdef
> CONFIG_CRASH_DUMP.
> 
> I think both approaches work because CONFIG_CRASH_DUMP implies
> CONFIG_KEXEC_CORE, but I wonder if it would be better to *not* nest
> in all cases.  I'd like to see the cases be consistent so in the future
> someone doesn't wonder why there's a difference (unless there's
> a reason for the difference that I missed).

I agree with you, it's a great suggestion. Thanks.

Do you think below draft patch includes all changes you are concerned
about?

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f8163a59026b..2e8cd5a4ae85 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -209,6 +209,7 @@ static void hv_machine_shutdown(void)
 	if (kexec_in_progress)
 		hyperv_cleanup();
 }
+#endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
 static void hv_machine_crash_shutdown(struct pt_regs *regs)
@@ -222,8 +223,7 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	/* Disable the hypercall page when there is only 1 active CPU. */
 	hyperv_cleanup();
 }
-#endif
-#endif /* CONFIG_KEXEC_CORE */
+#endif /* CONFIG_CRASH_DUMP */
 #endif /* CONFIG_HYPERV */
 
 static uint32_t  __init ms_hyperv_platform(void)
@@ -497,9 +497,11 @@ static void __init ms_hyperv_init_platform(void)
 	no_timer_check = 1;
 #endif
 
-#if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_KEXEC_CORE)
+#if IS_ENABLED(CONFIG_HYPERV)
+#if defined(CONFIG_KEXEC_CORE)
 	machine_ops.shutdown = hv_machine_shutdown;
-#ifdef CONFIG_CRASH_DUMP
+#endif
+#if defined(CONFIG_CRASH_DUMP)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
 #endif
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 1287b0d5962f..f3130f762784 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -826,7 +826,7 @@ void machine_halt(void)
 	machine_ops.halt();
 }
 
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	machine_ops.crash_shutdown(regs);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

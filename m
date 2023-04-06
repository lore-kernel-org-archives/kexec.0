Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45839C76196
	for <kexec@archiver.kernel.org>; Thu,  6 Apr 2023 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EJSLM/7fFvoJn+185Hf4QwNAC3USK6JjxgJ3UB5Q84=; b=n06v4tDq1UQ+66
	u9omORSthJhFXF9BCphzeN2sOxvmOmhUbPvs3jabkKRdKAHtPfmYA6K7Qze3r2JFooZiXzkPagiGV
	HNJNPQ1+p7W5+wF0sI95an95ClkdkrdrdK7pvFVV6su0noVFig3e5Zzjgkr7qKMAFkaHbhAo8l+wq
	16blXc1y5OgQI8AaalxwHK239yAZuRUdh4z+1l1tuS8aTT0K/LbDjg7Skz6uPAcuhxWJcQs7R2RAp
	C3E8x9YAOE8S26t0noKM7w+nGvD1zAssYa4p3sDM4FzBfc9QTfVfQEoE6L+qzAkBfBXMqhKZC8Dol
	pi9oBPhDkFlh09pNse/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkZV8-008rBh-0G;
	Thu, 06 Apr 2023 23:58:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkZV4-008rAq-0Q
	for kexec@lists.infradead.org;
	Thu, 06 Apr 2023 23:58:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680825520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFDqnzDNSLjp3pxSVrwV7aOd+4k4yJ1snm/13Jprst4=;
	b=CjkfMMVCRhNTJr3nOIHiU3PVZ7zfgWi3KLXx8dOgh9nePETlGUUBKRa17lx6MjVKRaSKFw
	v8yHkKHxduQoyrffI+1ukBMxUgLbxs/kMu3uz8HZG9n/Rg31ijl5AV6/wS4B5ETT7/jDkZ
	RrSi805/22kqptwTLARipHLfI8uQj+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-QClurESXN1SjjlcoxeaNlw-1; Thu, 06 Apr 2023 19:58:37 -0400
X-MC-Unique: QClurESXN1SjjlcoxeaNlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A98785C069;
	Thu,  6 Apr 2023 23:58:36 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CC8CD18EC6;
	Thu,  6 Apr 2023 23:58:34 +0000 (UTC)
Date: Fri, 7 Apr 2023 07:58:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v21 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZC9cp5RLyNNx0DMG@MiWiFi-R3L-srv>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-3-eric.devolder@oracle.com>
 <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
 <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_165842_248780_94E75E12 
X-CRM114-Status: GOOD (  30.60  )
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

On 04/06/23 at 11:10am, Eric DeVolder wrote:
> 
> 
> On 4/6/23 06:04, Baoquan He wrote:
> > On 04/04/23 at 02:03pm, Eric DeVolder wrote:
> > ......
> > > +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> > > +{
> > > +	struct kimage *image;
> > > +
> > > +	/* Obtain lock while changing crash information */
> > > +	if (!kexec_trylock()) {
> > > +		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/* Check kdump is not loaded */
> > > +	if (!kexec_crash_image)
> > > +		goto out;
> > > +
> > > +	image = kexec_crash_image;
> > > +
> > > +	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> > > +		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> > > +		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> > > +	else
> > > +		pr_debug("hp_action %u\n", hp_action);
> > 
> > Seems we passed in the cpu number just for printing here. Wondering why
> > we don't print out hot added/removed memory ranges. Is the cpu number
> > printing necessary?
> > 
> Baoquan,
> 
> Ah, actually until recently it was used to track the 'offlinecpu' in this
> function, but tglx pointed out that was un-necessary. That resulted in
> dropping the code in this function dealing with offlinecpu, leaving this as
> its only use in this function.
> 
> The printing of cpu number is not necessary, but helpful; I use it for debugging.

OK, I see. I am not requesting memory range printing, just try to prove
cpu number printing is not so justified. If it's helpful, I am OK with
it. Let's see if other people have concern about this.

> 
> The printing of memory range is also not necessary, but in order to do that,
> should we choose to do so, requires passing in the memory range to this
> function. This patch series did do this early on, and by v7 I dropped it at
> your urging (https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/).
> At the time, I provided it since I considered this generic infrastructure,
> but I could not defend it since x86 didn't need it. However, PPC now needs
> this, and is now carrying this as part of PPC support of CRASH_HOTPLUG (https://lore.kernel.org/linuxppc-dev/20230312181154.278900-6-sourabhjain@linux.ibm.com/T/#u).
> 
> If you'd rather I pickup the memory range handling again, I can do that. I
> think I'd likely change this function to be:
> 
>   void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>      struct memory_notify *mhp);
> 
> where on a CPU op the 'cpu' parameter would be valid and 'mhp' NULL, and on a memory op,
> the 'mhp' would be valid and 'cpu' parameter invalid(0).
> 
> I'd likely then stuff these two parameters into struct kimage so that it can
> be utilized by arch-specific handler, if needed.
> 
> And of course, would print out the memory range for debug purposes.
> 
> Let me know what you think.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

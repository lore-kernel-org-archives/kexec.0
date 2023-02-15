Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4158CC05027
	for <kexec@archiver.kernel.org>; Wed, 15 Feb 2023 01:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3nMbxr9e0n07/wV9jlx2bBb8Yy6vNwHpF0sWzM/zRrg=; b=PhXmQLA714NyEu
	6A152X8IGyO/UvcStcTFSGyoa1S//TTQxyD/nQjV7F2/zuhN2pxNAGg85+tBrE/HgiXaoiEETtPt7
	hu3+Hf3FyJQczwib8IoovkWgVeaFLm4cYdXZne7Q73K6M0fEisuF1J/FhzY9oD2lL5XAZxI/7gSzu
	k21P5c9iELDc76HaqkGdQkwhIQixoeheI1oyebi/GcDEAl3Dbt8RAherHQhccxuIHgtfVRXqjX7py
	+ms5MmewkjpRtg2isJ6y2v9FcCJ/jA0ldSRbEwEUmLTyQ1zP/vCujIu6aIv0nVp7A9+I2/QZFLGYo
	dKGZQ1ja7oG/kfM6rOVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6B6-0047Up-1x; Wed, 15 Feb 2023 01:01:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6B2-0047S5-7s
	for kexec@lists.infradead.org; Wed, 15 Feb 2023 01:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676422895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNC4MqEUDW2/mIdiDF3kH441RIGy+JSKPjHydADHWoo=;
	b=eHznKPV12uRfnGCLq4sxPNOrsAUsWzwtWj3XBT0rlJYmLvA06lHn18ZT2tJnhGQ2UDTl2g
	JFHAB6OYhm/jzPhlENsnPmMBeAqWLz4pDDuvwxzrqx2sCn0Qy9JQ4KlbrB3rWfODHRxr5V
	jB3ceW0/WodF8b0ZOelNDidFQyWv2BA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-SvhBT2YXNY66LFZumx3wCw-1; Tue, 14 Feb 2023 20:01:30 -0500
X-MC-Unique: SvhBT2YXNY66LFZumx3wCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA13B2805593;
	Wed, 15 Feb 2023 01:01:29 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF30492B03;
	Wed, 15 Feb 2023 01:01:28 +0000 (UTC)
Date: Wed, 15 Feb 2023 09:01:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zeng Heng <zengheng4@huawei.com>, mingo@redhat.com, bp@alien8.de,
	jroedel@suse.de, vbabka@suse.cz, hpa@zytor.com, tglx@linutronix.de,
	eric.devolder@oracle.com, tiwai@suse.de, keescook@chromium.org,
	dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, liwei391@huawei.com, xiexiuqi@huawei.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH v3] x86/kdump: Handle blocked NMIs interrupt to avoid
 kdump crashes
Message-ID: <Y+wu5UJTzVIYrsbK@MiWiFi-R3L-srv>
References: <20230202014053.3604176-1-zengheng4@huawei.com>
 <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
 <e57ba121-5bcc-e63b-691d-3e3d998e9e48@huawei.com>
 <Y+tZE8ixmlIDYrOu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+tZE8ixmlIDYrOu@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_170140_381205_49D035EC 
X-CRM114-Status: GOOD (  18.39  )
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

Add kexec list to CC.

On 02/14/23 at 10:49am, Peter Zijlstra wrote:
> On Tue, Feb 14, 2023 at 05:30:46PM +0800, Zeng Heng wrote:
> 
> > > I never remember the shutdown paths -- do we force wipe the PMU
> > > registers somewhere before this?
> > 
> > I have checked the panic process, and there is no wipe operation for PMU
> > registers,
> > 
> > which causes the watchdog bites.
> > 
> > Do you mean we should directly disable PMU registers instead of calling
> > `iret_to_self` to
> > 
> > consume blocked NMI interrupts ?
> 
> If you don't wipe the PMU, there will be many and continuous NMIs, a
> single IRET-to-SELF isn't going to safe you.
> 
> Anyway, I had a bit of a grep around and I find we have:
> 
>   kernel/events/core.c:   register_reboot_notifier(&perf_reboot_notifier);
> 
> which should end up killing all the PMU activity. Somewhere around there
> there's also a CONFIG_KEXEC_CORE ifdef, so I'm thinking it gets called
> on the panic->crash-kernel path too?

No, reboot_notifier_list is only handled in kexec reboot/reboot path,
please see kernel_restart_prepare() invocation. Kdump path only shutdown
key component like cpu, interrupt controller.

> 
> If not, someone should look at doing something there.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B4BC4167B
	for <kexec@archiver.kernel.org>; Tue, 20 Dec 2022 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YUnY1tuyyYVgDML9u4c1hHBmSQGfqd83y9+LwLh0eqU=; b=D4MWf1+H4aQXyy
	jGWxt0nt4YpWcX5QIKlFR76bjEYiFNND0kLSXHseGGXpkzzXQvphQZfIpBnKivkstKbT73A4KFJpb
	2MwZNA/Sl4i7hHwYMTUpghNIO/cJreJdMgyd12VbY3QDUC7HZBOw2Om61s5FdlQ4K1ukHOpV8sJ5l
	ruEpuIH1WuH13ZvIrIy/THmHkpdZv2dY+Vk9itxUiBC9jn9fO64e7w2/p+MG6dSyfTGy0e/holaTT
	xrQbP2av5aXODmjHdV8BTCc6k6eY1C5YndPE17pUxkoiGAvuORQZ3O3hHzNy+Ia6XU4oEzJnko75w
	wLtDjrDdFmOKb1hYudfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7bta-00Ex8P-T0; Tue, 20 Dec 2022 12:38:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7btT-00Ewy0-GE
	for kexec@lists.infradead.org; Tue, 20 Dec 2022 12:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671539930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YGLPYrhUM3liQYpN3p/+bDVBoiicBenOmdXkygbdC0=;
	b=ZofDCtM9217rEe1oEmKfLTzu6VqEVqy5ahDNJFewvpLugh993UzGBFtaqL/ad1h/tj8Ox5
	aGcxJ9NHQLBTGbf9OTnWXHR+Dj1LZhjYXDlKwTeGw85JkQFUJMX5cBWyieDJUoo/AUudYw
	KMMO2suKkZjQ/bK+lBYENDSa6vQ9NWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-hvM0dMytMiWl0AERQdiC_g-1; Tue, 20 Dec 2022 07:38:44 -0500
X-MC-Unique: hvM0dMytMiWl0AERQdiC_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04002183B3C3;
	Tue, 20 Dec 2022 12:38:44 +0000 (UTC)
Received: from localhost (ovpn-12-53.pek2.redhat.com [10.72.12.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30D8240C201B;
	Tue, 20 Dec 2022 12:38:42 +0000 (UTC)
Date: Tue, 20 Dec 2022 20:38:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org, kexec@lists.infradead.org, dgilbert@redhat.com
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y6Gsz4mqnZCtC9rn@MiWiFi-R3L-srv>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_043851_655174_E10F5CBF 
X-CRM114-Status: GOOD (  15.46  )
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

On 12/20/22 at 12:38pm, Peter Zijlstra wrote:
> On Tue, Dec 20, 2022 at 01:34:58PM +0800, Baoquan He wrote:
> > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> > 
> > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > Implement IPI shorthands support") can fix it.
> > 
> > The problem will disappear if removing 'nr_cpus=2' from normal kerne's
> > cmdline.
> 
> And the root cause for this is... ? Does the kvm x2apic emulation
> somehow get upset when we shorthand CPUs that haven't been initialized?

Thanks for checking.

I haven't figure out the root cause. I haven't read the apic code for
long time, and not familiar with the kvm code. So raise the issue to
upstream.

I can do testing if any suggestion.

Add our virt dev Dr. David Alan Gilbert to CC.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

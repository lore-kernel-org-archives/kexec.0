Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92565C5479D
	for <kexec@archiver.kernel.org>; Tue, 10 Jan 2023 02:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3vWqhYBhqJNC92QXFgyVDM8H4VC0p8XwKUarbh42+H4=; b=RWDYf07qkdRD4V
	XRsYrTsdbOGVN8IQHe1cKRzVkXNOFcxi6kt+ciE1AJXi+m12+hog43AWWZ/Bid5va8rIdbr/0Pdoo
	Gdmf5OPYHrmFcqV79J12INRucUV33Jg8voEOuYuXyz3YcFPAp8NB/93uiUucivJLJDK7itmh+0CVK
	9f90EmexYhw64PRqoM9D9lx+768n+CfT7V/iOP4M4zgfpe5q8ZsrmHcEtX1x/eI8i8PenJPTPQvyY
	eyecgwk1MI60GW+Gf1ZYJ34g5q0ffH5w30EiVQf+rblrZ3a8+FoZLFzHA0LAU/S4jrJHDXDSC6ANW
	A2HEa+R/3uVQMqw4133A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF4Jr-004yRt-Pd; Tue, 10 Jan 2023 02:24:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF4Jo-004yQY-FD
	for kexec@lists.infradead.org; Tue, 10 Jan 2023 02:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673317487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odciY+9+EikNajE585hIA5zUDol7M/v4VgDdpw0aLYY=;
	b=HVSSokT6hc5dGk+Q8ZOFuThkHGtZr+8Jgt31PDdATUG6CNI78ekzXh1BppySQE37RrL52Y
	gEjVy8u5Dhz9RIqLOxssFNjMGl08YDZaw2S6cC9Kp9zvntK4EjjXjGVt5KYSWaVpmUWsCD
	7VxmkQ3HS0v7BOoy2dSGBRSNb0WIH2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-RNpvsEVsPr-9Y50zhF9Krg-1; Mon, 09 Jan 2023 21:24:44 -0500
X-MC-Unique: RNpvsEVsPr-9Y50zhF9Krg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AEE2811E9C;
	Tue, 10 Jan 2023 02:24:43 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E0C1A175AD;
	Tue, 10 Jan 2023 02:24:42 +0000 (UTC)
Date: Tue, 10 Jan 2023 10:24:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y7zMZ8nCNtSt09kV@fedora>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <87k01vjrnt.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k01vjrnt.ffs@tglx>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_182452_617725_A43C7D16 
X-CRM114-Status: GOOD (  14.37  )
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

On 01/09/23 at 10:59pm, Thomas Gleixner wrote:
> On Tue, Dec 20 2022 at 13:34, Baoquan He wrote:
> > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> >
> > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > Implement IPI shorthands support") can fix it.
> 
> Is there any output on the early console or hangs it silently?
> 
> If the latter, can you attach GDB to the guest and figure out where it
> is stuck?

No any output on the ealry console. I will try gdb debugging. Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

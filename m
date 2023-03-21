Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CBDC6FD1D
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 02:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gwa5sjKyU7yhhUEUuMyv0nvL9PZaprNjUpP5gjDsFPI=; b=12y5itfWMzu4mj
	mR4NVYDPyVci3enOFIfX2yuH+pOFG+y+SYuzztGHq3+Y48hkE6XP3lV1eMizRjmr5tVAf13PfYPrs
	XKQlw3SOQYAU+v9iEd9t7E864WDv/1vcnvfBOeUcTYetbwfYCDMXH4oNOX6df/Z+42aXZR/sN1pHo
	Qbm7T3hnL3Bi6Z5z/jzeDmXUcPbuvDs7VPBu5gLLZcXUYLts+JWnyd3366GV5yHL3bNzIP2npDcZ2
	f4/ZJ6aPh8SCPX4OE5ZmO9CWu6R4vXbJQPpa3iROoAodyA2p7kA3Jbjx7sZ/SqkPGWzIZB09mT/oN
	G8byQUX4MtsOa0KyIBhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peRli-00B10d-2y;
	Tue, 21 Mar 2023 02:30:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peRlg-00B104-1G
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 02:30:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679365831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8Jw9Nr2e+wCPq9TDRMSOjtClj7zVlNFMHhVGtvKL/k=;
	b=RAhsnQbvYO3OF/tqyDjPrOTmvnZSqhw7BZnZ5IlJXhlufVzoKU93nmNkff9aNqDLEfRcCH
	D/YnO5b6+dgE7E4gVl53VkV//38srE1ox5LU+TlbmC4C0wOY7chYStVonuQpubFhsjrbzs
	V7tXvZE3QDcme1EKPAOz1S/dppxJE+k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-PCJeYWObP0CHigoWpsJiTA-1; Mon, 20 Mar 2023 22:30:25 -0400
X-MC-Unique: PCJeYWObP0CHigoWpsJiTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0308299E746;
	Tue, 21 Mar 2023 02:30:24 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B6F18EC2;
	Tue, 21 Mar 2023 02:30:23 +0000 (UTC)
Date: Tue, 21 Mar 2023 10:30:17 +0800
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
Subject: Re: [PATCH v20 2/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBkWub0rTMp2+kxd@MiWiFi-R3L-srv>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
 <20230317212128.21424-3-eric.devolder@oracle.com>
 <ZBgVjjZdiEA5YxQX@MiWiFi-R3L-srv>
 <12fa9836-4ddd-2961-7d32-4754506c84ae@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12fa9836-4ddd-2961-7d32-4754506c84ae@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_193032_504202_C8B733C3 
X-CRM114-Status: GOOD (  24.16  )
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

On 03/20/23 at 10:06am, Eric DeVolder wrote:
> 
> 
> On 3/20/23 03:13, Baoquan He wrote:
> > On 03/17/23 at 05:21pm, Eric DeVolder wrote:
> > ......
> > > @@ -697,3 +700,137 @@ static int __init crash_save_vmcoreinfo_init(void)
> > >   }
> > >   subsys_initcall(crash_save_vmcoreinfo_init);
> > > +
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt) "crash hp: " fmt
> > > +/*
> > > + * To accurately reflect hot un/plug changes of cpu and memory resources
> > > + * (including onling and offlining of those resources), the elfcorehdr
> > > + * (which is passed to the crash kernel via the elfcorehdr= parameter)
> > > + * must be updated with the new list of CPUs and memories.
> > > + *
> > > + * In order to make changes to elfcorehdr, two conditions are needed:
> > > + * First, the segment containing the elfcorehdr must be large enough
> > > + * to permit a growing number of resources; the elfcorehdr memory size
> > > + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> > > + * Second, purgatory must explicitly exclude the elfcorehdr from the
> > > + * list of segments it checks (since the elfcorehdr changes and thus
> > > + * would require an update to purgatory itself to update the digest).
> > > + */
> > > +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> > > +{
> > > +	/* Obtain lock while changing crash information */
> > > +	if (!kexec_trylock())
> > > +		return;
> > > +
> > > +	/* Check kdump is loaded */
> > > +	if (kexec_crash_image) {
> > 
> > Here, what I mean is:
> > 
> > 	/* Obtain lock while changing crash information */
> > 	if (!kexec_trylock())
> > 		return;
> > 
> > 	/*If kdump is not loaded*/
> > 	if (!kexec_crash_image)
> > 		goto out;	
> > 
> > Then we reduce one tab of indentation for the following code block, e.g
> > the for loop block will have smaller pressure on breaking the 80 chars
> > limitation.
> > 
> 
> Ah, yes, ok. I'll make that change. Do you prefer I post that soon, or give this v20 some more time?

Yeah, giving v20 a while for reviewing sounds great. After all this
is only programming style issue. Other than this, the overall looks good
to me, let's wait and see what other people's concern, esp x86
maintainer's opinion.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

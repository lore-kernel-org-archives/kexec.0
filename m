Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB70CC7619A
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 23:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TvKqH0KquPvAYexY8ThhsWeExulfkt+ydgPG7opctBM=; b=rsoB2XNji4jHYa
	bTHV2WDmOaqdhj+Ycll0Glw9n7oz40UraB/po3J5DM8Yxc+8l6jvF/OvBKg27BEV5zeVxZZaprQES
	8thzboF6s+YBmY4+d6EsXCmnKgEepnl8kN63MyjPUeaNt1SQvPFuk0BraHGj1rj+T6U3uSwLBjez6
	vQvl+c6fNb6Qcp/SBnqck5BhKOn1/fKnJtxuFvr2iz/1LkZyUWJOYwlBMZ/iZZpEEDnCBm2QsjCa5
	4zSspP4M5FVyUaoOk44o4688CZczUSWHF6bOZRKOT67pDfn76NapCKf1QT3mV6tXz+pA3vlf1eN1k
	QdAleComIDrxFj3QrqHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi1lX-005LSc-2i;
	Thu, 30 Mar 2023 23:33:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi1lT-005LR8-2y
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 23:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680219185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFKIO15sTpdAt8JGYcoib0o9EwbibSfqk1NxeizxC3g=;
	b=eYBqx32dwJ51PvXswo46Vr+FZDShVrtp70X8HF4naNcVclexcPclfFsK7qXqYTWXG0h3t5
	VmCF63OjoSMih8wD6aD4tEweF0o8pGaC/WH9RmJgGwshVXjQsiP84DDE12F9TyoKV93P4P
	a/Lkmrhh68q2AVpXRZN2fqYXRxGEZlM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-KMXxKy-dMLmNmEpxqNMX8w-1; Thu, 30 Mar 2023 19:33:01 -0400
X-MC-Unique: KMXxKy-dMLmNmEpxqNMX8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 625BB3C0F231;
	Thu, 30 Mar 2023 23:33:00 +0000 (UTC)
Received: from localhost (ovpn-12-64.pek2.redhat.com [10.72.12.64])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F368202701E;
	Thu, 30 Mar 2023 23:32:58 +0000 (UTC)
Date: Fri, 31 Mar 2023 07:32:54 +0800
From: Baoquan He <bhe@redhat.com>
To: "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
	bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
	atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZCYcJos4MLBvpP9/@MiWiFi-R3L-srv>
References: <20230328115150.2700016-1-chenjiahao16@huawei.com>
 <20230328115150.2700016-2-chenjiahao16@huawei.com>
 <ZCQewkvSpaI52DSM@MiWiFi-R3L-srv>
 <b8a32e3c-c083-20de-16d1-f628b02b739b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b8a32e3c-c083-20de-16d1-f628b02b739b@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_163308_032406_E1E26429 
X-CRM114-Status: GOOD (  20.72  )
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

On 03/30/23 at 09:40pm, chenjiahao (C) wrote:
......
> Agreed, I will clean this up later in next version.
> > > +		if (ret || !crash_size)
> > > +			return;
> > > +
> > > +		/*
> > > +		 * crashkernel=Y,low is valid only when crashkernel=X,high
> > > +		 * is passed and high memory is reserved successful.
> > > +		 */
> > > +		ret = parse_crashkernel_low(boot_command_line, 0, &crash_low_size, &crash_base);
> > > +		if (ret == -ENOENT)
> > > +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > > +		else if (ret)
> > > +			return;
> > > +
> > > +		search_start = dma32_phys_limit;
> > > +	} else if (ret || !crash_size) {
> > > +		/* Invalid argument value specified */
> > >   		return;
> > > +	}
> > >   	crash_size = PAGE_ALIGN(crash_size);
> > > @@ -1201,16 +1246,26 @@ static void __init reserve_crashkernel(void)
> > >   	 */
> > >   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> > >   					       search_start,
> > > -					       min(search_end, (unsigned long) SZ_4G));
> > > +					       min(search_end, (unsigned long)dma32_phys_limit));
> > >   	if (crash_base == 0) {
> > The above conditional check isn't right. If crashkernel=size@offset
> > specified, the reservation failure won't trigger retry. This seems to be
> > originally introduced by old commit, while this need be fixed firstly.
> 
> Just a little curious about the rule to cope with this specific case. If
> "crashkernel=size@offset" was passed
> 
> but reserve failed, should try again to allocate in high memory, regardless
> the specified size@offset,
> 
> or just throw a warning and return? Since I noticed the current logic here
> on Arm64 is to check if !fixed_base first

Yeah, we need mark the "crashkernel=size@offset" case and avoid to
retry. Because you won't succeed if  memblock has already failed to
reserve an unavailable memory region, retry is meaningless. This has
been done in x86, arm64.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

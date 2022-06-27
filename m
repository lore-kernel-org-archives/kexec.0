Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDEAC43334
	for <kexec@archiver.kernel.org>; Mon, 27 Jun 2022 02:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W7KiOdnXEUp5f98nu16t7OPRgQ8eCt1DAkvOx84fLoc=; b=zK0GBGfdfL44DO
	pqhu6Hurls6LVYYbUOROaGbdr92a7lbweVa9JhKVXh/uALixzh1pPVlq0De959hjC7666Txn5OeFd
	lBFhJXyxk5XPlnUjip7EBbNpu4YC0ttIg+Rtc/TCQqYdRo5ExIdh3AzmPzJKOf5XfeMZjQJqvAr4T
	RpxA+UMVRlK4AjcMJ7rWFYH5TzxFe3zXCxkqzck0jrHLHa+uA+4s8SIJq4HS+uESj+29GJR55ZMMs
	gF3+AbF05k97bMhm8ljnnlJgLJfC7iTRgmN4GkVgGEWLCkl6fTWHc3LcizuixziQ9Q7bPX2xkyEQ5
	xRNU91OH1m8havZX6kAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5erj-00EnKd-Kj; Mon, 27 Jun 2022 02:52:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5erd-00EnHo-NC
	for kexec@lists.infradead.org; Mon, 27 Jun 2022 02:52:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656298356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JakvLevS0YnBGyhibLY4QkJ72ieVyrb1/yRcRNc1BYw=;
	b=jNCD/kYs9UsjI6vXvS20lyqAhrDHrtzj+h7FZqI1c+09SbtCU6xd2XWxTLjE4YFr7+XJDA
	e3UqdTdJ3uFvf52u5vLaARzjyyu330MPXc0AGpHalNszSX4C6ZM4NNa0YWAZG2tigpBIPs
	KaIARRyAp0ZT14ycgoWqWlURPCf5CCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-3tZgnw0DPyKkAw1P9ym7bg-1; Sun, 26 Jun 2022 22:52:32 -0400
X-MC-Unique: 3tZgnw0DPyKkAw1P9ym7bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B95D811E75;
	Mon, 27 Jun 2022 02:52:31 +0000 (UTC)
Received: from localhost (ovpn-13-65.pek2.redhat.com [10.72.13.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B0D6F40CFD05;
	Mon, 27 Jun 2022 02:52:29 +0000 (UTC)
Date: Mon, 27 Jun 2022 10:52:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	liushixin <liushixin2@huawei.com>
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Message-ID: <Yrkbak66vYT55H4x@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
 <YrRzvO5F0dumsbAU@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YrRzvO5F0dumsbAU@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_195237_952001_3CE44843 
X-CRM114-Status: GOOD (  26.36  )
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

On 06/23/22 at 03:07pm, Catalin Marinas wrote:
> On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
> > On 06/21/22 at 07:04pm, Catalin Marinas wrote:
> > > The problem with splitting is that you can end up with two entries in
> > > the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
> > > for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
> > > abort (but can be worse like loss of coherency).
> > 
> > Thanks for this explanation. Is this a drawback of arm64 design? X86
> > code do the same thing w/o issue, is there way to overcome this on
> > arm64 from hardware or software side?
> 
> It is a drawback of the arm64 implementations. Having multiple TLB
> entries for the same VA would need additional logic in hardware to
> detect, so the microarchitects have pushed back. In ARMv8.4, some
> balanced was reached with FEAT_BBM so that the only visible side-effect
> is a potential TLB conflict abort that could be resolved by software.

I see, thx.

> 
> > I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
> > have different bootup time. And the more often TLB miss and flush will
> > cause performance cost. It is really a pity if we have very powerful
> > arm64 cpu and system capacity, but bottlenecked by this drawback.
> 
> Is it only the boot time affected or the runtime performance as well?

Sorry for late reply. What I observerd is the boot time serious latecy
with huge memory. Since the timestamp is not available at that time,
we can't tell the number. I didn't notice the runtime performance.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

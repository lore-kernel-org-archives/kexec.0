Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54034C433EF
	for <kexec@archiver.kernel.org>; Mon, 27 Jun 2022 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tzZj0GX+1LNVarcI4XmQP/mrFF86T+BG2Meyg1qk+Ik=; b=b3wLrKxBJiMoKE
	YLtAW7Y7/iqWBAriuFDh7LqGaIiIGm6ZJNnKpzIHwsWXJ6MRSTmNoq8P9dfmz5GECaFTrenkpUM+o
	aQyLdcNXiOeOBXe+NUh5joSumPCohrTz7OO2RADGZo3NAGWpzzWlhYisi9fUI2YPdgVkTB3RHbk4B
	mTv2jvF4TkVl9UxXzfdHidIv+dN9k2UI4BIp7TSZELyVLBYWIuGsvf1/Oo0JSgrlBeMVgv+3THEmY
	wEcXeps9gQnfAPXIRBo6l75Iu3glpXj/Rpub+prEfE9YAB5EgOIq4GAtH8hZhsBxvTOfAwBDWvac6
	U0I4FCrdM9FfzIH3/9Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lo1-0002Nv-6P; Mon, 27 Jun 2022 10:17:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lnx-0002MH-SX
	for kexec@lists.infradead.org; Mon, 27 Jun 2022 10:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656325036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29XAW3SdVV053hARy2DHbS6TO7CBuYcWdq0hwUUUOu8=;
	b=i02/zf9jeGNZ63POGBjKzIzknhWwA0Rptr8MX0ZqVp0Y857DyCi4KiPZAaOCClZ78BZd6m
	yvi3IpMAaJCtKdRY7kPPaZvTaf1XFjO6HszsqiRJUEgOpKUarZvkbpGB4JCV6BRbsJ901R
	XcYIEeIT3QogvF0Wv+gJJBQj20IwBeI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-_16kP6lEP1-vh2RorxSJ6Q-1; Mon, 27 Jun 2022 06:17:13 -0400
X-MC-Unique: _16kP6lEP1-vh2RorxSJ6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 474EC83395C;
	Mon, 27 Jun 2022 10:17:12 +0000 (UTC)
Received: from localhost (ovpn-13-65.pek2.redhat.com [10.72.13.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC4A404E4DD;
	Mon, 27 Jun 2022 10:17:10 +0000 (UTC)
Date: Mon, 27 Jun 2022 18:17:07 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
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
Message-ID: <YrmDo7Sx1jNQ4WFd@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
 <YrRzvO5F0dumsbAU@arm.com>
 <Yrkbak66vYT55H4x@MiWiFi-R3L-srv>
 <e3318551-4134-245a-c060-86ab81eb3e68@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e3318551-4134-245a-c060-86ab81eb3e68@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_031718_061300_3104A99C 
X-CRM114-Status: GOOD (  29.75  )
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

On 06/27/22 at 05:17pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/6/27 10:52, Baoquan He wrote:
> > On 06/23/22 at 03:07pm, Catalin Marinas wrote:
> >> On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
> >>> On 06/21/22 at 07:04pm, Catalin Marinas wrote:
> >>>> The problem with splitting is that you can end up with two entries in
> >>>> the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
> >>>> for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
> >>>> abort (but can be worse like loss of coherency).
> >>>
> >>> Thanks for this explanation. Is this a drawback of arm64 design? X86
> >>> code do the same thing w/o issue, is there way to overcome this on
> >>> arm64 from hardware or software side?
> >>
> >> It is a drawback of the arm64 implementations. Having multiple TLB
> >> entries for the same VA would need additional logic in hardware to
> >> detect, so the microarchitects have pushed back. In ARMv8.4, some
> >> balanced was reached with FEAT_BBM so that the only visible side-effect
> >> is a potential TLB conflict abort that could be resolved by software.
> > 
> > I see, thx.
> > 
> >>
> >>> I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
> >>> have different bootup time. And the more often TLB miss and flush will
> >>> cause performance cost. It is really a pity if we have very powerful
> >>> arm64 cpu and system capacity, but bottlenecked by this drawback.
> >>
> >> Is it only the boot time affected or the runtime performance as well?
> > 
> > Sorry for late reply. What I observerd is the boot time serious latecy
> > with huge memory. Since the timestamp is not available at that time,
> > we can't tell the number. I didn't notice the runtime performance.
> 
> There's some data here, and I see you're not on the cc list.
> 
> https://lore.kernel.org/linux-mm/1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com/T/

Thanks, Zhen Lei. I also saw the patch. That seems to be a good way,
since there's only one process running at that time. Not sure if there's
still risk of multiple TLB entries for the same VA existing.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

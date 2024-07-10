Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF6C2BD09
	for <kexec@archiver.kernel.org>; Wed, 10 Jul 2024 03:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0paFNbvV/TWE8K5aBR+wY2oQlk62mP2zrLfJAM9nif0=; b=M6aX0Jhp+Nd6WG
	d8nw7z0tVovKIedcb3dDyl92aqv5lC9Wt87nB7ks/zZ9fPNGOV9qo7eokcwBcgzXo8p2je6rCXhGy
	tDOdjX2xFSIZPJhoaaZgPuzzJjWrf0KZw8EJm8wn7RZkGq8lZs3D73xvhpTms0qC5TadutXFw8GzI
	ZvByYDLHtMfMLE0/DhKsGXBF3DQGu6HZlwK++u7DriRi45sFAyTEyP3AmqT62v7S7xzOAinVn1KfH
	3QVRQA7m8+thHMBLaAZD+VcZ9fsQCIJfrlasCgs6yPNeVUmdvu8Q4w+nDnWIDWU1VoYRLvpBnHXuv
	DTC9+/fJlq7jqpB/xqNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sROCC-00000009Kc3-2mbi;
	Wed, 10 Jul 2024 03:40:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sROC4-00000009Kag-3iAs
	for kexec@lists.infradead.org;
	Wed, 10 Jul 2024 03:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720582835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TDO9TiwXKhQArR/husLC6W35eQMaOfa6OJltOm3NtHE=;
	b=QsorQ4skeG1LPvE1zZ1ZzueyiRgtKWaV5KrNYww48luf8KMjt3qZwH3rHbo807GuIJsRC3
	fq2J+greB3+NJ+Cy9Ozv39vUZnDFl2GKyZp6+be3ltMNVtLwa+1yCuDMqLspmXhiXhynR8
	JKpjZAE2nnATc8HQ2gK8atp6fnpby4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-evszWIkEP4igK3S0oBR-Zw-1; Tue,
 09 Jul 2024 23:40:28 -0400
X-MC-Unique: evszWIkEP4igK3S0oBR-Zw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05811195609E;
	Wed, 10 Jul 2024 03:40:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36E751955F40;
	Wed, 10 Jul 2024 03:40:21 +0000 (UTC)
Date: Wed, 10 Jul 2024 11:40:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org, deller@gmx.de,
	javierm@redhat.com, robh@kernel.org, thunder.leizhen@huawei.com,
	austindh.kim@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Message-ID: <Zo4CnwD28TbiknVy@MiWiFi-R3L-srv>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
 <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
 <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
 <01869981-b1de-32cb-bd25-d6ea09752b3d@huawei.com>
 <Zo1D9sB0UTOIrApP@MiWiFi-R3L-srv>
 <8aed5c59-090b-ea7e-020c-dd2785ee3d7e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8aed5c59-090b-ea7e-020c-dd2785ee3d7e@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_204037_012025_1AB1B36B 
X-CRM114-Status: GOOD (  27.74  )
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

On 07/10/24 at 09:52am, Jinjie Ruan wrote:
> 
> 
> On 2024/7/9 22:06, Baoquan He wrote:
> > On 07/09/24 at 07:06pm, Jinjie Ruan wrote:
> >>
> >>
> >> On 2024/7/9 18:39, Baoquan He wrote:
> >>> On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
> >>>>
> >>>>
> >>>> On 2024/7/9 17:29, Baoquan He wrote:
> >>>>> On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
> >>>>>> Currently, x86, arm64, riscv and loongarch has been switched to generic
> >>>>>> crashkernel reservation. Also use generic interface to simplify crashkernel
> >>>>>> reservation for arm32, and fix two bugs by the way.
> >>>>>
> >>>>> I am not sure if this is a good idea. I added the generic reservation
> >>>>> itnerfaces for ARCH which support crashkernel=,high|low and normal
> >>>>> crashkernel reservation, with this, the code can be simplified a lot.
> >>>>> However, arm32 doesn't support crashkernel=,high, I am not sure if it's
> >>>>> worth taking the change, most importantly, if it will cause
> >>>>> misunderstanding or misoperation.
> >>>>
> >>>> Yes, arm32 doesn't support crashkernel=,high.
> >>>>
> >>>> However, a little enhancement to the generic code (please see the first
> >>>> patch), the generic reservation interfaces can also be applicable to
> >>>> architectures that do not support "high" such as arm32, and it can also
> >>>> simplify the code (please see the third patch).
> >>>
> >>> Yeah, I can see the code is simplified. When you specified
> >>> 'crashkernel=xM,high', do you think what should be warn out? Because
> >>> it's an unsupported syntax on arm32, we should do something to print out
> >>> appropriate message.
> >>
> >> Yes, you are right! In this patch it will print "crashkernel high memory
> >> reservation failed." message and out for arm32 if you specify
> > 
> > That message may mislead people to believe crashkernel=,high is
> > supported but reservation is failed, then a bug need be filed for this?
> > We may expect a message telling this syntax is not supported on this
> > ARCH.
> 
> "CRASH_ADDR_LOW_MAX >= CRASH_ADDR_HIGH_MAX" indicate that the arm32 does
> not support "crashkernel=,high", I wonder if this is generic for similar

Imagine you are a testing engineer or a distros user, how do you know
if "CRASH_ADDR_LOW_MAX >= CRASH_ADDR_HIGH_MAX" when you test
'crashkernel=,high' and see the failure message?

> architecture. If so, the first patch can print such as
> "crashkernel=,high is not supported on this ARCH" message.

Please consider conprehensively if this is doable, you can paste
draft code here to prove it.

> 
> > 
> >> 'crashkernel=xM,high because "CRASH_ADDR_LOW_MAX" and
> >> "CRASH_ADDR_HIGH_MAX" is identical for arm32. And it should also warn
> >> out for other similar architecture.
> >>
> >>
> >>>
> >>>
> >>
> > 
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

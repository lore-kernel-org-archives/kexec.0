Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE47C74A5B
	for <kexec@archiver.kernel.org>; Thu, 23 Mar 2023 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HPA2TwMt+ln7YuWdKCEIChqJqlZ0O+BYR4ma25JFMt0=; b=E7RbwQ1esmSBmC
	5zhL0TW+PzwBh/MrPA5IacNrlrNGDKuJSMeDKA4VjCBV8qLXfhfiMAHuaTsgUrX2Ai6NA+nJEMDFk
	UyTUuGAx6DAMzb1PyXVX5ti0d0TJhEwY+4Wh6wIWO2eZcgL9tFtdMtC6ZIo493RCdYJK3tM0ANYSe
	P4QvBA0Fv+az/zNmb/R9hkH/+4PownrdcwzCGmCXmWPwkn1JKVcDhMa1Qwe94J+FGfRba4qq0itsQ
	gSvuJfIFXfweMpQO4xhQJAajfz+A6tPFgkqAeoqTgydZWX/PFCtBLD4lzkdJRq5OA4jmRXVwpe6J6
	j8h78zbyO6OIhS70O3mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfOgs-002akr-0D;
	Thu, 23 Mar 2023 17:25:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfOgp-002ak7-09;
	Thu, 23 Mar 2023 17:25:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9A8F662827;
	Thu, 23 Mar 2023 17:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A4C433A8;
	Thu, 23 Mar 2023 17:25:24 +0000 (UTC)
Date: Thu, 23 Mar 2023 17:25:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZByLga6FS5o8Syug@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
 <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com>
 <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_102527_167065_5445FD09 
X-CRM114-Status: GOOD (  34.54  )
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

On Mon, Mar 20, 2023 at 09:12:08PM +0800, Baoquan He wrote:
> On 03/17/23 at 06:05pm, Catalin Marinas wrote:
> > On Fri, Mar 17, 2023 at 11:09:13PM +0800, Baoquan He wrote:
> > > In fact, what I want to achieve is we set CRASH_ADDR_LOW_MAX to 4G
> > > fixedly on arm64, just like what we do on x86_64. As for RPi4 platform,
> > > we leave it to crashkernel=size@offset syntax. Two reasons for this:
> > > 1) crashkernel is needed on enterprise platform, such as workstation or
> > > server. While RPi4 is obviously not the target. I contacted several RPi4
> > > players in Redhat and my friends, none of them ever played kdump
> > > testing. If they really have to, crashkernel=size@offset is enough for
> > > them to set.
> > 
> > I'd like crashkernel=size (without @offset) on RPi4 to still do the
> > right thing: a low allocation at least as we had until recently (or
> > high+low where high here is maybe above 1GB). IOW, no regression for
> > this crashkernel=size case. We can then change the explicit
> > crashkernel=x,high to mean only above 4GB irrespective of the platform
> > and crashkernel=x,low to be below arm64_dma_phys_limit.
> 
> Since crashkernel=,high and crashkernel=size fallback was added in arm64
> recently, with my understanding, you are suggesting:
> 
> on arm64:
> RPi4:
> crashkernel=size
> 0~1G: low memory (no regression introduced)

And, if not enough low memory, fall back to memory above 1GB (for RPi4;
it would be above 4GB for any other system).

> crashkernel=size,high
> 0~1G: low memory | 4G~top: high memory

Yes.

> Other normal system:
> crashkernel=size|crashkernel=size,high
> 0~4G: low memory | 4G~top: high memory

Yes.

IOW, specifying 'high' only forces the high allocation above 4GB instead
of arm64_dma_phys_limit, irrespective of the platform. If no 'high'
specified search_base remains CRASH_ADDR_LOW_MAX (1GB on RPi4, 4GB for
the rest).

> > > 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
> > > problem of base page mapping for the whole linear mapping if crsahkernel=
> > > is set in kernel parameter shown in [1] at bottom. 
> > 
> > That's a different problem ;). I should re-read that thread, forgot most
> > of the details but I recall one of the counter arguments was that there
> > isn't a strong case to unmap the crashkernel reservation. Now, if we
> > place crashdump kernel image goes in the 'high' reservation, can we not
> > leave the 'low' reservation mapped? We don't really care about it as it
> > wouldn't have any meaningful code/data to be preserved. If the 'high'
> > one goes above 4G always, we don't depend on the arm64_dma_phys_limit.
> 
> Yes, this looks ideal. While it only works when crashkernel=,high case and
> it succeeds to reserve a memory region for the specified size of crashkernel
> high memory. At below, we have 4 cases of crashkernel= syntax:
> 
> crashkernel=size
> 1)first attempt:  low memory under arm64_dma_phys_limit
> 2)fallback:       finding memory above 4G

(2) should be 'finding memory above arm64_dma_phys_limit' to keep the
current behaviour for RPi4.

> crashkernel=size,high
> 3)first attempt:  finding memory above 4G
> 4)fallback:       low memory under arm64_dma_phys_limit

Yes.

> case 3) works with your suggestion. However, 1), 2), 4) all need to
> defer to bootmem_init(). With these cases and different handling,
> reserve_crashkernel() could be too complicated.

Ah, because of the fallback below arm64_dma_phys_limit as in (4), we
still can't move the full crashkernel reservation early. Well, we could
do it in two steps: (a) early attempt at crashkernel reservation above
4G if 'high' was specified and we avoid mapping it if successful and (b)
do the late crashkernel reservation below arm64_dma_phys_limit and skip
unmapping as being too late. This way most server-like platforms would
get a reservation above 4G, unmapped.

> I am wondering if we can cancel the protection of crashkernel memory
> region on arm64 for now. In earlier discussion, people questioned if the
> protection is necessary on arm64. After comparison, I would rather take
> away the protection method of crashkernel region since they try to
> protect in a chance in one million , while the base page mapping for the
> whole linear mapping is mitigating arm64 high end server always.

This works for me. We can add the protection later for addresses above
4GB only as mentioned above.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8C6C76195
	for <kexec@archiver.kernel.org>; Fri, 24 Mar 2023 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VE6kOAjhJWxp7nF4NfawyS/gXAO2O1XvRNeHwlPhe2o=; b=NLCKwVGl7m9hc+
	5VZUgtzS6KCoGLDahO4d5K+xQnGroBcHnL2lJ29hfeFkSsFbV/40xwswjiUD184sp9BT2klJuGNcg
	pFkI3jZy/ef519Tn/KxetvSJStUWsAk7KqZl65s187DJGQSWvcXRE3n6tcSilIWjd6tmoJ0xTsVu9
	3B7+LvYowM3opuvyKfMdlbE50QdaYdls6KxvG0d3Z2/JQShjO90rYQcrkYX4LlKQiKVlkTkbF06X+
	4dyZHIOah6RmpVJ9o1uNE113poEHSthTyBP6RG0XjpQEKTSBm7JguehuIs31k51P0dTYkaOeR6qEA
	Dx0UOgcJFAEw3wVxRxVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfku9-0053DA-0f;
	Fri, 24 Mar 2023 17:08:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfku7-0053CY-1N;
	Fri, 24 Mar 2023 17:08:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E206AB82565;
	Fri, 24 Mar 2023 17:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3361AC433D2;
	Fri, 24 Mar 2023 17:08:35 +0000 (UTC)
Date: Fri, 24 Mar 2023 17:08:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZB3ZEBRKlCI9WIgK@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
 <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com>
 <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
 <ZByLga6FS5o8Syug@arm.com>
 <ZB2u0QAEU1P7qIZc@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZB2u0QAEU1P7qIZc@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_100839_621117_BE46E6A7 
X-CRM114-Status: GOOD (  15.27  )
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

On Fri, Mar 24, 2023 at 10:08:17PM +0800, Baoquan He wrote:
> On 03/23/23 at 05:25pm, Catalin Marinas wrote:
> > On Mon, Mar 20, 2023 at 09:12:08PM +0800, Baoquan He wrote:
> > > crashkernel=size
> > > 1)first attempt:  low memory under arm64_dma_phys_limit
> > > 2)fallback:       finding memory above 4G
> > 
> > (2) should be 'finding memory above arm64_dma_phys_limit' to keep the
> > current behaviour for RPi4.
> 
> Then for RPi4, with case 2), it will find memory above
> arm64_dma_phys_limit, namely 1G. Then it will get two memory regions,
> one could be in [1G, 4G], another is below 4G. I am fine with this, as
> long as it won't cause confusion that people may think two low memory
> regions you mentioned earlier. Please help confirm if I understand your
> suggestioin correctly. I will start making patch with this clarified.

Yes, you understood correctly. While it may still be slightly confusing,
if the user is not specific about high and low on the cmdline, we just
allow the kernel to find the best places. I assume distros will just use
,high and get a consistent behaviour on all platforms.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

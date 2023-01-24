Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E972C54E94
	for <kexec@archiver.kernel.org>; Tue, 24 Jan 2023 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ecs3n6ids/hH9MgILtrh7q3K0TZlDMrTFXVfDm/9ro8=; b=ADa2hKSz+5SmuX
	ZhQOE73e3y3AqjIsTNG1mh17WEUW6+/ox5T8uiOi9TJ1uIJERDjqHv53yNQO1PbGbPZ+PajlR0ju8
	TaHA+pWRx/W4Z5QSv+aDnBd+5aK8JSO2IX4oVH7Je3Q4N1A5KGxJglBMf93xJblM8OGzRIDgsDFom
	p8UWSvfmEQZwl0PbR1KZ6qojKVVmNwv4bPgucdv3TZCZjQ7wRuL4BN7Jvk5llxwiCDvM4nxi6fZzn
	nmAom98upNoN/wdoUVNQVTOdVxkqqyB/5ZgUeFpdIolPAez53AUzko9+gOo8N6+EIMsLMxga0IvSO
	AsvkD0j15XdGClpF9rHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKNE7-004qP4-Oe; Tue, 24 Jan 2023 17:36:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKNE1-004qO0-7z; Tue, 24 Jan 2023 17:36:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ED423612B3;
	Tue, 24 Jan 2023 17:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5DEC433EF;
	Tue, 24 Jan 2023 17:36:45 +0000 (UTC)
Date: Tue, 24 Jan 2023 17:36:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9AXKgJvUuilsWUX@arm.com>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230117034921.185150-2-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_093649_358013_C401ACC4 
X-CRM114-Status: GOOD (  20.35  )
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

On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region up down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> This looks very strange because we have two low memory regions
> [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> why that happened.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region above the high and low memory boundary. If failed, try reserving
> the suitable region below the boundary. Like this, the crashkernel high
> region will only exist in high memory, and crashkernel low region only
> exists in low memory. The reservation behaviour for crashkernel=,high is
> clearer and simpler.

Well, I guess it depends on how you look at the 'high' option: is it
permitting to go into high addresses or forcing high addresses only?
IIUC the x86 implementation has a similar behaviour to the arm64 one, it
allows allocation across boundary.

What x86 seems to do though is that if crash_base of the high allocation
is below 4G, it gives up on further low allocation. On arm64 we had this
initially but improved it slightly to check whether the low allocation
is of sufficient size. In your example above, it is 126MB instead of
128MB, hence an explicit low allocation.

Is the only problem that some users get confused? I don't see this as a
significant issue. However, with your patch, there is a potential
failure if there isn't sufficient memory to accommodate the request in
either high or low ranges.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

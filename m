Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402C2C54EE9
	for <kexec@archiver.kernel.org>; Thu,  8 Sep 2022 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzPzebp/z1cBM1YbxcaJJbbhjYK1rqgKi2LQA3LRVY8=; b=gHFOd2AtOdYHxV
	vKvoRhxv9gwhi0F3eR7uCIN10qJTBSQ7fTJpOz+UQ+xnrqgIv/D0M52oM184Kr6ljrhyWw1JG5sWr
	ZOMkhG8cWGCzyG4wVG3cvSoKTs5YoVTJF7IPczSj4knNKDoUMBmgpyI71vVGR0/eyjNx/NyJy9K3h
	34yCMUrYNDx3NtL6wv3797mbeB4dYsg+Zov5RE1sEtcuOAeM/r0OAUloNxNR3jw/vAKJLM0rNbHLw
	hXflTneS9dPVTHsdJ6dmdNbkkRHCMLJMm2HnVk3q33N1R4BOBMWn0T3SMYHcDFJ2Oud9XZcRr1vgS
	6lN/R5TSdVRtZegTxK7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWHik-003x8v-RB; Thu, 08 Sep 2022 13:37:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWHfO-003uLM-1N
	for kexec@lists.infradead.org; Thu, 08 Sep 2022 13:34:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662644038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O9ip73Qx6fI5v+xW3rG6yA0ch1PUUa46LdixT8CDecw=;
	b=an5H4KKZHyt0kFMZewyRuonUE/SoVDdc106xpOqmioYhmTngjbfHv6/2Rzi3+MZAaoT84p
	cfd2DrszADHnbvK3P0B3xC7SIsGkKhDlqdaFUz4g+nOb5UGRhml/6MQrYF9rqHKc/CxF4b
	z7RmmKxvAnBR3c4TkBXHAxxVW3lftn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-5ecYr9iaNguGo_DcNpwlVQ-1; Thu, 08 Sep 2022 09:33:55 -0400
X-MC-Unique: 5ecYr9iaNguGo_DcNpwlVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9139811E76;
	Thu,  8 Sep 2022 13:33:54 +0000 (UTC)
Received: from localhost (ovpn-12-219.pek2.redhat.com [10.72.12.219])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F13841410F38;
	Thu,  8 Sep 2022 13:33:53 +0000 (UTC)
Date: Thu, 8 Sep 2022 21:33:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, will@kernel.org,
	catalin.marinas@arm.com
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
	linux-mm@kvack.org, thunder.leizhen@huawei.com,
	wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YxnvPu/tNvlBeJ/c@MiWiFi-R3L-srv>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org>
 <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
 <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_063402_229159_1A10354F 
X-CRM114-Status: GOOD (  36.52  )
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

On 09/06/22 at 03:05pm, Ard Biesheuvel wrote:
> On Mon, 5 Sept 2022 at 14:08, Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/05/22 at 01:28pm, Mike Rapoport wrote:
> > > On Thu, Sep 01, 2022 at 08:25:54PM +0800, Baoquan He wrote:
> > > > On 09/01/22 at 10:24am, Mike Rapoport wrote:
> > > >
> > > > max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
> > > > the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
> > > > it like:
> > > >
> > > > static phys_addr_t __init crash_addr_low_max(void)
> > > > {
> > > >         phys_addr_t low_mem_mask = U32_MAX;
> > > >         phys_addr_t phys_start = memblock_start_of_DRAM();
> > > >
> > > >         if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> > > >              (phys_start > U32_MAX))
> > > >                 low_mem_mask = PHYS_ADDR_MAX;
> > > >
> > > >         return low_mem_mast + 1;
> > > > }
> > > >
> > > > or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
> > > > as you suggested. Which one do you like better?
> > > >
> > > > static phys_addr_t __init crash_addr_low_max(void)
> > > > {
> > > >         if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> > > >             return PHYS_ADDR_MAX + 1;
> > > >
> > > >         return max_zone_phys(32);
> > > > }
> > >
> > > I like the second variant better.
> >
> > Sure, will change to use the 2nd one . Thanks.
> >
> 
> While I appreciate the effort that has gone into solving this problem,
> I don't think there is any consensus that an elaborate fix is required
> to ensure that the crash kernel can be unmapped from the linear map at
> all cost. In fact, I personally think we shouldn't bother, and IIRC,
> Will made a remark along the same lines back when the Huawei engineers
> were still driving this effort.
>
> So perhaps we could align on that before doing yet another version of this?

Yes, certainly. That can save everybody's effort if there's different
opinion. Thanks for looking into this and the suggestion. 

About Will's remark, I checked those discussing threads, guess you are
mentioning the words in link [1]. I copy them at bottom for better
reference. Pleasae correct me if I am wrong.

With my understanding, Will said so because the patch is too complex,
and there's risk that page table kernel data itself is using could share
the same block/section mapping as crashkernel region. With these
two cons, I agree with Will that we would rather take off the protection
on crashkernel region which is done by mapping or unmapping the region,
even though the protection enhances kdump's ronusness.

Crashkernel reservation needs to know the low meory end so that DMA
buffer can be addressed by the dumping target, e.g storage disk. On the
current arm64, we have facts:
1)Currently, except of Raspberry Pi 4, all arm64 systems can support
  32bit DMA addressing. So, except of RPi4, the low memory end can be
  decided after memblock init is done, namely at the end of
  arm64_memblock_init(). We don't need to defer the crashkernel
  reservation until zone_sizes_init() is done. Those cases can be checked
  in patch code.
2)For RPi4, if its storage disk is 30bit DMA addressing, then we can
  use crashkernel=xM@yM to specify reservation location under 1G to
  work around this.

***
Based on above facts, with my patch applied:
pros:
1) Performance issue is resolved;
2) As you can see, the code with this patch applied will much 
  simpler, more straightforward and clearer;
3) The protection can be kept;
4) Crashkernel reservation can be easier to succeed on small memory
   system, e.g virt guest system. The earlier the reservation is done,
   it's more likely to get the whole chunk of meomry.
cons:
1) Only RPi4 is put in inconvenience for crashkernel reservation. It
   needs to use crashkernel=xM@yM to work around.

***
Take off the protection which is done by mapping or unmapping
crashkernel region as you and Will suggested:
pros:
1) Performance issue is resolved;
2) RPi4 will have the same convenience to set crashkernel;

cons:
1) No protection is taken on crashkernel region;
2) Code logic is twisting. There are two places to separately reserve
   crashkernel, one is at the end of arm64_memblock_init(), one is at
   the end of bootmem_init(). 
3) Except of both CONFIG_ZONE_DMA|DMA32 disabled case, crashkernel
   reservation is deferred. On small memory system, e.g virt guest system,
   it increases risk that the resrevation could fail very possibly caused
   by memory fragmentation.

Besides, comparing the above two solutions, I also want to say kdump
is developed for enterprise level of system. We need combine with
reality when considering reasonable solution. E.g on x86_64, it has DMA
zone of 16M and DMA32 zone from 16M to 4G always in normal kernel. For
kdump, we ignore DMA zone directly because it's for ISA style devices. 
Kdump doesn't support ISA style device with only 24bit DMA addressing
capability at the beginning, because it doesn't make sense, we never
hear that an enterprise level of x86_64 system needs to arm with kdump.

Hi Ard, Will, Catalin and other reviewers,

Above is my understaning and thinking about the encountered issue,
plesae help check and point out what's missing or incorrect.

Hi Nicolas,

If it's convenient to you, please help make clear if the storage disk or
network card can only address 32bit DMA buffer on RPi4. Really
appreciate that.

***
[1]Will's remark on Huawei's patch
https://lore.kernel.org/all/20220718131005.GA12406@willie-the-truck/T/#u

====quote Will's remark here
I do not think that this complexity is justified. As I have stated on
numerous occasions already, I would prefer that we leave the crashkernel
mapped when rodata is not "full". That fixes your performance issue and
matches what we do for module code, so I do not see a security argument
against it.

I do not plan to merge this patch as-is.
===


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

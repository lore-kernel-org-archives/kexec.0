Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8435C00140
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OSwgImDxXIuuN66Xaew7B4nGYDSiHGYEM2dxZCPPR88=; b=SEKIZmE5iF60TC
	z42KQOtIRbhFAFCY3k0aRsBzahmGATz7hK1YWTV4hwgEg8gb9mJ20S7cq3TR4JalfbikWyzOLSABS
	boDEyVvrPkCwuMXDUamY9W9FhSsSRaLx85IC3/gRVzaa0YLT0ziy/NU8ioG5yw8lV9gRzgc5G/m8M
	E0+sVCAM+rHBcBGXbNvSqn5cfSF5qcF2TrTLXGY+py+4rzBbFS1f3Na3NjLKxY/QNi9DgXpyGTsY6
	kDdpwouhQnZvYZwUV9ti1l0D4pM1rvWjPDgFuctb8pqYbO5Hd7dW4sLs1iXEBhTdgOrZNCKkhRHWb
	YxCP7ZfMRak9aOECEB5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIrJ5-00E8E6-My; Tue, 02 Aug 2022 12:47:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIrJ3-00E89l-9K
	for kexec@lists.infradead.org; Tue, 02 Aug 2022 12:47:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659444443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbbGtoG/Vl+wjUfmVqEW8AmNwItFx5zbhZBvkq/eXg8=;
	b=cVoWV5i+vBr2ft+yJ7EfyTt4pkUxwNGE0TYHMm7nFF+JFWT0K/exH6mpn5Q+Uu0k6x5PY3
	s0IG/0zjZzqY8aMD8bwuEM7O3fE53rXxz+KDojJsMnId3BnYBR5ExHwVCqTCkW+gCxvsES
	fv5Xo1ZT/4hSQRswNWKHDYn/H7iJZoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-dOMSq3THNai4QTNWY5116w-1; Tue, 02 Aug 2022 08:47:20 -0400
X-MC-Unique: dOMSq3THNai4QTNWY5116w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48B82858F00;
	Tue,  2 Aug 2022 12:47:19 +0000 (UTC)
Received: from localhost (ovpn-13-104.pek2.redhat.com [10.72.13.104])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 307DF90A04;
	Tue,  2 Aug 2022 12:47:16 +0000 (UTC)
Date: Tue, 2 Aug 2022 20:46:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Will Deacon <will@kernel.org>,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>, ardb@kernel.org
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
Message-ID: <YukcwUyEvOLjV00C@MiWiFi-R3L-srv>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com>
 <20220802083703.GA26962@willie-the-truck>
 <bc2830f7-7c3c-30ea-0178-ad86922f8f5c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc2830f7-7c3c-30ea-0178-ad86922f8f5c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_054729_556363_17B6DCB1 
X-CRM114-Status: GOOD (  30.33  )
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

On 08/02/22 at 06:12pm, Leizhen (ThunderTown) wrote:
......snip...  
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 339ee84e5a61a0b..5390f361208ccf7 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> >>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> >>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> >>  
> >> +/*
> >> + * This is an empirical value in x86_64 and taken here directly. Please
> >> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
> >> + * details.
> > 
> > Honestly, I read that comment and I'm none the wiser. What does "due to
> > mapping restrictions" mean? The remainder of the comment appears to be
> 
> Because the comments you read is addressed to CRASH_ADDR_LOW_MAX, not
> for DEFAULT_CRASH_KERNEL_LOW_SIZE. Please see the following patch:
> 
> 94fb9334182284 x86/crash: Allocate enough low memory when crashkernel=high
> 
> > specific to x86 and refers to jump ranges with 5-level page-tables.
> > 
> >> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> >> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> > 
> > So why does this value make sense for arm64? We have considerable platform
> > fragmentation^Wdiversity compared to x86 and picking a one-size-fits-all
> > default is more likely to cause weird problems when it doesn't work imo. I'd
> > actually prefer that the default is something that fails obviously (e.g. 0)
> > and we force an appropriate size to be specified.

The default value mainly serves the crashkernel=xM case, not just for
crashkernel=,high specified while no crahskernel=,low. The simplest
usage of crashkernel reservation is user only need set crashkernel=xM in
cmdline, we will try to get available memory from low memory region
firstly, if failed, go above 4G to find again. If we finally get memory
from above 4G, then the default low memory is needed. E.g if
crashkernel=512M is set, and no sufficient memory under 4G. With it,
user don't need to know about crashkernel=,high or ,low, and even memory
has type of high, low, or dma stuff.

> > 
> > On the other hand, if you can convince me that having a global constant is
> > the right way forward, then please move this out of the arch code.
> 
> Yes, the default value may not be the same as that of x86. For example,
> 128 MB may be sufficient.
> 
> So we need to discuss first, do we need a default value? Personally, I
> don't think it hurts.

Yes, we can discuss. Welcome anyone to help provide information how we
should take care to make a small but enough value. In fact, on x86_64,
we didn't set the value at one time. It was set as 72M at the beginning,
later Joerg found it's not enough, we finally decided to make it as
256M. People who mind the wasting of 256M can use crashkernel=,high and
crashkernel=,low pair to specify the value exactly.

commit c729de8fcea3 ("x86, kdump: Set crashkernel_low automatically")
commit 94fb93341822 ("x86/crash: Allocate enough low memory when crashkernel=high")

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

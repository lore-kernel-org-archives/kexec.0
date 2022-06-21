Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93BDC43334
	for <kexec@archiver.kernel.org>; Tue, 21 Jun 2022 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OTjxWMiEQrWnwdK1t8FBeowFapBJtthdVdIkDokeTik=; b=UrPclx8lGC/ezQ
	Gv/6TEcheBVN/gyf4GNMb9RK3UEBcdg3RrdUiAxnLqlpah/yT7ZuU8R3hoOdA8cmLfSHAxoNmSz8l
	oob8pBZ5IHeCmzwebBFKlgtuLakYZBKBADDi+qm2Mf3XfIAhZG3dOuwJGE5IPlDNuWnD3GufLVTHi
	javyqk1+E5qFs6nZY1EN+RNu4n3Eb5LAzr9rrXsStgpBuofFvj9Em6zHh8FA8+d2ZSXK5XX4uwagS
	GNs1ZLt4M/1NzMDRq7XvNgBK76TXl6OyDuZ6J9zP+TxIPGD1VcWYCECOaCRdn6k92MrFmWUDKQ/Cp
	Ay9J4im6QG7FCjApbF8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3aB3-004cxF-5i; Tue, 21 Jun 2022 09:28:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3aAw-004cu5-Up
	for kexec@lists.infradead.org; Tue, 21 Jun 2022 09:28:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655803670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/6eJspt/AVzBoz5mItJSgxql1F5f7nb/z62lzZC//s=;
	b=h92MBdQ60YyfZtTbeTYIsHZWShRLkjKqTjvj2+fhkEzm8r35rgkMIsdzQo3u8IA9caCYqf
	5pxhNmMkM6OnewRaPK1fLodCkqUaE5yz1EyXfayLo9+RONtmB/JSoZisruRS5D5+BQzVE2
	ixudyhNSW9jUk8rYMuFumpZtVxYWyig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-MQve9TMLMYyX3G1gVtvhfA-1; Tue, 21 Jun 2022 05:27:47 -0400
X-MC-Unique: MQve9TMLMYyX3G1gVtvhfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 539A280B70F;
	Tue, 21 Jun 2022 09:27:46 +0000 (UTC)
Received: from localhost (ovpn-12-183.pek2.redhat.com [10.72.12.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A52A540CFD0A;
	Tue, 21 Jun 2022 09:27:44 +0000 (UTC)
Date: Tue, 21 Jun 2022 17:27:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <YrGPDLea0ALMOqFV@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_022759_098313_CAD0A6AE 
X-CRM114-Status: GOOD (  40.34  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 06/21/22 at 02:24pm, Kefeng Wang wrote:
> =

> On 2022/6/21 13:33, Baoquan He wrote:
> > Hi,
> > =

> > On 06/13/22 at 04:09pm, Zhen Lei wrote:
> > > If the crashkernel has both high memory above DMA zones and low memory
> > > in DMA zones, kexec always loads the content such as Image and dtb to=
 the
> > > high memory instead of the low memory. This means that only high memo=
ry
> > > requires write protection based on page-level mapping. The allocation=
 of
> > > high memory does not depend on the DMA boundary. So we can reserve the
> > > high memory first even if the crashkernel reservation is deferred.
> > > =

> > > This means that the block mapping can still be performed on other ker=
nel
> > > linear address spaces, the TLB miss rate can be reduced and the system
> > > performance will be improved.
> > Ugh, this looks a little ugly, honestly.
> > =

> > If that's for sure arm64 can't split large page mapping of linear
> > region, this patch is one way to optimize linear mapping. Given kdump
> > setting is necessary on arm64 server, the booting speed is truly
> > impacted heavily.
> =

> Is there some conclusion or discussion that arm64 can't split large page
> mapping?

Yes, please see below commit log. =

commit d27cfa1fc823 ("arm64: mm: set the contiguous bit for kernel mappings=
 where appropriate")

> =

> Could the crashkernel reservation (and Kfence pool) be splited dynamicall=
y?

For crashkernel region, we have arch_kexec_protect_crashkres() to secure
the region, and crash_shrink_memory() could be called to shrink it.
While crahshkernel region could be crossig part of a block mapping or secti=
on
mapping and the mapping need be splitted, that will cause TLB conflicts.

> =

> I found Mark replay "arm64: remove page granularity limitation from
> KFENCE"[1],
> =

> =A0 "We also avoid live changes from block<->table mappings, since the
> =A0 archtitecture gives us very weak guarantees there and generally requi=
res
> =A0 a Break-Before-Make sequence (though IIRC this was tightened up
> =A0 somewhat, so maybe going one way is supposed to work). Unless it's
> =A0 really necessary, I'd rather not split these block mappings while
> =A0 they're live."
> =

> Hi Mark and Catalin,=A0 could you give some comment,=A0 many thanks.
> =

> [1] https://lore.kernel.org/lkml/20210920101938.GA13863@C02TD0UTHF1T.loca=
l/T/#m1a7f974593f5545cbcfc0d21560df4e7926b1381
> =

> =

> > =

> > However, I would suggest letting it as is with below reasons:
> > =

> > 1) The code will complicate the crashkernel reservatoin code which
> > is already difficult to understand.
> > 2) It can only optimize the two cases, first is CONFIG_ZONE_DMA|DMA32
> >    disabled, the other is crashkernel=3D,high is specified. While both
> >    two cases are corner case, most of systems have CONFIG_ZONE_DMA|DMA32
> >    enabled, and most of systems have crashkernel=3DxM which is enough.
> >    Having them optimized won't bring benefit to most of systems.
> > 3) Besides, the crashkernel=3D,high can be handled earlier because
> >    arm64 alwasys have memblock.bottom_up =3D=3D false currently, thus we
> >    don't need worry arbout the lower limit of crashkernel,high
> >    reservation for now. If memblock.bottom_up is set true in the future,
> >    this patch doesn't work any more.
> > =

> > =

> > ...
> >          crash_base =3D memblock_phys_alloc_range(crash_size, CRASH_ALI=
GN,
> >                                                 crash_base, crash_max);
> > =

> > So, in my opinion, we can leave the current NON_BLOCK|SECT mapping as
> > is caused by crashkernel reserving, since no regression is brought.
> > And meantime, turning to check if there's any way to make the contiguous
> > linear mapping and later splitting work. The patch 4, 5 in this patchset
> > doesn't make much sense to me, frankly speaking.
> > =

> > Thanks
> > Baoquan
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

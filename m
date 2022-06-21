Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD93C433EF
	for <kexec@archiver.kernel.org>; Tue, 21 Jun 2022 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NftVbCGhlipuby1SGjoNdUH97KIb03Ck1TO64JeIIxM=; b=40id4O5feqBzyb
	tjeT9dtrWD72K7BY0YcAwbPfpf1KofWtdgB6tk+s5pYB9I7Rlpir1j0AJzYiRetc5fGw2v4RaRbMs
	PWQU979I5Ls3i9fuapHsdhUKhu4z0xsYfj/99ySFEE0Ku8E9QOkvydREMzSRpTQliekOZfvnLQ7eW
	9IK3CqwbzDOlw1Mt0KDNmYcdm5F7en7B1k6fgbUHpAr6p7JOUkw79HLMi8VPA7+deW0yEntilFfTO
	VK1d5Pj7GHuuwNs6ONq2X/wX7LIHjEURk5dKvFU6Tty/YUn/pV1nJU4RbLGyROUyOUzRNUyBXEXSN
	LebSPWx/vVE3lonT8exw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3iEu-006fc5-9w; Tue, 21 Jun 2022 18:04:36 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3iEr-006faf-7C; Tue, 21 Jun 2022 18:04:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 97936B81AAC;
	Tue, 21 Jun 2022 18:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A105C3411C;
	Tue, 21 Jun 2022 18:04:25 +0000 (UTC)
Date: Tue, 21 Jun 2022 19:04:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
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
Message-ID: <YrIIJkhKWSuAqkCx@arm.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_110433_585929_06EE6562 
X-CRM114-Status: GOOD (  33.02  )
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

On Tue, Jun 21, 2022 at 02:24:01PM +0800, Kefeng Wang wrote:
> On 2022/6/21 13:33, Baoquan He wrote:
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
> > =

> > Ugh, this looks a little ugly, honestly.
> > =

> > If that's for sure arm64 can't split large page mapping of linear
> > region, this patch is one way to optimize linear mapping. Given kdump
> > setting is necessary on arm64 server, the booting speed is truly
> > impacted heavily.
> =

> Is there some conclusion or discussion that arm64 can't split large page
> mapping?
> =

> Could the crashkernel reservation (and Kfence pool) be splited dynamicall=
y?
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

The problem with splitting is that you can end up with two entries in
the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
abort (but can be worse like loss of coherency).

Prior to FEAT_BBM (added in ARMv8.4), such scenario was not allowed at
all, the software would have to unmap the range, TLBI, remap. With
FEAT_BBM (level 2), we can do this without tearing the mapping down but
we still need to handle the potential TLB conflict abort. The handler
only needs a TLBI but if it touches the memory range being changed it
risks faulting again. With vmap stacks and the kernel image mapped in
the vmalloc space, we have a small window where this could be handled
but we probably can't go into the C part of the exception handling
(tracing etc. may access a kmalloc'ed object for example).

Another option is to do a stop_machine() (if multi-processor at that
point), disable the MMUs, modify the page tables, re-enable the MMU but
it's also complicated.

-- =

Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D95C433EF
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=suIgXV/tnnevXbaK90coz5YEy0glTGLVtpGIFrIZcrg=; b=t5cmnQfXBY++6V
	LkC9lnHgrMqN+zRcZyVmyKV8OaBvl3M1GmW3wqt5X47do/s39j/UDAdfW3+LLIJOqD8KYCLOhs+cc
	+PoTrHhWvGEtGuQDz0LzLOP0Ey28vrKWGBdckuLWW6O+X+fz3Qwa7aZhno3SW2RDTLtRtbOMwjAa7
	L21gOiBiobFZykb+7cCZo9MMOd/JwIV9JnxVjyfk24A+QH66ONIZvebwQBcTGTpn1tKQbUCBnivxu
	gCSglwNqaRmo2SgvjzVJNhsoIte4FpHBcamriBAWmSvbOHAiHrJWEBFZv41dqOerVG3v4Q+lGvEuF
	1hUJbi3wbDRSv2i2IrVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NVH-00FTax-Ud; Thu, 23 Jun 2022 14:08:15 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NVE-00FTYw-6q; Thu, 23 Jun 2022 14:08:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 60A9CCE24FB;
	Thu, 23 Jun 2022 14:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72C1C3411B;
	Thu, 23 Jun 2022 14:07:59 +0000 (UTC)
Date: Thu, 23 Jun 2022 15:07:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
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
Message-ID: <YrRzvO5F0dumsbAU@arm.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_070812_426438_9E199CD9 
X-CRM114-Status: GOOD (  22.11  )
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

On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
> On 06/21/22 at 07:04pm, Catalin Marinas wrote:
> > The problem with splitting is that you can end up with two entries in
> > the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
> > for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
> > abort (but can be worse like loss of coherency).
> 
> Thanks for this explanation. Is this a drawback of arm64 design? X86
> code do the same thing w/o issue, is there way to overcome this on
> arm64 from hardware or software side?

It is a drawback of the arm64 implementations. Having multiple TLB
entries for the same VA would need additional logic in hardware to
detect, so the microarchitects have pushed back. In ARMv8.4, some
balanced was reached with FEAT_BBM so that the only visible side-effect
is a potential TLB conflict abort that could be resolved by software.

> I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
> have different bootup time. And the more often TLB miss and flush will
> cause performance cost. It is really a pity if we have very powerful
> arm64 cpu and system capacity, but bottlenecked by this drawback.

Is it only the boot time affected or the runtime performance as well?

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

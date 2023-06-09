Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3978C7EE29
	for <kexec@archiver.kernel.org>; Fri,  9 Jun 2023 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1BWDDB1RYEOpSBfkkzij8Tt9k5J6QEE+wJBKVmccEAo=; b=wZtwCcsN+tikaH
	wzN9qtGNBPKTEbbp2uAX7Dowdxn5dS63G9JJ9l0CpbN7pk7KIFZzZ09wsE9KSrF7XgIhzraKxLYWJ
	yONR31u/IKiyO2bYgEz31jGDVABJNMO+uH5cLzQoou3ahQTFpFSgppMt+QLz0Qqk/rxyg4lEm41tm
	bGCkbf2hYaBWQml89W6dIQwwr2cWdZySVOoJPmGNoNP+opjhS73FyVRHQz2ofEiL2a/YrzMyQ0CxW
	jurgEhx893Xz3La3v/bXOho71oAb9FFPpD11TI0QPzCMGRiO4z96u5JT+/q46XRew2kCpKCRNaRDc
	IsLHIge1ThG+stU5gL3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7hoa-00E0JR-0o;
	Fri, 09 Jun 2023 19:30:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7hoX-00E0IS-30;
	Fri, 09 Jun 2023 19:30:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7D80E65B47;
	Fri,  9 Jun 2023 19:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C24C433D2;
	Fri,  9 Jun 2023 19:30:22 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	horms@kernel.org,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date: Fri,  9 Jun 2023 20:30:19 +0100
Message-Id: <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515060259.830662-1-bhe@redhat.com>
References: <20230515060259.830662-1-bhe@redhat.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_123026_023177_AF940F6C 
X-CRM114-Status: GOOD (  12.49  )
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

On Mon, 15 May 2023 14:02:57 +0800, Baoquan He wrote:
> In v5 patch, Catalin helped review and acked the patch. However, an
> uninitialized local varilable is warned out by static checker when Will
> tried to merge the patch. And Will complained the code flow in
> reserve_crashkernel() is hard to follow, required to refactor. While
> when I tried to do the refactory, I feel it's not easy, the existing
> several cases causes that.
> 
> [...]

Applied to arm64 (for-next/kdump).

I reworte some of the paragraphs in the documentation patch, removed
some sentences to make it easier to read (some details were pretty
obvious). Please have a look, if you think I missed something important,
just send a patch on top. Thanks.

[1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
      https://git.kernel.org/arm64/c/6c4dcaddbd36
[2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
      https://git.kernel.org/arm64/c/03dc0e05407f

-- 
Catalin


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

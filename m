Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F30C76195
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 03:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P8oNVAB1RyQhqlugHxU5X4iHpOWiB3YMRSkylUtDz1c=; b=mxQS2Itw6EYniV
	Q7HZHphPnSUwkh85SW4ycFyz4GWFDiLn2jV46qNbfDC0inH27OHUfiC7Pt1P33Jv9MO/3d4v06JUr
	YEjhFtHoO5XP7emsrNuOeCQvj/wjS7zYVxLTh1K8KZpQIGeQnESdTzYapJxjSC2Bc8GVdV+RmD/ZX
	vSUdK4HGx0uHNJBf2kKV6evDszn/qGyxeipzGl579LN596qx0rZRn5jiLEFX7sD1vSycMcOPRAp6S
	uN1lALt7C+ujdXpknfcv3fzu2PkCn9/WUQvxFyxAUiC+5R/pnRKRJ6xvrB/LqR341jLg6YfpS7Edy
	M+JuhBAue4kH4QRY/W/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfu8w-0060w6-2u;
	Sat, 25 Mar 2023 03:00:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfu8t-0060uo-1Q
	for kexec@lists.infradead.org;
	Sat, 25 Mar 2023 03:00:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679713227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDkgtInWoMj0Kl4LkfGevv4ADacM/sg4LTkpZaBnKrc=;
	b=UgYRqXvVtMhnhb0UdUDBPpsrYHlHut5Uc+GdZvThZOCT5vvSQhd1rbrYxTmqjg49/zSl4u
	5wpvMINnQSZzsVCK1ePIdxLU4u9UsLPVGFUu5Q3xsFOadXEfDYOblPserIhKgut+dS8qYj
	51JhebjLUmgguudhlIQ+Y+kmPoDwtBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-thQ0X1QGPmmYShG0G3q_5A-1; Fri, 24 Mar 2023 23:00:23 -0400
X-MC-Unique: thQ0X1QGPmmYShG0G3q_5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FC5887B2A1;
	Sat, 25 Mar 2023 03:00:22 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CD24140C6E67;
	Sat, 25 Mar 2023 03:00:15 +0000 (UTC)
Date: Sat, 25 Mar 2023 11:00:11 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
	horms@kernel.org, John.p.donnelly@oracle.com, will@kernel.org,
	kexec@lists.infradead.org, ardb@kernel.org, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on
 crashkernel memory region
Message-ID: <ZB5ju+xxCwZ7DDA5@MiWiFi-R3L-srv>
References: <20230324131838.409996-1-bhe@redhat.com>
 <ZB3Zx85Ajnhzq3Pt@arm.com>
 <9ca6f729-989d-654a-83e6-c89d8f65c69d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ca6f729-989d-654a-83e6-c89d8f65c69d@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_200031_693289_6C186667 
X-CRM114-Status: GOOD (  16.48  )
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

On 03/25/23 at 10:14am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/3/25 1:11, Catalin Marinas wrote:
> > On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
> >> Baoquan He (3):
> >>   arm64: kdump : take off the protection on crashkernel memory region
> >>   arm64: kdump: do not map crashkernel region specifically
> >>   arm64: kdump: defer the crashkernel reservation for platforms with no
> >>     DMA memory zones
> >>
> >>  arch/arm64/include/asm/kexec.h    |  6 -----
> >>  arch/arm64/include/asm/memory.h   |  5 ----
> >>  arch/arm64/kernel/machine_kexec.c | 20 --------------
> >>  arch/arm64/mm/init.c              |  6 +----
> >>  arch/arm64/mm/mmu.c               | 43 -------------------------------
> >>  5 files changed, 1 insertion(+), 79 deletions(-)
> > 
> > This series works for me and it has a negative diffstat as well (though
> > I'm sure people will try to bring it back ;)).
> 
> After the write protection is removed, it is recommended that crc32 check
> be added. However, it can be added later.

That's a great catch. We have calculated the checusum with sha256 in
user space and kernel, and verify it in purgatory in user space.
However, arm64 seems to not do the verifying in kernel if
kexec_file_load is used. Please see kexec_calculate_store_digests().

If stamping happened, the checksum verification can help us spot it.
Yes, this can be added later. Thanks for raising that.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

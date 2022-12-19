Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EB6C4332F
	for <kexec@archiver.kernel.org>; Mon, 19 Dec 2022 07:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y7CrWxyUOMgW96ZySmF9sPo2EPEW5W7/IvOFTHRQlbs=; b=kdLgYChgvBPDUd
	s9n7EBipkFk+oDziho6xdiyyuzg4bZpITbKiuMeB8Fwky7reBmqiK5hcJ2hruCKWqr60X847HeDaI
	MOYO3NyuFqmtkxQBn8m1Msk89NEz1XglNStATSQkSQRvUGrSQ/EobfN6ky/Z89gPu5294wryyPnOT
	RCHs1VGYykopb5rallxJMnBI43ZHwjIvs1Yi7BZe8t0+4AB+8jNq673tl/lC3X1okBZSKh+dx837C
	ZuEc8xskb61V5lqTkmCgm8nB9UbSe6Mz53aXmBrXCMm9v0iW1E/jawJi6ZQpeGJGgRNL2xHNgy+/7
	pUE2fregxmKrxTgrr6Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7A9K-009bko-11; Mon, 19 Dec 2022 07:01:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7A9F-009bfX-U7
	for kexec@lists.infradead.org; Mon, 19 Dec 2022 07:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671433273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lroQEaauydsDS3XBI9G0FXXDhHdZpuGziiitGfhqAV4=;
	b=a1PWm23cQIZA0UEeKGzPU4UJ5cvtTfSY8G+3QYbS/LyCLudPt532V90WHEt5gMVrG8V0l/
	8y99aFtND1Aamt23UxooyXwuz3HB9kKXnNNQa1IPCA7CDCn+yiRNKdSf7XpnfH+FBebV5Y
	WLKDh0t71RZZZ4ZzPkQ8g6fHUlYmxzI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-Mw9N3ZP3Op-oZqbhAUTCxg-1; Mon, 19 Dec 2022 02:01:09 -0500
X-MC-Unique: Mw9N3ZP3Op-oZqbhAUTCxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CDBC811E6E;
	Mon, 19 Dec 2022 07:01:09 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 797AF2166B26;
	Mon, 19 Dec 2022 07:01:07 +0000 (UTC)
Date: Mon, 19 Dec 2022 15:01:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y6AML4BGQgeiwJ/j@MiWiFi-R3L-srv>
References: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
 <20221217155842.GA389338@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221217155842.GA389338@bhelgaas>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221218_230118_201536_6B1434AA 
X-CRM114-Status: GOOD (  18.91  )
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

On 12/17/22 at 09:58am, Bjorn Helgaas wrote:
> On Sat, Dec 17, 2022 at 05:48:51PM +0800, Baoquan He wrote:
> > On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > > remove it and just use the generic version.
> > 
> > I ever posted below patch to do the same thing, Andrew only picked the
> > memory leak fixing patch.
> > 
> > [PATCH v2 2/2] kexec_file: clean up arch_kexec_kernel_image_load
> > https://lore.kernel.org/all/20220223113225.63106-3-bhe@redhat.com/T/#u
> 
> Indeed!  Sorry, I wasn't aware of your previous work.  If you repost
> it, cc me and I'll be glad to help review it.

Sure, I will repost the patch for reviewing, thanks a lot.

> 
> > > Bjorn Helgaas (2):
> > >   x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
> > >   kexec: Remove unnecessary arch_kexec_kernel_image_load()
> > > 
> > >  arch/x86/include/asm/kexec.h       |  3 ---
> > >  arch/x86/kernel/machine_kexec_64.c | 11 -----------
> > >  include/linux/kexec.h              |  8 --------
> > >  kernel/kexec_file.c                |  6 +++---
> > >  4 files changed, 3 insertions(+), 25 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

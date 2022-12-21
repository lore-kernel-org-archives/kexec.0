Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35189C4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jJco6gifr2PMUMZYSs7iRLopekd63j9Sl6HCtfkyTkA=; b=B8MTZsDauAlFWq
	BdUi2B8kAwJnlyuQ+veStf/94y27vP7HUr8g/8OUSKlJijkepaboUD0b340oSyKy3+R0Gj0lv6Lco
	vN0cV7q1fGP6CqWmpZ3aqRWww75nqMob1rDgvDPWRj8AZtYQDjgpMYrZSEIEjRURpQ44fElIMriA8
	YCZ1ViNGKUC4ZDygJOJObfEcUxFJRoTb1WJy4XsT9smaITd6fEd0FfCUezsLu7i9ZG+TTby4lrZve
	BZE3cxKYCKioVgvQo4dV6TQcTmN30127rabCJ4ZNVTP3QaK6wxi3+8g2Y+pjOS824T/b/f0zAmJmI
	82fVcmib6QzifrI1oY2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7sBo-00AL8E-II; Wed, 21 Dec 2022 06:02:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7sBP-00AKdA-32
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 06:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671602545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFARvs3vX7F5UIgsIk8mEBbeBoqPfv+G3BzvbbBHE5g=;
	b=AxeJLbeC2q2KjRkpfVxrcacdHhLBz7P2AsCcEbfCXdrOMpugnn1z3IWZb75w/3QPqJwkt/
	ydCbgEX34sAno8Obc3o2q3we963H7G6QJENs9RDZY+tX/loXAxC+xHUgmlniiXwINUvO1w
	XedjzOL49BH8VGHt219vTaeb1Iaiwy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-H8M4KejGNnGeLNOea66BPA-1; Wed, 21 Dec 2022 01:02:22 -0500
X-MC-Unique: H8M4KejGNnGeLNOea66BPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B042858F09;
	Wed, 21 Dec 2022 06:02:21 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB5040C2064;
	Wed, 21 Dec 2022 06:02:20 +0000 (UTC)
Date: Wed, 21 Dec 2022 14:02:17 +0800
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
Message-ID: <Y6KhaSHMsQoT3kfR@MiWiFi-R3L-srv>
References: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
 <20221217155842.GA389338@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221217155842.GA389338@bhelgaas>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_220227_250637_216D5733 
X-CRM114-Status: GOOD (  17.39  )
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

When tried to rebase my old patch to the latest kernel, I realized this
patchset is what I can end up with. I would like to ack this patchset
to make it merged. Thanks a lot for the effort.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

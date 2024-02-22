Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E6FC48BF8
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 07:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=txxPgKXquX/RAvL7+vUUyiguRdPYxtwkHzlgP6a7IAo=; b=dhZdiRr0aLH+l9
	xzWxXyghXy9Auh96ywqJRnI6hFcUQighAg2Tfi9/PlG5bwjiqaGe+Jyk5Rx8D2riRd05xWPy3tPet
	L4m1QVv1LaRbnH08Szh30FXUX8RNKERBfHhJeiouUpuYs/UNOGEjIelVa1c507kwbiY1r8IyxwPX9
	938K4SD0vzTXoTbZWGWqH9o/FwNM481VGNb2oDrveUlOVTolzbrYat9mEDy/Iiclhx9xyAV+XqphS
	A3HXkuQAkV/e79eBkTbGg3x111bLcETXHPYjYKfil1J5VQFYGRD9Dheu/AQj/0hsG3evou4R3vbOY
	bwAlmWk9z7GTRNdasBcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3Aw-00000003lMt-1KLE;
	Thu, 22 Feb 2024 07:07:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3As-00000003lKv-1zsO
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 07:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708585637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j88KzvyAQZThT6aCL8ZS+o2FWYKBFq83FjUT4vcsoNg=;
	b=dAG9+1e/EKoCMf1NgJsULZzlVEBLj/HYQwz0sE4mLdbvwgJP1W8k68VoZDxdxZRgc4cfTt
	Bgv21k54msRQgc8EGhhmw85rsDrIJ370oAFzdjFWHEh5exD5EMgsgfcOFzZSD0MYy1wKiN
	qYAUbIHLF5jV/cp6Kmxyrj5uGCBNhQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-MaV-uow3NFqRm-_MOPABCw-1; Thu, 22 Feb 2024 02:07:12 -0500
X-MC-Unique: MaV-uow3NFqRm-_MOPABCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B19A185A787;
	Thu, 22 Feb 2024 07:07:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B5A492BC8;
	Thu, 22 Feb 2024 07:07:08 +0000 (UTC)
Date: Thu, 22 Feb 2024 15:07:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, linux-s390@vger.kernel.org,
	piliu@redhat.com, linux-sh@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, ebiederm@xmission.com,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up related
 config items
Message-ID: <Zdbymex3ABImSwI3@MiWiFi-R3L-srv>
References: <20240119145241.769622-1-bhe@redhat.com>
 <9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
 <Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
 <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
 <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_230718_592716_50368EF2 
X-CRM114-Status: GOOD (  19.91  )
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

On 02/21/24 at 12:57pm, Andrew Morton wrote:
> On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
> > On 04/02/24 8:56 am, Baoquan He wrote:
> > >>> Hope Hari and Pingfan can help have a look, see if
> > >>> it's doable. Now, I make it either have both kexec and crash enabled, or
> > >>> disable both of them altogether.
> > >>
> > >> Sure. I will take a closer look...
> > > Thanks a lot. Please feel free to post patches to make that, or I can do
> > > it with your support or suggestion.
> > 
> > Tested your changes and on top of these changes, came up with the below
> > changes to get it working for powerpc:
> > 
> >  
> > https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
> 
> So can we take it that you're OK with Baoquan's series as-is?
> 
> Baoquan, do you believe the patches in mm-unstable are ready for moving
> into mm-stable in preparation for an upstream merge?

Yeah, I think they are ready to go for merging.

For Hari's patchset, the main part was planned before. And I am not
familiar with fadump in powerpc, the Kconfig fix from Hari is a good
guarantee with the expertise. Surely, I will await Hari's comment on
that.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E19C624B4
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s+LcJ+J7x1Bwh0Wdz0FElt38Lvjm9Lfg1NKKkohmDKE=; b=oR2Ainh+/g5wWA
	x7xPsOJ8hfOpWp84RUNPym9nj5hxVkrE/UF2K+LeXALsV1uNGN5CNslBC/0QDBYnAbKAQFk2XmKwT
	FL9/ZrZC6kzVkOMLYHvBIlTp3/C+q/pjidSWLlf3G3N8uejwTLTB/TQMudIR1i0Oa6abEk+2Tf5f1
	7LW97Tb0N3HpduC+57yRCYjic1GdZpTrbEnrd9rwRJpskABCJ7oN+qzym/LxjjpmIbq9Kpq1RRUAv
	NYTF54VNti1mAYDBXejP/bckmwONK3q9NA0PATV//S/D/rccO0OoE0Ksb0jMTET9da5J1q1RJZfcj
	3F5GwS6Yq9WRsDH9U5+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6AkV-0051WM-2Q;
	Thu, 23 Nov 2023 14:32:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6AkT-0051Ue-1w
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 14:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700749926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yzx9qOvDK5HqVyciE7l1diyIFw6Eysuxf8uBBLbzRo=;
	b=TQI+bMu/E8altjBqMoA2MxLAL7z4d9P8u4lA/Mp6yBFrSFB2CsAai8XLyCgjJkGlQ7JMlb
	4PpbfePnDc/yJPGNgDOlMnX2bzORbjWSiTqvyqNbahrtpYRvoNqx/Z1qLrYyVq5eS5KJNS
	QrUjvyd7ukIKGMuNRjOf6T4oWL/bIh8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-_SGWWHWgMVObeNhXt_Ynzw-1; Thu,
 23 Nov 2023 09:32:03 -0500
X-MC-Unique: _SGWWHWgMVObeNhXt_Ynzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B69673C0BE39;
	Thu, 23 Nov 2023 14:32:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 14ACC5028;
	Thu, 23 Nov 2023 14:32:01 +0000 (UTC)
Date: Thu, 23 Nov 2023 22:31:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, ignat@cloudflare.com,
	eric_devolder@yahoo.com
Subject: Re: [PATCH 3/3] s390/Kconfig: drop select of KEXEC
Message-ID: <ZV9iX5HNftPjNr3S@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-4-bhe@redhat.com>
 <ZV9W5AmmYhCFmN9e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZV9W5AmmYhCFmN9e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_063209_735860_808775F4 
X-CRM114-Status: GOOD (  21.99  )
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

On 11/23/23 at 02:43pm, Alexander Gordeev wrote:
> On Thu, Nov 23, 2023 at 03:36:52PM +0800, Baoquan He wrote:
> 
> Hi Baoquan,
> 
> > No proof is found to require that S390 architecture has to select
> > KEXEC. At least from my testing at below, dropping select of KEXEC won't
> > impact anything.
> 
> It does impact the outcome of defconfigs.
> Namely, CONFIG_KEXEC is not set with this patch.

Right, CONFIG_KEXEC won't be set defaultly with this patch applied.

> 
> > ===testing 1===
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_CRASH_DUMP=y
> > ===
> > 
> > ===testing 2===
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_KEXEC_FILE=y
> > CONFIG_CRASH_DUMP=y
> > ===
> 
> Unfortunately, I do not quite realize what these testings were
> and what is the difference between the two.

Both these two testings have CONFIG_KEXEC=n, and building all passed.
I wound't present their difference, but two cases where no CONFIG_KEXEC
is set and no dependency on CONFIG_KEXEC is seen.

> 
> > So drop the select of KEXEC now.
> 
> I suggest dropping this patch. Once the previous two are upstream
> we would remove 'select KEXEC' from Kconfig together with defconfig
> updates.

I see your concern, will drop this one in v2. Thanks for checking these.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/s390/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 3bec98d20283..1aec2e692dca 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -217,7 +217,6 @@ config S390
> >  	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
> >  	select IOMMU_HELPER		if PCI
> >  	select IOMMU_SUPPORT		if PCI
> > -	select KEXEC
> >  	select MMU_GATHER_MERGE_VMAS
> >  	select MMU_GATHER_NO_GATHER
> >  	select MMU_GATHER_RCU_TABLE_FREE
> > -- 
> 
> Thanks!
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

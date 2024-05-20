Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BCDC04FFE
	for <kexec@archiver.kernel.org>; Mon, 20 May 2024 08:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tbjyqkiM2+5a45CcCJDDd5ZCNcstOyUSGhi3J2cmrl0=; b=cLXs2HlcngBUuU
	e1u0myDXaCiD9evUFVUMS9ijNARKcxSVYUFtsLnEBhb7iXyQz5QRfFeYFVz7Lh3GNajePrNSdJKpP
	XmhCG2qBK3/ldkBQwU0LGLvKTtIVDxaHT5Wdeg6jXn4VC13Rl8GE701nljzdX6Z+DUSM29Qz01eXd
	zksx5bKZ/Zh/dlk4AjWLQbtWfpF2qFJjykfxHP7Vb+PSrpV1gsida5hbERiI6SBlA+6RdnG3O36Rs
	kIfjBnh9tyIxwpA4fHYYhIJd0oVZ/ItYGi9by9ezYmc7wnUUBClfxxsLoxsRJ+r1TleH69k/O34TU
	h0OcBOjIDVtATouNrG6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8xyl-0000000Dpk1-0WsZ;
	Mon, 20 May 2024 08:02:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8xyi-0000000DpjN-3mR8
	for kexec@lists.infradead.org;
	Mon, 20 May 2024 08:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716192156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy+7AXtAUnkcBy21ulMkkpiT/tcQ0Mivk0et5OrUGKg=;
	b=VyKYMoQdPnWONyqdhWFP7CvhlgRYSWFynoTDtXOnlnae+swo/NcbWwOeuT3agaA1DSXL5f
	TfBbyiPUAukLRBLuavvcK2G1FTkzvwYofZLJ4z+AuJ862wsaZov6h1Nx4E6tlrJ1ygj5il
	7xKfIeUJurApznnb9eIjuJ9ZaAmJLnc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-sjT0YiC1N9WDfdP_fCDYGw-1; Mon, 20 May 2024 04:02:34 -0400
X-MC-Unique: sjT0YiC1N9WDfdP_fCDYGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97E6A185A783;
	Mon, 20 May 2024 08:02:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E762DC15BB9;
	Mon, 20 May 2024 08:02:33 +0000 (UTC)
Date: Mon, 20 May 2024 16:02:00 +0800
From: Baoquan He <bhe@redhat.com>
To: "David L. Craig" <dlc.usa@dlcusa.net>
Cc: kexec@lists.infradead.org
Subject: Re: What About the Root Filesystem?
Message-ID: <ZksDeLjTYzguL0PX@MiWiFi-R3L-srv>
References: <ZkYjxbfhM+VJP392@able.home>
MIME-Version: 1.0
In-Reply-To: <ZkYjxbfhM+VJP392@able.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_010241_039049_3BEEE999 
X-CRM114-Status: GOOD (  13.82  )
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

On 05/16/24 at 03:18pm, David L. Craig wrote:
> The kernel kdump doc only points to this mailing list for
> further information, so here I am.
> 
> I've been experiencing freezing of an AMD FX-9590 8-core
> box that has become much more predictable with time.  Are
> these disabled CPU-halt states?  I am seeking to get the
> box to spill its guts via NMI->fdump processing.  I finally
> got AltRq-C to do something different but inscrutable,
> causing the light to go on about the inadvisiblilty of
> using the same root filesystem for the dumping kernel as
> the freezing kernel.  Surely there is discussion of this
> somewhere in the past two decades of such capability.
> Can someone please point me to it?

I am curious about the problem, but may not understand what the problem
is. As a non-native english speaker, sometime understanding problem from
a paragraph of words may be more diffcult than the problem itself to me.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

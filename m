Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63FCC5320E
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LoobrKSqB4yWQ8RSkF3XELsihQKJ6XOLoJmHdnjwXV0=; b=Sjyibv/bnsE/Cj
	BlbKc0F2ybeo+P7ucSFX5FwgNcYLN4JTvUBBfrkZ056x+27oCh3c6cNAnXqnxe5DbMRmnoTNIwphY
	7+YRf3ANkhUIfYk95T/mNg7AJeTbxbzrEUisDdjm4etrLeWkqzARU2Ouwxe+FxFSZxxLo9pyY2WEq
	fTncRhEYmRsmI3X+FspwKZCo4IbavCHhWYeSoofw4T7pHA9Ae6kswnuq1nMqLbJpEK26Q+Dm+g9ze
	PYPEX11tmSojHW+UGkeQYAm66z/uU77er32WHnhlDuqUJpnQGUH+goG2udHYZoyDDbLbdNaul6wNu
	ua4mecPwI/KEH5Xa0qlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sis5g-0000000AVHy-3pMX;
	Tue, 27 Aug 2024 09:02:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sis5e-0000000AVGL-0id9
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 09:02:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724749332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=outpxqXc6KM2Oo4/0nqD4smTGWGwDj3DOJrNewpgErA=;
	b=dgp6agpqlSJc07JJsv+eXN33QWCP0zMDcbSFyO+/dICmjEsR74TYOPbkVfyBdhV22122XS
	bgcpMAc2PyVNaeLN3HYs2NVdmdR45Xbt3uU6B+5dYan6RTd5UeWqJ9cYBj9h0QqzsBHH7J
	0Hk9GcWbTVPSB1b+hsuCyB8A9Mf/f0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-rv4ABExJM5egEclpNPuyLA-1; Tue,
 27 Aug 2024 05:02:08 -0400
X-MC-Unique: rv4ABExJM5egEclpNPuyLA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B6471955BFE;
	Tue, 27 Aug 2024 09:02:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 416C019560AA;
	Tue, 27 Aug 2024 09:02:02 +0000 (UTC)
Date: Tue, 27 Aug 2024 17:01:58 +0800
From: Baoquan He <bhe@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Dave Vasilevsky <dave@vasilevsky.ca>, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <Zs2WBgtADYxzVMyt@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
 <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
 <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
 <f355e26eead641f5f281372aadf9dee7de19a4c7.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f355e26eead641f5f281372aadf9dee7de19a4c7.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_020214_301848_8D6CEF75 
X-CRM114-Status: GOOD (  16.53  )
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

On 08/27/24 at 08:37am, John Paul Adrian Glaubitz wrote:
> On Tue, 2024-08-27 at 14:22 +0800, Baoquan He wrote:
> > About why it's enabled by default, as Michael has explained in another
> > thread, distros usualy needs to enable it by default because vmcore
> > dumping is a very important feature on servers, even guest instances. 
> > Even though kdump codes are enabled to built in, not providing
> > crashkernel= value won't make vmcore dumping take effect, it won't cost
> > system resources in that case.
> 
> OK, thanks for the explanation. But as we have found out in the mean time,
> the assumption was wrong to enable it by default for all architectures as
> some architectures cannot boot a crash dump kernel with their default bootloader
> but only through kexec.
> 
> Can we have a follow-up patch to disable crash dump kernels where they're
> not needed? I mean, not every platform supported by Linux is obviously a
> x86-based or POWER-based server.

Yes, while isn't Dave's patch a good one to fix it? In Dave's patch, the
default enabling of CRASH_DUMP has been taken off, change to rely on
ARCH_DEFAULT_CRASH_DUMP provided by each arch.

 config CRASH_DUMP
        bool "kernel crash dumps"
-       default y
+       default ARCH_DEFAULT_CRASH_DUMP


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

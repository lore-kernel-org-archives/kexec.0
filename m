Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4955EEB64DE
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 02:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bprryOAZlW7mLKCESXW7NRXALvlTBtyFL1A+QeVHyPE=; b=rlRWmS3r4ZBqNC
	lKWodllBdWrfrmiIqW2bmKjOeZj0Jm72CNyLjAFLfX0jBdbRU6eZ1/JbJ6adnsluYHjMyM4KnuEV0
	z6tayV8wY8hmqMy5QFxklk9zLvwKMz1SppIAGNeuVslV9V9iXnLfeNiC+hL0kXpN0RMO+B5yIi5/t
	7tXTWZ7pgA8Ug0QcmQQ2+Rr2lDrXyfazV+xSQdGLEVIB7FuBmXtn3P1C6GmwZqjHaTL/9Edq7Qomt
	OA7nBo5Gi1MVDck8BHUuVQoaCiNTFFpKoEKdFAeK6uR7J5SVECcFhzAiSKc1Rae0CbQSadaRV2AXz
	9Q7tVwRfIrhFjs6rR7+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snUFl-00000000IDG-1pz9;
	Mon, 09 Sep 2024 02:35:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snUFi-00000000ICn-0tZC
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 02:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725849341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjtEHt8bSvmRde39BXklX+Lti/JhyV/GdXZeYzGRgUo=;
	b=JE3Xob7DSfq1jc7QanatXchA6OSj5jmja1XIJICXceB90/42vGdNk0FaYa1J8gQy4QijNI
	j+uFUHYh7suhARVni34YLqpFsQaYoo9yJYTi4ao0cbted5MMHbFMqRneKP7vm7ol+B2vL7
	nhBLEGt+w8Q+DQTY/C+ETCaFmXkhqKc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-stwFWWh1NuS5XhhFDaflqA-1; Sun,
 08 Sep 2024 22:35:37 -0400
X-MC-Unique: stwFWWh1NuS5XhhFDaflqA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24C7119560A5;
	Mon,  9 Sep 2024 02:35:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB3C1956086;
	Mon,  9 Sep 2024 02:35:32 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:35:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <Zt5e72DEl0K8cQe9@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_193542_342447_5D2BB63A 
X-CRM114-Status: GOOD (  10.65  )
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

On 09/08/24 at 03:57pm, Dave Vasilevsky wrote:
> I received a notification from Patchwork that my patch is now in the state "Handled Elsewhere".[0] Does that mean someone merged it somewhere? Or that I should be using a different mailing list? Or something else?

I guess it's powerpc dev's patchwork which automatically grabs this
patch to do some testing? Becuase ppc list is added in the CC. I don't
think this patch has been picked by people because this is an old v1 and
there's concern about it.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

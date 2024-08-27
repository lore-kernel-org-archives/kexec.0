Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47469C5320E
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CrokUJpqXEQoYiHOdrcb6v7o6a/PaeHuUe2GeKaptPM=; b=P2FrvsRnhMISvE
	AIvyTMB+G6stwxGXDDKcgUyvGbjoD4FGVncKAjC0SR2Udo9DAxS10P3GE9hcfImtSokolV4HhDqEf
	j8slSd2rpfc8J4G0ZDVUtR4QkvF2QQ1yxBPooEyeVHMY93Ib1PAOJKznL6L1ymbOYLnYnnNibmEYQ
	Dwks/COLi4DQOrpUeEJsFwEUSSMVkVx57jN4u/3GpYg1EU49ywoBltm2/4sT4FbG9GUHF6eVVOVyu
	6hU9jEks4e+XJ8htqBTZ+0udr+JxPG/NLLCtDo6z02KIvL981pwUdduIrp+sFlojHetDw2bQTnPuC
	jLEHAb/9tOY0jNvVlR3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sipbN-00000009zUI-2spS;
	Tue, 27 Aug 2024 06:22:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sipbK-00000009zTj-24qw
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 06:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnUXRhsOmY1WUumG5iPOdpGy9YuwRoJOmvxNn5A0R3s=;
	b=els/zeSKV8IPnFI0Vp+inPC1sq0qwaiZhE5HIQ/C0WGSY01KFTpozvebpOt3YYpThle/8l
	ZfwzMLgNUuYf3w5UN6K/zhXVeyWqFU1ibLQ9GIVL7kYZGbbGh/7ChMrYl3qf9j2QcYYxAv
	uS4f6DryBsJ02LJUV3ActDdoc36C0kA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-t7YesfeCNKOOuuMJdnOrxQ-1; Tue,
 27 Aug 2024 02:22:39 -0400
X-MC-Unique: t7YesfeCNKOOuuMJdnOrxQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C07E19560B1;
	Tue, 27 Aug 2024 06:22:36 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C25D219560A3;
	Tue, 27 Aug 2024 06:22:33 +0000 (UTC)
Date: Tue, 27 Aug 2024 14:22:28 +0800
From: Baoquan He <bhe@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Dave Vasilevsky <dave@vasilevsky.ca>, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
 <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_232246_626170_2705C265 
X-CRM114-Status: GOOD (  15.92  )
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

On 08/23/24 at 08:16pm, John Paul Adrian Glaubitz wrote:
> Hi Geert,
> 
> On Fri, 2024-08-23 at 15:13 +0200, Geert Uytterhoeven wrote:
> > IMHO CRASH_DUMP should just default to n, like most kernel options, as
> > it enables non-trivial extra functionality: the kernel source tree has
> > more than 100 locations that check if CONFIG_CRASH_DUMP is enabled.
> 
> I guess we should then revert that part of Baoquan's original patch.
> 
> > What is so special about CRASH_DUMP, that it should be enabled by
> > default?
> 
> Let's ask Baoquan who made the original change to enable CRASH_DUMP by default.

Sorry for late reply.

It's me who enabled it by default when I clean up the messy Kconfig items
related to kexec/kdump. Before the clean up, CONFIG_CRASH_DUMP only
controlled a very small file including sevearl functions and macro
definitions. But kernel codes took CRASH_DUMP as switch of kdump.

About why it's enabled by default, as Michael has explained in another
thread, distros usualy needs to enable it by default because vmcore
dumping is a very important feature on servers, even guest instances. 
Even though kdump codes are enabled to built in, not providing
crashkernel= value won't make vmcore dumping take effect, it won't cost
system resources in that case.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

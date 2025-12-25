Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F76EE784BA
	for <kexec@archiver.kernel.org>; Thu, 25 Dec 2025 02:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0yhfpKa36z2S4e97UcvwglyoKQJoQuKZ4hzUKoJo5oQ=; b=ZphTuccDkbrVjt/Yv6h2N2yqRx
	uiede4bD10TDYsc+yJ6lTc/D7lpgIdWVjpS38fXzIozjbyEty6AOdBP90LXq333SlMZ739IKKDsEb
	8YewPeg5FR0ax7ElwAvCvredyrM5wSpsQd+6RWFKGysYvhVvy1AqZGeqTBJQ25uaoGhPVgJamkflf
	T66RcOYl6YyrKQt6BjzscHT2lD0709BrjXZg5ammRNKe3KBZgXbovf6qAPXk1X8hCkfn19wDmjKjL
	1nmROVOUdx6/2Wg3XADJl1fErA0LXfqdeXgRg29TtNRjWfsbT0Ghi5ayP120RvmIoGSmkg0fktxXE
	8NJYplrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYb3q-0000000004x-2fRF;
	Thu, 25 Dec 2025 02:26:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYb3m-0000000Hb7X-2qoy
	for kexec@lists.infradead.org;
	Thu, 25 Dec 2025 02:26:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766629596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yhfpKa36z2S4e97UcvwglyoKQJoQuKZ4hzUKoJo5oQ=;
	b=IUMbKaKj9poHGeZ5e9JYTDLoB4x2nL9kZflwaAxjzwCYHyifycdSU5XqTbsCvAIUt/upUS
	Tj/XNy+kO9gIrCcPMMGSdWXj9MOqy3qAtR+YTZtd9X8L13eKEVDqgu4oErqNOnqpmdwCdD
	DVUgcEsmFpqimop3fgRLA7i2x++0pZw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-XD3JdoSdMca2cw992Umbgg-1; Wed,
 24 Dec 2025 21:26:32 -0500
X-MC-Unique: XD3JdoSdMca2cw992Umbgg-1
X-Mimecast-MFC-AGG-ID: XD3JdoSdMca2cw992Umbgg_1766629590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A7461800365;
	Thu, 25 Dec 2025 02:26:29 +0000 (UTC)
Received: from localhost (unknown [10.72.112.137])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F37A30001B9;
	Thu, 25 Dec 2025 02:26:27 +0000 (UTC)
Date: Thu, 25 Dec 2025 10:26:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	elver@google.com, sj@kernel.org, lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aUygzzVSqg52TANl@MiWiFi-R3L-srv>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
 <aUtd6es8UC0lNf/9@MiWiFi-R3L-srv>
 <edd6e350-5482-4551-aa94-e1ab8d2f9774@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edd6e350-5482-4551-aa94-e1ab8d2f9774@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251224_182639_373559_42A16414 
X-CRM114-Status: GOOD (  17.23  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 12/24/25 at 01:25pm, Andrey Ryabinin wrote:
> 
> 
> On 12/24/25 4:28 AM, Baoquan He wrote:
> > Hi Andrey,
> > 
> > On 12/04/25 at 05:38pm, Andrey Konovalov wrote:
> >> On Fri, Nov 28, 2025 at 4:33 AM Baoquan He <bhe@redhat.com> wrote:
> >>>
> > ...snip...
> >>> Testing:
> >>> ========
> >>> - Testing on x86_64 and arm64 for generic mode passed when kasan=on or
> >>>   kasan=off.
> >>>
> >>> - Testing on arm64 with sw_tags mode passed when kasan=off is set. But
> >>>   when I tried to test sw_tags on arm64, the system bootup failed. It's
> >>>   not introduced by my patchset, the original code has the bug. I have
> >>>   reported it to upstream.
> >>>   - System is broken in KASAN sw_tags mode during bootup
> >>>     - https://lore.kernel.org/all/aSXKqJTkZPNskFop@MiWiFi-R3L-srv/T/#u
> >>
> >> This will hopefully be fixed soon, so you'll be able to test.
> > 
> > Do you have the patch link of the fix on sw_tags breakage?
> 
> I think this one  should fix it - https://lkml.kernel.org/r/cover.1765978969.git.m.wieczorretman@pm.me

Awesome, let me apply them and test. Many thanks.



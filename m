Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F66D2F7CC
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bHMFmGN0oadjbgXe1sqHZFT+wgMNJVQ4LPoHUYfdTrw=; b=gzj8cmyLvobi4yq0euxCHPTUAR
	fhfOPUoS9rt2B9FSB/3Bm1q4frTetUDUlfR4j9lGHyLiK3d16PBGZptUMN8sNeXh/TwkPbESak8lh
	BSyO/xulxIlpRUMT1mxzKf0gCGbdgGvol0igFjXqtLudqIREgTNZtwU9/fDhGSirAyixPFU/iCyA6
	2vwsYZ1s7ef0jIre6W5GDEi7KLdrJKlmhe+rESWSmyi/lZsRd8nqlsXK3Z6/zeYn0QqXaELgUUHtH
	58ZJiUShiev3pVvTHvOZfka42cXOeNpSSlAADxvdAx6v7kBYubpiwmLtU4Qhg3Gmalw8kvC4zyhMH
	E2d+nJiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRVNb-00000009VJp-1uQi;
	Fri, 05 Dec 2025 12:57:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRVNX-00000009VJI-2ney
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 12:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764939462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHMFmGN0oadjbgXe1sqHZFT+wgMNJVQ4LPoHUYfdTrw=;
	b=hLjZmcs1VUPTTBUOCTAppvGEsBy0Zt/x7yyE0TjMsNWZpJIbBoCCv1yJaRmAs0nKByM4TY
	xI94jTNxA3YsDlZn06nfD8BWpbXfYKMMv9sJ5hFhgx+xVnkxf5fOeYWNhVV7DtP6Wqt2eP
	L72bxsGnPqvb0y4KwAMZfKr89h4i7nU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-zVsvedK7Ppqdvd4IfslGNw-1; Fri,
 05 Dec 2025 07:57:25 -0500
X-MC-Unique: zVsvedK7Ppqdvd4IfslGNw-1
X-Mimecast-MFC-AGG-ID: zVsvedK7Ppqdvd4IfslGNw_1764939443
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4505C18002C9;
	Fri,  5 Dec 2025 12:57:22 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB9719560BE;
	Fri,  5 Dec 2025 12:57:19 +0000 (UTC)
Date: Fri, 5 Dec 2025 20:57:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org,
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aTLWqo03FUqN3QKz@fedora>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
 <aTKGYzREbj/6Hwz6@fedora>
 <20251205110311.11813A10-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205110311.11813A10-hca@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_045743_772024_50B7CEE3 
X-CRM114-Status: GOOD (  24.20  )
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

On 12/05/25 at 12:03pm, Heiko Carstens wrote:
> On Fri, Dec 05, 2025 at 03:14:43PM +0800, Baoquan He wrote:
> > On 12/04/25 at 05:38pm, Andrey Konovalov wrote:
> > > On Fri, Nov 28, 2025 at 4:33 AM Baoquan He <bhe@redhat.com> wrote:
> > > I also wonder if we should keep this kasan=off functionality
> > > conservative and limit it to x86 and arm64 (since these are the only
> > > two tested architectures).
> > 
> > We may not need to do that. I tested on arm64 because it has sw_tags and
> > hw_tags. And if x86_64 and arm64 works well with kasan=off in generic
> > mode, it should be fine on other architectures. I am a little more
> > familiar with operations on x86/arm64 than others.  I can manage to get
> > power system to test kasan=off in generic mode, if that is required.
> > From my side, I would like to see x86_64/arm64/s390/power to have
> > kasan=off because RHEL support these architectures. I need consult people
> > to make clear how to change in s390. Will post patch later or ask other
> > people to help do that.
> 
> We are aware that s390 support is missing / does not work, and will
> provide something. I guess something based on this series would be
> good, or are you planning to send a new version anytime soon?

I will send v5 soon to address Andrey's concerns. That would be great if
you or any s390 expert can send patch based on v5. Thanks a lot.



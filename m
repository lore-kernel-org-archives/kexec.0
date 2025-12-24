Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB77E74907
	for <kexec@archiver.kernel.org>; Wed, 24 Dec 2025 03:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PEnYiKFC1BPTOh2lEem5yt8CWGQxdCaNcVZbw2GCpAY=; b=R67GjGEgaYEiMZPI7ilLAoArs8
	L2whx/Q9bziV1mk8jeJD7EzKlXEfj4hvrEufo1OPCzbVe0IHBi5Bwk+y0vY9QpMjfStusXQZbhlzE
	bYVxZuQlRfWQ0EzfBiuRu4A9SivMlDeLCo7YsEcuW6At2E22SrEG9rkDXoJQgVHh4m6vifuR69i79
	Nj80TAWgov5VjLXOv3uGJN+ls50AtqiVEjQtOhkZkmNOULsatl9N23yRhM7ulSiOnNFQeIPOs7kTw
	7ItKSEm/0QX+L6/gvL/fEkgmyIrKFjTi6rjIHaNkjoi0RwV35YBMd/7f6QE1vEzQ+EPPEKkO2XQC7
	imeKLofA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYFYf-0000000GMes-0jji;
	Wed, 24 Dec 2025 03:29:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYFYb-0000000GMeP-19sb
	for kexec@lists.infradead.org;
	Wed, 24 Dec 2025 03:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766546938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEnYiKFC1BPTOh2lEem5yt8CWGQxdCaNcVZbw2GCpAY=;
	b=N/wKxGjMUzoxuoPjb1H1PFt0iS1l0InpUxbvjTRpJbn2DIL0ZuVBkeUxKwhk3ru554iiBB
	WR+jAR6wUHnG7gIu7WykB8qyapagkGAXxlSS1FZF3VxixDBRieMWlKgXVfM65OrDKjKR8U
	vKzo2Q+zmy/Fv0v2lsXQXsZGyGPlmgw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-69w2rVsPMJybW1GIqvYelA-1; Tue,
 23 Dec 2025 22:28:52 -0500
X-MC-Unique: 69w2rVsPMJybW1GIqvYelA-1
X-Mimecast-MFC-AGG-ID: 69w2rVsPMJybW1GIqvYelA_1766546930
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ABDC1956046;
	Wed, 24 Dec 2025 03:28:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C99551956053;
	Wed, 24 Dec 2025 03:28:46 +0000 (UTC)
Date: Wed, 24 Dec 2025 11:28:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	elver@google.com, sj@kernel.org, lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aUtd6es8UC0lNf/9@MiWiFi-R3L-srv>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_192901_389964_D39CBEC6 
X-CRM114-Status: GOOD (  16.96  )
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

Hi Andrey,

On 12/04/25 at 05:38pm, Andrey Konovalov wrote:
> On Fri, Nov 28, 2025 at 4:33 AM Baoquan He <bhe@redhat.com> wrote:
> >
...snip...
> > Testing:
> > ========
> > - Testing on x86_64 and arm64 for generic mode passed when kasan=on or
> >   kasan=off.
> >
> > - Testing on arm64 with sw_tags mode passed when kasan=off is set. But
> >   when I tried to test sw_tags on arm64, the system bootup failed. It's
> >   not introduced by my patchset, the original code has the bug. I have
> >   reported it to upstream.
> >   - System is broken in KASAN sw_tags mode during bootup
> >     - https://lore.kernel.org/all/aSXKqJTkZPNskFop@MiWiFi-R3L-srv/T/#u
> 
> This will hopefully be fixed soon, so you'll be able to test.

Do you have the patch link of the fix on sw_tags breakage?

I am organizing patches and testing them for reposting, but still see
the sw_tags breakage during boot on arm64 system. If you have the
pointer about the fix, I can grab the possible unmature code change to
make sw_tags mode work to finish my testing.

Thanks
Baoquan



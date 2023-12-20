Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52BBC3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uqXA9UpFt4yWjKyEDHfb1h/bCkOsiOpOidlFzIEhAZ0=; b=Jif9NaVmi5SBN7
	0iB3k2zqEjekawDOegWu9r+UAvpf97WjOSWaCdUCnj0PTJdlWS0ByzyieRLMSiTmCXq9w3qFQlOcV
	oPIsUQrfjK9C+uHMDJoRTyn/UCYpcyYmmAyLTQB/dfGJAxrX+/HsW+u22aOpQLAVWWlp1EvK9xq/S
	J2fKxmOUsTu6+ZEGuH8A7dAn0UareQD+eC4ssYa+nzlxK4END3GBf46n+vUBLBnCGGum3dKBDAH67
	X4C6rCPB1jZJDPQQKkwJMYa5PrM8Xuz2KFRGiVIQH6xM8lGuDoQ+fDn1o58EBubuh+OgtivPUgX3N
	zKL1PSiz5TUD6SPSvP1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG61n-001FcY-1w;
	Wed, 20 Dec 2023 23:31:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG61l-001FbW-10
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 23:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703115056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpHzyetdfnFa+em1B7GLhPjt2d/LNwN97Oht9kcvxy0=;
	b=G5CC6tV958fNdRre1M9LmM1aSB1w67VhvWWUPhU46LE6mfwkVkLkQ19QISV2M15tY1LzM8
	Hv2Qvuz6y0maWJW2OuVZc0p1x2pNdzMsESyObrai43nLKmB0+8SpzD7ud/oUu9k1xP6tsR
	vneg+wE0EsJWYZg/4OWzo22089r8oVA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-si85M4twNxiIF802LZPQqA-1; Wed,
 20 Dec 2023 18:30:52 -0500
X-MC-Unique: si85M4twNxiIF802LZPQqA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54B173C00094;
	Wed, 20 Dec 2023 23:30:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C10492BFA;
	Wed, 20 Dec 2023 23:30:50 +0000 (UTC)
Date: Thu, 21 Dec 2023 07:30:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, joe@perches.com, nathan@kernel.org
Subject: Re: [PATCH v4 5/7] kexec_file, ricv: print out debugging message if
 required
Message-ID: <ZYN5Jy4PVh3ghbxN@MiWiFi-R3L-srv>
References: <20231213055747.61826-1-bhe@redhat.com>
 <20231213055747.61826-6-bhe@redhat.com>
 <20231219-twitch-many-ca8877857182@spud>
 <ZYJsBW0Y7Y+XhSgf@MiWiFi-R3L-srv>
 <20231220074634.cd736ec567cd7adf1e4c6d7e@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231220074634.cd736ec567cd7adf1e4c6d7e@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_153101_438789_8D19CC94 
X-CRM114-Status: UNSURE (   9.21  )
X-CRM114-Notice: Please train this message.
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

On 12/20/23 at 07:46am, Andrew Morton wrote:
> On Wed, 20 Dec 2023 12:22:29 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Could you help fix the typo in subject?
> > 
> > [PATCH v4 5/7] kexec_file, ricv: print out debugging message if required
> >                            ~~~ s/ricv/riscv/
> 
> I made that change.

Thanks a lot.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

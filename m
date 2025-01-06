Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396D1E77199
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 06:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ECj6xbOSydsrQ0h3y60hbN6oNhcXb1gzQeH/Gov1IA4=; b=ekTNotbv/itpGxxrkYfKlhpVN1
	xPDayV/KI3raCivBY5xngnaR2gQzjN4b95VZDEIzPBtQ6rVa+dvbRTgFnsl3U7lFiPySXHl3SnlnS
	+7Z0qv2oTftND/NicLJ0XikXIJEvW90AKPGBeo4aVZXZBIKEnEIf2gUn3+DcL60ZXMolHYM9unZ9m
	BKotlN8tA5P8zRjS61E/4q8vLbQYk/kykGRB/5fILOoeO/Q6vX95QIuy/3wXpEaAPH7XYZBj3Lvgg
	WGJKCpeK2TWXdN0jzVQ7kVTjWrUwFKBqJX4ElvynzbIioIXbdRfjYhlBl91iF9PQMnU5HxcnH2t79
	GLImeaaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUgHe-00000000Gnx-0cZ8;
	Mon, 06 Jan 2025 06:08:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUgHb-00000000GnY-3M71
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 06:08:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736143691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECj6xbOSydsrQ0h3y60hbN6oNhcXb1gzQeH/Gov1IA4=;
	b=TIJG+e+fRUdqDAOKQgMSmC2na2rCeaLrDFo8KMDSpSQBhTCAHVkMHTOP16JA2DHwjXCOBh
	VT/+NJulOklJdmN0faw8PlMJ/pOku+JyOAWvpksfC0kmxdrXR6RYUID5Xf5Mg5MQMgD1IH
	fBhgeE3NAjmgrwtZa4z44mOCq+yQa8M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-jEM1C5x0O9uGyYUyawzKbA-1; Mon,
 06 Jan 2025 01:08:07 -0500
X-MC-Unique: jEM1C5x0O9uGyYUyawzKbA-1
X-Mimecast-MFC-AGG-ID: jEM1C5x0O9uGyYUyawzKbA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A94B91956057;
	Mon,  6 Jan 2025 06:08:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 439E5195605F;
	Mon,  6 Jan 2025 06:08:01 +0000 (UTC)
Date: Mon, 6 Jan 2025 14:07:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 0/5] elf: Define note name macros
Message-ID: <Z3tzPXorz6hzkvy/@MiWiFi-R3L-srv>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_220811_938274_9C82BD7D 
X-CRM114-Status: GOOD (  14.16  )
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

On 01/04/25 at 11:38pm, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> However, NT_PRSTATUS is also named "CORE". It is also unclear what
> "these types" refers to.
> 
> To fix these problems, define a name for each note type. The added
> definitions are macros so the kernel and userspace can directly refer to
> them.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Added a macro definition for each note type instead of trying to
>   describe in a comment.
> - Link to v1: https://lore.kernel.org/r/20241225-elf-v1-1-79e940350d50@daynix.com

The entire patchset looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>



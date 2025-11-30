Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4281CFD2F6
	for <kexec@archiver.kernel.org>; Sun, 30 Nov 2025 02:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Og04/bt+yhEkeXfMP3slZPqApRz+VQNIptaZnXqjJQA=; b=aejDZfuaLv+Qb93YoBncS6b6d9
	1RGSLJWThF5k/v1AvY8XE6lfwsU6tz054O544I56OJKeQjtN4sSZtkIxnAs9qKXeitYz0XxwZEYj2
	ynKnvN/OuoiNgplhLioYA/BK9rAiTK28GpW4E3iwSsIiwhlWc/NHB+CGFrXepgGO6+4RFsHqzip2v
	PYStTM4OOMvKsdlLekQ6FwkX/oSu+AXjuHXnJuEEYUYrOImfL1oegudXxPchAkZyKOJ5PNFcOF573
	jXLrpRMVnNvasSEpv5SUuZoM91MhJWdIOZKEdU+SZEKoequQ1V9OBfTVzVYSXrIZ+zjUjWDjV+W6X
	ZYS2pKxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPXVT-00000001yAY-25a9;
	Sun, 30 Nov 2025 02:49:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPXVL-00000001yA9-3INa
	for kexec@lists.infradead.org;
	Sun, 30 Nov 2025 02:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764470976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Og04/bt+yhEkeXfMP3slZPqApRz+VQNIptaZnXqjJQA=;
	b=NzE/Ft8gqNhuCFWhUQYfcR12hl1DG2Ud//aJfEeMkOO5tA9nSdj0vlNSv8NVL7LTjvrE+w
	xakdZ86Da5kX+2G3eMCIeLVpIdaA0jz3xbnq4Q7ZyXavprY/KJ1ytzSgk9CSIfgk+F3Eez
	zrwr5x49un5YBJWYHAVfZadZzQlgSTc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449--EjyqyECN-2YKkxJ_5cbUA-1; Sat,
 29 Nov 2025 21:49:29 -0500
X-MC-Unique: -EjyqyECN-2YKkxJ_5cbUA-1
X-Mimecast-MFC-AGG-ID: -EjyqyECN-2YKkxJ_5cbUA_1764470967
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC3C1180048E;
	Sun, 30 Nov 2025 02:49:25 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5839F1955F1A;
	Sun, 30 Nov 2025 02:49:22 +0000 (UTC)
Date: Sun, 30 Nov 2025 10:49:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Potapenko <glider@google.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	elver@google.com, sj@kernel.org, lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v4 12/12] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aSuwrkCSxvffKAZc@MiWiFi-R3L-srv>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <20251128033320.1349620-13-bhe@redhat.com>
 <CAG_fn=WpLtVhhOfU3pBKbJ2P3ih+PX4oW+MKAAmHRW0onOgSvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WpLtVhhOfU3pBKbJ2P3ih+PX4oW+MKAAmHRW0onOgSvg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251129_184940_280605_2D7FA0E8 
X-CRM114-Status: UNSURE (   9.56  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/28/25 at 04:50pm, Alexander Potapenko wrote:
> > @@ -30,7 +30,7 @@ static inline void kasan_enable(void)
> >  /* For architectures that can enable KASAN early, use compile-time check. */
> I think the behavior of kasan_enabled() is inconsistent with this comment now.

You are right, that line should be removed. Thanks for careful checking.

> >  static __always_inline bool kasan_enabled(void)
> >  {
> > -       return IS_ENABLED(CONFIG_KASAN);
> > +       return false;
> >  }
> 



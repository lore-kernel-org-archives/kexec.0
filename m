Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1E1D5AE79
	for <kexec@archiver.kernel.org>; Thu,  7 Nov 2024 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JbQ29Mg4zhieVM78G5ReZQAZYSUNjyUHlj4s2pd8kd4=; b=f2oB617KkZoXqV
	NYAoItGK6P84kgQ9r/CasKdqTIeiecVQk51BRfT/ZUQ/g6ZRpV6Dqx9kiLrtg069VStzyDL2426MC
	GvDxfEwJ9TVVC96L/Znvpv3foGZV8gG/iDUMyqUVJnAKWFqqczj8iy6bfB7eNHFPtelCDy/ck2Tul
	LJz0i45UB1S0lSMd1Ngc3DHTHSywpdMC02Yf0QGWNRYjtK6W9gN30b4MoiEjTzEraovJMxNEfEKMa
	aAOp8PSe8w/21cPa6nxHpH/hzuysVqSjTEXh+IM9CLc03gObSSbOSLKDps+w/8kFLCDNP/4z6WAvR
	8ZPi1yjU7w6i4t1bpdqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8yqK-00000006IZH-3RBQ;
	Thu, 07 Nov 2024 09:30:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8yqG-00000006IYP-3hPH
	for kexec@lists.infradead.org;
	Thu, 07 Nov 2024 09:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730971814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zP+DJ0/7LJ4723YZGZpKMGkLZrefkCQcMD0ml6N+XeE=;
	b=GLR8999CBdu6ED3GPczx2MGDHHdSn4vF+36i1XC9DU1q3ukhx1sm4pu7ErL/tTLxD3hKW+
	QwMGP5Vcu2sLMMUYbVoKzl3ekuKVN5Dez5pZDOf3v9f8uaB5PrQORsn4iHagd68NxS4nTA
	fBDH7D64HIiT17p7mJYW1aXuvaKm6Ss=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-hAfAq9TUOdq7hQ4jkyeavg-1; Thu,
 07 Nov 2024 04:30:08 -0500
X-MC-Unique: hAfAq9TUOdq7hQ4jkyeavg-1
X-Mimecast-MFC-AGG-ID: hAfAq9TUOdq7hQ4jkyeavg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D5BE1955F57;
	Thu,  7 Nov 2024 09:30:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.155])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B7EA1956054;
	Thu,  7 Nov 2024 09:30:04 +0000 (UTC)
Date: Thu, 7 Nov 2024 17:30:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyyImAlkcpTHlszJ@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
 <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
 <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_013017_068161_3EC874D7 
X-CRM114-Status: GOOD (  13.81  )
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

On 11/06/24 at 12:20pm, Borislav Petkov wrote:
> On Sat, Nov 02, 2024 at 12:06:18PM +0100, Borislav Petkov wrote:
> > Ok, I'll take your 2/2 next week and you can then send the cleanup ontop.
> 
> OMG what a mess this is. Please test the below before I apply it.

Just got a machine and building kernel, will report here when testing is
done.

> 
> Then, when you do the cleanup, do the following:
> 
> - merge early_memremap_is_setup_data() with memremap_is_setup_data() into
>   a common __memremap_is_setup_data() and then add a bool early which
>   determines which memremap variant is called.
> 
> - unify the @size argument by dropping it and using a function local size.
>   What we have there now is the definition of bitrot. :-\
> 
> - replace all sizeof(*data), sizeof(struct setup_data) with a macro definition
>   above the functions to unify it properly.
> 
> What an ugly mess... :-\

Will clean them all up as suggested. Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

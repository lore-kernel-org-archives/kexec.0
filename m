Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CCBC47422
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DYrsOEERFTnWNfK0ZTluRWuXkGaU+pwM1GynL+a7Vo8=; b=o3zRSr/Uki0k5X
	1K0E8P20X+4gpcrgVWQym8ImCF/ufLN8eo3iqZ48E0oaO8U4DzPTRg2dHYEtF79Tz1noRWfBvYVa5
	OJpproIpcsXh/Ly2WFqwV/5ySm3Z9C1DBlIMHxF+Ka8dX3ca8cpuXdUT6EkFX1gLxdAIN4RBkBco4
	RkVVD5IHHY7iXo/2PRXP5gTBgYqBpqNT6/704KNByoSg/OGRkUTojc3ie6JQ1VdiOWqbP06p8BM4C
	4fjr1ljG4d/POheHvEvLdNxzHA45PkfUnojQQK8JKua+aje2pRFn2T6IfZtUa6PQf+ahZieoTgXgK
	dugRmBiZ5TInsHGnFg4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSePH-003jAx-18;
	Wed, 24 Jan 2024 14:39:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeP5-003j70-2y
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 14:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706107137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls80tWWITZqF3iJAPsDuzCkVtKDTZBr/hmM0JE5RG5g=;
	b=a9o0e4Y2/Nx+5Sirj35CLJ7eA6BEQOVfkJrkX77SlO43mLIoLqjl5Lnr2R2O0qlwutKpYT
	ZIubIU2ElrFeeohGOctIDfK4eK8YKMCQ2dVIL2wEL1066i3fsUQG8yJ71XchNpR+5Avw/s
	/tBkbUbyGdZo1R7kNm7BKOWzLzdEv2g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-hw5KzothNAWkK-1bR3SVuw-1; Wed,
 24 Jan 2024 09:38:53 -0500
X-MC-Unique: hw5KzothNAWkK-1bR3SVuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 254953806622;
	Wed, 24 Jan 2024 14:38:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 49B49AC03;
	Wed, 24 Jan 2024 14:38:51 +0000 (UTC)
Date: Wed, 24 Jan 2024 22:38:49 +0800
From: Baoquan He <bhe@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH linux-next v3 10/14] sh, crash: wrap crash dumping code
 into crash related ifdefs
Message-ID: <ZbEg+aoWKPww71gW@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-11-bhe@redhat.com>
 <27d8aa3a9e604a7e45c87b7fbc5b1ec2a63f03e3.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27d8aa3a9e604a7e45c87b7fbc5b1ec2a63f03e3.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_063900_060737_E8722ACE 
X-CRM114-Status: GOOD (  15.93  )
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

On 01/24/24 at 09:13am, John Paul Adrian Glaubitz wrote:
> Hello Baoquan,
> 
> On Wed, 2024-01-24 at 13:12 +0800, Baoquan He wrote:
> > Now crash codes under kernel/ folder has been split out from kexec
> > code, crash dumping can be separated from kexec reboot in config
> > items on SuperH with some adjustments.
> > 
> > wrap up crash dumping codes with CONFIG_CRASH_DUMP ifdeffery, and
> > use IS_ENABLED(CONFIG_CRASH_RESERVE) check to decide if compiling
> > in the crashkernel reservation code.
> 
> Comparing this to the patches, it seems you missed the first word
> "Here". Either amend that or write the word "wrap" capitalized.
> 
> I would omit "Here" as it's not necessary and just start the
> sentence with "Wrap".

You are right, thanks for careful checking. I will see if I need repost
to include this update.

> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

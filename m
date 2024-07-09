Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E8FC2BD09
	for <kexec@archiver.kernel.org>; Tue,  9 Jul 2024 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VbeQwiUyfBDPhg4YMcJeSSGVANI6LoRkdkuWalwC0A=; b=0aHI8R6Fh9Lhg2
	jVdf7FqRiGMyUOYy2TD9hsiwQL5mZsHG5hYv1KqVnWnLCWDi8Zr1ZXtUm2BUdX9WeJK8Rj1Aumx/H
	IFU1mgcdgS99kFTU6uOFdQifLfQ+NcxvK0xnkJqT3DnN5cqIScu2RgOJjJWAOyT+Fy1tng8rpYr8h
	G38ZjWRoYGUaIV2t4sEDlyJZLIKgmLbRZDPdm4+v9m6D/HsrYa3VCnMt4uuAhxmnvBU/6nHz7MFXR
	ir7JpUqhWDw/jh3GDZwE0zzkWuUeOGNa4/9bxzT8zoJ8R4s7/Ew5zDnliK8cJkUlfcWmokvZHz1e6
	MAwVzbey0G2imKtYyaLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR8GQ-00000006qUX-0Cja;
	Tue, 09 Jul 2024 10:40:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR8GM-00000006qSK-2ET2
	for kexec@lists.infradead.org;
	Tue, 09 Jul 2024 10:40:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720521597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1HsxreEQuhm/cJ8pO1jF0rT+KIGY8ZQkAVruIP3CKhg=;
	b=YOmHiaJnzyV4xQmWlFud+jy/nC8Ze01IAqitP3bYyto9+S6XnJPmv4U83OMPYUT3PjsWFm
	FYGEN/T2cZTL2mdEy4RZencj/NwH/2yyCujFivgSIFgAfIlpCMP+c2wItZNq2c7mQs5mvt
	FSADuMokppmHjTb8fRYSMY/L1Z0X6NE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-Ry-MDm3LNnernJl-EEleOQ-1; Tue,
 09 Jul 2024 06:39:53 -0400
X-MC-Unique: Ry-MDm3LNnernJl-EEleOQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 445EB1955F0B;
	Tue,  9 Jul 2024 10:39:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE6F019560AA;
	Tue,  9 Jul 2024 10:39:46 +0000 (UTC)
Date: Tue, 9 Jul 2024 18:39:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org, deller@gmx.de,
	javierm@redhat.com, robh@kernel.org, thunder.leizhen@huawei.com,
	austindh.kim@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Message-ID: <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
 <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_033958_663580_D8C213DE 
X-CRM114-Status: GOOD (  19.23  )
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

On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
> 
> 
> On 2024/7/9 17:29, Baoquan He wrote:
> > On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
> >> Currently, x86, arm64, riscv and loongarch has been switched to generic
> >> crashkernel reservation. Also use generic interface to simplify crashkernel
> >> reservation for arm32, and fix two bugs by the way.
> > 
> > I am not sure if this is a good idea. I added the generic reservation
> > itnerfaces for ARCH which support crashkernel=,high|low and normal
> > crashkernel reservation, with this, the code can be simplified a lot.
> > However, arm32 doesn't support crashkernel=,high, I am not sure if it's
> > worth taking the change, most importantly, if it will cause
> > misunderstanding or misoperation.
> 
> Yes, arm32 doesn't support crashkernel=,high.
> 
> However, a little enhancement to the generic code (please see the first
> patch), the generic reservation interfaces can also be applicable to
> architectures that do not support "high" such as arm32, and it can also
> simplify the code (please see the third patch).

Yeah, I can see the code is simplified. When you specified
'crashkernel=xM,high', do you think what should be warn out? Because
it's an unsupported syntax on arm32, we should do something to print out
appropriate message.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

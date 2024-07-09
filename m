Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD3C2BD09
	for <kexec@archiver.kernel.org>; Tue,  9 Jul 2024 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nyj+had62oM9L+vWCAJJizHtRmPvgf2BQdyBTS0ktJU=; b=fGp8vnHNJQLCic
	3J+D0kkEJjlJfMt7BV1OkT/deTP1SYa6uNL259xGcdSnemhfCYD3Gs2r+4+L06525bcJ5C5gux2eS
	scNaPnZ3p/9FPnmwCZ4K59mM3ybgMQGG2MAHg3bd/ueqr2dbPPL/IY9yunsl/iBKm9vuwVdHIt15y
	h/KODf3vP/9wHIvPzTpSdXSFtMgw7IkjsXdHVGuCo5sb6NgB7FQldmrNc2U8zjrWy67L+l+eRokHf
	C38frMMmrq/IoNnHT2MWSGOLtFGJGl1YyT+EhRwuk4SsVReq1pzflIJA8exE2udIWdF8Q8Omfc1UF
	Ma2uHGelzTC5hpI7lX2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR7Aj-00000006cER-2VIJ;
	Tue, 09 Jul 2024 09:30:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR7Ag-00000006cDM-2pxf
	for kexec@lists.infradead.org;
	Tue, 09 Jul 2024 09:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720517399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UrNehCdEOz3kmpljIH4fi/GT8Naw2VAyq67V1zlRwE=;
	b=iqMaUdcuS49pW/PY2h86iwWP4Z+i47J27FvpKcETtmd4VcdpfMtmNc4T/iHSSUVp+ptpf2
	CfsxzIt5a/sRhoP0dVJFvbPVWrGGupHaf1FmOE7mL+lIc7YSghgCgcH/tJ9PSl9O2S4+wv
	DlBnuLfYmgKApmGyQLtgqHAW27geOiQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-M8UPmP1PMDilwb-uNonikA-1; Tue,
 09 Jul 2024 05:29:57 -0400
X-MC-Unique: M8UPmP1PMDilwb-uNonikA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CC6B1936187;
	Tue,  9 Jul 2024 09:29:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0D441955F40;
	Tue,  9 Jul 2024 09:29:49 +0000 (UTC)
Date: Tue, 9 Jul 2024 17:29:45 +0800
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
Message-ID: <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240708133348.3592667-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_023002_836049_A0EECAC3 
X-CRM114-Status: UNSURE (   9.12  )
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

On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
> Currently, x86, arm64, riscv and loongarch has been switched to generic
> crashkernel reservation. Also use generic interface to simplify crashkernel
> reservation for arm32, and fix two bugs by the way.

I am not sure if this is a good idea. I added the generic reservation
itnerfaces for ARCH which support crashkernel=,high|low and normal
crashkernel reservation, with this, the code can be simplified a lot.
However, arm32 doesn't support crashkernel=,high, I am not sure if it's
worth taking the change, most importantly, if it will cause
misunderstanding or misoperation.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

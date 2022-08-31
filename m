Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750DCECAAD4
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=awnRqpxtsz8iU3/0xU/wdNhogSNTKYPH8ne1ucdk6EA=; b=JkdN1gUinoZCbT
	xzrUix9kU5GgezESmfFC7uu4DzhgnniIwzlxz/6kqLyqTeEGjzIJbCsbb0LoIVU2d/pXFe5k7SWKE
	uOiYGm2Kt/Fsbuk5CgFkFMCrqs6NlgVpRk0rQ2TDmiuLXZuHfPdFqZyTmVxzBhz7SHlZEckF3G2yI
	BGLaf05lFTegtKm8acu2cPTurSL4RJw58dRtNKFVksUyOXo52iN7PjHQp3MyS9KRUIGTP4QGnd8ml
	8zJuOx1qB5hgGyPoEsiMubiqTnFHUX3WXh+gLV0Kg9dYxb2YLqOTZEEt/+v3TEfGcxjQcruBt4Z7r
	kGs0Sru171TCxr9MHuhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCO3-002xeA-Be; Wed, 31 Aug 2022 01:19:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCNk-002xVI-M8
	for kexec@lists.infradead.org; Wed, 31 Aug 2022 01:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661908743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0FJw7LLBKzZ9BAQVj7sdve+f9M7Ki+7/qyGyj2VEc4=;
	b=B1AcHRz21mEItGmT/ipll9q5L95AZxB8dKQkMb0mWxiURk8fOINZJOLyEUm0IYoS4DCEOg
	4fxdd8PZ/k11bOCscdP4YwwBCjao/DPcgrpmt6j01DYYmTVa6QD6CQXuIK4Ntj/qTl/WrP
	kHzIcnWlfunVzlHxXuqs52pB1e+HJ1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-djM3oyxSOLaVWSWEQ3DKwQ-1; Tue, 30 Aug 2022 21:19:00 -0400
X-MC-Unique: djM3oyxSOLaVWSWEQ3DKwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8625F811E76;
	Wed, 31 Aug 2022 01:18:59 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B73561121314;
	Wed, 31 Aug 2022 01:18:58 +0000 (UTC)
Date: Wed, 31 Aug 2022 09:18:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Yun Levi <ppbuk5246@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
 <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_181904_835592_B774FCBB 
X-CRM114-Status: GOOD (  11.84  )
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

On 08/31/22 at 09:38am, Yun Levi wrote:
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > Does this need a Fixes tag and cc stable?
> >
> > --
> > Catalin
> 
> IMHO, it seems good to add two tags like:
>    Fixes: 3751e728cef29 ("arm64: kexec_file: add crash dump support")
>    Cc: stable@vger.kernel.org

No, I don't think the Fixes commit is right. It should fix the commit
where crashkernel,low is introduced. Before that, no issue caused. 
So the tags should be:

Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
Cc: stable@vger.kernel.org


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

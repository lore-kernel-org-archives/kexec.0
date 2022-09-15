Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA0DECAAD3
	for <kexec@archiver.kernel.org>; Thu, 15 Sep 2022 01:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+5LipbvZyTEbzalIPtfwZB9i/1yz2rkYyD9ODTg++KY=; b=BxeSJZXoowqScj
	zie9Da7PJtrK/bNf2N63/LBWWdqSO6Np5PI8rAkj442O194I6+MjyvfnjRLp9RE6fDbzva2vyQwXA
	IB4iMh3uTwPpPmaeWM9KIAYRKrrvK7FB0NKKsbu91tElU1dBf4XoghUdyz2qY1aLpaUSK3Cl2TUIP
	aXnX0/IFfD8gd7A2YPqCy7/ziHxVtaUVk+Y480ekT3NfXvEzsX9Gxdr/3vzDq7F/vOZaL47kR0TGG
	1zy4WGRqzuReONSxFCydMr14bfMYW/O3SldBZoLUmnu1udUUuLMzQiPGV6p+qWaNrOb74Cbma57LL
	NG/xlkzLnBACz/ahXFCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYdYR-00EHpB-UH; Thu, 15 Sep 2022 01:20:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYdYO-00EHmS-Fw
	for kexec@lists.infradead.org; Thu, 15 Sep 2022 01:20:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663204829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0bjgK+lBiTyGtI8DZXw0xpj/MCgq70rfPwVLT8sgAVc=;
	b=V3nI21NnaAzYEFySyHJss9FWQpsyvrunybdsx6dBCqu4CkWbgVYfD9I32G1/lY9Mt95PZ5
	7inhU3OFQYIhZV9hJCwiO5SXuyH+A8N6pAlDpAv2y/v7SzlD1y0peoY6Uusn2aATW6wUCL
	w/0aKkHpfGCkDg3CtMCDyAvWh06vCls=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-nDvdEKQIPbKHKqYFLvmIfg-1; Wed, 14 Sep 2022 21:20:27 -0400
X-MC-Unique: nDvdEKQIPbKHKqYFLvmIfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C6B83C0D85A;
	Thu, 15 Sep 2022 01:20:27 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 786D31121314;
	Thu, 15 Sep 2022 01:20:26 +0000 (UTC)
Date: Thu, 15 Sep 2022 09:20:22 +0800
From: Baoquan He <bhe@redhat.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
	akpm@linux-foundation.org, nasastry@in.ibm.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Message-ID: <YyJ91vHulTdjri49@MiWiFi-R3L-srv>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
 <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
 <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_182032_806498_33B7F0E9 
X-CRM114-Status: GOOD (  14.93  )
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

On 09/14/22 at 01:01pm, Rob Herring wrote:
> On Mon, Sep 12, 2022 at 8:01 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >
> >
> > Hi Rob,
> >
> >    can you take this series in your tree?
> 
> IMO, it should be someone that cares about TPM, kexec, or powerpc.
> Yes, there's code in drivers/of/, but that is purely to avoid
> duplication of code across powerpc and arm64.

Looks like a PPC specific improvement, is it possible to have TPM on
other ARCHes? For generic code patch, Andrew kindly help pick them
into his tree if cooked. If it's an arch or component specific code,
we usually ask arch or component maintainer to take it.

For this patchset, it should be merged into ppc tree?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

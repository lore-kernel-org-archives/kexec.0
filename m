Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA686C63705
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zg3IRfCPy9Ukz4/prSXLWvsNRCxcKF2sMFCJWT69AsA=; b=Ef4Y5duRK1MV+8
	37K+tcMaj1niQdx5ZuAMBMTW1n6s+phgCyJNhTu0+W8+mojI57HMTGwjfYWSpj/mDMHQbZXeIlQdi
	00S+SXGy9gdEuWuHUDqjxzvdVwCV2/g3hCrypnSJj2ftUjyULIqgaXYcf39S/fWvok4zyKgDY/iOI
	efqg2+yaw8QO896LoIOokDG93uautAcDYZFZW580Mcy4y6u+coSA2CEQkt4nqdYM3gNrcslTL8mWu
	tuGATNn2yiP5VgSetgyD7hxyaiCIkGZ2Z6pucFeRk8Y/DR0u5AucMkigo8n45LySaW4NwmdYqDy4Q
	wGj4cPEOs/kzmuxrRcZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2uvu-004KXI-MQ; Wed, 07 Dec 2022 13:57:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2uvr-004KQc-QV
	for kexec@lists.infradead.org; Wed, 07 Dec 2022 13:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670421474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3+JlsJ+T+0zmdcrgV//HeWy7oKJHU0vdTnsFfLVk0g0=;
	b=BfPKCejh4tSy0D8eI7bSP5g5Y7nM+fePrVvo0dsA2hMozWA93Wk8cs+IM0lSfm0CvO+mWu
	vNC4NTCNdqzUKmuH0sFflnKwDBx+AdS2r89JePV280lNj9IADDy1+RQSYJ7bRDp3I6XI8y
	dtkNmFnIQ1QnbttFnwbxSXqZPhzwfrU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-2ktB4nM3PwGAN1inS689RA-1; Wed, 07 Dec 2022 08:57:53 -0500
X-MC-Unique: 2ktB4nM3PwGAN1inS689RA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC8D43C38FE8;
	Wed,  7 Dec 2022 13:57:52 +0000 (UTC)
Received: from localhost (ovpn-13-181.pek2.redhat.com [10.72.13.181])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A30E340C2064;
	Wed,  7 Dec 2022 13:57:51 +0000 (UTC)
Date: Wed, 7 Dec 2022 21:57:48 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y5Cb3KGDXijyBXfM@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <Y5BkL8x01KWoF502@zn.tnic>
 <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
 <Y5CKNqtDm5VT+gsz@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5CKNqtDm5VT+gsz@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_055755_970535_BCBFC9EE 
X-CRM114-Status: GOOD (  12.83  )
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

On 12/07/22 at 01:42pm, Borislav Petkov wrote:
> On Wed, Dec 07, 2022 at 08:36:13PM +0800, Baoquan He wrote:
> > Below is my last reply to Eric about my thinking on this.
> 
> Yes, I saw that.
> 
> So think about it: if a CONFIG_ item is not present, what does that mean
> for the code which is enclosed around it?

Ignored by compiler.

I thought we usually need to introduce the kernel config option, then
add code related to it, so that is a wrong idea. It would be helpful to
tell this somewhere in document.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

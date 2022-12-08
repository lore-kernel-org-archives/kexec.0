Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18913C3A5A7
	for <kexec@archiver.kernel.org>; Thu,  8 Dec 2022 04:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wz3cs+PtkhIm3wmYCWx7hxbisVO2TYIrYz45B/wHJ9s=; b=g5oSpczzON0Nia
	PCnPncrrxRNU0+7OJaTpHlsDOHbz5vG70sv9jEFPYviUMr1lkEwq5mKpqsMh3OjbXKq9QhrxALHRa
	SrevktJXWqkPOjWuaCxUXWfLv8wgX651xO2yrGrl4xs4wu6YgoVQB3p5sYlML3WcTYsIn7LSoCZbe
	GnlU6ZDJkIrqg2KLpmIhJKO0wqOkcar/8GurF6qj/PwK84MLzjMz93AKnjE4MtO+XXS3odhS7siqs
	OA0kHP7nEavJ9ZCiBEyIZXpnSzFk8BrfksRM2Ha3dOYbMPhNBhTMbtKccANh4ZRO7tKoLq/yP8W/O
	d0m4rEdk8dPs3bgPQYjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p388J-001Hr6-Aw; Thu, 08 Dec 2022 04:03:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p388D-001HnZ-4V
	for kexec@lists.infradead.org; Thu, 08 Dec 2022 04:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670472209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHrhx6+79Jl3ft6O4UZcMqaubIrHp9gGZE3MaJ/Gw6g=;
	b=IaJCdFz+IBSeyCf09bacTc5RUso2x060cmH9bkhcNwAeCwbzLh+HjJ1w75u8HlYOZPrcW5
	5jG2NN2a26ezc+dy9uf6it6PtmExUtzSLJcAOiIdAdDuWd4UtYIwLr4H7pWPrQgqvN0tLH
	qyFqaUebgvDzFBC+XZ6xeESneh8wADo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-ccbyXt8iMgWzL3wDrvVn1Q-1; Wed, 07 Dec 2022 23:03:25 -0500
X-MC-Unique: ccbyXt8iMgWzL3wDrvVn1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B381181D9F2;
	Thu,  8 Dec 2022 04:03:24 +0000 (UTC)
Received: from localhost (ovpn-13-206.pek2.redhat.com [10.72.13.206])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D62A2027061;
	Thu,  8 Dec 2022 04:03:23 +0000 (UTC)
Date: Thu, 8 Dec 2022 12:03:19 +0800
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
Message-ID: <Y5FiBwepe/M8+yuU@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <Y5BkL8x01KWoF502@zn.tnic>
 <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
 <Y5CKNqtDm5VT+gsz@zn.tnic>
 <Y5Cb3KGDXijyBXfM@MiWiFi-R3L-srv>
 <Y5C3mzQLviL54IK6@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5C3mzQLviL54IK6@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_200333_405202_DBCB712C 
X-CRM114-Status: GOOD (  17.10  )
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

On 12/07/22 at 04:56pm, Borislav Petkov wrote:
> On Wed, Dec 07, 2022 at 09:57:48PM +0800, Baoquan He wrote:
> > I thought we usually need to introduce the kernel config option, then
> > add code related to it, so that is a wrong idea.
> 
> It depends: sometimes it is prudent to add the code behind an ifdeffery
> first but have it not being buildable so that you don't have to deal
> with build breakages but rather concentrate on adding the facilities
> first.
> 
> And you add the Kconfig item only in the end where everything is in
> place and it should build properly then.

I see. Now it's pretty clear to us. Thanks a lot.

> 
> > It would be helpful to tell this somewhere in document.
> 
> Feel free. I mean, it is pretty obvious but if it helps, it wouldn't hurt.

OK, at least people tracking this thread got this now.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

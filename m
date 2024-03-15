Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E950C54E58
	for <kexec@archiver.kernel.org>; Fri, 15 Mar 2024 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z8PfCS/dU4aiVacARhVI3+cA9o83hs933ZS5QRDDS/4=; b=Blxr8S6LjAZdHb
	b4WOlx7lfgXvSuFODH9UcfVd7NJNlCT16KWFWnEXQxM4OyktMInI3L3ie2mQJeZQIr4QdSYohuhKa
	q0bLt/3hgD3Ax50YdweIjAfOeqnPvLp2qDejO/haFtoWoCm7yc8gLq3d3g5gMM8YRJe0RbQSodV5q
	MEE5PaxoeKYuwfalqZ80Mg63XdYDBmy6+gRHPGSg1lZnsW1VwetjxrFdb8nxMji2Ryuui/XFwU413
	Xw/zgU1x8x/qp4zVGZ9RrKhV4L/76z5xrset7TI4OpPcnNw7+pWGEGaDur+VETkEOcbbiXUXojSUm
	/fb+w/UNjVW1K5xZtwQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl3CZ-0000000HDUj-1PdV;
	Fri, 15 Mar 2024 08:46:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl3CV-0000000HDUF-2gG6
	for kexec@lists.infradead.org;
	Fri, 15 Mar 2024 08:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710492361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TpSpPLJARIEcIzi8mXnWA3J+rWEcca5w1++qUpIKz1E=;
	b=WvYrRMa5w1KW5AWWSl8fNUvDPhcnb/ODaGtHzszafcANFrVsvzvmrQ7Hh+POolsGsoMxRZ
	Pre+biU7QekZdFJsEHPyXFwFCsb/xiJIDsar0LSnGwRlkRPyykQfpl2NZ9w7I1FgL09jEN
	c/tu0z2FyFqmP0XeHcShCkdgpjT1zGc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-tQQwnvyFMci6E88p4WoZBg-1; Fri,
 15 Mar 2024 04:45:58 -0400
X-MC-Unique: tQQwnvyFMci6E88p4WoZBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 015C11C01EB3;
	Fri, 15 Mar 2024 08:45:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 586A710E4B;
	Fri, 15 Mar 2024 08:45:57 +0000 (UTC)
Date: Fri, 15 Mar 2024 16:45:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: add kexec_file flag to support debug printing
Message-ID: <ZfQKwuoVEMtAw67i@MiWiFi-R3L-srv>
References: <20231114152030.240945-1-bhe@redhat.com>
 <20231127133218.GA3354982@kernel.org>
 <ZfQCxkuFX+Cb7fhQ@MiWiFi-R3L-srv>
 <20240315083914.GA101331@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240315083914.GA101331@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_014603_771881_A33C7943 
X-CRM114-Status: GOOD (  18.50  )
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

On 03/15/24 at 09:39am, Simon Horman wrote:
> On Fri, Mar 15, 2024 at 04:11:50PM +0800, Baoquan He wrote:
> > On 11/27/23 at 01:32pm, Simon Horman wrote:
> > > On Tue, Nov 14, 2023 at 11:20:30PM +0800, Baoquan He wrote:
> > > > This add KEXEC_FILE_DEBUG to kexec_file_flags so that it can be passed
> > > > to kernel when '-d' is added with kexec_file_load interface. With that
> > > > flag enabled, kernel can enable the debugging message printing.
> > > > 
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > 
> > > Thanks,
> > > 
> > > this looks fine to me.
> > > But perhaps the corresponding Kernel patch should land first?
> > > Let me know what you think.
> > 
> > Ping, the relevant kernel patches landed in mainline kernel, please help
> > merge this patch.
> 
> Thanks, applied.

Great, thanks a lot.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4FEC54E66
	for <kexec@archiver.kernel.org>; Fri, 15 Mar 2024 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zscNyrS3hvzmpiCWWrOTmSd54kzZQW49a9Zl/sNL1nU=; b=XDN2Vge1METYYf
	vpNGDH1brbKFb24vAMvdUuNhDkiBEasRbo6Y9FFA6iwp4YqWofHda2B0Z3NfBa6K2h6PM5gR9ZUHG
	9zecZ0vhKSrZ8sg5LmQkelpDt5C+iNbV4aQSrRMlZ0LKTQnTyjToJokuA2YhmpsOPYPts+q4DNBIm
	MpNwTE8snTMv3poDEGnEjZ86Ho2oscXqwQGIcHvTFhqf3tioz3Uymfn+/7iL8gezRXyIARQ1lXUuH
	Z+IbzHUGsjncBf5o8alwS8maVhe6o7NAPinB82+EfMHeonXaXNW3lm/GJkwnkDTytVUxfv4i/27yP
	t2ZtWZPu6qN52Q5b0/rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl2fc-0000000H6L6-3lB5;
	Fri, 15 Mar 2024 08:12:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl2fa-0000000H6Jb-1ttO
	for kexec@lists.infradead.org;
	Fri, 15 Mar 2024 08:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710490320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJd2ZAVZhRytLTw9IlCtcSLQe1/wfh9mIOIQi8LNjlg=;
	b=BFMJTzQgWBhoiFep6FmZlacLylFDbf4Zq//xb4E2h8dlzJyVqBjGLQJFPG01kWbE3dbWJi
	ujVZjzI8iJTm4G9uR890Ggng2FvlcGwb8QzOROnlj7mea2FFhq3wy0fQT5BTz/cWjbfojh
	kqjUBRgnPnJhbz18+muria9LZ03axgw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-joPUgBMROjy4pm4VDqs3jQ-1; Fri,
 15 Mar 2024 04:11:56 -0400
X-MC-Unique: joPUgBMROjy4pm4VDqs3jQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9383A3803919;
	Fri, 15 Mar 2024 08:11:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EADE63C23;
	Fri, 15 Mar 2024 08:11:55 +0000 (UTC)
Date: Fri, 15 Mar 2024 16:11:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: add kexec_file flag to support debug printing
Message-ID: <ZfQCxkuFX+Cb7fhQ@MiWiFi-R3L-srv>
References: <20231114152030.240945-1-bhe@redhat.com>
 <20231127133218.GA3354982@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231127133218.GA3354982@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_011202_641823_7D71B8AC 
X-CRM114-Status: GOOD (  14.75  )
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

On 11/27/23 at 01:32pm, Simon Horman wrote:
> On Tue, Nov 14, 2023 at 11:20:30PM +0800, Baoquan He wrote:
> > This add KEXEC_FILE_DEBUG to kexec_file_flags so that it can be passed
> > to kernel when '-d' is added with kexec_file_load interface. With that
> > flag enabled, kernel can enable the debugging message printing.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Thanks,
> 
> this looks fine to me.
> But perhaps the corresponding Kernel patch should land first?
> Let me know what you think.

Ping, the relevant kernel patches landed in mainline kernel, please help
merge this patch.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

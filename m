Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D23C4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 02:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ZcW9OfdDuEFYDN+LLdz5Nm8MSHRa5goc3pNtJZmTr4=; b=pNy9Ezo4wCrUYv
	fH84nbocDJRNdNbR4cQePT010OT7iiJudoqRb+2aicF00zehmjuftrKLjznjygR1ksQGFTatbF8sI
	jf/q+DEoIk711JrXceXWsllGDXxbR53ZbhGeczxo0ycbRVmhf/x9QHj7QuZLMBNp+XPh02XhumFPa
	EOFoF0iwfeS8JGYkgRTDzXyYcUu1+TPcdUuYy/JHQLM1311k+WinR3LRAAHXjtjyD/8SERPQiQx8U
	oB4Ah7cFZ5KanfVQe9/SdBk8CRtxlFZQdc+OCRoT9g5r8Zy78nmknJztqf+Y6lPeS8KIPRdcOO5uL
	qfBdpIbZ3sLtdSAxdWdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8X0U-009nJI-0b;
	Thu, 30 Nov 2023 02:42:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8X0R-009nIG-0P
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 02:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701312142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlnSo+MSVJ02cRZKA4QKHS15/hcZAeTG8jw5g53iRBQ=;
	b=KTEIbtRuCvq7Ji64izVP1aK8BB+8UNgVh1J0aJF/YlHohUwjsUsz7+mlsfOj7Mc4rQ+FXs
	a72I+pwvon+Ucg9vwtBOBwOR8rvLDTg13cS8+MhO5CHWXTmZ3yBXnecpo/rINc7WjjvM3v
	mwevwHSdaRG6skd2CvIiIosEZ7aVs+I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-57Xl6FtdMtiy8EYMFLhbpQ-1; Wed,
 29 Nov 2023 21:42:17 -0500
X-MC-Unique: 57Xl6FtdMtiy8EYMFLhbpQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A8722815E20;
	Thu, 30 Nov 2023 02:42:17 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A36F8492BFE;
	Thu, 30 Nov 2023 02:42:16 +0000 (UTC)
Date: Thu, 30 Nov 2023 10:42:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWf2hdX9L8SZhvzB@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbvB/4bKu69zMbd@MiWiFi-R3L-srv>
 <ZWcDiHNCJDNfCbaq@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWcDiHNCJDNfCbaq@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_184223_231288_756890D0 
X-CRM114-Status: GOOD (  11.89  )
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

On 11/29/23 at 10:25am, Michal Hocko wrote:
> On Wed 29-11-23 15:57:59, Baoquan He wrote:
> [...]
> > Hmm, Redhat could go in a different way. We have been trying to:
> > 1) customize initrd for kdump kernel specifically, e.g exclude unneeded
> > devices's driver to save memory;
> > 2) monitor device and kenrel memory usage if they begin to consume much
> > more memory than before. We have CI testing cases to watch this. We ever
> > found one NIC even eat up GB level memory, then this need be
> > investigated and fixed.
> 
> How do you simulate all different HW configuration setups that are using
> out there in the wild?

We don't simulate.

We do this with best effort with existing systems in our LAB. And
meantime partner company will test and report any OOM if they encounter.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

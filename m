Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05806C87FD3
	for <kexec@archiver.kernel.org>; Fri,  1 Aug 2025 03:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NlRwIOX39loAW8Ndc7IEtOq9p1vayc9rGBUA9qXU/0w=; b=yE5NVRIjQFQG6QfsRltGea8/Ia
	Fe+YQYu/8yWzrEH5jFJxskPkmHiQ5HHRQhECTukXU+Scu6/g0WFvWiSGaYcoU3uuUxOTTk04VSICj
	XzlICKQAS/32xz7IEIDQxRhdRru1jld8vmw25H0leMGq18L03rddznymh2gmqD7usXG3DM/pQzmXl
	f3qUW25juOnnhS/Miq7IwjFD8iRuWTa64EftLtp7if6zFR3mP+8VtdIiTUE5fJZ3Q3y7wJQe13Mdy
	4lW3YpYthiNMBGTU4NMQRmvBOGuKA2w9vlAPQrK9i+iTgaMDN7Z4qtot0jVviC3E7INsco8BYZnXh
	ahcK10sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhg4l-00000004rqi-3SHF;
	Fri, 01 Aug 2025 03:04:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhg2j-00000004rgj-1UYN
	for kexec@lists.infradead.org;
	Fri, 01 Aug 2025 03:02:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754017367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlRwIOX39loAW8Ndc7IEtOq9p1vayc9rGBUA9qXU/0w=;
	b=A9OCCutWPwHVe3siO/1Tuw5qvk/g0FSlCmPq2X30fehKuoAZEXUn3ftW8Lm2X0rHAE7rT7
	sZBoxrktifQsyL8jUYr9UIl3s4InhGEsZNcXAR2P/2ViglyBDygq5SdpX0KfER4BpoUoYU
	l1oylce4utWuN4r0y7HkcN0xhgwaswE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ATep_vWVM4mb-Cfc0HRovQ-1; Thu,
 31 Jul 2025 23:02:42 -0400
X-MC-Unique: ATep_vWVM4mb-Cfc0HRovQ-1
X-Mimecast-MFC-AGG-ID: ATep_vWVM4mb-Cfc0HRovQ_1754017360
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D9DA1800374;
	Fri,  1 Aug 2025 03:02:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.183])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD09D3000199;
	Fri,  1 Aug 2025 03:02:36 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:02:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Brian Mak <makb@juniper.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, x86@kernel.org,
	kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Message-ID: <aIwuSFKSUJDI6ULl@MiWiFi-R3L-srv>
References: <20250729182142.4875-1-makb@juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729182142.4875-1-makb@juniper.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_200249_469092_85CA966A 
X-CRM114-Status: GOOD (  13.19  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 07/29/25 at 11:21am, Brian Mak wrote:
> The kexec_file_load syscall on x86 currently does not support passing
> a device tree blob to the new kernel.
> 
> To add support for this, we copy the behavior of ARM64 and PowerPC and
> copy the current boot's device tree blob for use in the new kernel. We
> do this on x86 by passing the device tree blob as a setup_data entry in
> accordance with the x86 boot protocol.

I see how, but no why. Why do we need to add DTB for x86?



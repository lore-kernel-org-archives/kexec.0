Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A656D11183
	for <kexec@archiver.kernel.org>; Mon,  4 Nov 2024 06:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/r0D1fzxP08DPM1Mhtsw52CPy50i/CtyJxN1In01ifc=; b=3F5KtrbRWNOHNo
	T+3clmL9d5MEC0jJOA2Z8MTZkgc6PMtRmGkxxdzYx6ajSGC18csGzBpmD7B1cKLsfLwCed8PlNzLM
	wy6zafTITMBvEUvIwLhqg16ou4sNFZMjuPi1DOvxtqEjR78GaZ4MFYcZ81vAW+pudq8BjGPfosISD
	rZ3mhHS3kF47ZGWXSkhyiU5c8V/jTW/in9c+GpCbIQkAwOBnFLc3ilfSYhhhN+WXk2ZZcJP4d7lvU
	ve3p2R3d755p7XFdTsgjWLL73RnlgFjlJ4CVBft8BS26DrS53cFxe8BLVqBT7dRwVloVKJ9cw669k
	7n28ZVp5gMzd470sXgOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qPg-0000000CkKi-17QZ;
	Mon, 04 Nov 2024 06:18:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qPb-0000000CkKE-1bWb
	for kexec@lists.infradead.org;
	Mon, 04 Nov 2024 06:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730701080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Do/2TiELOGIeqU3m4GK74cp6r6SIjB0QSr9SYGDc+Tc=;
	b=F8qd860iqM807yJMtKDFVnQeAOyiAkva9vlyQRrdu1U2h3rxvRrW91nwDKsiSt4u2RSV9J
	x+DD4Tu/ajTRngXLIysi7oklHoi4MXN1/K29OTOLybdMNGlgy7jB/CED0D3DrZVPHevAHe
	ouJcGr1Fbv+pBuQpQwZdzBNprLpdVh8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-2cIPdUKtPMy9hOiHaNGHWw-1; Mon,
 04 Nov 2024 01:17:57 -0500
X-MC-Unique: 2cIPdUKtPMy9hOiHaNGHWw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F5A11955EE9;
	Mon,  4 Nov 2024 06:17:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.78])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF30719560AD;
	Mon,  4 Nov 2024 06:17:52 +0000 (UTC)
Date: Mon, 4 Nov 2024 14:17:48 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	akpm@linux-foundation.org, Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <ZyhnDBmhvsG2TZ5V@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_221803_522312_FB950BB6 
X-CRM114-Status: GOOD (  11.46  )
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

Hi Coiby,

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption, widely adopted by users,
> and in some cases, such as Confidential VMs, it is a requirement. With 
> kdump enabled, when the first kernel crashes, the system can boot into
> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
> to a specified target. However, there are two challenges when dumping
> vmcore to a LUKS-encrypted device:

I am doing RHEL code rebasing to upstream kernel, will review this next
week.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

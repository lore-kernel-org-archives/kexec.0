Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80516C3DA4A
	for <kexec@archiver.kernel.org>; Fri,  2 Aug 2024 03:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=etp4EMAVzZXoqwPlkkECELTEcmWLQ8XJ+R/n72XBXsk=; b=CiWhb2oTF7O14V
	rJOMvsFt3bjfiqYNP4FeNbc6rsFxkXfnqGAqCrrEhu/qsvfmyy4WXNQX7i+edDU1i8dRS/vN0H7E2
	F30dVts/nuyli8DM1r8GtBoRf8vaHeLzkDwh9SHBj1XcirZ18CV4ZefimvQQeNdSHYC0agvCfesrO
	dRkZp0rd9CTEuxugr6FRZwqF93ibAvyiL96mIFcXx4G6RzW+Qchnu5rs2nqZxhz+9q/m3wGlI0hWH
	6zoN8sLn82KSHX31vjOAvDpwEXbMh5lpGU0njEm8Zn+ya+si162kTAqXLUGVnQlIR27R/3ibQo708
	/ViC8aSkZqpT1WpHTNcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZj5n-00000007Uyn-2PbU;
	Fri, 02 Aug 2024 03:36:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZj5j-00000007Uy4-0Yci
	for kexec@lists.infradead.org;
	Fri, 02 Aug 2024 03:36:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722569789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrKLPB5W88JO7vCS6F3DlPPfSigwWRaZ9yW7IargJtw=;
	b=SN2RURVgtG0a5rBhMbdP/oVvgnaYKpxtDr+3E2qJjzTPiUoicaZ68jq1QATI6+QtF/8hMY
	s1nd50/d+ooR+wgd5GtydjXeWIyL1kQ/d/XR3xkCYchLmRlt5Ak9CRcUPT6j78wNomif9f
	ic3jNdT0t+r1F5xoBQHHfelG48cCjDY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-cPhAdaPvN6itzE-CkQ_iBQ-1; Thu,
 01 Aug 2024 23:36:26 -0400
X-MC-Unique: cPhAdaPvN6itzE-CkQ_iBQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16D801944B31;
	Fri,  2 Aug 2024 03:36:25 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54C8F1955E8C;
	Fri,  2 Aug 2024 03:36:22 +0000 (UTC)
Date: Fri, 2 Aug 2024 11:36:18 +0800
From: Baoquan He <bhe@redhat.com>
To: A Kundu <avikalpa@yahoo.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au
Subject: Re: kexec failure with Xen 4.19-rc4 and 4.20-dev on linux host
Message-ID: <ZqxUMgcEHakeFPaU@MiWiFi-R3L-srv>
References: <05395ed2-3bf3-4926-8e24-c2e7ff37ed26@yahoo.com>
 <cebc7800-df78-4f90-9f8e-82e3f9120b6e@yahoo.com>
MIME-Version: 1.0
In-Reply-To: <cebc7800-df78-4f90-9f8e-82e3f9120b6e@yahoo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240801_203631_270887_EE3C7B7B 
X-CRM114-Status: GOOD (  15.24  )
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

On 07/31/24 at 06:34pm, A Kundu wrote:
> I am experiencing issues using kexec to load Xen 4.17(debian's apt version),
> Xen 4.19-rc4 (compiled from source) and 4.20-dev (compiled from source) on a
> debian host.

You should CC this to XEN dev list so that XEN dev knows this and may
provide help. Not everyone is interested in and knows XEN.

> 
> System information:
> $ uname -a
> Linux host 6.9.10-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.10-1 (2024-07-19)
> x86_64 GNU/Linux
> 
> $ kexec --version # compiled from source tarball with ./configure --with-xen
> kexec-tools 2.0.29
> 
> Steps to reproduce:
> 
> 1. Set variables:
> 
> XEN_HYPERVISOR="/boot/xen.gz"
> XEN_CMD="dom0_mem=6G dom0_max_vcpus=6 dom0_vcpus_pin cpufreq=xen"
> 
> 2. Attempt to load Xen 4.19-rc4:
> 
> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
> Could not find a free area of memory of 0x3b6001 bytes...
> elf_exec_build_load_relocatable: ELF exec load failed
> 
> 3. Attempt to load Xen 4.20-dev:
> 
> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
> Could not find a free area of memory of 0x3f8001 bytes...
> elf_exec_build_load_relocatable: ELF exec load failed
> 
> 4. Attempt to load Xen 4.17 (from debian rrepositories):
> # kexec -l /boot/xen-4.17-amd64.gz --command-line="$XEN_CMD"
> Could not find a free area of memory of 0x3b4001 bytes...
> elf_exec_build_load_relocatable: ELF exec load failed
> 
> If you need any further information to investigate this problem,
> please let me know.
> 
> PS: If I used apt's pacakged version (which might be compiled
> --without-xen),
> it shows,
> 
> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
> Cannot determine the file type of /boot/xen-4.17-amd64.gz
> 
> # kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD" --type=bzImage
> Cannot determine the file type of /boot/xen-4.17-amd64.gz
> 
> 
> Thank you for your attention to this matter.
> 
> A Kundu
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

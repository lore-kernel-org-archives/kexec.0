Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31139C87FDA
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 03:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MyI6bQ4VKi6kzEU6MGPeSA2rT56TE5vaJOVAfdMj034=; b=dc/u0sXIPWwYxSLZWmV+l0kiFx
	HIdrCEbT9DZAeZkCfUEWOVKFLwp/WBSYO6uIUo2/m9CV557UIwFxe5q+3bLnQsqotGHx1ka54KQnu
	ooxTScjhAN554kx9rQhZ1S0rbDu+2jeQTk/zkmQ//xLAO7w8m+q5e2dTyTDFGuErE1/L40jtzoyRd
	pAfScTy0Wqwv7ZgppMPVtzwoZpyn7B68iVvOXytFZrlCerNvf1MKzYpMoDrdtnFgPtjl4nacr77SR
	HLnRrFQ9xMcqFKtFFm1HbZuLEfiGiIh6O3uyELoNJDUour2VTSatzy0lAr+UBwAzrOpN8WZJfDx2q
	QrWQ9esg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulJXb-00000006Rh2-2Jhz;
	Mon, 11 Aug 2025 03:49:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulJBz-00000006Pm9-3mpD
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 03:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754882841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MyI6bQ4VKi6kzEU6MGPeSA2rT56TE5vaJOVAfdMj034=;
	b=N98C2TSFtN91dW1oU7CzirJAkJIDuwmPCmhoCep1fcn8mkbL2ZPXn7Ijgm9UIJXBdjZt/e
	qjLgGajyALv5Yp87rz9HUJyPuDyfMpS3+xp3Eirh2iJ99b32e5WDiasDQVfSk7wOVM0PE0
	tESQtu6okFAMvFyWJU0GHk9p8iEC/1Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-cJM1f6W-OqG3v9WB2WJDTw-1; Sun, 10 Aug 2025 23:25:52 -0400
X-MC-Unique: cJM1f6W-OqG3v9WB2WJDTw-1
X-Mimecast-MFC-AGG-ID: cJM1f6W-OqG3v9WB2WJDTw_1754882751
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fe28867b7so54258085ad.2
        for <kexec@lists.infradead.org>; Sun, 10 Aug 2025 20:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754882751; x=1755487551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyI6bQ4VKi6kzEU6MGPeSA2rT56TE5vaJOVAfdMj034=;
        b=gaeCssGEnUyyh7LmDeo/68c2ZieC0VwMweUvNihG3H+afZ6YWcI6XufqxW1oCZFlHq
         0y+cq5+Ryb/wNWdWklPx8rTA/Zxp3fKMzfBmS83X1nhCx+EgRuGoHeQ8RXjmfKRw96Q6
         Bo1UU65qOHiK7pZq9vJO6KT3cWK7ZoUirUnAeWMX6IM5m6eJupDVlAHMAEr/gQ5cCwSX
         6cT2T8kVTogjLqTc/hWO0ZINqmHGZPrfcMYdtw1pVPZGXFoU08TAA7X7XmaNMoDCXWMY
         rkxdVBuXD96VNZMsFBr8hgYsztiDlYXft/3v0ungrCFvV2qRKEDvYNQ1n9oxbYqyYE4c
         8LIA==
X-Forwarded-Encrypted: i=1; AJvYcCUKh0S6lNgqU9ixD1kWu0C8kkzg9VGHM5sMybgEBJhkqiQQMPms5Zm9QQ0eSWC+Byb7x/c+RA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKC4QAY9wfpEkl1cZzRmwhKLNcT55JasAwgDJ5RfeD2qnXJUx/
	eEgOqwsWlSGc//M2MRYeJ60OJOhnZgZsNU1xS0iwGj4l8W0CRmainP8W51zCyfUgwNgrGcGdIdH
	vLjMPIllyhrRwBKqrfSEOkieMSNrHbqy83UjAJB2vZMKyJcVYZSlJKZeOuDW0Tg==
X-Gm-Gg: ASbGncs0DneNW0aWwMn1gba29FO2QZGY92FtCogNXqITpFnCk0udR+bAQgxc8awNZnK
	bm75xtHHoB8Z5/O6u0ahS2xnGW1VGj3/X5FSk6PgJ5wWOEJantaiG2VA10H8AKtU9S+g5mGBAmn
	9+qLKuJ5f+bv2HqZfNgylFTzWEhj5K/g/fcz7vWUW6cNhYpMHEEWDnaiD3UGSOUWWyA+lpHfJ5M
	Gwfd0LdX0+M6VmKl1Gl92j2Yc8+ZH0jPuauuUTXuDu9zQopnINqgsVs3JecMxRnD6CxudjHkMEp
	qcttIwUMDAm9t8qnltbo26JJSuMzj3o=
X-Received: by 2002:a17:902:f641:b0:240:7c39:9e25 with SMTP id d9443c01a7336-242c220019amr145851325ad.27.1754882750974;
        Sun, 10 Aug 2025 20:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGij+iLLH1kTC74+yPsc/frGl3BwTOOImoH7zdGTiZxVFriyBsG7HIux9tyLkoa+5Pjls7KUw==
X-Received: by 2002:a17:902:f641:b0:240:7c39:9e25 with SMTP id d9443c01a7336-242c220019amr145851095ad.27.1754882750559;
        Sun, 10 Aug 2025 20:25:50 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6a8fsm258509715ad.23.2025.08.10.20.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 20:25:50 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:23:49 +0800
From: Coiby Xu <coxu@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -WZ4kkZtbW614AcwOaQpHuoFShdQe_BRNdTMqI7IvPc_1754882751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_202724_003359_DF88ED59 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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

Hi Thomas,

Recently I met an issue that on certain virtual machines, the kdump
kernel fails to get DHCP IP address most of times starting from
6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,

     # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
     # MSI_FLAG_PCI_MSI_MASK_PARENT
     git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
     # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
     # Provide MSI parent infrastructure
     git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
     # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
     # Prepare for PCI MSI/MSIX
     git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
     # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
     # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]


I'll appreciate it you can provide any suggestion on fixing this issue.
And I'd be glad to verify any idea as this issue can seem to be reliably
reproduced only on certain machines.

The aarch64 kdump kernel on Fedora is booted wit "irqpoll nr_cpus=1
reset_devices cgroup_disable=memory udev.children-max=2 panic=10
swiotlb=noforce novmcoredd cma=0 hugetlb_cma=0". Removing "nr_cpus=1" or
"adding pci=nomsi" can make this issue disappear. 

Note I've also reported this issue to
https://bugzilla.kernel.org/show_bug.cgi?id=220328

-- 
Best regards,
Coiby



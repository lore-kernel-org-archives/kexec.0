Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E58C433FE
	for <kexec@archiver.kernel.org>; Fri, 18 Nov 2022 00:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TR+xFxEs8/+wc4XzT6uyC70yoRWyMbdR+DZOu1Dt134=; b=jL8zlIBgbwzjSZ
	KEZYOFvwFmJTr1ZbgvJz+BFdaCzp3ADdC3XwhL8G6JIfIdzzPlJhZHuK/WBLUXX5bpPsan2V7Q2Qc
	VvOCQfQIueMUqU9uNIV6lYsPwCSC571NR63ikHk4gqUoEKxQNAP5WBBUC/i6cKNT/dxSfLVU/OB3V
	O1Jzfj0zFb30OSBj1gj58n4RbtLoqU6LpUA/7hsQH1Wi8wA3cFpsKcGhFTXE9k4w17tUcgpvv5OaP
	2levdBkcv9TAoVeN6A5xVjqQwsVuaGD5FwrE/m0ejH9jEQptch0xlwK1kEaoXasvAdT0kuH0Irf6X
	UbNlvC5c86gUxegwILFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovoyy-000qvM-M5; Fri, 18 Nov 2022 00:11:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovoyv-000quA-E4
	for kexec@lists.infradead.org; Fri, 18 Nov 2022 00:11:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668730302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t75IuiAQcMlm4oCjhALxycpb3Fn6D89zCbLbH8xoMhU=;
	b=RZcU4J8/NRVL5oMka86uKBamtnu9yaG6aFk5SsE9We4SOmaETV3qgrHQgbELjM8qwIWjfi
	LqyCeYI6/4sYYf1oHFnzGvkzjcbHkNuSiqkQBrc/DfeHpU+ZZKLT8nPMv/3E7UfqW5Loa/
	n/Tg+atdPWgclgCG0/554EGjQOHjZs8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-gFkoYcibN7O9y4IdUg4itA-1; Thu, 17 Nov 2022 19:11:39 -0500
X-MC-Unique: gFkoYcibN7O9y4IdUg4itA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6114B1C068CC;
	Fri, 18 Nov 2022 00:11:38 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DDC1492B04;
	Fri, 18 Nov 2022 00:11:37 +0000 (UTC)
Date: Fri, 18 Nov 2022 08:11:33 +0800
From: Baoquan He <bhe@redhat.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>, anup@brainfault.org,
	heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
	alexandre.ghiti@canonical.com, vgoyal@redhat.com, dyoung@redhat.com,
	corbet@lwn.net, Conor.Dooley@microchip.com, bagasdotme@gmail.com,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
Message-ID: <Y3bNtRekTdzVMMdK@MiWiFi-R3L-srv>
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_161145_583671_B7F22E9B 
X-CRM114-Status: UNSURE (   8.63  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi risc-v maintainers,

On 10/26/22 at 10:42pm, Xianting Tian wrote:
> As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> need to update according to Bagas's comments. 
> https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> 
> As others patches in above patch set already applied, so this patch set only contains below two
> patches.

Could you pick this patchset into risc-v tree since it has got acks
and two Tested-by?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

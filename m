Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44D9C4332F
	for <kexec@archiver.kernel.org>; Sat, 17 Dec 2022 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WcwfqEwhNcxMoM3JBmJ/RUGbNP7uKifBzh1mhMFmPSg=; b=17e9bwy5fC7hSk
	/wGbtkPKytjohGD820Cn2mnCBqVxJ6TVRzjrB7V/UgWXbDGdcyJluHH0SWPtrPY1mbt2UIZ6kd+FY
	lLGWa/V3F7Ks5F6gKe07yKPijvW5tOkaJepg+a819X6jwaHBBmx/LR3ST+RLFP8532H8Kj5459qrH
	PJP//PTvf9tsBVkWpRfFYTiI4UTwv/fFq/lRb2hICTT1ROle8AEjxuxwevaOCBO32CI3p/db7sRzW
	W/FgojP85TQCoiBO4lP/rOBF1A6Ua/J4llt92J2jheq+Yj6deI24YubQU0AygNHTfNhiPYpRfd2Ia
	3BwAW7yHtAA8OREMSxGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Toc-007nKu-LB; Sat, 17 Dec 2022 09:49:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6ToU-007nId-Rx
	for kexec@lists.infradead.org; Sat, 17 Dec 2022 09:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671270540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+cb7SeX23uGI90U7WymgIHpdK7PIOEux9WNUqXxSTM=;
	b=LKWVCvf/sVYVA/f/WYdh6ReU87428TzJ7g9vl5CKQnkmw6q2W/1iMxd7ZTNFeTpiST6itH
	6LkAOD8El8Ub7SeU+MJBRWYUUudSRR80QBKrQI42ltFwjEyEAv5TvIaH73xQECYhEpPTKw
	T9sU2e0ofJZMh0vcvYf+1J+B+gClZcA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-slC8Q35xPLK9tZqcDtKq2g-1; Sat, 17 Dec 2022 04:48:56 -0500
X-MC-Unique: slC8Q35xPLK9tZqcDtKq2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D589F29AA383;
	Sat, 17 Dec 2022 09:48:55 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EB6C40ED76B;
	Sat, 17 Dec 2022 09:48:54 +0000 (UTC)
Date: Sat, 17 Dec 2022 17:48:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
References: <20221215182339.129803-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221215182339.129803-1-helgaas@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_014905_163533_A4A59A84 
X-CRM114-Status: GOOD (  15.32  )
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

On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no arch-specific things in arch_kexec_kernel_image_load(), so
> remove it and just use the generic version.

I ever posted below patch to do the same thing, Andrew only picked the
memory leak fixing patch.

[PATCH v2 2/2] kexec_file: clean up arch_kexec_kernel_image_load
https://lore.kernel.org/all/20220223113225.63106-3-bhe@redhat.com/T/#u

> 
> Bjorn Helgaas (2):
>   x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
>   kexec: Remove unnecessary arch_kexec_kernel_image_load()
> 
>  arch/x86/include/asm/kexec.h       |  3 ---
>  arch/x86/kernel/machine_kexec_64.c | 11 -----------
>  include/linux/kexec.h              |  8 --------
>  kernel/kexec_file.c                |  6 +++---
>  4 files changed, 3 insertions(+), 25 deletions(-)
> 
> -- 
> 2.25.1
> 
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

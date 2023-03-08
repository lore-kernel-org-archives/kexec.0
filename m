Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E0C678D5
	for <kexec@archiver.kernel.org>; Wed,  8 Mar 2023 00:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mJ2cRAaUXDyqTOzCFltpIy4VXIbU5rbEll9X2CQHAig=; b=nzAALMgJE9GDM8
	kS5A4pLXupB8eM/1IuKnx0IDQ0g3yZw1FAQg5khzkulQ1CHfD0+jXFN3kJS+eNMwJDY4EBT/AXJkH
	MF0ljy3ZXEPy3X5fkuu9UTdWboEi0o/fidPrkBAKozdNfRDxxZO4R6HGXmbGXKsY54PkdgZhO3QAR
	8nYNaRKeE/ZEUzuSgwtrBXKvn6ul06kwE/dkn6sl49xqeE5+NvSZSTY5/YSrRFmRYeyz6lszFwwIM
	Dib7aD/gNCcXbG5cwsKNaDhKgVNM9sSFWWllbkVx+fD82FXrdL43Q5aRnuEwhSR6PcTJOeh53I5aS
	R8hWyeDT3CpxsERFZVqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZhoZ-002zpQ-1G; Wed, 08 Mar 2023 00:37:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZhoV-002zop-KF
	for kexec@lists.infradead.org; Wed, 08 Mar 2023 00:37:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678235868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+naXqPK+BNnrnoMbMYJmt5mQqn+jrV3xlv29zF2BaDc=;
	b=TxQ8Hn6q68f7YfST2VHpnRLV9B6T31uJgFE9PRTusDitsK0/5vIlOvVdCB9M1MAbF9JbuM
	uHx7g/xLG49NmTYikwIMLhJgpTU/y4kctB2lX0zMNg/Vzhyof+XcwrPuAT30q0dKUN2Ghl
	IVQ9gugSNsUVhy6sb+q1tzdI7t/qwjk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-IHxFFcYPNxiGgwSh0CszzQ-1; Tue, 07 Mar 2023 19:37:46 -0500
X-MC-Unique: IHxFFcYPNxiGgwSh0CszzQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B45E2A5954D;
	Wed,  8 Mar 2023 00:37:45 +0000 (UTC)
Received: from localhost (ovpn-12-137.pek2.redhat.com [10.72.12.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 818D3492C14;
	Wed,  8 Mar 2023 00:37:44 +0000 (UTC)
Date: Wed, 8 Mar 2023 08:37:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Message-ID: <ZAfY1OxDBzX7cnw4@MiWiFi-R3L-srv>
References: <20230307224416.907040-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307224416.907040-1-helgaas@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_163751_802591_D9472346 
X-CRM114-Status: GOOD (  15.10  )
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

On 03/07/23 at 04:44pm, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no arch-specific things in arch_kexec_kernel_image_load(), so
> remove it and just use the generic version.
> 
> v1 is at:
> https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/
> 
> This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
> slightly.

Acked-by: Baoquan He <bhe@redhat.com>

> 
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA9CC282EC
	for <kexec@archiver.kernel.org>; Mon, 10 Mar 2025 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XvsmY/JjLBpjK3oBugk8F8gXHOkWN8ooUJaY0xPdhNg=; b=jqgK8hHE4y5ZFThrTFdxK94gMo
	fLcQB4wJ41/irZJmknlkodtigc9s9rgTT0xt6XIdt1GTTbTx7XLhAHFoMECnqOvf4saTYIiwH1hI1
	gEzurSVTV5rNPGc6QViSW2jXbMdhVjKLJuG/7EngNQdGUqcMnfw7cZLq6GUgOYD9S3y/aC1zhDC6S
	JsQl/uDfoCGEnwNaK80C0j13UZE7ZzuscvqUyOzN0Hy1ct5/E7G6oahSX/3k9Sc2oZArKsTyrNfcZ
	lsnVVjeH+o60NWLwEIad/rzIGBnysORH5ZqiLe8O6FIUivnUSEkt3u7/qOsRZ0Sfesr/Zpjj+lLkD
	1sG9l+3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trTqZ-00000001Ubh-3J7F;
	Mon, 10 Mar 2025 03:30:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trTqW-00000001Ub2-1dq6
	for kexec@lists.infradead.org;
	Mon, 10 Mar 2025 03:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741577427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XvsmY/JjLBpjK3oBugk8F8gXHOkWN8ooUJaY0xPdhNg=;
	b=fWf0un3OqqISm/xiRqEPI0DGoRbUezowH2OrqRO2xxThoa7lh7Efqfj/jDZB95AfuNUfF7
	AvZuphq0jWzIs7xKrTt+xPjmGJ0rf/sQkszqctc4yGh1WX6bbLB6kOH8Wh2g6JtB99yWZk
	sVkhNek/QYBRJEOD06DLskKi+X06JCA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-5DRDCMvMM2OaPcK41SI6KQ-1; Sun,
 09 Mar 2025 23:30:22 -0400
X-MC-Unique: 5DRDCMvMM2OaPcK41SI6KQ-1
X-Mimecast-MFC-AGG-ID: 5DRDCMvMM2OaPcK41SI6KQ_1741577420
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449081956080;
	Mon, 10 Mar 2025 03:30:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.225])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85B60180094A;
	Mon, 10 Mar 2025 03:30:17 +0000 (UTC)
Date: Mon, 10 Mar 2025 11:30:12 +0800
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Coiby Xu <coxu@redhat.com>,
	dwmw2@infradead.org
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z85cxCfnRkLve16D@MiWiFi-R3L-srv>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250309_203028_524823_D0E86A9C 
X-CRM114-Status: GOOD (  10.81  )
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

Hi Andrew,

On 02/07/25 at 04:08pm, Coiby Xu wrote:
......snip...

Ping again.

This patchset is adding a generic infrastructure for luks support in
crash dumping, and it adds the support in x86 ARCH. Since the x86
related change is only located in kdump only files, won't impact other
x86 codes. Could you consider pick this into your tree?

And by the way, this is a kdump only fix, not related to KHO (Kexec
HandOver) which David suggested to adapt to earlier. Explained it here
to remove misunderstanding. 

Thanks
Baoquan

>  Documentation/admin-guide/kdump/kdump.rst |  32 ++
>  arch/x86/kernel/crash.c                   |  26 +-
>  arch/x86/kernel/kexec-bzimage64.c         |  11 +
>  arch/x86/kernel/machine_kexec_64.c        |  22 ++
>  include/linux/crash_core.h                |   7 +-
>  include/linux/crash_dump.h                |   2 +
>  include/linux/kexec.h                     |  34 ++
>  kernel/Kconfig.kexec                      |  10 +
>  kernel/Makefile                           |   1 +
>  kernel/crash_dump_dm_crypt.c              | 459 ++++++++++++++++++++++
>  kernel/kexec_file.c                       |   3 +
>  11 files changed, 604 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> 
> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
> -- 
> 2.48.1
> 



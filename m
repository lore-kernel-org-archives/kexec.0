Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51B7C4167B
	for <kexec@archiver.kernel.org>; Sat,  9 Dec 2023 22:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmqIw8chnz6KzLjsNDtPbbp8Z79LmYUeBrDxTJvDOIE=; b=M9n7pF3ksGf4f+
	IaNMqKIXEuphOwZBlEI0Pva8xqeBNKZaFk+iRwCzgCQdFuV/tvHB4vHdn1xFzPAOfUrAuQnKTK3mP
	LNeuGYwp7MkQRDZrFepFnRKB0nt8WGY1AP3KjfowsDebl2injIyr8z+1FR6AFg1DU4H3sFbdyHjeC
	K4mJp2m3lBYYSFtzivCyX9b492xx5NJuHqrqyR5JjRG4PVf1gFPWA6wXi2V2dMseTBAeBFlDRifhP
	cH3svF+Nz4FraHEJupHwfO6tFbX+WU6mASBDtkkYrfV+sHJWqX6pcD+R40JIVTnkfAwFslU854amL
	fudUzMSrspld/Mu6WhVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rC5u5-000dOe-1G;
	Sat, 09 Dec 2023 22:34:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rC5u2-000dNn-1O
	for kexec@lists.infradead.org;
	Sat, 09 Dec 2023 22:34:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 43D8BCE0930;
	Sat,  9 Dec 2023 22:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44937C433C7;
	Sat,  9 Dec 2023 22:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702161259;
	bh=XsuMwPIsmzIChD8ndzu9XynHImam+pakPevqcPXRNtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+3ya32iasF+Y/ixGjJWRb6MVRkCX7SUQSlOC7QcPVmApdwOw8RsA8eKFvh3qbP7S
	 qurGC4BZ7+i6bSPwU0DlnsrWqZIH5edTjZK1gJcsz1xuzDcGKFKhsQBdtd2EjljejQ
	 EBBBXu+OIRpADiQ9c+pKSlLavInXYnnt2LwNDXDc=
Date: Sat, 9 Dec 2023 14:34:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Baoquan He
 <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] crash_core: Fix the check for whether crashkernel is
 from high memory
Message-Id: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
In-Reply-To: <20231209141438.77233-1-ytcoode@gmail.com>
References: <20231209141438.77233-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231209_143430_675154_5C7B804C 
X-CRM114-Status: GOOD (  11.21  )
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

On Sat,  9 Dec 2023 22:14:38 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> If crash_base is equal to CRASH_ADDR_LOW_MAX, it also indicates that
> the crashkernel memory is allocated from high memory. However, the
> current check only considers the case where crash_base is greater than
> CRASH_ADDR_LOW_MAX. Fix it.
> 
> This patch also includes some minor cleanups.

Can we please include a description of the runtime effects of this
change?  ie, what happens now and under what circumstances, and how
does the fix alter these things?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

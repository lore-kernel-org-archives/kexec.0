Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93601C678D5
	for <kexec@archiver.kernel.org>; Wed,  8 Mar 2023 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YbjC1JIbkpu4YCqOmKms4mWyNUvEXZIb6AlVSNtQImo=; b=44jR9/ALGe7Y/Y
	10io+JJbc+0xCNsBkzuo85D8CNELzfnEN8r40ZrdmaxLG//rsbXzQL/C2CGWgpTND5o5iFgtqWdlB
	B7eEf7NFUGo18TmPkMQfr9ez6fYWegiL/DD6SnBnk/e/nFmZ0E3c777FeOCmskYdR/m3gz2MBxtXk
	9vfjdVJ2F413W6mDIh82xDOPPXePYNLuLgclm0b9aXFEhW2nLSWXWtXIJyhDeN/g47zYns4c8mj2O
	uM/grWVwFWXiZiH+AkxNmQwsUMj84nqB//pHLFxfSDv+ipQtHFA5HP9iG+Ocr6t4/TvcCYQtBhk21
	ypc03Fjhdve3duINn5yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZtFo-004vmO-7U; Wed, 08 Mar 2023 12:50:48 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZtFk-004vlX-WE
	for kexec@lists.infradead.org; Wed, 08 Mar 2023 12:50:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 97C04B81C48;
	Wed,  8 Mar 2023 12:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE2C433D2;
	Wed,  8 Mar 2023 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678279842;
	bh=I2SWCZHT09NHUL79MyxjnYQAAqkEZ/+55NJNhSLyYy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nf/6T7WSznILZZnJWuD0GeR796koPKfPL2DQj7cJ+dKS9jUNoappi62Hy5Zp1Ey05
	 TGmZL1sQrPDcHWDxLTYgqeYej50G8wAOHTGqyyPhMxeTziw5/85xYjtomVebUqal9T
	 TMD4GS9QHP7z6OjKchrH5Bjzi7imyzzZjn03/f0uMBF0tGINKApFZ5NRoo9MQVDiEn
	 iWPvFS9vd9LlfPCbiuc8sBL33XGXwHwRFMPMSvS2zHxH/gVrY8Z8e7G54nz390fH8i
	 GeRK6x6f+MVZ2PgAqLNw7NTSvVN5tEIoKvCH8mhwD0rWwy85um+QfW8zydpeP2IOAX
	 no9XnFgKMvKjw==
Date: Wed, 8 Mar 2023 13:50:38 +0100
From: Simon Horman <horms@kernel.org>
To: Youling Tang <tangyouling@loongson.cn>
Cc: kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH v2 1/2] kexec: __NR_kexec_file_load is set to undefined
 on LoongArch
Message-ID: <ZAiEnqF/xjuTrNLi@kernel.org>
References: <1677899351-31098-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1677899351-31098-1-git-send-email-tangyouling@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_045045_196034_AFC6EFC4 
X-CRM114-Status: GOOD (  12.74  )
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

On Sat, Mar 04, 2023 at 11:09:10AM +0800, Youling Tang wrote:
> The initial reason is that after the merger of 29fe5067ed07 ("kexec: make
> -a the default"), kexec cannot be used on LoongArch architectures. We need
> to add "-c" for normal use. The current kexec_file_load system call is not
> implemented in architectures such as LoongArch, so it needs to pass kexec_load.
> So we need to set __NR_kexec_file_load to undefined in unsupported architectures.
> This will return EFALLBACK via is_kexec_file_load_implemented, and then via
> kexec_load.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

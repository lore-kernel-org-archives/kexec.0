Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9833FC44527
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1BZuFpFF3ZCJAw8J5cGf3oYTMZyR3mu4ZhcYlnqpe0Y=; b=Se8tLBnyGxw0enEk+ONnsugiqU
	+KDg0nppjAiaJw16ZPc2ndMdbNheKqstE800dzzYKg6YsufcrhpispJ4W0hYRcRXpnWvW8ZlY4VCb
	OmP/RqjKePHanZjZbJbFwo4xvey1C7bEUI8QUidxS2cENMOCMsH4PIWW9jhonA7k2sOJZE+Ld0dmR
	w1a+eyzbFPEEcNnJq8NkZPFVeJTXxcLpytmsmCpbs72/5y8e+Cm9P2AONvLwCJc+ZsWdzU6QKE0Xm
	WinZfUhqz1geHjaPZ3AIkvoDu69WCx+2IvmWGsSL5NlhQPI2j9auss56sdIknzR2grUVS9m1pOXP7
	Ep7DI3bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkUg-00000006Log-1MDO;
	Mon, 20 Jul 2026 09:41:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkUU-00000006Lic-2UTc
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 09:40:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DAFDF60A81;
	Mon, 20 Jul 2026 09:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2781F00A3D;
	Mon, 20 Jul 2026 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540449;
	bh=1BZuFpFF3ZCJAw8J5cGf3oYTMZyR3mu4ZhcYlnqpe0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hr9wTapxBs54VZOCknn5t84T+rkjQ1B5BP0ISVVwW5BKZXdrdkEKU6P9JIWPhkgTr
	 gx+ZvpgPLbJQuf/tNEEjo+/EQ4BnPsj6YWcvOpEZ9T1B5otahyyc6IU12xs1WUumQO
	 6hStTVmnU+V4ZEY5GsxH02AwXFa2BiGWD7fDj5sKb2HWJ1i/xZFRt+HlNvbLvyUWmm
	 KPNyTdfwl2QszQDlwqXKQ6WsyIwNJ1DgZU/1Y1kWXgesyhV/5hqN1up9LKX01trYRz
	 Zvq0/PNKxj+UWOwy9femOGrd8aqlpyUhvxUIW1jY5ffWWO/IAyFufs1Pqgm6vLme/l
	 Q1To8kYYiF33g==
Date: Mon, 20 Jul 2026 10:40:46 +0100
From: Simon Horman <horms@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH 0/3] kexec-tools: Add new KEXEC_FILE flags
Message-ID: <20260720094046.GE1736709@horms.kernel.org>
References: <20260612223945.1400554-1-makb@juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612223945.1400554-1-makb@juniper.net>
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

On Fri, Jun 12, 2026 at 03:39:42PM -0700, Brian Mak wrote:
> Hi all,
> 
> I realized I forgot to raise a patch series for adding the new kexec_file flags.
> Apologies for the delay on this.
> 
> This series adds support for the KEXEC_FILE_NO_CMA and KEXEC_FILE_FORCE_DTB
> flags, which are used by the --no-cma and --force-dtb options respectively.
> 
> I also saw that there's no debug print for the flags passed to kexec_file_load,
> so I added a print for that as well, which was useful for me to verify these
> patches.
> 
> Please let me know if there's any questions or comments.

Thanks, and likewise sorry for the delay.

Applied as:
- kexec: Add kexec_file_load debug print
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=29898e149feb
- kexec: Add DTB carryover support on x86
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=d5a495bfbfc9
- kexec: Add support for disabling usage of CMA
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=e4de788721cb



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0401EB64DD
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nVpVRY9vyDPby3OfReizCrxCIj7dC4A9h4P6cwi0Z0w=; b=w1RQRG0MZrEf36
	cXv8zKwq6SsdUSL/wX/U8tPVRmpPyEIoaKgSV8LoJdtxrWvbp20IGCx5O/qvheTKc9j7dIe9FnxVW
	/hDfZiN4mwu1oqru2BppP0oFvsRHIKWQ8HxSRc2jj+vz8teqUJC2+0BOrfV3E+i6Wdb0sWhWeAk/K
	9EC50+ShVdhOkZNzHJC/nWbApvOVTwKRx5xVQjwwF1FwGIHfWCxzapcSUVOqdpEyuO5zi4fyZAsKj
	Sg1/MDYmoAziU7gHDrFkXjw1w2CwOLWnmoKdTKnIE7pHMbizU/64GyhsCNaIci4wILRYYsPTXYC9n
	+QXygo9pguYvtCcxGdJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUMbx-009kgS-2I;
	Fri, 11 Aug 2023 07:31:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUMbv-009kg4-0Y
	for kexec@lists.infradead.org;
	Fri, 11 Aug 2023 07:31:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9F4A560DBC
	for <kexec@lists.infradead.org>; Fri, 11 Aug 2023 07:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73194C433C8
	for <kexec@lists.infradead.org>; Fri, 11 Aug 2023 07:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691739061;
	bh=ZUlacCuYW0yl025n+zG3PEyJTB0jL23XwqtzbUb1Ig0=;
	h=Date:From:To:Subject:From;
	b=tD9TWVSIz6bWi2fzmAD5cdo1KhA0H9MRK7N1kXM6RmdpR1OzJDZYkeb14ADReARrR
	 IVBlT2xquUWy1QAhFJBGNTxRqNKZ3SZLwlVDqicHqhUZXt5sRI8e5/VwtFJid36UAd
	 Cx12RMmmRLquUVb6upClVEEHbTl8CSD3HxvFZYF4DBpW4jsjdHistzU4ad57CKr1VX
	 penYTGDJOtx1QF7sEj45MBjDb2ociU7C1ljK0HdN5knJ2wCCFHiUKiKQXfOCLgtYNi
	 o1XggnA4FrH5H5yCMuNAS+I9YwtUDdzXqCRyL5dZm33FX8FcziG5IAIXNsHSbB4Ug8
	 d3Bvmh/S50Idg==
Date: Fri, 11 Aug 2023 09:30:59 +0200
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.27 preparation
Message-ID: <ZNXjs19UOvGEl/5K@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_003103_249892_C72CFD96 
X-CRM114-Status: UNSURE (   7.67  )
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

Hi all,

I am planning to release kexec-tools v2.0.27 in the next two weeks
to roughly coincide with the release of the v6.5 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.27 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.26 are as follows.

Thanks to everyone who has contributed to kexec-tools!

f67c4146d7b5 arm64: Hook up the ZBOOT support as vmlinuz
fc7b83bdf734 arm64: Add ZBOOT PE containing compressed image support
f41c4182b0c4 kexec/zboot: Add arch independent zboot support
1572b91da7c4 kexec: Introduce a member kernel_fd in kexec_info
714fa11590fe kexec/arm64: Simplify the code for zImage
a8de94e5f033 LoongArch: kdump: Set up kernel image segment
4203eaccfa92 kexec: __NR_kexec_file_load is set to undefined on LoongArch
63e9a012112e ppc64: Add elf-ppc64 file types/options and an arch specific flag to man page
806711fca9e9 x86: add devicetree support
29fe5067ed07 kexec: make -a the default
e63fefd4fc35 ppc64: add --reuse-cmdline parameter support
8fc55927f700 kexec-tools 2.0.26.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

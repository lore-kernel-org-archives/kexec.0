Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FB2C05052
	for <kexec@archiver.kernel.org>; Fri, 18 Aug 2023 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZQ2ItQjemagCbfX0yG0edjeglPtOgpyJfWQqYqU63RE=; b=W45XFSsiz0hGVx
	EIvyenj9JWg02ZXuEoBvkjW7GbFUB3zktpQRPtCfymKrCn5kTNcDNU7P9u+0HPAcDMezE5KJL7qVV
	TTGd2e9OPXmLVgw1ug4KryJGf4ZLpVZI3oJVIpl+3CpBTebIrQp6skMGTdm9xJMNuTgwuZ8/imMjy
	yK0nXkvBRjjABDIvyjUExlic0Shj+K0AW5WQz/N98kgc2bgMe5RyhZ9ahUNUa6jJY9FblRtfbYVKN
	mqFF33HcJNg8hT5tVT4xfZ3AOdR0C60LpHB+/i0Fa8MsQwTGYz9dEoXB6VhVRyzt5N+X9fuF2rpbx
	EIyFlG/TcbVHinBcR72g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWx2V-008LWO-10;
	Fri, 18 Aug 2023 10:49:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWx2R-008LTJ-25
	for kexec@lists.infradead.org;
	Fri, 18 Aug 2023 10:49:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7014A632A4
	for <kexec@lists.infradead.org>; Fri, 18 Aug 2023 10:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F65EC433C7
	for <kexec@lists.infradead.org>; Fri, 18 Aug 2023 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692355745;
	bh=fJfa1iDwK+kQXUJ0fJK3l9f5+0dVJ0vAidbP5tjjvcg=;
	h=Date:From:To:Subject:From;
	b=jxmtae9G326WiEI8pgj8hN8XCLpp7SIKMNW/8MdXlStm6M+9+n6dcKxqGbkF5zki+
	 BDhzvpVt3ShRX7aFomdZzU9gimgNlJO3Bad7uiCQSRWEw+cQ9HkVtjU4x/8P3yiIdY
	 L5QIJISGmFafPUT44NuQleGkuA4y40bmCpRAgkU/njAiGupgO0q9a2UJ7uO9Eqf9wH
	 Gp/bRmBHvPHp2GtVwF3xTu5JFbtROKG0eLPG1qBU+38IdvaSEi0snsJfjdIPY8BZDX
	 qfqOCNrmD/+ToKz+I1X2hK9fAqH3JsptWbDmVeOsPNDeyV9qVDquC/zcELvn6PWQ8+
	 ZDPPuDjBALTzg==
Date: Fri, 18 Aug 2023 12:49:02 +0200
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.27-rc1
Message-ID: <ZN9MnhFyaAbcVzo3@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230818_034907_748088_F22E8C4F 
X-CRM114-Status: GOOD (  10.25  )
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

I am happy to announce the release of kexec-tools 2.0.27-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.27
in a weeks time. Testing of 2.0.27-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.27 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.27 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.27-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.26 are:

777ca453ca69 kexec-tools 2.0.27-rc1
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

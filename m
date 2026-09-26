Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A4BC98335
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/oS5cGci8QiKs9/+vr+9VzvkfNfCYGybORMZp8o7zYk=; b=NdRjnTokKEURe/iTHpMnF1zsCC
	dwKg8QabpyiTUyDOh0z9guyqxa5MZ4hq9KJZ/AubTk4hvSyx2fGwRrMPHyTQAahc4Fa6OMeUDwV5P
	So2eXTJkjufkI8DG9yhyrkkpkPKPMkklhnuLVX7r4tZt0K7JfWW4rkqUG+wN7We8YJXpXbkdtg4hN
	3RIHIHjErK5/ZpfhJpwHtuSwW3t8c0T6a8e/0p/MtJXV16u7jXMfjbVQyKf/7r3487RWaHE3IxFXM
	8IEibVRrUSl4tov3Dza5CTkakX5l/bmNFfHfGghlD0I+dtSmmqAvScbIdjMeDmUgzu40ivzkKldmR
	+rnHFWNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xANs7-0000000FA62-2cew;
	Sat, 26 Sep 2026 08:35:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xANs5-0000000FA5T-3jvY
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 08:35:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3119143F86;
	Sat, 26 Sep 2026 08:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1282F1F000FF;
	Sat, 26 Sep 2026 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790411701;
	bh=/oS5cGci8QiKs9/+vr+9VzvkfNfCYGybORMZp8o7zYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKI4YSoIet132l4ifkQSXpJ5S/HAo847RXSPWXlIA//sS1T6DGjDQTSrpmN9w+Kk8
	 js4BixlSkmCw0FEiWLxPcvGxE+3BW6mUpaVXp7XnIRL7QdFfavBtgd1//5Iee5neNs
	 RbienQhHQWLrliSen8LuKxiRtjLuTujrUWtILEs7n/v8uXZzy1skEP7wNx/NpddT7Z
	 GKDAu4WaRdM8Gb/v3pq+XXSFKIL8eKYWfrSN8F+Oz6PgY1dZcpz94w2o4EId72TGE1
	 eqRFZeQmkE1AufPSMNNHLAa7nmcdoN/3AKwfCX7m1232ogKRodq5xYHa7hRr5g9vD9
	 B4sDgFN4Tljag==
Date: Sat, 26 Sep 2026 11:34:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Luis Augenstein <luis.augenstein@tngtech.com>,
	Maximilian Huber <maximilian.huber@tngtech.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Askar Safin <safinaskar@gmail.com>, linux-doc@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v3 0/2] Move tool for generating initramfs cpio to
 scripts/
Message-ID: <areDq-1iFZUViDgS@kernel.org>
References: <20260925-move-gen_init_cpio-to-scripts-v3-0-99c493f76722@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-move-gen_init_cpio-to-scripts-v3-0-99c493f76722@kernel.org>
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

Hi Nicolas,

On Fri, Sep 25, 2026 at 09:29:29PM +0200, Nicolas Schier wrote:
> initramfs cpio tools had been subject of several recent discussions on
> linux-kbuild.  Let's get two minor steps forward by enabling a
> top-level target for building gen_init_cpio w/o the need of a valid
> kbuild configuration [1] and move the tools for generating the built-in
> initramfs from usr/ to scripts/ [2].
> 
> Link: https://lore.kernel.org/all/20260220191150.244006-1-safinaskar@gmail.com # [1]
> Link: https://lore.kernel.org/all/aSdrCFkUQup3qb-q@derry.ads.avm.de/ # [2]
> ---
> Changes in v3:
>   * Update various remaining usr/gen_init* references treewide (Nathan)
>   * Link to v2: https://patch.msgid.link/20260720-move-gen_init_cpio-to-scripts-v2-0-26b7e15c7133@kernel.org
> 
> Changes in v2:
>   * Build gen_init_cpio only if CONFIG_BLK_DEV_INITRD (Thomas)
>   * Keep underscore top-level target name (scripts_gen_init_cpio)
>     (Thomas)
>   * Link to v1: https://patch.msgid.link/20260309-move-gen_init_cpio-to-scripts-v1-0-0c5059b1ec5b@kernel.org
> 
> ---
> Nicolas Schier (2):
>       kbuild: Mark usr_gen_init_cpio as no-dot-config-target
>       kbuild: Move gen_init_cpio and gen_initramfs.sh to scripts/
> 
>  .../early-userspace/early_userspace_support.rst          | 16 ++++++++--------
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst     | 10 +++++-----
>  MAINTAINERS                                              |  1 +
>  Makefile                                                 |  9 +++++----
>  scripts/.gitignore                                       |  1 +
>  scripts/Makefile                                         |  3 +++
>  scripts/Makefile.package                                 |  2 +-
>  {usr => scripts}/gen_init_cpio.c                         |  0
>  {usr => scripts}/gen_initramfs.sh                        |  2 +-
>  scripts/remove-stale-files                               |  2 ++
>  scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py     |  2 +-
>  tools/testing/selftests/kho/vmtest.sh                    |  2 +-

There's also tools/testing/selftests/liveupdate/vmtest.sh I know of, didn't
check for other users in tools/testing

>  tools/testing/selftests/nolibc/Makefile.nolibc           |  2 +-
>  usr/.gitignore                                           |  4 +++-
>  usr/Kconfig                                              |  2 +-
>  usr/Makefile                                             |  4 +---
>  16 files changed, 35 insertions(+), 27 deletions(-)
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260225-move-gen_init_cpio-to-scripts-9e89ef99e51a
> 
> Best regards,
> --  
> Nicolas
> 

-- 
Sincerely yours,
Mike.


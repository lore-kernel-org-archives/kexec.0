Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F349FE7719A
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aLvwPrq2OgaU0a/cBhR7BasCwOVkoEZA5e8ZFXYAKgU=; b=bMEX1/N5+PDN27Zodn0eGeDY/U
	M/i4NIBhJjTSXL8eusTQtiLSi3dYI05FUAfl6i7/RZRrHEDWSzTfXl3JtFZVvplIpkmw3C9kOwcbR
	HP3dKGUl7DAtHt8WjWsdxFu5FJNiN7bioaypa8Tv7EL3+VCdFR3nNeFzuHecAnbj6kuOaL2NpdUwM
	l5BEqDELRdN1ftY0N9E9UJ/42o7Dcopnhc8z+FaiFJyi9zGhCULIE37BBpzDbLmKsSzf+64IZTDjE
	ZCp2xXAqDWFDJolTsrFyKgW5x234jCf5IBZyWFfFWeulSPtZWFKD5Wse22hYrRGGOG7nc9GzMtF9U
	sGp1prSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVupC-0000000CYAP-1OaQ;
	Thu, 09 Jan 2025 15:51:58 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVupA-0000000CY9H-0m32;
	Thu, 09 Jan 2025 15:51:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D378CA420AB;
	Thu,  9 Jan 2025 15:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E5AC4CED2;
	Thu,  9 Jan 2025 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437915;
	bh=4PNW5U1RCpwSI6ed5qCmkDfjxSB39XjXAAnaje7o+L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9BSlQcxUU/kvrDz8ezVoOO+s/YBhBI99DBGbLdRbteRKBcsdBNKhfA6NIrkjDYkC
	 9GtrmQ7VK0dv7qDBCLFFprwhk5flkxmRl+V2FYyKWlDlaQk5dy/y43RuJc1rAObSVE
	 sl7FszvwCJ3ZWmJ3LwoRXHehBmq48TqQ4/nOFcPMPAGWGxlPfP39p5Evt4580Qxykh
	 T6IreW5JxdI40u2aiQRRvDdYRS5jpPoTlnD0T3RTnaN10Mg41YwaqUaSESqRhF+j/w
	 8yWPU7z9RguVCtFoKzz3OeFzncyxzknkL/0P6P7tlQkSO/uCgw6CAfTy6ch0j+etXR
	 6KWhdTwfzx9bw==
Date: Thu, 9 Jan 2025 07:51:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH] treewide: const qualify ctl_tables where applicable
Message-ID: <20250109155154.GP1306365@frogsfrogsfrogs>
References: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_075156_281679_0F1D4C85 
X-CRM114-Status: UNSURE (   9.22  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Jan 09, 2025 at 02:16:39PM +0100, Joel Granados wrote:
> Add the const qualifier to all the ctl_tables in the tree except the
> ones in ./net dir. The "net" sysctl code is special as it modifies the
> arrays before passing it on to the registration function.
> 
> Constifying ctl_table structs will prevent the modification of
> proc_handler function pointers as the arrays would reside in .rodata.
> This is made possible after commit 78eb4ea25cd5 ("sysctl: treewide:
> constify the ctl_table argument of proc_handlers") constified all the
> proc_handlers.

Sounds like a good idea,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> # xfs

--D


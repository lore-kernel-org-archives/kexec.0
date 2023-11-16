Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8B1C197A0
	for <kexec@archiver.kernel.org>; Thu, 16 Nov 2023 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1KRYTTIvXWZz/WWQbbBN8P88EXlA36I84aaVP3L1JXY=; b=efTPqWH44LRYwP
	6y+7nkjF8j6OU9Y1NY5wglH1qtr7TikjOGiKByzMEggYsFifSTHGoFlkDLyj8jgnbqNrE5z1o5SN6
	IZnTRwpD+tCmO/sMGubLvIB5qWi3XUeorAyuuMIXDYKNrsKrU1gSR5DEJYvOydCD867kngysyD75E
	zb/cJkPtAGrHoPrIqm6Iihjz9+8oqdGhq36jRjiDfPUW2HSXgnZil8oxvgqF3HqlQ2Wb6Zi+ImfMk
	8EEUCFxUYvNK+0q6utMz3jO3n5JHt+CI4dI/t8VxsgnPv4Miw1/shxVIvXhzGwC8LqiFF7AGTwCSB
	QAoAwKZBmg2pFcq9ikDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3aeI-003FdB-2w;
	Thu, 16 Nov 2023 11:35:06 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3aeG-003FcV-2b
	for kexec@lists.infradead.org;
	Thu, 16 Nov 2023 11:35:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 05578B81CD6;
	Thu, 16 Nov 2023 11:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092A7C433C7;
	Thu, 16 Nov 2023 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700134502;
	bh=aMjATXDlRxLOK1TUHAP5XJgk7QsDrmk47Ab0KAlBXQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0JNTvMEnLnAhzZKHDckrBF4LE53Gt/lE4mTCzNy1v+z8e9CzwFIemvpm4QGYAiAz
	 qZUT9oi1EH+yWSVFliUDojM/DbpDUg04p6gLJ+dzL06MIHk+Gj2bN4nKplhHO7aqnV
	 kL8bRwvjrPrtAGytT5bJDbUBKaQKgILktVeDGr/Pg8FgN90jQRtR//EB0T0ECLsClL
	 zM/UGwoi/Po60LrafKyoUhTI3PrdrdB90hkgxQOAL6rHaZH2q9HQbG4TPGmid4pUAG
	 FNbJ9vBcQDPMCDHCSM1kP44/KVPvCK1slxr+84fmmS2B/Heirw5auvmcSodKzkJwA+
	 bjvQlXNPI7YSA==
Date: Thu, 16 Nov 2023 11:34:57 +0000
From: Simon Horman <horms@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: ppc64: print help to stdout instead of stderr
Message-ID: <20231116113457.GA314364@kernel.org>
References: <20231116084137.179818-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231116084137.179818-1-adityag@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_033505_009875_A25C9DC5 
X-CRM114-Status: GOOD (  12.46  )
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

On Thu, Nov 16, 2023 at 02:11:37PM +0530, Aditya Gupta wrote:
> Currently 'kexec --help' on powerpc64 prints the generic help/usage to
> stdout, and the powerpc64 specific options to stderr
> 
> That is, if the stdout of 'kexec --help' is redirected to some file,
> some of the help options will not be redirected, and instead printed on
> the terminal/stderr:
> 
>     [root@machine kexec-tools]# kexec --help > /tmp/out
>          --command-line=<Command line> command line to append.
>          --append=<Command line> same as --command-line.
>          --ramdisk=<filename> Initial RAM disk.
>          --initrd=<filename> same as --ramdisk.
>          --devicetreeblob=<filename> Specify device tree blob file.
>                                      Not applicable while using
>     --kexec-file-syscall.
>          --dtb=<filename> same as --devicetreeblob.
>     elf support is still broken
>          --elf64-core-headers Prepare core headers in ELF64 format
>          --dt-no-old-root Do not reuse old kernel root= param.
>                           while creating flatten device tree.
> 
> Fix this inconsistency by writing powerpc64 specific options to stdout,
> similar to the generic 'kexec --help'
> 
> With the proposed changes, it is like this (nothing printed to stderr):
> 
>     [root@machine kexec-tools]# ./build/sbin/kexec --help > /tmp/out
> 
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks Aditya,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

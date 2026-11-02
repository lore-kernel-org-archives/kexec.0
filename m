Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAD606A324
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v8f2V06w;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dytOCAJ8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xxWoHxsw4VPFqHPAqACZbusTmTkHUnFSnkXXJwnJ4WA=; b=v8f2V06w+wv7yK
	Sep2vAKRLhMUpHegOnjxyjpDUr8SxdoNXj/mpauRgm5UVycdTYTp1TwEiIVM031er7VeDCRD1m1MB
	gzIdglMG30Fq1ZsOaM5VB5ah9CS11ALUoaY5sdB3wvQ/efUZ+48JEUJIBXE+2puX+2HRAhUqs/i7n
	yN7a8EsKnLwyrxk4DAAB+OE5iTAMZrOs+Fk03IuLm81rk6wWR/PIahuFMqvLq7LwVQnw+3v6guDL9
	pCd5AHT7MqAyK+1cOdn+l/d5ZWukrHAoQfB4ZDKwBdwHLfPk5PbpCrbMHhusE0IcgP5szF5B8AgPn
	cptl8IZfngeOHq+oha1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNzJk-00000000RQC-3cL9;
	Mon, 02 Nov 2026 21:11:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNzJj-00000000RPp-0GxJ;
	Mon, 02 Nov 2026 21:11:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A7F743D60;
	Mon,  2 Nov 2026 21:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC731F00A18;
	Mon,  2 Nov 2026 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793653906;
	bh=xxWoHxsw4VPFqHPAqACZbusTmTkHUnFSnkXXJwnJ4WA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dytOCAJ80VHiZ1OuHgOm2U1eYLbIsfTF1vQWmQotjAlcYPh3GK76v2x+nXUxkSisM
	 rRSMnxpBhgTKN8qPsqtbMHMR1UcE5DT4mgUuhKJo4qXktvA3N/yVCLaVhqZ4M63hYH
	 QbrscRO/3j+WrNfWqflniFd2/f4mJsHcE8FZW7CXPExB2Ibn6fo+J7vdNxA+QmucPj
	 asTGnwJy3cojByhQ2o4smk8bCPPjZkdrGQJDXaJrz2GO4vpMh3YJ9pqlDgFCK3Aw3b
	 4wFppyIBa3dGdCapF7WeNSk1Sr3UoL9HoLlYvJGsRNCyDrMBD3ag/9W+/du91VH57q
	 5GRjihOJRtTyA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A6FA8F4006B;
	Mon,  2 Nov 2026 16:11:44 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 16:11:44 -0500
X-ME-Sender: <xms:kPzoaoxuxxTdjPhQc-3C1zahFZ9aLPvFlowSXGC4R9C8GitGRfcHEQ>
    <xme:kPzoanGt2jIbLsy47fOpg3WSZ6PY5cBPEClcODOsbon89QNyNk_IgDaAKQadQr2gv
    uVji238fOMsmLse7Ab600gs9JzJ4DZGzIXqA8TonRFGYfmnT8t3fbcj>
X-ME-Proxy-Cause: dmFkZTE7nCOuYmDhbapfq9wnjcJo8I33hiQgEa8gG2mpUd6SiuGVjxefYxNF6ts7apvhL2
    O5TBTvvYo35j+hcPabsgTVdffpGt9MvK5vyw0ZMRJyC2vP2RybIncEIE31yiniEOHW+BGf
    KJmARPQ+h8rxdMmbqHuWCrc+Rw3W1Pf0ttMp3mPjsGk8H3PuZMLxakWBNCayAXhn4arSzS
    SZT0vmmbKnAjrINdR7jALY8t/GQLDesfw1v5pO7HM0aidEkcoMk/IX3mKuG96bBGSC44od
    6j/8Jj2EeiKpBxuZiOuoARjnD/H7MmHLm4946WLbdldIeKehhGb+AjzJw7psiDGcN84+AT
    fxd1ztnRd84WKFx7SmijybVrXSJKl1AR6Etu7r8JTz1E2IGG2rbVvLkvpR2IBVnXEcQUHC
    r3GDkPNpHJrO1FrRX5A6DIGX8s2wqnE6WbRRhP/2UYux7WzU3qFcGt1leEKU+a12CXazx+
    obllJ0NCoPjY5PVFTCgHM6NA+K8OAWAC3Y3QpVQ0GtrFfYBqHxRpcYNa889BVVJkMXM0Xx
    NfAqx7SCTsESPLk/r6Zjs10FtyBDV2ONG987Ot6HPmAwX9PryQz/c+/GTZobKPftcCgNbF
    dMjgQuUNaOpeJy2SLb+WxTNiYQx6H//DcXk9Eak51jjRY6pefZcEU0xUdZXw
X-ME-Proxy: <xmx:kPzoakX1575s1xPK_eRnHKHwfrJs0dh41R1DNgFe6QjSA1GNvloQig>
    <xmx:kPzoaucrAaHqLBPd5fXUJKW90uwtgM36P2rOCnTrC3gEediQhDxGvg>
    <xmx:kPzoaq1brQHn036GXHRWgb2TJPEUtB4n80avLnuqxkDWgbKvmiH79A>
    <xmx:kPzoakc8_jk9jC4iv-WEqTZu5jnNeZJxZR4JSbSaITEBNtWbgxkbuQ>
    <xmx:kPzoau7BSrFGgoTyo_PA1CYGAey1sR943z5_XGLHZHfJ_ObFFdVmJ7Se>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7098678273B; Mon,  2 Nov 2026 16:11:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFgPYeWZplpR
Date: Mon, 02 Nov 2026 16:11:23 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <7ee779f9-db3d-4829-bdd8-1d09e3f74c43@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-net-v1-6-982104a4f592@kernel.org>
References: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
 <20261102-work-procfs-net-v1-6-982104a4f592@kernel.org>
Subject: Re: [PATCH RFC 06/11] SUNRPC: let procfs own the seq_file of the cache content
 file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Declare the seq_operations and let procfs open and free the seq_file of
> /proc/net/rpc/<cache>/content. ->proc_open() and ->proc_release() only
> take and drop the module reference and set up ->private now. The
> rpc_pipefs file is unchanged. Reading the procfs file then no longer
> holds up its removal when the network namespace goes away.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)


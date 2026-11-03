Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB578606A326
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HAVGD+ND;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=M8SFv9Ui
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0uILcWGxRJkmEp+n0zS/w9W2zfSCMknq4cj8Cc7NJqk=; b=HAVGD+NDfDiDeA
	F9kknMcCZGlfQ1Z+WdC5RvT3PDfuZGQNl4//NEMKijeGWV3JKEcWTdABLX7T/AOLUAWFRCgPrmk1s
	cEd21n5uVHj9kCbf3OoFpmpPHogtDD7SW+L5tEnu4vwIzRuZqtf3K+U+b0Vi1awYwnhEGxm3xayyS
	o/g7m0SpMCF+T8iErGP30GyI+CmYn6jM6r4bMIeGgLnfrAsoVtKIb0MXnLgy5Vm6kS/RjIT0TVt8R
	bmnPPrWNNNuFzH5PSLorVdqvPmbikP4I+4huxxGZGMTAo68JVBSRquZqm4bnCW+zys2H2pMxlWIqN
	6zybXfgn9l28hwEnvqmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK4c-00000003Vro-0pqE;
	Tue, 03 Nov 2026 19:21:34 +0000
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK4Z-00000003VrJ-3aH8
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 19:21:33 +0000
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so1276373137.3
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793733690; x=1794338490; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0uILcWGxRJkmEp+n0zS/w9W2zfSCMknq4cj8Cc7NJqk=;
        b=M8SFv9UiFTwJKdz/19NCToErwmqVr8dVeePgUTgPu5Ih/NF+mw9I1quWR+qA2+Cjzg
         nRZpM/bqzoqDM2T5BRvaNgoHm9XTQbZh/FSD77OrhCeidYZoSDMZFWMdVD9n6fatub5F
         mrDNzZFtEktNlsAAXdjyIHnwlsMBCI5mMyD5+0HsqydbQAuBZnNM0WGmJuhFllj352Fl
         NipyzQebUmVkm9Cle7/TH7Gt2VsxCBr4Dz+snmW5Thd4VVko7n/vfenlGGJdNNfpKxFF
         khWvI403COGA9x3yGGNdTo486d6dLCZ393SdB6eCWLMsp2KMk0LH1Hqr/p68Ga8RJxVs
         ufTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733690; x=1794338490;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uILcWGxRJkmEp+n0zS/w9W2zfSCMknq4cj8Cc7NJqk=;
        b=MAL25iwNrLHTUJpjDD3eKXvPjnrJ8+WJXdS+/ozLQ2BnChs0G40AR1InzG68bhp9OW
         yBz24avMMEAu1fPzdS0ahKMWTpepLt3kvZ4iwq2rTfFPOeFmc1bh2a4540GncT+QKcMy
         Lw1302jXqtPkxBUFBgmR7xg40MGxW+1E6uxkcAt1jAnf9hNoRWgY+AoQhoMHWtc3M0V4
         CbX4L7weXGGoNNKOxuL/zxwRKy9wlYbkK2l6XMaq+959YK7mvXH/VycKyKK1bckG8U3A
         IKAQgZK1EauPFBMsRlsb6WVgzrs2D/KQlMm4DmJEopzAhfyaeZlEXVtxgu2kjR+baWPb
         TtqA==
X-Gm-Message-State: APuU4Z8VawlUwY87pTXm7BzM4lnS/gU3NkQGf1hHZcKTeYFWkkTYSIL2
	rlFdqCg0eo8WKOPggOrkDFbxxWACUpJ5K/WPgB8PZ5sc5EHcy1MO7IBs4hCQfzCkREVwyyEPWXn
	vkOAk
X-Gm-Gg: AYBFou14cUY75cCju3csLY3OwSwadGi9Ze3eZeDdnbd6xdDpTZBYMnDeFYPg15QEcG1
	Gyq6QcKrDiYwtmhOhg4V47TsvaizHc+anoDjOOc3reZzywbCkodAsHGJ6/qoUupkmMkdxb8SUy7
	WxITEAH3+WnnffDZh1kkJGL5ylJBBnICHuEay6jxK5nLDONDqPTcJALh2aLDpItvYw/k9GL+gsQ
	rRk8TjiLw0eYlxT4oLfQ+sUhAEgw3Hv9nSuaPUjph0tbH50f04E6VWNCgO3JdbvQMpxlIyy8+HP
	GjKGjpJAWFBWY2HYUiFMmul7SEeK6/0ymwaWoBWbWlSrUZoKnxNFVl0mNVGIg2ale34ZxHAE4ZM
	df0u0xbaxeH2AZv0x1BrEHA1JyBJdmF0q4ftpfCu3R7vtTEFVrFef0NhQVFD7R7KBVmlrJpMsNT
	lvmEMiWkaKBNb5yRW3sLsRfTJrL1flwUKeqL/urxkTc9HpuXt0BBiiUuQdpSOzLvzDv2DaBWgkz
	A0QSQhKSPDOUWgx1sbOsNG5IFnr+3nt5Wa9Rs+VG1QuBOPVm5MkBO3MOzCjbw6rmLnM1j7P2KqC
	wMCy4ymdoBqif9GJXImImJX9MTr4RSLzNcwkwxjHCYFvAtVf3A3jdO+4hAQH5NNHWXN8UF6llMn
	9f+TcfgqKAc0ibff9g1MCP5vi7f5Zolb8LkMJOCA8epqI/CxoY1n9Ygp3vkBoGxQ/CIunBMSDXQ
	==
X-Received: by 2002:a05:6102:6c4:b0:7ce:78f9:adfe with SMTP id ada2fe7eead31-7d072c17d00mr5173411137.18.1793733689733;
        Tue, 03 Nov 2026 11:21:29 -0800 (PST)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d999c2ccsm560241.9.2026.11.03.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:21:29 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live Update
Date: Tue,  3 Nov 2026 14:21:10 -0500
Message-ID: <179373348545.623992.16522569527665218421.b4-ty@b4>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_112131_913968_A79834F2 
X-CRM114-Status: GOOD (  10.01  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 16:25:16 +0000, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10
> 
> This series introduces support in the PCI core for Live Update, enabling
> drivers to preserve PCI devices across a kexec-based kernel update
> without interrupting the device. This functionality is critical for
> minimizing downtime in environments where PCI devices (e.g., those
> assigned to VMs via VFIO) must continue operating or maintain state
> across a host kernel upgrade.
> 
> [...]

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=lu-pci-preservation

[01/13] PCI: liveupdate: Set up FLB handler for the PCI core
        commit: f874391deedec9be601bc044f2aed52a267a3671
[02/13] PCI: liveupdate: Track outgoing preserved PCI devices
        commit: e207461556c0d3a42fd59dc548e9e8f599aae298
[03/13] PCI: liveupdate: Track incoming preserved PCI devices
        commit: 42907d099a3c37f5a089d92465b3a61de9c7cbea
[04/13] PCI: liveupdate: Document driver binding responsibilities
        commit: 78d4d22c0d4e0830a5db9b903f1325b7fbe0eb17
[05/13] PCI: liveupdate: Auto-preserve upstream bridges across Live Update
        commit: 8178f14641e2d7acf648acc33a0cc070763250af
[06/13] PCI: liveupdate: Preserve bus numbers during Live Update
        commit: 3f832a32a1801a9e7b1dc4e88a3e1744a316b538
[07/13] PCI: Refactor matching logic for pci_dev_acs_ops
        commit: 966230f2ebac2013f60ba6376a6ca726f6427ecd
[08/13] PCI: Save and restore the ACS Control register and Egress Control Vector
        commit: 88016172c5585b1dd0d777ec529fcac577e4e94f
[09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
        commit: 1fabde9a0e4964ac43e8ef3f0c9619d8ed80cc23
[10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
        commit: 5506c59d1b844edad5cf2a704f8b87b353b3a2bc
[11/13] PCI: liveupdate: Freeze preservation status during shutdown
        commit: dbe2c3dfd43f9aa094b59669b81aa92b8685d23f
[12/13] PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
        commit: 534abf9f0870b457e1e6f4ef8267b0471e9d2c2c
[13/13] Documentation: PCI: Add documentation for Live Update
        commit: 5d995129832f72dc7a3870eabb216d487a145cf3

Best regards,
-- 
Pasha



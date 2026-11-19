Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A791606A32C
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KYFJpUiQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoFAuLBL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AobPWOfmzE3HwwF/Li0VAD7XrzGxn/GVq4nxLwzb/JE=; b=KYFJpUiQ9MGOhE
	tdVg3LqKBRZwwWhSneqEqOj7JkX9Umv+yUwa+loO7ZrnxGIHsBxU/e+KeOggqDxcCJZX5BMgwkLzX
	677NdKmPKfadQAYAAbJU0PRx1oDqKybiroycoi4gsEYE82CeJ3Q75iciPs65eAnLwt16plaPIPv8X
	L8uiNanz/OnTTu1NQ+PeNk30XCl1HBE+p2HcONqPrT6aCkkKfqVC2ImVp01X34ESw8CQ6MDNzaP9V
	hnqPAYQnhBhOVQ2DF4j2SD5QHnmvO1x0pgIJTEilIfseIIq1Ybe3lkbBOrsxKZAHea91OPMyxVK1J
	oE5ydmU1Z/2IIyaHo2Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU08o-0000000BgAi-3ORR;
	Thu, 19 Nov 2026 11:17:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU08o-0000000BgAW-01OC
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 11:17:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ED9E36329A;
	Thu, 19 Nov 2026 11:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1D71F000C4;
	Thu, 19 Nov 2026 11:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087040;
	bh=AobPWOfmzE3HwwF/Li0VAD7XrzGxn/GVq4nxLwzb/JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoFAuLBLyrbCp46UN1DqjdfvdaUEF6buOWWn7dJXM5u7SBuptSdSeSEjIjPSlto36
	 ep6RVRQdAMkHPSbyStWx34/QptijWC/8sp6xbkMGTPj1iECx/8xExZdYtnFhSe0MdO
	 D4B5NwVRjNWBrHvndeCdJvat6B4dl2QB12Qvu3ewQF73QtGI1vamPYZg+pn7BXRvbA
	 KiML+OE5AiVdQDol/CqPlM4uKF4BI3gOaTddebE3minv2yBivpknT8m3rQWoj8kGw5
	 6cvAOO2zzwTspWVc0dBTqi5QR73Yb7ZdeHf/ClDE9ZhZCnLKHpF3VFrzsEnpSLCJTH
	 274YR2125V8pQ==
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>,
	Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live Update
Date: Thu, 19 Nov 2026 13:17:06 +0200
Message-ID: <179508650609.356641.3313376675131770414.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Wed, 18 Nov 2026 22:36:51 +0000, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11
> 
> This series introduces support in the PCI core for Live Update, enabling
> drivers to preserve PCI devices across a kexec-based kernel update
> without interrupting the device. This lets devices, such as ones
> assigned to VMs through VFIO, keep running across a host kernel upgrade.
> 
> [...]

I updated the lu-pci-preservation branch with this version.

I'm waiting for Alex and Bjorn to confirm they are happy with it before moving
it forward.

Applied to lu-pci-preservation of liveupdate/linux.git tree, thanks!

[01/13] PCI: liveupdate: Set up FLB handler for the PCI core
        (no commit info)
[02/13] PCI: liveupdate: Track outgoing preserved PCI devices
        (no commit info)
[03/13] PCI: liveupdate: Track incoming preserved PCI devices
        (no commit info)
[04/13] PCI: liveupdate: Document driver binding responsibilities
        (no commit info)
[05/13] PCI: liveupdate: Auto-preserve upstream bridges across Live Update
        (no commit info)
[06/13] PCI: liveupdate: Preserve bus numbers during Live Update
        (no commit info)
[07/13] PCI: Refactor matching logic for pci_dev_acs_ops
        (no commit info)
[08/13] PCI: Save and restore the ACS Control register and Egress Control Vector
        (no commit info)
[09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
        (no commit info)
[10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
        (no commit info)
[11/13] PCI: liveupdate: Freeze preservation status during shutdown
        (no commit info)
[12/13] PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
        (no commit info)
[13/13] Documentation: PCI: Add documentation for Live Update
        (no commit info)

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: liveupdate-7.5

--
Sincerely yours,
Mike.



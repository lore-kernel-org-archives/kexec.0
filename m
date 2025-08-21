Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1681CA0EFA
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VpHM1uBa4sOEGG7WK0F1Lv/uHtgOoqOPQTT0Bq1COOw=; b=yJlTkXqE5O3KiPv844SxbmnwQK
	mM9WQ0XEfI7195+Z2SGETS3EX84EWwBmzMQxM7r6KrYQyUrJkUbUiVTp5Mj6N+sLXT8dgQtViRbme
	LzxdpDnqCCiX9vKBjKC9V6dwTpqduzlJtXE8vMBWdj5xbIQ+UBG0MnCawJAaT9kJwjGwgkz2TPOy1
	S5c/TrDMAw+fEubmRzBvTV7ER3sYQcr+jDheopiYcSaQG46M3hUtDANyNIlV+Fk7xzZgNgAA49MT9
	TJRWbyONORBQMOkqXUtvhzuiEIRlZZlnhtknHd2zqelS14DRwKlpNFweAiOJa/hJrKoSxuHZMyuwm
	f+xaAXkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2Uv-0000000GbMG-3I0W;
	Thu, 21 Aug 2025 10:26:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up0ch-0000000GFGf-0MUh
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 08:26:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 83AB05C575D;
	Thu, 21 Aug 2025 08:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD01C4CEEB;
	Thu, 21 Aug 2025 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764774;
	bh=cLUbOqUr6cTb/vKgSfC31FXfcobLn5rCi7Usx5zRpc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KB/twgsA/CTVnp586RP3GyuIdvA0EyWAAu+91jwzNtpbYbFOXHSU+jhu4roGlyYaB
	 BxV+AOwx9I0X+6uSH1kDHGrWRCz5VW4AjFllgPvHKsWA5GjEhBoTsBtmc2sQ09hzK5
	 jQuxubCyXuxk/Fe2zDo0iQi/7yW6zxEmdnetP1tMY7f7jUGykW5edx68Zmf5wRLqM1
	 AaGdKlxJfMGHLS7Dw6iFgcgxUCI0acFJ+cmRXj/ME/nXBKoswdmAChcBH49jSUT7AT
	 nNClgUYNQbD/ibAssVpOs7cjGiJbe9NxlKJR5WwEypQ96O8gqU8pcz1UxbhkZGpIi3
	 Vsg9b0HqcCtvA==
From: Christian Brauner <brauner@kernel.org>
To: Lichen Liu <lichliu@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	safinaskar@zohomail.com,
	kexec@lists.infradead.org,
	rob@landley.net,
	weilongchen@huawei.com,
	cyphar@cyphar.com,
	linux-api@vger.kernel.org,
	zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	initramfs@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
Date: Thu, 21 Aug 2025 10:24:11 +0200
Message-ID: <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815121459.3391223-1-lichliu@redhat.com>
References: <20250815121459.3391223-1-lichliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=brauner@kernel.org; h=from:subject:message-id; bh=cLUbOqUr6cTb/vKgSfC31FXfcobLn5rCi7Usx5zRpc0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsuyF9J8I8+ZPI912RyxZ9nXK0nUlMZilruGDJHpOm7 9cirH4HdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE5BbDX+kbB6buCWFhtarJ sWE8wewxpUXp9twbsTPVd/5ZsXix9k9GhvNr7pbsmytTaOiSs/k6/9MrFlk+jBf5/2xw5Z0eo9v QwAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_012615_205977_2BF57879 
X-CRM114-Status: GOOD (  16.66  )
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

On Fri, 15 Aug 2025 20:14:59 +0800, Lichen Liu wrote:
> When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> By default, a tmpfs mount is limited to using 50% of the available RAM
> for its content. This can be problematic in memory-constrained
> environments, particularly during a kdump capture.
> 
> In a kdump scenario, the capture kernel boots with a limited amount of
> memory specified by the 'crashkernel' parameter. If the initramfs is
> large, it may fail to unpack into the tmpfs rootfs due to insufficient
> space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> memory must be available for the mount. This leads to an OOM failure
> during the early boot process, preventing a successful crash dump.
> 
> [...]

This seems rather useful but I've renamed "rootfsflags" to
"initramfs_options" because "rootfsflags" is ambiguous and it's not
really just about flags.

Other than that I think it would make sense to just raise the limit to
90% for the root_fs_type mount. I'm not sure why this super privileged
code would only be allowed 50% by default.

---

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs: Add 'rootfsflags' to set rootfs mount options
      https://git.kernel.org/vfs/vfs/c/278033a225e1


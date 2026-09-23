Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C5EC98304
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PunvAU+DlMDl9/ZMTsQFtHIX6hxmtTujipDeh0Nhe6g=; b=xxmDVJverJ1OyltEAcV/qULyuG
	y0znaLtXJ53ZYw4jW++tkpQ/2uiovIfUSZf3fQJ8TmQFFxi7THBALmk/w9OEL3o+5v5YFu8gUdBoU
	rVTnW2p+tfdmDwcd1vz7vkLraX8X5PiM9B9e5Lk57KYmo47Mb4MErm9SFfx0SRGoXjWDZ1LWMDDi4
	QjIyyfHL9q4Qjx2buv9GMQNhhZLYw1O3xVTP08EIytw/zS0t17bDWRKJ55nQmoMJ3+4I9I6uhRVdR
	FGHYzQnYS53s10o8JnZEOFWkvtFfhxRr37ujrHIpgX5tAmtR5xctFx4hi36d2uguLTOHfGGn86ZFE
	XeQslBBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9WAr-00000009hMn-2k9P;
	Wed, 23 Sep 2026 23:14:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9WAq-00000009hMf-2SPY
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 23:14:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3784E43D1C;
	Wed, 23 Sep 2026 23:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6007E1F000FF;
	Wed, 23 Sep 2026 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790205286;
	bh=PunvAU+DlMDl9/ZMTsQFtHIX6hxmtTujipDeh0Nhe6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GwCaB5PBF3E1FC7ficVZunVcVFP0VTS4+2Bga9Zh/QWOyuH+hyzsTGLPyEMk96WMf
	 +kc/oK1keREe/0gQBuzQyoZq3CDbecwLRM8O5ySUTnSGYs3dHQt/PCXL+l3pnWCzBq
	 8v5YXQQoz+eqdXYFpCyp8o1nU7W1tw2hhUZEdsZJx03gNAcoNu+/pHkyJUyiL7aMBM
	 G0y2Nxbed1B9b5RMeUi6BRWNr3yCLvxgYDZr4S9Xu2xYatq12zK0sn/yBPtbjplq5S
	 /jp8m9DH1r6h8OKTYOgvj3UBZI5WVdk9hcvn/8OeJLddtZZzBqRBs9kQ3fI0ky1imT
	 UdSPO5heLxLVw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/6] selftests/liveupdate: add tmpfs kexec test
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "David Matlack" <dmatlack@google.com>, "Hugh
 Dickins" <hughd@google.com>, "Samiullah Khawaja" <skhawaja@google.com>, "David
 Hildenbrand" <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260923224408.3745689-7-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
 <20260923224408.3745689-7-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:14:44 +0000
Message-Id: <20260923231445.6007E1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/liveupdate: luo_kexec_tmpfs fails on persistent rootfs
--

commit 656981de91db4b31da49ddcf77d65f446841090b
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

selftests/liveupdate: add tmpfs kexec test

This commit adds a two-stage kexec test for tmpfs preservation. The first
stage creates a tmpfs mount, creates a file, and preserves both. The second
stage retrieves both and verifies the contents.

> diff --git a/tools/testing/selftests/liveupdate/luo_kexec_tmpfs.c b/tools=
/testing/selftests/liveupdate/luo_kexec_tmpfs.c
> new file mode 100644
> index 0000000000000..608a6eddbd7ba
> --- /dev/null
> +++ b/tools/testing/selftests/liveupdate/luo_kexec_tmpfs.c
[ ... ]
> +/* Stage 1: Executed before the kexec reboot. */
> +static void run_stage_1(int luo_fd)
> +{
[ ... ]
> +	ksft_print_msg("[STAGE 1] Mounting tmpfs at %s...\n", TMPFS_DIR);
> +	if (mkdir(TMPFS_DIR, 0755) < 0)
> +		fail_exit("mkdir %s", TMPFS_DIR);

[Severity: Medium]
Will this fail on test re-runs if the directory is left behind from a prior
run?

> +	if (mount("tmpfs", TMPFS_DIR, "tmpfs", 0, NULL) < 0)
> +		fail_exit("mount tmpfs at %s", TMPFS_DIR);
[ ... ]
> +/* Stage 2: Executed after the kexec reboot. */
> +static void run_stage_2(int luo_fd, int state_session_fd)
> +{
[ ... ]
> +	ksft_print_msg("[STAGE 2] Attaching the restored mount at %s...\n",
> +		       TMPFS_DIR);
> +	if (mkdir(TMPFS_DIR, 0755) < 0)
> +		fail_exit("mkdir %s", TMPFS_DIR);

[Severity: Medium]
Will this unconditionally fail with EEXIST in run_stage_2() if the underlyi=
ng
root filesystem is persistent across kexec?

> +	if (move_mount_empty_from(mnt_fd, TMPFS_DIR) < 0)
> +		fail_exit("move_mount of the restored mount to %s", TMPFS_DIR);
> +	close(mnt_fd);
[ ... ]
> +	ksft_print_msg("[STAGE 2] Test data verified successfully.\n");
> +	if (luo_session_finish(session_fd) < 0)
> +		fail_exit("luo_session_finish for test session");
> +	close(session_fd);
> +
> +	if (luo_session_finish(state_session_fd) < 0)
> +		fail_exit("luo_session_finish for state session");
> +	close(state_session_fd);
> +
> +	ksft_print_msg("\n--- TMPFS KEXEC TEST PASSED ---\n");
> +}

[Severity: Medium]
Does the test exit successfully here without calling umount() or rmdir() to
clean up the environment? If so, does it leak the /tmpfs directory and its
mount on the host system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923224408.3745=
689-1-pratyush@kernel.org?part=3D6


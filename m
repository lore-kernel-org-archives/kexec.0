Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF78C9830E
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0LEsbhIDjBe66cbu0GZSdPhdvVGyJ9cnICBeyy6iWkk=; b=AsEqvbCU5qP/NWTjHp5H0cYCsP
	3ji9p7Bl1GAEnaxUpk+jAJ5cOugFmDptkyHsa0A6lfa8E5MUDxaWzikMFBkn7IsPklTlwVXrHWisG
	w44NX6PHf/9S15goxoDYHd63HixZLq8Nfhim1HVwvh24plEQ7YFBpkKOh5E2H2ClGDq/d4NfVo3DM
	rwj1yEU+QMj+CfA4xqYTA1iZtkWxaPZFwm603sl/nrRXycI2NAfhIuMIt8vKepuqtpFA+t2dFXmpL
	hpHqGeepTodNDfdvoclkhPlNFSS5Twk4bJ4IjdtX2+MAJ0ES4/27EBEGxGLoL6gq/tTgKZYpL5iyc
	SZKraDpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xABkI-0000000EHVX-0aU4;
	Fri, 25 Sep 2026 19:38:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xABkH-0000000EHVG-0EFb
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 19:38:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 875BD43765;
	Fri, 25 Sep 2026 19:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F401F000FF;
	Fri, 25 Sep 2026 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790365088;
	bh=0LEsbhIDjBe66cbu0GZSdPhdvVGyJ9cnICBeyy6iWkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DxbIi28P95AzIzpsaRJqifwhTdKpAAPYMwT4+wQMpyTkmjQuoUxKrj2UjvZ1CzDD5
	 2dz5GyyZf+UVrlZzUi7246Dh6pWzJ9W7Wngn2hPuK1aiFavZpjeydxRVuDNMIUxFq7
	 X17bAkTBN1fMC2PylaMk7Rvp4/A6m8r52ETGTJMC4t6XJXPofRdG3WdbI8bKjXZK7g
	 G1JU9ZU6xnROvYjqRsDVA3WL2Wh4bkp3mkF7Lz4mpmR+9iPkg7uMvQ8cnOVC11EsoI
	 5m7BmFWf1IT7ed9EuauM/1lhewkRONS0osKU8zKGAvl585hEth7Rs4equHnAMtEzz1
	 wUQlc7U9HlCJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] kbuild: Move gen_init_cpio and gen_initramfs.sh
 to scripts/
To: "Shuah Khan" <skhan@linuxfoundation.org>, "Jonathan Corbet" <corbet@lwn.net>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Alexander Graf" <graf@amazon.com>, "Nicolas
 Schier" <nsc@kernel.org>, =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Maximilian
 Huber" <maximilian.huber@tngtech.com>, "Nathan Chancellor" <nathan@kernel.org>, "Willy
 Tarreau" <w@1wt.eu>, "Randy Dunlap" <rdunlap@infradead.org>, "Luis
 Augenstein" <luis.augenstein@tngtech.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, "Askar
 Safin" <safinaskar@gmail.com>, linux-kbuild@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
In-Reply-To: <20260925-move-gen_init_cpio-to-scripts-v3-2-99c493f76722@kernel.org>
References: <20260925-move-gen_init_cpio-to-scripts-v3-0-99c493f76722@kernel.org>
 <20260925-move-gen_init_cpio-to-scripts-v3-2-99c493f76722@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:38:07 +0000
Message-Id: <20260925193807.70F401F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/liveupdate: vmtest.sh mkinitrd fails due to missing ge=
n_init_cpio
- [Low] kbuild: stale comment in gen_initramfs.sh assumes old usr/ location
--

commit 97c7fb8e47f1b247f157846cfecd29ff5f239ed1
Author: Nicolas Schier <nsc@kernel.org>

kbuild: Move gen_init_cpio and gen_initramfs.sh to scripts/

gen_init_cpio and gen_initramfs.sh are part of kbuild and required for
all kernel builds w/ CONFIG_BLK_DEV_INITRD.  Move both to scripts/ to be
more clear about their importance.

Link: https://lore.kernel.org/all/aSdrCFkUQup3qb-q@derry.ads.avm.de/

> diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selfte=
sts/kho/vmtest.sh
> index 0014bd76e88de..1e86ffcc3a79e 100755
> --- a/tools/testing/selftests/kho/vmtest.sh
> +++ b/tools/testing/selftests/kho/vmtest.sh
> @@ -100,7 +100,7 @@ file /init $tmp_dir/init 0755 0 0
>  file /kernel $kernel 0644 0 0
>  EOF
> =20
> -	"$build_dir/usr/gen_init_cpio" "$tmp_dir/cpio_list" > "$initrd"
> +	"$build_dir/scripts/gen_init_cpio" "$tmp_dir/cpio_list" > "$initrd"
>  }

[Severity: Medium]
The path for the kho selftest was updated, but it looks like=20
tools/testing/selftests/liveupdate/vmtest.sh also still calls the old path.

For example, in its mkinitrd():

	# Generate inner_initrd.cpio
	"$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list_inner" > "$worksp=
ace_dir/inner_initrd.cpio"

and again later in the same function:

	# Generate the final initrd
	"$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list" > "$initrd"

Since this patch ensures the old artifact is removed via
scripts/remove-stale-files, will the liveupdate selftest unconditionally
fail because it cannot find gen_init_cpio?=20

Should liveupdate/vmtest.sh be updated to use scripts/gen_init_cpio as well?

> diff --git a/usr/gen_initramfs.sh b/scripts/gen_initramfs.sh
> similarity index 99%
> rename from usr/gen_initramfs.sh
> rename to scripts/gen_initramfs.sh
> index 7eba2fddf0ef2..27ac1fd48001a 100755
> --- a/usr/gen_initramfs.sh
> +++ b/scripts/gen_initramfs.sh
> @@ -247,4 +247,4 @@ done
> =20
>  # If output_file is set we will generate cpio archive
>  # we are careful to delete tmp files
> -usr/gen_init_cpio $output $timestamp $cpio_list
> +scripts/gen_init_cpio $output $timestamp $cpio_list

[Severity: Low]
Is the script header comment now out of date?

At the top of the renamed scripts/gen_initramfs.sh it still states:

# Generate a cpio packed initramfs. It uses gen_init_cpio to generate
# the cpio archive.
# This script assumes that gen_init_cpio is located in usr/ directory

Should this comment be updated to reflect the new scripts/ location?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-move-gen_i=
nit_cpio-to-scripts-v3-1-99c493f76722@kernel.org?part=3D2


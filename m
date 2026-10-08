Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85868CA600C
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EMfIGKHZL2EcuSKE4fetcJKV4ZBxsEiNzCi6Z94i7bs=; b=ZgSXUmp80WyzVOK8mPRvBuEK/k
	C+zwYLEhnMc2o7WsszTwhZNaO9rP85a/x3brk3iuvDGySVDP6XaaXVXOPsBUHxTKHrIpex5GaQSfY
	GN9mSa7EvCLXLo7C1TiY8BDD3t7+hnwqmm1NXbloWOTRiqmRhCBW82eqhsUJ2qQyShJ3hKDpXLXES
	a9UpRE6TVEwgpPPm6sBbo2Jw0eSgFDOr5zBq6sdjfgBR+jLfPAvI8mZhFIcAFlaDkuQHpaWaSB158
	28+Tzna4R+D7Z8CEMckxhjJEz4NAmrOB/43Wwvt4sRPlHYZhVtVgAXkUNBjkGNrmGKPxoVnFAbhdj
	YULgm0iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEoG1-00000004T9Q-1Hh6;
	Thu, 08 Oct 2026 13:34:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEoG0-00000004T9K-2Xrf
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 13:34:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D5A996025A;
	Thu,  8 Oct 2026 13:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FCA1F00893;
	Thu,  8 Oct 2026 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466439;
	bh=EMfIGKHZL2EcuSKE4fetcJKV4ZBxsEiNzCi6Z94i7bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8eMDAx6L9M21p4L4bm3XoG0wYjiHPzh4pUoHd6zVTIn+EQ9VKNLR0Eiw41R2CCok
	 kK30o0nyNc4Rz/9ptJ0DGGuj6nLT6LkyNLKMUx5MsbnyB6rx024+Ork7+zA8Hwlkjc
	 TqJ7jDSVlX9mtve4DDRPH2m9RKsqIe+ldoxUZZFdD+Xj9tN6maRT17w+T3uSp/Rg4X
	 jOUg5Nh6VeQzAmm5SGuiihTMbrU0JSq+AoPDHLUWQla8dwJrWw87TZCZdS23c0A4Cb
	 00QqAcU8V8gVUFUzKkP9PhfPO6V8/2h7q2fA+LKzembMMVtAvPFPR91uINyDYoy6f1
	 smig3ElBv0KAg==
Message-ID: <sashiko-outbox-164218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/liveupdate: Prefer KVM and HVF over TCG in
 vmtest.sh
To: linux-kernel@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-kselftest@vger.kernel.org
Cc: "Jordan Richards" <jordanrichards@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Shuah
 Khan" <shuah@kernel.org>
In-Reply-To: <20261008132813.1966023-1-dmatlack@google.com>
References: <20261008132813.1966023-1-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 13:33:58 +0000
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
- [Medium] selftests: KVM accelerator preference breaks arm64 vmtest on GIC=
v3 hosts
--

commit 5b52122d5a64c0b3471d0fed69b32ec99d464203
Author: David Matlack <dmatlack@google.com>

selftests/liveupdate: Prefer KVM and HVF over TCG in vmtest.sh

This commit reorders the QEMU accelerator options to prefer KVM and HVF over
TCG. It aims to utilize hardware acceleration when available instead of alw=
ays
defaulting to TCG.

> Tested by running run-vmtests.sh and then observed that arm64 correctly
> fell back to using TCG after trying to use KVM and HVF, and that x86
> reported no warnings.

Will the arm64 test actually fall back to TCG when run natively on modern a=
rm64
hardware?

In get_arch_conf(), the arm64 QEMU command is defined without specifying a =
GIC
version:

QEMU_CMD=3D"qemu-system-aarch64 -M virt -cpu max"

Because the virt machine type defaults to GICv2 for backward compatibility,
running this natively on modern arm64 hardware (which typically only suppor=
ts
GICv3) will cause the KVM accelerator to successfully initialize, preventing
the fallback to TCG. However, KVM will then fail to create the default GICv2
in-kernel interrupt controller and QEMU will abort with a fatal error.

Was the observation of falling back to TCG made on a cross-compilation host
where the KVM accelerator itself failed to initialize?

> diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing=
/selftests/liveupdate/vmtest.sh
> index 64fd2ab55b765..69beda6c961d7 100755
> --- a/tools/testing/selftests/liveupdate/vmtest.sh
> +++ b/tools/testing/selftests/liveupdate/vmtest.sh
> @@ -180,7 +180,7 @@ function run_qemu() {
>  	echo "# Serial Log: $serial"
>  	timeout 30s \
>  	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \
> -		  -accel tcg -accel hvf -accel kvm \
> +		  -accel kvm -accel hvf -accel tcg \

[Severity: Medium]
Does this change break native arm64 execution on modern hardware?

Since get_arch_conf() lacks the gic-version=3Dmax parameter for arm64, QEMU=
 will
default to GICv2. On modern arm64 hosts, KVM won't be able to emulate GICv2,
causing a hard failure during machine initialization rather than a fallback=
 to
TCG.

Should gic-version=3Dmax be added to the arm64 QEMU_CMD to safely enable KVM
acceleration on modern hosts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008132813.1966=
023-1-dmatlack@google.com?part=3D1


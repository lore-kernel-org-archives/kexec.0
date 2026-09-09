Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7708EC79F9E
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbbYF/s+aFKItSacBITHj0bF42iOF/BwYLBw6a8ytro=; b=3tF/CQcOgCZiZYms9AvUBGp6CM
	c8poX0iZc5iLxFw3GXQr/bDRYkLhOUpd6tosS4Ac7QpUO/UuGBnQTMZGtu+kKTsSmSNMg5aIma5GL
	7uFLCvZGOQwKh1DRtLg6bIGDG6yiGWVAS5q2F6nAIZMXOu018nRYJGxljdJXzl6OTOJJJ6ly3a7Yi
	woXU4Jlj6I94ZULRAB7sePCDJl0mARzcN2w1cp+rThpSiPDL6Zo6yoCriS50nDkjdeKMkM8JBi78u
	RcXQYX+Y5FG4cAjnQ6JYOrhGyFWmBysvIZpuknAyHPgYz2Ab2fSCTa5RjS0s4+CLKJzYzyyAX+l5u
	564VYklg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46TF-0000000AXK0-2Hpu;
	Wed, 09 Sep 2026 00:47:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46TD-0000000AXJg-3st7;
	Wed, 09 Sep 2026 00:47:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5FB7B601FF;
	Wed,  9 Sep 2026 00:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649E21F00A3A;
	Wed,  9 Sep 2026 00:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914843;
	bh=DbbYF/s+aFKItSacBITHj0bF42iOF/BwYLBw6a8ytro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DbT9LWZhoH9gE0PVPnlfsqJ5k1NKXil7ZlqAKjRvJ8maM4cKMNST4xQP+yAD7oIQx
	 kdR5+WX2aIZ0J/fkiyKYgDsDAZCetknPGGLMn2Ld5RYWddX4ueVhERDYcAPHcBlvc1
	 L3Q/cS8tpKYxXNaD/v2ggjZ1DJ8grhq6ksOTwmlqEHr2bbECY/paVwvIHTicIDuWIr
	 vM7d5gK0tsqx3DCb9rsHjpFZCXZP6C89mie/v/qGkcPoDchuDip5MJw3tzuq/4ytyF
	 TaVsmX/C+L/LtptLwRkAmcYNf6hpxngcLyH1jh0l18TeUrwpilXf3cI999ieJpRytI
	 lfL0qkfdLHTQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] crash_dump: Disallow writing to dm-crypt
 configfs during kexec_file_load syscall
To: "Coiby Xu" <coiby.xu@gmail.com>
Cc: "Baoquan He" <baoquan.he@linux.dev>, "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Dave
 Young" <ruirui.yang@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Will
 Deacon" <will@kernel.org>, linux-arm-kernel@lists.infradead.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "open
 list" <linux-kernel@vger.kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, kexec@lists.infradead.org
In-Reply-To: <20260909003657.1570544-4-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-4-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:47:21 +0000
Message-Id: <20260909004722.649E21F00A3A@smtp.kernel.org>
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

New issues:
- [High] Severe locking imbalance in `crash_load_dm_crypt_keys()` leads to =
a leaked mutex on the error path and unlocking an unacquired mutex on the s=
uccess path.

Pre-existing issues:
- [High] Premature and unconditional reset of `is_dm_key_reused` to false b=
reaks ARM64/LoongArch kexec load retries and defeats intended cleanup logic.
--

commit a9405cf8948ba39213612c61a1f3b10b23f437e4
Author: Coiby Xu <coiby.xu@gmail.com>

crash_dump: Disallow writing to dm-crypt configfs during kexec_file_load sy=
scall

This commit prevents concurrent writes to the configfs group during the
kexec_file_load syscall by utilizing config_keys_subsys.su_mutex. It aims to
avoid buffer overflows, stale keys, or memory leaks caused by changes to
dm-crypt keys during iteration.

> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 3a416933979f8..580534d43b66e 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c

[ ... ]

> @@ -478,6 +490,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  		"Loaded dm crypt keys to kexec_buffer bufsz=3D0x%lx memsz=3D0x%lx\n",
>  		kbuf.bufsz, kbuf.memsz);
> =20
> +unlock:
> +	mutex_unlock(&config_keys_subsys.su_mutex);
> +

[Severity: High]
Looking at crash_load_dm_crypt_keys(), if kexec_add_buffer() fails earlier
in the function, it jumps to the out label, bypassing this unlock label.
Does this leak the config_keys_subsys.su_mutex if the lock was acquired?

Also, on the success path, mutex_unlock() is executed unconditionally. If
is_dm_key_reused was true at the top of the function, the mutex was never
acquired. Can this cause a kernel panic or corruption by unlocking an
unacquired mutex?

>  out:
> -	return r;
> +	is_dm_key_reused =3D false;
> +	return r;
>  }

[Severity: High]
This is a pre-existing issue, but since the error and success paths
unconditionally reset is_dm_key_reused to false here, does this break
architectures like ARM64 that might retry segment loading?

If load_other_segments() retries the load sequence, the second pass
through crash_load_dm_crypt_keys() will see is_dm_key_reused as false,
find zero keys, and silently load nothing into the kdump kernel.

Additionally, crash_dm_crypt_cleanup() checks !is_dm_key_reused to determine
whether it should free keys_header. Since the flag is unconditionally clear=
ed
here first, does this defeat the intended cleanup protection logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909003657.1570=
544-1-coiby.xu@gmail.com?part=3D3


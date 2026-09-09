Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924A5C79F9E
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oI9yUTRZpy5Q5+OvZos8ZCyIS7fJ/x1ZjGcs3opQbDY=; b=Mu3RxCxtB+AGYYEnDG/XLp4WjW
	RSCR6VWcwcqjpYcSFAvOt4cT2hIvvhp7MbC/FrgHptjklwockmJ2GwLH8WG69ALzOuaODYLBguDOw
	Ps7Zrxz7ZYdKmLTE0E3MoFeCVBO0QJpnY4zkm7YL14PbuM8Ukoe/UgAlcKg3h2HHLY1h1pHPWnDuW
	mpAhXv8TU4664GYXsgcEpbHvNwyjVV6WsxR3kT1VMWebAiZp6iaggckc0vxSotPdxM6PdyfoLVyzG
	WQB4EJW6XZX/lt/NQM/8OhqJOvGdI4j1CgKea5642rMPeXw6VLHKy2MshFi8QtSs72ZgrfOziPg/P
	O1I+FuYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46RW-0000000AX2N-1LSf;
	Wed, 09 Sep 2026 00:45:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46RU-0000000AX27-3y2A;
	Wed, 09 Sep 2026 00:45:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E50AE601FE;
	Wed,  9 Sep 2026 00:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2660B1F00A3A;
	Wed,  9 Sep 2026 00:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914735;
	bh=oI9yUTRZpy5Q5+OvZos8ZCyIS7fJ/x1ZjGcs3opQbDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJ/EKFl5RuO6OP8Tmk56KeDA+Z91o4v5KrM4HsNxMvRftsKt2BnPwNG5b4LAhr2zP
	 nj0/EN3N4DYwNZlgcwsrwNzzsGg2J/7Ef6idz7nONGKxegPCQREbl8N7MEEptB0B8p
	 Ptf3i+4g+i85xX7IYa3Y+PWwJIpA/UUY6Tk73GIcQLBFGvSsa5vCgznum0kOBnkn2W
	 tI31l7xj9CVjuBQ2VpduiRM7LelpeiqGupeWMORun4rlPBn1qFTp1iUTKViL0d1PYv
	 A789LVjBYtA4K4XwmoX06F8bxehEhGOozzrq0BcaveeiWXdGaZu6brpl8zWiCCXR6p
	 W8omxwWHNyHBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] crash_dump: Improve readability of
 config_keys_restore_store
To: "Coiby Xu" <coiby.xu@gmail.com>
Cc: "Dave Young" <ruirui.yang@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, "Sourabh
 Jain" <sourabhjain@linux.ibm.com>, "Baoquan He" <baoquan.he@linux.dev>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "open
 list" <linux-kernel@vger.kernel.org>, "Will Deacon" <will@kernel.org>
In-Reply-To: <20260909003657.1570544-7-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-7-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:45:34 +0000
Message-Id: <20260909004535.2660B1F00A3A@smtp.kernel.org>
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
- [High] The local variable `r` is returned uninitialized when the user wri=
tes a value evaluating to false.
--

commit 22a99a886bc0e01618cd42c5f2b503de86fa5a10
Author: Coiby Xu <coiby.xu@gmail.com>

crash_dump: Improve readability of config_keys_restore_store

This commit introduces user input validation to config_keys_restore_store
before restoring dm-crypt keys. It ensures the restore function's return
code is verified and improves overall code readability.

> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 9ad50ac54866a..b8fe630462cfa 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -371,13 +371,25 @@ static ssize_t config_keys_restore_show(struct conf=
ig_item *item, char *page)
>  static ssize_t config_keys_restore_store(struct config_item *item,
>  					  const char *page, size_t count)
>  {
> -	if (!restore)
> -		restore_dm_crypt_keys_to_thread_keyring();
> +	bool val;
> +	int r;
> =20
> -	if (kstrtobool(page, &restore))
> +	if (kstrtobool(page, &val))
>  		return -EINVAL;
> =20
> -	return count;
> +	if (val) {
> +		if (restore) {
> +			pr_warn("dm-crypt keys already restored!\n");
> +			return count;
> +		}
> +		r =3D restore_dm_crypt_keys_to_thread_keyring();
> +		if (!r) {
> +			restore =3D true;
> +			r =3D count;
> +		}
> +	}
> +

[Severity: High]
If a user writes a value evaluating to false (e.g., '0' or 'n') to this
configfs attribute, kstrtobool() will succeed and set val to false.

This causes the if (val) block to be bypassed entirely, resulting in the
uninitialized variable r being returned here. Could this leak uninitialized
kernel stack memory to userspace or cause undefined behavior?

> +	return r;
>  }
> =20
>  CONFIGFS_ATTR(config_keys_, restore);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909003657.1570=
544-1-coiby.xu@gmail.com?part=3D6


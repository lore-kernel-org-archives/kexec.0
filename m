Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8BDCA6012
	for <kexec@archiver.kernel.org>; Fri,  9 Oct 2026 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DK3/VZRkg9keQfDe/R52sricG0gQd0N7igHwZJUZjCc=; b=UIZ735jleu3mIKCP/Zxz2jFnqU
	6dJdraiJKOFAZxNCgDfcVW6KHsMBg6H6CGZNEumX/L7RH2slr/fM7qtjEeHX7aW8QA7zOFZOadROu
	eELkDHU0/KXz4xUPxOHiBVjzThGcqetwOJVwo7QLSmQFm8aJcmlAIM+kWRZKVbg0PeMrE3GiA9xgn
	tO3h2uWOfkuBNKM2evI+aRd/AJxVPDnC2E1KuSSF/xKIwljw+aU3wLglGZHuo6LFXjKARsTGGyohb
	2QKEYnJDalL1uxwqZdz9hq2WwkwJCQ+6lX/svj4OGoyULx/7o7fRt9XG2CIvmsbDEUNQDFZHVEpTb
	wu/a9DgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7qW-000000063wj-1YeA;
	Fri, 09 Oct 2026 10:29:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7qV-000000063wR-2Cv1;
	Fri, 09 Oct 2026 10:28:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 96C256053A;
	Fri,  9 Oct 2026 10:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3515E1F000FF;
	Fri,  9 Oct 2026 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541738;
	bh=DK3/VZRkg9keQfDe/R52sricG0gQd0N7igHwZJUZjCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omOk7SM4pteaQL3ytjlOMStKEP8y5BJpwnOgjK0TU1iMRq45r0o96UXOMicaN7vgj
	 RvguW/WX9Zw+EylgjqBLro15OZlgHso+0eVAPeE6v/dd0CY52lhca4GzDEUZTquQdm
	 Ty1uYuaO/T0cQi2/OlBcXtEIDJnGC4Owl8fZXXV8x0HGk7LyfH330jruzK6dibFL+G
	 wFXYMU7TmiYwyRz3De/nu8hsCVHl4oXA8XzGdFSBSg0IkkzvzEYZwGtPXpgAaLZrb2
	 mdfQaF2LhBOl3A4y9MU5HJ+Vkh7tZ53li7BVJWkdBbSV/70GsRIfe+bILB6so/1Ha6
	 1F+AKIjEKGU0g==
Message-ID: <sashiko-outbox-165237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] kexec: Add helper to report an active kexec
 reboot
To: baoquan.he@linux.dev, "Shradha Gupta" <shradhagupta@linux.microsoft.com>, wei.liu@kernel.org, catalin.marinas@arm.com, mhklinux@outlook.com
Cc: mark.rutland@arm.com, x86@kernel.org, decui@microsoft.com, maz@kernel.org, tglx@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, dave.hansen@linux.intel.com, kees@kernel.org, broonie@kernel.org, longli@microsoft.com, rppt@kernel.org, kys@microsoft.com, bp@alien8.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, haiyangz@microsoft.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@redhat.com, linux-hyperv@vger.kernel.org, brads@mainlining.org, will@kernel.org, pratyush@kernel.org, namjain@linux.microsoft.com, pasha.tatashin@soleen.com, arnd@arndb.de
In-Reply-To: <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
 <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:28:56 +0000
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

> A shutdown callback in a loadable module may need to distinguish a
> kexec reboot from a normal restart, halt, or poweroff. The Hyper-V
> VMBus driver needs this distinction when moving its kexec cleanup into
> a common syscore shutdown callback.
>=20
> Add kexec_is_in_progress() and export it to GPL modules so the callback
> can remain guarded when VMBus is built as a module. Provide a false
> inline implementation when CONFIG_KEXEC_CORE is disabled.
>=20
> The helper reports only the normal kexec reboot path. Crash kexec and
> preserve-context kexec do not set this state.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009102215.3360=
863-1-shradhagupta@linux.microsoft.com?part=3D1



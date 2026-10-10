Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97100CA6017
	for <kexec@archiver.kernel.org>; Sat, 10 Oct 2026 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Io44OKtN8L9s20sxzd0rilXBdNQoIbjjjTAYFAepx/w=; b=zWPo18O/ai3/qSuFDxEa+AIosl
	JNGQYrpgaypXvU/sSMRz0ud5w8zAlAWDeDnVRSH+U4fsdBvj4i6Rn8jM2KH5at6n2+RTRF9NSnG5M
	WHpQn+N/vaSTx/JgCYCRh/xjHA2Nbhwj8gLx89NYf4uxfAz4c+h1jRw1zP9hCM0/rquD5YmiThazT
	fyQsQamD9BPxbtbU5U1vRfOgxwaOHpsUTr3eLaHWpRn6bLbu5f/6bdFhHQ8ZRGgLTRlk8f6Uu0q3P
	NgmP9kv8ck8OT2dSy/kGDSrdJ9dfQLNExJi1p3fP5spyvDd0BQXNXvgynTZi4ffBpj3javD/1ZdsA
	UTdMgM0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFXJD-0000000883d-2yY0;
	Sat, 10 Oct 2026 13:40:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFXJC-0000000883E-35Up
	for kexec@lists.infradead.org;
	Sat, 10 Oct 2026 13:40:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 19BA343AF7;
	Sat, 10 Oct 2026 13:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DA71F000FF;
	Sat, 10 Oct 2026 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639618;
	bh=Io44OKtN8L9s20sxzd0rilXBdNQoIbjjjTAYFAepx/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MW+o7Ge29PerOGxb14B0X9AefCQ/ejSI8q/f+0jfu/GxHBzlOOkubHRyHnjlYwkQE
	 +Y/3QogWD4tmDUYPi65jf9A86vvCK06LhPX/YH4LP32st9wqjokWuYeFsYCtTCWKIx
	 fPL5LXXPrVIZyq1e4RjOtJZTYhuDGxoB8zLq6PuCfHPYsg8gg+GA24b2yqVVso3D8R
	 6xpPoKtG0P8cPcag1pU/OuzsdRM+14x0FQNUt6CJiHVSnTuSN6WKwdqi2OA/wvY6im
	 oQ4rLgn4OGZNsWng7UvakLZmijI3nSOUjywMOvpFX8dnF2qC5fyk/V7jhi/Ls/sHMp
	 LpwYcWkO7UOJg==
Message-ID: <sashiko-outbox-166588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PM: QoS: Add a sysfs CPU latency request with a
 boot-time value
To: "Roman Kagan" <rkagan@amazon.de>, "Pavel Machek" <pavel@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Len Brown" <lenb@kernel.org>, "Christian Loehle" <christian.loehle@arm.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nh-open-source@amazon.com, "Mike
 Rapoport" <rppt@kernel.org>, kexec@lists.infradead.org, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, linux-doc@vger.kernel.org
In-Reply-To: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
References: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:40:16 +0000
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
- [Low] locking: data race on req->node.prio in cpu_latency_qos_update_requ=
est
--

commit d19f16780c138f4d33dfa7e439454d2244724233
Author: Roman Kagan <rkagan@amazon.de>

PM: QoS: Add a sysfs CPU latency request with a boot-time value

This commit adds a CPU latency limit requested by user space for all CPUs,
exposed via a sysfs attribute. It operates similarly to the per-CPU resume
latency request but acts as a single PM QoS request shared by the entire
user space.

Link: https://patch.msgid.link/20261008-b4-cpuidle-shallow-v1-1-c19e71127b1=
4@amazon.de

> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 1944dbeb0d4c9..f381361939079 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c

[ ... ]

> +static ssize_t pm_qos_cpu_latency_us_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	s32 value =3D READ_ONCE(cpu_latency_qos_sysfs_req.node.prio);
> +
> +	if (value =3D=3D 0)
> +		return sysfs_emit(buf, "n/a\n");
> +	if (value =3D=3D PM_QOS_CPU_LATENCY_DEFAULT_VALUE)
> +		value =3D 0;
> +
> +	return sysfs_emit(buf, "%d\n", value);
> +}
> +
> +static ssize_t pm_qos_cpu_latency_us_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t n)
> +{
> +	s32 value;
> +	int ret;
> +
> +	ret =3D cpu_latency_qos_parse(buf, &value);
> +	if (ret)
> +		return ret;
> +
> +	cpu_latency_qos_update_request(&cpu_latency_qos_sysfs_req, value);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Can concurrent writes to this sysfs attribute trigger a data race?

This calls cpu_latency_qos_update_request() on the globally shared
cpu_latency_qos_sysfs_req object without external locking. Inside
cpu_latency_qos_update_request(), there is a fast-path check:

    if (new_value =3D=3D req->node.prio)
        return;

This performs a plain lockless read of req->node.prio, which concurrently
races with modifications under pm_qos_lock via plist_node_init() in
pm_qos_update_target().

The pm_qos_cpu_latency_us_show() function correctly uses READ_ONCE() for
this field, but the plain read on the update fast-path could cause KCSAN
warnings or undefined behavior if multiple threads write to the sysfs
attribute simultaneously.

> +
> +	return n;
> +}
> +
> +static DEVICE_ATTR_RW(pm_qos_cpu_latency_us);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-b4-cpuidle=
-shallow-v2-1-adede7dd9077@amazon.de?part=3D1


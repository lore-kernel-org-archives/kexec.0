Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC94DCC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bXwUwTDwIdQZIMMMkZasHnzd4wgakqaPWJ6Tg/h2edg=; b=PvyJeEdPsnwV+KxUMv33wyRhMl
	sDcxs5VuAa8XFQh3K1J0eYvuIyA0FwAak0df841fMs04CDOe5Hg+P7E9lpPn02FI41mwoVuefoaU1
	cej5/bEwmygw3IcN8n43fWRdmu7A1OvNjsMpU2NXtIl6k5yz6Nl1fTMEYZbP4TE0btq0n9mrHdFLp
	ZfMdW4jkwp09NztmfSV+kloDlmWWfzswa+mlxWn+kSw+UJ6Lb1VudJFKjhVS+N0dRJDS4RzBGuadp
	W6RkzgmBvUcc59agczJyYOwU11ME41bC+pBN/k6FCU4GMaWP/vg3OLNj3Z1fC9kmY0Gm77YJ7B3Ha
	9IW13rPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNi8-00000000cA1-2gqF;
	Thu, 15 Oct 2026 15:49:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNi5-00000000c9A-2jNR
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:49:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 02153434C6;
	Thu, 15 Oct 2026 15:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95841F000C4;
	Thu, 15 Oct 2026 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079376;
	bh=bXwUwTDwIdQZIMMMkZasHnzd4wgakqaPWJ6Tg/h2edg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QYnNLonQjLAyFKkXIZr1de7/0gi73jWKUyz+kOoIDQc5CmQ0tuiHemkcIEXz1xjz6
	 43VBytwnKwcH/a5qtpFEuJkoUTIGEGkh+tP9AwTfOMEQ6CUXlva3Rg5oJnoYMSgTLk
	 z3uzFQx2RKicph0YbImx6KQIofnrF8atXrDB8ARl+sRwlazKfm7C1XlmBsIErNf7oC
	 bukrDaH9OsXxsyZUkLgh7Na20NvEH5Ju/er3vo0AzuaEIs6TN+NTILVcRGooTmKGZU
	 rc4ubaR0zhJQSv1KPRsPoUX5tSU1rvyBq/rErCK7s5iuhjLsY9r2rW528Vkjhd4T3t
	 b2+xvBgAAA7xQ==
Message-ID: <sashiko-outbox-173102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/8] mm/vmstat: Avoid redundant per-CPU
 stat_threshold writes in refresh_zone_stat_thresholds()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261015153331.1872641-9-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:49:34 +0000
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

> During CPU hotplug, vmstat_cpu_online() and vmstat_cpu_dead() invoke
> refresh_zone_stat_thresholds() on every CPU transition. Currently,
> refresh_zone_stat_thresholds() first zeroes
> per_cpu_nodestats->stat_threshold across all online CPUs and all online
> nodes, and then unconditionally writes per_cpu_zonestats->stat_threshold
> and per_cpu_nodestats->stat_threshold inside the zone loop for every
> populated zone and every online CPU.
>=20
> However, calculate_normal_threshold(zone) only changes when
> fls(num_online_cpus()) changes (at powers of 2) and is clamped at 125
> for large normal zones (>=3D 16 GB) once num_online_cpus() >=3D 64.
> Unconditionally zeroing and rewriting every CPU's per-CPU stat_threshold
> on every hotplug step repeatedly dirties remote per-CPU cachelines with
> identical values (and briefly exposes stat_threshold =3D=3D 0 on live CPU=
s).
>=20
> [ ... ]
>   Total:     3.46 s ->  3.38 s (-2.3%)
>   refresh_zone_stat_thresholds() (cpu511 offline / online):
>     104.6 us -> 50.7 us (-51.6%) / 109.3 us -> 53.5 us (-51.1%)
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D8



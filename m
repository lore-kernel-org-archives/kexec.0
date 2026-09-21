Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C5CC982F7
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsIzCklxA1OR0ZhVy9j+cyd5RWzkJaDGyF6RmABKvFI=; b=XiEy8mxCn21ABjn/rm+/qM8Knr
	3mh6AdX3ICNA6ztCkpZPmdrlmS80y1LBKF9PaMJtd3vucw6a+vfLusNmfAIdAtC9LOthNulrNUyyT
	87v6+k4z2XywAb4zuyt3AetYGp//3G+f3CNNciBAJH0rMCFcb2DbrsBEmnLHVNiOAc0ZIPn5nmSKU
	vb6toN6whjONI1sXGn20u0BMDMZzqlJ4F6sLzbWaf/jjTrFZm5E7KyOrizSCZdRFf3UEGnkcYQQVR
	gKuQHLiWddzIUvTKu4JNx/hRMjSfQoGfzKwUzMCZ3X7XqT6WZOvN37SvSqA+Ba3HNqmSgaDsC0JzN
	cR4RlvDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adF-00000001Zj0-1jlw;
	Mon, 21 Sep 2026 09:48:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8aAV-00000001U15-3oI1;
	Mon, 21 Sep 2026 09:18:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D23841384;
	Mon, 21 Sep 2026 09:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871BC1F000FF;
	Mon, 21 Sep 2026 09:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982315;
	bh=tsIzCklxA1OR0ZhVy9j+cyd5RWzkJaDGyF6RmABKvFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMHnycOPKN9qTyZjIdzxqiQkBqe8TEOAyTaK79u+kYwBW/Wh9tJJF65/tlUGFl4Zf
	 /CqPGAac9B4NZ2mlNpo2Fzu6pZDo2D9yK2HdgqtYrF+HkXbYXVMGPmbxP9R+RhwJwV
	 YZblf79v1O7TYxdtcDmF9HQtIR5mdoqv1EBbRHqzkrJ+LRMsP/aSjLZPWJcdPQyyqH
	 gnzTMi9Nzgn9EW3vJs1OebGdTg8vKLmD+pLEukdRRqYj8nLU1eaknVh6FuPZNOWNPU
	 aAMOJXknMuq+uxAGd3fkvo0bi8Zm+cXxSIHwqVlhF5LsIdoWEUJtStC+zBb4hAAl8t
	 Ai37eNFY5eUnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/14] driver core: Add
 device_hotplug_lock_assert_held() helper
To: bp@alien8.de, kernel@xen0n.name, graf@amazon.com, npiggin@gmail.com, hpa@zytor.com, rafael@kernel.org, hbathini@linux.ibm.com, leitao@debian.org, takahiro.akashi@linaro.org, palmer@rivosinc.com, akpm@linux-foundation.org, me@linux.beauty, sshegde@linux.ibm.com, sourabhjain@linux.ibm.com, kai.huang@intel.com, x86@kernel.org, ritesh.list@gmail.com, pasha.tatashin@soleen.com, coxu@redhat.com, linuxppc-dev@lists.ozlabs.org, baoquan.he@linux.dev, mark.rutland@arm.com, linux-kernel@vger.kernel.org, piliu@redhat.com, zhangtianyang@loongson.cn, will@kernel.org, chleroy@kernel.org, chao.gao@intel.com, loongarch@lists.linux.dev, yeoreum.yun@arm.com, tangyouling@kylinos.cn, pratyush@kernel.org, rppt@kernel.org, mingo@redhat.com, seanjc@google.com, bgwin@google.com, catalin.marinas@arm.com, liukexin@kylinos.cn, driver-core@lists.linux.dev, guodongtai@kylinos.cn, mclapinski@google.com, james.morse@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, robh@kernel.org, vishal.l.verma@intel.com, kees@kernel.org, linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com, jbouron@amazon.com, thuth@redhat.com, chenhuacai@kernel.org, tglx@kernel.org, maddy@linux.ibm.com, dakr@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com, maqianga@uniontech.com, gregkh@linuxfoundation.org, mpe@ellerman.id.au
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-14-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-14-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:18:31 +0000
Message-Id: <20260921091831.871BC1F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
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

> crash_get_memory_ranges() walks memblock, which memory hotplug
> modifies under device_hotplug_lock.  A caller that does not hold
> the lock can race with memblock_double_array() and iterate a freed
> regions array.
>=20
> Add device_hotplug_lock_assert_held() so that crash code can
> use it to catch such unsafe callers via lockdep.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D13



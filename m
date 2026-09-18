Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B969C982EF
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+RK1cJzE7vYEJNH4KMTogSsel/5JlapcOCdBl4VlP4=; b=4mkovBkKmXJN3SOGIKp/VpmyW2
	GS1ij9LkR0R7oT265XGFnoRauhz8O3Hy2ssjqKtHB8suQgz5VhDhBkKgwY0Gduvh/mTU2XDaLBNgP
	vsT+EA/BCAYhkMFSF1BXrAhJUDhmGBTcjm0XhHIGhPZJz5hn0eCg0kQZgETCnriG5SX86QeaOdoC6
	eVtI1DSrnuv0pAIlqWODDvWPTokdIxlnXZMO/lWDR+VJr2AqxrMQL379Nu8xkrnlf0TO3dnLgvn5v
	Yfutzzz0NJaipv227+xovNry7MbyldRS7GAnHFOEplng99IE0aP5kARS9lnGfpLJ166DujX5UywX3
	BSsWlxow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4k-00000000NIx-1nr9;
	Sun, 20 Sep 2026 20:23:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Vns-0000000E5i8-048y;
	Fri, 18 Sep 2026 10:26:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95B0B439F7;
	Fri, 18 Sep 2026 10:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197B1F000FF;
	Fri, 18 Sep 2026 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727207;
	bh=5+RK1cJzE7vYEJNH4KMTogSsel/5JlapcOCdBl4VlP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eupBYsTA6h+6JQa2ShdpohTKsfpx+UdpDggKnPH+KXXFxsygHGJ3gVN7254T/GPMe
	 CCJuO2D+n0H9tMNb5k6YwM/32ifMNPqfHtQSFOCBaZj6dRWQ1vzKk3XpZyXdNfGkx7
	 B0Js2Z4P3IKPLnB+2SOz682eQuD+4qtrx8oYjMSHCPVu5RKdrncN8SQoPWtTZHGmte
	 Q4tbyvx8n9a4FX/eeC0AihF8aWsPxSvZDHDagwVODDYyAxhyaTW+yVRyV2j2QDDIoa
	 SpZ4/7ywTZa0GyrUoyi/T60ERtnAj0Y2RgtK2FOpO+4su/jwnsmyzw4AjMeXvnu3vY
	 TSIYXJPdwk56A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] crash: Assert device_hotplug_lock in
 crash_get_memory_ranges_nolock()
To: akpm@linux-foundation.org, me@linux.beauty, takahiro.akashi@linaro.org, linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, maddy@linux.ibm.com, hpa@zytor.com, yeoreum.yun@arm.com, lizhengyu3@huawei.com, loongarch@lists.linux.dev, mark.rutland@arm.com, blum@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, kas@kernel.org, pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org, chenhuacai@kernel.org, palmer@rivosinc.com, robh@kernel.org, ardb@kernel.org, linux-arm-kernel@lists.infradead.org, seanjc@google.com, tglx@kernel.org, thuth@redhat.com, tangyouling@kylinos.cn, adityag@linux.ibm.com, x86@kernel.org, pratyush@kernel.org, kernel@xen0n.name, liukexin@kylinos.cn, bgwin@google.com, ritesh.list@gmail.com, will@kernel.org, dakr@kernel.org, chao.gao@intel.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev, zhangtianyang@loongson.cn, hbathini@linux.ibm.com, jbouron@amazon.com, sourabhjain@linux.ibm.com, kees@kernel.org, gshan@redhat.com, mclapinski@google.com, rppt@
 kernel.org, guodongtai@kylinos.cn, coxu@redhat.com, piliu@redhat.com, ruanjinjie@huawei.com, maqianga@uniontech.com, mingo@redhat.com, linux-mm@kvack.org, mpe@ellerman.id.au, chleroy@kernel.org, graf@amazon.com, linux-fsdevel@vger.kernel.org, bp@alien8.de, eric.devolder@oracle.com, vishal.l.verma@intel.com, james.morse@arm.com, catalin.marinas@arm.com, npiggin@gmail.com, baoquan.he@linux.dev, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, dave.hansen@linux.intel.com, leitao@debian.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-14-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-14-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:26:43 +0000
Message-Id: <20260918102644.5197B1F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

> crash_get_memory_ranges_nolock() walks memblock, which memory hotplug
> modifies under device_hotplug_lock.  A caller that does not hold the lock
> can race with memblock_double_array() and iterate a freed regions array.
>=20
> Add device_hotplug_lock_assert_held() and call it at the top of the
> function so that such callers are caught by lockdep.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D13



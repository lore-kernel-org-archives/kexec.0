Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C8C982F9
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lYPW2EitrWksOeNywbT4ACddfE8LBXRuHuJ++AYnkVg=; b=p8we1Igrn6Yj9Jx3uPe3V94CvD
	Gjno7qpNyQvMcFvDde8gkhjZQyRk5+Qn+3AIUNGLSwOQCJHL2YdKVVxk5G5N0kZfbMC9C3ej99YOB
	6hhNsEdePuJF2syurbSto6kNviVKCR9mdHIfwZ0DcsxeW5ANQBK4LRJD8nI3QKYfTY/Am6A8bLeUf
	4Hsy+MxJY+BTdTayhKezyKMglLEDvewPNuHIAWzzGNcybWl3SLpAysVS8ZDEFiXNBrVvQroUfUKoB
	atKD3zJzIn4AfJRBo58THwsxaz8hnKksfTi5zB9E3oeEp+CH1n91OOCTE4TYI+p2TIgJHELWczC7F
	v0jcHsSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adG-00000001Zmf-2xge;
	Mon, 21 Sep 2026 09:48:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8aBm-00000001UCW-359g;
	Mon, 21 Sep 2026 09:19:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BCF8600C8;
	Mon, 21 Sep 2026 09:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE231F000FF;
	Mon, 21 Sep 2026 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982393;
	bh=lYPW2EitrWksOeNywbT4ACddfE8LBXRuHuJ++AYnkVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HgcUGeADs7/M03n4e2fM1RNJ+WDOaeSKU+QjIz/LtyFBUbeVb4L6/srXNM6s+yLNv
	 lemuTopLmR2RY1n46up1y6lfw2TMG+aXggHsOLTYpKvTSW+vgKxMx6SkvQeFQps3ws
	 LZmwqCnE+K8/UsHYTHgJgNTPjKAMTLM+s8evUKg2waXxzx3eq6dsntJvuKU8eTySRy
	 n36264uQDAJ9ioRxlPfRKtNGms4PwRu3OHjhXWjPEXx3gi/RjiBAl7Ew39lMayDC/6
	 xPzGfGJQuRTpNBCK4aGXsXkjg0/RZfLekSNvS3HBjltpptS1F1D56r968uAhWjn0Vv
	 hAK7VnVuwYw0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/14] crash: Normalize the kexec_load elfcorehdr at
 load time
To: zhangtianyang@loongson.cn, chleroy@kernel.org, eric.devolder@oracle.com, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, dakr@kernel.org, guodongtai@kylinos.cn, hpa@zytor.com, kernel@xen0n.name, chao.gao@intel.com, pasha.tatashin@soleen.com, npiggin@gmail.com, coxu@redhat.com, liukexin@kylinos.cn, seanjc@google.com, bgwin@google.com, rppt@kernel.org, bp@alien8.de, kai.huang@intel.com, sshegde@linux.ibm.com, kees@kernel.org, mpe@ellerman.id.au, tglx@kernel.org, jbouron@amazon.com, yeoreum.yun@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maddy@linux.ibm.com, gregkh@linuxfoundation.org, will@kernel.org, pratyush@kernel.org, akpm@linux-foundation.org, robh@kernel.org, tangyouling@kylinos.cn, piliu@redhat.com, hbathini@linux.ibm.com, mark.rutland@arm.com, chenhuacai@kernel.org, me@linux.beauty, mclapinski@google.com, dave.hansen@linux.intel.com, ritesh.list@gmail.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, leitao@debian.org, palmer@rivosinc.com, maqianga@uniontech.com, james.morse@arm.com, takahiro.akashi@linaro.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, vishal.l.verma@intel.com, catalin.marinas@arm.com, graf@amazon.com, sourabhjain@linux.ibm.com, mingo@redhat.com, ruirui.yang@linux.dev, rafael@kernel.org, baoquan.he@linux.dev, thuth@redhat.com
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-13-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:19:51 +0000
Message-Id: <20260921091951.BDE231F000FF@smtp.kernel.org>
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

> For kexec_load() the kernel does not build the elfcorehdr, so it is only
> rewritten by the first crash hotplug event.  CPU hotplug events do not
> change the elfcorehdr, but they may run without device_hotplug_lock
> (e.g. CPU offlining during suspend), so they cannot perform that rewrite
> without racing with memory hotplug.
>=20
> Normalize the elfcorehdr once when the crash image is installed via
> crash_hotplug_prepare_elfcorehdr(), while device_hotplug_lock can still
> be taken safely, and let the hotplug paths skip CPU events entirely.
> Architectures that do not need the rewrite  (e.g. powerpc) treat
> KEXEC_CRASH_HP_NONE as a no-op.
>=20
> The x86 crash hotplug handler now skips CPU hotplug events
> unconditionally, so nothing reads image->elfcorehdr_updated anymore.
> Drop the field and the code that maintains it.
> [ ... ]
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D12



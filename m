Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B1CCCF2C1
	for <kexec@archiver.kernel.org>; Sat, 17 Oct 2026 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:From:To:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yaDAKbPnX3HpuNTDLAnNxcR/jGoyDFB1q+z6ycJjZa0=; b=BiKJ7jceCT/owYvd2MU+YVqNDd
	ANngSJsWEYCx87ya5gEtpeC/G17KuxaAHhp1M2AAQakQXNQVeOVMFD1kg5ZLFVWR/2dMRGaIOyM9S
	Mhgji9h77aTMDEQK0z4JxNyfzUqTn3Lf1TQRBXgEhkeQ6SjHycPaJqKy9aJi3GY9CkQTB2S5hE12O
	WmaZZcF4rphUfHsaELUlli526sXNBRX6yhLR2telafrDLoMbsQ5mLlIlyZXhc5REgV7Ef+nw04lAi
	Kqn95+3wSzNaE2UIGYmNJoM9xKdnJa9BhgcXsDUDiYA3Edwfm2zNgNKblvyjDaIYENukbD/jtS2sz
	707b4RKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI78P-00000004um7-3MyE;
	Sat, 17 Oct 2026 16:19:49 +0000
Received: from mail-244116.protonmail.ch ([109.224.244.116])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI78N-00000004ulm-0Bcj
	for kexec@lists.infradead.org;
	Sat, 17 Oct 2026 16:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792253980; x=1792513180;
	bh=yaDAKbPnX3HpuNTDLAnNxcR/jGoyDFB1q+z6ycJjZa0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ubyZ2Wrq4LqZ5/7guNFCrqMzJvxMK8RL1PM5Vyn+aJD/wnUfKHsvu3qY30yjfCtsc
	 ZJgPhlX4eGlz+YCTHrfY9wN4q6M5wegRj6Gj/jS8fRSdTQ+ndNX6BzXKDTsZ8JGH70
	 z1LVnkCD0HzH/Y9r8/Z7GKAfZywq1aSau2iG5Ns2AbDcCkTcYX3EtwZmAu41iCodNS
	 LsnD8wlB/PXH9bzbrYOc34BGNTw+MUMrPvCfbGqERv1q0HIN1vXUDjjX6IA4kJ9UNk
	 Y7cRl8abz+ychT2UCfOeTZa6IyXfSIE12CtGNi76uYO9qBaZNdRyJcmYp/jslqe0Wy
	 NgcP1cXzTvOyA==
Date: Sat, 17 Oct 2026 16:19:31 +0000
To: rppt@kernel.org
From: BernardoGV@proton.me
Cc: sourabhjain@linux.ibm.com, pratyush@kernel.org, graf@amazon.com, akpm@linux-foundation.org, guodongtai@kylinos.cn, pasha.tatashin@soleen.com, ritesh.list@gmail.com, kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix global scratch size calculation
Message-ID: <d4c253f3-d36f-0253-f22d-43c9f397f6ad@proton.me>
Feedback-ID: 60703638:user:proton
X-Pm-Message-ID: 38ba154f675276b492e436a3eb2d748b1c610ceb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261017_091947_245600_882CB821 
X-CRM114-Status: GOOD (  10.97  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Oct 12, 2026, Mike Rapoport wrote:
> I mean more fundamental code refactoring that takes into the account all
> cases (and I could miss some)
>
> - NUMA vs no-NUMA
> - systems that have global scratch containing lowmem scratch vs those tha=
t
>   don't
> - and of course fix global scratch over-allocation

One more case for the list: reservations made before KHO sizes scratch
that are never served from it. HugeTLB is already excluded. crashkernel
is the other big one. Sourabh mentioned it in the powerpc thread. Here
are x86 numbers from a machine that never asked for KHO.

Ubuntu 26.04's generic kernel (7.0.0-38-generic) ships
CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=3Dy, so scratch is reserved on every
boot. (26.10 has since turned the default off. I've asked for the same
in 26.04 [1].) The machine is a single-node Ryzen AI Max+ 395 with
128 GiB and no hugetlb. kdump is set up the stock Ubuntu way, which gives
crashkernel 2048M high + 256M low.

Three cold boots of the same kernel, KHO on by default:

  kho/out/scratch_len   crashkernel   no crashkernel   delta
  lowmem                   760 MiB         248 MiB      -512 =3D 2 x 256
  global                 8,510 MiB       4,414 MiB    -4,096 =3D 2 x 2,048
  per-node                4,338 MiB       4,338 MiB         0
  total                 13,608 MiB       9,000 MiB    -4,608 =3D 2 x 2,304

"Memory: ... reserved" goes from 18,849,832K to 11,771,924K. The
difference, 6,912 MiB, is exactly the crashkernel plus 2x crashkernel of
scratch. With kho=3Doff it is 4,915,232K.

Both problems show up here. Without crashkernel, lowmem + global is
2 x 2,331 MiB and per-node is 2 x 2,169 MiB, so on a single node about
2,169 MiB of reservations get counted twice. That is the over-allocation,
and the total comes to roughly 4x what was reserved. crashkernel is
allocated with NUMA_NO_NODE, so it lands only in lowmem/global, at 2x.
If I read Sourabh's patch right, it would count NUMA_NO_NODE only for
global. On this machine that leaves crashkernel as nearly all of the
global scratch (about 2 x (162 + 2,304) MiB).

The cost is not only boot memory. Scratch ends up MIGRATE_CMA, so
anything that pins can't use it. Here that is amdgpu GTT on an APU. A
single process tops out at 107 GiB of a 120 GiB GTT limit with KHO on,
and at 117 GiB with kho=3Doff.

Happy to test patches on this box.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2171297



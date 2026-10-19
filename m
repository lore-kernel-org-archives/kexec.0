Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C23CCF2D6
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sXO2/1ZLYjpyHDjT93fi/BujL9M5/NL5FbbRDOzOStI=; b=eddfuxpkpcvU2xf2LC+995/SO+
	Z1YXLt2qK6KMRQVi1JtXET3yccfK4MYYEB/qLJmHmakDfe/iiPFtZvIxI1F3g+G2tOD5qVpqeLuVH
	+XAt0Zo+5d7e0WOdaJWTM1OcFSqK2DxB/Mm3pZI7MrxP1eonlFWH/aunyF5B+MKw/eNnDgjChC1YM
	4Rmp9+9HZm+leeh+AtUXDc3ZCtRkhtx0SltKwuTQxae73kQB/wi1rBAWzQYLNof2+5oCpmJQFU97R
	u/Cich/ZnSjkTa8nn2ta7IfuZaYWo3YVIATQiY1WGB0P5FHhXFDHSbEUUNkoiUD+/NpHWavJT5Hak
	wf6l6IHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIksz-00000007ELU-2XAQ;
	Mon, 19 Oct 2026 10:46:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIksy-00000007ELK-0vz3
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 10:46:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 01CCC4403B;
	Mon, 19 Oct 2026 10:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFA11F000C4;
	Mon, 19 Oct 2026 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406791;
	bh=sXO2/1ZLYjpyHDjT93fi/BujL9M5/NL5FbbRDOzOStI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lSYA73yMQyL4lLb4kPx0Zs3lLN5hldyzT3bd2envsgGUGVBvQEPWXtcmMckyJUUWu
	 8cZlXxgiJFs10A9wmhW7ZoJ3+cn5Sj8EAzUajflfgdSJFDA/5EUbftljxJ1W1sBT28
	 Ebr1W9F8TAOa95buU6O0qAHHExPX47+hbcJz6yGdaqvQjBp20HfbqrP+mN1qgsqhen
	 Jkwm4CCcW3ldfORM667zxYEiF5EMmbbgsf+z9ygLXnP8I9+4wEEGfarhlVm2SOemLW
	 Htv/UWXBk98wmVc0EwCUeHXTyQLw+Ja6IA7QaTIt051iJQPq4C3InOk5isPktjkx3Q
	 6kEab0XFecCSA==
From: Pratyush Yadav <pratyush@kernel.org>
To: BernardoGV@proton.me
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  pratyush@kernel.org,
  graf@amazon.com,  akpm@linux-foundation.org,  guodongtai@kylinos.cn,
  pasha.tatashin@soleen.com,  ritesh.list@gmail.com,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix global scratch size calculation
In-Reply-To: <d4c253f3-d36f-0253-f22d-43c9f397f6ad@proton.me>
	(BernardoGV@proton.me's message of "Sat, 17 Oct 2026 16:19:31 +0000")
References: <d4c253f3-d36f-0253-f22d-43c9f397f6ad@proton.me>
Date: Mon, 19 Oct 2026 12:46:28 +0200
Message-ID: <2vxzjynege7v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sat, Oct 17 2026, BernardoGV@proton.me wrote:

> On Mon, Oct 12, 2026, Mike Rapoport wrote:
>> I mean more fundamental code refactoring that takes into the account all
>> cases (and I could miss some)
>>
>> - NUMA vs no-NUMA
>> - systems that have global scratch containing lowmem scratch vs those that
>>   don't
>> - and of course fix global scratch over-allocation
>
> One more case for the list: reservations made before KHO sizes scratch
> that are never served from it. HugeTLB is already excluded. crashkernel
> is the other big one. Sourabh mentioned it in the powerpc thread. Here
> are x86 numbers from a machine that never asked for KHO.
>
> Ubuntu 26.04's generic kernel (7.0.0-38-generic) ships
> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y, so scratch is reserved on every
> boot. (26.10 has since turned the default off. I've asked for the same
> in 26.04 [1].) The machine is a single-node Ryzen AI Max+ 395 with
> 128 GiB and no hugetlb. kdump is set up the stock Ubuntu way, which gives
> crashkernel 2048M high + 256M low.
>
> Three cold boots of the same kernel, KHO on by default:
>
>   kho/out/scratch_len   crashkernel   no crashkernel   delta
>   lowmem                   760 MiB         248 MiB      -512 = 2 x 256
>   global                 8,510 MiB       4,414 MiB    -4,096 = 2 x 2,048
>   per-node                4,338 MiB       4,338 MiB         0
>   total                 13,608 MiB       9,000 MiB    -4,608 = 2 x 2,304
>
> "Memory: ... reserved" goes from 18,849,832K to 11,771,924K. The
> difference, 6,912 MiB, is exactly the crashkernel plus 2x crashkernel of
> scratch. With kho=off it is 4,915,232K.
>
> Both problems show up here. Without crashkernel, lowmem + global is
> 2 x 2,331 MiB and per-node is 2 x 2,169 MiB, so on a single node about
> 2,169 MiB of reservations get counted twice. That is the over-allocation,
> and the total comes to roughly 4x what was reserved. crashkernel is
> allocated with NUMA_NO_NODE, so it lands only in lowmem/global, at 2x.
> If I read Sourabh's patch right, it would count NUMA_NO_NODE only for
> global. On this machine that leaves crashkernel as nearly all of the
> global scratch (about 2 x (162 + 2,304) MiB).

To remove crashkernel from scratch calculation, you'd have to allocate
it from outside of scratch, like the hugetlb pages. Crashkernel is
usually allocated earlier in boot, so we'd have to call
kho_extend_scratch() before crashkernel allocations, and I am not sure
if something will break if we do so. I suspect we at least need to check
efi_init().

Not saying it can't be done, but it isn't trivial.

>
> The cost is not only boot memory. Scratch ends up MIGRATE_CMA, so
> anything that pins can't use it. Here that is amdgpu GTT on an APU. A
> single process tops out at 107 GiB of a 120 GiB GTT limit with KHO on,
> and at 117 GiB with kho=off.

Well, my pipe dream is to have KHO entirely without scratch. You would
use the same mechanism that kho_extend_scratch() uses, to discover all
usable early boot memory, and not pass over any scratch at all (or, a
very small amount of scratch). The only problem is that it might fall
prey to fragmentation. If preserved regions are spread apart enough, you
might end up with _no_ memory to boot from. I am not sure how to make
this idea reliable yet.

>
> Happy to test patches on this box.
>
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2171297
>
>

-- 
Regards,
Pratyush Yadav


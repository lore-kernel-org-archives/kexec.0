Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE5DCA9ED1
	for <kexec@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=li1gWyf1yXK2Y0+8Y+XJI0fZtOcno0yy1qKJ4a5DFLQ=; b=Z+hALNmU9VLjolvIrHYYcTdRuA
	Fzv9ZFrlqGK4ahPnnkNdUSOu+AWjt6Vy7XUFHmIzQSVyFB+iZuyCyT4XmhCp3/EWmotF1kY1mvpGO
	2v8v1It95elvp6pOkR9AgNUkVVUvH7VxU5xZP4k6y5RAnvxdQGDNu+VeyXXCSc65BN/qsbyxA2LpI
	Whh1eZyMhFP8rp1S6Ulr5wGRtR84S8+oadUZHAnPWqKIlFuNZGj8knIcNL5c4mlgoBIUNAGXZNVAK
	ULZ+aOPxaHS28QTFKeXucYf1iTZMUGiGz5IDz61mQfQx4lFjrSxszHY4D/O7fuoyipX4yMLZBxQKw
	TRiwvXLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGDHv-0000000AFHF-2Nyk;
	Mon, 12 Oct 2026 10:29:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGDHt-0000000AFH2-2SME
	for kexec@lists.infradead.org;
	Mon, 12 Oct 2026 10:29:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 450E7435AB;
	Mon, 12 Oct 2026 10:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9109C1F0089B;
	Mon, 12 Oct 2026 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800985;
	bh=li1gWyf1yXK2Y0+8Y+XJI0fZtOcno0yy1qKJ4a5DFLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kRu+XuQMs2afadLx1E/dMzg4UjakTRJyFch11x+nKfuPjfky+k/kNXDOoDhj3rW1N
	 Vcpq9nfCc9DtqvN2BFOChx3riMtqSRoHOsOtlczK6tjDBlBNZWL8KKX3xlnOBCDDL3
	 f0F01h3Oo3jSMMsgotPXe5Mff0ELWO78/1SvG8M9Qog5tkbflus98C/kST/AEaxLSY
	 7gci+2byo1HErx2KJwEYiBm2aPoPPkW3jNs7jEj83RLZ6dvGnB88+MnD2lTvgkxSqC
	 2jkjTNzSBrbhEVkFdz/snNWEEAzPObgs0kY49vAdZiiBAIcFYl31oeTesZd6W9y1UO
	 lLKap5XQ8vVGA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Jordan Richards
 <jordanrichards@google.com>,  Mike Rapoport <rppt@kernel.org>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/liveupdate: Prefer KVM and HVF over TCG in
 vmtest.sh
In-Reply-To: <20261008132813.1966023-1-dmatlack@google.com> (David Matlack's
	message of "Thu, 8 Oct 2026 13:28:13 +0000")
References: <20261008132813.1966023-1-dmatlack@google.com>
Date: Mon, 12 Oct 2026 12:29:42 +0200
Message-ID: <2vxzv777jjop.fsf@kernel.org>
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

On Thu, Oct 08 2026, David Matlack wrote:

> Pass the -accel options to QEMU in the order KVM, HVF, TCG, so that
> vmtest.sh prefers to use KVM and HVF over TCG when they are available.
>
> QEMU uses the first accelerator in the list that initializes, and TCG
> always initializes, so the tests currently always run under TCG, even
> though the commit that added vmtest.sh describes "automatic accelerator
> detection (KVM, HVF, or TCG)".
>
> Fixes: 89dd1421c554 ("selftests/liveupdate: add end to end test infrastructure and scripts")
> Signed-off-by: David Matlack <dmatlack@google.com>

IIUC HVF is only for MacOS. I don't think we care to run this script on
MacOS.

Anyway, thanks for the fix

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> ---
> Tested by running run-vmtests.sh and then observed that arm64 correctly
> fell back to using TCG after trying to use KVM and HVF, and that x86
> reported no warnings.
>
> arm64:
>   qemu-system-aarch64: -accel kvm: invalid accelerator kvm
>   qemu-system-aarch64: -accel hvf: invalid accelerator hvf
>   qemu-system-aarch64: falling back to tcg
>
> x86:
>   (not warnings)
>
>  tools/testing/selftests/liveupdate/vmtest.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
> index 64fd2ab55b76..69beda6c961d 100755
> --- a/tools/testing/selftests/liveupdate/vmtest.sh
> +++ b/tools/testing/selftests/liveupdate/vmtest.sh
> @@ -180,7 +180,7 @@ function run_qemu() {
>  	echo "# Serial Log: $serial"
>  	timeout 30s \
>  	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \
> -		  -accel tcg -accel hvf -accel kvm \
> +		  -accel kvm -accel hvf -accel tcg \
>  		  -serial file:"$serial" \
>  		  -append "$cmdline" \
>  		  -kernel "$kernel_path" \
>
> base-commit: 80cf37169daef112b6bea9ae7d9808355a045475

-- 
Regards,
Pratyush Yadav


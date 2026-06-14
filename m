Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18497CD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3kqt2PsjkTRNbqmgv01YobweDN9fkjlj+b394Tb6Uu0=; b=RgGJilT9l89wN9b1c19kvoBHGF
	JbNDqZTl1q1UI6yX8CbmESfOxNi1M5hdc+pqPQjOuqUnrAiH+e2C/wu5oP347W/kNiCKt44qHy1GL
	16MsBPKM1TXRJbR+853KZR91t5AoCExcNH6s2q94qv50/hmCrHqpMkajx4BdgspQhRcTZNW0KyDtz
	mo/nP1i6AvzePeA/8xrt0x6Bok5LWaRQsA0WD0uc2kpOGM+QNbwYLt6zUzTu94oxa1x7pF9gE7xrk
	XRANEojOH9eOiX9WsXntO4ghVx9/jPrJiOy5h9VM5U7RTxBox79rO9JH0DkOX/0nl1TSAgfAHQTaW
	UE3KavSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYhzm-0000000CrYg-0vRh;
	Sun, 14 Jun 2026 10:23:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYhzk-0000000CrYa-3B6N
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 10:23:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CB0D24431C;
	Sun, 14 Jun 2026 10:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315241F000E9;
	Sun, 14 Jun 2026 10:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781432591;
	bh=3kqt2PsjkTRNbqmgv01YobweDN9fkjlj+b394Tb6Uu0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Ealqgkai4qqTif1CDYIGqpuXKEUkZpWX1rrlTJZYqn4Gk8Nh8DDN3ub6KB02kVvZN
	 x4CAJMfzUv7VEeOzFAB3PtoQc3yYUD3HTwf4SHDYxCOPZiw39hIFVIG2P3LduzPW1O
	 pYj58K3ewGrckUmR6B+zCng2vz4C8k9AXgGN1kirbidHcnCW6EYXEC2qG151+cN8Q9
	 Eo4X70VM1fItupStDRQjHyA44R5N/eHuCNoMhHyDUFO5cGpMx5FaT15HKm76d04nK2
	 ab5dFLosIzV4tt0xcUzjbzAcIhNkjI2iCb2nblLkldnpZhYU+ABp9SfjlyB5tjMQwm
	 NbmQbN8BkBe5Q==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/3] selftests/kho: add LoongArch vmtest support
From: Mike Rapoport <rppt@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: Huacai Chen <chenhuacai@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 George Guo <guodongtai@kylinos.cn>, WANG Xuerui <kernel@xen0n.name>, 
 Alexander Graf <graf@amazon.com>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Kexin Liu <liukexin@kylinos.cn>
In-Reply-To: <20260601093930.112758-3-dongtai.guo@linux.dev>
References: <20260601092823.110362-1-dongtai.guo@linux.dev>
 <20260601093930.112758-1-dongtai.guo@linux.dev>
 <20260601093930.112758-3-dongtai.guo@linux.dev>
Date: Sun, 14 Jun 2026 13:23:03 +0300
Message-Id: <178143258399.2123877.4049283498071192411.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Mon, 01 Jun 2026 17:39:30 +0800, George Guo <dongtai.guo@linux.dev> wrote:

Hi,

> Add loongarch.conf to configure QEMU's LoongArch virt machine with a

Please spell out "virtual machine" here and below or use VM abbrevation.

>
>
> diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
> index 49fdac8e8b15..918698b6dd2a 100755
> --- a/tools/testing/selftests/kho/vmtest.sh
> +++ b/tools/testing/selftests/kho/vmtest.sh
> @@ -107,12 +107,20 @@ function run_qemu() {
> [ ... skip 14 lines ... ]
> +		-kernel "$kernel"
> +		-initrd "$initrd"
> +	)
> +
> +	if [[ -n "${QEMU_TIMEOUT:-}" ]]; then
> +		timeout "$QEMU_TIMEOUT" $qemu_cmd "${qemu_args[@]}" || true

Runnig with timeout can be actually useful for other architecures. Let's
make a local variable for timeout of 120 seconds and always run qemu with timeout.

-- 
Sincerely yours,
Mike.



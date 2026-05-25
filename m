Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5739CCD5BCE
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjY9MInIrdeSdVKHsoHljcvbmHUlFL7f0hkiG9rqDjI=; b=nyRNzVefNK3J1Qw8ZZcccsOZ5A
	Fs5wPmqUpXQz7unsMZLJxu4bB0K04RpXTfd8zHPCYUF1Ta2ws0FVZnLr/qQLvLJVRxwOXhdO7cwE9
	xWaCmCcKxJrCtnv8o2ipP6qmdIt5ZRuNYdL4K9ggDWrgxxkYqY5in2LRbUKKLb9ROKZmwisrZmzY0
	NRUpkat1SuCAH2X1YmawmfkbgYTJYqplTJCSWeA7S8ykbxvI24oJZLkdVPA3hZBq76FAm7RTB0T6r
	jQafTQ11CjtEtKAe6n2Y/pcngqPB+giFl4HlBqV5b5iPA4BWOVV8sgLnb2U1+4qaZrHjzTJ5tt3u7
	a2D3vhhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRQ32-0000000GYvi-0O0H;
	Mon, 25 May 2026 07:48:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRQ30-0000000GYv3-1YMB
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 07:48:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 87430601FC;
	Mon, 25 May 2026 07:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D4C1F00A3A;
	Mon, 25 May 2026 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779695305;
	bh=wjY9MInIrdeSdVKHsoHljcvbmHUlFL7f0hkiG9rqDjI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VgFiOYr6S0DjulovWK0ttkMDGLLywevPI+YoML7qLCufLrKNwD3HggOMvcwOvMZaq
	 ZUXcaANqTQn6CBaR2TxSV7UQP9sudD33jQ+3G3cXfeZzHr1P0J7uDno03Tjf/m3Brd
	 dZLaEJgrFCwqUxTxcgRgmtxmdGPU8kx6GdhoMcVFWnjdW9KkXlDIDReZbfy+uJSznU
	 Zc49VqyBE/QJwZ3fKbhtsyqEFRw9kgbLPbmv1uYAd9/3rO+6jdvqzz9V7Khxhqa59D
	 QgRJB8XB7KoTHf5deafYNRqiLNNXUxfR2fStlLk4NhXKHFpMLmACTdxGgBRtAwAs2r
	 I2EekSJyNzmow==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 7/7] selftests/kho: handle QEMU not exiting after kexec
 on LoongArch
From: Mike Rapoport <rppt@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org, rppt@kernel.org, pasha.tatashin@soleen.com, 
 pratyush@kernel.org, kernel@xen0n.name, graf@amazon.com, shuah@kernel.org, 
 loongarch@lists.linux.dev, kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Guo <guodongtai@kylinos.cn>
In-Reply-To: <20260525062810.103367-8-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
 <20260525062810.103367-8-dongtai.guo@linux.dev>
Date: Mon, 25 May 2026 10:48:14 +0300
Message-Id: <177969529482.4047269.8837009779600841681.b4-review@b4>
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

On Mon, 25 May 2026 14:28:10 +0800, George Guo <dongtai.guo@linux.dev> wrote:
> diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
> index a6ae9ac09595..3cb9674e4475 100755
> --- a/tools/testing/selftests/kho/vmtest.sh
> +++ b/tools/testing/selftests/kho/vmtest.sh
> @@ -103,16 +103,37 @@ function run_qemu() {
>  	local qemu_cmd=$1
>  	local cmdline=$2
>  	local kernel=$3
> +	local arch=$4
>  	local serial="$tmp_dir/qemu.serial"
>  
>  	cmdline="$cmdline kho=on panic=-1"
>  
> -	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \

Just make it 

	timeout 100 $qemu_cmd ...

for all architectures.

-- 
Sincerely yours,
Mike.



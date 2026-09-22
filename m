Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A339C982FA
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQVO+L6U+7PhHURB8dec1U6IWGgiQcJA8wyG052zgM8=; b=3u/4zL60YvyeMj9PALj0uzXYLo
	0CzySeW6OE7W0838pRkolyaR3obeUTDwxzrwwL7n2aGxtcXjFApumcgConVDmwISUYg0S1NaluCQS
	JU84YA7tVSi4NJB+QYn+RDyQdk2wsoHN7yxa8PJ+6AuxochX0pmceFctD47/EjLyXAMJ2n+qEqSwC
	iWM11plZTVfrnhpZqDSfR4RigGgHZasIQv6di269XgjQZxrIjEBtw8iKfT3rfqnmCVLzYE3ObjvRi
	DX/F3fzR7rR6YmdZrwa60awUb4fuxfLwiXePT/W6cWxGuDrcDiNNNJpJx08hnganKYSf+avjGFmXr
	UZBE31AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zOm-00000005HJV-0fwv;
	Tue, 22 Sep 2026 12:15:00 +0000
Received: from mx1.mythic-beasts.com ([2a00:1098:0:86:1000:0:2:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zOi-00000005HHu-2SmN
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 12:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=From:To:Subject:Date;
	bh=WQVO+L6U+7PhHURB8dec1U6IWGgiQcJA8wyG052zgM8=; b=DC/Yh8ApRsFZCRmoUijng34Jfs
	xZtRwOEd+231PI9jyCNquXT+r2XU28m2RRWwbhRvpFXn9kjVZbR7/8HKDoB3t7HqqdwePUOS30Vzo
	ohyrI1+oc9FT0czZUAAkIUXlZ+ALfO3o1+eeD+S69iJi3d2oeUlrHFioxs4+pYYMewQN1piVe4NvJ
	ksyccqQQoqzLv6VM5C6VQMH5pk8rI+MvStXhuqcEbogG8yblIpyFWcM1N6CpHggDAgV215BQXrIS5
	2Tlkt9XQXl1t4D+r6YlJiVugtqGsrcUJeNOiw0E3KaAlQWCbEFCzUY0rPVe4X53wknNizYRQY1Kbo
	R7EbKJTQ==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tom@tom-fitzhenry.me.uk>)
	id 1x8zOf-00FOFy-1N;
	Tue, 22 Sep 2026 13:14:54 +0100
Message-ID: <a3f3f6c9-809d-4998-a23b-8eb0c825333b@tom-fitzhenry.me.uk>
Date: Tue, 22 Sep 2026 22:14:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kexec-tools v3] arm-zImage: prepare for more malloc
 requirements of zstd
To: Andreas Kemnade <andreas@kemnade.info>,
 Russell King <linux@armlinux.org.uk>, kexec@lists.infradead.org,
 j.neuschaefer@gmx.net, Mike Rapoport <rppt@kernel.org>,
 Pratyush Yadav <pratyush@kernel.org>, Tom Fitzhenry
 <tom@tom-fitzhenry.me.uk>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20260922-malloc-fix-v3-1-1d61286bde65@kemnade.info>
Content-Language: en-US
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20260922-malloc-fix-v3-1-1d61286bde65@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_051456_882471_90E1EAD9 
X-CRM114-Status: UNSURE (   4.94  )
X-CRM114-Notice: Please train this message.
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

I tested this in QEMU with kexec-tools at 43c5cba85ad2 plus this patch:

1. Against unmodified Linux 8d3ae59288f1 (gzip): kexec reads the
    64 KiB malloc size from the header and boots the second kernel via
    kexec -e without regression:

   # /bin/kexec-patched --debug -l /boot/zImage 
--initrd=/boot/tiny-initrd.cpio.gz --append="console=ttyAMA0 kexec_booted=1"
   [...]
   zImage size 0x1a3500, file size 0x1a3500
     offset 0x00007770 tag 0x5a534c4b size 24
   zImage requires 0x001b4500 bytes
   [...]

   $ printf "0x%x\n" $((0x001b4500 - 0x001a3500))
   0x11000  # 0x1000 (4 KiB stack) + 0x10000 (64 KiB malloc)

2. Against Linux 8d3ae59288f1 with the v2 ARM zstd series[1] applied:
    kexec reads the increased 128 KiB malloc size from the
    header and boots the second kernel via kexec -e:

   # /bin/kexec-patched --debug -l /boot/zImage 
--initrd=/boot/tiny-initrd.cpio.gz --append="console=ttyAMA0 kexec_booted=1"
   [...]
   zImage size 0x182548, file size 0x182548
     offset 0x00017370 tag 0x5a534c4b size 24
   zImage requires 0x001a3548 bytes
   [...]

   $ printf "0x%x\n" $((0x001a3548 - 0x00182548))
   0x21000  # 0x1000 (4 KiB stack) + 0x20000 (128 KiB malloc)

Thank you addressing my comments.

Reviewed-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Tested-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

[1] 
https://lore.kernel.org/lkml/20260828-zstd2-v2-0-4d9ce7150877@kemnade.info/


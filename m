Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84E0C87FCF
	for <kexec@archiver.kernel.org>; Sat,  9 Aug 2025 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GWFLV3j+XOANdYBimYJ4zedPVrX3giwHycaRYnwL3b8=; b=l/cp5kmPzFwbbP5/SRmrvU4Dc/
	0pa32IzzKdKp0eqVHMidyJTGOkAbqfr/Ne9UItotFXwEGMqZZOCnhPqt3xEtyrkkylF8oX2NUXxep
	3roP3uJ3I3pG4fZfCunPBEkX4X4zdkekU5oKUyaWX2fhAOOsnO1d0ItTBNw0y/JiDi8AqcMUTb2/s
	BP9RXBq69a7Z6njkXDcfc5DuAYXWn8XLZwKOb65rlp2BJEHetHkk89RDGsNVe3Ls+e25riqYLupmK
	xz2VNT7ZlYt5lnq20V5Wxn8mbqySRqphYdngMjvTY5M8CTqYdpOdbPAVBEZ5EeC5egAxpaT4O4OXv
	7QFOkrnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukl5b-00000004bpK-0yuT;
	Sat, 09 Aug 2025 15:02:31 +0000
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukl5W-00000004bp0-0hvM
	for kexec@lists.infradead.org;
	Sat, 09 Aug 2025 15:02:27 +0000
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7CDD94505F;
	Sat,  9 Aug 2025 15:02:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (100-96-55-144.trex-nlb.outbound.svc.cluster.local [100.96.55.144])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1E39244A29;
	Sat,  9 Aug 2025 15:02:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754751742; a=rsa-sha256;
	cv=none;
	b=ZifmuoKFioLVwij0c7PQ0BPqScyMki5tbpOGgMfV82o2Ka1ezKFVui1lYpBUZ8mnguJykm
	lFELoDcx5aepgy1xyRoBUO0u3jBZSiV0NP92aUR0Bp/Q/uiC1cY4nHF+fYSO7ICmNBw+i2
	p3IpY4eeuoiiHFMKwofozFJUZAG2ZsfO0rzQ1vnpA/I+KOCkTOfHiqIZVb/rpE6H9POu7x
	YJFSHkMT6ASwPn2rwQLCeskZLgAIi3JpQxYphQADaM47OOh3T6ZN1XxVoS0YNbErqUbDKt
	4fCgC+gGTDMndO32CMQU86QyGvsLv9QhZcDM6tFxrUjM2sAQEXfIueVmit7rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754751742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m6IMy7lNX/Af0fhZL9pGdjjp7pfTiPVYPel8oysoPb0=;
	b=oUBAu6row978mdiominQokoIFj1cG3gxFtmMTCTZlavc7qTUXvMVowjQKjqCqIMasa94Ci
	Q5q98gpA2pUOLlgJxixv/wl+ZKkLJWO/yuyiGxOnHabXrtMeWON3aLg7i2s9Jmdkydg+3p
	IoFgx3xF0tmgWUAm4LKeniujx1mCgP0UhhnuNyT49sblnOUbW6EB3bOk6qYUl6T9GdbtWN
	LmWkZOGAS4jD9vEfr5x33bPDKMcmlBw6F71esuWfJZMgKb9YFPVx8Ym2Pz/MW19jZo9vE/
	E/EEwsb4YVWwbXcWBF3oPg83a1W7/93vgrUx36/QUFwH0/Yh1NgCoRicAt7Umw==
ARC-Authentication-Results: i=1;
	rspamd-64567b6586-jmh4x;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Snatch: 705235065017f21a_1754751742366_233136106
X-MC-Loop-Signature: 1754751742366:2427474581
X-MC-Ingress-Time: 1754751742365
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.55.144 (trex/7.1.3);
	Sat, 09 Aug 2025 15:02:22 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4bzkdn3FTVzDd;
	Sat,  9 Aug 2025 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1754751742;
	bh=GWFLV3j+XOANdYBimYJ4zedPVrX3giwHycaRYnwL3b8=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=PGegFFGM9+Ol5b8kO1xxUpeW6IaRnNljkSlO6iG+h50HfrlivQ9rTwi1LvOBK/F2n
	 eLn1/QuQDC/0Cl/t5Quja9xkbCRnM8T9BItAtVj+MAFhDs4D11SL+LI5XDdQ38XT34
	 4p2lpHaj3Fp5XsqDCKRExFtcgCsOlI3iBigN2hfFSQr+9Gii8Z29hdmpi7Ok7wABIu
	 p87NbZihRm4v5ykz6gg1B7rP6b8yI1T1YnxfVGCN7x41KlFayid8wssmbEddX3+Wqp
	 sqXdVlgr9O4gV+Z0VAEG98yOJo6/QXpbTQX/oBJ6E3mmJQnhpbAVPI1FULNDQGG/Yk
	 fvUkMZaKQtx1Q==
Message-ID: <feadab5e-915c-44ae-a1a2-46a2efc5f113@landley.net>
Date: Sat, 9 Aug 2025 10:02:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Lichen Liu <lichliu@redhat.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 weilongchen@huawei.com
References: <20250808015134.2875430-2-lichliu@redhat.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250808015134.2875430-2-lichliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250809_080226_411076_C0148C12 
X-CRM114-Status: UNSURE (   6.05  )
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

On 8/7/25 20:51, Lichen Liu wrote:
> This patch introduces a new kernel command-line parameter, rootfsflags,
> which allows passing specific mount options directly to the rootfs when
> it is first mounted. This gives users control over the rootfs behavior.

Works for me. In an i486 mkroot build against stock 6.16 with this patch:

$ root/i486/run-qemu.sh
...
# grep rootfs /proc/mounts
rootfs / rootfs rw,size=125728k,nr_inodes=31432 0 0
# df
Filesystem     1K-blocks Used Available Use% Mounted on
rootfs            125728  764    124964   1% /
dev               125728    0    125728   0% /dev


$ KARGS="rootfsflags=size=1m" root/i486/run-qemu.sh
...
# grep rootfs /proc/mounts
rootfs / rootfs rw,size=1024k,nr_inodes=31432 0 0
# df
Filesystem     1K-blocks Used Available Use% Mounted on
rootfs              1024  764       260  75% /
dev               125728    0    125728   0% /dev

Tested-by: Rob Landley <rob@landley.net>

Rob


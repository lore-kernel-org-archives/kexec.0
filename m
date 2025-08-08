Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C50AC87FD3
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D1TZb3mxnOhzg2Vdcog/qlZmoNoGc345fnptq8iGJ98=; b=qQQLAxGFS0+aBTvlagOtvzWoAd
	wJ/8jGAs9/qsfUtt3PbYgxroSOXTD+UkrkQfb1N2x2C0ed7A195gIeGcDlZsU6B75pGK061LKZGtx
	6Jif8PCdprycBbXZsvFc+07ueOC5qyjeVM4TaW7WOf+P484uk4Pujv2D3lr6AE9Zevx1DYQzRKa3y
	khQPQDgMN9EBv3C/rE+8gZRI3ktPSZy3yEA4juHEc+D/cjGf6gilt1S20ufDInVCFi+83auJw0QLr
	tpQUefQQkokYE6nb84FMry3vK8uh4HUcFLOLba9Uxq0QEEsfZEfro9mTPWojZWqNvv8ucQ5VN5XsO
	qoFCtfrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukOF0-000000032Xp-3wrx;
	Fri, 08 Aug 2025 14:38:42 +0000
Received: from crocodile.ash.relay.mailchannels.net ([23.83.222.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukOEy-000000032XR-2iG5
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 14:38:42 +0000
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F1778163C02;
	Fri,  8 Aug 2025 14:38:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a287.dreamhost.com (trex-blue-7.trex.outbound.svc.cluster.local [100.96.43.79])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 65F4E163B10;
	Fri,  8 Aug 2025 14:38:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754663917; a=rsa-sha256;
	cv=none;
	b=U5DOtUOe+EXj0k9jC2e2otGFUbw7gtlv5kLVHHvPNLp6s+RFlSsfLZVvOEOl4Qzwsmt22P
	XnQmDzpAT28DxZcjeSeNSeH0c0ZlIfF63IG9n1yTCzn9HbdCV+9Skru2h9TMHql8etmbDY
	o1q+L564EQciGjAadK4MGtJv07Ts0xR1bnn5FN2SpAvCE76N6jr2a1XUXQrCtNpWDJT2vU
	9iTdh6mRLe1f9VivpBxU+2ZZJVZtC7QT228dpQ5Z7FfbN8oIXHJqqM8jn5KgEUrMJtgotq
	u5Jl5lJATnOtuNuAuZFRc8DBVYjno44c0KzPmb8nePGN7mzvGdSjdcTmlwocQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754663917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=D1TZb3mxnOhzg2Vdcog/qlZmoNoGc345fnptq8iGJ98=;
	b=UKj+eOWxtRJ6GoVPm0GBqSteOq42xAYZIkWkyCrZMp26VjsgnkY6zJ3k25FBIm2z6PTJ/A
	cBhjlNIKSeNYuDBuNui2FLJy4P013s27amVvMu6TXaaCEORtItXQTFaig4Gtr+zEHpan3O
	8MYVyODQXObrQOk4eHx0ucuA8gho9crgIixUiFFJbrTUCAU/UfykYdSPme1XE9PGjsezBj
	0Qg8wXOUtzkiv4gMLoFcWoxYueey0lPhex4qLsxEzypSFE5eSJDNa+ANrU75m0Ytfcz8QO
	Nu7kRWhK9F10NoAfH2cVxmEQUdJfg/vYFRh8holK1ZYCFpQ5qQYMZS2lLAJQgQ==
ARC-Authentication-Results: i=1;
	rspamd-64567b6586-ljwq7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Wiry: 0facfc34247bd33c_1754663917774_3566483743
X-MC-Loop-Signature: 1754663917774:4240174711
X-MC-Ingress-Time: 1754663917774
Received: from pdx1-sub0-mail-a287.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.43.79 (trex/7.1.3);
	Fri, 08 Aug 2025 14:38:37 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a287.dreamhost.com (Postfix) with ESMTPSA id 4bz68r5kNFz9g;
	Fri,  8 Aug 2025 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1754663917;
	bh=D1TZb3mxnOhzg2Vdcog/qlZmoNoGc345fnptq8iGJ98=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=LUGdjVjizdycZ9ufsLErUENC8J5JKfno80ba2VkEv6FonVIrIUMQUH0ZWMbqVNJT/
	 FONZmqn9ezSC5jqfOxTbj87DJ1iN+Hy6JHBX8+j31Kt9+7VBU3S89jarJXCmiy7r63
	 liu0qcqQunCYH5sBJR+BJLoo5C87IByykileUb8i/xRUQliUgXsxMAJgoL+oQ1/Nml
	 kMrpmscYyoFZCIZmTeWbYKUt6QMKI14QoL/I2oNPxK+YLRTzwNnpBrqdnVldZ54pIB
	 5n41TU0EMjJaHppTNd6ML0lupy/RV8dc8HIAPt1T7i2HU77szYJmvpYdnR321yhUi+
	 RzXMttc6BtZJg==
Message-ID: <7cf546fa-d98f-4c9f-92ae-0bd26b9d1178@landley.net>
Date: Fri, 8 Aug 2025 09:38:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Dave Young <dyoung@redhat.com>, Lichen Liu <lichliu@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, weilongchen@huawei.com
References: <20250808015134.2875430-2-lichliu@redhat.com>
 <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_073840_968388_D08ED7B9 
X-CRM114-Status: UNSURE (   4.05  )
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

On 8/7/25 21:30, Dave Young wrote:
> I do see there are a few similar usages in init/do_mounts.c, probably
> it is old stuff and it just works.  But I think making rootfs_flags as
> an array and copying str into it is the right way.

The lifespan of the string ends before PID 1 gets launched. The copy 
would be unnecessary and either perform an allocation or impose a 
gratuitous length limit.

Rob


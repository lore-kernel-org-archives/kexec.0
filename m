Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1256CC43458
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 23:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WbeC0G2r0+fJphZIiEMA3U3mQUgbuZ2yGF2MPyVi8cI=; b=yC/nICalzLdhAPxZ3TXXOgKEfK
	zioLI04ALcieIQQsZLxWhREuJR1ksDDhGqc7vLCONEgXu8uqtDY2DvwY4s8KDKnDmeRPU9ACkCqVe
	aL42aCRnYjM9CqYivk3nLlZgThmTIZox7nVZbQvCcmkxEOWAP1+B/T34PzuIlS12g00KdIYzrMckt
	kwkyHxawRmFv9V1mUx+giWtfwdro+7Q3zfCwoL9RYNkr8dSVOMqe2Y3NzuXi/FGJHaUK7wATXwlNi
	dc5//Y/aW1j7FoXxiKGhJa5oEv+A1wqx1wQTm8ZlYA1/dBrlQLz3DQSSJpxJrwd0Neon5oi3LGSmw
	arqxpVNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjQED-0000000AZEC-0omx;
	Mon, 13 Jul 2026 23:38:25 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjQEA-0000000AZDj-28E0
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 23:38:23 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8485b358552so4072180b3a.2
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 16:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783985900; cv=none;
        d=google.com; s=arc-20260327;
        b=F9ude1kXPO8ZZDdQ6FSdiErv81w9zWIHH/NKZsWndhDHkhuu6BnNYtgl1pibxwG+dy
         9DKgQKMVy1+j6y1odAcMKN2OBi+zqwltmcqE4WW0JZC1ZrXdKlYQpHFMvv+V5axGJc6l
         E3645XJfeuQDBRrm63pRRsHUuTRrPqlwV91R+Js402oGkeLaxUblIT7OV3uPFWV3RmFg
         QoWD/REtZwOOGpehhLm6wEuS59mevHADbHcKqI5s30ke3a2ziuYmPZmtsTaRJcIRzRLz
         sadFE+N94NZz27bepmaPCa2X5wvmt4bWHrjHMSJZThobv5UYa+c89TgLrxYyazGGDWEb
         bu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WbeC0G2r0+fJphZIiEMA3U3mQUgbuZ2yGF2MPyVi8cI=;
        fh=6J7ZtZj7lzJauCAZgqof8jR5v3uZMKZpBcI2MlFy+ec=;
        b=AjHBVoy2nucf9/4QwDEM3OnVHwxgYmywZ0K4In0xJ1Gev/96rbqQNJMHQJgeRGgRab
         R6KMl1TYKu6Cv1zGk3ak5nzgiPo9yQkkF05L1nY+DdFn4xAtzJ3q86doChefifBg8D+f
         mY1+BbAO9RwyEI5znF1t+Nb+ojhWllgTuNhru94qe6IFog9K/qrr/gBj0AJtt7cjeKv5
         tlm60WhBYtC3WO8ExiFz9HYc4Ptj5lfk78OH7vqwJobuhyPbecoXfYGwLYg0LVQgdwWY
         uuVj2TxfITY9ydqBVpuoiGgSJVxZavIqtiWCVlYoc97u6SyqFJdDGx4kYrNEusAVRyqK
         zzpQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783985900; x=1784590700; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbeC0G2r0+fJphZIiEMA3U3mQUgbuZ2yGF2MPyVi8cI=;
        b=G1fY8x7LXzNvG6VrFSsVVem20GKLkIrengr589zJuSJu/lWO6kYbrNAAkKOsweKGPi
         S/vxnXHdukOLr3Rm8qU1tPB0ZAQtdzBejNJOhV4GcZGVZXF1bwmUzKwgV1H5ZopFAVWT
         qEPK6Lq1FiBzeLf6J3N6+qLTsdbP64zgeGYZLves0a7qgpw5JuzeMbJ920syGj9Pw+7Q
         rpcrIfePvvg5bmgamD7yYYvG6pl5M4Wd0jx0mXtjRsS3lz0zV2cor+COw4fp/+BE2s4C
         kk6ItL6k3LuTCih1Kk9L4EkQJHA1TSGzfHJ2payGNVCgA0F5HDE9CuUZ4ipANxxXaMYR
         wR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783985900; x=1784590700;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbeC0G2r0+fJphZIiEMA3U3mQUgbuZ2yGF2MPyVi8cI=;
        b=oC0qWY/EYjxslWsk2UJVCdRP5CkeIOuLzkc2uFLfK6PjMLr+dipAcGstVEkESZ1fnR
         HzdgxDkUfcJjSFiK/U3d+yl94aWEuArRhZc0NC0Iy8TjCts8MwtR7bkR5Sm7uVDA7ddq
         MPchxc8eLyLBXv6ea6tVScfzyTqwmjvrvC2jAZw9F7Q71g4riBRUvE2fk7hdZ4jRd8hZ
         Cpz5E8hZTkbVSCE3jHs+35G7MXbwfbZUHz/JgFfomFrwyzchbDEpgKaa81/to7erOMg9
         mW4lLR3enoTN/CeY/smzhHkQXRRktRcMIiE3ECt6TGCIV2Ejzk9XhP1N0H5SHw++zSlx
         IwOw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6YXakgSzc2+BsnPXo9blIiiGjqKiXNLfBKXm3UL2ZftUYa6iaC9EJc9CCW/6P98usyy8dPA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwnjI7WsxFMI9I02n5/W/4MjkthbdK2R/CoQzwh1fJjlW8VQBi7
	yOksA0gviYAsBYAkpn46XyHC7OjxpnE2BHGE5y8Lap6qgf0eeodd8vvy3lzoUlQ8dR0swqgxwvw
	pa+/vq85kf/Y8LOquFTpYQ4Jqmkl/cRTxyjoC1pH/parJwxkBJrV1VkZBckQ=
X-Gm-Gg: AfdE7cmftSEs2y4Ff1Et41MfVGbfH/SAgsJUsmaET27kEo2KJO9VIWKBDJPP7/NO4dS
	CcDZa9U9SYAA6oi7bYHbrXuYUzqjttc6U1hq6FJBZ2AQ37yZh1kDsPzKjAWrYaQEAHLlXRDtnxk
	a/F6kU+7NUaVolrZoJQOQH3UJUV1bphFHzPLclAilmgu1yTQi3w6lefbTsG97PIkeYR9QBmV2wr
	g7Wuk7aiiFE95hELaRD73IiWLoYmjyJ4vvrbBnsG4FujzqeWyJMkCe9RxVuGAuQyXYc+XrJs4hr
	d9mGrSA=
X-Received: by 2002:a05:6a21:460e:b0:3bf:bdb9:f602 with SMTP id
 adf61e73a8af0-3c1108b79bcmr11388010637.22.1783985899795; Mon, 13 Jul 2026
 16:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260702174033.32116-1-sakacpav@amazon.de>
In-Reply-To: <20260702174033.32116-1-sakacpav@amazon.de>
From: David Matlack <dmatlack@google.com>
Date: Mon, 13 Jul 2026 16:37:53 -0700
X-Gm-Features: AVVi8CfY9nmLyptjh2AyzFeGNNgc7oKcQvO8AS5RIIVcrg8HsCOADDuDwJVvlPw
Message-ID: <CALzav=fJrcaOFbP-rpOPeRNW59e0mXCgX120xHPnyrpvNH2JgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] driver core: defer per-VF sysfs creation for
 fast SR-IOV bring-up
To: Pavol Sakac <sakacpav@amazon.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, David Woodhouse <dwmw@amazon.co.uk>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Alexander Graf <graf@amazon.com>, linux-mm@kvack.org, kexec@lists.infradead.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_163822_554718_701440B8 
X-CRM114-Status: GOOD (  16.63  )
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

On Thu, Jul 2, 2026 at 10:40=E2=80=AFAM Pavol Sakac <sakacpav@amazon.de> wr=
ote:
>
> Virtualization hardware keeps increasing in CPU-core and VF density.
> Kernel is trending towards preserving VFs using LUO across a kexec
> which will put SR-IOV in live-update hotpath. VFs must be re-added to
> the sysfs tree, along with its supporting devices (e.g. vfio,
> iommu_groups). On production hardware a single VF can consume ~80 kernfs
> nodes. With thousands of VFs on modern hardware, hundreds of thousands
> of kernfs nodes need to be created, which can add 100ms+ to the boot
> time and to guest downtime.
>
> Proposed here is a PoC of deferred materialization of sysfs files until
> first access to avoid cost of kernfs node creation in hot path. In the
> reproducer below using a synthetic VF to isolate the sysfs overhead,
> the per-device sysfs-creation time is reduced by ~74%. It exploits the
> expected access pattern of hypervisors, where only a subset of device
> files need to be accessed to attach a VF to a VM on the hot path.

> Feedback appreciated for:
> - table-driven attribute refactor targeting common device add path /
>   suggestions for more efficient/less invasive approach
> - mechanism of interception in kernfs, materialization, locking scheme
> - fit into context of LUO - complementary or is there some other
>   mechanism already considered to mitigate the sysfs impact

Preserving VFs is still on the roadmap [1], but I think this would fit
in nicely.

My plan is to have the kernel keep SR-IOV enabled on the PF throughout
the Live Update and remember which VFs were preserved. The next kernel
would still need to create all the pci_dev structs for the VFs, sysfs
files associated with them, etc.. So speeding up the creation of sysfs
files for those VFs would be benificial to reducing the Live Update
blackout.

I have some questions similar to Greg's, but I will follow up on the
thread he started to discuss.

[1] https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@goo=
gle.com/


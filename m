Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86465FDEE52
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=; b=JYG0lz8nS+94i4Aa0IrmRVetkb
	gwGhBpH6wNhnwb3je13zve/3bz6KbsYuFma1LqO8G+yat00LGWI9Cu37JMOZ/4SKKQBaqoaOueOLZ
	rUb/lcNUDtswbJkpJRwL1EKZRs7W4SwTJCIyFTL6hHMhAsWdRWESTMKlDNKumPWCsxE+HhNfNs3L8
	oatUZms4qN07XJOTQ+eCa0mfQjuH3VLFoidhjhZIrYh4LmSQBhEyJMUXv0bMq/C6lcFOdaJH/eBuy
	J3utUA7GPfUcRhfxkuDAn1pGmq6nGO+F7W2e/Gs4fAwEJ9fjWMVPGIpCiTQ86oqudMFVUOEQ+w0jo
	RnU5s+lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG2Ge-0000000CMu6-1tlQ;
	Thu, 23 Apr 2026 22:11:28 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG2Gc-0000000CMtW-0C2G
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 22:11:27 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-38e97e73234so60285931fa.1
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 15:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776982284; cv=none;
        d=google.com; s=arc-20240605;
        b=jwLX9ctrbRGYCgDOzc2q8YyB6kTfzifDrwsU34vlnJwsMeGbkjdnNvMUvWkLRGuQj1
         I2g6rZKyv43Nq4XqzinfirJEf8tYY29xXpiKrQ2e3xWNvV6l+q+Z+6DzBOxLJ0hPVyFe
         O6AkXFu74Z2oDlvIM22giNqYxRcv6QyQn3buInmZqa2k3Nlb8SzY/dfIx7SGOgLKi73p
         3sIwwqLjNA7N35sXusXj+iV8MUT8nOk6GPtA6SjzeqY1bT2P2Ld8DLShS3fOo+RiSJpU
         +3Q2Pq4FNC25D51OcYqWsTeGvhbMd2n6ZG16erfFPC/NCUxhKGR6+JDlp0ZthHBCaOmk
         U6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        fh=SejxjZq6TkEl3mRmTRuOANApUX+oD67U0JJrYgfJha4=;
        b=lGOrt0wwAhM5yc5cnfoXPEZ0N/5CJFzwEp4ULEt4FCa3vjISnlRZDyiNEYEb6Zmfte
         OyHXUqZOdp2YyQ4Ts8O2LcbyTUxA7CbWexv6xGfKWt6RblDipQEug8x/2jrtU7Qy0w4E
         G3ZkWafS0Eq2MMMh1PIjbrHjl/jfzRE8KHe7efvhMMrIl0E3qxJvSPvfDuyEVOL4J88y
         KVYOfSSQhznjXkrDE0JKeZ6ddCFnXAXUbSMmugAKETqzJ2qkkMbVy8EkbTz6ZMMyxprZ
         qmYVQBl0LR8IeBRDICu0EvroaGqEpoCf3ZjhM+fPt2cKHnxvtmEIAm7L3UNCUcVrQrmt
         E4Kw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776982284; x=1777587084; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        b=JjHF0U5j+G5lPpX7Fc09lg+sVbLT6adCMdNIENaUB/kM7V3WOxlGiIqu0a0zQ8GSrL
         iNKqh2gLIeePpcLjcDsg9u0rilcJONnJDaAle0xmf5PpFf7fzE4IuO05YQS3F9pVwMIg
         jYuveYL8PsQ6qTD5pnRFtfEaj2jq2fFz6sfc3vF5jHKVieGRcAuybA7xzmMh9vSW2NDN
         56antoYLWylw1KwHBhG33+OtXbU8gIV7rPMQrSN8sfOYD9MFHvQHtojQ82Bwt2jaFY0X
         zgey5Xpe4gE4h7JU/O/B9qicW7mbSf5Q/ANNU1xqgQS0EfYWeZ4HNMacbcGIj8h23WsH
         VEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776982284; x=1777587084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        b=T1irbG9h21vawe3kUjGkm6P6SAtBO70e4vHB72ltplFpGfAIW8Fd0dwhWHnsYOXJLH
         tRVVGQdjhVv16brVG6cXdLVCy/iJ4MfImNHlfwk3EAi+ute663ca1x3G+QRZvP7zOIek
         7UFPVseugLvTCKNjALnizhOFwCaDUQhVPfP/brjWKMG252J/N6UBhiu40a2MdFTvG4yO
         1KDQVQBLEWaeGk6j4UFTAv4E0o81uKnatI+5Oyifgsg1cfyCfd9ZN+FGFN6vBkPZT7hP
         V1nfJb9G9VhbQ0lDO0gVqsHMYEocVsTNe9+gIwrcM5GvTTw7kA+8pN8XACZYlWgzxH1j
         9FIg==
X-Forwarded-Encrypted: i=1; AFNElJ9Zx0vHLW8ceTgqzsfM0ZARAPPVV30oGosrpVamhkXLL2PZZS8QoZtKLFav0Arn0ch4aAeCXg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9hJWPFxRpYpf3hc4e4yTBDYlPAgTDHsSvr6Iuxgj4xZpc+iic
	T40YHh/YVDp8ysUAc5RI90CSmrhoUN6rqPMSJIHvswZEVh1rw9JD5uJYyiPV6zQbYbCLmGrsOYS
	/t869YrmUpg5k6ST5Muytj8PxStwQqGLztO3FsDkE
X-Gm-Gg: AeBDietyGNd+uzP3GCoJGcxkM1b95CxKXEivQeEyZG9dMVsVCK0nN/KVIUAhlzrn5le
	3llvUQ4Co/nOTF1qrWWYgr04znCYL4LAXyF5g/LTdQnNHDP7rWw2ae4ptxeIIdgjri3RdHSjJpT
	vNERhWgpCgFdUwFk+dW1ZEQ6y590KGe0h26WYdDfvtnWeYXSfO2jksvwjBrlGlktK8F1nF0lXX/
	fjnVNZlIcj+W4OSjZ1pQ03qTtLX7SxQ2unjf/8sst2EIx46EWNBzzc9ZpBFWyPKeZCtOrGCIDbO
	biK6wgK0H97cflDUfB66q4Iv/pzFlg==
X-Received: by 2002:a2e:bc83:0:b0:38c:6b7:ad39 with SMTP id
 38308e7fff4ca-38ec7818193mr99821181fa.13.1776982283419; Thu, 23 Apr 2026
 15:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-9-dmatlack@google.com>
In-Reply-To: <20260423212316.3431746-9-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 23 Apr 2026 15:10:55 -0700
X-Gm-Features: AQROBzCzQHNRAyujF9tGZltx4kVtGjkMoj2uVw4QUXf8lLhcB6v0kyr5BiRYiDc
Message-ID: <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_151126_158155_5BA0A30E 
X-CRM114-Status: GOOD (  16.67  )
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

On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> Restrict support for preserving PCI devices across Live Update to
> devices in immutable singleton IOMMU groups. A device's group is
> considered immutable if all bridges upstream from the device up to the
> root port have the required ACS features enabled.
>
> Since ACS flags are inherited across a Live Update for preserved devices
> and all the way up to the root port, the preserved device should be in a
> singleton IOMMU group after kexec in the new kernel.
>
> This change should still permit all the current use-cases for PCI device
> preservation across Live Update, since it is intended to be used in
> Cloud enviroments which should have the required ACS features enabled
> for virtualization purposes.
>
> If a device is part of a multi-device IOMMU group, preserving it will
> now fail with an error. This restriction may be lifted in the future if
> support for preserving multi-device groups is desired.
>
> Signed-off-by: David Matlack <dmatlack@google.com>

Jason, do you think requiring singleton iommu groups is still
necessary/useful now that this series preserves ACS flags on preserved
devices and upstream bridges?


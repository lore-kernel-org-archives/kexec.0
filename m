Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D02FF8870
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 21:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=; b=XEF56V0EvNulwmksHpPvPUONrl
	+8eOt91p8cUuUX1nCK9Wjg/UrQI0m+0ryX8rkwNklEYQ7ETuByIxU+z0aC54zAaDfx2FFO6OuASJ0
	+MjC9MGI5RRdhIrkswbfbmBac+mKNiDbIdz3o6qe++N30CPWy4CKgDpoy3gCEsLCP+0Wg3PCWO6B/
	oWFsm2taEt6Q9U81mXhM4p+ILctkR3OIre2OhYtctxqJdbZOlB/v4YVKdL/BFkiSk+/phkFhZI478
	rl9SNNzzBeFZthapDWjeQsdqgqpZti5IDzi1m+7eejiQQHZ3dDszfR1++442T17RBho8MYUdZiWq4
	FjwuTYfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTYP-00000000BGa-0Cyc;
	Mon, 27 Apr 2026 21:31:45 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTYN-00000000BGG-0iU0
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 21:31:44 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-38df1889fb9so103512701fa.1
        for <kexec@lists.infradead.org>; Mon, 27 Apr 2026 14:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777325501; cv=none;
        d=google.com; s=arc-20240605;
        b=Bjvy5WaZuXsr5iVXcYf6D/tu9C/+/uUYvIubnOQWOK2V0Dc1b0JhUgv8xZil8rMI6Z
         PN8sGfehlA50Lu2NUsFIUYBVbpGim3gLeLBsjuPC9Veh/XuIdSfjZzlbDbzK9jHfuuni
         PLKiXr3G2Yz9+yEXdumzWuL7BWtEmaD54ySF9Gpjv1Nf9ScjrtUbgeO2hIVWUYPN8IUw
         iL0/rEovsI2vH4yyuVFYzrHNfXTSdO7TBs3igTHVjT5DCyq1BOEwrGI50iW3y59GY44a
         +Qdjpdsa7hQuTZ6EYia1aLBN+Duf4qyjZ+WTxPVyOZzH1JbvlLhQKVftLR8Wy8Xo2bKG
         MrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        fh=peNRUivF4cJ5Q92bchu+FX+fuxBbMZqQ66ulssuEHGs=;
        b=Cv6aYcMF4ea+PQ5t27l3cfRIViyjX38p1mEEhXW+24mmAh1tfnx5Pb9L4WX5ycPdQZ
         WYX88hNoC9yJNq/rlT3BL1VSQADhK9c5fWcTmshSnB8GQoM00mP9bUEUKA7m3Z8xTRsO
         fJ84BUg8fjoFUe/pqaCTpETHgU2eZVRHG2Xf0j27T9Tji7K62yMASHOzga5fPvQKIW82
         ATTDJTw4kmrHOF8za8vUG2zdxYPGUWB4gZ2S9jVNplxoCo3pmUh2fs+A8d7VltqlS+dN
         1V/cjRLvlkEKHZGcbNLF4zwuZLDxCCOHxnLkzqvI+WIREhWAQ4gJbXowij7ZvYoDAM3e
         UUAg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777325501; x=1777930301; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        b=Tf3P+Bci6Uz1Nm4+j4imgZY/2DzFCsQ1/mNzmJOU1EYyVlZrH4WsPGy8mTbKfzd1fK
         AiECLafixEBtYWH+ex5wF9yG6aGGpYse6xavAp7nFf+wI7iNPON4+23U6skuJvLuvM5c
         6wiUXn+nfEcP+SeZXcxKL7d2/FjDn7skDfb5l0lkag0AiDPJr1A2XBSeStVYPYjy6cwl
         +s7nxACPxp8I41L3p0A+2ujTg0H+zGx9waVyIkX25VQRZVrvj7upQDY7nkWKTl69vG+h
         Y+NtdYIytCNvctcOa91aKZtZO46W2uJe0jmUrq0G6cHVHpl8DDxkkrvfs6EshaVvpEcJ
         aRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325501; x=1777930301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        b=QKs5oyktJapRml0i+25bX8dIHaB1x9L8KVwDLjNykjhN53VgP8bxW+Md13nBMuyPAH
         Ko1nyOY+nkxPkY2XrjBtn6PRGr+hxczOWkRbDCNjoW0CQCHSvJerzNumblqhdjXdOHqM
         QA/6JJxWpqA1pWzaTSgH2T7VLbNuKkdZSQXKav3Fqwp0nYRpjk7Q2rXyxK3/d29BWfG/
         KP4EI7U1WEVqhfFWkfRtFsXb2+a+Pu0nqN4AsdNyoPS0kRRNhXUXhCVWoaCofJopHrtG
         Tv6h5b4I674Y+rLK0Fzvt5yxtm7/H7kHIzB+7urLYbr6kixVPbA1gXhYR3F9RVGt6TuW
         73sA==
X-Forwarded-Encrypted: i=1; AFNElJ9EKLShTKoMuZsba4u810AXbtjoCAshB5o3dtkBui9QPoju5YpUy8Ksj6t4OxlOAHbYb3Lifw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWk55r0kLJABt7bW+MoG8vjvQm+RuAJXLfiWb9m7gELdVDFlFW
	gml6hpcTTZ+759z+lsfrjOAaxlkYAEQZ+wVD5jMh7ky8KGmLRFd5VLGa7HilsNsxQ5bWNM0DnNc
	efYMHSOqEj3HHYQUYTj53arCyUnItMRRX0OZFIm9n
X-Gm-Gg: AeBDiet7RzdbMLdHLPnMr5g0nasgSJRQU3cCVCTPxTlXV8PmGox9Amt0YA2tM1r3aL5
	Tlfa+NfZZrOFFHYToj2rYXxNDK/edi9WdGYxbltcKVF8w0Q5VmjXiUkSkzet0aDdtcM2ILRtdN8
	ggU4bi16YLYv2MhIoUdikKmCYROEtf0UOSgoqNhJBRbVBvi6+gtwZNm8WcULMDRj/C4tvDUive4
	VdIdzIUGFGfs8O9oVSbyboa0heGRHxpCYGat+Z6ZHURhTUnxpz9f+WsDiE7wa6RgYdPmANwBhnj
	wEwpX+iDRifpvvOC2NjRjs6qzDW5rA==
X-Received: by 2002:a05:6512:3c8f:b0:5a4:505:f62f with SMTP id
 2adb3069b0e04-5a746411871mr173644e87.6.1777325500555; Mon, 27 Apr 2026
 14:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-2-dmatlack@google.com> <20260427210529.GA186381@bhelgaas>
In-Reply-To: <20260427210529.GA186381@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Apr 2026 14:31:11 -0700
X-Gm-Features: AVHnY4K95rEzKgWcXKT0jFnCdsBpr0VFFFUI48Oher6g49BqIzQIKoHjNP8bc8M
Message-ID: <CALzav=c=99653vuRa0S6cyAuTfP-PWFpOdopYArihOBLor6eQA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_143143_247389_CC5EFE96 
X-CRM114-Status: UNSURE (   9.66  )
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

On Mon, Apr 27, 2026 at 2:05=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:

> > +++ b/MAINTAINERS
> > @@ -20555,6 +20555,18 @@ L:   linux-pci@vger.kernel.org
> >  S:   Supported
> >  F:   Documentation/PCI/pci-error-recovery.rst
> >
> > +PCI LIVE UPDATE
> > +M:   Bjorn Helgaas <bhelgaas@google.com>
>
> I don't think I want to be the primary contact here.  I'll see patches
> regardless since they're on linux-pci.

Ack, I will drop this line from v5.


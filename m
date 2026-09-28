Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E910CA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGfj2Y/eKe1ZG7o5pFOTvuJbhKG8WlfCFzo9fqTzU3o=; b=f2rNhYN3PdAbgfv0KAvxXhToGL
	G/x9XheW8eiBaz+/1jQpjtWSrBnaj33yPDZGkVLys/GaErHCrNFMsc9OKNBgMYZE5Jt+NhojvgXwv
	KwBBDNQxlPYUjZijW1DaF+x/Gr47K7dSQPt412WT6q64WLewI07qtxXR5BQpnVDgnyiOpUUpN5HgP
	TbT4lu/cTOIJ6MeMOeTFfE3w3E8oGVBde4im5oxKxhwbi3wZaaalGZQX7U129S6lR9rMxQlqBLu5r
	/lK2vXRmSNmtxLPWJZDbTdM82Y9578uuK19H6dX6sCIVpGZXHPcZWaQbUQXT4R6bvzczFuw5RZK3N
	e5MlPqhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF0e-000000018JQ-0yVL;
	Mon, 28 Sep 2026 17:19:24 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF0P-0000000188m-3Nny
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:19:11 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2d8facae850so3235ad.0
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790615949; x=1791220749; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qGfj2Y/eKe1ZG7o5pFOTvuJbhKG8WlfCFzo9fqTzU3o=;
        b=l9cwWnYzEd6YYeo3wyfTcpuM1n9X8oN+XDcVpXvY8XAXsKs4OTMuqUTSQ2FDO9irTE
         GhXQQgPU1dEUNkVnqPEIg2MkOe2s4V+im0Txh+JEbH6icQUuKz/jDpXLO1msjswmshs+
         sD8mtaQ6E+sQ0l+OvPueSqUgVdMTmfD+7AoUEz9vJUcvtY11qHu8py98RSVr+FznzslQ
         oa6fOSzg1s8YDd5YEouH9GgTnthRajarG82Kdqr0mveBmFbL6mQADCKv1rlrFfVzVX4+
         lC/mVaUfxxd+jmv62kIx3IQiTMk+EUlD1C15U1oi02z/hh3vwg4mV1aK9foL3t3FZtYN
         oafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615949; x=1791220749;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGfj2Y/eKe1ZG7o5pFOTvuJbhKG8WlfCFzo9fqTzU3o=;
        b=oOd8zoaPhwRcx1er4SrVdVPcX7hLGfJRZ1L/G56p3R1kPrdRBUh4QrG7sWW2fZzZn/
         xxcp1VHHpJ3DK1vpM6OXzq65je1UAfc3p5fEBDIg401p2ltrmw0+zlcJXy2tGjP0b4T4
         GQ0D2SzQlyV1rm3YFEYLJAntLkbsc0SsZpj4nq4YnwzvrUYCshVXMmuxPvpXyuuuKJ9b
         84E3AVmuHf1lG0k+ubZE9VIgGdBZK4A6qtdx3gQQLSpDd50Ed15XhzYsFzdxozOMBW72
         BD5VAte9fF+soDMGDFU461UbIXQsDUU2tXhDa4qwqY4GqfvZo8DSrgPh0YyTVJWeReas
         HK3Q==
X-Gm-Message-State: AFq9FYLqn9A8yM/F4VSFQvoExhXwtzZVdXge68T3vYPqSvgC7Ksw+ArE
	MA+S4fT+SXaQ5SWftqjcbyXjMK2RwAgodM4zZRzclIB57NFxjXeHFzBztOWfhrbwZg==
X-Gm-Gg: AYBFou2uTuhPNpRTsypmpegRgStmPFqouGObgDr8iJZFXR2Y++0XJ/vix4kTtVhfJFS
	5hPYwQpOy4QDvMie7d9JcljT8S0i5vklCS0iVDMbc2pts5yIMo3HK48tPvvSxSv3ZeWeLJaMDjO
	wmuekHS9+PpUYtSZh3dsnRMcWNmpeD4EeezWg2lkn8DTOJwQpB4KvtwceJP72/pXLKktZHqUBTd
	Jx7YmE2WiXEcoX1HpU3ue0j0x35BaPKOzada74a3M6uL2Z2OgElHsy1jEY31IBnad4bYfu69sdd
	Qc/FCeSuSB6UPlYbtPtUbCgD+h0A/CKTaEF60x0589upFGxvTCsjGMZfdtP6DZtzH23aFUxdnpW
	k0lBmI6w6c2kHLShhJ/F13PdO+TPqGCbW1gAQwFmOuexcbQsd6rJ+xjLwyFuLK3fK27fY4LBgK5
	Z6B/ihcEWpctX4KxVuNJAUG1b00JF0MweEOuMyZEjtl9Wgn6MhIGOhzmpwayyEb7IkcvvM2tfG9
	VHFiZWktY+WFyFHnjKtG7L4ijGso9LqYzWn
X-Received: by 2002:a17:902:f70b:b0:2df:8e89:3bff with SMTP id d9443c01a7336-2dfa9795c44mr8307715ad.17.1790615948122;
        Mon, 28 Sep 2026 10:19:08 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7a4b03082sm2784007a12.11.2026.09.28.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:19:07 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:18:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
Message-ID: <arqhghssNc4fIu_9@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-9-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-9-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_101910_028972_E58525A7 
X-CRM114-Status: GOOD (  15.23  )
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

On Fri, Sep 18, 2026 at 08:06:34PM +0000, David Matlack wrote:
> Save the ACS Control register in pci_save_state() and write it back
> in pci_restore_state(), instead of recomputing the ACS controls from
> scratch with pci_enable_acs().
> 
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
> 
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS Control register there as
> well, otherwise a subsequent reset would revert ACS back to the
> configuration left behind by firmware.
> 
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so keep
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan



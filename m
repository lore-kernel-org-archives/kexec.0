Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37053606A326
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H7YOGTij;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J9UW1AUO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UAmEuVaLj2um1QYSHCqaR42KS0RtEEeYHE8D0ahDr3M=; b=H7YOGTijhEp1Bu6V9w5vnPQaaX
	i6GWWsuxxcK3dpnWdFyXAKJWrFXh6NIzPshJlowF9bYl0D1vqkhBAKE2FwbjwYgpEhFs+j2+IcFpE
	WYD0FClZ4aT/rrvklI2Sqb6G4hd7sgF4BidRW0MuC2PVxsToB8MCUApg1WCuw2h/y4+4HVdVyOHFj
	i8UY9OWOiQMP9raZSevn1jMbazR5YR7GCuEhtqv5mfKL6XHc1lyYpnxjmMwrbqO9X9jVxIEH7wAmw
	xkBffvJWeryzv7KuAVYE00R40Izd+LaAew9x/XB6TzA9HQLbhPmwRo8mWZQO0z0RYq8Vc3s8ozKYI
	K+771BiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPrA-0000000FIej-3atC;
	Fri, 20 Nov 2026 14:44:52 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPr7-0000000FIdr-2sgK
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 14:44:51 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-55be673e029so240681cf.1
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795185887; x=1795790687; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UAmEuVaLj2um1QYSHCqaR42KS0RtEEeYHE8D0ahDr3M=;
        b=J9UW1AUOd2P1uJDR6NpXIw3hxoqrSaQsmrEGFYypJ4vpKcCVA5duxjwaAOL0tevPq8
         gBssa5e60rD8wRS7yYo8yHTPNbED15pShSNoDSjhK11y8Tx3Mslg9AVfqrxPNQ91qJ9U
         bMYBYCSLNEmMiLlst1EgxbMmQYO98rkEHO+fZm3f8PQJMsO2ucPlGETO8lnOMmO01vZt
         S9kp/i0MWoCO9oyHlxEsZqcai9xuf066rOGYapQAILtGLoSb+OSt34mixbCJxcaFqS5I
         bGVUwIecY/wbfibd6hoRAiOV0E4CcRt2Z4Yd8whsLeDm6+ml6d4+SWgFQKziUiZFGynO
         akwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185887; x=1795790687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAmEuVaLj2um1QYSHCqaR42KS0RtEEeYHE8D0ahDr3M=;
        b=AtKUKFbWWtZ06wJEOrVZfPrZv71QCHQ/0F84RK3O+OURE/X6c/3Dh1C3r+xKd3KCmf
         WqgRZNbnwTS2TLxkYSpOhcNJHg1Xipy2iVtr3qD3ollAYQQAM2am6D/SOsSkYK1mAnwp
         oQdJhD09/VZAFryFvKSNOmO6mfbTAlqtPA1SSCaz+1nphsUVutXA263MO9+U5kSVij9J
         bhgOMQamtqhgxjE/prbe5X9S0hLzynKRWSBHdl/h1klh95sk6qEMWx06bBpWIWda/XF9
         +A+VFzUBuyQ43iBiv5lEhgenfY9vNZHBkgk6rfpAss6VZjRuN/UTB+sFbNQneGzWY6K3
         /pfA==
X-Gm-Message-State: APuU4Z+DxW+/j/ANLC4YOKUQOh6FMkFWrEgnG6XY3xxXiBnlrKfyDlSn
	zd8x7CRzY33gSKA014QDYJuK9vjdsWZkOXErGW4HGbWXpkvyIMNh1GxC/IxU7P/Leg==
X-Gm-Gg: AYBFou2xKfoGdX/7JKF4uf8yoMRCOeAvm58kTPYQiiUJm1+emzAqrkYkL+qwTzjuNKz
	/boBeXPtRb013rfXKW7Q1LI76K9C3f50fMq0/qABmJGZkGPhB3F0vaH1r8qHpzlPPdjQC4Iphjc
	fUUT8iMVd40AidsSa4FscsHQpeMvtaDDFo+DtQV2289qK6QfkBV/jf/oGJQGvdNOpiYNuaF+IKt
	6IxhShsk3tm4HfR+WGdEsj0Q1uP2o9Y2ZQ6a0HXwQcPr8yRmHgNp75cHGLGQofmy1fjtUOHwd+z
	J0N1lXl5/Vx5PGHW/LTVgHAzDauxRGqc3QJkEw4VdP2EuYMi4JOUYe/5qVJ2gXiHR8d+ofzTJrK
	NqUGWMlaAA68FhVTpLAYHmWxfTdD4WRXMhzmtWgV0vJzbsW3F/rzMXW5ULrz0kAntcZYcd81rAv
	LdqRKz2zwsBfaNd5QKhGX9scw5T+qNTWvbBewwrG7tbHGL6v29Z5PF2pDxgXDAXss59jCHvamdR
	cRJZjpbxLlw5bvlhaMZWtJ5od1MfCYouxWz/w5X3OcrEj+zgVLpRflz23/1vlUbWG5HYhATtu7x
	gMCGiXJ8IER/KGhhbT+tPyXY3IZIYZy5+rI4f0wQk5Yd/AHzCeyJozuo5iddB8W4vLUhKFvUtAR
	f++QmjLBGH6f3
X-Received: by 2002:a05:622a:2b07:b0:536:6ea4:e6a0 with SMTP id d75a77b69052e-55d7a35af5emr17844321cf.11.1795185886849;
        Fri, 20 Nov 2026 06:44:46 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028c80dsm14013017b3.13.2026.11.20.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:44:46 -0800 (PST)
Date: Fri, 20 Nov 2026 14:44:34 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>,
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
Subject: Re: [PATCH v11 08/13] PCI: Save and restore the ACS Control register
 and Egress Control Vector
Message-ID: <awBc0m4oW9nW4hgX@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-9-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118223704.3286085-9-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_064449_737515_6A0FCBA1 
X-CRM114-Status: GOOD (  21.65  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:36:59PM +0000, David Matlack wrote:
> Save the ACS Control register and the ACS Egress Control Vector in
> pci_save_state() and write them back in pci_restore_state(), instead of
> recomputing the ACS controls from scratch with pci_enable_acs().
> 
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
> 
> This also lets a later patch adopt the ACS controls established by a
> previous kernel across a Live Update rather than assigning new ones
> through pci_enable_acs().
> 
> Save and restore the Egress Control Vector as well to keep it in sync
> with the Egress Control Enable bit in the ACS Control register, which is
> now restored from saved state. The kernel never enables Egress Controls
> or programs the vector, but the firmware could have and they need to be
> kept in sync to avoid changing how P2P traffic is routed.
> 
> The Egress Control Vector Size is a HwInit field of the ACS Capability
> register (PCIe r7.1, sec 7.7.12.2), so read it directly from the device
> to size the save buffer in pci_allocate_cap_save_buffers(), similar to
> how the VC capability relies on its HwInit fields.
> 
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS state there as well, otherwise
> a subsequent reset would revert ACS back to the configuration left
> behind by firmware.
> 
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so don't
> allocate an ACS save buffer for them. Keep configuring ACS from scratch
> on restore for any device that has no saved ACS state.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan


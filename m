Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9F1CD98D2
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bi42mNvv8zEfpJesfq39j8DzoTdUbmNl2yt46Rb57o=; b=eDrE6rwll5vU8VHxgqgU3gTjKo
	gzwychm1cE6TikQylUsEFbGJzlHwsl8noZJQ9XLVmMPsbMsMOxKMg8BpsvA/nkQaSf+aSDVg/07Ui
	CW0vL9gjBeiPSu3KxeFgipr4JYSozKWUe3MZLU5jSLTL6MM37J3oz7kHeNdu3Zq47KOAc5D6L2XZW
	8KPg8jrUxxlsAO3lYg3EatTJfADehQ5uLosN7e9kpSc0AsoX2cIZSHWQD8uEGl33PzqPT9wRvaWsX
	Nwrx4xgedMl6mlMS0b/Z4wlCx+HbNwLVMWqBFUN4C1BLJKmL8PBsAChPLtQzpnJ1VTX1+o9/XASU2
	KA4qVz0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZcQ7-0000000GNwb-3OZ5;
	Tue, 16 Jun 2026 22:38:11 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZcQ5-0000000GNwB-3B7v
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 22:38:11 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c6a4eccab1so8515ad.1
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781649489; x=1782254289; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0bi42mNvv8zEfpJesfq39j8DzoTdUbmNl2yt46Rb57o=;
        b=JqFy4wLLrVI1+w2Lsb+eN7EMN8avDG/B2DmmnqdmxL9y2ljC8a8XPv93+izFRDuxPB
         IbXn9QogXNQOgqy/CCXRsq06EhMfxErzn8XLD7SRks+e886TFE1NxuGMta19Zz9uGADi
         m5jE3IpcUfl1P+hp1+vF7/1JWDAgrTpPv1vVKESgAafRaEIRMt9iViiIh5kmPbo7HOg4
         RsFhDaW72fnpXEwrxRxJYMFfwm7Puu+cQVs8HRosEbK4Gh/7Ls2WKWINP2/Lq07HJA4B
         PBLICb6CcOhh1xjxjRJzhS3pOsAZwUQ+flHtGlNPLRkYfVYd62hS+5auiBw2Uuq1oTt7
         1YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649489; x=1782254289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bi42mNvv8zEfpJesfq39j8DzoTdUbmNl2yt46Rb57o=;
        b=c6VSIwCqUoH5HVIrQ6buaYzGAT6aPMELMl/novk98VhtVZZuY+ejjuHVd8JpDrqPnv
         cCFFlFtUmQCJDh8SvwimtviulnGhfEbA4dWCQByfBY307M+8J8aEBlJ9qp6Ifi7DOTmp
         A3yEQb8znvWu7EnfrhDbxK4l9ISqClK92i0YWJdCd+UbbXb+Mh+Hhk3LtCFYjAZpzXd5
         y7EYYmI2XnRZeQI/YO6smWUwFmWTzs4+T1pTwYSm2ZpkAfRgUDbZfkiJsdilCdmNYIyj
         pG49HIohUSwu1NCJVa5OKacMdefhjlh+SXedExNKfQi5NSWdNEecGydYfsY3i24A1g5i
         ufFw==
X-Gm-Message-State: AOJu0YxR6JWySHHu8XlXlaXUK6JXms0l759OJhZRANZIQpFpQKr0sDiU
	x5CnMM0HG5k3xAcuwZbnmMDdL52EJsInB6Ye+ZbUFd0oexKnHJFiKlO2R1H07UBEXA==
X-Gm-Gg: AfdE7cnb8kqMNP+trrfeZYhxTPfFmS5YUaIWXBZ0yYIeiblwpPaJUsLhlk5i7KgFh/r
	f2aVam80xsU3j6vaHvG3JQFmlqjUem911R57TX/zXwFgJZ29rtYczi9R1/ziCm4scaABwr/HXcF
	t4sr7Q7VLMzNDucEA9gfE+kqqDgzPP+xX390VIEJF/mUSmL1k2vecG4imET9orKaq7+Axri8+FM
	eVjLrBCDxbWv5depm77QTanbi2UDSNeUQaT6c+pUiPc2a7o0JGONiGRk6DQIsHC0fu0DPyo4EKc
	egJkluj+Re8UDlH5g0d70ht+fZc37P/7HuVyKfa9mtUA/VVIRCPwZTxe3PO+Oi8ENp1LNW3MF8P
	XBe3qAQo7tvBpVWT8Lp+Nw0oSXgdIBpbvfHVfGrYHRmSHOYem++kIwEBXlVfbQZv5zg3haisOJ4
	lC2LeaTkPb7zDyRras49RcqARvVoBm6YHjH/akAJzNNsUB2Ymbxn5yNeTRg+HnJZKCMbabRgCtx
	pzuuDkFJtCD8EDZ34o=
X-Received: by 2002:a17:903:289:b0:2bf:2e8c:db96 with SMTP id d9443c01a7336-2c6bd35b47fmr636505ad.5.1781649488392;
        Tue, 16 Jun 2026 15:38:08 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5590sm159640205ad.14.2026.06.16.15.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:38:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:38:04 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <ajHOd1lkBJTySVif@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <ajGpxMXk9iyXLzC4@google.com>
 <CALzav=eo=UwoTNTYM8Z7uKoihxfB7NtVP701qidVgoqyBKhUig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eo=UwoTNTYM8Z7uKoihxfB7NtVP701qidVgoqyBKhUig@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_153809_809181_BCB5FD33 
X-CRM114-Status: GOOD (  28.02  )
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

On Tue, Jun 16, 2026 at 03:20:33PM -0700, David Matlack wrote:
>On Tue, Jun 16, 2026 at 1:09 PM Samiullah Khawaja <skhawaja@google.com> wrote:
>>

[snip]

>>
>> Hmm.. This is interesting, so the KHO state is freed and it cannot be
>> reused. I see you already pointed out that we are putting an LUO policy
>> to say that the retry is not allowed.
>>
>> But what should be the behaviour of liveupdate in this regard? Let the
>> system boot in a normal way? This might break other subsystems as they
>> might depend on PCIe restoring state properly. Also I think some of the
>> PCIe state, like device-id, BAR addresses, ACLs etc, might be used as
>> source of truth by other components.
>>
>> For example, lets say FLB retrieve() of PCIe fails, but succeeds for
>> VFIO/IOMMU, now VFIO/IOMMU are restoring state of a device that is not
>> restored/preserved?
>>
>> Should this be considered fatal?
>
>If PCI FLB retrieve fails then there are certain things that cannot be
>guaranteed, such as BDF (B specifically) remaining constant. This
>could lead to memory corruption as the IOMMU may have live
>translations in place for those specific RequesterIDs. And, in the
>future, preserved devices may be doing P2P which depends on BARs not
>moving. If the PCI core cannot retrieve the FLB saved by the previous
>kernel, it cannot make these guarantees.

Yes, this is what I was worried about.
>
>So yeah I think you're right that PCI core should treat FLB retrieve
>as fatal and just panic.

This sounds great.
>
>> > }
>> >
>> > static void pci_flb_finish(struct liveupdate_flb_op_args *args)
>> > {
>> >-      kho_restore_free(args->obj);
>> >+      struct pci_flb_incoming *incoming = args->obj;
>> >+
>> >+      xa_destroy(&incoming->xa);
>> >+      kho_restore_free(incoming->ser);
>> >+      kfree(incoming);
>> > }
>> >
>> > static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
>> >@@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>> > }
>> > EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>> >
>> >+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
>> >+{
>> >+      struct pci_flb_incoming *incoming = NULL;
>> >+      int ret;
>> >+
>> >+      ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
>> >+
>> >+      /* Live Update is not enabled. */
>> >+      if (ret == -EOPNOTSUPP)
>> >+              return NULL;
>> >+
>> >+      /* Live Update is enabled, but there is no incoming FLB data. */
>> >+      if (ret == -ENODATA)
>> >+              return NULL;
>> >+
>> >+      /*
>> >+       * Live Update is enabled and there is incoming FLB data, but none of it
>> >+       * matches pci_liveupdate_flb.compatible.
>> >+       *
>> >+       * This could mean that no PCI FLB data was passed by the previous
>> >+       * kernel, but it could also mean the previous kernel used a different
>> >+       * compatibility string (i.e. a different ABI).
>> >+       */
>> >+      if (ret == -ENOENT) {
>> >+              pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
>> >+              return NULL;
>> >+      }
>> >+
>> >+      /*
>> >+       * There is incoming FLB data that matches pci_liveupdate_flb.compatible
>> >+       * but it cannot be retrieved.
>> >+       */
>> >+      if (ret) {
>> >+              WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
>>
>> I think this should probably be considered fatal as mentioned above or
>> the caller of this function should get an error so it can fail. I think
>> retrievel of preserved state should generally not fail unless there is
>> memory corruption or ABI is incompatible.
>
>Yeah. I think I will just call panic() here to cover all cases.

We have an luo specific panic macro/function that you can use.

luo_restore_fail()
>
>> >+              return NULL;
>> >+      }
>> >+
>> >+      return incoming;
>> >+}
>> >+
>>
>> [snip]
>> >+
>> >+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
>> >+{
>> >+      return false;
>> >+}
>> > #endif
>> >
>> > #endif /* LINUX_PCI_LIVEUPDATE_H */
>> >--
>> >2.54.0.746.g67dd491aae-goog
>> >
>>
>> Sami


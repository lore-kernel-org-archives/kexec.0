Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F38606A682
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MgPoQ8Zk;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CbRKvKWe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=l4CNQ2xoCIzIiOKM0YDrq2t5ezZfH9cmVn2diC4Zwwo=; b=MgPoQ8ZkEs7vMffAvG5e333MiK
	twpoKEFg4LtIFCd9bfxhhd8qxq99RC9eYQ1iu9BZkLqI7+V/IVI1fsHMG6qHbjZLS27EkyMP/Jzf3
	lffA+eUxI3Pp4Kxx8Sficaf35KDIVDpAnd4V7j3kXNA4VdIM2jFb2gLhj0qyc2qBo6JeI9SuZwM9v
	0+txKdJqFnK7yLcGjQ41zmf7SRjo3tjgtrXcPp0RRdXE28sUjwK/2lq//jBCs/PVpSVODOHq+OQ14
	TQ3VLd8qFXn3iLjgFiTqTLgK5jcNwFomCXTLmA61a3uAJ8OzJTvCvwBH2ls2XQBrrkXyo3ni7QyUL
	UhmySuDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHu-00000004bFk-3U3a;
	Mon, 23 Nov 2026 19:01:14 +0000
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHl-00000004bA8-1rLB
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:01:09 +0000
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-4ea2c058e67so4099550b6e.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 11:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460459; x=1796065259; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4CNQ2xoCIzIiOKM0YDrq2t5ezZfH9cmVn2diC4Zwwo=;
        b=CbRKvKWe822LUItdgGGVA+EHPRVBkoI/ORfLIbMFVXhFgrlUJyQlMvgw84j9mFWRp1
         61LqRtpGqwqM7meeepWIQGuEPpXSimd9/pfWuBK07P/9V5LKbIpo4AjAbR7nngvtVSes
         utfSSzjifOMBZfYSj+qiyBFr9QH/EyQm5MGrxgj2QATtRLYQlV9oUhzhybxdvtlCKH69
         V2CoP8zj+JciL2gkk6MlqGxpQvygMcvELZtJ7C/wUTPOfcPVQw+OLOeDxf4mblsfSh6W
         ECnDmhQPa3QxrWthbO2Vt6qZT6V8HAE22e9CSSnZaHHmMPsS/oiQtZ13TAGEKimMicog
         fbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460459; x=1796065259;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4CNQ2xoCIzIiOKM0YDrq2t5ezZfH9cmVn2diC4Zwwo=;
        b=Nr8wKzbYjsrSWRjMDEr9WmK6IJxulU12XxmlOMB20vgEtCMFqbu69sfCv2vHbN9pNE
         eidbOvXMJ/a9+2SPDKqVRIJ5nrhNpfKtVExzwtbfdJXcbEANQMEivR5A49Y23e98wFcJ
         JMs07hFW3KeanE3zDhEdwlx2amRUqXB/mh0pBKUkmXJheWAYgNA87q5q7TOJnm9suGFU
         8XQ34CyLO+DcmZSNf/E2K4MYOYl5JCnROUk90EpbCjeolzhOlw8tg8IZJYqqGH1E+Xm/
         rB8JAYG8w3toDgo+3K0UkczJZf5ajsKcj3Jb64mqNI0ajrBi/ofnYXM/64WJFzlat0pj
         3rdQ==
X-Gm-Message-State: APuU4Z8mPkR+bXR++yxUikEutZ2ItkyqwzkWaTYUHuRiqSHgAOSIiNRZ
	7Jm7vJf7yWskBpTnfqR1UJQ/ao0wNUy6y2WVpnsKE66+CtVY7u3Th+mNa7LCrFPeOcScoHHXWaG
	4Uuq0r0t4OUBs4i2ITC+kTtbP7Pi31yCz5KlNGuBvReuYxBOWsNApVeKb9nJF6k4EPgnT8ncKhw
	tsicCtqXft/URFxoy8roZAldAyZHb+7zAIR4ZPaFT6d1x3xwYP4JU=
X-Received: from ilbcb19.prod.google.com ([2002:a05:6e02:3193:b0:54f:8d15:4dbc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3084:b0:55c:844:98ff with SMTP id 5614622812f47-57a0a93940fmr14754171b6e.34.1795460458168;
 Mon, 23 Nov 2026 11:00:58 -0800 (PST)
Date: Mon, 23 Nov 2026 19:00:42 +0000
In-Reply-To: <20261118223704.3286085-4-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-4-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123190045.2166865-1-dmatlack@google.com>
Subject: [PATCH] fixup! PCI: liveupdate: Track incoming preserved PCI devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_110105_934157_FA0360FC 
X-CRM114-Status: GOOD (  10.53  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pci_flb_finish() logged args->data, but LUO does not pass args->data to
the FLB .finish() callback, so it always logged 0x0. Log the physical
address of the incoming struct pci_ser instead.

Reported by Sashiko.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 493576119a76..520c7530475c 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -409,7 +409,8 @@ static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_incoming *incoming = args->obj;
 
-	pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
+	pr_debug("Finished struct pci_ser (0x%llx)\n",
+		 (u64)virt_to_phys(incoming->ser));
 	pci_check_all_devices_released(incoming->ser, &incoming->block_set);
 
 	xa_destroy(&incoming->xa);

base-commit: fd54e32f7903199e8acb2762dd2debfffe4501c4
-- 
2.56.1.809.ga0b61035b5-goog



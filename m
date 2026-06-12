Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EA4CD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YX03BK2qmjHf2a7Mv9URt0qeSBupGSFb+1E3T4/eV8=; b=pAe9vjmYIxgCSPZpOkfnlepugF
	qecKzZPhgwU6CAnsRVHR7E7rLdxsCMHpDBo1DYicSLRrIYAP4tLkal75CjWtwXIWFojH0FGVxBXrJ
	CV09RmT5qgdIVr9qQH8fHPaGnABfx2FfvuVWvHsY1mz+q6gnC59jWP15ywoneAUUwkvgmhKnzIumk
	rXYowB/4+bg6TloRNDFfoodxjJh7N6tb+HiYcr+aFy3OjASV8NloUnLeqHBDsZDUQnsP7l05z+Zv4
	gbNAdzSEv4J7Kh1KIEeGXjV1N6+37K4dVVHnPcnLlQfBctTnIrT0tPuIaiBLrPAPdhzoaY6yrcjwW
	Xeb02AQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXzPw-0000000Alfs-1TGW;
	Fri, 12 Jun 2026 10:47:16 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXzPu-0000000AlfA-1khN
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 10:47:15 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-91574384cc2so95267285a.2
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781261233; x=1781866033; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YX03BK2qmjHf2a7Mv9URt0qeSBupGSFb+1E3T4/eV8=;
        b=U0KXJvw0XrWWO1zxnVXaOUhxfCXMxyR6y1xOCtk82ow4hWKl5CcS2EHUBOdGVMeqnT
         odGKp70ZLJHiA1bK9Brxza0M8aPk1vpS9HLnTXcoSEDns6oLR5ugMrO6ZN8UhlmuDvHt
         pn90gPmNgo5R7NNylh215IJbXxdmrzCZasMhSFwHmlyePgFvesHn51dstZ63QxlNm5M9
         RaDZyFzCmVPElqQZcgl0ZY1+YtlGfkI/Xvhutnq1balY4TqZ+6UoTKhcDsHpzw6vrLHe
         F7Ct5WTengH5aTcmq4D7jRn4Oy4JyhWvT9S6yjdluCf0UKr950Y8Taa1LhNEGB6VFChi
         kySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261233; x=1781866033;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YX03BK2qmjHf2a7Mv9URt0qeSBupGSFb+1E3T4/eV8=;
        b=OoJ91PPjhu2WLsoqAPqB9vIMbyOqNVCqbeFuR7iZMe1t8fPamyprfQ7oJgyqH+2syL
         uAagk7uIPQF8VHbatMV3NgqizNHIbjPY956GyRiwBdcRj65jqFuU06G6I8htCC6S+yLS
         FKial5tOogeEpx6jGluCaVpw8Ot85ouLUxbkprZ39Af/TFGA5GSb17bai6xHvqDklkja
         gNU1uyNk/1awiaJxPIV07CROcQdUMc/c7zHQyrOdoHK+EK+u/BSkhWg7sKI4yxigsNdA
         Nz9ON+MTxS6QpcUXCD4c7WIj74/ZdFZTEG37v4MgvBHxnPaN2q5R8UWxtSsAb9rrgiVM
         i5TA==
X-Forwarded-Encrypted: i=1; AFNElJ8Om/GGVd4KiesrUZv32toiJkJxi73W4Zf5ZfkPRJB1at6kGgfP1NQwm2HC5CjYBE603OdTKA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxljO/HaPvCcZGQDOa0c5vxImUpyLibCkD/D6ysoi+RTC13W0Ru
	ImVlETLsaDYAH9dOtH8FKuhY0/a/Y+H3AKmvetkwPfoaNG4Y5icQf8dllgiVlJqa/R4=
X-Gm-Gg: Acq92OGufURlPXppcrkKst+q0LX99soMUF8KDzZBI1QXRSec83NX9aIIHx04SiM7blT
	SsMuHvjSUNOfaRkzMwFDavmUX8RcDQIk/vgeGDk4o/mV8U2Ov0NVla66eOyDmSnoB+1mk6hNP6T
	wRFdvtZhL4sfnIx/TgEinOXks6I5YDVURcnsZS1ovVdLPRmxduGd7tSQnMyIYpu4fi6nUG2hhMr
	7d/Y+jh2VryM0MIluLqc4RVr1mHMO49vH4XCT6havYiVbtHVb9nBl3ARIYppiyq3Kycx/1QPZlI
	7QsYpnN+1wJeOLHqAUY9Rpmm/8Gnruee8lHp3SIOn5bp8+2lCGMq8DOBe5Hdyy1bY7T/rz6Z1hc
	8/ckv/3OtikTK8nDZ8sResPJRKE2p8YVSChW1BIAh5U31A5Il6Wf6/HUmVf8xj4u7oPoC1R2Kl/
	VH2Dp2PL0v6S9dQNFHepvR+Xc6TeHumowpqlOj14lRCzOcDanV5AGusXxED4hu
X-Received: by 2002:a05:620a:2894:b0:915:d5cd:8ce5 with SMTP id af79cd13be357-9161bb00960mr256901885a.20.1781261232925;
        Fri, 12 Jun 2026 03:47:12 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30457764esm19942056d6.26.2026.06.12.03.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:47:12 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aiutNINqxhtlm2Dt@kernel.org>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
 <aiutNINqxhtlm2Dt@kernel.org>
Date: Fri, 12 Jun 2026 10:47:10 +0000
Message-Id: <178126123047.908199.12042730612990730743.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=klfiiHVrid71PPzvcY6gYtk5jDnKIjwVEJeiVajF+y0=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK+OvGft7vBLOTTPKIur68ZEWcTau1cnkC3skC
 zr1NiV+qhmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaivjrwAKCRC7dyhM23N6
 3gyZEACjBtejaa5EWZ+XlEJc8O4GIePljN4Z+SFApZu13G3wo00ycXVVPBN6V5+aetDEBlFZrNY
 xw5OagriLkgPclJeE/mSxyOeT440nRV0zQFEVcf8vhFBQLQKCxAyB4642/MrXNo3B/PkoAoh0Me
 5aOMfam+XcBbudOzksGfJ7ZLSORV98BsXPrQ2Gsb6dTXgHFl//fyMWjL5VR6c1NBooV7xs5ZAO0
 OyLNZhDXi7tnur55gyTJ/0gH3Of9YOHVcrWYvVldEyhPy8lii0HEPojuUI5xhRYj+yZLO4kKpik
 FxHBtPVm01/VoKz953HN8d8gCvKq8fV/OXil9B8twhGfhtiAy9trrIboh49Hu9Y6rxKp8OMT3Dd
 YNjvpceH8opcMcU/iVBCcdU9MQUUtHcImaw1YvucE4iPfFH+ReeBRJfJ7KWFzAQbqwPUctLC4Je
 OSAgwwcEBo0QmBxa+F8FNfgRqKBMV8G9vlEkD5ZmjiCsmA74UHfOgL89LOWmLzxYFnubGLMUU/2
 25SbVIJ/Zdyyjp71SESgIGRiKKuS3NfU7976kXg7Jclio/CVpIz9cwvxf3WMC0ZKYqgUjX84syz
 6JjnY7o6rWtYmf1Cous+o64R7Pxmwz2jyxzHbudSfK2qe8Lcx3aT1oGWKJA/9LSyKcHdQv9dcrd
 zelYBz9lnBEqGvQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_034714_468853_D3984A0C 
X-CRM114-Status: GOOD (  11.38  )
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

On 2026-06-12 09:54:44+03:00, Mike Rapoport wrote:
> On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> 
> > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > 
> > Please add Pratyush, Mike, and myself so we are notified directly of 
> > incoming patches, the same as with other areas where the liveupdate/ 
> > tree is specified.
> 
> Or we can add PCI liveupdate files to LIVEUPDATE entry.

That will not work, as we cannot serve as maintainers for 
PCI/VFIO/IOMMU/KVM, etc. David Matlack will be the maintainer for the 
PCI components, and we will accept patches once they have been approved 
by him.

The simplification we could do is to create an email alias 
for the live-update tree maintainers. This would allow us to use a 
single entry instead of listing all three of us individually.



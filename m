Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2758C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HlCwb+1ZnQlT8KXH+VzgKgpVkzFEV+OYr4Ev43BkCgI=; b=YWCoYcKoZFRDOCF4IgHgOBQbZT
	yMotvRH0rHRSHl6yAvv5zHw76A6ZEdbJZQlseek7tGf3Ks/6zQC0QXyNTgi3fWYy5jwTIQp7UWBwr
	qg0kafmW3PYHcAeIW21fKNcO/C8MvDREIyYOg1dV1suAanLm6//5j2tVMWV4f98Jh025PrhkhvkMn
	XCGZOu0xRaZvJyFn8s2+6hcLZPB4Bz5xRUrxaXUB3QsPjYoBN/E9Pq3PgVYl5hokmtW60Ke7Yez2v
	c7le8h5DKwFOoT4dYQTYA15q3RV1X1dsz7l230JXFYxhK0hIgiza3w5t9Xc03KPzA2Mz5YwoxH9j5
	aB1DjALg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqdn-00000003JSw-3L4I;
	Fri, 17 Jul 2026 22:02:43 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqdl-00000003JSN-2FoF
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 22:02:42 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-51c5382806fso41960661cf.2
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784325760; x=1784930560; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HlCwb+1ZnQlT8KXH+VzgKgpVkzFEV+OYr4Ev43BkCgI=;
        b=eRBKDxfunvRp1t6AZuBqFoPULyTS5YZ6mKaNsPdNqdOAC0NXvm5Q9nSXZ4GB/5sb7X
         Z0rBUksyhMuVz9gJ1nyNN5aNeMS8Vyq3GI3RkO01W+BuFOVaLmedF08Q41UGQrSCSjaQ
         pDGXCiJGclrpnRLLUiGOCPMhKkZkO0440CXJaEs8A2mGVGCtm27+IjSkhYTAcC6NQldr
         h3bgBBY5YIaPlILqe2GxOhzM9W+X/LdzihELmfP6JRx1ooSCgEeMavp4DvPgsMDGkoZA
         xX4buLIDdwnAd7kLPTO61ZT/QYpJLpHWfvxA4+RnQKdmBFQ2SziDFheNl1SjmCDyxkDw
         VN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325760; x=1784930560;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlCwb+1ZnQlT8KXH+VzgKgpVkzFEV+OYr4Ev43BkCgI=;
        b=MBXzb/ZgioRvyIujB/aLP3QuCu6Ai7Jibvo9W1PvwihFm3Ih1zPD/mfp+pRdDrx7fg
         BYWhV+VdVzQw81jFS7FI7CuhMze/im/VuNzRUb+3Q0pNn8J7DinpSKx0obgbr+TdVC1b
         FveYfwVK1uevKOJigqGb15vWs5kZZwDusYa2AXBGqjRAYbkeQacAg9JXs5B//I5D1Vjc
         gkB1rcy31TlQ4rqp2DNSaHdh5U0pjUI2/E/spC2ltw9UcptL//rKF7zh4CE7nOidiaJK
         NVUl8bp+/aWvokD25jPXxyGTIIQzSVryMt0UAE/IgxThHCGo8/GX5F6feTP8wV5P3mp5
         2wqg==
X-Gm-Message-State: AOJu0YzvWEgc2HnAuzL+9XOUllWK6ds20VXVg2fHYiqf16X21hbnC856
	Ry55WAlEM0zo9fnroVio6EHkXYBUthcDi3r0drcdCFDueIt7lxzgGODm1eCtqInzM7Q71bjGMrC
	PTJIm
X-Gm-Gg: AfdE7ckQT6YKTDeDvJ7tZZ7bAFFzSDsWavGwn0RaEzQZX3mwgYjJTzxq8Datpc4B47Q
	1qqTSzmk12DGrS8XOoQ0mj5hE/c6Gur87EisLoGlYKGSzF8zWIhg1dCyf2sMeFBlGJDw6pcU1i+
	YrLb0a2+1di17q/LhNFKVDvb29Gd0iblFpbXzA1dGjchWCL2+IPOHTelLoe1fo0E9wVxj76yQT/
	OEbIH59uYVUbw17haNb45H3xnj256Kz8MrLzsxCS97IPm8IkrE35C6TcOfu3qRdk4QWBTyataDd
	ElXHtyquX2ZFUwmSypGPUnPKLFGS+D2poDOys0SPiTnglzwO/Niyg4Y+Chvnt3pvN9HGMgjMWEi
	jz98k6drJRMuuFYOKQ3jxfd7YngKTrjVJDbBgmUmYL7bCQEfEuWd8+XkGNaYnvGoxV4pdRPgNfa
	eTUMAJVEG0QCVUI4kJJJ4fhtkbIcsaKSOpl5Q6xNw=
X-Received: by 2002:ac8:5f06:0:b0:519:51af:febd with SMTP id d75a77b69052e-5213f668ee9mr42987041cf.46.1784325759954;
        Fri, 17 Jul 2026 15:02:39 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f016aa5sm21849151cf.17.2026.07.17.15.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:02:39 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 07/12] PCI: Refactor matching logic for
 pci_dev_acs_ops
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-8-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-8-dmatlack@google.com>
Date: Fri, 17 Jul 2026 22:02:35 +0000
Message-Id: <178432575544.189683.9290455764634301119.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=586;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=LxcbZe7BgnncPWKoPk5gxZGS/pQMdASC0LgCixjRw3Q=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqZ+Wxzq3jD2mMABNI1669A+3RszfBn3ErJXV
 Y50TeZzWEGJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqmfgAKCRC7dyhM23N6
 3sVSEACDLPUH2+MHEoWyXAsDxYRkVARIRC+B2caZvvSgXaiLKmKi7pEnnql+8FPdsbwKkqRf9Jo
 dQ2qaVmpxf3l7ARpfkVXvpF8obibHQVOtxBKAkqoFNEHzWZzOBT2vYoywdcdcaiRGpZ8X12q8Tl
 TZ6s50Ini0rYTCvZ6zZ0zyslIqeoYN/w21C1mnmLJA5l/oSdh8oF+nocO9jyy1UkYfclKEmsVfS
 aASn9AyStUUOLNMQvuee3N/W+Er5iAx44Oxg/HGGBmN+ofL/MrxdUAodAIg6NbpN0q5+5fKvDvD
 3KJcKOTnhHwhzxV3DvLnf1mAjYQ/jx4J4sTJYd8zPRCFQzvZ6IDSdiVzymUbhQvcVC66zvWuSgM
 zuzoedeSeAq72CoyoWiZ8xLA3hfJyhDVh4pzPcDA46ZJ0AgW7nAoqHiYNPJVCbtB2qPsQSNgU4G
 1APtHXn0r5wICS6gPX7ZNcb7gNjnMcy6DZnrtpb/EgW7mEZr3zXxyuTeJrA6i3CogY5HCwl3avb
 k6g3LAvAnL5AhxIdAkfMb/JyCoo7fbWVvu3QdRJZoo4BTMU36Y41oNHHfuKo4IvKo+GpHaqe6jl
 t0fLRciM4UeB0Huvqd6ER6xDzWL/FjnnKjzHSJX4hp19xMTADl+jaeSlOdLUWzkPxqF+6X+8KBF
 zC29UAmi2lxznvA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_150241_610465_4BD806BE 
X-CRM114-Status: UNSURE (   7.64  )
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

On Fri, 10 Jul 2026 21:26:10 +0000, David Matlack <dmatlack@google.com> wrote:
> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the loop and device matching into its own routine. This eliminates some
> duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


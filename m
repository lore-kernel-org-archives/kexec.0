Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E204C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifI+MxSrxAA6sSWteBBgDksztUF+b16cD5klnXr7OpU=; b=XZEbePTWwnjiRK2p2khR1VUCCq
	Trs66ypoKSFAegghigGKOmVHYEUH/ZZx9aNucUa+s4/AcmN8WVeFRN/dpQSqsXXDRXYbnlvMfemFn
	aODN9ZAVpw8iTp3V/asjJjdcUDa8yVd78oAnRFznGHX+OS1oKlEh+TEx7tLUvhYigjZ1BOiDRV4ot
	D5zC+l9CO5buYeHENT5gt1bn8FXHspxeid0uC1xfB3XlnBKusE/qtz/t7KXg2GAesqMN9vwLWbDyu
	V6PAl5BKuDgBFBVIbcWDzhVvq4yJAz+Lz59d2ntbjFx2ZXI4quR29BaVHQ8rbr0YqZdtoclVlr56e
	lImOc3BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqbR-00000003J9z-1Tah;
	Fri, 17 Jul 2026 22:00:17 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqbP-00000003J9Z-1Msl
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 22:00:16 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-51c928bf172so59032251cf.3
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784325614; x=1784930414; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ifI+MxSrxAA6sSWteBBgDksztUF+b16cD5klnXr7OpU=;
        b=VM6EdEF1stw1zvPYxdYuunQnBo7z0F5pgo057E0L1ID8OIpt3B+vTfFPtbi3d/5rZh
         9iPQWU9zEtKNGWzgXdbNGfT4f6yQfMNhQd0ESsPlspMjIKKeMUeHVDH0wVYJvuYZ/KOX
         NQAONY8bluTF/M04QB2G+e/7cSxvbwewPBpL7Z8syztMap7Mrq325FwZzQRD9DIftP9p
         d3bS9rcS4FaGefM6TU3em67Dmafcz77oIeE8D7I1tpzyW1yneK/3YTaxqmTJWawy4ZzC
         dpd0cs4qiUqS9GGjeCNOJFUdMJxq5oYhk8mp/Og0SjvPultO622foSKBoorRgTK+DZj1
         MY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325614; x=1784930414;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifI+MxSrxAA6sSWteBBgDksztUF+b16cD5klnXr7OpU=;
        b=Eq6emZI6a9kLW92zPtztQHMSxXPHmFAlMeMaBAJUDgVEFQPsbZGwMPXagq9zmaATMG
         Bt0jN1GJh9goTpsLA3l4S5s4iYJkqVKhYmgtpcofazEgp7DIi/LC4l9/iso3IYh9AS6u
         5xZl41sHiXyJCTIaVIbTJ0hk8fRgMHjuILFFDFqjNHR8i83C3L6bISN6CfRsHHCWoQz6
         6/RylpmJduIlHgZv+RHUkdlT/uBzZLWDB3BzBGg9k+if2l8OXy895CytO2rQoXlU2Qm+
         6mhEQd1UuL6JWTfcMJTg71t8xbHyRqO6STSE4jqFSG45i5EQvP5B589xVYRX0dWqAKkA
         w1/A==
X-Gm-Message-State: AOJu0Yz9d9m9+7gSayYa7QVHNv9t47lyd/eD7nyYqyzJS6bm/4UtLHv/
	VmxcX5d2NROQsMHSLVhkoH6mH4ge56/bGOURiOixnb0XI8TJeZNR3QUsYaKQnFXi/HI1QYnf+ov
	Ve8wf
X-Gm-Gg: AfdE7cndx0gpnJiBOLK/SjgEpVbqPRSosKVdvDGkAVY8piRKuis3/mYFG8IoJjILjBn
	enZGyBUFF3bnpoqAnZXd1h88aGExtPjG+BHP+WP7OVOfvcLingmP69bYZpmagnxORaI9LD9Jp09
	V00Bko0fnhLHpoHZRSf495f9F6BVlNstywKqOqkj1NM5ujdNuLTeFx2nUcITpWnmYyPlYTnsJgO
	Z2K8xbCEAJ4SJvPRaxNrLZ0waJfWAiHbjJyPyQb/j2aYK/UQCJNuQeNBKaIY0iv2MISSruKGLZ4
	+8NaSjceJ1GfnfQp+QqbPOaRCha02F8Uz1wMm6e5tu8sr6dwEV86VCGgnyYe6iQnoUjCXQpanOQ
	fRXrDuajCQQ36L5fxFA+WRTiX9w+J6DUThZdGkLh5irujDoObQA6Pu+M/8t7WB3dojWmsuxMWBl
	9SBrZHtiWggZxD+pUqPmJhL8ZVP4AR4pjWdfeQZ+Q=
X-Received: by 2002:ac8:5fd5:0:b0:51c:7b12:5fe7 with SMTP id d75a77b69052e-5213f378d24mr42575461cf.83.1784325614000;
        Fri, 17 Jul 2026 15:00:14 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b2a5csm27038726d6.25.2026.07.17.15.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:00:13 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
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
In-Reply-To: <20260710212616.1351130-7-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-7-dmatlack@google.com>
Date: Fri, 17 Jul 2026 22:00:09 +0000
Message-Id: <178432560931.189683.8819967076124393595.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=635;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=qvWcvkNG2F6VP4AQ/OsjiXWkoEcGbEfuK0Svedjd88A=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqXst23iQddM5JeKJBv5+L2AUkI6Q1Imib8QW
 FplXhImuLmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalql7AAKCRC7dyhM23N6
 3h10EACKK0N2VwEouy2CYlXnQQDJcHE0yJsT9DHhMi2Mje4OjA+G2J5YK8Ey9tSvDFEN4MIxr1C
 IZPZjgDZHgP6pYqeWYUKqF2adMUoo/gT3yM0xVuTHeyIwVU62yur28Xfb6YM9xVDfvGFBv6vtfO
 jm7GyFSIVeTdMitTPUwJ9+dSDxWZVL/Av4OrHAmbpsCdtjU7ipKoGAZ8mjFd1LQJQWo2r+iDqQ8
 F35z2mfJYXSEiHmuc8NDXRunjTg+VzvwBDFdMrrWDgW2R0dzM1fP9kuTUxix91XHpMwBXUIJFk2
 f6zhYw2ecfhQ9QUraWoXPAvpO/zcWsJZJTPxmwjJguJWsY2u0fWnprkQQQRUBl36KJOffbjb0z7
 fI/gzFrFkS1P2N0l1uwAv27v4n5GDfPok9wFNXYwvhEIFi9QF3y5EYHTxoblOxdIhOGcYe19jBz
 0YtAyz1zbJL11x4KiVA7vH9rRb57YZwnrVzae6b8DzkkIjtpCur0tNk7GiRU4JwFioWjr3UVcMm
 jYkRI58+ErcB766VyU6VNEEI+AOYi5hmlSIXCY4SCJEu8mnnzar4ozhZ/5GeWfJORkK0gOE8YGC
 K19l9lBFbdGjs7nS9EQtHBT8DqPt5iudHpvDhMfozA/RFMnUT8eETh1IhocLyiqY5FNzxM+SSzW
 CsGDXtheCUaiY2w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_150015_384570_6135DEE1 
X-CRM114-Status: UNSURE (   8.60  )
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

On Fri, 10 Jul 2026 21:26:09 +0000, David Matlack <dmatlack@google.com> wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


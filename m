Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE786C44515
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PEzgM2Gr2GnhjRTo4YiC2+4P5iEfgV4/tsxVcY/iHLk=; b=tsGUdJq6AEXb3MYAZTMD2ZKWUL
	wy2/OkPO5SM5fQPRY8C05JjaGKOvPg6ObYuP79BxViO0KakXV3C/x8IItohtVsiItkShqkekADK5+
	LBvrNcXCnxy5LeMAQHSfCCHes1RyQksWV0+wH6W0rPyVbt61I3gnIwbD3lZb5cEJdcj1Esxz4sMe6
	Eeqj32P33xNkuc3xHgrhOTX0O7mJt1owtKDWkr2BuFAOIslzQhxo7bek0+/zJKqKZrvD8DCGk1PLN
	LJjs0glT+unkU41MaWvaM5vIHa6Cs0ma+5UMzyIklDf0Y1ww3jViQ63rAK52nRXyCQ9Gvj5pbS/Q7
	9WNcV7OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks0y-00000003P1u-2DwZ;
	Fri, 17 Jul 2026 23:30:44 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks0v-00000003P1L-2i5O
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 23:30:42 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-90004d2f7b7so107799666d6.1
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784331040; x=1784935840; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PEzgM2Gr2GnhjRTo4YiC2+4P5iEfgV4/tsxVcY/iHLk=;
        b=V0iNr9uud2A46FECq6uZsTVxIznNK+/XQ5yp49rYBugL1gbJsOqpSgPuyhdePWG2wt
         XDNNB8PrLz49o5dzeoUB74gC5is5k2BvosH1E2p3dcRMdx+LPs2Z7/Naz4urvsXeYwP4
         nj3lr7sxd1A7sQZCO/tJq0mb2qXBctFRP9u5+fw4FgXoQwZExGCEBoMbjTYwjckxCe/e
         9qn2jb3kOBbAEowECwXBPw1720U9lyDjbVVKV52YEFLANkRA4SLzM/Iz+plXhJt72/oI
         F9yoWprRED1xQvSLlh9UIqUqouPz9VRpFkTHyaWUK4iIfzRfwBj5nvmXskB8673Wi3LR
         dHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331040; x=1784935840;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PEzgM2Gr2GnhjRTo4YiC2+4P5iEfgV4/tsxVcY/iHLk=;
        b=eS0rVQjKmWE1q95zoRcK+xqKBmo+rWrgfdyzp06d3yBAHZeLp0wK4IKeML0QvJLxx/
         L8jnHsPArbqDTjGVO++XFqp3Xs3V64fIey+ETUfjGvoAfiiU9x4V8J0MuxmvB3kysOUB
         tLJ1vnFnSFhSf4AtNJ0jPkWg8rYLS87V5FcAixujOx218Ja8zoSDpED4Oe6Bp+6/BxYN
         XCULZAAPZ5wD/LhYFrVQfbcWm+e5eXOhCnUiPncGDk7NKdZJhh6e+apcxfTJTWhB3DzC
         ucwf7CEpgwnLGzFE9PxUK14xZ3i4V1VLh8wq45u/UIbcf4yVPRAdZyrDxTF/ygupEYTl
         r4fg==
X-Gm-Message-State: AOJu0YzLnvHaaFYg+tKzgZXckLX2w5P+SlnUQ4H3Ca5I1WGUk2lm4fTB
	MBnSznytH5UU8Ov/z+cWOVvKCdAsdoKrZFWxobfAeZBd3zdhmiVzgcB9sB3rNpEHN7eK5/rBgeB
	8KJxo
X-Gm-Gg: AfdE7clyvRzDRFre79cp+IEGfbauHcJIFkouIJLCK598diEWXUoOShGHmwLuByHGM3i
	YIEEErNJ8PsprRgoj7KXFptozsQD52b3JXXwBJzqDC1ENM9Top6MhiRwNn0H52Eh/rZv/2xvu9u
	GfEQ9nJqq17w0FHeMWRU1Smco+RgqsMbqAVE0pB3nUMWgJdVbXjbbp9gWpPdBXuSQ09ocTd5TLX
	wEss5fAHmxMB8QifW+uzzhNRyDCwf+PC3oNzCzgkogDcfpHbECWl8Ph3R4zWlDhojN5odQqPQJC
	Q2H6aVWtXB7A2OGlJZ+dw8ypbxA7a6WixV4oDrM1HUadYkPLlENAFyLCicvJu0XZLbTbHA+sSnz
	5XXQGswqxeSfmBJ7sL4rVegQS1DlYpH+YyyWmaCMvWOy9AU6y+6uZt6hYra8SjoRjntScKF/I9O
	/dJkVPe6me/+mVXCPxlaiCFbepd3oWEtd464/6HqqyCUQTEtUxsA==
X-Received: by 2002:a05:6214:4807:b0:8e9:f5de:d619 with SMTP id 6a1803df08f44-907784da90fmr56797966d6.56.1784331040363;
        Fri, 17 Jul 2026 16:30:40 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871f766sm28579206d6.46.2026.07.17.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:30:39 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
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
In-Reply-To: <20260710212616.1351130-11-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-11-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:30:37 +0000
Message-Id: <178433103736.189683.14104484157018816623.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=cwll5ojRGw0w+GA5kxbSjj8gBXVrPV2vP/bR+u3qu5k=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWrseW7SPwOTtm1kzcWpOdZF2Wwm/mTro1PbnO
 BhI22jAjkGJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq7HgAKCRC7dyhM23N6
 3iBJD/wJ+nRxR75OuWW3wtpYMQDKol4uxhjUSJYUOuyvweRovjjuACyx9p6/PrONMDh1yR3KCBd
 XKIIq4cIDra0zdFAnB70v+teL+vUXwgXL4FsjqfeMNQ8RDk6BuWEogaq9ED/vIKwmxiIuZ9Idel
 XXiHuXwwUCZZVKAJPpJ5JHzLLjUAH/Eii8tu6ckH1GUH2ePTX/r1nnhchIWg4HGnouD8HC7tVME
 K0whSSIfgfycSAHtG5cYny6ngWHUdXYOI2Q3a97FmnB+RKa4g9Ag+Llm6iMKYom4/9o2j9qUZ11
 d0WDFsVH9gW3GqSqnetsBL5L/c7OnEl/RIqGUM0zlYiUb727YtIfoXn9DpV6Z8+yNtrOm9iPgS5
 Ie6dckeuYoLHiVGduirWtSb250rhL9ozPyICTcqrg1woQo+jDQN++SUWm468PrJgf9qtar65lrs
 RQfzXAbY+3/3hrHs2GRzm7GMouU5Txb/7bvq5xX/5eX1vUtgr3A3WPkrfJke6e3Ik7ku9IObEJY
 NWG7xDzQqedcXzxVUkEpCq6BuJbQNJho9WV2Mj4Wlq0Zo2Wp/VywDc3HycJz3PTw83AIiyHw0s3
 qdw0MrqzDnG/Dyk4El1d7ow5KVN/N+v7DmdRb7U8qmLDILyi/hHxAefi4xjmVoU0+trUeBFOWHH
 2SrfN1XBYQ3BnJw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_163041_703772_07E904DE 
X-CRM114-Status: UNSURE (   6.90  )
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

On Fri, 10 Jul 2026 21:26:13 +0000, David Matlack <dmatlack@google.com> wrote:
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
> 
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


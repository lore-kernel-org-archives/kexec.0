Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BADC44515
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOQMW/VMMZhI1OvT3xpmRY3tlZwPV7fJgB6bntOIi38=; b=ledROjEP6VYZEcQAAtRvyn8cGr
	hi2dI2LTrMfxrj1fEMcdYSVDhl4OxoYEmQngoOldxNYko8kk4fxjk+qe+kNzcJ74A+YKqlMbhLsZx
	CetKJxuacvq3I9YidFZK4/KgWgTcYsWhtyLkp7nKzSTGT1v0k/0UNe5tgN+vR17LQzQ5cki/jQ3Xd
	LrQx6GJ71v60ZBeazv83+dF+Ei3H+H+FB+AnA0wQv7aV946UxH3l3qi9Rul7Ym/SYITIpa5Xpxca2
	Y83seFJpmLYaT0+fUNCuyZgDnpDKSitP2GDt77MxQAtqTmN1Ehrf15ol0fuYHoAXKKp3q3n/boLR6
	pSbGRBDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks92-00000003PWA-228D;
	Fri, 17 Jul 2026 23:39:04 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks8z-00000003PVl-1iX8
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 23:39:02 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-90004d2f7b7so107926706d6.1
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784331540; x=1784936340; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jOQMW/VMMZhI1OvT3xpmRY3tlZwPV7fJgB6bntOIi38=;
        b=L8YoeuhPOMiv3CbTWNbq/+uCiLD8YRDYuoPJ704TBI3vMnYUJCUegHvTQbCpAdAan0
         R80eH4ddUcKagvWmkmS81MDnD0O5527+m9bj8FeDhlbdLVpAZ6QyRr3vIx4GohdUsHGR
         2VSeoLXNGZXK3Z3w2IW+v2qpYhNjBKnabK1K3NwVH10pHD+NOMzs7jq97bMCYsJonggr
         T3PBots1ft808QGGwJgxyvpxZ4DpzW7iJmTNGx7MvAQ1fPhbUb89Fx/vPoZEwwKANC6N
         HR4o69rbwGKkUp6XhJb0JGpSC9S0ktw5nnSTQp6FH4bpk4TOpWJQ0IU7KOoWI7aCQkBm
         eBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331540; x=1784936340;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOQMW/VMMZhI1OvT3xpmRY3tlZwPV7fJgB6bntOIi38=;
        b=Tk9aSTuDUAFjKcJbobkf3JoCJMyc7Pc9zbHpPjFzZZ7LklPegcwSFzvjIodHBHKVFK
         znIJig3K5hBkSMO7hC3KFzyKW+1OmFvEWRiDuFcwe4rtoYWxaWUW4h82UFrtuPSwPmBu
         J8JvycpWIGYr/5nsk+MuNa7nZCsgtgCVRYqrxbk4eTk7VgF1B8yiCI0WtVw8Y37mh/M0
         jATIgM/kxxS6VDOp1283DpyGQPbR54CKBx6pi6XNt+G4Z7iI8UfpWNscihCdZPjthLqq
         Uhibb0KOClIAAouhnuom76yr3zClYXPfJS3OLoVLZhXHLei5xFsADwsRHtRivX2R/XEl
         eHKA==
X-Gm-Message-State: AOJu0YyzHEsotDXiC4hu7s4UjaV/Tn3t4z6HjhX0lyvq3Vt3FwjLXg/3
	UXkFocHtd36Y8r8TUu731Hmg42cXc4H86hQbp1YMto7sw2Wrjz3g8GYlCcW49X81hQ01l5rzJy8
	Dll0R
X-Gm-Gg: AfdE7cnsX4pYGzqZAwcoPcvxg/nXrSZFyHOO8gMLdce4Xbyq/aU1cFs1E77SlRnte4/
	1hLt0rXmTDFwJQexhfCeIQuD21HjgZc3o/0b8PEOfaSBtD2d6e0HWI34rnArl26G5oSDQGsg4bv
	+lo5LwS9JOzTGcFTJPOZ+ylQnUfAY0oJr/zyluC32RZ0OgUX0aEg9FzWm2uH/pRL6WeypNY/bqR
	A2AXUA4/VXiOn1BSbcpswdRwvvJAJ5SMonyjx1tHT8Sx9N4c7pBzUdWfSim3QniB2huENHxti3f
	S5I5wBEil5bvPMTDukGWbTzKIX0ZOamq5+8fwTdt9mW73q2OFpA+aQJ+1FBP58DqMwqMBUHI/ZD
	td0jJNbVyRB6iK7amEHonybnw2vmKEoFKMJilcAksV5u2R2AWqqHJkkTfzGN/+mSpLyxnfHq6++
	LDcbTSJ8hmymXH2fs/VSUpHQCO6WYgJigmCc0vyXk=
X-Received: by 2002:a05:6214:5d08:b0:8f2:df9c:3322 with SMTP id 6a1803df08f44-9077832dd0emr59277606d6.14.1784331540051;
        Fri, 17 Jul 2026 16:39:00 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786f79e1sm28353026d6.38.2026.07.17.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:38:59 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 12/12] Documentation: PCI: Add documentation for
 Live Update
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
In-Reply-To: <20260710212616.1351130-13-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-13-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:38:56 +0000
Message-Id: <178433153669.189683.2878214157071313722.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=vSoFj0hBTT5p/CFJP12khF+A/hWJ+rXJdU4yKcto9Gs=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWr0SpjC+L15xuM1whuQrxtevTro4lUduG+wQx
 gZjJKCgnxeJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq9EgAKCRC7dyhM23N6
 3hr1D/9oIctf3jZFaNFf/Pf9J2Q7CfddVWZ2nNZ2arIAM0OUwhaxiAs+LtuvHStvp4Lzy79OaPC
 MNsK4RZArZ79NaLPOR9S5E6dP8SihdNKm23FpYWS8kmNKUvlpnvUn96H2Bo1thrOScdtHk8KXo2
 7hSeP/+8USMLy/ZHr2ShtiB+g1UAd176dG+ifwhSmAAgPmd16B83riVzBB/kFOwP0PXrnOHWCVg
 NoyCSnhFa7Oj1iHgWlBLPNUv1deka5wHUy7CtHqHc73wIsD+RDeq2t9Dnauotw051GQYm18pWKa
 Ro4mNfaV4/bgXOl+EindmOYLeL4vmRfgF/9ZiKkyjLjZcj7FGt7HsIhCwwbT/u2+A8OkOyGoZYi
 r1Iwow+abKmLmqHeqRIFjne6kQTJb22jxEEb/ezTHqlg26zjd2K/Z1L1frMnEuyd/6lmTpda2my
 KRnfdxmtZtL9QDtYOyUNtLuaOuwzNTTdod6HZcSVYGSUrQl+jbcegXb4vAnwsS3vURMyxjiGKME
 rn/hi18xZaZXcMv99T6EuayIMn8QHlfKaxv/XQG2mzCxdePpLOJp5QQlK322veGWDifJAyrkoRP
 XWQu7Llfgoiq2whZiWSbBSEkh55X60dfTNM06+VWWl86F4nrUoLaQGJti/70J124jfGNFISbW/A
 zR5q4Zf8lKCRE6g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_163901_465943_CF3A5E6F 
X-CRM114-Status: UNSURE (   9.56  )
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

On Fri, 10 Jul 2026 21:26:15 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
> new file mode 100644
> index 000000000000..eba55f8a92ae
> --- /dev/null
> +++ b/Documentation/PCI/liveupdate.rst
> @@ -0,0 +1,29 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===========================
> +PCI Support for Live Update
> +===========================
> +
> +.. kernel-doc:: drivers/pci/liveupdate.c
> +   :doc: PCI Live Update
> +
> +Driver API
> +==========
> +
> +.. kernel-doc:: drivers/pci/liveupdate.c
> +   :export:

I think you need:

+Internal API
+============
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :internal:
+

In order to include docs for structs such as pci_flb_outgoing, etc.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


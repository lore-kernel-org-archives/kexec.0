Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C3AC44516
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+DUQOwOw2uIV4ajc2HeXFDWOg42tRR4f3JX3Z/V06A=; b=sADJeTurE1AiFrO9rAK6cLw8VD
	2q9VD+apYw60Taevq/zoCdEZjgTOJJ0uCzmMIhRlD/+j0VdrqUzGARvKHyYovsOt0LopxsRD0TD5s
	2OQu1k9BIm3ZVS882B8XTxbpf2iI6rPE22Czryxu1H9faz9SmhNYQQoWRNpMDLT60feViHz0dXbUJ
	xPG1dr+0HiD0TtpHm/78/UqZjOnMNT96570I2yXKCU9dR9pQ/kWDnPc8dqRm5sWdut9nhu9tmxK9U
	Q13Sk0D+pVuB5XW1vaTNuLkt7CRxF/nL6IxHQuqJF689vVWTxgF8eD2JMqq93/Nw4KPako/G9kraS
	HZh3Se9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks2Y-00000003P9z-3iQQ;
	Fri, 17 Jul 2026 23:32:22 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks2W-00000003P9Z-04X8
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 23:32:21 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-92e85499ffbso399108885a.0
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784331139; x=1784935939; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R+DUQOwOw2uIV4ajc2HeXFDWOg42tRR4f3JX3Z/V06A=;
        b=YhJAFG8mF5nH1V8+/JHLId8itMVnLsIhJ+ul5pmH/AxfqY7nayHvcGxHRk0DS+ChOB
         3r+kyhaLAcwUGgDu41TiSVGIeOpkQ3RuqjPK8spcD49CU3h0kT0u9nwNT8MV0/2lMcxI
         YEIUVM4cIRLj04VRbXNRVAxqD2uP6SqGrS1Ntwr9Lqn+rvsP7UWh1wbLn7YdS33TeXB+
         5InieXQYSXgvqVzY3IBbw+1IMrjBJADq7Q6pGVDnLvylqIt9j7eWdwp1SUoNqAsnzk+L
         zd6tL5yLDABjCRZA0Xj34YLVeguy82l2lie+FXRevXPlEED15AEbg5ZN7FJuZBeOEAqF
         kluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331139; x=1784935939;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+DUQOwOw2uIV4ajc2HeXFDWOg42tRR4f3JX3Z/V06A=;
        b=d9m44QDSnYs0+6VLFp9U3+qz86wBkxJ9+QAUD7pTIh7V7//oWVeprJsBOVVTtv5J3R
         IzRBQ7Hlvj2yloQtCSdFYJgzLMpwYVofrg0ULIODvC6J5eO8u0eL32a4KVGacz8DRGrH
         ocem2d43U9c2PGdBNcnTYEFrGjzPsfxKjNDK+nDQ/MrY3cMIKscdIKr3ZWighTkV+Lwz
         YM2LEI3mBhXjBeqfA1UaCWXShwCgY0Z+cz7PqzyVl5/UpQBFJoL1Nm7PpGHpwU89Rvzz
         OV9bzsypceSVh9530RX7AKdxYcgw0CHA7D494g2TZYROVAh/u/d7Xp00Ccn3j8afNtjz
         +Qvg==
X-Gm-Message-State: AOJu0YyRjQyhche9rxQaAXoIsat7QuIT5/34ObxihK6gSl+6tGHBburj
	dzPJwWksrTDfSdJ3Jty8KIq2W1GKCd3zTJRpeG6Mc4umPG77LdcAAJOwn9azyo/vCOTCY4cj9s5
	5q/Fy
X-Gm-Gg: AfdE7cmz9JSDB0OwiQhr7rYbnbRktWAtySNfYKvYwI+UyxUuCFZJylhkWtm2cTdfFow
	owXJp1TzcJgS2/YrI3d3E8OcCV8dHcfkTJBaVmqvZtNwts5e3C7FXg7+OHdqGj1DKGTZ77NRId7
	rh4A9DLwGJGcAs7I1TBHieR0xPuxHNESExtNv2JsAjttIO3VoxstDS4r+CgIA/6F4ISNmcSuKUd
	Q6RC8PW5pQpgyNsd9R8Io1j9d8DhcFoSqHzY/Auqu3KAbomxUPKtN4Twdp/1QvIoHwgla/bZArL
	4csxa5ioJQI+0OqOGw3xrwpI2aKgX51hXvWNj3C69OE2WRcrUAVCq36U+4F46wmBW98WEeJOQHx
	VSWN6UxhzMSkpTTEG53TCf63fYILMWh40osyzVHMvxN/W4F5z+7fmtpifnUr1kdMPyTVXDvbAYK
	dvOMUKSs1NvEBi7hxeZgL3dPjKtqSoXljmZstpsdc=
X-Received: by 2002:a05:620a:472b:b0:92e:f3ca:2ecd with SMTP id af79cd13be357-930b41a0733mr524243585a.60.1784331138856;
        Fri, 17 Jul 2026 16:32:18 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm279957485a.35.2026.07.17.16.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:32:18 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
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
In-Reply-To: <20260710212616.1351130-12-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-12-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:32:15 +0000
Message-Id: <178433113516.189683.9930130364443329744.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=563;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=s0LMm+OcoPpmqRB57FW8WPIACTHAgSpt/ofOePUvqwk=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWruB0abwGG0XPrEN8HQE9RCrgd8/buD859gp2
 KaKebSgf3WJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq7gQAKCRC7dyhM23N6
 3mj7EAC6bErgn8QbHlK63bz1p0Z8+rEQtPpeKYfyZoG2uWv9cDi5gkXPAA2cyXTEg8FWk+3dxwk
 y6gytV5WrSayDd6GSc5dQIvNqT/DfySvbzgAES3hjQEYplR6GGXtAvSOJrQm3brDRl3OO/+Jyt/
 RWwegnDu0EtMTwd45jI8iO64zYNbU6iXPDmoo6XX85I5an+0rvaOq2+751osnajpvrUctCRX6co
 rct8df07a7hqEr30tX3CdeA6FpiPhXcSZdcc7Y/mdkIvSPqDsKQWLerNa66FSM/YWQRJyQz75aK
 eh1RdPuqTNnMgn57asyEoYg5pPIxn2wSy1R2+6bmZnsj7Bfhs8kivkdPulT2cq/+tDvb/i1R8cg
 JRhN3kONqgHydgwy6TrTDZQzDKLE1v70UqFkEmihAIJqaxEBEeMylAu3uuCt/3Xf/N8ePqlq4p4
 Zl1+UFEzR12poe688gj93wg/k5DYz12wvCyUaVd1ftxDmqLc5IbkfD19MjDTMA2VHhZ2dygKp+5
 jBzpCI2Ct6WYvMfudLSRjaT4vueHL50oW8vh8gE2xIOaoOwkDXSTmru1jcXLEpWZBDxDnjbHWx2
 A8HHgGX6czH1+b8pT3wyIyMQzrFYbow7ruhbDMctEsSZ9cOZE5vkRTllxa+Bfy5AWxoJFldiSFq
 vnDsQy6niCySu6A==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_163220_072813_66B89220 
X-CRM114-Status: UNSURE (   7.07  )
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

On Fri, 10 Jul 2026 21:26:14 +0000, David Matlack <dmatlack@google.com> wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
> 
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


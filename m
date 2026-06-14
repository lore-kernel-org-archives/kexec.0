Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65531CD98DA
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZeAw+vIhY6bA9mSRruzAQBCEt99MDj9JV/iQLow7qBM=; b=H8TZlQmd1U98hOY+AVg97zDO05
	q8VDvK26ahDqjL5t/AEF5eo2xdnRi4vQosGwOA2jLJ+fNOezRu0h2bKJ/qq5Kp5nCJJM7rXhEZqx9
	P5VSeNBlWfIc4SvqDsznC+5eCdpqOh6BtGlJEd1GxpHPjBjVXwyWHvYwwuPfabUeTElSkX+ZDiKMA
	8AzZ87ii79HYXBBsncGm5XVBUJf4l/8NXQWwvXIAZsOg5slqWDrmXvlkJlzpWit/n9uEimObWj4pQ
	wgMeCcbG6VWjeiCAAJUp/rZpMmPU9HNBcwM+zoY676qplq2igzaHg4FDVsMzE/uzqRtKc/btLMPwg
	P9Nop4dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYl5X-0000000D3CH-17Ek;
	Sun, 14 Jun 2026 13:41:23 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYl5V-0000000D3Bp-0tst
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 13:41:22 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-915d64fead9so365332285a.0
        for <kexec@lists.infradead.org>; Sun, 14 Jun 2026 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781444480; x=1782049280; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeAw+vIhY6bA9mSRruzAQBCEt99MDj9JV/iQLow7qBM=;
        b=CotNUvy+DWPPd76Cg4iQAhU8V3MGeq+YlJQt6Mu/zd3iD//GmvJbikVSCe+7+PPbHA
         o9Z5ntTQ2c3K7W48Gvf2My6Lv4kpaMbDYaRyFpKsINdDWUXlxWNLScmnWX1imWV2M9HB
         TcSugRhWdyfd5S64UstIc+Fm10TDBxiJTm2U1AOohRpKok6seclD9uYRJz6FTulmopsI
         Juv/RrKWD2my2ZTxRgt+6TXRT2MV2aOAp02XE0vjtSPPp2vUu1ZmlxZ2Z4Kgmx0b+rN0
         Og3hw94rnFMKThgBuHuLpKRO/t2UG5ApwgueHSZNQw2Dw46u6LVUWyGj6yXgSIbJ77TF
         TP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781444480; x=1782049280;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeAw+vIhY6bA9mSRruzAQBCEt99MDj9JV/iQLow7qBM=;
        b=K53SfpRKUvf7x1EN3PbBVK6bFO0zFbtv1ulr7f/beNhm0ub2bDwCGc2FQpf0XPfvFK
         9ThYVi+9R0fFUbXFU17uMM6mZtt4QylEiz8dJbgIS96OICXugzlSf9uTjkM9AOjotEQ+
         x2fPueyIqa9XQ3SYSLVtBALkyDqDAxla/3EXh6ckOJ5MWfEwDTE92Hdx97tr8DmluA44
         O201tA7mV3PSTFb8TlW0gcxvZegN+XKqm2izAV8EYyYuPfAnaCh7lhqtJG1/5HCObV5w
         GBSAvKMoXfljRV/IH+CwSbwtSQTsWMOpSr9aW7v8/ZX7gE/FqW4JlP46EFThCjR6C4uk
         CwNg==
X-Gm-Message-State: AOJu0Yw1fgftHsNovvhdBvkJ+VzAnsFfSnLDygf+SomdbxHEM6XRXySv
	LqsrBWweV//qCdtW9kAmJWXYKT74L2LY9zMCqirwfBvjNJOW3JJToLQSpp/7Q3RhcTg=
X-Gm-Gg: Acq92OFdKej4JUkkZkqZ/toFCZld64fciRkWsk5UVnTgQJgTt+Eh7sogsNW+vtY/btp
	WwmZEbm/7PKpktFl2nqbiLgWxDTzIH4nkyxY0MJZKYHy7dypxx3fCRxw3VKiSLyehd5EUuTdyCC
	XvJN7ZV+M6Xp4LCLBxlZpVRe06XqCfvAf5hdnCDSWPULRGm7kFEsrdFAQLety8xuLyGuh1tDmld
	J3yq07H3NF9KkHckg7sapRnPuKYTVhHGWEC0pJUUjLwFysasgvRl1971po7ZXKXxzNoeWU6OPKN
	/C/VvFQyv00P42Ku9rw2Hp+dLaHsmk+3hsdPpUJjRyO/hdmi+wU7YnwsZATJ3SnaGNkNyX5Ss/f
	ALKbqIOw1PdMrkXMBteYVzkxaHEP7ACdniGbvwYdAHm3rB6FS92w1LK6k7fZsAAqL/uX79ElfAU
	88TxjMUvFj8tAwCWLpgC47zwl1yxxiThGiovcqltvZIT448hqkMdNN5XccYM0ZqHrPmX77TYI=
X-Received: by 2002:a05:620a:284a:b0:915:80ed:8327 with SMTP id af79cd13be357-91619f73cd3mr1359281985a.41.1781444480052;
        Sun, 14 Jun 2026 06:41:20 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a00af50sm804255185a.30.2026.06.14.06.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:41:19 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
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
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-5-dmatlack@google.com>
Date: Sun, 14 Jun 2026 13:41:12 +0000
Message-Id: <178144447224.1257322.6028717050680465656.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=436;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=9qCCo5jqZNYTFQYhvn1w10HthvCojM5bi7HQ3wIdz0Q=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLq9+V5ehmqYdW7aqY5UC46rzyaBztHZtTXaEV
 wNq3cD8aFeJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai6vfgAKCRC7dyhM23N6
 3n8VEACd7+ln+qHdtrY009zcX3HQrr1PUWTlugPorIeOn8XmTJbgYuCm1D7mH91o1Qk0SZe2+wI
 2S0wRpAHlKaOVEtO68gKBmhZPDreEUWbyJPh2baoB7PEM0rHohe6beLyk9a0EDGyMoizfUQVlBE
 elPL2YdcMN8btmVGap5fkjrisPb/6OsmU2lUYZ+KNnAx38aUZVcUvKDewIbq25zdwlZBUKGecSh
 As9pDuvz/CVYl/3F2pe1wWh3q+WvNwNasidlW+NrS3zSIJVb0xbHv2NXEnOUJcJ127swxUuqvNJ
 Q3siNX2gD5B3zi5rElvySm4JdLzs16A2WhlbSrwn1B93becCXOtZ1Opap0noIZ3rbnK57eIq2nD
 pYRAwOqOK5KN423EhDkvTAWZGYyxMC9vWQBfaAa49JbYobhWtvnGWr1ezCJ8k8bEcf4RRLYXcoN
 8xYz7NI1pblzXU2nq5qcyacPiWBzU90F28R3+LuI6wz45GMTbHQZJynLNwaWubYDsQjEZHym77Z
 X+89BTifV4853SOCW3d5PdFyp+NqcbzEkiRaNg8G2v+FxPzIY5B2QAbioj9U4pY8gLM/BoLASVh
 xtPEpIr93n5If5K9gYKxSJDWp2YDmXIBrR1LD3sDnJ+q/TjpSVubUA9Pu3yUcMq3lQZSfZeqnKo
 h5XFZvHeHeKTbBA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_064121_374917_3BF65E6C 
X-CRM114-Status: UNSURE (   7.19  )
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

On Fri, 22 May 2026 20:24:02 +0000, David Matlack <dmatlack@google.com> wrote:
> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


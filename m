Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04315C48BC4
	for <kexec@archiver.kernel.org>; Fri, 16 Feb 2024 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UhWJvuFL5sB2/0dNo+dt6+LCCgLFxWWMDPXVWOfDRbE=; b=SosDPIctD+Ba/T
	Nh73Ox+Y86DI5UijcVPMvvZS5H+NHD4Mx69jrGFxPQlZjt7R2ep4LHkKeaed3jf+Bx68KUhA5utVE
	6E7td2D0B1s03B6a5IljoGfoaZ0aTAMlwbZLNVyuPA6nsTGXxJbS/ByfqfHlImA/8Yh3yNfW7PpOe
	qqy/vE/zxu2olRzPi9ys34pUS2HUn6srwFuYvAfFcgg9ps/sF02U24n3uFmkQTe1vAxEpTW2hbBOw
	EJU+kAnYkXgpHRJFTh/qglPfgzSmnpjMvxP1cZsq/zpK39LhUIPWu84ulH87Jd4Z6ybat9qf5g7RP
	m87hKZnCPfoqK7zKem3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0Hp-00000002qsK-2X2r;
	Fri, 16 Feb 2024 15:38:01 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0Hn-00000002qr9-0Jb5;
	Fri, 16 Feb 2024 15:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708097880; x=1739633880;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0cZh71B0l8IG4uZIp4OIszUKFw5xlrbFMIKov5F9rMU=;
  b=uWA6o3gJYBT0v1Fu+62uED0Yh0WDIBtYUtrv242a4JSjL5Syt7IAgMOY
   c/d87e2aJ4dcblxO2ahsFGD7K/Yzc6sv6Q2jYRAlH1rMqGueBC9a1xWG0
   tzu6QpGRJYQ0U3yCiRKwrALzxha8tcILOAjMSUvqye9v33ufvF7kl1PVX
   w=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="613548127"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:37:56 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:15970]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.23.202:2525] with esmtp (Farcaster)
 id a4a5ea06-05a2-4ef6-b192-ef4a9bf9607e; Fri, 16 Feb 2024 15:37:54 +0000 (UTC)
X-Farcaster-Flow-ID: a4a5ea06-05a2-4ef6-b192-ef4a9bf9607e
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:37:50 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:37:50 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:37:50 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id BFA7920CE8; Fri, 16 Feb 2024 16:37:49 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 05/17] kexec: Add KHO support to kexec file loads
In-Reply-To: <20240117144704.602-6-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:52 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-6-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:37:49 +0100
Message-ID: <mafs0le7k8lo2.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_073759_291858_49411682 
X-CRM114-Status: GOOD (  15.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Jan 17 2024, Alexander Graf wrote:

> Kexec has 2 modes: A user space driven mode and a kernel driven mode.
> For the kernel driven mode, kernel code determines the physical
> addresses of all target buffers that the payload gets copied into.
>
> With KHO, we can only safely copy payloads into the "scratch area".
> Teach the kexec file loader about it, so it only allocates for that
> area. In addition, enlighten it with support to ask the KHO subsystem
> for its respective payloads to copy into target memory. Also teach the
> KHO subsystem how to fill the images for file loads.

This patch causes compilation failures when CONFIG_KEXEC_FILE is not
enabled. I am not listing them all here since there are a bunch. You can
try disabling it and see them for yourself.

Since Documentation/kho/usage.rst says:

    It is important that you use the ``-s`` parameter to use the
    in-kernel kexec file loader, as user space kexec tooling currently
    has no support for KHO with the user space based file loader.

you can just make CONFIG_KEXEC_FILE a dependency for CONFIG_KEXEC_KHO to
get rid of these errors.

Or, if you foresee wanting to use the user space tooling to use KHO as
well then you should refactor your code to work with the option enabled
and disabled.

>
> Signed-off-by: Alexander Graf <graf@amazon.com>
[...]

--
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

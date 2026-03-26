Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC8710AB827
	for <kexec@archiver.kernel.org>; Thu, 26 Mar 2026 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=; b=YdW8Q78Vg3NmjYirxkXVTPd+MM
	/cIq8hOCS1mgM+MzHTPtsbgwXMix3cYFvg/7ag3qF/O9EJfuUVAd2IP1u/VQkdCxkWtPW0R4aEQSU
	V1C2QjqtcnNb/2LQ5+3Kcl5XHA19LieDH4hJOJFUK6RwJcgJ4KDwlrxOsYDvO2s72lH1JCoILcu8C
	ztFfsKGWjseYMf0rOLB5iCO1nsC0v8wnqZBb+L6hUcIGCxYmT5HjWIdZMFm25kdYhs2k1N+M2FmAr
	UuI06v7QSF/MrrURKq7XIwDtkbPs+SoQNsTZVZsc9R3rZrzddjtNLvqkDyaVXVFltMjLtOztvWXwf
	XTrv+dew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5rYh-00000006Bng-2OQp;
	Thu, 26 Mar 2026 20:44:03 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5rYe-00000006Bn9-2b7B
	for kexec@lists.infradead.org;
	Thu, 26 Mar 2026 20:44:02 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so1639852e87.0
        for <kexec@lists.infradead.org>; Thu, 26 Mar 2026 13:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774557838; cv=none;
        d=google.com; s=arc-20240605;
        b=lnJTKPF2YB7sfy/bYgI3O15OSMY0La3I+t44Y45flfpYdIM8PEKhqcY4/RAqWuwds4
         r69oKd1/epPWlMXSoQxaO4+ixNvDmNYOjcG45cANn4LoqbL6Hy177TCYo+KzKGn2Z5LB
         5Wxl8Z2iV4NJKGIyKGuiMrWgBAIOB98ahqvk8UAdX1ByXz/n8omF/zsPMyTrcXLCzY1r
         w/wkaJgsfqiwx+d5H8s3thnkaRusdxR2Q5DXRpMKzZ4b1F4Ks5GzSQPuIf2yWXG7Xzts
         09MaalBaWYgYDnBPykOnSUigOp679Swo3GlU9oPJBYdmUsNT77c96+VGvPdWQERVoniv
         3dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        fh=RJpqlwqoSFE7sg3PF5nh75w0visblMZWReR8i/+7Zxg=;
        b=CoRkaWHvmJDKnxG0H3xhXlnqkupiZWJ9rCcIfGG0YWpXrUJ/6PmMHJYKh0UbVPeB6d
         FAoNdV9gEmCXbBCwK7bwAfZSp/px57rzJ8bvzcH8Mel+SpQYIMSYkM70SPXwWL2k1g0I
         aEqt4oZ1XdNJA/iC5l/7wy97ik95RxYgPoxeuwlRtNk3QHKcKMzkRBV3/+9F7UeNSplS
         l+yS8uZX+E46aahWXg2zz3jWrSb0QYrLyh7MAhIyY1+E7+yMTIYbyIyLB2XbSBMqHdo4
         atlBB5YkUUZSQ0/IVgGy5IpaMAKzMogcecqMPCVcb3ycml7gZqa07zaWhORUwa8IIF3M
         pLJQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774557838; x=1775162638; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        b=TH1RBKkInVEEiGEqwXVcINjywIZYwkLALKRzeNfbBFaRAuWdOoGN8GVJYQG10T56z5
         p+A6EbTj/8596xIStwVdynVhIO4ht3E7NWoLBAuWbNGdK/5l/GuM20bMF1E8Wrkxj4oK
         oO7srDMxqAOtLFUEN4GOBQgY06MJXVAiPBbpbAkdALzIoxraI9eD1blUV7hixUsoSLPo
         z1rpoJYmzwAjMFVLwv0Ah7b1o2ExubYdw0OCS7DP+6FqzEAtrKq9uHqKXP4MqgAQVJrJ
         TYCOOq00q5/hMTnrkGWc0iepJND8a7wDLL1Ec2IjExFGT59la1QLn93CM+3rowzeOp+A
         9Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557838; x=1775162638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        b=YKqprptPO4UwLLHUrQyhK2YlnOUVHZkNSEnMrujybXdlGBDfDUMgLDL+AZpHVjSwIx
         ZVWSR4ozdOmQgVBxOncvli7Gn/gFJRtF3UFX3Sqjp34kjUgvcAqggVWMWz49VTb+qQas
         U0/IW1t5ZQZveI13xfC4ioPyDQ/8W5aKWAZ+jPEV0rgLz1qqNEyEDu+b6JrScRUz26hQ
         lPGXmgGmbl5iYz+brTAbx8dY/sZn773LtK5OevXd2AjokLbyZE35Z5v/QFlXrthVwJSC
         pkWGEClJ0TG3lp3ZeDr/yhdwRgH4RgoQhyhsql2HTDNsYJdiR2iv+iZoeXcD/WSn6ob3
         b7rg==
X-Forwarded-Encrypted: i=1; AJvYcCV2kzC7k6RVOmr6sLoebDkQwSckUMNgdR0BiVctArkENSbS9VUJliqzuSwiV8aMa1nX2mIffg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywyq/zV4IqSAdyug/SLNG+lc6d3i+i+8JhRuBCAtu7POu3a+VZR
	WVSmpozzYJd0fmHN7hexyePqNNq/dcK3G3h++HWf+u27Lkeb17JXhzbYu/RQbvkKw0Kp1bJhy8J
	SB8vcBoqH0FZf6cuztAsnN4UGnWJxCCx4YIHKRIqj
X-Gm-Gg: ATEYQzzD9LPIGzUvW1oe7E2+75rfFwtdJ4dNDx9BhCVf4Px1CyYM65bNS8Z2/Hb4Hva
	JAbwz2Mjdqb5bLUazTN4vpE3VWzc+x2vIk6MpyX2aa9CcHUHEC67yArQ48n7abb9c2TS7dsh+fS
	TUwDHOs8pFHVbFwI5xmQunAaKCSw1uRvvx7tSt91aZJd3+3o1Y9TCH7rNpkmXaNEpeOw9BC4B++
	RjXOhbpiJdmw7TqgxOnt9BPqq0zEU3Eq5nmY/eS+IRPvxULUOxNUSF/bfKKEh2+sSZDMYVqyc08
	0466zlvH
X-Received: by 2002:a05:6512:10c6:b0:5a2:a5e0:2da2 with SMTP id
 2adb3069b0e04-5a2a5e02ec7mr1094413e87.8.1774557837156; Thu, 26 Mar 2026
 13:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 26 Mar 2026 13:43:29 -0700
X-Gm-Features: AQROBzDv95n65Jfr7km6DKOoUBuRrbrSOHrGu-gele9pXf1C5O1laHd_UCbivjU
Message-ID: <CALzav=f4--Kp5vXz5zrxZR3WVsa9T1GF4NFFtuf_Q5ESMHmWwQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] vfio/pci: Base Live Update support for VFIO
 device files
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_134400_735545_06E7E016 
X-CRM114-Status: GOOD (  15.46  )
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

On Mon, Mar 23, 2026 at 4:58=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> This series can be found on GitHub:
>
>   https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v3
>
> This series adds the base support to preserve a VFIO device file across
> a Live Update. "Base support" means that this allows userspace to
> safely preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
> and retrieve it with  LIVEUPDATE_SESSION_RETRIEVE_FD, but the device
> itself is not preserved in a fully running state across Live Update.

Apologies for the large number of people who got added to the CC list
on this version of the patchset. The changes to
Documentation/admin-guide/kernel-parameters.txt in patch 4 caused
scripts/get_maintainer.pl to CC a number of additional people due to
--git-fallback. I'll fix that in the next version.


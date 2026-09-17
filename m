Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8125EC88E72
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 23:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkBkFvNjZkmBQ+ciR5KjrTSHBNZ+IYK3WHfHxYYYMK8=; b=sH6LXpg7nneagMWeT/VAK7rAPe
	+YMZS9e+RME7T9rPjRnt+lFwWFJhGvtMIl9cJ+1GWSxH0aTIp2U+76eyRcyEAQi4dV6bPi1BaitD7
	ZXnhzirXv29RJ3kccHygZUByz1X9WVdxKfwqZ7OCaMHK9MRmKGAjhV9074/YLwYjgJ8TGwBIVs2dc
	g7iHgtHQ0hFPwuI9l5RE5/z20ezNm+YRDAhbItEvxJvhR0O5Zsg9rG/+hP2wmSRREQoStuBrUnSb/
	yCdegJ0BP6IpWP6d9yMfoOLoLOk9PWHyO/q42uMI5hIUe7o0qsIU+/VT3dy/gKbLp+rtNXVNhGIbz
	AWFMhUxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LD0-0000000ClYw-08gS;
	Thu, 17 Sep 2026 23:08:02 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LCx-0000000ClYA-0FaH
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 23:08:01 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-398e9698a70so74279a91.0
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 16:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789686477; x=1790291277;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KkBkFvNjZkmBQ+ciR5KjrTSHBNZ+IYK3WHfHxYYYMK8=;
        b=PACGPb0Kq8YuBy0R0Nr7TZHrsGEoySjeNJh2bMXFgFWJpZOV6pdkh2KISgxHdPQjFU
         p2V4TSQvK1jIVwFm9hJZOlZlACciTVpqBWM04M0srEE6qeRIbStNTW/aaWVr38xYR0Ui
         +0fKTITn9MyXnpeR14MSyvNoXFf+aUrHcpT2Xjb8y52PqkTrygAo8D2dMKfSdAW7JbiX
         VmmWU3CZIz9oFlMPd7eqKNwD0MzW7diFdiLWFYjVdZ5U0wNFG5mNZHbYEqAKgYT2TMKi
         33VF/wBdpKyAdgenCtaqz4DRW98YOIg1kc6MioCaP9F1mWkGtxuuXZsTIqB1+SHOZXqD
         6RVg==
X-Forwarded-Encrypted: i=1; AKwUvBxMw5K++n9doY1rNTd9GcJ5IXOVtdLcY7iaC9Bz+QtkWzEmgqdQtMWoQsMdlmpwXVDmWvWfHQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nNphQdMWP8E4CuCQoqsJ+3ViksanjdWKAC5uRZ/zx+rjoqizNQ
	fsBj+W4FWd+pRCHqPwrO3Pyvl9uSquX76fEoo+u2HT7FoLSsIwge+xg/87UjUH0vRVS8U0D43vE
	r1q00/pWPij9/QaTWQ3co73565vG6Ya9C2yx3mJJzKtCV/kEIbljqF6jXLgSShUsYir13lb87w1
	b7ht2ktPC9zLHXBeX2eBjWFsXNMW+BhFR5wDCWtnucAdT4zlvfh5vB9zGUedIRc9hnJOhxKD7dh
	Q7ugns3LgcRnfeutymJ
X-Gm-Gg: AYBFou10lZWbuSCcCrNknrI+VNnUM/SjtToYwTIGw/rBsCshJ3DPS1JGJ1QnRqjcDcO
	V+mc73YfhVhHMpQXQKDX16cEivXbrCvN70Ip8qy34HWuQB3gZvtPXjFMJ8pbPAj8F46toL/sWxV
	Tf8uqAlU2tGQJyIymjLTPv/Nm7MLyADQvQPiMduUB1inPCMfbH4K72IYnbBUe3Llv6Z68QSvTeZ
	yVUFEKz+rY3ycyXwT5BfK5toSsT0nVu2+GkGMTaU72V4UqE2c/l8CsS0qUu2sCdARuioFrk7Oor
	wz31KTMu1L/0aX6kXkFz2MGytoG+0WkBu9bhcB17jlbRmFveDPSkV343XYC1hHU0UNfvfcyQAaa
	LkQ00xIDlGBFu7jHv4fvWPe6ixmBSmqdlKiZDXHmcePGAfcAv4d99ZZ6wiAXgjt0fTtG8m7plFi
	6ys4s6QMeqdZpv/98mwfqF7+QZOMTjKI/s2fKf8vTR
X-Received: by 2002:a17:90b:4405:b0:39e:4c80:f681 with SMTP id 98e67ed59e1d1-39e54f430c9mr1196410a91.32.1789686477191;
        Thu, 17 Sep 2026 16:07:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-33bf8a90d01sm305050eec.5.2026.09.17.16.07.56
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 16:07:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc2229450b4so65202a12.1
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789686475; x=1790291275; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkBkFvNjZkmBQ+ciR5KjrTSHBNZ+IYK3WHfHxYYYMK8=;
        b=MlV4mEEvnFSH/3Na3Y7/Y9MyDsEl1jfitYNb/EZ1fazMSbmgFV6EJrSKsiJQ9ZuFvf
         tRh15XLGjyyRnnjj6KK0gFE8Z9wgVn5hKh6BcwwhpWzxNeJJ+Fko3ec2Hkog6UaruKJk
         Yvw4z5zlIfvERwaZFq9q/KOXMh60iVNOJJfIE=
X-Forwarded-Encrypted: i=1; AKwUvBxuCccPjCBTs6lRrqq5GycHQY5is7X8MuM5m1gwyeLDMoXXIYEVpqE+OWr8YUJy2Px6TAq2EQ==@lists.infradead.org
X-Received: by 2002:a17:90b:1e04:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-39e54f3dba9mr1123045a91.31.1789686474955;
        Thu, 17 Sep 2026 16:07:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1e04:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-39e54f3dba9mr1122991a91.31.1789686474393;
        Thu, 17 Sep 2026 16:07:54 -0700 (PDT)
Received: from [10.211.247.235] ([216.221.25.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf596e1f6sm21060020eec.1.2026.09.17.16.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 16:07:54 -0700 (PDT)
Message-ID: <58026818-7737-4560-be64-5cf22f2d8d69@broadcom.com>
Date: Thu, 17 Sep 2026 16:07:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] x86/vmware: Preserve panic diagnostics in
 vmware.log
To: Zack Rusin <zack.rusin@broadcom.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Petr Mladek <pmladek@suse.com>, Joel Granados <joel.granados@kernel.org>,
 Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org
References: <cover.1788414671.git.zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_160800_042377_62A33B87 
X-CRM114-Status: GOOD (  16.29  )
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

On 9/8/26 11:07 AM, Zack Rusin wrote:
> A virtual machine may have neither guest-local persistent storage nor
> working userspace after a panic. The host's vmware.log remains available
> after the VM terminates, and a production encrypted guest is the only
> component able to export readable panic text. Hyper-V already provides
> this class of host-persistent panic reporting.
> 
> Add a panic-only VMware logger that copies the newest 4 KiB of the kernel
> log and sends it with bounded low-bandwidth RPC work. Ordinary guests
> enable text transfer by default; encrypted guests require an administrator
> to opt in through kernel.vmware_record_panic_msg. A separate late dumper
> reports the structured crash event after built-in dumpers and suppresses
> the event while a crash kernel is loaded, because a configured VMware host
> may terminate the VM before the reporting hypercall returns.
> 
> Patch 4 makes panic diagnostics run before kdump by default on VMware
> guests. This follows existing platform uses of
> crash_kexec_post_notifiers, with Hyper-V as the closest guest-reporting
> precedent. Unlike Hyper-V, VMware exposes no capability bit for this
> behavior. An explicit crash_kexec_post_notifiers=0 still wins, and patch 4
> can be dropped without affecting patches 1 through 3.
> 
> This replaces patches 2 and 3 of Alexey's v2 posting:
> https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
> 
> The intended merge path is tip's x86/vmware branch. Boris please review the
> VMware transport and policy. Petr and John, please review the panic-only
> dumper use and registration ordering. Joel and Kees, please review the
> sysctl. Baoquan and the KEXEC/KDUMP team, please review the 
> loaded-crash-kernel guard and the default in patch 4.
> 
> Zack Rusin (4):
>   x86/vmware: Add a bounded panic log sender
>   x86/vmware: Add the vmware_record_panic_msg sysctl
>   x86/vmware: Report guest crashes after kmsg dumpers
>   x86/vmware: Run panic diagnostics before kdump by default
> 
>  Documentation/admin-guide/sysctl/kernel.rst |  14 ++
>  arch/x86/include/asm/vmware.h               |   2 +
>  arch/x86/kernel/cpu/vmware.c                | 245 ++++++++++++++++++++
>  3 files changed, 261 insertions(+)
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935


LGTM for the series

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>


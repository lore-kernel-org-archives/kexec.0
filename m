Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A50C35FFC
	for <kexec@archiver.kernel.org>; Tue, 25 Mar 2025 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6R9zA86q92q5KNyTPt/KezT2KM642idnT1llXfBvGGY=; b=scN4vu5BtI8uBHsILcWNeLqM7K
	n8WahtDRn52r4EZIo+LnExeHwcPo8eeoNjkfeu1oJ9A/q0MvwbJ7fYdrMrW6VQxJz/toJYM96VCvY
	iSWsThra1ukYywbJ7Qqz1F7aiuV2R8aMUwYFGE666c9H4klYZr2pmA7rGqtkLLGWyAsnijL+hTBxH
	eo7C7/HIv+sHMjoMDrnyvlnfuF/Y3brBRF20xz0ABVS9ASwhAz2QRBxzv3U2OosSyY//eyixVNcJT
	WMwlA+AS1zU/gOfEqfQie0QNUF9MBE88osRp4ldN1ojvYXEIeN5i953BCMqSN5Digh5IACjtEPDL8
	YtA74Mgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx67v-00000006K9A-3m90;
	Tue, 25 Mar 2025 15:23:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx58u-00000006BQq-15OU
	for kexec@bombadil.infradead.org;
	Tue, 25 Mar 2025 14:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6R9zA86q92q5KNyTPt/KezT2KM642idnT1llXfBvGGY=; b=fD6c3rDjQaa2/Rf3njxll1/Hx+
	uobDJP/mOfUy78l9dxs2DaZZhoYnRhwCS6+uvoJq/gJr1n1dj4APXtsHahs36whZOKtOJrIM9YU7p
	vEHD56ZR9bBPi97sePNixd11wBYJ2y7C7YHmUJ9ncWbNfDGHyiT6YuecMlILPcPGqkPI7gOqDcS1x
	yOe2/0NFc7D1mbquaGg7zU8dPvoapQcmpjmFN3gwZ4BdNSEavcRkHhrZORXf9HpJcpt47A+W6HkAh
	wgK3v4xoPxs30uDsFQIJvIZpHDieZl+qcB1kjXJ+wGparUKikzPzlepSlYnhkGmWlVtdHxMU1KxLX
	SyYqBEuA==;
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tx58q-00000005VI0-4543
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 14:20:35 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-47688ae873fso57620811cf.0
        for <kexec@lists.infradead.org>; Tue, 25 Mar 2025 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742912430; x=1743517230; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6R9zA86q92q5KNyTPt/KezT2KM642idnT1llXfBvGGY=;
        b=ESZwnXi4vWfsCrCQB7oEbfPPNvori7VAW08K0rPoD7UCENbL6p/wQI8FZtCaro4jLb
         GbKbKD90UzzezuTbgCmSShykuVzmdgFpWOQPXlePCBnXWQD4vnGYJbVcGiBCUVPnWKkF
         scRZs/k1KtmItLZQpUYvkYhndp1GEToXVDrY/1mhIZppUioyE9uTtx1Gls8C0amSu+ao
         cYyKLk6/ao22qLK3qz8bzaiJPa4IQntqk9hMi8Ovhkm1MKe3DH5GXap8TezTm6gSd+7/
         xrWjzvfQZER9bvUlz/+C0bQFLRjvsn+tQ5W+V+c0DxuV3OU4C9RVMBZudv3+mmwdSBIo
         31Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912430; x=1743517230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6R9zA86q92q5KNyTPt/KezT2KM642idnT1llXfBvGGY=;
        b=fit4vWZDRZRIO4boOLwRK637jTzlPPG+v8WZ1vUyln+B0S4TxjpzxboQKGL29sqi9z
         SvpPurDNGuoJQ2QMDXlTgV0Z5t3QIs3Vm9JKtjkea2fB+QsEA7DZNmp3Kim3BFsI3s+7
         QneraHwTsCjGMkdkDjzfCMSh8/N1FH8xqhOybeKEiwTo8dp6Whbr9clRIzEPp3iToYuo
         rdbkiyyidzL96YoVV4yema4Y5oMwH0S+1uWkzn3699G34ObmWuSvNw060hydDSiX3+DG
         wY9+Nka5nhlJtRuixUmFI58M6+DCDZWSV/9ak0XTqNOOraX7A6GN39pdyk0Z5EaO7Mf9
         Q2sg==
X-Forwarded-Encrypted: i=1; AJvYcCXWIWnM4ebsUErwYkVEYJEG81jGEiQ88FtPHDs+Zp5kiyju/Trazlu72OnLgBRmqu0iKi2iKg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmD/E102ffxRQbENbCGfYYwuC8vbRYKaLfn9ZaYM30aLATnUEJ
	fYDASg2VRXjrBMP16fMwTSnNPIj4H9HBpfGo5s8GbxujGYpTmUQvYr6L3ezJWoaSPumyN37DFJ3
	RnYFk9EaTHl67SE2bajFtexrSqAQuwcIZ9kXmag==
X-Gm-Gg: ASbGncu0NGNdDboDw0UUosZFcmqY8AY4lk1zboQzwI056a14fZyCACbKqQ3gJw6yo+4
	HwJmLW0ys3x61x/lYk+Tl+W7gvRRvFxlzTRFTmeda5Ira1z1JM/wqy7XExDxt9nuV60mnmP4W8X
	+vM6TJRNbBFE+xLRKnrQvzmifP
X-Google-Smtp-Source: AGHT+IGc+rzcOSqRq1NAurG0wArv+f9TNDXi3NJHkDUdzPbqAqbmujaqTIOq09aOpi8XwtONse7qgR0mbQ4HEgDxOjc=
X-Received: by 2002:ac8:529a:0:b0:477:29f5:53eb with SMTP id
 d75a77b69052e-47729f55467mr169156461cf.6.1742912430244; Tue, 25 Mar 2025
 07:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Mar 2025 10:19:53 -0400
X-Gm-Features: AQ5f1JpBD7J0LGV4vivBPILeYhry8D0ETPzHZusd7bV5-E3dLFdBAyFaK8Fs_Bw
Message-ID: <CA+CK2bDtBk=49hbz+C=fDswz_Nbtj8kVjsY-pTsmBt+O8YPLmg@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] kexec: introduce Kexec HandOver (KHO)
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_142033_164831_C345BEFF 
X-CRM114-Status: GOOD (  10.36  )
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

> To use the code, please boot the kernel with the "kho=on" command line
> parameter.
> KHO will automatically create scratch regions. If you want to set the
> scratch size explicitly you can use "kho_scratch=" command line parameter.
> For instance, "kho_scratch=16M,512M,256M" will reserve a 16 MiB low
> memory scratch area, a 512 MiB global scratch region, and 256 MiB
> per NUMA node scratch regions on boot.

kho_scratch= is confusing. It should be renamed to what this memory
actually represents, which is memory that cannot be preserved by KHO.

I suggest renaming all references to "scratch" and this parameter to:

kho_nopersistent= or kho_nopreserve=

This way, we can also add checks that early allocations done by the
kernel in this memory do not get preserved. We can also add checks to
ensure that scarce low DMA memory does not get preserved across
reboots, and we avoid adding fragmentation to that region.

Pasha


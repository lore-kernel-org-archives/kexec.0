Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1B606A320
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uXimclPg;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=GI7bRBfc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UxG7GXUsicfCIDfMFjBbx3umG5dZ58gNRJ1FSEEffBI=; b=uXimclPgs9hiya
	IdFwlyi2dMs9YnvhhWNE4gFf7hiRLYGxffJF9+XQyGFrUp3VdpobNrasjwFLBjmzLdPcxB+KqfQxh
	WbPEHpIZJiqFRiHaM5ETimqsp449SjdsqivE7mvNWVX6Y837fFtEcT3lv7L0aTkMhcm7zkZqsuA6X
	exbb477EQwJ+ak0n2d42XaxQ913NgYNXpMtvlCyIibj0qB46SJkCJysthn6vGmrC2jMLKyQo5W9HL
	zYRcCfmPs89SO+ndzQ3kAFYDV2iKWvsiAkm4mtTP3TyJejYQsSqFVrJurRyaDYB+XDxovI+N1+XGP
	3Ps6B6WKLiO3NEBvAeYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4kw-0000000GIzw-1nP3;
	Sun, 08 Nov 2026 15:24:30 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4kr-0000000GIuJ-13DM
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 15:24:26 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5eabf243d05so32169e0c.2
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 07:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794151464; x=1794756264; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UxG7GXUsicfCIDfMFjBbx3umG5dZ58gNRJ1FSEEffBI=;
        b=GI7bRBfcX+xcuPKYp/TF7Faqq7VptzKk3v+vp0M5gGL/eVqC7pIh0Wq1z7fz+RRe9H
         Sj9+6+aVWDTPm3tFy64dem2SIuxyl9zGLIRGYFoJsZ2IfNB67pWKAxZv8vXUeIG+fKcS
         RGnD0Qz69mlQgl1biQ87fAJ7tA3shBK/4ki6Z3vIj4FCqmXg46hoPnFS/TrOIB0fnEYe
         Z4DfCyq8TDGBh0ZpEcROF12d4akgEQTW0m3Pwug015xg9rvkGtSeWafKU+fvd/fpV/8m
         M00j1EmX9AhPlb13ws8S2vQ0PCymAVrA65f9EyjucSVI3NAJaOS605e0gCF0E8ButQ/9
         fc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794151464; x=1794756264;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxG7GXUsicfCIDfMFjBbx3umG5dZ58gNRJ1FSEEffBI=;
        b=JbharQgBGpvHJg44vIANrNq88OE7VT++YmEYL0yxkqNmqb1DI64WR/+sB/aWvrEKQx
         jZ6Z7rhB7S25jV+e8jc0ZbNsQRQ6QFhaYv12ZW8/9ri1oo/012ST6Ea55/TIHaP+nfBM
         5u2vdpvM0PdkHB8Aaz0GlL1iKomvGg6AugN+ebSPkMYLR8CIagLs9kkru1rzH4+hHr6T
         WU35rLyzjxCUILf4NdEB2/SDz+KYgU1A2ZJAd1ICxNAt0jJESmUyTNiNozvzmXk00W2p
         ELaal2g3XvavmBofYPujpTFRA6aNGBqElXyQtRxJAuwRwcRNhx7BBgwlMOD1hTU2Yh0H
         aO0Q==
X-Forwarded-Encrypted: i=1; AL+hErEqdOaoNaLyB+JaWz1GrFFp6kZKxwjHy4+cOYjQ6q/u8ZTcP5+4BUTBQfzW8/LRrkH/8/yq+w==@lists.infradead.org
X-Gm-Message-State: APuU4Z9uGOatxK8b+RtrYW0EYApdF2hTNnK6p7SJNYPAncxGJIOEvhTS
	kv8Ukfj1un+DxYQhRWJQiA7g/5j6p3hy77ZUpG3BCHbH+QBzb9AqqMPOM9uAfEwhR00=
X-Gm-Gg: AYBFou3TIcYaWbuXOVUsfij315QUj2lqdaszAeWI5PUykqDHRUXafSJjoyP19OtbLkC
	+e9Q8KEtMahF9UobQIZx85Rrcf04tv+nTKnyHFdI4p34rmZPlygIRdIsosmVJKfpcOagQR4+jPj
	1j8Z6PWx46neC4jkTRpygfSFGLHHgP3ZrQ7Q/PD4oldUXMohV8Ktpu85qHNHgvfqfWdvmtGMNm7
	ICurUkhzOE3XdCxgmmTB8x06XLEjaoyGkmatiPFCugrPg31xLLddy+ech6MUjytfqMk8w8Kcun6
	dLGdAfDMW4stnTW5vG29B9ROEfXq/P4HZkcLE4OFYVbFFe+g3vJH7h/lYnyHt1Apa3E4mHVr7KV
	M3wZhkB/SigyohPB1V+iRXWs6vZj0KQezN0C4SSf8PW3TeYnUP/HmOqGIKsjnm+zbIvVGRkgaZt
	Vr4MZKyEjQYd2bqk1sT62SDeprp4laociYzHGa+ZYnU7ztXZ1hnqmP7aFEid0VtoUXqSFJhSfaq
	/IjxG+ICpul8N7v7CrZROpwz8EXD9cCcEp27dzv7VHq4q1byDiYDn+JNkh86+16c11yguOjMRYL
	hpK/dT3aKzk45onrcoKXDiM0YqSaI0yJnnOTJBtGAU+xRflQVym1W9jeRhyCS8iSw7+If++sInb
	Ps8fAbUnVDav5Inygpi6vTpQUTaBqcEjyUFrs3+nwaJ2+MXs=
X-Received: by 2002:a05:6122:546:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ece725fcc1mr534957e0c.17.1794151463870;
        Sun, 08 Nov 2026 07:24:23 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece60c1adfsm2166205e0c.8.2026.11.08.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:24:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/4] selftests: liveupdate: Add riscv support
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, 
 shuah@kernel.org, guoren@kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-5-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-5-cp0613@linux.alibaba.com>
Date: Sun, 08 Nov 2026 10:24:13 -0500
Message-Id: <179415145359.358073.275309518363721943.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=417;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=FtmrOogkqyUZ+q/8/Vic7Il7P35EARJys1IQgDvRVIs=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8JQhVEhYRlNImO2ueIVy23Pfe/4w2LJsKj2WG
 qH/Tmd7+XeJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavCUIQAKCRC7dyhM23N6
 3vP+D/sGPpbNDhlfiFA68lnaSlf3Ud1W6sEIzkODc2Rr/nh/XGhE/+iIjOkpoSCxRJE/NO9C+DG
 jRVkLElYMybWKAUMrMtK/FIY/Mmj3rQk8/+k2K6EyT8bp5Y5pm3UJWc3keXSIflkIzqBrdk8OXd
 jc5vEvhN6qdxqdjUra55/a8LMtN17XIqisUGChRTOKnezNh85HlE5QXwKBWEqOhTZjrKrntjYer
 eOUgHTCNquEbY7APFlbwpmVAwBwissclqIuP6RyhNBxnQRqOXacs8aiRer/a3lrBw56srBMgGEF
 Rz9b6ezMwvCKh5xpZJRAGlCpYcn4mztgSYF7qcsBmQdYhJq7h6bupQliFFODDM+BF8IPhTU0qYp
 JpCLkQvAUYKCSzApDXp4mGTNdwfPr+Dn/vL7vv21BiZ3nYC2zdmt8L3v34AoMkQuK+a0s1nUWMh
 syI3MknQ2599AHAVwKArwt3/21IjEzIIbZzcZdO+XsALXP79CbPrgN3Tz6Z+h1Dr8LB3dmfQTFm
 nhFIECmygvfqj7AVJQhQeN3IHyDJyyhpqLb3t7HlTEs4+MYEROzKSC+8ZZogWFtGCHVfovlcKgP
 uKerMtzV8HQ4ZSBMJ1ZQ5PX9EMGpc8uOa/dLCjDJX6tjUtcIEoU0vWb/7qtwlMVuPp0e1ny0g4M
 TnCpyQ6RyzM/VOw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_072425_317334_D9F769DB 
X-CRM114-Status: UNSURE (   7.02  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 06 Nov 2026 15:14:59 +0800, Chen Pei <cp0613@linux.alibaba.com> wrote:
> Teach the live update vmtest runners about riscv64, so the LUO tests can
> be run on this architecture.
> 
> LIVEUPDATE depends only on KEXEC_HANDOVER, enabled for riscv64 by the
> previous commit, so nothing in the tests stood in the way.
> 
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha



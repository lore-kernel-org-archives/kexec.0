Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC086C4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zeKnAyrKcTQEASDP8GiBa7MFsoKdJ8Ox0u3x63lMPDo=; b=hbKcXokmPbg5q/
	svmqRHxoSLV8Gpn2Gs/Z/ZJ4A+mddyv14X/qp/MlHGzllc8coCnxGCIh/jigC0OKfiEs9kfkyLASQ
	nHM0eJQv521uCqGdYB/E8JqsHF2rvqcybtmujoubnMLWfp/lqLUFX+8SuR0g9nmILpexY6Q3NJO8w
	/8+GJH1V8bRunoHnQVtNORwRBUEFIxrxe2nkuk/dCICZHsTpzfF7xmhzY3FbgjXY4Y4W8T9B+xNAd
	W3pfgmbM43FlV5ShVhP3PVcn0tYwZhNziuIR2UtPJvmlnxUhOJCRQjigp2QN/HI3wSQtqu+Wipy3E
	+PtZC7DV1dASTiiaLAvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8T8Y-009Rli-31;
	Wed, 29 Nov 2023 22:34:31 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8T8W-009Rkq-1C
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 22:34:29 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2859c011cb0so346962a91.1
        for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701297264; x=1701902064; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnm99jqQ5LZRgPNiiPzVL+B5VKBQnQt/eKM5uqfnZUU=;
        b=fYSJTyKdkhZroi0pQwN0tENvL9UNpXHxuuCQHGudbQNKdFOqA3Rsf7SkN3ZBJiqNaJ
         mFiaMZ+vK+H8xyEwwDgsVmEqOn5VtlJAhv6trZOZg1StIJcFLdph92BbcbpcupOHe0sT
         m56QtLhMOMKgXsHN8cjE8+OuoAk1SVPmGRU/pkIFKim4Q1vuYQ9zGw8Cxm9gz0Onkw99
         7bAJsDaYdeX9L6VPbUE/HlxFTZDJ3ynkFAKXmyE4iCgJv6xnSOsEDrPQipp9cV9fAqz/
         Vmp/mlMZlApHtl2emH4ogtMOEVuSmT6EaAOnoGIHDXs/COaLWaankdq9HBjYPRy5/YvC
         1Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297264; x=1701902064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnm99jqQ5LZRgPNiiPzVL+B5VKBQnQt/eKM5uqfnZUU=;
        b=jKtpajs8Xb97/c5sHCZYNH//0xYWAkk3vO+kHY+5oD8eSmUsQy/IMAsfiXWbeKs+is
         B1W46+b0lyo7E7E4ZtX+sVO9cClfE2U60qx1QEIcsc+xEmj/IiGUq4VXJchs7/pnDb/y
         VRGyTjSA+wPCi9VMc3n8Pw4BWnVjscEqYCij3Jnz0S1Dg0TgUGQFQC2SaCAJP8vZ7fPP
         Do0slM6J/nJwpocLdI+SmvWQdCu2a5EPGfup4kpdbX9V70FIxULz+i4RBu+06fP4sC2E
         e7h+z7A6bpOV9qx6wg0qi+ufILfgpyBYyh6xXLT3niLdVacK1ynnu5Q0QEBDDsw3bSR0
         1J2A==
X-Gm-Message-State: AOJu0Yz+gnPEcGGIJPdTnmkOSwR/7Lz5JcBvVswe+3Qzd9ie0bFxp4CG
	D810gl+9tRwZr3JQkKTWiuJsMgN15brTvGyHUFquDw==
X-Google-Smtp-Source: AGHT+IH0alFbhyux92V1WZYTs36CZIO0U41SCJZeLRz21ETmzAJqO7Ml6enLVYzem3Tj55K02bcXJQG+91mwi5Wj52I=
X-Received: by 2002:a17:90b:3c2:b0:285:772b:91a3 with SMTP id
 go2-20020a17090b03c200b00285772b91a3mr19810082pjb.27.1701297264563; Wed, 29
 Nov 2023 14:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20231129220409.55006-1-ignat@cloudflare.com> <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
In-Reply-To: <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 29 Nov 2023 22:34:13 +0000
Message-ID: <CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com, 
	agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com, 
	stable@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_143428_422619_C47C243D 
X-CRM114-Status: UNSURE (   9.88  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMTA6MjPigK9QTSBBbmRyZXcgTW9ydG9uCjxha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToKPgo+IE9uIFdlZCwgMjkgTm92IDIwMjMgMjI6MDQ6
MDkgKzAwMDAgSWduYXQgS29yY2hhZ2luIDxpZ25hdEBjbG91ZGZsYXJlLmNvbT4gd3JvdGU6Cj4K
PiA+IEZpeGVzOiA5MTUwNmY3ZTVkMjEgKCJhcm02NC9rZXhlYzogcmVmYWN0b3IgZm9yIGtlcm5l
bC9LY29uZmlnLmtleGVjIikKPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNi42Kzog
ZjhmZjIzNDoga2VybmVsL0tjb25maWcua2V4ZWM6IGRyb3Agc2VsZWN0IG9mIEtFWEVDIGZvciBD
UkFTSF9EVU1QCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuNisKPgo+IEkgZG91
YnQgaWYgYW55b25lIGtub3dzIHdoYXQgdGhlIHR3byBhYm92ZSBsaW5lcyBtZWFuLiAgV2hhdCBh
cmUgeW91cgo+IHJlY29tbWVuZGF0aW9ucyBmb3IgdGhlIG1lcmdpbmcgb2YgdGhpcyBwYXRjaD8K
CkhtbS4uLiBJIHdhcyBqdXN0IGZvbGxvd2luZwpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9o
dG1sL2xhdGVzdC9wcm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVsZXMuaHRtbCNvcHRpb24tMQphbmQg
YmFzaWNhbGx5IHdhbnRlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGlzIHBhdGNoIGdldHMgYmFja3Bv
cnRlZAp0b2dldGhlciB3aXRoIGNvbW1pdCBmOGZmMjM0OiBrZXJuZWwvS2NvbmZpZy5rZXhlYzog
ZHJvcCBzZWxlY3Qgb2YKS0VYRUMgZm9yIENSQVNIX0RVTVAgKHRoZXkgc2hvdWxkIGdvIHRvZ2V0
aGVyKQoKPiA+IFNpZ25lZC1vZmYtYnk6IElnbmF0IEtvcmNoYWdpbiA8aWduYXRAY2xvdWRmbGFy
ZS5jb20+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

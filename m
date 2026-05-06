Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ABECD343B
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Su2p72OGhTa6hvAv10iYjEdJ5nUmIFzciV3ESYU7Ql4=; b=hFYidOY+PTwOZugZEdc6X7Wh5R
	7wRGZEMgecCFo3I4Jxf+BFGPViDs9pTx4RIGuYOXOnUREjyZVHjVQfNc38CqMjOwM/xqh/1SwH5s8
	50J525AnfVuG4pByGrL0EuW0yU1/3KlQpcjxJoH3lOJrJwdpu+XeT2ZqM7hMePbUAHnszknMjf8u6
	0/LnN1ociYBMMbZhQEmlQ2Xzp7EuscngdrUM+NjHBfO4fTcKqQSF1hcqr7nyTkhb6Ebeb5BsaSZHp
	BZaD2HAKAhlauzm1b2yHL0RkWnxnwV6Gtx/dRoz7bvCpfo91GP63M+zM8oO5BsGMe5Zy0sy8Feb51
	2bopl7Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdvP-00000001GSC-1uO7;
	Wed, 06 May 2026 15:12:35 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdvO-00000001GRX-1Nn8
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 15:12:34 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-65c364b893aso5805852d50.0
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778080353; x=1778685153; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Su2p72OGhTa6hvAv10iYjEdJ5nUmIFzciV3ESYU7Ql4=;
        b=FAUzo348Ltx2RgzwL4Q6fuyaCHoqyXKc1NTFNKa9WViDk51bGPAZO3DUtvePaLALFb
         DMA2wzY5fFaxOhCS6FkMEBUKpj64G/m2ABabj/JWRa5NhU+kLyStZzOoQXO2roy60KGy
         8JrmoRRGIm88SWBHhGSv1lHbCMDaxlynXJEqk2Chh340qCl3G8sWNZzURSEfTM0VO29W
         LJSJZROA9a1yE/YLCQsdp2YKwdhtHfKrM+0pgiI5nIGDmasvnH1CKAAY3mJbZRyjBHEH
         Pd/iFOLksxTYeV0DERdzOtnTj/sujmrwd1jAl4OTRMAjYZUES0ybjTbullca+MAOuHNZ
         aa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080353; x=1778685153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su2p72OGhTa6hvAv10iYjEdJ5nUmIFzciV3ESYU7Ql4=;
        b=GjIl8loInQc7z47YPOrtYjqdsQsq5vaSPxz8JJXwHM3XDuqE3KH6Sqiy5WUi/03X/M
         LSDcUuSTwda0AIOGLEmpxstnY6lWCITFcdDbUows8yJkThKtuB2i+MwJYsQbBW7fMtac
         +POdfCUEKIE+4AcxOIdQyxIInAxs2kNhNemi1v9YV2ml6cywfsxIRkAB+BsPbxVayjVu
         lCP4dvX+SPmTwYvUXFzpcLoci3BkZA0MgLl9n6JmP+7U+VmKfzvyF6wP/z09qA+Sy2AQ
         mg7Dnp9zIAAx7ahxjgw4JACjfoAw2OKv90cAh2AfjJ9eQ9D+Qx4rX5qpBLbHvE1J4Ghw
         vb8g==
X-Forwarded-Encrypted: i=1; AFNElJ/nAksjpoAD9k1LRUSw7PUopbN3EBPUv7Vk50LRfTezTw9+KYMuug5Hrhm28bcN5XjNYyjLKg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4asjvIffjrckmPGRjV6gl87u6fMPP++7JHD5pOtagRLCIZo5L
	c2VOk5h4NzHwvEyEdc9VaMvikBDEBeElZ2rtSl0kBsikraZ9tHMza2K/oRJHn7jgXNA=
X-Gm-Gg: AeBDietdCS4DPwlj1mplrr8UEnUwOg5/adJdwplUx1eCFJZKXmr0PEMwd8yIX5KSIge
	QP0jfgwK2anBpSOLywKxfelWgJUWKRcJYWseDC19/QbpVeU+nNbZinGCQ/52cBogOHjGiDqRs/x
	b2k8e7aJM95VITb7F8PymlYRPE8L1NY2lj1Ayh9hiTgbt5uxh1vxogtwk08XkWkedUAbybPaGRr
	l6VKHqZdAkhJ1VJ7ci0OF2IxYQQQsnECTP/Y6jN+pYINywpxSNP11y+YFpNyH7TZVRN6x79n7mP
	D3X/CvmWdw/PnLRAValfsvAJjkGopOzsHBgDju+q+BDFT/rDjOWiaVhpYR2teJAg7N330fsxFJC
	SYxtizCy9TQB54GkVJgXntaK9BlRFT41osEIMWRmO6q3XPt64V6S0pD2M+lgwBhBAnsd0YBx8aN
	Pto+ZumHOtu3100cofDixV64DgByE/7RgR79GTnW5hqS9sy5w2SP/q/3fjGzWslolcY95XiEbyc
	BtT4g/rxmGgCxcQk1XQvhVbc+bi5gogk+HFM0gxPhbrzQx527M=
X-Received: by 2002:a05:690e:2497:b0:651:a928:4c90 with SMTP id 956f58d0204a3-65c799d8571mr3470884d50.43.1778080348335;
        Wed, 06 May 2026 08:12:28 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7afc6b18sm1171087d50.14.2026.05.06.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:12:27 -0700 (PDT)
Date: Wed, 6 May 2026 11:12:26 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org, 
	sourabhjain@linux.ibm.com, jbouron@amazon.com, akpm@linux-foundation.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, liaoyuanhong@vivo.com, 
	rafael.j.wysocki@intel.com, piliu@redhat.com, kexec@lists.infradead.org, graf@amazon.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v1 1/3] liveupdate: skip serialization for
 context-preserving kexec
Message-ID: <aftZZ5AuQcNuqInP@google.com>
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
 <20260506043200.2025677-6-pasha.tatashin@soleen.com>
 <2vxz34050wi7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz34050wi7.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_081234_374003_B071B828 
X-CRM114-Status: GOOD (  15.45  )
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

On 05-06 10:31, Pratyush Yadav wrote:
> Hi Pasha,
> 
> On Wed, May 06 2026, Pasha Tatashin wrote:
> 
> > A preserve_context kexec returns to the current kernel, which
> > is unrelated to live update where the state is passed to the next
> > kernel. Skip liveupdate_reboot() in this case to avoid serialization
> > and prevent sessions from being left in a frozen state upon return.
> 
> Should we also stop KHO? Now it is stateless and always finalized. I am

No. KHO preserves kernel internal memory; for context-preserved 
kexec, the 2nd kernel and the 1st kernel do not have overlapping 
memory. So, whatever the 1st kernel maintains in KHO is an internal 
detail of the 1st kernel. Once we return from the 2nd kernel to the 1st 
kernel, all KHO memory is going to stay as-is, and the 1st kernel can 
even perform a regular kexec or live update later.

Pasha

> not sure how these kexec jump images will interact with KHO data, but
> seems like we shouldn't be handing over memory if the image will jump
> back.
> 
> Anyway, for this patch:
> 
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> 
> >
> > Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
> > Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav


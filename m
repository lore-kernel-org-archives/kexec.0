Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9477C4452B
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+9XXd1f5+onL8AjI4khFaIFq5nBOeaDPXuilZKVYdI=; b=vWVqC/3zKl5fGrkZQwaiBiA1FG
	H+PpgdKpiNMZ+6RETkqWiAOmObjFuEmFMOdNuw1+WMULZc+ohg9ggTH2LfyHhr0fgHyroMKJ3FfEP
	yw7+7r4HykVTVQqbt6HvP2cpn7wiVV6StRHxH4gOHVYO3yDNj1vvFGlm1h2/SndDSnCDKgyZxyUoE
	mc0VfBZNxOLrzB6dnp6EcWvbBZ/MiT8jVo3zqG/H77tQ9hXbNg4isTeDpa85L2K7cHYCAb3xL1tDN
	sS5ZZ61FiOdKCVO4BSb1KogDUjL3S8H+ieTZ8A/QwCNooanMjIVlPUgWEPfLfhmyqFZ94EdbpWeFe
	glVQCUxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmF1s-0000000AAiq-1lAr;
	Tue, 21 Jul 2026 18:17:20 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmF1p-0000000AAhj-4AxC
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 18:17:19 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-92e5c92c389so781911385a.3
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784657836; x=1785262636; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f+9XXd1f5+onL8AjI4khFaIFq5nBOeaDPXuilZKVYdI=;
        b=RUxFUg1WvRgiTYU0zt6454trBVqCrLyPCMNiqFWdp2fNtvxKn0pV/t0VFlb9Gvqi9Z
         sCs4b3uoHmlABpvJ3PeTZALgwjlX4ch3n2mkcaO9g2vUHZbQP2guw9NElb0JddxtOy4/
         p2NYjGQ2TKNdbqrATee21PgRG2xeWU0z5i8UsXMqPXuaKqWCnJNI9wwsOba6UlgJz10X
         ZUJdvPUKF3Bo5C68VSgONgVkLVhj5Clx8nI+VZUhpIO1zit1t3zE1wvMsKa4GlUWOxSz
         w72ZBl3IZpKj/2d9AP9DpGzkI5AlWP2En8+Ey7bUXFHmLt+hGIyFk8V7X4AD+1i5Jt53
         jo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657836; x=1785262636;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+9XXd1f5+onL8AjI4khFaIFq5nBOeaDPXuilZKVYdI=;
        b=m9n35E8n07JvDoLilVEedFg4udsT1GX7Nrnz9t+8WpfU0X2PMSfsgdGwAkdpcNClVd
         uDc++AZJbNev1s3A24UcyEUCNfoHsd9ybNazQPbq6btihdir7rQHKbZcF4qYRAEnWHul
         STy3+e+SVmUqzQ1UHhRKvyzoB59W9+uCnKHtLn0jM3FBPrNjuDqestG3ivk4FUmQUEbo
         hYI1rpQ/who1pRo8uGnGt+WHv/Sh/COWNbQBmY55+snHf55woQAH/dUm74LMu0a2AHLA
         aaPSJXIo64EQL4vb7dY0jjYatZdfmV2mAsHc3tJIewZkt8sauNsHwYKJj5e/5Y2ShlWm
         mp1w==
X-Forwarded-Encrypted: i=1; AHgh+RogdTKvT4jWqg27gfSntYM+av2boLw3J8HRtWorPw3mxC41ZcXmg7GrqaRxKQGx2xxl4JROdw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzpMoR33f3B79PaNxpwOIykLqTsmNLfypeNTnk49iJdbFk+8Ewc
	1hJ6CPqHgIqYtUZkacc0UfR2R12exJkk3j6xkkt5JUrYY3PlE7tcE2T8x/Z/w9lRTdI=
X-Gm-Gg: AfdE7cn3ox4TL4BMn8E41ihdKvVAIOLdbNYornQazMiQ+hOprzDYlU5ELOnA+hXejY3
	bsa+r4ePdAsRSuISM7jHrhTzPXRzCIhat23XIH/XCJpV6ye1Z3d7dsDd0XIvy3Deqi7GNETmM9U
	4L4bWrpBSkOXlh21bf0YBdSIAsnLWmerU/P0Vt///UnyyxGQl1nx4/uNJX3kOC5bo7wkZodX1sD
	CSNZ9S38MqJLzxfF7ODU997YwST6iSC2fJEyjB80xBwAkMKYS2c6c4HaCQ5MNAYxQ/NFzKWP17V
	9QXnIF9lETgNyDB9nS+SdFTQ8V3xBKregVKElx2xpSdVK3BPUg8XW+Cy2jJd1ijFZZmpKMw9lY6
	hbzF7X1iSJsoBssSQb7947jOsnV3uwgV1RICdfDctc8N6D/eXAr1rm5w6UrAeF4rOwF3jSQfUdy
	smO86aXlHOsA7VIeagfMHc3l++ZkdoWUbwhucsfPXNlXk3U3XP2A==
X-Received: by 2002:a05:620a:708a:b0:92e:fd2c:6a21 with SMTP id af79cd13be357-930b3ed4e6bmr1951409485a.27.1784657836474;
        Tue, 21 Jul 2026 11:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dd4c2sm1177061685a.6.2026.07.21.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:17:15 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding
 Enable on preserved bridges
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-10-dmatlack@google.com>
 <178433098576.189683.2364970585754668266.b4-review@b4>
 <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
Date: Tue, 21 Jul 2026 18:17:13 +0000
Message-Id: <178465783370.437204.17382376546970842455.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=Fo9WpNwT/sUGT1i7/NR5Dmr2ueLjAaW0mDLdJx/XgD0=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqX7eqlp/ogJ/HFSfe9d7gJvqY2QGlESov+8vFK
 UnrL0B5ofWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCal+3qgAKCRC7dyhM23N6
 3rjiD/9pLAojhUZ3Gw0QkDSo7CBHc6v2wUGVKaF2iWfP34rUPJsFfVEgg0jF9wmXV0jX94tyfnY
 58vcRgopDo9BnjdD8MJiKFLY+c/1bwgj5XqBw+4EWhLvz1cWvI0pK57KzZJf31wAFALQ1n98Pex
 seGiBWeqXy76HaXMdWJDmgR4qaB2Vj75oUuWMgQjY/Rmh9diTQj64aJRo0Z0TliMy/x4gDC6h38
 +9FxcViNa0lAmfU8/om1ODmLzJYeNSkFs4cKpSTk2bzfYB9eamzgedskRKF1qKnP5mzg6GJcu2D
 OAMcwa46xXwAqfr/gFHQBaP7I/C+IJECu6cyTskw9gA3Zq6Q+2i/sSvfgeKVZQlkttlbmR126zD
 DxnnvF42qrMvHhoRSvB9sDlwSwmLklefh37cOifSHw+vVceIzCVZjS7Shfm3AddiYxSYqYcNaY3
 6MHkGOo3+A0GZ8YcJafB+8ex0TkPCLiZwlXZXCxLB9MeHjmJX0X5cFrb9n1luDPUNQVXeLK0t+4
 lawS9ROqKc2B9vkgurKqrFrmOZQjImBcdvlievMeF0JaXTh9/omvw+U/ObgJMAvq0Q+aKKb6XIi
 a5XHO7v0Lj4g+Vp6FrvyZ8Z67/Mqdn/XYGInU31avmh94um8Lqtsa1ygKrugCRiViW5TWEwES1Q
 aEb+GAhvGiNMESA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_111718_045624_49A38688 
X-CRM114-Status: GOOD (  21.16  )
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

On 2026-07-20 16:19:00-07:00, David Matlack wrote:
> On Fri, Jul 17, 2026 at 4:29 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> 
> > On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> wrote:
> >
> > unsigned int    ari_enabled:1;
> >
> > Sashiko asks a valid question, what protects other bits in this word
> > during modication?  At a very list a comment is needed.
> 
> This was my reply to Sashiko, not sure if you saw it:
> 
> .  pci_liveupdate_configure_ari() is called from pci_configure_ari()
> .  which also sets dev->ari_enabled=1 and is pre-existing code.
> .
> .  If writing to dev->ari_enabled in this path is indeed unsafe then that
> .  is a pre-existing bug.
> 
> I figured that a comment wouldn't be needed for continuing an
> established precedent (it's ok to write to ari_enabled during this
> path).

Overall, I agree that if there is a bug it is pre-existing. But we 
should also take opportunities to improve existing code and make it 
safer. In my opinion, Sashiko raises a valid concern that is not 
obvious, since there is no comment explaining the access of non-atomic 
bitfields in the header before the struct pci_dev definition.

In this path, it is safe because we run inside pci_device_add(), where 
dev is brand new and has not yet been added to the public devices list.

However, it would be great to:

1. Review the access patterns to ensure there are no concurrent writers 
   on any other paths.
2. Add a brief comment in this patch right before setting ari:
/* Safe to write without locking; device is not yet publicly visible */

or:

3. Create a new separate patch that adds a comment before the struct 
pci_dev definition explaining the bitfield access pattern, and how 
concurrent writes are avoided.



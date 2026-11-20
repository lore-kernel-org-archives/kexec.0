Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFA606A325
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MTeNMoXv;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=iMNTY+gP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WeOrsjpJfRBrNwFvy+AQY39SEDxtlUWfYfyLARDn2qU=; b=MTeNMoXvkjpMPf
	Sr64CMjxj+WEm9awBQfx5wNrJ/9Ao7LI++TClZUhMSB77O4IThltdI2OOOZd79Q4p2ovRvuQGBNfZ
	CuJt4Qj0b86haVKlLdFtRRQyBrX2HqislNmDDUohP5w67bv8UlgN7hfSWTDH6sx7PyCpihIoGKKUE
	7nITe7Nz9TPFpxnT9h9JBovwfeEPp3Zw/1BGDhOsJLaKyTnlQMyYx7pBLF2gKlze3so06hIOkbPUO
	0Qs91yg+XdsfOgReKHrZEtxEhrCGJl9/U55zqEdyqnLTT3c65g9Pk4OXNU7fQ5lcT3vRjQIuL0iZQ
	o6ZqWG+FN4+E0M3nkRbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNrH-0000000EyiP-02Ig;
	Fri, 20 Nov 2026 12:36:51 +0000
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNrA-0000000Eyg2-1Xhd
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 12:36:49 +0000
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-7d2e43ff4b4so1517608137.0
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795178202; x=1795783002; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WeOrsjpJfRBrNwFvy+AQY39SEDxtlUWfYfyLARDn2qU=;
        b=iMNTY+gPl4ECYL6hhk5ieZqme8TaVG+LIma1AznpEcnXShLlkQxKoM+VYZ+TFyhPLH
         MY6eZRCY2xPxPfN3HkvGR7t4vj3hQ8NfNPEXbN8fMBVQnfLXXvxN09FIDlonGLqXoruO
         z10rZfxFEiEitORVqaPeGyDwYCpYcW7LcdosD5FN0/XSgzK/t39tqyBHGTReQWb1OLnQ
         tHhwvMOOB/DO2voajomMPGdul+MPHP1u/eFEnu7Nw8/49p2GSsisETa+OAvx1p26Tx3g
         D3Oii4F8xjhSHoP5+vOebmam+ZmhqqWqdYxera/zZD66xieGxyvmUjndYQolK3qhGyrD
         EYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178202; x=1795783002;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeOrsjpJfRBrNwFvy+AQY39SEDxtlUWfYfyLARDn2qU=;
        b=HhJ3omo0EmcVdDdMn9SUmyCBGHQgDnAE49b+Ehz/fuLagpyQWFBfE2GCLfQj+fifV6
         mhzHwJuG2/bDhXWO5W0q/OkqNrHnMJJnx6SWSXs2qvuyM7vg4yhTfmrCJISmxKiJ8A67
         9DhZTKikZAEtEmKxCtRIQMp/vW315K25waqx+CJecRNIOBDQYckVamyl4VE/6e2gic3j
         Eh//FGcnv8vq7rW+JUyZERHPzKzxMgzmCKR7UXmcFnwE1E02hjuXetmBQwJVxMMaFuTH
         yH5i+WE7ZJmxRIJJTdz4WTYgOSSDgGOF95MqjkNqG/nZPkE/p7KmFFpx7ikVDwQt5n70
         S0Jg==
X-Forwarded-Encrypted: i=1; AL+hErHMxWNqSJrEFS4JCwv6K3xp+SMEWta9R8sTUrXDAfTF3RQvYLsehLcbQ7UVeyUqfB3Oe++gfQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z+A55YE10uunh3JAFKZmjia6GqZWheQ0m/wVtXwvoqLLSehPjTJ
	Dyl9HIJCsuIdh0q0BO5V2I2TZxA7ccFztibnCrUXF4+QzUKk1GYF+a5og2CRD3VYxy8=
X-Gm-Gg: AZFdTZdYCr+7mCGUuXqupK6jMZz6bjVpeUCqu1i46F8JNot0sz69lqTX2+igm+F1YDd
	U8VjePZX968vV7cmkUWHTHO8eu8+ZClhHS6w7v4xuNMUic6ajLJ/RNTeZ6SGCBzeewRR8n6MPZ2
	aMnbgD3p0rLAhUgrSdhBlRdZceP120lRAoBoTOIMPDAkUfF+rKI/C3Bf8gNrbjQY7V93OlfFZX3
	ar216dihRGQ55jv2EOgbEUJdtVu242fChhxxR2Lzw4pBpGMhLaY65SonT8NH98Thmq+eBIwVvhF
	IA0ldr8Bi3+SElK4CDJIxf2gAJ1NMRK73wtLJCfF6lnKvMJV+ST84YYgD8ZDlcJsQR0h3rorTg/
	p3Eh+/HX88mz7qysRf/txxbUxGlOidf/7RnRTR6KeKNDgPBc33PgrsoGm9szmv1utZCZzFb7sVM
	T8MK/BI5GFBWLgyhuz4r/Dn9M7OdjD6FtlqBBHfhDPZmmAXcuPENtWWph9vywsdc/8TsM9crLOa
	BLzOr7CvRFLOP8zTeQT7EDruuUDFy5zG/RaJjHEffQl1Wlc/1Hk6GGW9HX4Twj9hl20RL9r9dC3
	3JjBhklmrUz03lOrWJRQ4rHiKyWwSXSKXe91uz8FzewdgNP/5RuYaFClBYJMbdqIshhQIyWfQGa
	O+ohVkBl3Wu7UKo+k9EYZYHYdPoHKtRogv/eTRlqRDDWi0Y0=
X-Received: by 2002:a05:6102:6441:b0:7cc:905a:331a with SMTP id ada2fe7eead31-7d739660c9fmr746735137.14.1795178202521;
        Fri, 20 Nov 2026 04:36:42 -0800 (PST)
Received: from soleen.c.googlers.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e80cb440sm2765262137.7.2026.11.20.04.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:36:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] arch, kexec: declare kexec and crash capabilities
 in Kconfig.kexec
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Paul Walmsley <pjw@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, 
 Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 x86@kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev
In-Reply-To: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
Date: Fri, 20 Nov 2026 07:36:31 -0500
Message-Id: <179517819160.302903.17107992182494080507.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=279;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=6sWQl9lmqjTJk3yxh91YK+fuuFKvUf1mQEwavRJAVng=;
 b=owEBbAKT/ZANAwAKAbt3KEzbc3reAcsmYgBrAD7YSNYHVf2cFGXSq25iXRKWCRXN4f0ixFmnf
 ++ItKpA2qWJAjIEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCawA+2AAKCRC7dyhM23N6
 3tiPD/d31VAJSvGrL/uVfmPyx9aQ56Xv29nKPQ6VnqwxP+xMB94zunEWD8SU+Mc33Jsi99L7q8T
 EfGGkXbTCSoGd7NQv3bSnhUhMQVXfpkd18XOnWbNd0iZdBWi4KwA6+/bOhxsYpO/vNSV52HyHUl
 YH2tsnNB0E6EUN5P7dsJ2PqcWD6QjGrbW/xN/5ItrxWqVXu7AFWAGG87321F8utMVUAjMd5pbNX
 gMmicb9aVIU7JY8k0q7PhcEcRAKBjeq1d52NlSDCQyaltHTGY5+29RgVN9juLHJk/Aqy3s15ERG
 gm7x8LUDOEKOpRB5wWYYeKgpWsUscytR/AC4OBQTujXKhQIWBnWrzxr6tjgdacQJt/i9O9RHd1G
 2mft4ocO42XqcRceZtQr6UzRDuVwoDTDwn7Tgr1GRPVmpKWKbzpatvf9WPoIEE1p4+zITr10dGz
 r/38wDLPSJghOgD31RGTysREDXP/fCAYar6DdmmMDK63vuMssMRCUOe16Xd0DOIZIG4FAZ7iix4
 P8e8ny0z7tfxqx4vm+6CsIaWgFvVAxYu7Aw1xAruadzsWe+u5UqQLLBY6z+0k76JoRaBMkkcS25
 JEuj8uFaMFXD2ei4JRlUNt57apqgQNCbvhYb6KUTHwP7pocn/UNfKH5JCi9KQCFr7OzuMoLGVJq
 hED2RJ/U2jV7C
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_043644_437648_FDBB66DC 
X-CRM114-Status: UNSURE (   6.84  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 08:16:56 +0200, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
> 
> The intention is to take it via kexec tree.

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1B606A324
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=D2J6qPsN;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=QZ0/Nhy1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mF/CN1MwkKAbj0n+aog+XXJlGwsq4jMzPf88n15fnBI=; b=D2J6qPsNVmWLaG
	Ltot8d+NxQNm+ikV3CoL1MQn/Z4BTSJ0I7aU/V0UBUoDoDc2qY4EoKqqJaSsj9ihxYiSz23QQ2k+u
	vpHfZPPiGATIV+TSmx9g+q7o2GkiS3WKl4Ldmrd0AXeernS4CjM0PFYwWTqBfrKUio+K8rVL9oD00
	iURjw+ImIDqRCevDukS92pIfwjWBTBish8cC5ZgMVks6MCWsmfmeFD7BWL+A27P7ux5fOZy8Ngq4E
	x5gZTEOd/U330M7DMJ0acwTIN5tCizslgtPc2RXIYAjOBcMOjlVDLPyfzZrH0HdOsyKOH3069wPkE
	RT8qG6GKvyF4jhsIqA2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU3Wz-0000000CIfv-3al1;
	Thu, 19 Nov 2026 14:54:33 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU3Ww-0000000CIdq-1hbj
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 14:54:32 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-94965745d92so251816185a.2
        for <kexec@lists.infradead.org>; Thu, 19 Nov 2026 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795100069; x=1795704869; darn=lists.infradead.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mF/CN1MwkKAbj0n+aog+XXJlGwsq4jMzPf88n15fnBI=;
        b=QZ0/Nhy13grlmTMvfMScqScm0r5J1H0rNioOckoRMAH1nGUdinkgJQbslSmzPBregb
         iwtN3iz+SXztVW1+EVNMzhZiciVJzaWkBx8B/FQfPpmNbGHEFI6OWGgGq55M9HqRjMA9
         SEL4ncK1dbFILoOPIQzwv41V0e2ySs6K9zCwkl9kUxli9zi3uwnPFQllYtsJ1ZjeCf2+
         /sLNz2Ul7Rc3BRlTyxCvByxhOAXkdoXuaycIWGaqkjzoTZT7oYOI1y/Aso5ZB5ei1mi3
         5FpXQ5p0+xR/Qy1bO14AcAGeLYeMaRPTniHIVsJViDaggn+v7few1QOJIyYRI12XkKeN
         me8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100069; x=1795704869;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mF/CN1MwkKAbj0n+aog+XXJlGwsq4jMzPf88n15fnBI=;
        b=hjR5/aa/LUg+qB3go8Bf5GXqyFXPrOwoEtzS6fhifRwDHf/2Bf35KkOnG0nX/rqZAU
         gbZM0Ud88BTBmxz7WEXcClvQDz95D73zzhVFwVEBySQ7K+uo5d6gj7H6bnohMn++g594
         exeMvyXAHQJFbi6bu6XFVigo6P/HtD0v/rt4fsfMugW97uvnL8Zq/eP5vXmNRcC1sNds
         qJn5roHEsml9hIVElIV8b+yn/VIZiOIg6rANddZorvm/K9iX4FxBWUxnEXg0t1fEKOF+
         LhpNkLAaN1w41WG8Ub5Hyr8vB0NWdRXZDcAxYvMkiKrMI4tqEBoGUNt+3S7q9uauPvAK
         2FyA==
X-Forwarded-Encrypted: i=1; AL+hErEAQsGd95JmQoqBB123uub53NETCquDcxf9qSFNdLLXIob+jhB5tcKhSnqXUQ85YGC1scu1tA==@lists.infradead.org
X-Gm-Message-State: APuU4Z80rxqPhyANfUXtLty/e5EElRmQPnp0OtF9MBtYvuG+WyRURk5/
	2C+Y7Pn6Pw6PfqyM50XU4CMX8r/WoPvMVf5oPTTZ503VNGuBJJw/8g+x3FRfACItSg+p732YE8B
	EFLX5
X-Gm-Gg: AYBFou1yrexIQimehz0hewyqiZSxP1KTqR5Aa53SQXGfqY2QBFpUCfyemXXmblzKjZv
	vqoP68Rs0NDhvnG5q2n2Zky3yyS8mc7SQtaOWSBsNHO2ET8/pBwEXgprHANaAfAY8grqao7kKo0
	LgntcQ0UpOwg1NJV/WNMQiE6Nmk9Dmf/IZjginy8u/h1M7iuIdarTHO32aMopEsJJ4FfJyvgLwH
	qJFKZ3EGPrhtFbvn1NJFIwgno0yxmOdXZsAuGAexMe5Rqc+pab24ZEPixcjnFH1qveBm0Tlu7gK
	PyWaz+c9OrqZJFJ8pOTGYe+cj1sDIjbvcK5bQkXzKv7oaGG+p0kXZRp1sNIk1QkjhHsagPXJgnY
	PUlJUPNngZS2AONTug3gaRC8BKq6YXhZJpgu3cF6CMpvQxDC1/5rxYGbEMfYNalqRSpbwdmYAE8
	DN2rJNCBUewyoS+EN6RpMCLgSFhPTEKVKfehXhuY+sgL7UCChHrNuXNu0KNYypybtQIFXPwYJ/k
	88ZfuLlFJtFyNFnuVooVGHC24BLMG0KqI8oUqzxnORwRouorI3r6Yz77LS88q7Yb+5XR/GgFeu0
	9vKwl02sf7V/qUBC3lYoKZijjjRoKQlw6PXa/Q2xDtpH67sW3iKwTZV9Z1uu+zBe8jCYe67uTPf
	nT6OQlueSYqQ45+zcHR2EIDTa/2uOSM4=
X-Received: by 2002:a05:620a:6e84:20b0:949:a7d0:e6b4 with SMTP id af79cd13be357-949a7d0e7f1mr416234385a.51.1795100068869;
        Thu, 19 Nov 2026 06:54:28 -0800 (PST)
Received: from localhost (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949b9a5370dsm10296885a.23.2026.11.19.06.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 06:54:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 09:54:27 -0500
Message-Id: <DMZ9V6MU9XNZ.3J23SCKTSDHB@soleen.com>
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: "Breno Leitao" <leitao@debian.org>, "Alexander Graf" <graf@amazon.com>,
 "Baoquan He" <baoquan.he@linux.dev>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <kexec@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH 1/9] kho: Reclaim the metadata page left reserved after
 kexec
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <cover.1794383544.git.chris@chrisdown.name>
 <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
In-Reply-To: <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_065430_464862_055DBFFB 
X-CRM114-Status: GOOD (  20.45  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 2:52 AM EST, Chris Down wrote:
> After a KHO kexec, the new kernel keeps the page holding the previous
> kernel's kexec metadata reserved for as long as it runs. It only needs
> the page once, since kho_in_kexec_metadata() copies the previous release
> and the kexec count out of it at boot, and nothing reads it again.
>
> Free it with kho_restore_free() once copying is complete.
>
> Fixes: 76aa46b9e404 ("kho: kexec-metadata: track previous kernel chain")
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  Documentation/admin-guide/mm/kho.rst |  4 +++-
>  kernel/liveupdate/kexec_handover.c   | 10 +++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-g=
uide/mm/kho.rst
> index 902d171a780a..f9d2cc5999ee 100644
> --- a/Documentation/admin-guide/mm/kho.rst
> +++ b/Documentation/admin-guide/mm/kho.rst
> @@ -120,4 +120,6 @@ stabilized.
> =20
>  ``/sys/kernel/debug/kho/in/sub_fdts/``
>      Similar to ``kho/out/sub_fdts/``, but contains sub blobs
> -    of KHO producers passed from the old kernel.
> +    of KHO producers passed from the old kernel. A blob disappears
> +    once the kernel has read and freed it, as ``kexec-metadata`` does
> +    during boot.
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index eeec298aa9d6..3046b89e5db4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1808,6 +1808,9 @@ static void __init kho_in_kexec_metadata(void)
> =20
>  	pr_info("exec from: %s (count %u)\n",
>  		kho_in.previous_release, kho_in.kexec_count);
> +
> +	kho_debugfs_blob_remove(&kho_in.dbg, metadata);
> +	kho_restore_free(metadata);
>  }
> =20
>  /*
> @@ -1885,14 +1888,15 @@ static __init int kho_init(void)
>  	if (err)
>  		goto err_free_fdt;
> =20
> +	if (fdt)
> +		kho_in_debugfs_init(&kho_in.dbg, fdt);
> +
>  	err =3D kho_kexec_metadata_init(fdt);
>  	if (err)
>  		goto err_free_fdt;
> =20
> -	if (fdt) {
> -		kho_in_debugfs_init(&kho_in.dbg, fdt);
> +	if (fdt)
>  		return 0;
> -	}

This re-ordering can be removed, now that we applied:
https://lore.kernel.org/all/179508700586.361583.12491114908870226409.b4-ty@=
b4/

> =20
>  	for (int i =3D 0; i < kho_bootmem_cnt; i++) {
>  		unsigned long base_pfn =3D PHYS_PFN(kho_bootmem[i].addr);





--=20
Pasha



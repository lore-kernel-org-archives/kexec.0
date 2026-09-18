Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A510C982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 03:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hkjoM6yd6CXdEoSX1RClXGhH+cgflcxUopLdHG+auvU=; b=IamOaXgi6Nd+/eFVT3a9+XnGj9
	KNNR/SlYDWPfOEwpzcpxe9lsaYCRioQ/WVyTV9d0D8i6zvmTtx7TF5uV72NJ0BIT71qf4WWH16wsY
	bqxQ+KpKLoC6WIX+9iXByq1Mtp9IcizNcJd9VTkFJWWm2KoP6jXBzxI1Tr1sq/lqaP7rJ6Tel9JZY
	r/6qRDn9850uCjcmsByYROnoxPZXO+v6MXb5u12zpX1jvTcCw3d4EScUeiw+BtIh5L7dvOwtnhIYL
	ClhvqbWyPM6RQPznDXMZB3DNvoGekPwOAEV4597SaLCoQVZXzV76LMqkch2MHeKPCBg9niAADlBOR
	Es/8nFyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PCt-0000000DNne-1QOi;
	Fri, 18 Sep 2026 03:24:11 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PCq-0000000DNmz-0Es6
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 03:24:10 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-86927f9ba4dso176342b3a.1
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 20:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789701846; x=1790306646;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hkjoM6yd6CXdEoSX1RClXGhH+cgflcxUopLdHG+auvU=;
        b=PkmoxNYhHKSktLm1Jsty1Q+kkEBWHGyauqAGcYh1PgnglapegYeHsYMe5W9I2CB2TI
         NlBGFv6KCWWA1c5o8x4BSBch5E/Z9IaBzT8Rcmh+URIFVIHXm6v7GWSleXTB04IlsT3J
         Km6kBlI3O5j5xVSUd7WSuq6/GSFJ7Ge2HnuyPDcGidfVIjXJn2CBiDEBXfLWnjixa6NU
         Okh4++vGFn4XpbTGdyrM8QQR/5DV5d4qp5QV5xSJX7JqCra94o/2j6znAab55NSxgGHM
         dw4Z9ZWcdkb5g09OEypEmu9KkaB77lxL4QVHq4JKkU6mqRReFF5XEFeSe0sZHChxgJj9
         xUyw==
X-Forwarded-Encrypted: i=1; AKwUvByvSuw6AVmQeGfGVy7IkbWsZg8GOLJU9bT+HXS1a7j+WvD+tk+O0YWHTZ+iCPt+uQ4bz6wQGA==@lists.infradead.org
X-Gm-Message-State: AFuF++lKlK5ZU8xFjsSCbTrhbF7Pk/OByqcwpaiKeV7roqa/YHpLN2fO
	QeF55r6nzModQbHhbd0X2I8R3vAu28WxwBJAFtmPyBwg6vB36iv/vIw/h8tcpXNoBa1eptYGSSp
	QUbLo3wS+Ng2r5q4YAfW9IoSK9/VXVB3rXoNevQgUWtPltIEbmpf6bUMI6M2XtfKkWNh/UBzEgF
	A92v+i5o5xQAv0x+fO4KuBP8fq/VIuox4RdhjBNMR7YOGxzCAne1sni9Ss7pHSsBEwQ8MX/toax
	GUwOiUMeLKT
X-Gm-Gg: AYBFou3Xtb5Otu4mbIwqR9540StY50DurWb7DaREeqe3TkgZkkGZQuGUDdeI+Od8JKo
	eM+kU2YpVyDNELzZdMV+qGe4jrc8X5UEeg89RftsNCE+qkbpUfKLGfVmWqbzFyCCsMiKEFoJWqZ
	S8iOA5JvqneEAnInAfIlyuEbwesDOvOJ3kvfmGgUYq1teZFaN3nx21L2XBqFEtVbVmr/lNpOY5E
	lW/86SlwSNkhqBsfJJSShoInjt5e91Mg+IZOO4Jmg3VwRzN+GtYOTN13wSf/n8r7wz4VWJOgtDs
	pNNcwGuO9q/9DbqIVjUcKx4xED8Qinzg7nZp1cqVSknzqzgad92+X7Wndy9fSq1THyM86J5uw4s
	1TyDcZmjFFjOCPcBAau2HD2VkCNTtN/IlfFWj/FaVwM29DntP1bat6wtjQMxHsmdSDtWZmvcqPX
	OT0O2QQoHyN9D5dp7u1PplUOStzGjkVAom
X-Received: by 2002:a05:6a21:7486:b0:3da:bd6d:bef4 with SMTP id adf61e73a8af0-3dd8c441374mr2384261637.13.1789701845789;
        Thu, 17 Sep 2026 20:24:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc5bc9f893dsm160407a12.3.2026.09.17.20.24.05
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 20:24:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3a55b68ae57so1383841fa.2
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789701843; x=1790306643; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkjoM6yd6CXdEoSX1RClXGhH+cgflcxUopLdHG+auvU=;
        b=cLxlKs1v8a7auzn8JrP9pb978pE0yRXpL8uiC6DxIX11mRlc835Os5FVSAyVnOrHhN
         eZQbtPUWTUtZeWniBDc6TFXV/NTnF2sa2u8R4anBqo1saO2kaGIpAQWftyhkG9UGWQ0/
         ikJAUQQsNVlWFEBMrgHCkLgQEU3eZhO2KP4t4=
X-Forwarded-Encrypted: i=1; AKwUvBz31+cRyMJ7N176ztlI+TFo4PRQgl9Qg/OhGmB5rS2tdIOS8BWAxvV5qf7QqcUfNv/Q7siGug==@lists.infradead.org
X-Received: by 2002:a05:6512:3ba3:b0:5b8:bc5e:d118 with SMTP id 2adb3069b0e04-5b8c1986aeamr235852e87.66.1789701843369;
        Thu, 17 Sep 2026 20:24:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba3:b0:5b8:bc5e:d118 with SMTP id
 2adb3069b0e04-5b8c1986aeamr235845e87.66.1789701842954; Thu, 17 Sep 2026
 20:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788414671.git.zack.rusin@broadcom.com> <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
In-Reply-To: <aquttpMVKX8e6zGB@pathway.suse.cz>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 17 Sep 2026 23:23:49 -0400
X-Gm-Features: AcwNN1UbbvzheDkuAbTIJB-wv3-UyGyD0BDcZCvagFWxgsOb2LvxtBfe6D-Qesg
Message-ID: <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by default
To: Petr Mladek <pmladek@suse.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a5e45c065bb96e66"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_202408_141951_091B1713 
X-CRM114-Status: GOOD (  33.37  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Bo Gan <bo.gan@broadcom.com>, "H . Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--000000000000a5e45c065bb96e66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 5:07=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Adding Guilherme G. Piccoli into Cc.
>
> On Tue 2026-09-08 14:07:16, Zack Rusin wrote:
> > The core panic path enters a loaded crash kernel before running kmsg
> > dumpers, so the VMware logger cannot preserve the panic in the host log=
.
> > Set crash_kexec_post_notifiers during VMware platform setup. setup_arch=
()
> > runs before ordinary core parameters are parsed, so an explicit
> > crash_kexec_post_notifiers=3D0 still overrides this default. The 0644
> > parameter also remains writable at runtime.
> >
> > VMware exposes no capability bit for this behavior, so the default chan=
ges
> > for every VMware guest. Running the logger first adds work to the panic
> > path and can reduce kdump reliability.
>
> AFAIK, the quality of the notifiers is varying. Running all notifiers
> might reduce the kdump reliability even more.
>
> I do not like much the hack with crash_kexec_post_notifiers. It is
> an all or nothing option.
>
> Also it was introduced as a quick hack so that users could decide
> what is more important for them. But it is not longer a "user"
> decision when some platforms enforce the ordering because they
> depend on the notifier.
>
> panic() is problematic and it is about compromises. And we need
> to balance what is important, what is safe, and what is optional.
> This is why I suggested to introduce more notifiers some time ago,
> see https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp@alley/
>
> Guillermo implemented this, see
> https://lore.kernel.org/all/20220427224924.592546-1-gpiccoli@igalia.com/
> But it has stalled because it touched too many subsystems and it was
> hard to get an agreement.
>
> Maybe, we should start with something simple, and introduce
> one more panic notifier as a start. It might be called either:
>
>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers =3D true"
>     seems to be primary set on hypervisors.
>
> But I would rather make it more generic and call it
>
>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
>     more notifiers which are either 100% safe and useful or are worth
>     the risk before calling crash dump.
>
> We could put there x86/vmware notifiers as a start. And we could later
> move there other important notifiers.
>
> How does that sound, please?

afaict that sounds good. Keeping it to one new list and one client
should make it manageable to review (which is my biggest worry :) ).

As so the implementation: I'll drop VMware's
crash_kexec_post_notifiers default and start with one generic
panic_pre_kdump_list, with only the VMware log sender on it. The
structured crash-report hypercall (REPORTGUESTCRASH) can terminate the
VM, so it stays late and remains suppressed when a crash kernel is
loaded. Log transfer is still controlled by
kernel.vmware_record_panic_msg, with encrypted guests defaulting to
off.

I think that without that default though, x86 oops_end() can enter
crash_kexec(regs) before reaching panic(), for example with
panic_on_oops=3D1. To cover that path too, I'd call the chain from
__crash_kexec() after the image check and register capture, under the
existing kexec lock. A second call in vpanic(), immediately before
kmsg_dump_desc(), would cover the fallback path. And I think a
set-once guard would prevent duplicate or recursive dispatch.

That leaves CPU-stop and ordinary notifier ordering unchanged. The
logger would read the kmsg buffer directly, without invoking the other
dumpers, and would need to tolerate NMI context and other CPUs still
running. I'll keep the crash-core call in a separate patch for kdump
review, leaving other clients for follow-ups.

Does that sound good to you?

z

--000000000000a5e45c065bb96e66
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIP6m
uYCiia3ORHyqPmaSAdKPjfLBQQ4P4lHomezD1Dh3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxODAzMjQwM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIJoiqN+pGBweUn+Tw/Bk02/2LuL0p2H5SVE0c/c
RackBtK7eGpsWfY80ejZOxPsrOcCSNd/PwPLAHfTDFrBV4eeRsKSIvXnYo9Rd/s/WXtvfnj7aksD
arOk+coO3+mc6qBHRSeQ6/JJJOxBkavp6QdrvJVDF9/hryFuMHaIZEOC/Jg6b8zCMv696KHqI2LH
Gsw5+z4jBn/co22kaB8CqYvlWWSzvqpHK6QJp9ZHtGfVqoROyKfvWGMv02z54jwmscT6p60Ru2IY
XN1CMthKyOmV+cLZzJv5XVGDiy0i7AoAH+aGU8BWVmKulTEcWBlUd8zX/E1WsuK+yNMAGGEGDcU=
--000000000000a5e45c065bb96e66--


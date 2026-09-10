Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A55EC79F9F
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iv60bofOpgeNkkxL1uuoq/g8ewRxIvgjl+H7/W9vWAM=; b=VpKBkE4FCE4WDs8PKI6lGAzsbk
	kf4WZSUgJ8bESaRQ307YU66RG1xeAadVKoco+6zq5HmMfHw4bh9OX0YWZmk5u7uklwGWH24y5DnvX
	gmZhjeWs69ucAUARIuWDgvAR6KxBIIz+KiDchr5EqHYR+ZeaAKzE5WKbJqOS+UV9Nt2VI2kAgS+s6
	rA8m5ckZr/A352A6z8QM0EhbqB2j2eloa4xZL+NWnRX5fPgCHLFsOOcHcAvywPindiW9YglOf2EUv
	+tQCCTbsFdgPES+qJjgaIVa7VBo1kQ6VcFpgOZxJkt7itT+xF1yjBhXnIRysiHrNnLFnwOJD8gH1E
	Vst9SVfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4dDE-0000000EFf5-2Biq;
	Thu, 10 Sep 2026 11:45:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4dDD-0000000EFec-0zGU
	for kexec@bombadil.infradead.org;
	Thu, 10 Sep 2026 11:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iv60bofOpgeNkkxL1uuoq/g8ewRxIvgjl+H7/W9vWAM=; b=nTZMHHRExj62X6bVXbOzIuou4U
	v6ILNBnWqo5BC5okbAl2Zqmqea2FZtYAaJP3e5A9p/mjWJpE8DUrg3cT5WKjn3b5ja4vHg9yC0/8N
	DIai17oI3DSagZgNeC2iK/Cq74g7y+luSli3WaY5g7mD4zaIHJTGEIIaKqjceE1HRrPsIH8pXM+so
	M1S7LOW0MD34H4PHn+BHQFMqd2ud+k+WS1fQJ0vZXa1PKGTNzK9BQ9KG2v5mDjmP3XEhIDfwdQAhA
	2ak/kH5bYQ2rMb5lCB8A1RMUfMRO1XhAtVfOFuLgacCXuMpQwoQYN0oMae8N1Axj2ISiX/PIFF1VB
	fnXqDufg==;
Received: from mail-vk1-xa64.google.com ([2607:f8b0:4864:20::a64])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4dD9-00000002Q4g-0w4N
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 11:45:02 +0000
Received: by mail-vk1-xa64.google.com with SMTP id 71dfb90a1353d-5c83a3048b6so107059e0c.3
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 04:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789040696; x=1789645496;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iv60bofOpgeNkkxL1uuoq/g8ewRxIvgjl+H7/W9vWAM=;
        b=ex3lU/DaYudd3buA4M+hTyyWLOnvuNibwrdjFL4zkWQACKfW1tPZHBUX28iGG7Xuvx
         P+trrqIXfymBqTWVJgaAjScvlNRpQs+djVkuzk5mDUgbw17GpcfqdkBQNyzGemCwCjEv
         CGivoLl+ZPihd7a773moWds/TlowloOheIfDSFjL1dKElJQSpBBvAPkxVxa0NlzA5zMO
         5BEQZiXqfoeIIAqIcNcS7OH2UPbKkegOhottN+UC1vDkyMHRa3vb6m007mCg4BcedOjE
         eTK0uDuMA1mZmkkshhCytcJId3Gq1f7GlCXICGKpg7c9+M1dOHPtg+MmXO0hbmRy1zau
         12sw==
X-Forwarded-Encrypted: i=1; AKwUvBybLvBvmaZh2T5wfdq4xyc9gY/YuCG3AIIfAgtsF/DojaJAWkAUsflZ0484Sl2wJn8lD9TM+Q==@lists.infradead.org
X-Gm-Message-State: AFuF++ntqMUXd/I76YifI/96NaxpOoNzoZHXlxJ1rI42Ko8Mn5UbCOiF
	CEwyQscH5FTVF6aeP2ZQaDN3a2I0NRBJ/mHINj14j6kfUZ14/i3mvL7ueHlOABBD9IcZZfYwOf9
	COhf4qWVWRrZ62PvKYzo5p3ZTqp7VuFHDu7xewzf1FUzagQo2wlcOjLUBWVP84DuckJZgNcwvuc
	i0PABGPainsWPu8NGa1u1EMEldpH7vTDL7/mNwlA0s10irtRNcl6NSXpsQjOt9p6/Oy9hVFMHFr
	6hUTTnHztfC
X-Gm-Gg: AYBFou0MsHqIKVS1PKJitNBn6XLPbfYZ6YRlyXtDHE/HQywlgoRTqVpRHCXFT7F01gW
	ycR2N8MKUO0J3xfegk2G1g/K9x4hSSZA21UXObGcKsO00isNIXDGX5r3VdWD52jOH4X28x/Xwx7
	mkYyQhDxCzR1Qze2l4+GhY4ydjkPm3Q2bFu1O3HjphAezjqVNVTn3lwP7PWJAW6gwmz1VgrlOCH
	wBVZ8+1IX/oZb0dfHhCOWshLnnNV4PkHMS+cLsHOj23uWZejCIs0eCG9i4TcjjDSBrbSAHxHHTR
	sWrKsvydGaK5v1r5plbXO2mCCgoeSmNH+BoZEtXgAYV2DMZlTuDLIIP8qXBGUNmhuv71KSpBL/b
	NbDNzMAH58dKU4bV49+tWX9dKU4TaG2R6whSHfPUK5H5QIlA3Pk2Bd4F1Cmn4qzVsRKq7B/eIoH
	uQZ2UAP3tvGZC9VrTO2UCyv6or8XPwCg==
X-Received: by 2002:a05:6122:181a:b0:56f:6cc0:681e with SMTP id 71dfb90a1353d-5c83342f9b2mr4919065e0c.1.1789040696120;
        Thu, 10 Sep 2026 04:44:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ec232ce8sm9132218e0c.5.2026.09.10.04.44.55
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2026 04:44:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3a3540f42beso43745121fa.2
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789040694; x=1789645494; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iv60bofOpgeNkkxL1uuoq/g8ewRxIvgjl+H7/W9vWAM=;
        b=Sx+Jchw8BhKaxxk9kIFKMV0O4iVqRcO0HLt+aXu2LoCyvzJqjzq9K0xeVEaww+5I8S
         bwySQMoRk/N379rSDODyrqkClpdyfLQI6nFZfGnk0H4QASzj3uJoI1Ag/wIstU1BgqtY
         uFl//NcctsNrXcejE5orT32A0ufw0qRiLz0cE=
X-Forwarded-Encrypted: i=1; AKwUvBxqQjH6AaL6AXiPWx0q8nI+x2h+l0qaePSBpiCIuVzyIFHRGdYM9ck7SRKCZU8NYArSB7Yyyg==@lists.infradead.org
X-Received: by 2002:a05:6512:3f0d:b0:5b6:183b:d20f with SMTP id 2adb3069b0e04-5b8986ce57cmr1233200e87.54.1789040694235;
        Thu, 10 Sep 2026 04:44:54 -0700 (PDT)
X-Received: by 2002:a05:6512:3f0d:b0:5b6:183b:d20f with SMTP id
 2adb3069b0e04-5b8986ce57cmr1233181e87.54.1789040693727; Thu, 10 Sep 2026
 04:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788414671.git.zack.rusin@broadcom.com> <03e5c9855e9578b00abf8da69764f1b468597218.1788414671.git.zack.rusin@broadcom.com>
 <4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj>
In-Reply-To: <4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 10 Sep 2026 07:44:40 -0400
X-Gm-Features: AcwNN1V9O4m5Md-NIpRcZHEks8CoV3j2fYxMn4_4djvvW1loHBxxC_mukyVMqHE
Message-ID: <CABQX2QNc1GP5ZgizK=9+6XN9Ow4dsUKaFD51oGke=OP6hxCyYw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] x86/vmware: Add the vmware_record_panic_msg sysctl
To: Joel Granados <joel.granados@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, 
	Petr Mladek <pmladek@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000016fda7065b1f7f28"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_124459_743124_743FD072 
X-CRM114-Status: GOOD (  27.86  )
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

--00000000000016fda7065b1f7f28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 4:32=E2=80=AFAM Joel Granados <joel.granados@kernel=
.org> wrote:
>
> On Tue, Sep 08, 2026 at 02:07:14PM -0400, Zack Rusin wrote:
> > Full panic text is useful on ordinary guests. Encrypted guests should
> > export it only when an administrator opts in. Reporting a crash does no=
t
> > require transferring the log.
> >
> > Enable panic recording by default for ordinary VMware guests and disabl=
e
> > it when guest memory encryption is active. Expose the policy as the
> > boolean kernel.vmware_record_panic_msg sysctl and document that it
> > controls only the vmware.log transfer.
> >
> > Register the sysctl only after the panic buffer and dumper are ready, a=
nd
> > only when sysctl support is built. A registration failure leaves the
> > internal default in force.
> >
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++++
> >  arch/x86/kernel/cpu/vmware.c                | 23 +++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentatio=
n/admin-guide/sysctl/kernel.rst
> > index b6328cd0f43e..4577e935ddcf 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -1690,6 +1690,20 @@ entry will default to 2 instead of 0.
> >  =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > +vmware_record_panic_msg
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Controls whether panic kmsg data is written to the host's ``vmware.log=
``.
> > +This setting does not control the separate VMware guest-crash event.
> > +
> > +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +0 Do not write panic kmsg data to ``vmware.log``. This is the
> > +  default for encrypted guests.
> > +1 Write panic kmsg data to ``vmware.log``. This is the default for
> > +  ordinary guests.
> > +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This seems like it can be represented in a boolean value. Any reason why
> you did not use proc_dobool for your handler? Would it make sense to
> have vmware_record_panic_msg as a boolean?

Thank you for taking a look! This follows the existing Hyper-V
implementation of hyperv_record_panic_msg, which uses an int and
proc_dointvec_minmax with 0/1 bounds. I thought that consistency
across the codebase was more important even though I agree that bool
and proc_dobool() would be a better fit.

z

--00000000000016fda7065b1f7f28
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAt4
cev6P7GGT9P7O6xhDkrrsIOwZFgZdA7C8KsFBvldMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxMDExNDQ1NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKVm+t7Ihid+5m7LkmgrTTT/nFDgrcnNZG55rsNZ
62mD9lzTnUR3EB4aeSLPE4gqjCo2NvGlEge4LxsJMs+xDtH1AXSVGFlLmHPMS5hvYnHbAlgVbxKR
aj5+O/M/0qRkxMmCbkSoDljUiqc7xOozqnhSMWctS6WZBm+iIOxRGRFNr2Fjc8r2nFRBlwWXqpaO
pjlp/ZyPZH/vXQHqUTNpYUH2FuoR47zjvzTyKwSEwHbyo1t3mM31hud3yAuzplEA7ZUsk60RW+aD
ljBy85uU1rkBSCC99YwDars4rGqOH+iGXcDW964DUqSM1QrwbdxgzeJxaIFp+09N6F2fxPzrGVE=
--00000000000016fda7065b1f7f28--


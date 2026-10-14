Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E21C3DA7A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 17:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uRm44gAiUhyrp6pDDNw26lB142siFftJgiu5AAj4cQY=; b=oKwJq9unYKO9uHudlbRbGziMiD
	2IGaQrH5siouKFaH0Ua5G3stTTC7BiSi6u9ZzlJyMOTRfrxu/K7nUoXOrmC0ldFa1GD7bhAkT+9BL
	L2nveMxExNcXQ1MIkqvBGdi8Qi0OZBxGdwSdVlXaRM4DyA/FLzwDQXuNyPQXSfNwrmll0VbIZWd88
	YWbatkMO8gh8ttBeYlbXNqtwUtaebwuckucONr1k3EBLB98zVAPnnO1z+8+hW7Vvf3b3cAPVb713P
	TmnQ1TN3t7tHTyDlSWKJxSXfR2vmCv46aA4L1Y9mAJa7ZJPAMWd48p6KJLd8a0m6THm/Y+iTrxzks
	abW2s80A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2SL-0000000G3yd-1X3C;
	Wed, 14 Oct 2026 17:07:57 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2SG-0000000G3y5-08nd
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 17:07:53 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so2475414a91.3
        for <kexec@lists.infradead.org>; Wed, 14 Oct 2026 10:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997670; x=1792602470;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uRm44gAiUhyrp6pDDNw26lB142siFftJgiu5AAj4cQY=;
        b=C1+1u3RdLVTfydfCmvWmV0urxVnqJ+dsA+OyHOXEoKfwvA3NaljKQH/Ff4wdmRcdmJ
         D14l9znkC9iADH4bLe+2SgTM2n8oayZK74KqGRh3DW0LyAJlKsSjM0NVk6SfubTk4TgU
         D1SH2qOS0uP0IN9wElds18OqTnZ6+QCezEBghPghrI9Flyc0Y6xRpQni5pwA67StYPuw
         1Kp8m9i9ZFRH9CA4XjmUgM9za1xP7UtTlE/lQodm0SY/hFPhVLCuZE72Mb7rOjtnnfyK
         6kEMnrHNFNJEsr8lbA/24SWhEgSKyXothGMkF9iqZSOnC2oCKv5uTXYXoczbg3d7YrYV
         oefw==
X-Forwarded-Encrypted: i=1; AKwUvBz9CWhWO7e6sALGMQ8FlIy1P1MEcYhh1mbwB2GQVVyVPpn99AnGr/6cYTZ9Aj2Cv0MLJLhYBg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJug5y9r9wgnblCw+fXojbkF7ltedCS/QFJoOoR519JfNJUD6a9
	HhhFifA54aVsCDE6HXb4kElkmnoGT7Wv0gWM/iDMU1vsBn48RU+aMoqZSp1g4+SDLTpWJSMmKyG
	BRM2CasolDbwWJW6nfbKqeSr0e+MqeMQ4IXcAuv0v8SPv+T+8ue16QwERTt0bbvDNXzEqM3bLCm
	w6gnr9xAr5CO/+JTuXpwdUodokrMppdbYUuCrh0TTCa9WG6IjrFEtq5LZcrv88v+/miNsc7Zy0d
	TpIS1n1oIyT
X-Gm-Gg: AYBFou2O3qCUZbdCTH/8YHbFToc25Z9HdMiSrYFs+UGkUb+/f4K1XRU5zq93KY14n/z
	d2nln08DMmTr54u+r/akDJCMXp/VI7UuSO3qY9kPhLAjaAV8k2BseEdeOCN0LVkqUNv2Bd7ReAb
	CooPHllGUCCmVOSH5o0eBk/3GoLPfQp7Oyho+Hv1s9BH/hfCdJWoIdSqybAXaBfwvhl2lOEMSIK
	bTvdReqdGvN+5k5qTKxzJZcRQxptenrGhSTx4wAPZz8V34ceDOSOo9gVrqPmHwvZnh9byPkijU/
	X0438Vzso5kHhNUiXmI1sh9+5Ivv0uWpkiuwlqtIoY6novrqJUHcyDUXbSnDskkpL8pEOOSH4ZF
	3fWAH/YiSULogLuenlukQbh8d/kijXE6R8KG+c3vzEJO+QjZOWwHvqHhaO00c054wJ3JBcyY400
	ZlcmLNyuqG6mW6x4AOw2mzpK9o/w6gmrOpsbI=
X-Received: by 2002:a17:90b:39a4:b0:3ac:8897:7ba4 with SMTP id 98e67ed59e1d1-3ac889783f1mr1073153a91.5.1791997670297;
        Wed, 14 Oct 2026 10:07:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac9404baf9sm143366a91.0.2026.10.14.10.07.46
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2026 10:07:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3a767a22ca6so20514561fa.1
        for <kexec@lists.infradead.org>; Wed, 14 Oct 2026 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791997665; x=1792602465; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRm44gAiUhyrp6pDDNw26lB142siFftJgiu5AAj4cQY=;
        b=DlajZr/fda5xlTemqGzwTmXxpd6RIdtz15csEs46vjexpVzOfANlvWtG8uZmqXcV5i
         NNAfUt4VbmBTaZ5r/klT8uX02NmEX6jUuQcA6wAgYMu1s8oxMWDQ6sylU0QK7hi7dZml
         ad7cU8/P/AIu4z02ohvqt+AdkngbWMEXyjfbo=
X-Forwarded-Encrypted: i=1; AKwUvBzNT42Ow2wxIKYK/u19XtFijSq9GxrbjDzPB6DIGWymmpkHV0x+BZXYcfYM0reinng4xAmxFQ==@lists.infradead.org
X-Received: by 2002:a05:651c:b27:b0:3a6:6aad:be45 with SMTP id 38308e7fff4ca-3a9c54b789fmr36820621fa.10.1791997665350;
        Wed, 14 Oct 2026 10:07:45 -0700 (PDT)
X-Received: by 2002:a05:651c:b27:b0:3a6:6aad:be45 with SMTP id
 38308e7fff4ca-3a9c54b789fmr36820461fa.10.1791997664890; Wed, 14 Oct 2026
 10:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790014793.git.zack.rusin@broadcom.com> <364337F4-8127-4693-BB85-E0657B634B43@mainlining.org>
In-Reply-To: <364337F4-8127-4693-BB85-E0657B634B43@mainlining.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 14 Oct 2026 10:07:30 -0700
X-Gm-Features: AclHuK-pXeefcjtxG6LN0Usydz067LI9rz9CqzP8-9S0l3gWG-8eO_FkGWWqZ_g
Message-ID: <CABQX2QMX7yQgKwY7EnazH6ejAExx_hb2o8Vcw21E+kucYz=h-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] panic, x86/vmware: Preserve crash logs before kdump
To: Bradley Morgan <brads@mainlining.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004d4a02065dcff8e5"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_100752_132047_1BC8D4DA 
X-CRM114-Status: GOOD (  21.87  )
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, kees@kernel.org, dave.hansen@linux.intel.com, ruirui.yang@linux.dev, stephen.s.brennan@oracle.com, bo.gan@broadcom.com, hpa@zytor.com, pasha.tatashin@soleen.com, corbet@lwn.net, brennan.lamoreaux@broadcom.com, x86@kernel.org, joel.granados@kernel.org, alexey.makhalov@broadcom.com, mingo@redhat.com, bcm-kernel-feedback-list@broadcom.com, tglx@kernel.org, ajay.kaher@broadcom.com, baoquan.he@linux.dev, john.ogness@linutronix.de, senozhatsky@chromium.org, virtualization@lists.linux.dev, rostedt@goodmis.org, maaz.mombasawala@broadcom.com, bp@alien8.de, skhan@linuxfoundation.org, mhklinux@outlook.com, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ian.forbes@broadcom.com, rppt@kernel.org, akpm@linux-foundation.org, pratyush@kernel.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--0000000000004d4a02065dcff8e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:40=E2=80=AFPM Bradley Morgan <brads@mainlining.or=
g> wrote:
>
> On 28 September 2026 18:55:34 BST, Zack Rusin <zack.rusin@broadcom.com>
> wrote:
> >A VMware guest may have no persistent storage or working userspace after
> >a crash. Preserve its newest kernel log tail in the host's vmware.log
> >before entering kdump, without enabling every panic notifier by default.
> >
> >Following Petr's suggestion, add one generic panic_pre_kdump_list with
> >VMware as its first client. A set-once helper covers panic() and direct
> >crash-kexec entry. Fatal oopses can reach kdump without calling panic(),
> >so patch 2 adds that call after capturing the original registers under
> >the existing kexec lock. The late panic call follows sys_info() and
> >precedes the kmsg dumpers.
> >
> >Patch 3 adds Guilherme's suggested escape hatch for debugging kdump
> >failures involving early callbacks. With panic_pre_kdump_postpone set,
> >the list runs before kdump only when crash_kexec_post_notifiers is also
> >set. This can omit hypervisor crash handling as well as diagnostics.
> >The late panic call remains eligible. This policy is a separate patch;
> >I can omit patch 3 if it is not wanted.
> >
> >The logger preallocates an 8 KiB buffer and bounds its register-based
> >RPC transfer and retries. Michael suggested increasing the buffer
> >because 4 KiB can omit useful stack-trace context. Ordinary guests
> >enable logging by default; encrypted guests must opt in. Use
> >bool/proc_dobool for the sysctl as Joel requested. The potentially
> >terminating REPORTGUESTCRASH event remains a separate late dumper,
> >suppressed whenever a crash image is loaded. The v1 assignment to
> >crash_kexec_post_notifiers is dropped.
> >
> >Tested on VMware Workstation and ESXi with ordinary guests, and on
> >ESXi with SEV-SNP and TDX guests.
> >
> >v1:
> >https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com
> >
> >Zack Rusin (6):
> >  panic: Add a notifier chain for pre-kdump callbacks
> >  crash: Notify pre-kdump callbacks before switching kernels
> >  panic: Allow postponing pre-kdump notifiers
> >  x86/vmware: Add a bounded pre-kdump log sender
> >  x86/vmware: Add the vmware_record_panic_msg sysctl
> >  x86/vmware: Report guest crashes after kmsg dumpers
> >
> > .../admin-guide/kernel-parameters.txt         |  14 +
> > Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
> > arch/x86/include/asm/vmware.h                 |   2 +
> > arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
> > include/linux/panic_notifier.h                |   4 +
> > kernel/crash_core.c                           |   3 +
> > kernel/panic.c                                |  28 ++
> > 7 files changed, 321 insertions(+)
> >
>
> All the panic changes and crash_core changes looks good to me!
>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>
> Tested basic panic calls with Power10, in courtesy of osuosl:
>
> Tested-by: Bradley Morgan <brads@mainlining.org> # Power10

Thank you for testing!

Petr, do you have any thoughts? I think this version addresses all of
your concerns/suggestions from v1.

z

--0000000000004d4a02065dcff8e5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEFo
IJ5vd/MUhAk2bv3a6kGZnwx1m1lxJbC2yytLvdDuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAxNDE3MDc0NVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABK9edzXmHJsrnESInLkCDpMxAeQWV5jzCabkD63
GDvvFykL23/V0cxhOSPMDMCRC9nn0dsnVDcbFl9Zhc4DtkDZuXCbQENDMfMUSI/GePHHJG8YnjrD
2JWCESHf00TcVrhQbaO1r4Nq7xZtgMbLEeEz5zIB7hjmqikeVV6EyHhSloq+nAx07GaiUnIlZwoA
+Um86trs2MIo17ep5P50407bAKu5B9UkDlVvUWYNFpmBYZ02S+tKGkXM93HQ0hBzHbrwpTcko8Tn
6gqJzfNUh5LDuNdSF+L/WRZqxKEVQcHaRRsf16bPWPxCB7I+x++uf69cRAP2I0rYxLtm5Et7KXc=
--0000000000004d4a02065dcff8e5--


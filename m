Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B281DECAAD3
	for <kexec@archiver.kernel.org>; Thu,  1 Sep 2022 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JZCMtARI6l0Jld86D36FtRerrzdKXaosJ2Zg3mSD7bs=; b=xcQnZtWDdlvANjqRDteitDZ0o4
	4BqwWdbYs+QKrB87m7wm5hvO9Dv2emX8C+kH4zDKrNaPam/ZPUAtLrXnjAaw46dMyIZosoWm0O/ab
	4V2v91f018sciulPh5bW4TnryEFJlb/JlXtPujc7omabz4ub0F7HY6FCkA22xF5hezMumKYmmykED
	LcxZE4LOfpXMm9ydLOUSOKBor0bn1hpwPH0ATke3FnITeErTwJzQvlEEEgslP6DwZOejFSy6sIaOL
	qs7cj2vYxG0FnKOVw27FgMV/KjvrVD9NG7D1OWI2xEyDti3fjlv79E40LSLO8lX+7OGoFcHqDIx3O
	jRHFk3Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTl81-00CU2B-82; Thu, 01 Sep 2022 14:25:09 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRkj1-00HYlH-S3
	for kexec@lists.infradead.org; Sat, 27 Aug 2022 01:35:05 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id t64so1425574vkb.12
        for <kexec@lists.infradead.org>; Fri, 26 Aug 2022 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uE+exgWe77zMczfy7hf5E0ddBzA3BhKFGmxaOZBrMUY=;
        b=VPLoVwR9sBQEPMY4g5Z11tmv+o0OFwNv9TfsJ1F4ma7w79WTiW/1iN2wjrw1vKZ8bx
         viYikP5h2RBIW9++B1EHNxnMawjPetcvLiMW3SYO5pq88thEkUtGWU63dMNqNF9UJj9k
         HQujOtKTujkIN47iU1e7i2QcbIXBNsXsXlJ7qsmfoYfK1PFqa/6P53ejsCQDNoV8lLD0
         I2oBV5LUDPhSfEcjpRzSr/xTllJ3V38vFQiiyy8Pd9Y2irqCZw0UBn/oXotGtiUOP2e1
         JI0/ujuEhS4YtW7OmdEsA5Y8zZkNtT8zQIEikzug9B7g78vJpRrfg//+r2SElA+GeeaI
         unqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uE+exgWe77zMczfy7hf5E0ddBzA3BhKFGmxaOZBrMUY=;
        b=062CL7WkpFUgYYD8pDZgyKTUy/rGJUVeC+H16CadB+A2TkUt7LgT2D1rHsMeYJtafy
         rBjgYxGT8nbnOUPj3aW6+HOGmom/yll5j/BSWGzzSHq8FjvSRqbAaJndQ48A8aVCRArF
         BP6SrUyjW2vB41XzZ22xIKZO6XZy++giM2IR5DLFHu4oHnQ4mAgZVtG1P7/YWRtcc6u5
         IxYMzsk8HPt79unOrXjmrPHonq4nRh5EUw1xbQ/kxpG6XlXHE2aBh1dC6h6IlP29fqyP
         OXZ2NKAEnHNcQ9paioM/eekp/abi9nt3iFpxyWU6702pQT9HhRm6bDEln5AcU6oxFKjP
         UZEA==
X-Gm-Message-State: ACgBeo2vIAEcs1/kCHsDYDKa1bOQweRkCQ9xKo/PzDRW10yueHauKqpo
	YVVN/dk4vcbYNgI+8ZuaSMi7PGmYj+Ne4bSsxP1aZw==
X-Google-Smtp-Source: AA6agR6676kPEu/Rev8uWZa5ZYlMoLTmvo5rd3tPzM8wt5AUslnUJFy5aBd6xqx6TXoMybSzZ3rR05p2w+9Q4niQfNo=
X-Received: by 2002:a05:6122:178a:b0:380:c120:6760 with SMTP id
 o10-20020a056122178a00b00380c1206760mr795027vkf.7.1661564099282; Fri, 26 Aug
 2022 18:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220825154429.6169b270@canb.auug.org.au> <05664203-6e3d-1417-e28f-0389437a8943@infradead.org>
In-Reply-To: <05664203-6e3d-1417-e28f-0389437a8943@infradead.org>
From: David Gow <davidgow@google.com>
Date: Sat, 27 Aug 2022 09:34:47 +0800
Message-ID: <CABVgOSmNJgKZ4x-HgON3SB8av=sz=R2wmsUoo7N6wZ4V+b5crg@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 25 (kunit: virt/nitro_enclaves; also kexec)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>, Andra Paraschiv <andraprs@amazon.com>, 
	Alexandru Vasile <lexnv@amazon.com>, Alexandru Ciobotaru <alcioa@amazon.com>, kexec <kexec@lists.infradead.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_183503_933433_D099ACFD 
X-CRM114-Status: GOOD (  15.88  )
X-Mailman-Approved-At: Thu, 01 Sep 2022 07:25:07 -0700
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
Content-Type: multipart/mixed; boundary="===============8739020159566805631=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============8739020159566805631==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ed1fc805e72f095c"

--000000000000ed1fc805e72f095c
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 26, 2022 at 4:18 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/24/22 22:44, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20220824:
> >
>
> on x86_64:
>
> ld: vmlinux.o: in function `kunit_kcalloc':
> include/kunit/test.h:369: undefined reference to `kunit_kmalloc_array'
> ld: vmlinux.o: in function `ne_misc_dev_test_merge_phys_contig_memory_regions':
> drivers/virt/nitro_enclaves/ne_misc_dev_test.c:120: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:128: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:128: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:129: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:129: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:135: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:135: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:137: undefined reference to `kunit_binary_assert_format'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:137: undefined reference to `kunit_do_failed_assertion'
> ld: drivers/virt/nitro_enclaves/ne_misc_dev_test.c:141: undefined reference to `kunit_kfree'
>
> ld: vmlinux.o: in function `kexec_purgatory_size':
> (.rodata+0x209ee0): undefined reference to `kunit_unary_assert_format'
>
>
> Full randconfig file is attached.
>
> --
> ~Randy

Thanks. This should be fixed by:
https://lore.kernel.org/lkml/20220810234056.2494993-1-npache@redhat.com/

Cheers,
-- David

--000000000000ed1fc805e72f095c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB9
sgiwKpg9BWCisMK40o/9zEdgvHxhms9x2aHMJzTQZDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjcwMTM0NTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAqc/NXpo2Q8vY3pKg46Rx
mJwoK4l5CQWXAcrcsC8CE0TCrWvs+dg/z5vtnaWheztS/JIQenYlOZQaWTRgGWzSQjXbTJr6+wiQ
P4RWOzSEln2HWrMvu0o1Tm+Ji6nppmz+AhK0wAGEqaqYAFEeNm4d1pyV1gqj4izIfkw2QhPZjZfk
XUrQir9R4mtzJZggZL7lbz6Jtkzy0o+B/rTQWfvBkfVmQSsrPI3QgIwEFtid6JhtdoCbHp1TaE0e
UXE/zbos4jPiqiWESvPDnDa3bSBFWFhbLKbvTtXYQ1SITF2vcLViBTnIjOHORP2X7BP5ahQTNNzQ
vU/Yx1PIRDlH7c9/PQ==
--000000000000ed1fc805e72f095c--


--===============8739020159566805631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============8739020159566805631==--


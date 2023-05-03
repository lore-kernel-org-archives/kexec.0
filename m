Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE18C77B75
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:Subject:Cc:References:To:From:MIME-Version:Date:Message-ID:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5jpXKfyer2LdlisucqDM02cH7rlXh8eC97wGLD+yGc=; b=u8vfgaNzLui/jzilmXLaplBeSJ
	wlQ+rXEQw9uXrIwwkqDF5YRpsiGEFRmvsWmobP8op0kOADM0JI/68CqsVk1FryF+uPA82sEnZeyaD
	xvg4bNTZToj1oEDRHrR/U3WwKCTyr+KPb8zuSh1tCgge6gyDvwJ/QF5ALFkRlY0LUmZhE3iBg2Cbi
	FzFcPuU98CrW5cD/zW6nNqT+97U7NPH/9qtP29Z0W4L2SVDOzAXALr9xbHkkqOexwnxjoHJQiLluG
	RMV5NZusUAeFyMg/llDL8DmOJltu8VD+DbMeAcm0OcU7A5KmfBUl8cZKfoK0hNL+xwS1MVa6P6h3D
	pRIiESsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puGRc-005ISY-2q;
	Wed, 03 May 2023 17:39:12 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puAtT-004QL2-0X
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 11:43:36 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f315735514so20089905e9.1
        for <kexec@lists.infradead.org>; Wed, 03 May 2023 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683114212; x=1685706212;
        h=in-reply-to:subject:cc:references:to:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ4fZrYSYjkJwzZCU1NJgVwEm1aDXHIjKh2AApf5vpg=;
        b=E8WX3Mo4AMjtgkP25A2DLi05AW02WJsMvWexu/hmHmmAPS21CyCBYgtCJRQSdwI3CR
         TLfdn+Wcv7Gf0TJTUWDA0Z/QQraS1YAckuGvX3l+OEV1Z7sLH0Lfm6cBTk4b+9c4YRD6
         sHDpHdbMMxmAF46s+g8UmvyZUseq65wBvHPz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683114212; x=1685706212;
        h=in-reply-to:subject:cc:references:to:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ4fZrYSYjkJwzZCU1NJgVwEm1aDXHIjKh2AApf5vpg=;
        b=dM1mgBRcgfI5wIWEHSX5fMoBIddfvL41IRy+aIfkzyFAhUa+deQM6eEySu3Aub3qNo
         B380GnbYWDd3A2SGA+9HBAvehBj1eKwY6VMy/vJytGpt7thZy00dIseVu39d/CN4Hk9F
         o6QKxBr0/0Vw6umediThuF4LIPW0Xf9omZ9EuBCgAgD6FBrEvLrBjSyW/J62v8jdtBVq
         eHDEVhm9pu1AFOYiD+I5ve97efA6/KbfIOfEvqaw8FFFPxZzTRKDPgswbN6xrv+OE1X9
         DZ9iqeQkNxMSFNoKPQXTEZccL3yc4q9lyie+NLsnpAkPaVEqNIfm5jNjHVi5tTfprR7G
         LXRA==
X-Gm-Message-State: AC+VfDyEs+fJ/VkTMktun4niAw/3JmWK3GaOLfUltn2ZxDLuh4fDcec+
	efUQ1ACp2wgewiOeso1ayfdE/ijL+6ee9xoLtzDCQucphjCKURV8kl8kdjq3bdVIlZ2WI7T/61p
	msULYA061zQrpCc9kfiodaGssbVhx5qGRuw2DhiqIDMg+ujuGhfdIKlVmH19Xt7ESGOWJ5h8Fdn
	VYntE6n+HYRYHZtR/zBg==
X-Google-Smtp-Source: ACHHUZ5T5U/BoZJf8uPD6JP9kgUleHDmI4DwxS3mjoz+PZAERRLDHYK13QrEC0It/QVRKGCuEyxUIw==
X-Received: by 2002:adf:ef4d:0:b0:2f5:9146:7024 with SMTP id c13-20020adfef4d000000b002f591467024mr1397924wrp.22.1683114212198;
        Wed, 03 May 2023 04:43:32 -0700 (PDT)
Received: from [10.230.42.27] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c0b5700b003ef5bb63f13sm1682291wmr.10.2023.05.03.04.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 04:43:31 -0700 (PDT)
Message-ID: <ce9aec4a-e8fe-56e7-dc96-0180375f7c37@broadcom.com>
Date: Wed, 3 May 2023 13:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: kexec@lists.infradead.org
References: <b4ada33d-f6a7-ad32-9de2-51968ea29af9@broadcom.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Subject: Re: 64-bit kernels and 32-bit user-space
In-Reply-To: <b4ada33d-f6a7-ad32-9de2-51968ea29af9@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_044335_280594_18C5BED4 
X-CRM114-Status: GOOD (  14.49  )
X-Mailman-Approved-At: Wed, 03 May 2023 10:39:08 -0700
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
Content-Type: multipart/mixed; boundary="===============1486312887857488538=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============1486312887857488538==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c1735205fac8901f"

--000000000000c1735205fac8901f
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/2023 2:55 PM, Arend van Spriel wrote:
> I am trying to get a kernel crashdump on an embedded router, but it has 
> 32-bit user-space while the kernel is 64-bit. I tried something simple 
> and got following:
> 
> # kexec -S
> Unsupported machine type: aarch64

Clone the git repo and looked into the kexec message shown above, which 
is found in the function physical_arch(). It basically does a 'uname -m' 
and does a lookup in arches array. The problem is that on my platform it 
tries to lookup aarch64, which is not found.

Regarding the lookup I see:

	for (i = 0; arches[i].machine; ++i) {
		if (strcmp(utsname.machine, arches[i].machine) == 0)
			return arches[i].arch;
		if ((strcmp(arches[i].machine, "arm") == 0) &&
		    (strncmp(utsname.machine, arches[i].machine,
		     strlen(arches[i].machine)) == 0))
			return arches[i].arch;
	}

So the second if-statement means any utsname matching arm.* regexp, eg. 
arm64, will return arches[0].arch from arch/arm/kexec-arm.c, ie. 
KEXEC_ARCH_ARM, right? So can I conclude that 32-bit kexec can load and 
execute a 64-bit kernel?

Regards,
Arend

> Looking in the build directory I only see arch/arm/ folder, but no 
> arch/arm64. Is this due to 32-bit user-space? Has someone tried kexec in 
> such an environment? Any pointers would be appreciated.
> 
> Regards,
> Arend

--000000000000c1735205fac8901f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCvoOBYvtAXP3gpguog
hsHaFinaVsCmTFE+v7Yv4ZNt3zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzA1MDMxMTQzMzJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkDfzVFmu0+kb6j3Lp+uIBH1dfRzAQBZmb4rd
bVkhGibH1npMwcY/FVAsOgA8IfHcByKmHp3Bus0nbgueLaZcxHSTQT5zlYkcPXQSw7BCEvArr/fv
xuFP99M19jT05tZxENk9ow7YsJn4RRP0jQ0V3HwOgXAhO2P8wIBZBszTAY1xo4ugXxHLbRk0onBm
cuHi3IV4+5BICE9F3ayQNk6amTrH4qkMRmPOQQlBqjmYN92EW1qk4qVsrHe9D+XhbFqnSUe+OhVe
M0x7I9V6Q2VRWfx75Q9AHnXKx5215BMyLaF+W/DLyMy3aEMbO0qHYiWGU1D/KfR9CY44fzSc4qcj
0A==
--000000000000c1735205fac8901f--


--===============1486312887857488538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1486312887857488538==--


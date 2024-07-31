Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9A1C3DA64
	for <kexec@archiver.kernel.org>; Wed, 31 Jul 2024 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:Cc:To:References:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Io+FbRQrgpw9oCPIk8WzCiKwXvtPatL/mwzfwx4corM=; b=OAZbn2UkVcRIk1
	4cjlnbOlNtNboefHhMYirIKHRSaFz2Qn4d7D/eF/vkmFbEqXfHZUXS0mdz9YY6S2cAvGteSQf+v7p
	41dThivDjT8IKY0hAV/YFsqdHIuwm2fkZX9hxn5/WTFkg8bJb2mOGI6QR8cAO8KYOU6jTPHhnnzan
	zPdzXzneVq+0FK8XS15591FsSIZgchsPnh4pBesx46+0dlQP0xIycMcSxTzpfjaKvw63IoSgL0D3z
	NcvjUdI0cLOVGwS5Jm+1r5zjPvT1dNwAX+RQwcR9oF9ltiRi8EIyns7g5KGqlLmkpNojjRjGZzHP3
	LxwMwP/Oo+MbXmK10mmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ9AI-00000001GMn-2QaB;
	Wed, 31 Jul 2024 13:14:50 +0000
Received: from sonic304-20.consmr.mail.sg3.yahoo.com ([106.10.242.210])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ9AF-00000001GKO-3Yv1
	for kexec@lists.infradead.org;
	Wed, 31 Jul 2024 13:14:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722431683; bh=U/HbpM1FC5Bg3pobmjY/Fz2MFMFcYL48D3PoU8/ByRM=; h=Date:Subject:References:To:Cc:From:In-Reply-To:From:Subject:Reply-To; b=mKm1VYXrSa2tCry33oSu+o9uWZOGu5rGstGzvmtMcz/Wd8MPxjcu3HbZ0C7W4fumcLFTk5X8STmhrLiv0l+DNNPfep+FKU9+DA8QhhnkIc/J07wKNjJrfDSuiusjlJv0SIJosedCnCUHj6Pf0+S3YGvmxVqXNivB17VYn1Btsg+6cvSXin/NXRLKPj5rZa038p4q6EvOSSxdJEzDI8cVwQCDZ7uKVe6e1pvA1dtL3H2ucVcWFj6s6UPUTaIdxvyx+39CMymLd/sHtvCBzVcp68iaTd2kfhmhRkZ2O/gbFDVf/f8Ql359mJdGgIj6ezP1/Z7VGozTfLH/TBAJqgWIgQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722431683; bh=PRCp7gX3sDbZYsLhhPmnGigEnfeWEyVobe+wnSfCAy+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OfI98yjlOrCS795UjOmc82/I1s0DyzBARAHBWHNo4c/mKDZJysd1GF8gnsT6pVFS4Jhyccx8j2B4v+qH6Qw5GQTxqpCu8oaLxp0urwhL1BBxnsB8O7busVGZeJu5efwDGFH/C0lc8g7LYxG/Gy6PxtC9CZ1RB0G6QwNNhUAXRO97TnmT6P2dcq8qC9Ns6k4G92lH+jWJwPUI2M0ecQl5WLDPOLhQRM0afdeZ+mqP8f6UzShHSdBULCMDQbANinMTWWniRwq794jrklOTqQxtdoMdS7p52kyF3GdAOkOP7z9PYmXrU4NFp/7FaZ7ve7xYXu+GwgsrO8chXhiVQdfA2A==
X-YMail-OSG: rJhMDR0VM1lQMCliYKhhSS5s9Y1DbVZ2npzBRsmegRWNTf6U5QJ4Fu2bVXF2RO5
 Her5q.m.7YXwhdQR_by7QQ8kwQTsqRocep6fxKomiR2BFeX.IB.lxjc7fo2cvXguHwHjVc5HUfcH
 g9FAoeJ1o0GMS6GBQYFEFmp4.jFJ.e.ZtRGiIBnPIbdxOLV1GW.WJqfFK_bzDDmGhJSGDqNkHM2p
 l_BxazYL6KjeBwnFGNah9Q9rehri.KyJbQk3QvhGB6ppGudN9dbZ1N61TWar0rJjZj_FN8U2s1Gp
 5NTbTJb3oQeunbZdLsqRxVpQ4FFESMSPkSJGqF60NZwZ21WrWveu9GVuIEafa5F4BpfkMDd3_Qzq
 CYDF101XRReDgRyJByTD1iGiv2wl3cCKf7qX7a6Fm7K.7T.x7u__71ziLrrw8xwwC19.JMHjjH.j
 V.3bFjpGz8KUAH4jgrRu7_pu_unLJc5MAPLwfnBjIQ4cImtYE.LhC2dipWBx_mPEdLSZXU16sAZd
 sziIALpcb0xJbupIz.qRmjYo1nJchKvWl0xBCwG2R27.K.3USpR0F8LTIQawUlfUVD5_QrwTVpW_
 SWdnnzDZWzzGJfG.OqRihxv0mccmFs5AQ8RFvleMUVt.wYle.wUXJU0igd0ao9PfHfIPfasTybsv
 OWcYv2DWxw5VAfel.IMNNpSjIKie5.hh3NfNvH2yqq1lqACCURXUcWZ629ZrOfMniNVSQVI9F09a
 ._2tkO_HOGr4yjaKnmssa9LqmXkIT96ufJYD.JeCVlESEmpw.f3ER8lL70c2Q2KXk7h8Hgij8WGG
 sbv6i6EMH5qRrFRGDVOWjdfemNpcLbMx3bTCAcU_LiP5QIbNK4cFT8vvWFBk.7VnO.00yBLyymVJ
 BFQABH5KBKWW_ScimmHA6n8lmuHJoNKE0eHtEn5a2dabWz1bpvjRypa7HrOP0EVQuksD_YY2PvlS
 AvEWWu2FpDkV_CSIbXUgGyioTMB4tnqHnUKgAeLf8o0QcdnAgmGdNUI_E47TlAW6pQdsk.TKypqz
 AEtCUjQVhEbXS465xh_kt1LNtMEYsmi4vxxUG4GQXq6t1K6axbMRwdTKr.q6FmHE4IVU71udS7ww
 YuQ_vBGf8UTEDg_SgwFgf7UevEV2x3iEgfwbNjyeffeH5s38Y4PI7V18bFPQmKSuIUrKzpAgARzI
 Pqs5LSeKnBC.LE0zu.BVUIc73w05W800RiqhvenoAyJ4W2eaHaGQlifzC4ztGZkMHHo6TO79GbDo
 .Bq92PJzeNCFjSQHrO6wAfVJL58kO.mkfmbe59Q87wEQCRC1I9Y7_Dp6AXKZr_JzWdtcHiEe70X6
 ZOV4nHvBqS36XdX8gahWahwjumpOfDx5qzdfdZGUGcYki50LX.kjY12FwapCPKGEDTMOErQP8S6x
 h3xI5vC7Eidmhnm.h0LnD5lZTMf9n5YSwcom8kdxvtBuROZBmZktC.Y8EeD2slkvgH2IeZQT2UkO
 67gQtbgA_dB_cnQJRz2hUVjw8.Kv5C7JWOgvt4CAuHCXTCT0hubTSl9YMyKkos70ONjrxqh5DFe6
 ZkijeJKe41iG0wfn1_pfZZWOH7deWwoMs5C9BKEB4NddPoz4urMg4Vi06n.wRDtV1QPj5yYO8rkY
 f5h.e9f9jiI6vNYS1FD8C1rBOmXMUl8UEdxHN6fjGs1Gq41liJYqnUba0ZHB7DAhAWCtIKLqVeAZ
 E556joisOj5IfZCOB0uzC5.DAt18tZbUJuikEmcDhIdzPk0sz_bub5yINPfrZj47eRNgNhlJWu9i
 yRY2bW0Di3g5_8i41YYZJxzWT41KzDQdMZ0iEaxU8iFJal.R_urJvc_gm8l_htJjxH1i8Msq9Zbh
 8OsfEyVbuUV35v1Sb7GQkNqn8l5ureCctqXHk_49D_4YDbm0Doy13GGhhI1MeppDpjDsz.aPdOLp
 mvUgVckOd4aDJ9A1J6tOztXCIIz_rSapTmkYTcgp.9tr5Z5mbVXXKYE0kY2SO8Vl0UuIrYjkw0PG
 9PwA1QhKx6ohoYIwvxLcbK.nTivmOgw1iU6PseGW1UcIHcc4hs317Eg2cxkBjBzc8QdQdWCBWRZj
 3y.XDjTT12fy8GQGhevauPPUcT6OTV35JTcstClNKix3JsSJCiw0X90lIWcD3ky4BZaMUQA9MjcV
 pWDw8f4wf7GmxfiFUcd3Oo8VsLrfcs10GS6xC4TWdSYEHAC0XdpMsEDsFBpBsN8xNu7ifOU4-
X-Sonic-MF: <avikalpa@yahoo.com>
X-Sonic-ID: 6faafff8-1baf-4c05-8641-a652c2c8e72d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.sg3.yahoo.com with HTTP; Wed, 31 Jul 2024 13:14:43 +0000
Received: by hermes--production-sg3-fc85cddf6-kdpzj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 41958dc54f5ab0c10e41b1e18fb7b525;
          Wed, 31 Jul 2024 13:04:36 +0000 (UTC)
Message-ID: <cebc7800-df78-4f90-9f8e-82e3f9120b6e@yahoo.com>
Date: Wed, 31 Jul 2024 18:34:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: kexec failure with Xen 4.19-rc4 and 4.20-dev on linux host
Content-Language: en-US
References: <05395ed2-3bf3-4926-8e24-c2e7ff37ed26@yahoo.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
From: A Kundu <avikalpa@yahoo.com>
In-Reply-To: <05395ed2-3bf3-4926-8e24-c2e7ff37ed26@yahoo.com>
X-Forwarded-Message-Id: <05395ed2-3bf3-4926-8e24-c2e7ff37ed26@yahoo.com>
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_061448_103844_FF27AB0A 
X-CRM114-Status: UNSURE (   4.13  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

I am experiencing issues using kexec to load Xen 4.17(debian's apt version),
Xen 4.19-rc4 (compiled from source) and 4.20-dev (compiled from source) 
on a debian host.

System information:
$ uname -a
Linux host 6.9.10-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.10-1 
(2024-07-19) x86_64 GNU/Linux

$ kexec --version # compiled from source tarball with ./configure --with-xen
kexec-tools 2.0.29

Steps to reproduce:

1. Set variables:

XEN_HYPERVISOR="/boot/xen.gz"
XEN_CMD="dom0_mem=6G dom0_max_vcpus=6 dom0_vcpus_pin cpufreq=xen"

2. Attempt to load Xen 4.19-rc4:

# kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
Could not find a free area of memory of 0x3b6001 bytes...
elf_exec_build_load_relocatable: ELF exec load failed

3. Attempt to load Xen 4.20-dev:

# kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
Could not find a free area of memory of 0x3f8001 bytes...
elf_exec_build_load_relocatable: ELF exec load failed

4. Attempt to load Xen 4.17 (from debian rrepositories):
# kexec -l /boot/xen-4.17-amd64.gz --command-line="$XEN_CMD"
Could not find a free area of memory of 0x3b4001 bytes...
elf_exec_build_load_relocatable: ELF exec load failed

If you need any further information to investigate this problem,
please let me know.

PS: If I used apt's pacakged version (which might be compiled 
--without-xen),
it shows,

# kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD"
Cannot determine the file type of /boot/xen-4.17-amd64.gz

# kexec -l "$XEN_HYPERVISOR" --command-line="$XEN_CMD" --type=bzImage
Cannot determine the file type of /boot/xen-4.17-amd64.gz


Thank you for your attention to this matter.

A Kundu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

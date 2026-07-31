Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E470C54F54
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:References:In-Reply-To:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jq+nLm6uX3d7hVP9cxc5fqV49Heu7K0WJkC8omzG0yg=; b=uidAm//bFb17QrGHGgYFYJjG85
	hLKKE01fto4lwska4rkOGCVnc5qMc5CN8XQ276PcTbUUZRttk1tvQHl55O109hdOrSIUBKoqUq0e/
	wmyM4eBvzW5tuV2mWw2yA481A5eYjAkprKQAqtYsSzxJ2ccOGt9LAX8YZ1FsjUr4Lh3+qpmrCquNv
	8zaNh+aB1mtddsDRHEF1q2OH6/uWlMxVVgjEzLwmsvECctGlPXvLFpA2R+B+alzL+a0IyzZDIQ0NL
	1cUN5Y15yeWgp6/7A8FpW22NL1vC4fsDS41MnQbb4foAWOcXVeiNv1jIUMoS7+GJEIAzbt5+opUjw
	kHOURr2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpn5g-0000000Cav4-2HXu;
	Fri, 31 Jul 2026 13:15:56 +0000
Received: from mx0b-0072dd01.pphosted.com ([148.163.152.74])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpn5R-0000000CahQ-3mMv
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 13:15:52 +0000
Received: from pps.filterd (m0355331.ppops.net [127.0.0.1])
	by mx0b-0072dd01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBKt8s1229129
	for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 13:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coreweave.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps05102023; bh=jq+nLm6uX3d7hVP9cxc5fq
	V49Heu7K0WJkC8omzG0yg=; b=ZfDROFE0KE7MTgKzqz1kK0W/6OLMhlBcTA7YFx
	Btd8SHEeNbSkEOQ9ASbiaNRm1Tat2SLwaR45vUJWcsHSzttK83ndLFxMN8EEIJ/9
	gnYYZ3QY7g3E8iz7gAQAiPTYuLuvnUPeuGD58lcqyB+5jpIziKnSj+WWlHTZ1bfe
	9KuZbpFOP/KwBrzdQJp8X2CTuWad4HfOgk3dQJos3hyZERnqpRq5r6JkBFX9Jn+7
	3aykNB/7U+2uHYjyDBlYcYsFu5WTCt1VOzRJ2gz8TiGOHpdda5mdmU8tTEgOCrmh
	Hn8fSABmik10gKmURWpTqFPrxsd7bK8u9ZIMF2b7ADEBkqdQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0b-0072dd01.pphosted.com (PPS) with ESMTPS id 4frmd70w0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 13:15:22 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-669260a87f3so2047704d50.0
        for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 06:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785503717; cv=none;
        d=google.com; s=arc-20260327;
        b=ZrExwLinzvdgIavaeRxe0a7n2C35iM0w/DHUYorM5ql8E2WmkFG5KEO2I/tnqdxk+3
         pUoRRtFQzOqNTAinrbuq7GxkqRqgqLWCMP7t9kXQef3qFZae6DRz3dTMJzISQzagPD1o
         24SOpIQ2DHSB0zBmaXccrWMdtAJNTvg6t6Kmmv2qdIqDci+SpGU8fI8LNoWtboyG57Ls
         MTPmXI9WBg046BTL0xl/QiPGax1x+WfqzCzija9keeqShvmI5c/gETTlO0Dd0IRxqtew
         Otw0wdZGOCzr5kjF5Sg00mqw5Xa6dnWLHn0WG+yLproolWUUMI23FSqMhDj2zXmOMsRf
         94HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=jq+nLm6uX3d7hVP9cxc5fqV49Heu7K0WJkC8omzG0yg=;
        fh=h68HAU2StIxrDWA0tyrptrs+cwP+g9AOoiRhUhQxamA=;
        b=DbfU7sCq28X/GZnL8rwoi8RDSdw2905aCI+9KnlBeM2l2lODKTRerCU4/k4yuZSWuT
         3BpixbgT2RXEjpeDvgnjNZaby1ye4xxxNet9b42dxteSc9ClsQtv2/WeQXl8zJHUbClq
         +5bhCZ1Bn5BRhFaUL5Id9EqamBYm8mMkT8SYQMTB7DCy9zmuyuLQgtgy5/w1/y/wRCcu
         GW+6hsd7/Fu70m/YCIzsfjQf/sG7cuqFRNIy7q4TGGAWGqbEh1x53MIWM9aB0fpZ7jLe
         Qa+/m+SpEGVpmWO7LBPwRobdOcPOC/J5DANxi17f1wf9/BbbvwTah1e/3xYl2E5KUN6v
         lT8g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coreweave.com; s=google; t=1785503717; x=1786108517; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jq+nLm6uX3d7hVP9cxc5fqV49Heu7K0WJkC8omzG0yg=;
        b=K+fbxbhFMAOlxorEFLvJnPEok1oCNpb7fz/Q5sph7eeIySw5BYOSLZoCz0sPU4k0+h
         ZvjhIeZENJw3eLdg5teABFIZtF9xkahmbhuL9mZ7slSE3e55ImxuCQMva4YMqmjiYmXd
         MiuwV04pppXGXXiudFNjsP4B5aJtxlyf7oPczd5yuryYNJ1RHla/CaT48fC2puEKx2EA
         721JxzkG7SEAAaGE3kuMd8rnsRthfAnWND2Gljfe3Rzgohk4NUTaI4PcQyX9keIq2tUv
         8yRZjO+Y6Nzt4b/cp+T0wgmmh8r9MZPHfzxWpHvfGhnZhfIeJ+gd0LgWIExTJxa5y9iu
         1qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503717; x=1786108517;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jq+nLm6uX3d7hVP9cxc5fqV49Heu7K0WJkC8omzG0yg=;
        b=O0tsEeQUzm4mPJBBh3c2FrkaBDqPNufAOZQV3QF92Jp6HXlH87hmcW8n7cFxa0zhQx
         YrikPvh1XQtFIkkHclKrDsthJjSUM8QWPBPkZgqDpP5xFFGEZbjohdeoKlLgjqJCgH2p
         8y3n0m6oclY2j0dAsXiaLspIKfpcygQMV7zDx5IB0CZg9Qj8F30Tq9zN6qYo+Fd8+rT/
         bz7giQLFemfou2QR+AxbcGwOg4e+x/KF3ycG+ldqsqBdKUf5x0PsWssgpyJKAy7bi39i
         dlvveC/9TIp0Pu7eGTgqEMYlcOOK3kfQSVfZ5VcABlBzeiGLZhWjB+5ZsyQgua7NUZUc
         DkiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7h3Wn6YXa1D8DQGGuMjLovyNAaTj4e9MToNnQ+jcm1WhCPey7FTzdAyGmQ8mr17K4P7/oIA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEzyzttsmjqC5r/e+T2yVsGyxmtuea6iQ2Syp9ZURllsWhVxWp
	F7yvkL+SED8Rq9ycCYi5cB566VuBLqEc7uKquWWpQr9yVUN8O+IznizQts1bPX7XmiiJ8fdWW/g
	EkrRt90H3uu0M4f07DdwpesgN9jSI0jLPZIWp7Iv8d+Zuu4ie4D2wTx04Ogk0NrmTn/BHZ0Ujz1
	jDOt7hnOsi5fY1NblzQheu+J+xELxJzsRQ0+VkGU0LoT8Tfw==
X-Gm-Gg: AR+sD13pAI1qEqKQD5tuxW3u2JTEilZhQuJCWJ49ES+6kJ4OiCupeaXIWVYZZTYBp43
	ChZFis7d03H6MZR3LGeGQMLggr/s3AdnFczZKrXlB++/0SQOAF0rNI28x6iQ5q72viCR7bBNPHa
	DNqsvQLRI2SFi6d1+zcD2QoMhkc/0OaLpf0rILwUAe+mnVpKbicUWdG4g=
X-Received: by 2002:a53:a702:0:b0:667:c3f6:3810 with SMTP id 956f58d0204a3-6694559445fmr996738d50.49.1785503717393;
        Fri, 31 Jul 2026 06:15:17 -0700 (PDT)
X-Received: by 2002:a53:a702:0:b0:667:c3f6:3810 with SMTP id
 956f58d0204a3-6694559445fmr996727d50.49.1785503717034; Fri, 31 Jul 2026
 06:15:17 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 31 Jul 2026 06:15:15 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 31 Jul 2026 06:15:15 -0700
MIME-Version: 1.0
In-Reply-To: <87o6fnws8r.fsf@jogness.linutronix.de>
References: <20260729-vmcore-dmesg-stream-upstream-v1-1-a00b5d5489f0@coreweave.com>
 <87o6fnws8r.fsf@jogness.linutronix.de>
From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
Date: Fri, 31 Jul 2026 06:15:15 -0700
X-Gm-Features: AUfX_mz3pj-frIGXsrKCOouhu1euNf61IqGB_-E5-vm3hPtp2o8Q7K4vh-1YoKA
Message-ID: <CAJuCn-h_FMhMv97YZwB8gHEhXh3sNxB=WprNXyqkKR8xX+BgHA@mail.gmail.com>
Subject: Re: [PATCH kexec-tools] util_lib/elf_info: stream lockless printk
 ring records
To: John Ogness <john.ogness@linutronix.de>, kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwMCBTYWx0ZWRfX69pu4wWAjh3j
 b3fsisUFo7sv5wJA7xUZOK9JbU6i+xVVcCtThOnJLtBmBAbV8JnbYGputKVINcmC/NZUjCHWmsI
 9H+yknP7R8yfak0WYq0zgy3yoZVYLoze0WrjKF4A7AyBEIBEp2sdfwfuS09w50AVsPSX46PqGjI
 kjx+3Iy2MOQUEJS6mIlU4ndFy6RA2EB62F1+w2zHDhHIcFMblSm65WmTIQ5ISPBOpmBuVnVHStK
 4b5K1sIih/uSL3bHXZmsl3P4zbg0zNVmfCEjrHtV3EtlrhgtI32pJpHlXWwAMDWcIaKH6d9XKD/
 AtBXj3mCJH6qyqs/V3WztMC/yeY0xQWv6GrQpLCsS9o4ehYhbH7EYFNhcIo6RH2ooctK0ghZsn+
 eY3bLrx+jJtQWAj4la341fIVLnDvQGtUAL5QTd9CqjY5+SZYQCBseRKesJnYxthuyAKlnS8ZFKW
 Wgt9B3dM6EpnN7hhfYg==
X-Proofpoint-ORIG-GUID: 6-PmE7EofMX2WDvO02JWPopQ5fMg8Tq1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwMCBTYWx0ZWRfXyEDewiYCn3Mg
 lsmRVdt5oWe7NhVj4q/8qT+DnL5m6WVgK9rFTLrd/1zpz9V3tA4dKy4r9dgTEZm6ltWr6qP3tkK
 TualYFDPUHLqkydNyQm9nYs4c6TcHMhuiYDhjQlFvHsAZWaWvlUd
X-Proofpoint-GUID: 6-PmE7EofMX2WDvO02JWPopQ5fMg8Tq1
X-Authority-Analysis: v=2.4 cv=A6Bc+aWG c=1 sm=1 tr=0 ts=6a6c9feb cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=vOxYucsElnsA:10 a=l-fz8MELSNkA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ahbaqjHlhroLXWnmo6YI:22 a=49RLrBNox7jfN7ZIe-09:22 a=z_gs0eTbhPHkUdGzM9QA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=tnEk9zUDK5XSKFvBmtre:22 a=BYL-pX1xYmNgx-yrYO5N:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_061542_065920_46505390 
X-CRM114-Status: GOOD (  13.20  )
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

On 2026-07-31, John Ogness <john.ogness@linutronix.de> wrote:
> Is that really a problem? The code would be much simpler and easier to
> review and verify if you did it this way.
>
> At least, I would expect a patch that does this implementation
> conversion first. Then, if you really need the caching optimiziation, a
> second patch that adds the layer of caching.
>
> Also, I would expect the caching to be a generic mechanism that can be
> used for all kcore reading, not just the printk ringbuffer.
>
> (I do not have any authoritative role for the kexec-tools. Just sharing
> my thoughts on this patch.)

Thanks for looking at the patch and I appreciate the feedback! Your
suggestion makes sense. Let me draft a v2 patch without any caching since
I mostly care about bounding the memory usage here.


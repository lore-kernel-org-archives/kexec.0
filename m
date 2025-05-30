Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFABC5B552
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eRxoEOZMhRODJSYZJ+F0wZvNK0em7c0dCwwEsoHNqDU=; b=ReMquNNLfsSHBXTA63rdTydtWB
	b6Qic3CwpWduUkzZboBocqImjOIjHy0gpBlo8X+KuVtjBiOMpZOGP68/avb84b6AgqDw+zn+/vGdE
	8TUwnUOeM+T6ZNoCGux/XAk4Z9xP/Q/SXKrg6mrGm1R0tdAnY8IlVfP6EvuycmJYnM1XzaUm/ZJ1A
	PbOd2TE+G/KAslhkr6c5vjDRWCpLBuasH6Ik0wzbytKplo7Z1Ypm9MsjRFah9OoHgKyrKWGqGURnP
	eaVKfzhbg2zHyLKnQUjiW8D3UxV301rKZbaONfzBD/Lks6aQ6wtIc3fZGvdr1z3Cti2k1KaZZym3b
	IWFtc41w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKwSX-00000000E0J-3HrL;
	Fri, 30 May 2025 09:55:29 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKwRD-00000000Dsu-0DLw
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 09:54:08 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-441ab63a415so20081745e9.3
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748598845; x=1749203645; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRxoEOZMhRODJSYZJ+F0wZvNK0em7c0dCwwEsoHNqDU=;
        b=XGDUNxH8aLzgNEXuPK4ot5qHPpScNEiIC+dIHAqEkO1l8pqkD9O9lGBp1zjSEPmijf
         R3zYPVYYKHS1kwFn4dO5Moe4kP2Q5nCiWWEQDns3smGjdwrgvogvwWXDQ4CBcgzUlsSy
         KzphFpJNqffssJHZ8MpvcaOyf10sub60C1S5QZOsVrIwwGwO8AONVB8GC0Gq+/wAyUdU
         Wng8q0zpJG8x5bzoStEWusMxueejz1T9cl6ZzK6hmQu3yuK9SuPN4XwH9/upEE9Klcg+
         QZKyOKUoweLtQRaUkpu8ZvLm2dxFUIILE/eY4Uxkmu119DZpPFqFrGPw2Ru7YEbUKnbD
         2w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748598845; x=1749203645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRxoEOZMhRODJSYZJ+F0wZvNK0em7c0dCwwEsoHNqDU=;
        b=tIVMz46jLCb402UVqNF+GxTJgjsIx8L0yikrLePnc1e1ir8dD0ng6HHvWbQmdjFEFY
         tAeFb52txahcgmkkVl0cDHjs2NDK5pbqfNGydmjYrnPNvFeIu6BYHO4fndQncX8MLr29
         C/zaqtn2eBh4syK7a/r30DFPX3MgKF0okxALi6HAfKi4G3rJBP5ZmMfU70t1u/vJvPFq
         hFWXL4uGi4sHSc6C/T7glJJeyMyUp5KDhkl4SALspG3ExZc+Ku9bIMneTk+gKvC2zjSS
         WB13toEemeJrqjtAOYWk6McAsDx56MjHwG3PcQGSDJ4EiNnk9+D98NySsNe6XRmE5sPf
         cEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcN958cfuYva3C702ihwXE1rGAHYCvghTImgtV2l2ICmgOmIf8ET5vwdOb4P3Fzd4mHXOpnA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+J/xUDKJIa7mG+pwxkg9jQjYDbTI8e60yZ1IW5rNKqyIletZU
	ZSe3HPFkaUIjN+qlAjeqFRQrsRwW2fnZ68OBRaDmPXLtWs1Qolr1Wy/1ZdhkUQdaNJspZmYMN5t
	e3XlT
X-Gm-Gg: ASbGncuCCm/TdcAPXW37PcfAOu4ux1TPFGaiJfZ+7bZEnZzlOAe9TIdpklva+cAm3hh
	jMemlr8Pscicrqh+YMSBz3ZuVoGYOEhreMcoN/vpbVJA9s7fLkeRyc9paMqUywUxXv8sYfcmNvc
	OgZ8lPq2ryeMesXraL67Y2Pqe1aMp5zjQeyYChtJ3ErQzW8+Bj10cIdl6RRkE7pzR+Cml09yfaj
	RMI8Uml8F4deqw6HuvpJY0H2MegsFlM54MeH4VGP28YpwMr/h3RundWOfZIlmbsRMy6KZwUO914
	squC3QnK8fpW9OYdBcajkrc8Yyak7UVfriOsLmlkHR/G0fYx9fOXXgP2L8ygdRWtigg4hHq6Rpg
	=
X-Google-Smtp-Source: AGHT+IGaNzRwdlYZwrr0rVLBeL3KDtn/FBgW3cCsT7b4Bkm0T+MvmIXf3H7HJrmY+BO1AWC5F5xocg==
X-Received: by 2002:a05:600c:620f:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-450d6452cadmr34288755e9.0.1748598845108;
        Fri, 30 May 2025 02:54:05 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fb051bsm13429285e9.18.2025.05.30.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 02:54:04 -0700 (PDT)
Date: Fri, 30 May 2025 11:54:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Baoquan He <bhe@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aDmAO7Hd30PtCD33@tiehlicka>
References: <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
 <aDlsF5tAcUxo4VgT@tiehlicka>
 <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
 <aDl1ViMpK_6q_z06@tiehlicka>
 <04a49de5-eb79-431b-ba5b-eae2536781c6@redhat.com>
 <aDl7rHb34zIXEf6j@dwarf.suse.cz>
 <f95f2f30-1393-4ae1-96b1-96e4abfc368f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95f2f30-1393-4ae1-96b1-96e4abfc368f@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_025407_098393_AB505464 
X-CRM114-Status: GOOD (  12.47  )
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

On Fri 30-05-25 11:47:46, David Hildenbrand wrote:
> On 30.05.25 11:34, Jiri Bohac wrote:
[...]
> > I am inclined to just setting the fixed delay to 10s for now and
> > adding a sysfs knob later if someone asks for it.
> > 
> > Would that work for you?
> 
> Sure. We could always add such a flag later if it's really a problem for
> someone.

Yes, no objection with the most conservative approach first.
-- 
Michal Hocko
SUSE Labs


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDB2C25B75
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vlr8vwhm/kwvwmgWlq2KOPuuuw+5c+IK/MS4ZMrKgRk=; b=0V4fnMeaNJeT3MJ/cxiegtKELI
	gzCd6clkQ35IpgkNn6q+QW2bDVJ68KIQGU6g87Hx8KaTYtl2umShhts7sNapKA7E1WJ0VXY8EclSU
	jwPSbhmhz63GgNhbf9eZnsBjA/XpaQDsvkWw+FhuWTmaOQHdaBWJPkCXziUOzBO7lr332L2TR1m0c
	P+JFDASGQY4WdFMezoXOGE7mriFLgu2QWsSTsOuiw7QfDdZ6Wlfo7e7BnkPxQoChs1WReF0y1p6+I
	9eBpZLNMteAu6+ORhAuhqwHc6XN7CMlduO95Og5lxBM5OxXLlmIrRAdre6eJxA7LnH2YDy9jigwyh
	Ikulqjxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyK1-00000009l5v-0LiR;
	Fri, 31 May 2024 09:13:13 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyJy-00000009l1V-3kgg
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 09:13:12 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-52b88740a93so539894e87.3
        for <kexec@lists.infradead.org>; Fri, 31 May 2024 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717146769; x=1717751569; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6ZMuJgM1aDgO1ril1JnfzUqrJFWz+LSUP19WZBqGNc=;
        b=YOhKC9/RkTueR7H3fCKoHI5RGu/vZXyFV5A6xOVSqUjKukHqWN4d6tzQCWu+VDXEvj
         3EFThlXW+uXG4EZgCTx2XajSQwhE+3kT5uC4l7PzriAUD+YcXF2nrrKoaJ2z2nVa8kjt
         8fcpOxzG1n1ZQxlHqSgO9p2y0INARzn1OJu7aP1DJkmcNI2VIibtDDeV/W3jjhoSPmdV
         KW7KV10FkMzWkug2XCKWscEZhdTMWoiKfucMJHRnMgnnaSQJaQK6BiqNTh9/0QDS7Ww2
         OFQKkufZzTjtu2+dA0fYHDXBVAU+wcZA+fc1gk6WVbbnWoeYbwNXir1reyjCgHnlhfbG
         SV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717146769; x=1717751569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6ZMuJgM1aDgO1ril1JnfzUqrJFWz+LSUP19WZBqGNc=;
        b=mkqkPCizEyVxqGTCHdMRI4Yc1zSJQ/FzPrtcgVw9s5M5Dt1s4ielN4pt1zJiDh2uDl
         cRqKxl1VzHR/wBzfVSsAgKEN7wjtrGoycAtIKMD0Q3MQ5XwakDueMSrb9r0UuoKrNUjn
         EY/xi1lugE+kBKY5zxRo8UZu2dKTkjEQW/S6Hb4Z2jxldC7GN3QrbLzw5/N4G/mkPKg2
         u4KfJHX/CLzqiizKu4mDkKkADhdG07XH1Tc4/Ndjzc/zHzVA4fphycVdW6imF1Hv5uei
         K8RcF8E3Zqc9Cv45fRR1EGWP7my85i2v/uz9/RxO+eVSzK/RFfUVksVLfgdPt90CUndY
         r8Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWJg//YQfflreyO/wAfgsdgaXAPmzY9bSuBCVasTH3vu/p87E505Pk1pfWNzivGclx76oZUfqw+y8kS1qoaDH6j28xCaUD4zMGs
X-Gm-Message-State: AOJu0YyWO4nRciaQEKl41BysBxxf0lbzcU9mx8470LUaYnqCskFMIhNd
	5NEdlLdcFK7sQw3cQGXkzQCBJ6KpiWwxQTOm2z1bSBFmxkxVTQrM
X-Google-Smtp-Source: AGHT+IFU63l+mNBTUO22AXnMzH2w8LowDky00tObDxv/S9Yj6cn06SKwZt89GnylvhKlh4U8CcqWNw==
X-Received: by 2002:ac2:5a4c:0:b0:519:6a93:ed3a with SMTP id 2adb3069b0e04-52b89573bc9mr834468e87.23.1717146768652;
        Fri, 31 May 2024 02:12:48 -0700 (PDT)
Received: from localhost.localdomain (95.59.159.20.dynamic.telecom.kz. [95.59.159.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8724fsm261626e87.230.2024.05.31.02.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:12:48 -0700 (PDT)
From: Alexander Kuleshov <kuleshovmail@gmail.com>
X-Google-Original-From: Alexander Kuleshov <alex@localhost.localdomain>
Date: Fri, 31 May 2024 14:12:42 +0500
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, rick.p.edgecombe@intel.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, 
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com, 
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, 
	ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <eihdindv6akbn7oohmious6cany3ezjqflefd74wmkl2nllseu@izczd5vs6vj7>
X-Operating-System: Linux
X-Date: Fri May 31 01:22:55 PM +05 2024
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_021310_956048_24D3DEFC 
X-CRM114-Status: UNSURE (   5.40  )
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

On 30.05.2024 23:36, Ashish Kalra wrote:
>From: Ashish Kalra <ashish.kalra@amd.com>
>+	 * but it is not neccasery for kexec, as there are no boot services in

A typo in necessary

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD8C47258
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JyVVkRHVod6sgkTUfUxHmb/aN84PSh0rR9Szt1HazDc=; b=UB/3d34NJi8yIJ
	digmQ52Qer4Mejo8du6QPsVPX8aVGOkF54OqMLj4u5d999Z1KqjTXspI6kuQqX7co7MG9asYKqoah
	LFR2xVuYubno9kZTupDCkxpAmIto/biJ9rpJmwiftfDXOvFUoE6oE09r+VtGfG9KXGmSygCUo8jOg
	0SnS0UEPUaoXeVae/4gS4EGGaQvWFzPyrTfNAe7uHCKL1KPjiCvOmsoKB//ldLXfLVZU3msmrj1ee
	DWDBnxlvSjTNjto79QQEpjxXUy8J0z+i802Ec9BmJq2Sp3vFv2n/ki2GldF5KfrPZh0oHaJ9Vy2/O
	FNrxxBJM13h1x9UnryRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV54F-00000001qWy-1dQO;
	Wed, 31 Jan 2024 07:31:31 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV54A-00000001qV0-2NUZ
	for kexec@lists.infradead.org;
	Wed, 31 Jan 2024 07:31:28 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so1536985a12.1
        for <kexec@lists.infradead.org>; Tue, 30 Jan 2024 23:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706686283; x=1707291083; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgLPIeASAe7o9WjBABzOsB7qU2IyoTbg5XdoUZ2fWs8=;
        b=B8srJ+ObHKL7pP/5d6ByRYntSgT5Ly7TrMsRW0yRc2MIRPTtk7IuO+Lw3SxuOSaqVL
         qRn0Vt9h64oPuiOJjSHH8GCcuy+8nly6CuictHg2wlzFiaaPTEvBTMPqxMAu7E7bFJ+8
         EV6+I7GDBV8/AXiYtBJxGxFHftvaGjpDdeuFKxonv/0nvEqcvzYVI6qfvgLJ08mFYG2v
         lE7QifKF9eAX4bl89w9wmhSlo9dMdK2hNouBIH9fTKi+B8K7KRtwg/5XCJJuugc7rLlm
         OBb7T5FiDTx0wzRy+OmFUuXbhOIWH1o9nNT3DUQ7yo7O1FRG9Ts9hzOfAlKzqc6ExXUZ
         A1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686283; x=1707291083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgLPIeASAe7o9WjBABzOsB7qU2IyoTbg5XdoUZ2fWs8=;
        b=J7ddgV69drqnE+9up9TBIDSpdcQ9Ykx1JjEsxaFTuqpJvTx/3rLV4wW1fKKp6pSEfn
         +s2wtsJkJ3VGQU8KjJtiYZ/5B14K19hjzFm0XkILnhGm7+yHyPFTB0PfrDNJNSwo32rG
         pZDewY6lucRH/OQo6azK0+/mk9zIru510WsWWfTPV8FFzMPutE8r5DIIZIMQ7Rwx7wmO
         7TmyHcecJiPr4PDQb2+4MerXSUEcLmdzP8hvyoFmNoyqIA66AwWEIdlPXIdyeo42BGev
         XfVQIqi7ajgydeNPO1VLxkUN8+dkFnSosvO94su3EcolKZHonZ7xWizcUEOXPEipJz/F
         seTg==
X-Gm-Message-State: AOJu0YxkGZkvlm/uxVahGjc4BSqz/Ap1KvhD/Vu0hsR9OPmMmS5o0Pv6
	8n6/sRMZHFbgp5nBB31Hx5IBDuVddoTb3fQByMwCoo9Tz5aTZ6tSLfiEVU8by1M=
X-Google-Smtp-Source: AGHT+IGPzOcdc3+8Kb0Rxv3ybitEJMCoQK5tB6gdp4e+UqRtfJmhKXIVnjnDfIu++uawgiS1GLjYKw==
X-Received: by 2002:a05:6402:f93:b0:55e:ed35:ffce with SMTP id eh19-20020a0564020f9300b0055eed35ffcemr427085edb.37.1706686283355;
        Tue, 30 Jan 2024 23:31:23 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f? ([2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f])
        by smtp.gmail.com with ESMTPSA id d32-20020a056402402000b0055f82f799dasm323865eda.66.2024.01.30.23.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:31:23 -0800 (PST)
Message-ID: <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
Date: Wed, 31 Jan 2024 09:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_233126_627401_9F38106F 
X-CRM114-Status: GOOD (  12.58  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAzMC4wMS4yNCDQsy4gMTU6NDMg0YcuLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+IE9uIDEv
MjQvMjQgMTM6NTUsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKPj4gVGhlIHBhdGNoc2V0IGFk
ZHMgYml0cyBhbmQgcGllY2VzIHRvIGdldCBrZXhlYyAoYW5kIGNyYXNoa2VybmVsKSB3b3JrIG9u
Cj4+IFREWCBndWVzdC4KPj4KPj4gVGhlIGxhc3QgcGF0Y2ggaW1wbGVtZW50cyBDUFUgb2ZmbGlu
aW5nIGFjY29yZGluZyB0byB0aGUgYXBwcm92ZWQgQUNQSQo+PiBzcGVjIGNoYW5nZSBwb3Bvc2Fs
WzFdLiBJdCB1bmxvY2tzIGtleGVjIHdpdGggYWxsIENQVXMgdmlzaWJsZSBpbiB0aGUgCj4+IHRh
cmdldAo+PiBrZXJuZWwuIEl0IHJlcXVpcmVzIEJJT1Mtc2lkZSBlbmFibGluZy4gSWYgaXQgbWlz
c2luZyB3ZSBmYWxsYmFjayB0byAKPj4gYm9vdGluZwo+PiAybmQga2VybmVsIHdpdGggc2luZ2xl
IENQVS4KPj4KPj4gUGxlYXNlIHJldmlldy4gSSB3b3VsZCBiZSBnbGFkIGZvciBhbnkgZmVlZGJh
Y2suCj4gCj4gSGkgS2lyaWxsLAo+IAo+IEkgaGF2ZSBhIHZlcnkgYmFzaWMgcXVlc3Rpb246IGlz
IHRoZXJlIGEgcmVhc29uIHdoeSB0aGlzIHNlcmllcyBkb2VzIG5vdCAKPiByZXZlcnQgY29tbWl0
IGNiOGViMDZkNTBmYywgIng4Ni92aXJ0L3RkeDogRGlzYWJsZSBURFggaG9zdCBzdXBwb3J0IHdo
ZW4gCj4ga2V4ZWMgaXMgZW5hYmxlZCI/CgpXaGlsZSBvbiB0aGUgdG9waWMsIFBhb2xvIGRvIHlv
dSB0aGluayBpdCdzICBiZXR0ZXIgdG8gaGF2ZSBhIHJ1bnRpbWUgCmRpc2FibGUgb2Yga2V4ZWMg
cmF0aGVyIHRoYW4gYXQgY29tcGlsZSB0aW1lOgoKW1JGQyBQQVRDSF0geDg2L3ZpcnQvdGR4OiBE
aXNhYmxlIEtFWEVDIGluIHRoZSBwcmVzZW5jZSBvZiBURFgKCjIwMjQwMTE4MTYwMTE4LjE4OTky
OTktMS1uaWsuYm9yaXNvdkBzdXNlLmNvbQoKSSdtIHRyeWluZyB0byBnZXQgdHJhY3Rpb24gZm9y
IHRoaXMgcGF0Y2guCgoKPiAKPiBUaGFua3MsCj4gCj4gUGFvbG8KPiAKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK

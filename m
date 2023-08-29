Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A475C71153
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rBS25s8eAuaSHvEPRHN0dqyuHFJZVG06WOTh1rQ4A6w=; b=pTcwt4WMPBEZ2I
	y5nfs1/MWGHSSNM25uXGMGaU5EeQLVWSbPwGegnHe+D/GP4KffK/6lDNWOqRjamxbSfc5Yl+tekQU
	l8B6cQGxv063CzkfMp7Ojz/Fbgqi0WOEhmE5gEIDLls1vcTDvD1H1vdWJWuq0kJVR+dPaaCXNRUhV
	2he59EbzSIH6QDhcxlAtDWZQ2EJFquFGOdQGNjRlQ0yahxo7VYsh1RWc4ZUd1Q+z9C22AmR13eK68
	v+Pw0RdglvmmyAnaD5msIzxrzrsK1nEbm06Gd0vPJiL+Mo6lFQq5/HiT/eWxhWZ5mXkpv8RkYGhiJ
	brTeelSJLdkP3DkmN+TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb6IH-00CHzG-2x;
	Tue, 29 Aug 2023 21:30:37 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb6IE-00CHyt-2H
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 21:30:36 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58cd9d9dbf5so3478057b3.0
        for <kexec@lists.infradead.org>; Tue, 29 Aug 2023 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693344632; x=1693949432; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1Auf0z5ADRpVwU3wK7GGqhDo3zcyVhDtiPzWKFvZWs=;
        b=b5p+raC0lAx/K8ZiRSlUMkAvuHC6ZFHx+JaLalzdCVYyfbePrE6cDDwlOrs9EWNSuh
         GxLYoOMXyeIjEZ4+YBE7QvXIg82D2/4Mqv3KlwhmrSZV5ztqPAhRh0JLiIZ758LWAXM7
         NVLnO0KP+Y5iqeWHrKUOzIQx1J4iiVFwY5sHOo+YDfkAEqT1aLlWbqvWh87KyWWlyZ7B
         Qnd0CY7i32tJHDASWNoRwgg4BAfhc//mB8X1pv/BhTQjUaWdqE8bAeuWl3AzanJLPSjb
         Svy0zRRgfHRkCjOOhZp6n8v4lwUoEgnCNqehsZmsfnwnBAuxeuDjLNm6+xMLVOUC7pSr
         UIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693344632; x=1693949432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1Auf0z5ADRpVwU3wK7GGqhDo3zcyVhDtiPzWKFvZWs=;
        b=YqTf9t1OlYLWOZ5QWFpbAY5d0bUFQAAXH/prbySki76eScne5YgwAG45cwR4/yCI2c
         yvvDpSA/tG29ix0XaykZNHj62TNvwFeU8AGDuk/JJLyVoYgdMi0+G4c/ENRH/N4Rb6Ca
         E8aYyrSgvq1fWF/Kl3jBcTkcWEANZ30tlcDP3Oqq5D/OEISvl8jTFSsJyN6AL5huaUJo
         hg3ETBwu0v9Lt7pR0fudOTzdmU/Q2k3Y1dhDVEBmLXSvH+dNRelxrHwzbiDspGUGh8e0
         6V7JWSa9HSzUIHv5jJw2qDxeWeu69OcMXJ//BWy1CVFJuCpJKFJ7dg4UDGFWrGCd66Wb
         nGSA==
X-Gm-Message-State: AOJu0Yxm7qZZS7rYGqiHPFY7MVu8DqVGvKr+AzI31iWdy0C78/ZCR5fd
	LWpUD3pcj2IpVlW+ugUqVJMqg/HTqgvNB+T87yz7
X-Google-Smtp-Source: AGHT+IGXqcjzp7lemLr4OmY53Af17gLzlozRvp7po60yla7AEvrLXybXNorUHfsQ6EENu4c0afLLI4QjLJWsNE9DJ/0=
X-Received: by 2002:a0d:db50:0:b0:595:6912:4706 with SMTP id
 d77-20020a0ddb50000000b0059569124706mr477272ywe.23.1693344631808; Tue, 29 Aug
 2023 14:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com> <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
In-Reply-To: <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Aug 2023 17:30:20 -0400
Message-ID: <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	Tushar Sugandhi <tusharsu@linux.mic>, linux-security-module@vger.kernel.org, 
	AmirGoldstein <amir73il@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_143034_894369_C4E5ABCE 
X-CRM114-Status: GOOD (  31.55  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBBdWcgMjksIDIwMjMgYXQgNTowNeKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgMjAyMy0wOC0yOSBhdCAxNTozNCAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+IE9uIE1vbiwgQXVnIDIxLCAyMDIzIGF0IDc6MDjigK9QTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCAyMDIzLTA4
LTIxIGF0IDE1OjA1IC0wNzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+ID4gPiA+IE9u
IDgvMTQvMjAyMyAzOjAyIFBNLCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCAy
MDIzLTA4LTE0IGF0IDE0OjQyIC0wNzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+ID4g
PiA+ID4+PiBUaGlzIGRlc2lnbiBzZWVtcyBvdmVybHkgY29tcGxleCBhbmQgcmVxdWlyZXMgc3lu
Y2hyb25pemF0aW9uIGJldHdlZW4KPiA+ID4gPiA+Pj4gdGhlICJzbmFwc2hvdCIgcmVjb3JkIGFu
ZCBleHBvcnRpbmcgdGhlIHJlY29yZHMgZnJvbSB0aGUgbWVhc3VyZW1lbnQKPiA+ID4gPiA+Pj4g
bGlzdC4gIE5vbmUgb2YgdGhpcyB3b3VsZCBiZSBuZWNlc3NhcnkgaWYgdGhlIG1lYXN1cmVtZW50
cyB3ZXJlIGNvcGllZAo+ID4gPiA+ID4+PiBmcm9tIGtlcm5lbCBtZW1vcnkgdG8gYSBiYWNraW5n
IGZpbGUgKGUuZy4gdG1wZnMpLCBhcyBkZXNjcmliZWQgaW4gWzFdLgo+ID4gPiA+IEV2ZW4gaWYg
dGhlIEtlcm5lbCBtYWludGFpbnMgdGhlIGxpbmsgYmV0d2VlbiBhIHRtcGZzIGV4cG9ydGVkIGFu
ZCBhbgo+ID4gPiA+IGluLW1lbW9yeSBJTUEgbG9nIC0gaXQgc3RpbGwgaGFzIHRvIGNvcHkgdGhl
IHRtcGZzIHBvcnRpb24gdG8gdGhlCj4gPiA+ID4gS2VybmVsIG1lbW9yeSBkdXJpbmcga2V4ZWMg
c29mdCBib290LiAgdG1wZnMgaXMgY2xlYXJlZCBkdXJpbmcga2V4ZWMsCj4gPiA+ID4gc28gdGhp
cyBjb3B5aW5nIG9mIHRtcGZzIGJhY2sgdG8ga2VybmVsIG1lbW9yeSBpcyBuZWNlc3NhcnkgdG8g
cHJlc2VydmUKPiA+ID4gPiB0aGUgaW50ZWdyaXR5IG9mIHRoZSBsb2cgZHVyaW5nIGtleGVjLiAg
QnV0IHRoZSBjb3B5aW5nIHdvdWxkIGFkZCBiYWNrCj4gPiA+ID4gdGhlIG1lbW9yeSBwcmVzc3Vy
ZSBvbiB0aGUgbm9kZSBkdXJpbmcga2V4ZWMgKHdoaWNoIG1heSByZXN1bHQgaW4KPiA+ID4gPiBv
dXQtb2YtbWVtb3J5KSwgZGVmZWF0aW5nIHRoZSBwdXJwb3NlIG9mIHRoZSBvdmVyYWxsIGVmZm9y
dC9mZWF0dXJlLgo+ID4gPiA+IENvcHlpbmcgdG8gYSByZWd1bGFyICpwZXJzaXN0ZW50KiBwcm90
ZWN0ZWQgZmlsZSBzZWVtcyBhIGNsZWFuZXIKPiA+ID4gPiBhcHByb2FjaCwgY29tcGFyZWQgdG8g
dG1wZnMuCj4gPiA+Cj4gPiA+IEZyb20gYSBrZXJuZWwgcGVyc3BlY3RpdmUsIGl0IGRvZXNuJ3Qg
bWFrZSBhIGRpZmZlcmVuY2UgaWYgdXNlcnNwYWNlCj4gPiA+IHByb3ZpZGVzIGEgdG1wZnMgb3Ig
cGVyc2lzdGVudCBmaWxlLiAgQXMgcGVyIHRoZSBkaXNjdXNzaW9uCj4gPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWludGVncml0eS9DQU9RNHV4ajRQdjJXcjF3Z3ZCQ0RSLXRuQTVk
c1pUM3J2ZER6S2dBSDFhRVZfLXI5UWdAbWFpbC5nbWFpbC5jb20vI3QKPiA+ID4gLCB1c2Vyc3Bh
Y2UgcHJvdmlkZXMgdGhlIGtlcm5lbCB3aXRoIHRoZSBmaWxlIGRlc2NyaXB0b3Igb2YgdGhlIG9w
ZW5lZAo+ID4gPiBmaWxlLgo+ID4gPgo+ID4gPiA+IFdlIHByb3RvdHlwZWQgdGhpcyBzb2x1dGlv
biwgaG93ZXZlciBpdAo+ID4gPiA+IGRvZXMgbm90IHNlZW0gdG8gYmUgYSBjb21tb24gcGF0dGVy
biB3aXRoaW4gdGhlIEtlcm5lbCB0byB3cml0ZSBzdGF0ZQo+ID4gPiA+IGRpcmVjdGx5IHRvIGZp
bGVzIG9uIGRpc2sgZmlsZSBzeXN0ZW1zLiAgV2UgY29uc2lkZXJlZCB0d28gcG90ZW50aWFsCj4g
PiA+ID4gb3B0aW9uczoKPiA+ID4KPiA+ID4gSWYgbm8gZmlsZSBkZXNjcmlwdG9yIGlzIHByb3Zp
ZGVkLCB0aGVuIHRoZSBtZWFzdXJlbWVudHMgYXJlbid0IGNvcGllZAo+ID4gPiBhbmQgcmVtb3Zl
ZCBmcm9tIHRoZSBzZWN1cml0eWZzIGZpbGUuICBJZiB0aGVyZSBhcmUgd3JpdGUgZXJyb3JzLCB0
aGUKPiA+ID4gbWVhc3VyZW1lbnRzIGFyZW4ndCByZW1vdmVkIGZyb20gdGhlIHNlY3VyaXR5ZnMg
ZmlsZSB1bnRpbCB0aGUgd3JpdGUKPiA+ID4gZXJyb3JzIGFyZSByZXNvbHZlZC4KPiA+Cj4gPiBJ
dCBzb3VuZHMgbGlrZSB0aGlzIGFwcHJvYWNoIHdvdWxkIHJlcXVpcmUgdGhlIGZpbGUvZmlsZXN5
c3RlbSB0byBiZQo+ID4gY29udGludW91c2x5IGF2YWlsYWJsZSBmb3IgdGhlIGxpZmUgb2YgdGhl
IHN5c3RlbSBvbmNlIHRoZSBsb2cgd2FzCj4gPiBzbmFwc2hvdHRlZC9vdmVyZmxvd2VkIHRvIHBl
cnNpc3RlbnQgc3RvcmFnZSwgeWVzPyAgQXNzdW1pbmcgdGhhdCBpcwo+ID4gdGhlIGNhc2UsIHdo
YXQgaGFwcGVucyBpZiB0aGUgZmlsZS9maWxlc3lzdGVtIGJlY29tZXMgaW5hY2Nlc3NpYmxlIGF0
Cj4gPiBzb21lIHBvaW50IGFuZCBhbiBhdHRlc3RhdGlvbiBjbGllbnQgYXR0ZW1wdHMgdG8gcmVh
ZCB0aGUgZW50aXJlIGxvZz8KPgo+IFRoZSBtYWluIHB1cnBvc2Ugb2YgdGhlIGNoYW5nZSBpcyB0
byBhZGRyZXMga2VybmVsIG1lbW9yeSBwcmVzc3VyZS4KPiBUd28gZGVzaWducyBhcmUgYmVpbmcg
ZGlzY3Vzc2VkOiBTdXNoJ3MgInNuYXBzaG90dGluZyIgZGVzaWduIGFuZAo+IEFtaXIncyBvcmln
aW5hbCBzdWdnZXN0aW9uIG9mIGNvbnRpbm91c2x5IGV4cG9ydGluZyB0aGUgbWVhc3VyZW1lbnQK
PiByZWNvcmRzIHRvIGEgdG1wZnMgb3IgcmVndWxhciBmaWxlLiAgQm90aCBkZXNpZ25zIHJlcXVp
cmUgdmVyaWZ5aW5nIHRoZQo+IGluaXRpYWwgYXR0ZXN0YXRpb24gcXVvdGUgYnkgd2Fsa2luZyB0
aGUgZW50aXJlIG1lYXN1cmVtZW50IGxpc3QsCj4gY2FsY3VsYXRpbmcgdGhlIGV4cGVjdGVkIFRQ
TSBQQ1IgdmFsdWUocykuICBUaGF0IGRvZXNuJ3QgY2hhbmdlLgoKU3VyZSwgYnV0IG15IHF1ZXN0
aW9uIGlzIGFib3V0IHdoYXQgaGFwcGVucyBpZiBwb3J0aW9ucyBvZiB0aGUKbWVhc3VyZW1lbnQg
bGlzdCBkaXNhcHBlYXIgZHVlIHRvIGZpbGUvZmlsZXN5c3RlbSBwcm9ibGVtcz8gIEhvdyBpcwp0
aGF0IGhhbmRsZWQ/CgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK

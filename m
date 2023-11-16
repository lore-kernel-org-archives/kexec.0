Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AE4C197A0
	for <kexec@archiver.kernel.org>; Thu, 16 Nov 2023 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=reIAWev5j/6ZXiSZPMOjIQ15MDIzQFjN31yEbqV+oGU=; b=ci/1WPgr01CLQE
	KrD37IxOxM8a4k78b/9hzqS5GDdlz02bEgTgmnQjB9cxgbnartSUrtrhJx83v7zcwvdv2U/rmQv03
	2ZesjQoXq1kx6TZl1LR9jH46S/Q/U8/xyRbLQdb2yAU6MtvzwBL3sC83m/UaB/msX0B9chkiwqnyo
	MbqwXpAgBwICDO/OQMn6G+oQCTsi4MsK1LeFqkopDlhKuSovQI5nrX9jZyhURFLBJ43MN5zQfuYfA
	DdlPMrzC+J2v2VXTWTypRul0EVE3WbbFFXUdjdnCz95wYwKdCNuMN1kMpiQarmecW4AQx6Wkk2oj5
	9OaxUw+lqdIopc9AS5vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3kWV-0050gm-0N;
	Thu, 16 Nov 2023 22:07:43 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3kWI-0050fn-17
	for kexec@lists.infradead.org;
	Thu, 16 Nov 2023 22:07:32 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso2165566276.0
        for <kexec@lists.infradead.org>; Thu, 16 Nov 2023 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700172447; x=1700777247; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McWLK0Erh20b4c0w4AHhfY135hMZXUKuEa1U628p59w=;
        b=L1bRrVlntatHgEJXNXBe+gdorP4rDXRz5jOkBnxd3qfC7g8U+Jn95cDGVsmgPECdiH
         MuxGC0wvqUse+lHjaHvE6yjOeoJVBq9GK2R8ETBQx+EQa4DAobu/iLP8RNmWZa5FyG9r
         Ol0rxkGT7MiiRohxnrFMYmsiQHiTChUUIUUVX9w+5Ru+VUwRo8W2odPyAZfavbW5PbdK
         39eti8aZ2p36fcJVMMx8Cz2IGVQ7gPCPfawcoWd6lU/0jAqRvEAsOc6uho6q74OyuB7x
         NI00Nz49KSobN3P+w7vcsmIo10W11IQSjGZ0odDT9lF5AW4iwWKltm262tsROYs/k7dY
         6ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700172447; x=1700777247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McWLK0Erh20b4c0w4AHhfY135hMZXUKuEa1U628p59w=;
        b=wBXAZ2Pph9S7CM4gBheag5E+9fK+GHiFB6n5DOI2d0Zxwp270MqUybkK29Gum+Zkbj
         FB3Yp2pdYDlMPQJJ8L/NIbPgHJ2nnCZ0FmOzVQKLgtCLuwV7GhQV2VglKfA9M5yIVViE
         9ahLl4DS6NVdk1OG0CbYdZMcIXSIZwdOREh7s6ZtgQ05uvbGuKtRgVl8vxwnWXYZkKcF
         Qdm+bNvUPriVLL1Oy+KpVnk4Y5o2Dnsh6HcPUU1bHswoUj7u1P+VNafG5S+WPF0y/lUf
         BWgoZ7j6JKa7zSZ+wurBeulTf18coEhV+CG2V2LEtc15/8P6Z01fXwrUcxPRnsGdxoig
         Kzbw==
X-Gm-Message-State: AOJu0Yzvvlj9JZZh74sVYOt+dNsSQsCGaB2Rumrix7eXKYX4OYyaYaUH
	etUhA/WCC285nKoz/NGj9hQIgM4So0nJ2FG+nt3v
X-Google-Smtp-Source: AGHT+IHED5b06hwidP35hDGIWSIQ9u3imhXraRogqXkH7N0Totrcom3GLJDKwPINv/bKKOTrKwcA+sef6an7q3F/l3w=
X-Received: by 2002:a25:74cb:0:b0:daf:1ab5:e454 with SMTP id
 p194-20020a2574cb000000b00daf1ab5e454mr2458374ybc.7.1700172447508; Thu, 16
 Nov 2023 14:07:27 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com> <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
In-Reply-To: <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 17:07:16 -0500
Message-ID: <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, 
	vgoyal@redhat.com, Dave Young <dyoung@redhat.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, serge@hallyn.com, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_140730_920618_EA838168 
X-CRM114-Status: GOOD (  31.69  )
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

T24gVHVlLCBOb3YgMTQsIDIwMjMgYXQgMTo1OOKAr1BNIFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJA
bGludXguaWJtLmNvbT4gd3JvdGU6Cj4gT24gMTEvMTQvMjMgMTM6MzYsIFN1c2ggU2hyaW5nYXJw
dXRhbGUgd3JvdGU6Cj4gPiBPbiAxMS8xMy8yMDIzIDEwOjU5IEFNLCBTdGVmYW4gQmVyZ2VyIHdy
b3RlOgo+ID4+IE9uIDEwLzE5LzIzIDE0OjQ5LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gPj4+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Cj4gPj4+IHwgSW50cm9kdWN0aW9uIHwKPiA+Pj4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KPiA+Pj4gVGhpcyBkb2N1bWVudCBwcm92aWRlcyBhIGRldGFpbGVkIG92ZXJ2aWV3IG9mIHRo
ZSBwcm9wb3NlZCBLZXJuZWwKPiA+Pj4gZmVhdHVyZSBJTUEgbG9nIHNuYXBzaG90dGluZy4gIEl0
IGRlc2NyaWJlcyB0aGUgbW90aXZhdGlvbiBiZWhpbmQgdGhlCj4gPj4+IHByb3Bvc2FsLCB0aGUg
cHJvYmxlbSB0byBiZSBzb2x2ZWQsIGEgZGV0YWlsZWQgc29sdXRpb24gZGVzaWduIHdpdGgKPiA+
Pj4gZXhhbXBsZXMsIGFuZCBkZXNjcmliZXMgdGhlIGNoYW5nZXMgdG8gYmUgbWFkZSBpbiB0aGUg
Y2xpZW50cy9zZXJ2aWNlcwo+ID4+PiB3aGljaCBhcmUgcGFydCBvZiByZW1vdGUtYXR0ZXN0YXRp
b24gc3lzdGVtLiAgVGhpcyBpcyB0aGUgMm5kIHZlcnNpb24KPiA+Pj4gb2YgdGhlIHByb3Bvc2Fs
LiAgVGhlIGZpcnN0IHZlcnNpb24gaXMgcHJlc2VudCBoZXJlWzFdLgo+ID4+Pgo+ID4+PiBUYWJs
ZSBvZiBDb250ZW50czoKPiA+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tCj4gPj4+IEEuIE1vdGl2YXRp
b24gYW5kIEJhY2tncm91bmQKPiA+Pj4gQi4gR29hbHMgYW5kIE5vbi1Hb2Fscwo+ID4+PiAgICAg
IEIuMSBHb2Fscwo+ID4+PiAgICAgIEIuMiBOb24tR29hbHMKPiA+Pj4gQy4gUHJvcG9zZWQgU29s
dXRpb24KPiA+Pj4gICAgICBDLjEgU29sdXRpb24gU3VtbWFyeQo+ID4+PiAgICAgIEMuMiBIaWdo
LWxldmVsIFdvcmstZmxvdwo+ID4+PiBELiBEZXRhaWxlZCBEZXNpZ24KPiA+Pj4gICAgICBELjEg
U25hcHNob3QgQWdncmVnYXRlIEV2ZW50Cj4gPj4+ICAgICAgRC4yIFNuYXBzaG90IFRyaWdnZXJp
bmcgTWVjaGFuaXNtCj4gPj4+ICAgICAgRC4zIENob29zaW5nIEEgUGVyc2lzdGVudCBTdG9yYWdl
IExvY2F0aW9uIEZvciBTbmFwc2hvdHMKPiA+Pj4gICAgICBELjQgUmVtb3RlLUF0dGVzdGF0aW9u
IENsaWVudC9TZXJ2aWNlLXNpZGUgQ2hhbmdlcwo+ID4+PiAgICAgICAgICBELjQuYSBDbGllbnQt
c2lkZSBDaGFuZ2VzCj4gPj4+ICAgICAgICAgIEQuNC5iIFNlcnZpY2Utc2lkZSBDaGFuZ2VzCj4g
Pj4+IEUuIEV4YW1wbGUgV2Fsay10aHJvdWdoCj4gPj4+IEYuIE90aGVyIERlc2lnbiBDb25zaWRl
cmF0aW9ucwo+ID4+PiBHLiBSZWZlcmVuY2VzCj4gPj4+Cj4gPj4KPiA+PiBVc2Vyc3BhY2UgYXBw
bGljYXRpb25zIHdpbGwgaGF2ZSB0byBrbm93Cj4gPj4gYSkgd2hlcmUgYXJlIHRoZSBzaGFyZCBm
aWxlcz8KPiA+IFdlIGRlc2NyaWJlIHRoZSBmaWxlIHN0b3JhZ2UgbG9jYXRpb24gY2hvaWNlcyBp
biBzZWN0aW9uIEQuMywgYnV0IHVzZXIKPiA+IGFwcGxpY2F0aW9ucyB3aWxsIGhhdmUgdG8gcXVl
cnkgdGhlIHdlbGwta25vd24gbG9jYXRpb24gZGVzY3JpYmVkIHRoZXJlLgo+ID4+IGIpIGhvdyBk
byBJIHJlYWQgdGhlIHNoYXJkIGZpbGVzIHdoaWxlIGxvY2tpbmcgb3V0IHRoZSBwcm9kdWNlciBv
ZiB0aGUKPiA+PiBzaGFyZCBmaWxlcz8KPiA+Pgo+ID4+IElNTywgdGhpcyB3aWxsIHJlcXVpcmUg
YSB3ZWxsIGtub3duIGNvbmZpZyBmaWxlIGFuZCBhIGxvY2tpbmcgbWV0aG9kCj4gPj4gKGZsb2Nr
KSBzbyB0aGF0IHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIGNhbiB3b3JrIHRvZ2V0aGVyIGluIHRo
aXMgbmV3Cj4gPj4gZW52aXJvbm1lbnQuIFRoZSBsb2NrIGNvdWxkIGJlIGRlZmluZWQgaW4gdGhl
IGNvbmZpZyBmaWxlIG9yIGp1c3QgYmUKPiA+PiB0aGUgY29uZmlnIGZpbGUgaXRzZWxmLgo+ID4g
VGhlIGZsb2NrIGlzIGEgZ29vZCBpZGVhIGZvciBjby1vcmRpbmF0aW9uIGJldHdlZW4gVU0gY2xp
ZW50cy4gV2hpbGUKPiA+IHRoZSBLZXJuZWwgY2Fubm90IGVuZm9yY2UgYW55IGFjY2VzcyBpbiB0
aGlzIHdheSwgYW55IFVNIHByb2Nlc3MgdGhhdAo+ID4gaXMgcGxhbm5pbmcgb24gdHJpZ2dlcmlu
ZyB0aGUgc25hcHNob3QgbWVjaGFuaXNtIHNob3VsZCBmb2xsb3cgdGhhdAo+ID4gcHJvdG9jb2wu
ICBXZSB3aWxsIGVuc3VyZSB3ZSBkb2N1bWVudCB0aGF0IGFzIHRoZSBiZXN0LXByYWN0aWNlcyBp
bgo+ID4gdGhlIHBhdGNoIHNlcmllcy4KPgo+IEl0J3MgbW9yZSB0aGFuICdiZXN0IHByYWN0aWNl
cycuIFlvdSBuZWVkIGEgd2VsbC1rbm93biBjb25maWcgZmlsZSB3aXRoCj4gd2VsbC1rbm93biBj
b25maWcgb3B0aW9ucyBpbiBpdC4KPgo+IEFsbCBjbGllbnRzIHRoYXQgd2VyZSBwcmV2aW91c2x5
IGp1c3QgdHJ5aW5nIHRvIHJlYWQgbmV3IGJ5dGVzIGZyb20gdGhlCj4gSU1BIGxvZyBjYW5ub3Qg
ZG8gdGhpcyBhbnltb3JlIGluIHRoZSBwcmVzZW5jZSBvZiBhIGxvZyBzaGFyZCBwcm9kdWNlcgo+
IGJ1dCBoYXZlIHRvIGFsc28gbGVhcm4gdGhhdCBhIG5ldyBsb2cgc2hhcmQgaGFzIGJlZW4gcHJv
ZHVjZWQgc28gdGhleQo+IG5lZWQgdG8gZmlndXJlIG91dCB0aGUgbmV3IHBvc2l0aW9uIGluIHRo
ZSBsb2cgd2hlcmUgdG8gcmVhZCBmcm9tLiBTbwo+IG1heWJlIGEgY291bnRlciBpbiBhIGNvbmZp
ZyBmaWxlIHNob3VsZCBpbmRpY2F0ZSB0byB0aGUgbG9nIHJlYWRlcnMgdGhhdAo+IGEgbmV3IGxv
ZyBoYXMgYmVlbiBwcm9kdWNlZCAtLSBvdGhlcndpc2UgdGhleSB3b3VsZCBoYXZlIHRvIG1vbml0
b3IgYWxsCj4gdGhlIGxvZyBzaGFyZCBmaWxlcyBvciB0aGUgbG9nIHNoYXJkIGZpbGUncyBzaXpl
LgoKSWYgYSBjb3VudGVyIGlzIG5lZWRlZCwgSSB3b3VsZCBzdWdnZXN0IHBsYWNpbmcgaXQgc29t
ZXdoZXJlIG90aGVyCnRoYW4gdGhlIGNvbmZpZyBmaWxlIHNvIHRoYXQgd2UgY2FuIGVuZm9yY2Ug
bGltaXRlZCB3cml0ZSBhY2Nlc3MgdG8KdGhlIGNvbmZpZyBmaWxlLgoKUmVnYXJkbGVzcywgSSBp
bWFnaW5lIHRoZXJlIGFyZSBhIGZldyB3YXlzIG9uZSBjb3VsZCBzeW5jaHJvbml6ZQp2YXJpb3Vz
IHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgc3VjaCB0aGF0IHRoZXkgc2VlIGEgY29uc2lzdGVudCB2
aWV3IG9mCnRoZSBkZWNvbXBvc2VkIGxvZyBzdGF0ZSwgYW5kIHRoZSBnb29kIG5ld3MgaXMgdGhh
dCB0aGUgYXBwcm9hY2gKZGVzY3JpYmVkIGhlcmUgaXMgb3B0LWluIGZyb20gYSB1c2Vyc3BhY2Ug
cGVyc3BlY3RpdmUuICBJZiB0aGUKdXNlcnNwYWNlIGRvZXMgbm90IGZ1bGx5IHN1cHBvcnQgSU1B
IGxvZyBzbmFwc2hvdHRpbmcgdGhlbiBpdCBuZXZlcgpuZWVkcyB0byB0cmlnZ2VyIGl0IGFuZCB0
aGUgc3lzdGVtIGJlaGF2ZXMgYXMgaXQgZG9lcyB0b2RheTsgb24gdGhlCm90aGVyIGhhbmQsIGlm
IHRoZSB1c2Vyc3BhY2UgaGFzIGJlZW4gdXBkYXRlZCBpdCBjYW4gbWFrZSB1c2Ugb2YgdGhlCm5l
dyBmdW5jdGlvbmFsaXR5IHRvIGJldHRlciBtYW5hZ2UgdGhlIHNpemUgb2YgdGhlIElNQSBtZWFz
dXJlbWVudApsb2cuCgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK

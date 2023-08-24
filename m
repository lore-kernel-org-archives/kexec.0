Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA6DC3DA6F
	for <kexec@archiver.kernel.org>; Thu, 24 Aug 2023 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oRLVtSLPZhSlta+haZ9JWkyamTCiCSEPKnnFqub9rqQ=; b=NZgN1NiLq9S20a
	WWLqJ+UMOoB5d0gAM/63xO+FkzQ3NrAhhLic5yoNuKA3T6NxouZ27yl/xJ9JwjNTdqhnn0BD/lQyU
	vEXiQLzTsaUpZkSPU4Y+nwOE1poQAN2tvQbx+UQCgiU7wkpkEcg5KvSi6yCv+y22fSvxvmwQirxJT
	xfU4W2r91cyj3p4WkXgry7eytUvfz0+O8WfmiJB8/RmKFywVVjwJqtdlDb+HcNgMFxk1mig5uZimZ
	cp/Yyf30rnHZAZQyjnkrzCa+LauUe9t+GLAkSSChgEdhXy/Cl5Nzn6YBE7SwzQfrMzDwW5MHs7xHK
	5QFgwXyhXcp5bvarKOMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBti-003KX3-2J;
	Thu, 24 Aug 2023 15:05:22 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBtg-003KWf-2j
	for kexec@lists.infradead.org;
	Thu, 24 Aug 2023 15:05:22 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso43203235ad.3
        for <kexec@lists.infradead.org>; Thu, 24 Aug 2023 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692889520; x=1693494320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JiozmI8Cx83SGOqAUTYb4WjbXbJdSTEwcACCqiQMyg=;
        b=DFkNxQ2WgmD00dI+dYPj6aE6ODh7ejj6kD+vD3el3amYTH5/aqAi6LIefmDra2QWFf
         WIPQFnWG+TnkrMJGuo1EP8EuLxynObez14ViP3GVRDW4gajcSRV2WRHwi/EcggRd/gSQ
         v94d9M0Tw33Sc+2qlQBkyi32xC1g1cMNPVfr3Yju+IP2EBGVbQOnThpeRc8eCRU4GBjF
         Kv6wG3qXiqIIX7G1CGmzbXd5mLRiwJ8zpUVLtsPZyibPAnzmCS6SnCAde6venbGQWJDH
         nG+QfDEqUJ44Q2JVbO2d6WWcdGjFnmOH84/OsadDF0Su4O3W6HRe2KFPbWhPvGEIlBpA
         71GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889520; x=1693494320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JiozmI8Cx83SGOqAUTYb4WjbXbJdSTEwcACCqiQMyg=;
        b=VbU1OootX5GOLfy4kVqLNLDB6HjtURSwAvc8Kz7bKdWBaemPekmRVSmDwTeWxK+yGD
         RXykkIAotZOsR1L3PkRXA5iC8OW/X/McGgJAdw/1JhaZywjkJ/oxRhx/bpvWg135l4Js
         0DNL4hqb4pFHzjs1SGmDbrVNeTnwvB0aBJe+nlJw90pK1huQ4lcnduoSUzodcoxUu4um
         icAtB9uTSlDl94JZPHqJFBxvFMXl6ioSkxIFTrElB2RT3rnffyRUI3KHqpcjBfPyzp7H
         ywrkaxqoiiynad3rfNuEv8bKh787m6qPvz/8OsW6/1X1jQOav1gT8HX4ZBk/43Nm6UeN
         WHww==
X-Gm-Message-State: AOJu0YwPiHY93ZHFr6ijk995jJN/Ubr7syy1vcUXYZjBWEMR2Z48h1UB
	Hq4vI83RJyZZwC6s3tkOrmdwWp4HwMLR1gG+mjBToUA7tV8=
X-Google-Smtp-Source: AGHT+IEjVuaz2eBKTKtrJkva7vLQeVw9T1ELZG1C3oRrHlp4p/OLPld9I1byQD6LgbSAjXrJO+2zBZG3/2fPSYGj+GI=
X-Received: by 2002:a17:90b:124f:b0:26c:f6d2:2694 with SMTP id
 gx15-20020a17090b124f00b0026cf6d22694mr12373747pjb.12.1692889519611; Thu, 24
 Aug 2023 08:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv> <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNogKKZCp12Q92jh@MiWiFi-R3L-srv> <MN0PR12MB5953FFB655A208BD4FA32EE4B71EA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <CACBYKvRJL_WmZUN7BH_TjxX+TC2O1gjsudkh1GtRyB3WifjMJA@mail.gmail.com> <MN0PR12MB59532ABFAF131AC84F36B73FB71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB59532ABFAF131AC84F36B73FB71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
From: Alexander Kamensky <alexander.kamensky42@gmail.com>
Date: Thu, 24 Aug 2023 08:05:08 -0700
Message-ID: <CACBYKvT6AzupfrHZ58BYM8xi8TDLeppqD+Lt=rf9hfmSew+nmQ@mail.gmail.com>
Subject: Re: kexec reports "Cannot get kernel _text symbol address" on arm64 platform
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "piliu@redhat.com" <piliu@redhat.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Sarangi, Anirudha" <anirudha.sarangi@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_080520_909031_7F403846 
X-CRM114-Status: GOOD (  17.39  )
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

T24gV2VkLCBBdWcgMjMsIDIwMjMgYXQgMTI6MDnigK9QTSBQYW5kZXksIFJhZGhleSBTaHlhbQo8
cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPiB3cm90ZToKPgo+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0KPiA+IEZyb206IEFsZXhhbmRlciBLYW1lbnNreSA8YWxleGFuZGVyLmthbWVu
c2t5NDJAZ21haWwuY29tPgo+ID4gU2VudDogVHVlc2RheSwgQXVndXN0IDIyLCAyMDIzIDk6MjQg
QU0KPiA+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQu
Y29tPgo+ID4gQ2M6IGJoZUByZWRoYXQuY29tOyBwaWxpdUByZWRoYXQuY29tOyBrZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNhcmFu
Z2ksIEFuaXJ1ZGhhIDxhbmlydWRoYS5zYXJhbmdpQGFtZC5jb20+Cj4gPiBTdWJqZWN0OiBSZTog
a2V4ZWMgcmVwb3J0cyAiQ2Fubm90IGdldCBrZXJuZWwgX3RleHQgc3ltYm9sIGFkZHJlc3MiIG9u
Cj4gPiBhcm02NCBwbGF0Zm9ybQo+ID4KPiA+IEhpIEFsbCwKPiA+Cj4gPiBTb3JyeSBmb3IgdGhl
IHRvcCBwb3N0LCBidXQgSSBiZWxpZXZlIHRoYXQgSSBtaWdodCBoYXZlIHBvc3RlZCBhIGZpeCBm
b3IgdGhpcwo+ID4gaXNzdWUgYSBjb3VwbGUgZGF5cyBhZ28uCj4gPgo+ID4gUGxlYXNlIGNoZWNr
IGFuZCBzZWUgaWYgaXQgaGVscHMKPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2tleGVjLzIw
MjMwODE5MTkxMTE5Ljk3NTI5OS0xLQo+ID4gYWxleGFuZGVyLmthbWVuc2t5NDJAZ21haWwuY29t
L1QvI3UKPiA+Cj4gPiBFeHBsYW5hdGlvbiBmb3IgdGhlIGlzc3VlIEkgb2JzZXJ2ZWQgd2l0aCBh
IHNpbWlsYXIgc2Vjb25kYXJ5IGtlcm5lbAo+ID4gdHJhY2ViYWNrIG9uIGFybTY0IGlzIGluIHRo
ZSBjb21taXQgbWVzc2FnZS4KPgo+IEkgZmV0Y2hlZCBsYXRlc3Qga2V4ZWMgc291cmNlcyAoNzc3
Y2E0NTNjYTY5ZTQ2ZjczNzZiMDdiYTY3MjdiZDI2MWVjOTdlZikKPiBhbmQgYXBwbGllZCBhYm92
ZSBwYXRjaCwgYSBiaXQgaW1wcm92ZWQgYnV0IHN0aWxsIHZtY29yZSBzaXplIGlzIGh1Z2UuCj4K
PiAvICMgbHMgLWxydGggL3Byb2Mvdm1jb3JlCj4gLXItLS0tLS0tLSAgICAxIHJvb3QgICAgIHJv
b3QgICAgICAgMTUuNUcgQXVnIDIzIDE4OjU1IC9wcm9jL3ZtY29yZQo+CkhvdyBiaWcgaXMgeW91
ciBzeXN0ZW0gbWVtb3J5PyBJZiBpdCBpcyAxNkcgdGhlbiB0aGUgYWJvdmUgaXMgbm9ybWFsLgoK
VGhlIG1vc3QgaW1wb3J0YW50IHRoaW5nIGlzIGNhbiB5b3VyIHNlY29uZGFyeSBrZXJuZWwgcmVh
ZCBpdD8gRm9yIGV4YW1wbGUKCmNhdCAvcHJvYy92bWNvcmUgPiAvZGV2L251bGwKCklmIHlvdSB3
YW50IHRvIGNhcHR1cmUgb25seSBrZXJuZWwgY29yZSBvdXQgb2YgL3Byb2Mvdm1jb3JlIHlvdSBu
ZWVkCnRvIHVzZSBtYWtlZHVtcGZpbGUKdG8gZmlsdGVyIG91dCB0aGUgcmVzdCBvZiB0aGUgbWVt
b3J5LgoKVGhhbmtzLApBbGV4YW5kZXIKCj4gVGhhbmtzLAo+IFJhZGhleQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=

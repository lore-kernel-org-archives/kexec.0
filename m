Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D170C27C4F
	for <kexec@archiver.kernel.org>; Mon, 24 Jun 2024 01:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lw1EVSXCRncZVJ0Mt8gKBvi3QVy9ljccF1+9sS8nErw=; b=hVMVVamjmHhLer
	TvKH76GxTN0gMqBnzW9h7LEVgftPvQi9DcmBbTA2tcDPcv57lDc3SGudRVb1IXKJ3uV3JUBvAdMLo
	BIpOHZBdVJdx53CseetbOCzH8T1K8frriWHMFwqyKuoS1JUx/TDt9+bwmVAsCyOtAbbMjC1qVTe7G
	AWSrNtW28egxghb8No0M/2Wr4vU93itPq43UgcxvWcfB+fOln32QnMdNi559s44YpAt6o+H4bBSxs
	roAQkSEW+PvH9x8CQF2P5lMvyqhJZY0JpbVMLtxm2fli9OwdHzkHWxupNuD/RpKVAw3gOqDoYkVwq
	3/LKQORbPEIZ3vvHkYUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLYsM-0000000FE34-23dB;
	Mon, 24 Jun 2024 01:52:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLYsH-0000000FE1S-2qsP
	for kexec@lists.infradead.org;
	Mon, 24 Jun 2024 01:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719193923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aOPK0i+6jvB6VDDdYW6TLVTzmplrtlrPXL8VqZpj7E=;
	b=LcuVALhwgQIZrHlFgSHGQHmIm06zYMuMxDuomcXUB1HOxdbq5vSi/69JDIHn1Qtj9QCZhh
	0+XGXn5wjSheMlaRubbxr+akdqHAmb893x7gdQ9AsaVuyJefu1Z1PhkD/jeWFFuJmZML7O
	oD31xBcsci5zk1gcpIB9sqlWok/nFCI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-cH2iJ0iHMXCgdrT3XVrlbA-1; Sun, 23 Jun 2024 21:52:01 -0400
X-MC-Unique: cH2iJ0iHMXCgdrT3XVrlbA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3761d89298fso3089955ab.1
        for <kexec@lists.infradead.org>; Sun, 23 Jun 2024 18:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719193921; x=1719798721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aOPK0i+6jvB6VDDdYW6TLVTzmplrtlrPXL8VqZpj7E=;
        b=CMInqXRpcOhPIvRUs0ZcBi4DUhnV38TNpnEttv8zLCfmM8dNC75tuCE4oxzQ0VAE68
         GcSesOZdMWHLHvTTDkVru7iYkuh+xc8nZNIrxubHZhAbXKOlXd9G+5VF9Gy9DnQw26+w
         9eV4iemL/NZWe1CDKled+bJRN5LfKKIaCdBcC+Jf6ZhYTOHzbn+JmCh7OzFMeeLYNEhW
         P9b2/WcfDz6ueODx0YDDj/gXZHIkTkA6FEK/mt27ZRKT0p1Ywc6pRpOyjX1sAOVp/ijt
         +Hv/jPys4yEcYd5iLdS8SugWWLH+Eblq1j/9VR18nZoqmV/lMgBtBrJJScQh8JRWo61J
         eJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk3xxYNyG63h08zL1alFQGEY3bVM5neSLz5eGGT3ciwik/gQ+Lz2NeIU3XbWFckAPaFM3o6QNYGgUmdV/3RzsLGomuoZxmJlT9
X-Gm-Message-State: AOJu0YzfRgwIXzYfHgEMkguz9bPeAiCQRDzCtfkxEDBPxpUWuvENSWio
	voupE8PYtvTMPsOvUgXdsUIgd0ChB0LeyB9E5l4OaPdLpuAibpZNJwQbM15QGX6kStJRiaBdW2r
	q9GK5myikpYUxhO5xhFd4EoEXqkX7yAzladpxbvrGDyOz6em1Xj4OBzHeBArhd4zFfeBd0jHrwe
	3qZKC3A2peXpGLFegbioCDHHYa+5nBNcbW
X-Received: by 2002:a05:6e02:1583:b0:376:408f:585b with SMTP id e9e14a558f8ab-376408f5927mr27006535ab.1.1719193920968;
        Sun, 23 Jun 2024 18:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyMeoB/u6xnkbi17lmDObkp94AykwrFoPiSJZcOVji66fsLtxN8RnHaCqmKD4jPsYX9ByWEX7xlASA7kKA5pc=
X-Received: by 2002:a05:6e02:1583:b0:376:408f:585b with SMTP id
 e9e14a558f8ab-376408f5927mr27006475ab.1.1719193920631; Sun, 23 Jun 2024
 18:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAKh1g55PTX=tXoiQB8sKiZ1T+bBnCE4W67fFi5G8zEfh-nKq2g@mail.gmail.com>
 <56a5a42d-a2cd-4988-853f-49df60813ecb@nec.com>
In-Reply-To: <56a5a42d-a2cd-4988-853f-49df60813ecb@nec.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 24 Jun 2024 09:52:16 +0800
Message-ID: <CALu+AoSt=hZjm-ENnaQw5XDg-J6k7KTe_cUpLsSbtQW_t7sowA@mail.gmail.com>
Subject: Re: enhance makedumpfile to dump process list from vmcore
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Prasad Koya <prasad@arista.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, Lianbo Jiang <lijiang@redhat.com>, 
	Tao Liu <ltao@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_185205_814744_968C53EE 
X-CRM114-Status: GOOD (  26.05  )
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

SGkgS2F6dSwKCk9uIFdlZCwgMTkgSnVuIDIwMjQgYXQgMTM6NDUsIEhBR0lPIEtBWlVISVRPKOiQ
qeWwvuOAgOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDI0LzA2
LzA2IDM6MTAsIFByYXNhZCBLb3lhIHdyb3RlOgo+ID4gSGkKPiA+Cj4gPiBXZSB1c2UgbWFrZWR1
bXBmaWxlIHRvIHJlYWQgdGhlIGRtZXNnIGJ1ZmZlciBmcm9tIHRoZSB2bWNvcmUuIFdlIGFyZQo+
ID4gd29ya2luZyBvbiBhZGRpbmcgYSBmZWF0dXJlIHRvIG1ha2VkdW1wZmlsZSB0byBleHRyYWN0
IHRoZSAicHJvY2Vzcwo+ID4gbGlzdCIgZnJvbSAvcHJvYy92bWNvcmUuIE91ciBtYWluIHVzZSBj
YXNlIGlzIHRvIHNhdmUgdGhlIHByb2Nlc3Nlcwo+ID4gdGhhdCB3ZXJlIHJ1bm5pbmcgYXQgdGhl
IHRpbWUgb2Yga2VybmVsIGNyYXNoIHRvIGEgZmlsZSBvbiB0aGUKPiA+IHBlcm1hbmVudCBzdG9y
YWdlIGZyb20gdGhlIGtkdW1wIGtlcm5lbC4gV2UgaW50ZW5kIHRvIHJlYWQgYSBoYW5kZnVsCj4g
PiBvZiB1c2VmdWwgZGF0YSBmb3IgZWFjaCBydW5uaW5nIHRhc2s6IHBpZCwgcGFyZW50IHBpZCwg
cmVhbCBwYXJlbnQKPiA+IHBpZCwgcHJpb3JpdHksIG5pY2UgdmFsdWUsIFJTUywgVk0gc2l6ZSwg
Y29tbWFuZCwgdXRpbWUsIHN0aW1lLCBPT00KPiA+IHNjb3JlLgo+ID4KPiA+IFByb2Nlc3MgbGlz
dCBmcm9tIHZtY29yZSBjYW4gcHJvYmFibHkgYmUgcmVhZCB1c2luZyBjcmFzaCB1dGlsaXR5LCBi
dXQKPiA+IGluIG91ciBlbWJlZGRlZCBzeXN0ZW0gdXNpbmcgbWFrZWR1bXBmaWxlIHRvIGRvIHRo
YXQgam9iIG1ha2VzIHNlbnNlCj4gPiBmb3IgdXMuCj4gPgo+ID4gSWYgc3VjaCBhbiBvcHRpb24g
aXMgdXNlZnVsIGZvciB0aGUgZ2VuZXJhbCB1c2VycyBvZiBtYWtlZHVtcGZpbGUsCj4gPiB3ZSdk
IGxpa2UgdG8gZ2V0IG1vcmUgaW5wdXRzIGFuZCBjb250cmlidXRlIHRvIHRoaXMgZmVhdHVyZS4K
Pgo+IEhpIFByYXNhZCwKPgo+IHRoYW5rIHlvdSBmb3Igc2hhcmluZyB0aGUgaWRlYS4gIEJ1dCBz
b3JyeSwgY3VycmVudGx5IHdlIGFyZSBub3QKPiBpbnRlcmVzdGVkIGluIGltcGxlbWVudGluZyBz
dWNoIGEgYmlnIGZ1bmN0aW9uIGluIG1ha2VkdW1wZmlsZS4KPgo+IFRoZSBkbWVzZyBidWZmZXIg
aXMgdGhlIG1vc3QgaW1wb3J0YW50IGluZm9ybWF0aW9uIHRvIGJlIGFibGUgdG8KPiBkZXRlcm1p
bmUgdGhlIGNhdXNlIG9mIGEgY3Jhc2ggb25seSB3aXRoIGl0LCBzbyB0aGUgLS1kdW1wLWRtZXNn
IG9wdGlvbgo+IHdhcyBpbXBsZW1lbnRlZCBpbiBtYWtlZHVtcGZpbGUgZmlyc3Qgb25jZSB1cG9u
IGEgdGltZS4gIEJ1dCBub3cgd2UgaGF2ZQo+IGhhbmRpZXIgdm1jb3JlLWRtZXNnIGNvbW1hbmQg
aW4ga2V4ZWMtdG9vbHMsIHNvIHdlIGRvbid0IGludGVuZCB0byBhZGQKPiBvdGhlciBmdW5jdGlv
bnMgdG8gbWFrZWR1bXBmaWxlIHRoYW4gbWFraW5nIGEgZHVtcGZpbGUuCj4KPiBJJ20gbm90IHN1
cmUgd2hldGhlciB0aGVzZSBhcmUgZG9hYmxlLCBidXQgSSB3b3VsZCBzdWdnZXN0IGEgZmV3IGlk
ZWFzCj4gaW5zdGVhZDoKPiAtIG1ha2UgZS5nLiB2bWNvcmUtcHJvY2Vzcy1saXN0IGNvbW1hbmQg
bGlrZSB2bWNvcmUtZG1lc2cuCgpOb3Qgc3VyZSBpZiB0aGlzIGlzIHdvcnRoIGVpdGhlci4gICAg
SSBndWVzcyBpdCBjYW4gYmUgZG9uZSB3aXRoIHNvbWUKY3Jhc2ggdG9vbCBzY3JpcHRzIG9yIGEg
Y3Jhc2ggcGx1Z2luPwoKPiAtIHVzZSBwYW5pYyBub3RpZmllciB0byBkdW1wIHByb2Nlc3MgbGlz
dCB0byB0aGUgZG1lc2cgYnVmZmVyIGJlZm9yZQo+IGtkdW1wLCBhbmQgdXNlIHZtY29yZS1kbWVz
ZyB0byBnZXQgaXQuCgpJdCBpcyBub3QgcmVjb21tZW5kZWQgdG8gYWRkIHRoZXNlIGJlZm9yZSBr
ZHVtcCBpZiBwZW9wbGUgc3RpbGwgd2FudCBhCnJlbGlhYmxlIGtkdW1wLgoKPgo+IFRoYW5rcywK
PiBLYXp1Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBrZXhlYyBtYWlsaW5nIGxpc3QKCgpUaGFua3MKRGF2ZQo+IGtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

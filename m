Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F0D1AD4A
	for <kexec@archiver.kernel.org>; Wed, 16 Oct 2024 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6VZ94m83/xugqbLvC31WPcSj5Px6FcT1qYYISM/sUJs=; b=ITgVlJIMVlJrbx
	zCVAXsua0jF5Te/YpyZuI4rq6KbVVYerWxZoexUGl4lnO0NEmA+ezbI+ORHSYP5QBttZt8y72/rUY
	INb9KMzPm/1egAlBsucIIZ59glfvt5a+jxi8qIxNe6wM1tRbGo4O4lo+gsJYw0Mkz3VDStcfQgpoF
	0dychiieEQ4KkMATsHd7+8XYk8wztX9E1mV5sbQmPYuszArBiIYzhrrNUcaCmYYznVwP7u5uMMrZm
	0QXU05EgnniGRibiYgV7EkUknvjffnf7ppaJazOlCXXY/wBqmzTRqr6ZpeyvivUBEow4QXosZk8A5
	slVZVX9mnMwvpfhSYIuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t12Ly-0000000Bbfl-2tNm;
	Wed, 16 Oct 2024 11:38:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t12Lv-0000000Bbek-32lS
	for kexec@lists.infradead.org;
	Wed, 16 Oct 2024 11:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729078686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF+eTlcyLvbiORgpfj4z63y0NrWPM0D2UwJwXqsYRK0=;
	b=gBDolMi1l0Ypgrf2Qys8Z6DgywlW+baEkNqMf3989von0BDwwbijKmaQMvFy3gTbcRgQIB
	LCS+ACa5P087QjXVAR37kKw4wnB1fiwbZLkNaN5nLna5GSzNv88VYru/A+d+k/HvZNXW+t
	kUBTVYkcAe/iHEa1nH6pckyQ+GGx4a0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-GaZR5troO3KSw4Xdcp0p-Q-1; Wed, 16 Oct 2024 07:38:05 -0400
X-MC-Unique: GaZR5troO3KSw4Xdcp0p-Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe4fc0aa7so159936736d6.0
        for <kexec@lists.infradead.org>; Wed, 16 Oct 2024 04:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729078685; x=1729683485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF+eTlcyLvbiORgpfj4z63y0NrWPM0D2UwJwXqsYRK0=;
        b=YGrsxQDGKD0X7MTx6q2AeAL+plxGbRb5U4lvKDg7Iw+CtkpEcK8V731VvTF53ahS1g
         gZvjidmYbP0A8p0swJs0G9QVgScBVy6vv6APvIwQAeqe9v1Rfz4LLkvW+ki16ZABJAS3
         5gwTUocStSODH8uVGwHtc3xRbCeZIG8llAKXifzSB78rkRWL8OPgJHaxcAUSrJMH+vlu
         qrjUt7+a01jVPsuKsxcPYhB3NeQGcpfT2zwWlTOuJ56gF89anDas+Q4ajF5RoXkVl3KK
         SFANs8tQRB0KxlsgkM456qZxmks+ghOz/1les2ww7KIR58iehty2udpAJ38rE7U98Qth
         KvJA==
X-Forwarded-Encrypted: i=1; AJvYcCUTAn+0NUWI/O9q0NnPugSuu2dh1MYShpU+gQwRhKzVsedSc7bg8cfKmLARsi24JEDQoKBn5A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwvjEWnG0iO0tPbC5N9ZxivN6Ss4hj9zj205H51UY2f0W9XmcLM
	iieIUSlw8GF/i6TpthjUVyavu4oex4NY7CNAOJ63We0Z8sm6ICiklnZqlX+P2CmbhLsVHuADuIu
	UcUbNUgj72eItDbnh0xU7ypC8elYaWg0JzJq5T2C5c71A++hLl/aVIv/RHpt2IJW26oxSyGa7ff
	4fvFe0ANSXEJGEz65EYSAZJB8zmMOUJJGH
X-Received: by 2002:a05:6214:568b:b0:6cb:e770:f50b with SMTP id 6a1803df08f44-6cbf9e76302mr205594126d6.33.1729078684948;
        Wed, 16 Oct 2024 04:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoTl5BmyJt+oy/WMk/6HWSOvYllCORgVjiXW6saChSXDLQ2ZSU5piVCnAbv4H6IbcUBSR2TOM737092lru0lU=
X-Received: by 2002:a05:6214:568b:b0:6cb:e770:f50b with SMTP id
 6a1803df08f44-6cbf9e76302mr205593936d6.33.1729078684711; Wed, 16 Oct 2024
 04:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241008115408.21944-1-piliu@redhat.com> <20241008115408.21944-3-piliu@redhat.com>
 <20241011084406.GB66815@kernel.org> <CAF+s44QMLaQLmm6cst+o2Ssgi2v-SBXcw3hE1kKTFnL7DmoLFg@mail.gmail.com>
 <CAF+s44QRNpBrRuJsuVwvZduHTLhEFTtUz3fU5=4YNAn8sbBccw@mail.gmail.com> <20241015132610.GA2162@kernel.org>
In-Reply-To: <20241015132610.GA2162@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 16 Oct 2024 19:37:53 +0800
Message-ID: <CAF+s44SihJFWqe94fe33dNUgc0PiH_JOUvuxEpLiMWimV6cK5A@mail.gmail.com>
Subject: Re: [PATCH 2/3] kexec: Introduce UKI image parser
To: Simon Horman <horms@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_043807_853200_1F1E24BB 
X-CRM114-Status: GOOD (  12.63  )
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

T24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgOToyNuKAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIE9jdCAxNCwgMjAyNCBhdCAxMDo0MzozNEFNICsw
ODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+IEhlbGxvIGV2ZXJ5b25lLAo+ID4KPiA+IEkgaGF2
ZSBjcmVhdGVkIFYyIGFuZCBtYWtlIGEgUFI6IGh0dHBzOi8vZ2l0aHViLmNvbS9ob3Jtcy9rZXhl
Yy10b29scy9wdWxsLzkKPiA+Cj4gPiBEdWUgdG8gdXRpbGl6aW5nIHRoZSB3b3JrZmxvdyBpbiBn
aXRodWIgdG8gaGF2ZSBzb21lIGJhc2ljIGNoZWNrcwo+ID4gYXV0b21hdGljYWxseSAsIEkgbWln
cmF0ZWQgaXQgdG8gZ2l0aHViIGluc3RlYWQgb2YgbWFpbGluZy1saXN0Lgo+ID4KPiA+IFBsZWFz
ZSBzaGFyZSB5b3VyIG9waW5pb25zLgo+Cj4gSSBhcHByZWNpYXRlIHlvdSBtYWtpbmcgdXNlIG9m
IEdpdEh1YiwKPiBidXQgcGxlYXNlIHBvc3QgcGF0Y2ggc3VibWlzc2lvbnMgdXNpbmcgdGhlIGVt
YWlsIHdvcmtmbG93Lgo+CgpTZWUsIEkgd2lsbCB1c2UgLmdpdGh1Yi93b3JrZmxvd3MgdG8gY2hl
Y2sgYW55IGJ1aWxkIGlzc3VlIGFuZCBnbwp0aHJvdWdoIHRoZSBlbWFpbCB3b3JrZmxvdy4KCkkg
aGF2ZSBwb3N0ZWQgVjIgdXNpbmcgdGhlIG1haWxpbmcgbGlzdC4KClRoYW5rcywKClBpbmdmYW4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

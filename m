Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C85C48292
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pns6AY0GJJmmwZdaDyG3gZyk/8S1g6oTUNZ1tUrlDG4=; b=K30JSMp1nq9hcA
	YaEFU4wtXsjR01Eop8Unc4cEsYvpsvnpBk7+PfUbS1/QN3juExpgt0q6AOwEWxg51x4Pwpz8sa+Nd
	hIYhLrZsxs4/4KjWw/WWhp/TcD5FVElovfh57lflG3wDEOGfE+dL8ySF0jgK97dd8CqDgOq5CKrki
	wIbY6+xOmR9I+p6pWaVlikAEzaOZ5PzlRACFQ2GEjk5NqUMiEQ9bi6Ac85EuPCCDagtBYO5llFX2j
	kuUch43593Qiq0cg/mCOgcHZqAQ3RicoqNDMAkXYrE/NAjx5JeqHNS2Y726zJ5Q6UD/ArPjnv6x5k
	qGy83xAWRkbzLt6HYFjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2zU-00000004DTj-16l2;
	Mon, 05 Feb 2024 17:42:44 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2zR-00000004DSi-3BuM
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 17:42:42 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-42aa4a9d984so37570271cf.1
        for <kexec@lists.infradead.org>; Mon, 05 Feb 2024 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707154960; x=1707759760; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8HE4Ga8BSdBO6M6GmqVFa+HwwrrcZFVY3gTfyQML7uA=;
        b=Fx/5GZAM08/WEkrj/gRuQjyfa1cvxLodDHqoCNjQpEmdS+kofR4HQ2tUiVIRcnFt5r
         VGqLx+KBhOb9/qcw8ZAlFUopSZwNDawevBwK4Wps1bxQndGsb9PY1gc10YSXSAsgfQIx
         e7VP/SGXiEmadZQSx1h6HM0S3cEgeFjexz2CIlLfRudUkxxg1p7SPTFFPy289vpb18xp
         X1mO4CBCOWk3mTaQ8KZvkBeUaHGo6JgYJ4BSlU0hHNG8COrOSEQkFaIbvWl01nx3JTgZ
         sqUvW70FAzHe/nnWzLRZtGxJjEEfK0Nmbij7kScxkXlyUL24SZcm38xs9ld6sVaNiRDd
         1/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154960; x=1707759760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HE4Ga8BSdBO6M6GmqVFa+HwwrrcZFVY3gTfyQML7uA=;
        b=NeqoZF7wjnvYrNNnmO0XlHqCAYTstA7WKJk10dxJXEtQUvAMiqYBC1a2MoFReHwKQJ
         cqpUeHgW/cTiPo1w8SM8hketrOyZpxIccyBsK6EkUamWiVIfeXx59ed7yWh5YxIgH0g4
         LecffTvS5EirgGIelWHssot6B5PaqZIQuWu/h77ylGPetXfa2VFLjNF5z/D1nzdYUY0N
         w+Vtbuu2BdLQWtNAPxVbjWTBPy862fboITRbFtK5lrrnbl38S/+CluDNXaBa0fQDzf70
         fnwOPjv5JEan1x0M9Dv+ASKTvE25Ae7ZsuYQ93J5s1Lc0qNlC1mGRKyZtYVC+geP1Lg3
         0oNw==
X-Gm-Message-State: AOJu0YxaeR7gU5lpPfPPOXZAqLEEmdmqJlXl3ciRchwSgcaEGn7h5tOa
	UlPEWefBCIV9ySjjHuK0gG9caeBlpmMqUY4oRZElQ2mRSp8YD7ujt7rINxUekJI=
X-Google-Smtp-Source: AGHT+IHU4KsrD3c0EP9g7y8hIFpyaAa4okXRRNN8qBm5KuQa3mySXXt7+dYoSw0Wr4a8G0dHjecPyQ==
X-Received: by 2002:a05:622a:60c:b0:42a:9cd0:10d6 with SMTP id z12-20020a05622a060c00b0042a9cd010d6mr76578qta.34.1707154959703;
        Mon, 05 Feb 2024 09:42:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJEoYPtNarb3IKpx+TlDaQWnlGCPYYwqRse61FZumUi17YhNjF1PV/xF22JLrvNXqFbkebE3MWbOPPsd6X9lkUYDUu8OcgOJYYw525y7FBiRK5b6k1ygrBSUjRHKinQ83+/bgI+lNtpfQIgMjD96anUt1JUN/A07pGruYvZXzU+IkWkDlqulHlYWtlENVhDo7EDFB9txF76qn+sovVDt+EhL7ut1S/hZswfg+VWs1j/g37rEX6ap6/4HYUNOLco77wrroLxU0HPFDsjm75+gckY78bO+VGj8ZjeEVOo3As9m48+X0kxJ0Q+DCxEkK31OMS3+rk9JgZYfc/rvBZ4DfknXCKEFbNUSYiTsiRn8LuNk6aoyUi8Yt0fkyR8E0kWWgCK3tQyQl37yuAXLLWMzwjLPdLL+LetoDhwayckEgT6hVcQTSAdr/64XA4acyBFh/KrJTmXe27EODPpZ7XhFeqlSK9tOkNG5gDuy05MIpWcUZfCBG5xHxACRXuyekJg91XbC9JxH2AkXUiOdSYdpHdIXrVkRrLeiPD0hPJPc/vsi8qojAJdzmxkzyfLzLhg19sg4M2WCCcphSLrPd+8rW3G5XCnkab07S61wEP7FLkMnOakYoKQoDGJkTOFQdDEWmESvGbq6OoQFA0uUJj+KlWqrYt9e4aDsPJbchaYnyqj5Tje8QC1runF4T0tAZjue/v+GvEzghpVJQWjy+T/0qjRPKiwuFVw3YGWf5PAbhZzViL
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id z5-20020ac86b85000000b0042c04cef1d6sm137895qts.66.2024.02.05.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:42:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2zO-000fQ2-NV;
	Mon, 05 Feb 2024 13:42:38 -0400
Date: Mon, 5 Feb 2024 13:42:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240205174238.GC31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_094241_842567_E34FBC94 
X-CRM114-Status: GOOD (  23.81  )
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

T24gTW9uLCBGZWIgMDUsIDIwMjQgYXQgMTI6MDE6NDVQTSArMDAwMCwgSmFtZXMgR293YW5zIHdy
b3RlOgoKPiBUaGUgbWFpbiBhc3BlY3Qgd2XigJlyZSBsb29raW5nIGZvciBmZWVkYmFjay9vcGlu
aW9ucyBvbiBoZXJlIGlzIHRoZSBjb25jZXB0IG9mCj4gcHV0dGluZyBhbGwgcGVyc2lzdGVudCBz
dGF0ZSBpbiBhIHNpbmdsZSBmaWxlc3lzdGVtOiBjb21iaW5pbmcgZ3Vlc3QgUkFNIGFuZAo+IElP
TU1VIHBndGFibGVzIGluIG9uZSBzdG9yZS4gQWxzbywgdGhlIHF1ZXN0aW9uIG9mIGEgaGFyZCBz
ZXBhcmF0aW9uIGJldHdlZW4KPiBwZXJzaXN0ZW50IG1lbW9yeSBhbmQgZXBoZW1lcmFsIG1lbW9y
eSwgY29tcGFyZWQgdG8gYWxsb3dpbmcgYXJiaXRyYXJ5IHBhZ2VzIHRvCj4gYmUgcGVyc2lzdGVk
LiBQa2VybmZzIGRvZXMgaXQgdmlhIGEgaGFyZCBzZXBhcmF0aW9uIGRlZmluZWQgYXQgYm9vdCB0
aW1lLCBvdGhlcgo+IGFwcHJvYWNoZXMgY291bGQgbWFrZSB0aGUgY2FydmluZyBvdXQgb2YgcGVy
c2lzdGVudCBwYWdlcyBkeW5hbWljLgoKSSB0aGluayBpZiB5b3UgYXJlIGdvaW5nIHRvIGF0dGVt
cHQgc29tZXRoaW5nIGxpa2UgdGhpcyB0aGVuIHRoZSBlbmQKcmVzdWx0IG11c3QgYnJpbmcgdGhp
bmdzIGJhY2sgdG8gaGF2aW5nIHRoZSBzYW1lIGRhdGEgc3RydWN0dXJlcyBmdWxseQpyZXN0b3Jl
ZC4KCkl0IGlzIGZpbmUgdGhhdCB0aGUgcGtlcm5mcyBob2xkcyBzb21lIHBlcnNpc3RhbnQgbWVt
b3J5IHRoYXQKZ3VhcmVudGVlcyB0aGUgSU9NTVUgY2FuIHJlbWFpbiBwcm9ncmFtbWVkIGFuZCB0
aGUgVk0gcGFnZXMgY2FuIGJlY29tZQpmaXhlZCBhY3Jvc3MgdGhlIGtleGVjCgpCdXQgb25jZSB0
aGUgVk1NIHN0YXJ0cyB0byByZXN0b3JlIGl0IHNlbGYgd2UgbmVlZCB0byBnZXQgYmFjayB0byB0
aGUKb3JpZ2luYWwgY29uZmlndXJhdGlvbjoKIC0gQSBtbWFwIHRoYXQgcG9pbnRzIHRvIHRoZSBW
TSdzIHBoeXNpY2FsIHBhZ2VzCiAtIEFuIGlvbW11ZmQgSU9BUyB0aGF0IHBvaW50cyB0byB0aGUg
YWJvdmUgbW1hcAogLSBBbiBpb21tdWZkIEhXUFQgdGhhdCByZXByZXNlbnRzIHRoYXQgc2FtZSBt
YXBwaW5nCiAtIEFuIGlvbW11X2RvbWFpbiBwcm9ncmFtbWVkIGludG8gSFcgdGhhdCB0aGUgSFdQ
VAoKSWUgeW91IGNhbid0IGp1c3QgcmVib290IGFuZCBsZWF2ZSB0aGUgSU9NTVUgaGFuZ2luZyBv
dXQgaW4gc29tZQp1bmRlZmluZWQgbGFuZCAtIGVzcGVjaWFsbHkgaW4gbGF0ZXN0IGtlcm5lbHMh
CgpGb3IgdnQtZCB5b3UgbmVlZCB0byByZXRhaW4gdGhlIGVudGlyZSByb290IHRhYmxlIGFuZCBh
bGwgdGhlIHJlcXVpcmVkCmNvbnRleHQgZW50cmllcyB0b28sIFRoZSByZXN0YXJ0aW5nIGlvbW11
IG5lZWRzIHRvIHVuZGVyc3RhbmQgdGhhdCBpdApoYXMgdG8gInJlc3RvcmUiIGEgdGVtcG9yYXJ5
IGlvbW11X2RvbWFpbiBmcm9tIHRoZSBwa2VybmZzLgoKWW91IGNhbiBsYXRlciByZWNvbnN0aXR1
dGUgYSBwcm9wZXIgaW9tbXVfZG9tYWluIGZyb20gdGhlIFZNTSBhbmQKYXRvbWljIHN3aXRjaC4K
ClNvLCBJJ20gc3VycHJpc2VkIHRvIHNlZSB0aGlzIGFwcHJvYWNoIHdoZXJlIHRoaW5ncyBqdXN0
IGxpdmUgZm9yZXZlcgppbiB0aGUga2VybmZzLCBJIGRvbid0IHNlZSBob3cgInJlc3RvcmUiIGlz
IGdvaW5nIHRvIHdvcmsgdmVyeSB3ZWxsCmxpa2UgdGhpcy4KCkkgd291bGQgdGhpbmsgdGhhdCBh
IHNhdmUvcmVzdG9yZSBtZW50YWxpdGl0eSB3b3VsZCBtYWtlIG1vcmUKc2Vuc2UuIEZvciBpbnN0
YW5jZSB5b3UgY291bGQgbWFrZSBhIHNwZWNpYWwgaW9tbXVfZG9tYWluIHRoYXQgaXMgZml4ZWQK
YW5kIGxpdmVzIGluIHRoZSBwa2VybmZzLiBUaGUgb3BlcmF0aW9uIHdvdWxkIGJlIHRvIGNvcHkg
ZnJvbSB0aGUgbGl2ZQppb21tdV9kb21haW4gdG8gdGhlIGZpeGVkIG9uZSBhbmQgdGhlbiByZXBs
YWNlIHRoZSBpb21tdSBIVyB0byB0aGUKZml4ZWQgb25lLgoKSW4gdGhlIHBvc3Qta2V4ZWMgd29y
bGQgdGhlIGlvbW11IHdvdWxkIHJlY3JlYXRlIHRoYXQgc3BlY2lhbCBkb21haW4KYW5kIHBvaW50
IHRoZSBpb21tdSBhdCBpdC4gKGNvcHlpbmcgdGhlIHJvb3QgYW5kIGNvbnRleHQgZGVzY3JpcHRp
b25zCm91dCBvZiB0aGUgcGtlcm5mcykuIFRoZW4gc29tZWhvdyB0aGF0IHdvdWxkIGdldCBpbnRv
IGlvbW11ZmQgYW5kIFZGSU8Kc28gdGhhdCBpdCBjb3VsZCB0YWtlIG92ZXIgdGhhdCBzcGVjaWFs
IG1hcHBpbmcgZHVyaW5nIGl0cyBzdGFydHVwLgoKVGhlbiB5b3UnZCBidWlsZCB0aGUgbm9ybWFs
IG9wZXJhdGluZyBpb2FzIGFuZCBod3B0ICh3aXRoIGFsbCB0aGUKcmlnaHQgcGFnZSByZWZjb3Vu
dHMvZXRjKSB0aGVuIHN3aXRjaCB0byBpdCBhbmQgZnJlZSB0aGUgcGtlcm5mcwptZW1vcnkuCgpJ
dCBzZWVtcyBhbG90IGxlc3MgaW52YXNpdmUgdG8gbWUuIFRoZSBzcGVjaWFsIGNhc2UgaXMgY2xl
YXJseSBhCnNwZWNpYWwgY2FzZSBhbmQgZG9lc24ndCBtZXNzIHVwIHRoZSBub3JtYWwgb3BlcmF0
aW9uIG9mIHRoZSBkcml2ZXJzLgoKSXQgYmVjb21lcyBtb3JlIGxpa2Uga2R1bXAgd2hlcmUgdGhl
IGlvbW11IGRyaXZlciBpcyBydW5uaW5nIGluIGEKZmFpcmx5IG5vcm1hbCBtb2RlLCBqdXN0IHdp
dGggc29tZSBzdHVmZiBjb3BpZWQgZnJvbSB0aGUgcHJpb3Iga2VybmVsLgoKWW91ciB0ZXh0IHNw
ZW50IGFsb3Qgb2YgdGltZSB0YWxraW5nIGFib3V0IHRoZSBkZXNpZ24gb2YgaG93IHRoZSBwYWdl
cwpwZXJzaXN0LCB3aGljaCBpcyBpbnRlcmVzdGluZywgYnV0IGl0IHNlZW1zIGxpa2Ugb25seSBh
IHNtYWxsIHBhcnQgb2YKdGhlIHByb2JsZW0uIEFjdHVhbGx5IHVzaW5nIHRoYXQgbWVjaGFuaXNt
IGluIGEgc2FuZSB3YXkgYW5kIGNvdmVyIGFsbAp0aGUgZnVuY3Rpb25hbCBpc3N1ZXMgaW4gdGhl
IEhXIGRyaXZlcnMgaXMgZ29pbmcgdG8gYmUgcmVhbGx5CmNoYWxsZW5naW5nLgoKPiAqIE5lZWRp
bmcgdG8gZHJpdmUgYW5kIHJlLWh5ZHJhdGUgdGhlIElPTU1VIHBhZ2UgdGFibGVzIGJ5IGRlZmlu
aW5nIGFuIElPTU1VIGZpbGUuCj4gUmVhbGx5IHdlIHNob3VsZCBtb3ZlIHRoZSBhYnN0cmFjdGlv
biBvbmUgbGV2ZWwgdXAgYW5kIG1ha2UgdGhlIHdob2xlIFZGSU8KPiBjb250YWluZXIgcGVyc2lz
dGVudCB2aWEgYSBwa2VybmZzIGZpbGUuIFRoYXQgd2F5IHlvdeKAmWQgImp1c3QiIHJlLW9wZW4g
dGhlIFZGSU8KPiBjb250YWluZXIgZmlsZSBhbmQgYWxsIG9mIHRoZSBETUEgbWFwcGluZ3MgaW5z
aWRlIFZGSU8gd291bGQgYWxyZWFkeSBiZSBzZXQgdXAuCgpJIGRvdWJ0IHRoaXMuLiBJdCBwcm9i
YWJseSBuZWVkcyB0byBiZSBtdWNoIGZpbmVyIGdyYWluZWQgYWN0dWFsbHksCm90aGVyd2lzZSB5
b3UgYXJlIGdvaW5nIHRvIGJlIHNlcmlhbGl6aW5nIGV2ZXJ5dGhpbmcuIFNvbWVob3cgSSB0aGlu
awp5b3UgYXJlIGJldHRlciB0byBzZXJpYWxpemUgYSBtaW5pbXVtIGFuZCB0cnkgdG8gcmVjb25z
dHJ1Y3QKZXZlcnl0aGluZyBlbHNlIGluIHVzZXJzcGFjZS4gTGlrZSBjb25zZXJ2aW5nIGlvbW11
ZmQgSURzIHdvdWxkIGJlIGEKaHVnZSBQSVRBLgoKVGhlcmUgYXJlIGFsc28gZ29pbmcgdG8gYmUg
bG90cyBvZiBzZWN1cml0eSBxdWVzdGlvbnMgaGVyZSwgbGlrZSB3ZQpjYW4ndCBqdXN0IGxldCB1
c2Vyc3BhY2UgZmVlZCBpbiBhbnkgZ2FyYmFnZSBhbmQgdmlvbGF0ZSB2ZmlvIGFuZAppb21tdSBp
bnZhcmlhbnRzLgoKSmFzb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

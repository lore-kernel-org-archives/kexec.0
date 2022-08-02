Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BBEC00140
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 11:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aKkGdfBf6dzjXEoJOoZg+VVPxGLYYrojN960etMnlEU=; b=pt1zjuctdEf6MK
	5ibTRT5UXu7rVBVPnr8N2OnIEDbJOBqfyvvhS7XmBy1AKtCu3/ior+dRLBZEhSHhGsCKwSGYNo4mK
	Cjr1OagFkfU3p84D44GVSlrpT+Xs3In3WWJ4w2V4ipqf1TWZRRpVsCzWKb+kGc66+C71a5vIo/niw
	G/XBtblvIgV3eVRhQquItnC5O7RAaJoRjRvutJ4yK+gosInifDumwSibwlmJnDtCz54iXgEGojs8o
	BsinBinIBzvOeiMIndHTYYcqe2LF+bdRXGOSHkfjCxDt7/3qFkcwd23SQ8bavVpWQCpZB9YdlbAz1
	YGTzVEg4GXYdl7YUX+BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIpfW-00DDRU-Ml; Tue, 02 Aug 2022 11:02:34 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIpfT-00DDO4-Do
	for kexec@lists.infradead.org; Tue, 02 Aug 2022 11:02:32 +0000
Received: by mail-wr1-x42d.google.com with SMTP id l4so17442635wrm.13
        for <kexec@lists.infradead.org>; Tue, 02 Aug 2022 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9f72dYH7EcyVDv+LBnMsCnVkZlmCOPJR1dVC+vHmlQ=;
        b=PbIRsQ5mLbKfXHTSx44sIJ7Gd4sv9wPPE+08+maGOObDZIERZSne9y+IJCHxiRBpzx
         fmOh62MqqURQDpy8ukvI91oKY8lX34tW5hQAj2D5LVcdVVesrsQn76XAzrrVMTNCspf3
         xWJf8A7P9u3/054DS6MXNZNuyK03gSseguO6b+X/3Ihwtji3ab+KvS5gozcaUHrmSGll
         JeHTUHxa4bMHjlkAfoUFmdsVb0Y+OvT1cviJwKv2T7j7LzTzrLLHOkmtdsmjMEo08Ngm
         U+Obc+emsSXq1Lv1stUAf7YIcfGRvqEWeXCPTngvkFYA3Cnnkw4trTzKRdOlLR6rkhX5
         Sydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9f72dYH7EcyVDv+LBnMsCnVkZlmCOPJR1dVC+vHmlQ=;
        b=otzZTSEJ9ellNqQgMWoMjxAORxQU9K616L4T76asHIWIUaHA1E1c6eM17W5cMmAhMx
         n1oVS0MRW4ZjSbg6Ec7cpWebkiZJy9BNx7usz0uhpeEFAIS0bMO7jgUdqz7nAmAulwUP
         4oylSIHV9aYS5hppsdSEsTy1N5tDWrvEsn1HbAqdjRfXzmHPskH7PEw6SRQ8kNhUwAPa
         0zeyWUJTuUqV4cuJ/S4JOH3AdtbLjByV33LgyT7LnCgbaElNkREOHKdvcmJ3qgDFBevN
         LrElKB9WIOypIK4zhesXP579hNtfdeKwpJIxBniHgJ45rdaRCSJrRgYHAMHGzq4hdJ3M
         IlTg==
X-Gm-Message-State: ACgBeo1Gb/BsIm8gvbJnnWi5sRYKOPBAGWf9UgXwkW7lb8RslB9STp/A
	UvZOehGM6ISSlDbH9PAt/s8=
X-Google-Smtp-Source: AA6agR6n0fiwI6OBO7K3lIW3MDPSt9E3HBA1Pv5i8qmZaUp+fqN9wXf1IAashZzOuQ8JYMX2xYt0jg==
X-Received: by 2002:a5d:5a9a:0:b0:220:6309:5c87 with SMTP id bp26-20020a5d5a9a000000b0022063095c87mr5428877wrb.107.1659438147957;
        Tue, 02 Aug 2022 04:02:27 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id q12-20020a056000136c00b0021e47fb24a2sm14511127wrz.19.2022.08.02.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:02:26 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Date: Tue, 02 Aug 2022 13:02:25 +0200
Message-ID: <5847084.alqRGMn8q6@opensuse>
In-Reply-To: <YujTHv0xVG8DirkW@MiWiFi-R3L-srv>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com> <1923146.PYKUYFuaPT@opensuse> <YujTHv0xVG8DirkW@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_040231_490118_8679C0A3 
X-CRM114-Status: GOOD (  23.72  )
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

T24gbWFydGVkw6wgMiBhZ29zdG8gMjAyMiAwOTozMjo0NiBDRVNUIEJhb3F1YW4gSGUgd3JvdGU6
Cj4gT24gMDgvMDIvMjIgYXQgMDg6MjBhbSwgRmFiaW8gTS4gRGUgRnJhbmNlc2NvIHdyb3RlOgo+
ID4gT24gbWFydGVkw6wgMiBhZ29zdG8gMjAyMiAwNTowNjo1NCBDRVNUIEJhb3F1YW4gSGUgd3Jv
dGU6Cj4gPiA+IE9uIDA3LzA4LzIyIGF0IDAxOjE1YW0sIEZhYmlvIE0uIERlIEZyYW5jZXNjbyB3
cm90ZToKPiA+ID4gPiBUaGUgdXNlIG9mIGttYXAoKSBhbmQga21hcF9hdG9taWMoKSBhcmUgYmVp
bmcgZGVwcmVjYXRlZCBpbiBmYXZvciAKb2YKPiA+ID4gPiBrbWFwX2xvY2FsX3BhZ2UoKS4KPiA+
ID4gPiAKPiA+ID4gPiBXaXRoIGttYXBfbG9jYWxfcGFnZSgpLCB0aGUgbWFwcGluZ3MgYXJlIHBl
ciB0aHJlYWQsIENQVSBsb2NhbCBhbmQgCm5vdAo+ID4gPiA+IGdsb2JhbGx5IHZpc2libGUuIEZ1
cnRoZXJtb3JlLCB0aGUgbWFwcGluZ3MgY2FuIGJlIGFjcXVpcmVkIGZyb20gCmFueQo+ID4gPiA+
IGNvbnRleHQgKGluY2x1ZGluZyBpbnRlcnJ1cHRzKS4KPiA+ID4gPiAKPiA+ID4gPiBUaGVyZWZv
cmUsIHVzZSBrbWFwX2xvY2FsX3BhZ2UoKSBpbiBrZXhlY19jb3JlLmMgYmVjYXVzZSB0aGVzZSAK
bWFwcGluZ3MgCj4gPiBhcmUKPiA+ID4gPiBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGFuZCBub3Qg
Z2xvYmFsbHkgdmlzaWJsZS4KPiA+ID4gPiAKPiA+ID4gPiBUZXN0ZWQgb24gYSBRRU1VICsgS1ZN
IDMyLWJpdHMgVk0gYm9vdGluZyBhIGtlcm5lbCB3aXRoIEhJR0hNRU02NEdCCj4gPiA+ID4gZW5h
YmxlZC4KPiA+ID4gCj4gPiA+IFdvbmRlcmluZyB3aGF0IGFyY2ggeW91IHRlc3RlZCB3aXRoLgo+
ID4gCj4gPiBJJ20gc29ycnksIEkgZm9yZ290IHRvIHNheSB0aGF0IEkgdXNlIHg4Nl8zMiB3aXRo
IDRHQiB0byA2R0IgUkFNLgo+ID4gVGhpcyBpcyB1c3VhbGx5IGFuIGluZm9ybWF0aW9uIHRoYXQg
SSBhZGQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlcyBvZiBhbGwgCnRoZSAKPiA+IHJlY2VudCBjb252
ZXJzaW9ucyBJJ20gd29ya2luZyBvbiBhY3Jvc3MgdGhlIGVudGlyZSBrZXJuZWwuCj4gPiAKPiA+
IEFub3RoZXIgaW1wb3J0YW50IGluZm9ybWF0aW9uIChvdmVybG9va2VkIGFnYWluIHRoaXMgdGlt
ZSkgaXMgdGhhdCAoMSkgCj4gPiBrbWFwKCkgY29tZXMgd2l0aCBhbiBvdmVyaGVhZCBhcyBtYXBw
aW5nIHNwYWNlIGlzIHJlc3RyaWN0ZWQgYW5kIApwcm90ZWN0ZWQgCj4gPiBieSBhIGdsb2JhbCBs
b2NrIGZvciBzeW5jaHJvbml6YXRpb24gYW5kICgyKSBpdCBhbHNvIHJlcXVpcmVzIGdsb2JhbCAK
VExCIAo+ID4gaW52YWxpZGF0aW9uIHdoZW4gdGhlIGttYXDigJlzIHBvb2wgd3JhcHMgYW5kIGl0
IG1pZ2h0IGJsb2NrIHdoZW4gdGhlIAptYXBwaW5nIAo+ID4gc3BhY2UgaXMgZnVsbHkgdXRpbGl6
ZWQgdW50aWwgYSBzbG90IGJlY29tZXMgYXZhaWxhYmxlLgo+IAo+IFRoYW5rcyBhIGxvdCBmb3Ig
dXBkYXRlIHdpdGggbW9yZSBkZXRhaWxzLCBGYWJpby4KCllvdSdyZSB3ZWxjb21lLgoKPiBNYXli
ZSB0aGVzZSBjYW4gYmUKPiBhZGRlZCBpbnRvIGxvZyB3aXRoIHYzIGlmIHlvdSB0aGluayB0aGV5
IGFyZSB3b3J0aCBhZGRpbmcsIGFuZCB3aXRoIG15Cj4gQWNrIHNpbmNlIG5vIGNvZGUgY2hhbmdl
IHJlbGF0ZWQuIFlvdSBkZWNpZGUuCgpGb3Igd2Vla3MgSSd2ZSBiZWVuIHRoaW5raW5nIHRoYXQg
dGhlc2UgZGV0YWlscyB3ZXJlIG5vdCBuZWNlc3NhcnkgaW4gdGhlIApjb21taXQgbWVzc2FnZSBv
ZiB0aGVzZSBjb252ZXJzaW9ucy4gTGF0ZXIgSSByZWFsaXplZCB0aGF0IGEgZmFpciBudW1iZXIg
b2YgCm1haW50YWluZXJzIHdlcmVuJ3QgYXdhcmUgb2Ygd2h5IHdlIHNob3VsZCBjaGFuZ2Ugc29t
ZXRoaW5nIHRoYXQgaGFkIGJlZW4gCndvcmtpbmcgInByb3Blcmx5IiBmb3IgeWVhcnMuIFBlcmhh
cHMgdGhleSB0aG91Z2h0IHRoYXQgd2Ugd291bGQgZmFjZSB0b28gCm1hbnkgcmlza3Mgb2YgYnJl
YWtpbmcgdGhpbmdzIHZlcnN1cyBsaXR0bGUgcmV3YXJkcy4KCkFmdGVyIGRpc2N1c3Npbmcgd2l0
aCBHcmVnIEstSCAod2hvIHdhcyBpbml0aWFsbHkgbm90IGZvbmQgb2YgdGhlc2UgY2hhbmdlcyAK
dG8gY29yZSBwYXJ0cyBvZiBmaXJtd2FyZSBsb2FkaW5nIG1lY2hhbmlzbSksIGhlIHN1Z2dlc3Rl
ZCB0aGF0IGEgcHJvcGVyIApjb21taXQgbG9nIHdpdGggdGhlIG5lY2Vzc2FyeSBpbmZvcm1hdGlv
biBjb3VsZCBoYXZlIGhlbHBlZCBoaW1zZWxmIGFuZCB0aGUgCm90aGVyIG1haW50YWluZXJzIHdo
byBtYXkgbm90IHlldCBoYWQgdGltZSB0byBkZWVwZW4gdGhpcyB0b3BpY3MuCgpUaGlzIHBhdGNo
IHRvICJrZXhlYyIgc2xpcHBlZCBpbiB3aXRoIG5vIHN1Y2ggYWRkaXRpb25zLgoKVGhlcmVmb3Jl
LCBJIGFncmVlIHdpdGggeW91IGluIGZ1bGw6IEknbGwgYWRkIHRoZXNlIGluZm9ybWF0aW9uIGFu
ZCBzZW5kIGEgCm5ldyB2ZXJzaW9uIEFTQVAuCgo+IFRoYW5rcyBhZ2FpbiBmb3IgdGhlIGVmZm9y
dC4KClRoYW5rcyBzbyBtdWNoIGZvciB0aGUgIkFja2VkLWJ5OiIgdGFnIGZyb20geW91LgoKRmFi
aW8gIAoKW3NuaXBdCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAA2C32771
	for <kexec@archiver.kernel.org>; Tue, 27 Sep 2022 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8OxlKeYGvKbCSN4sWCJHGwJP8bmg3fCTs81RWBrKAhQ=; b=zWhH5ARru2CnCV
	BUL9C5UCma4IzZ6C5445VXSUwht33m3knx8kux3k8NaEuhAMFlhBYe8v0zQztjRcD3lVW9z68zC2O
	B6vt/vy8ZqjUq9HXsu9BneavdOD+NcHe58dQ6s7lntuobX3qcCA4rLDoV0L1Lxqp5SwL7GVu83KuV
	uWdBHd6piLdivsnL5V7NPsMU1oAiy8NuxIYBusLO4aBRDGMr+pgS5SLPfDiTKVovaFnBWQ9l5RDJU
	XCHZ7aYwcv3q9mdT1dqTCglcUOHrCZtJ0AYQkfGR/mERxzGKp5dqRXLT5Eu/Vaim6uqpM1nSL7bDM
	aAj3qZcIflnjbRcrIscg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od0WA-007tvM-GI; Tue, 27 Sep 2022 02:40:18 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od0Vy-007tUm-EK
	for kexec@lists.infradead.org; Tue, 27 Sep 2022 02:40:08 +0000
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so14280156pjq.3
        for <kexec@lists.infradead.org>; Mon, 26 Sep 2022 19:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date;
        bh=V8M4eGg3gaCQZE6o72RB5TOdPiGCPoyqG6tJ9FqxFAs=;
        b=MRYnGiyGQzAlQYCTGUTcEAcktEcLJHH7qTRBTxWQAbCpG3ywr6mwuBCNXi9xbv61Qp
         T5efRWUQRkpxvfkxyDtfKKxy2R41uCAHqVvSK3vNqoRUwVqVUywP3p0k61kxKKM2DznB
         fi3D5K9hrECwmWmAPj232bfprA2GiCcfznZ9dnioj0HGAi/5gbEJRd5EPaFolfVw4krz
         GpGKeczFd65BMaKa33nKHpfzkBsaoL0QnLjxOge4vLRzLbBo5XSzEcajxxgMLexMZ4ad
         qt0jW7DRonlwaOsj1cMyFyMNCWybcVliKgdJNUQLp90VyFThq1qVRPqwAPF5/xPtySgO
         qi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V8M4eGg3gaCQZE6o72RB5TOdPiGCPoyqG6tJ9FqxFAs=;
        b=RzcULeLv9HgSvmD5+Jy4vJ99EMc8DFyUJssk+ZNMdQCjdo2GMTuUVfDJ9xte/zSeZA
         KEKB2FgNy0PIGBJ+MdQak8bekDJMfFn6zPxupDuBOttFT9g5xvQ4/mCdNm/UJ2Qvff93
         m6OsItRCx/rFUJyzOmUUZEEbORxYni4320fRzkdE7Go9FLpey+yGyn76VjKKmzxGYppC
         ceI0ayT+oT7x1wU4GJINV42b9PkByBA3Cux0QUFbWnSmmvDmXyiYMR2gHc80xE+kL7xb
         cynAWsAh9qhWivODpZUG+TTxrw3ZeL2TmK0mOwuv9AcOAOrLH9B1x0xYAvGvDIEzJyFV
         b/2w==
X-Gm-Message-State: ACrzQf0/EJ0tzjwCsF3faUZkK7sQjOy9H4herKKef1KafPlGyRuwP6sr
	+P50Re/pOs0q/J4LzVWZg+d+zw==
X-Google-Smtp-Source: AMsMyM6sitMgi6yITxtgKf/FIi6qTHBWgbXvjfJeLHcB7uXBXtwNqJ3kNZYPd9pZHeK4TfymUUh2rA==
X-Received: by 2002:a17:902:f688:b0:179:e82e:2dec with SMTP id l8-20020a170902f68800b00179e82e2decmr1943916plg.25.1664246403786;
        Mon, 26 Sep 2022 19:40:03 -0700 (PDT)
Received: from laputa ([2400:4050:c3e1:100:835a:afba:269b:b6fb])
        by smtp.gmail.com with ESMTPSA id w11-20020aa79a0b000000b0052d4b0d0c74sm245374pfj.70.2022.09.26.19.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:40:02 -0700 (PDT)
Date: Tue, 27 Sep 2022 11:39:52 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Michal Such??nek <msuchanek@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>, Sasha Levin <sashal@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	"open list:S390" <linux-s390@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	Coiby Xu <coxu@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH 5.15 0/6] arm64: kexec_file: use more system keyrings to
 verify kernel image signature + dependencies
Message-ID: <20220927023952.GB34139@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Such??nek <msuchanek@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>, Sasha Levin <sashal@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	"open list:S390" <linux-s390@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	Coiby Xu <coxu@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Morse <james.morse@arm.com>
References: <cover.1663951201.git.msuchanek@suse.de>
 <Yy7Ll1QJ+u+nkic9@kroah.com>
 <20220924094521.GY28810@kitsune.suse.cz>
 <Yy7YTnJKkv1UtvWF@kroah.com>
 <20220924115523.GZ28810@kitsune.suse.cz>
 <YzFLBJukjDy7uNVl@kroah.com>
 <20220926074024.GD28810@kitsune.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220926074024.GD28810@kitsune.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_194006_539679_F368A2C9 
X-CRM114-Status: GOOD (  38.15  )
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

T24gTW9uLCBTZXAgMjYsIDIwMjIgYXQgMDk6NDA6MjVBTSArMDIwMCwgTWljaGFsIFN1Y2g/P25l
ayB3cm90ZToKPiBPbiBNb24sIFNlcCAyNiwgMjAyMiBhdCAwODo0NzozMkFNICswMjAwLCBHcmVn
IEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4gPiBPbiBTYXQsIFNlcCAyNCwgMjAyMiBhdCAwMTo1NToy
M1BNICswMjAwLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3RlOgo+ID4gPiBPbiBTYXQsIFNlcCAyNCwg
MjAyMiBhdCAxMjoxMzozNFBNICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4gPiA+
ID4gT24gU2F0LCBTZXAgMjQsIDIwMjIgYXQgMTE6NDU6MjFBTSArMDIwMCwgTWljaGFsIFN1Y2jD
oW5layB3cm90ZToKPiA+ID4gPiA+IE9uIFNhdCwgU2VwIDI0LCAyMDIyIGF0IDExOjE5OjE5QU0g
KzAyMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToKPiA+ID4gPiA+ID4gT24gRnJpLCBTZXAg
MjMsIDIwMjIgYXQgMDc6MTA6MjhQTSArMDIwMCwgTWljaGFsIFN1Y2hhbmVrIHdyb3RlOgo+ID4g
PiA+ID4gPiA+IEhlbGxvLAo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IHRoaXMgaXMgYmFj
a3BvcnQgb2YgY29tbWl0IDBkNTE5Y2FkZjc1MQo+ID4gPiA+ID4gPiA+ICgiYXJtNjQ6IGtleGVj
X2ZpbGU6IHVzZSBtb3JlIHN5c3RlbSBrZXlyaW5ncyB0byB2ZXJpZnkga2VybmVsIGltYWdlIHNp
Z25hdHVyZSIpCj4gPiA+ID4gPiA+ID4gdG8gdGFibGUgNS4xNSB0cmVlIGluY2x1ZGluZyB0aGUg
cHJlcGFyYXRvcnkgcGF0Y2hlcy4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoaXMgZmVlbHMg
dG8gbWUgbGlrZSBhIG5ldyBmZWF0dXJlIGZvciBhcm02NCwgb25lIHRoYXQgaGFzIG5ldmVyIHdv
cmtlZAo+ID4gPiA+ID4gPiBiZWZvcmUgYW5kIHlvdSBhcmUganVzdCBtYWtpbmcgaXQgZmVhdHVy
ZS1wYXJpdHkgd2l0aCB4ODYsIHJpZ2h0Pwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gT3IgaXMg
dGhpcyBhIHJlZ3Jlc3Npb24gZml4IHNvbWV3aGVyZT8gIFdoeSBpcyB0aGlzIG5lZWRlZCBpbiA1
LjE1LnkgYW5kCj4gPiA+ID4gPiA+IHdoeSBjYW4ndCBwZW9wbGUgd2hvIG5lZWQgdGhpcyBuZXcg
ZmVhdHVyZSBqdXN0IHVzZSBhIG5ld2VyIGtlcm5lbAo+ID4gPiA+ID4gPiB2ZXJzaW9uICg1LjE5
PykKPiA+ID4gPiA+IAo+ID4gPiA+ID4gSXQncyBoYWxmLWJyb2tlbiBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGUga2V4ZWMga2VybmVsIHZlcmlmaWNhdGlvbi4gQXQgdGhlIHRpbWUKPiA+ID4gPiA+IGl0
IHdhcyBpbXBsZW1lbnRlZCBmb3IgYXJtNjQgd2UgaGFkIHRoZSBwbGF0Zm9ybSBhbmQgc2Vjb25k
YXJ5IGtleXJpbmdzCj4gPiA+ID4gPiBhbmQgeDg2IHdhcyB1c2luZyB0aGVtIGJ1dCBvbiBhcm02
NCB0aGUgaW5pdGlhbCBpbXBsZW1lbnRhdGlvbiBpZ25vcmVzCj4gPiA+ID4gPiB0aGVtLgo+ID4g
PiA+IAo+ID4gPiA+IE9rLCBzbyBpdCdzIHNvbWV0aGluZyB0aGF0IG5ldmVyIHdvcmtlZC4gIEFk
ZGluZyBzdXBwb3J0IHRvIGdldCBpdCB0bwo+ID4gPiA+IHdvcmsgZG9lc24ndCByZWFsbHkgZmFs
bCBpbnRvIHRoZSBzdGFibGUga2VybmVsIHJ1bGVzLCByaWdodD8KPiA+ID4gCj4gPiA+IE5vdCBz
dXJlLiBJdCB3YXMgZGVmZWN0aXZlLCBub3QgdXNpbmcgdGhlIGZhY2lsaXRpZXMgYXZhaWxhYmxl
IGF0IHRoZQo+ID4gPiB0aW1lIGNvcnJlY3RseS4gV2hpY2ggdHJhbnNsYXRlcyB0byBrZXJuZWxz
IHRoYXQgY2FuIGJlIGtleGVjJ2Qgb24geDg2Cj4gPiA+IGZhaWxpbmcgdG8ga2V4ZWMgb24gYXJt
NjQgd2l0aG91dCBhbnkgZXhwbGFuYXRpb24gKHNpZ25lZCB3aXRoIHNhbWUga2V5LAo+ID4gPiBi
dWlsdCBmb3IgdGhlIGFwcHJvcHJpYXRlIGFyY2gpLgo+ID4gCj4gPiBGZWF0dXJlIHBhcml0eSBh
Y3Jvc3MgYXJjaGl0ZWN0dXJlcyBpcyBub3QgYSAicmVncmVzc2lvbiIsIGJ1dCByYXRoZXIgYQo+
ID4gInRoaXMgZmVhdHVyZSBpcyBub3QgaW1wbGVtZW50ZWQgZm9yIHRoaXMgYXJjaGl0ZWN0dXJl
IHlldCIgdHlwZSBvZgo+ID4gdGhpbmcuCj4gCj4gVGhhdCBkZXBlbmRzIG9uIHRoZSB2aWV3IC0g
YmVmb3JlIGtleGVjIHZlcmlmaWNhdGlvbiB5b3UgY291bGQgYm9vdCBhbnkKPiBrZXJuZWwsIG5v
dyB5b3UgY2FuIGJvb3Qgc29tZSBrZXJuZWxzIHNpZ25lZCB3aXRoIGEgdmFsaWQga2V5LCBidXQg
bm90Cj4gb3RoZXJzIC0gdGhlIGluaXRpYWwgaW1wbGVtZW50YXRpb24gaXMgYnVnZ3ksIHByb2Jh
Ymx5IGJlY2F1c2UgaXQKPiBpcyBiYXNlZCBvbiBhbiBvbGQgdmVyc2lvbiBvZiB0aGUgeDg2IGNv
ZGUuCgpCdWdneT8KVGhlIGZlYXR1cmUgb2Ygc3VwcG9ydGluZyBwbGF0Zm9ybSByaW5nIGhhZCBi
ZWVuIHNsaXBwZWQgaW4ganVzdCBiZWZvcmUKSSBzdWJtaXR0ZWQgdGhlIGxhdGVzdCBwYXRjaCBz
ZXJpZXMgd2hpY2ggd2FzIGV2ZW50dWFsbHkgbWVyZ2VkLgooSSBzaG91bGQgaGF2ZSBub3RpY2Vk
IGl0IHRob3VnaC4pCgpMb29raW5nIGF0IGNoYW5nZXMgaW4gdGhlIGNvbW1pdCAyNzgzMTFlNDE3
YmUgKCJrZXhlYywgS0VZUzogTWFrZSB1c2Ugb2YgcGxhdGZvcm0Ka2V5cmluZyBmb3Igc2lnbmF0
dXJlIHZlcmlmeSIpLCBpdCBzZWVtcyB0byBiZSBvYnZpb3VzIHRoYXQgaXQgaXMgYSBuZXcgZmVh
dHVyZQpiZWNhdXNlIGl0IGludHJvZHVjZWQgYSBuZXcgS2NvbmZpZyBvcHRpb24sIENPTkZJR19J
TlRFR1JJVFlfUExBVEZPUk1fS0VZUklORywKd2hpY2ggYWxsb3dzIGZvciBlbmFibGluZy9kaXNh
YmxpbmcgcGxhdGZvcm0gcmluZyBzdXBwb3J0LgoKLVRha2FoaXJvIEFrYXNoaQoKPiA+IAo+ID4g
PiA+IEFnYWluLCB3aGF0J3Mgd3Jvbmcgd2l0aCA1LjE5IGZvciBhbnlvbmUgd2hvIHdhbnRzIHRo
aXM/ICBXaG8gZG9lcyB3YW50Cj4gPiA+ID4gdGhpcz8KPiA+ID4gCj4gPiA+IE5vdCBzdXJlLCBy
ZWFsbHkuCj4gPiA+IAo+ID4gPiBUaGUgZmluYWwgcGF0Y2ggd2FzIHJlcGVhdGVkbHkgYmFja3Bv
cnRlZCB0byBzdGFibGUgYW5kIGZhaWxlZCB0byBidWlsZAo+ID4gPiBiZWNhdXNlIHRoZSBwcmVy
ZXF1aXNpdGVzIHdlcmUgbWlzc2luZy4KPiA+IAo+ID4gVGhhdCdzIGJlY2F1c2UgaXQgd2FzIHRh
Z2dlZCwgYnV0IG5vdyB0aGF0IHlvdSBzaG93IHRoZSBmdWxsIHNldCBvZgo+ID4gcmVxdWlyZW1l
bnRzLCBpdCdzIHByZXR0eSBvYnZpb3VzIHRvIG1lIHRoYXQgdGhpcyBpcyBub3QgcmVsZXZhbnQg
Zm9yCj4gPiBnb2luZyB0aGlzIGZhciBiYWNrLgo+IAo+IFRoYXQgYWxzbyB3b3Jrcy4KPiAKPiBU
aGFua3MKPiAKPiBNaWNoYWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

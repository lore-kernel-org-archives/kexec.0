Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgmEi-0004eo-Ct
 for kexec@lists.infradead.org; Mon, 27 May 2013 01:28:33 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7286A3EE0C5
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:28:07 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6044045DE53
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:28:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 44A0D45DD78
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:28:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 258D31DB8040
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:28:07 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A6F651DB803E
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:28:06 +0900 (JST)
Message-ID: <51A2B693.7000701@jp.fujitsu.com>
Date: Mon, 27 May 2013 10:27:47 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] Documentation/devices.txt: Remove /dev/oldmem
 description
References: <51A02E50.5020507@gmail.com> <51A02F59.8000103@gmail.com>
 <87vc668x4w.fsf@xmission.com> <51A15E2F.7010308@gmail.com>
In-Reply-To: <51A15E2F.7010308@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, davej@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

KDIwMTMvMDUvMjYgOTo1OCksIFpoYW5nIFlhbmZlaSB3cm90ZToKPiDkuo4gMjAxM+W5tDA15pyI
Mjbml6UgMDc6MjAsIEVyaWMgVy4gQmllZGVybWFuIOWGmemBkzoKPj4gWmhhbmcgWWFuZmVpIDx6
aGFuZ3lhbmZlaS55ZXNAZ21haWwuY29tPiB3cml0ZXM6Cj4+Cj4+PiBGcm9tOiBaaGFuZyBZYW5m
ZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3UuY29tPgo+Pgo+PiBXb24ndCB3ZSB3YW50IHRvIGtl
ZXAgdGhpcyByZXNlcnZhdGlvbiBhcm91bmQgdG8gc28gdGhhdCB0aGlzIG51bWJlcgo+PiBkb2Vz
bid0IGdldCByZXVzZWQsIGFuZCBjYXVzZSBwZW9wbGUgY29uZnVzaW9uIHdoZW4KPj4gdXBncmFk
aW5nL2Rvd25ncmFkaW5nIGtlcm5lbHM/Cj4KPiBBaCwgeWVzLiBJIHdpbGwganVzdCBrZWVwIHRo
aXMgYW5kIGFkZCBhIG5vdGUgdG8gbWFrZSBwZW9wbGUga25vdyB0aGF0Cj4gaXQgaXMgcmVtb3Zl
ZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+CgpJdCBsb29rcyBlbm91Z2ggd3JpdGluZyAib2Jzb2xl
dGUiIGFjY29yZGluZyB0byB0aGUgb3RoZXIgcGFydHMgb2YgdGhlIHNhbWUgZmlsZS4KCi0tIApU
aGFua3MuCkhBVEFZQU1BLCBEYWlzdWtlCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

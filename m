Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XGtlf-0003zS-Rb
 for kexec@lists.infradead.org; Mon, 11 Aug 2014 17:52:24 +0000
Message-ID: <53E9028E.2070709@zytor.com>
Date: Mon, 11 Aug 2014 10:51:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 11/15] purgatory: Core purgatory functionality
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <1403814824-7587-12-git-send-email-vgoyal@redhat.com>
 <20140811174017.GD12610@digium.com>
In-Reply-To: <20140811174017.GD12610@digium.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Shaun Ruffell <sruffell@digium.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

T24gMDgvMTEvMjAxNCAxMDo0MCBBTSwgU2hhdW4gUnVmZmVsbCB3cm90ZToKPiBGWUksIGl0IGxv
b2tzIGxpa2UgdGhlIGZvbGxvd2luZyBwYXRjaCAoY29tbWl0dGVkIGluCj4gOGZjNWI0ZDQxMjFj
OTU0ODJiMjU4MykgYWRkcyBhIG5ldyByZXF1aXJlbWVudCB0byB1c2UgYXQgbGVhc3QgZ2NjCj4g
NC40IHRvIGJ1aWxkIHRoZSBrZXJuZWw/CgpXZWxsLCB0byBidWlsZCB0aGUga2VybmVsIHdpdGgg
dGhhdCBwYXJ0aWN1bGFyIG5ldyBmdW5jdGlvbmFsaXR5CmVuYWJsZWQsIHllcy4KCkhvd2V2ZXIu
Li4KCj4gVGhlIGFib3ZlICItbWNtb2RlbD1sYXJnZSIgY29tcGlsZXIgZmxhZyBwcm9kdWNlcyB0
aGUgZm9sbG93aW5nIG91dHB1dCBvbiBHQ0MgNC4xLjIuCj4gCj4gICAkIG1ha2UgbW9kdWxlc19w
cmVwYXJlIDsgZ2NjIC0tdmVyc2lvbgo+ICAgICBDSEsgICAgIGluY2x1ZGUvY29uZmlnL2tlcm5l
bC5yZWxlYXNlCj4gICAgIENISyAgICAgaW5jbHVkZS9nZW5lcmF0ZWQvdWFwaS9saW51eC92ZXJz
aW9uLmgKPiAgICAgQ0hLICAgICBpbmNsdWRlL2dlbmVyYXRlZC91dHNyZWxlYXNlLmgKPiAgICAg
Q0MgICAgICBhcmNoL3g4Ni9wdXJnYXRvcnkvcHVyZ2F0b3J5Lm8KPiAgIGFyY2gveDg2L3B1cmdh
dG9yeS9wdXJnYXRvcnkuYzoxOiBzb3JyeSwgdW5pbXBsZW1lbnRlZDogY29kZSBtb2RlbCDigJhs
YXJnZeKAmSBub3Qgc3VwcG9ydGVkIHlldAo+ICAgbWFrZVsxXTogKioqIFthcmNoL3g4Ni9wdXJn
YXRvcnkvcHVyZ2F0b3J5Lm9dIEVycm9yIDEKPiAgIG1ha2U6ICoqKiBbYXJjaHByZXBhcmVdIEVy
cm9yIDIKPiAgIGdjYyAoR0NDKSA0LjEuMiAyMDA4MDcwNCAoUmVkIEhhdCA0LjEuMi01NCkKPiAg
IENvcHlyaWdodCAoQykgMjAwNiBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4KPiAgIFRo
aXMgaXMgZnJlZSBzb2Z0d2FyZTsgc2VlIHRoZSBzb3VyY2UgZm9yIGNvcHlpbmcgY29uZGl0aW9u
cy4gIFRoZXJlIGlzIE5PCj4gICB3YXJyYW50eTsgbm90IGV2ZW4gZm9yIE1FUkNIQU5UQUJJTElU
WSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4KPiAKPiBJIGRpZCBhIHF1aWNr
IHNlYXJjaCBmb3IgYSBkaXNjdXNzaW9uIHRoZSBpbmRpY2F0ZXMgdGhpcyBjb21waWxlciBpcyBu
b3cKPiBvZmZpY2lhbGx5IHRvbyBvbGQgdG8gYnVpbGQgdGhlIGtlcm5lbCBidXQgZGlkIG5vdCBm
aW5kIG9uZS4KPiAKPiBJZiB0aGlzIGlzIHJlcXVpcmVkLCBtYXliZSBEb2N1bWVudGF0aW9uL0No
YW5nZXMgbmVlZHMgdG8gYmUgdXBkYXRlZAo+IHdpdGggdGhlIG5ldyBtaW5pbXVtIHJlcXVpcmVk
IHZlcnNpb24/CgouLi4gSSdtIGhhdmluZyBhIHZlcnksIHZlcnkgaGFyZCB0aW1lIHRvIHBpY3R1
cmUgYSByZWFzb24gd2h5IHRoZQoibGFyZ2UiIG1vZGVsIHdvdWxkIGJlIG5lY2Vzc2FyeSBvciBl
dmVuIGRlc2lyYWJsZSBmb3IgdGhlIHB1cmdhdG9yeQpjb2RlLiAgVGhlICJzbWFsbCBQSUMiIG1v
ZGVsIHNlZW0gdG8gZml0IG11Y2ggYmV0dGVyLi4uCgoJLWhwYQoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==

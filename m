Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nov-007-i608.relay.mailchannels.net ([46.232.183.162])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ar5yV-0003SN-TA
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 15:48:06 +0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_2b9cefc83d79817679dc99118198cc99"
Date: Fri, 15 Apr 2016 11:46:47 -0400
From: Emrah Demir <ed@abdsec.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
In-Reply-To: <CAGXu5jLRnabqSBjdPoaAs-h2VCd_Hn3=hj3JSWTsJvi-cPEjtg@mail.gmail.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
 <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
 <f80ca230bf1fab7527d355e535de305f@abdsec.com>
 <CA+55aFxtuUBBJS4xxM5OiyZs04xjrpHPif+cO4U_s4OppeN-gg@mail.gmail.com>
 <CAGXu5jLRnabqSBjdPoaAs-h2VCd_Hn3=hj3JSWTsJvi-cPEjtg@mail.gmail.com>
Message-ID: <0cc6c4836fae00b175b4595446e1ed4f@abdsec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: Baoquan He <bhe@redhat.com>, Freeman Zhang <freeman.zhang1992@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Zhengyu Zhang <zhezhang@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, keescook@google.com, Dave Young <dyoung@redhat.com>

--=_2b9cefc83d79817679dc99118198cc99
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

On 2016-04-15 00:41, Kees Cook wrote:
> On Thu, Apr 14, 2016 at 6:02 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Apr 14, 2016 at 1:27 PM, Emrah Demir <ed@abdsec.com> wrote:
>>> On 2016-04-14 13:40, Linus Torvalds wrote:

>> I've pushed out my attempt at fixing things properly. Please check
>> that kexec works - and if kexec ends up reading that file as non-root,
>> I don't know what to say/do.
>> 
>> Here's the three relevant cases:
>> 
>>    cat /proc/iomem
>>    sudo cat /proc/iomem
>>    sudo cat < /proc/iomem
>> 
>> and two of them will now show the resource ranges as just plain
>> zeroes. But yes, it needed extra infrastructure to be able to get this
>> right.
>> 

> 
> Yup, that's why I was saying I was going to try to cook something up
> for -next. It isn't a trivial change. :) Thanks for fixing it up!
> 

file_ns_capable bring some problems. I used capable and now there is no 
problem as far as I tested.

It'is attached.

Note: I couldn't write "Noted-by:, Reported-by:" Could you write them

--=_2b9cefc83d79817679dc99118198cc99
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=0001-proc-iomem-only-expose-physical-resource-addresses-t.patch
Content-Disposition: attachment;
 filename=0001-proc-iomem-only-expose-physical-resource-addresses-t.patch;
 size=1918

RnJvbSAzZjE3YmY4YjFlOWUxMjljZGFmNDc4YTllODNhNjQ4YjI3ZjZmZTczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbXJhaCBEZW1pciA8ZWRAYWJkc2VjLmNvbT4KRGF0ZTogRnJp
LCAxNSBBcHIgMjAxNiAxODozNDoxMiArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIC9wcm9jL2lvbWVt
OiBvbmx5IGV4cG9zZSBwaHlzaWNhbCByZXNvdXJjZSBhZGRyZXNzZXMgdG8gdG9wCiB1c2VyIGZp
eGluZyBjYXBhYmlsaXR5Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFp
bjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpJbiBjb21t
aXQgNTFkN2IxMjA0MThlOTlkNmIzYmY4ZGY5ZWIzY2MzMWU4MTcxZGVlNAoKZmlsZV9uc19jYXBh
YmxlIHVzZWQgaW4gb3JkZXIgdG8gc2hvdyB2YWx1ZSBhcyAwLCBidXQgd2hpbGUgYnVpbGRpbmcK
c29tZSBwcm9ibGVtcyBjb21pbmcgdXAuCgprZXJuZWwvcmVzb3VyY2UuYzogSW4gZnVuY3Rpb24g
4oCYcl9zaG934oCZOgprZXJuZWwvcmVzb3VyY2UuYzoxMTY6MjM6IGVycm9yOiDigJhzdHJ1Y3Qg
c2VxX2ZpbGXigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhmaWxl4oCZCiAgaWYgKGZpbGVfbnNf
Y2FwYWJsZShtLT5maWxlLCAmaW5pdF91c2VyX25zLCBDQVBfU1lTX0FETUlOKSkgewogICAgICAg
ICAgICAgICAgICAgICAgIF4Kc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyOTE6IHJlY2lwZSBmb3Ig
dGFyZ2V0ICdrZXJuZWwvcmVzb3VyY2UubycgZmFpbGVkCm1ha2VbMV06ICoqKiBba2VybmVsL3Jl
c291cmNlLm9dIEVycm9yIDEKCnNvIGluc3RlYWQgb2YgZmlsZV9uc19jYXBhYmxlIHVzaW5nIGNh
cGFibGUgc29sdmVzIHByb2JsZW0uCgpJdCdzIG5vdyB3b3JraW5nLgoKbHRyQHJlY2VzLTA6fiQg
Y2F0IC9wcm9jL2lvbWVtCjAwMDAwMDAwLTAwMDAwMDAwIDogcmVzZXJ2ZWQKMDAwMDAwMDAtMDAw
MDAwMDAgOiBTeXN0ZW0gUkFNCjAwMDAwMDAwLTAwMDAwMDAwIDogcmVzZXJ2ZWQKMDAwMDAwMDAt
MDAwMDAwMDAgOiBQQ0kgQnVzIDAwMDA6MDAKMDAwMDAwMDAtMDAwMDAwMDAgOiBWaWRlbyBST00K
MDAwMDAwMDAtMDAwMDAwMDAgOiBBZGFwdGVyIFJPTQowMDAwMDAwMC0wMDAwMDAwMCA6IHJlc2Vy
dmVkCgpyb290QHJlY2VzLTA6L2hvbWUvbHRyIyBjYXQgL3Byb2MvaW9tZW0KMDAwMDAwMDAtMDAw
MDBmZmYgOiByZXNlcnZlZAowMDAwMTAwMC0wMDA5ZGJmZiA6IFN5c3RlbSBSQU0KMDAwOWRjMDAt
MDAwOWZmZmYgOiByZXNlcnZlZAowMDBhMDAwMC0wMDBiZmZmZiA6IFBDSSBCdXMgMDAwMDowMAow
MDBjMDAwMC0wMDBjZWRmZiA6IFZpZGVvIFJPTQowMDBjZjAwMC0wMDBjZmZmZiA6IEFkYXB0ZXIg
Uk9NCjAwMGUwMDAwLTAwMGZmZmZmIDogcmVzZXJ2ZWQKClNpZ25lZC1vZmYtYnk6IEVtcmFoIERl
bWlyIDxlZEBhYmRzZWMuY29tPgotLS0KIGtlcm5lbC9yZXNvdXJjZS5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEva2Vy
bmVsL3Jlc291cmNlLmMgYi9rZXJuZWwvcmVzb3VyY2UuYwppbmRleCBjNzcyN2RiLi41MmEyN2Uz
IDEwMDY0NAotLS0gYS9rZXJuZWwvcmVzb3VyY2UuYworKysgYi9rZXJuZWwvcmVzb3VyY2UuYwpA
QCAtMTEzLDcgKzExMyw3IEBAIHN0YXRpYyBpbnQgcl9zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwg
dm9pZCAqdikKIAkJaWYgKHAtPnBhcmVudCA9PSByb290KQogCQkJYnJlYWs7CiAKLQlpZiAoZmls
ZV9uc19jYXBhYmxlKG0tPmZpbGUsICZpbml0X3VzZXJfbnMsIENBUF9TWVNfQURNSU4pKSB7CisJ
aWYgKGNhcGFibGUoQ0FQX1NZU19BRE1JTikpIHsKIAkJc3RhcnQgPSByLT5zdGFydDsKIAkJZW5k
ID0gci0+ZW5kOwogCX0gZWxzZSB7Ci0tIAoyLjguMC5yYzMKCg==
--=_2b9cefc83d79817679dc99118198cc99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--=_2b9cefc83d79817679dc99118198cc99--



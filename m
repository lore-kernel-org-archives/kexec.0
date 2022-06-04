Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D55C43334
	for <kexec@archiver.kernel.org>; Mon,  6 Jun 2022 07:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Content-Type:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=970RM11Dw1EVjuVr1g2FFHBag5U6PZSrn1AWvyWHQXY=; b=oO+RPGitfsWtUkNL+vJ/C74msN
	tPhbeeinVDY2qJqwtmELJpiZihfSQGnRUJwEgJr5lBOk8NzNM7tF6R5Pow643w7d7EDEexDNYimDi
	GoJ7DKHWltKvt4lWR2IMQvNxm06692iT2By28Cx6Uf6LtCxqt7c2p+sQpIXs8jZDhZeafPUj1oOJ9
	1gEHaycsF4sqAXVp7HlCXM0sRILhCy8iHRkluqvXvRf7VStHgirPs2Z2UyPqvjd8tTYTmUMhcoRBn
	b0o5nkfsfVjwPnUa4V1ac7Z+Dj2dPzpADzs/ry4F3au5d8x9PCrYbk0NdRXWvKAiBSxOW1iBGKzJ8
	myfyE1fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny6ns-00HTRK-DX; Mon, 06 Jun 2022 07:05:32 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nxN4z-00AVLQ-2d
	for kexec@lists.infradead.org; Sat, 04 Jun 2022 06:16:11 +0000
Received: from [192.168.87.250] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 483C020BE598;
	Fri,  3 Jun 2022 23:16:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 483C020BE598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1654323365;
	bh=8p/RaOaAJGdOzKVI7fXplTCJuJQLaZ9u8GmEGtg/Jls=;
	h=Date:To:Cc:From:Subject:From;
	b=a19QJREUxtKumeQfQZB7llbqkOpEGOtwQ1/fpOik4RkycPfw1+1tKREuLmHn1o1i+
	 RhZfnVqAQigsC0m8+BLgpv0iL8H2T2O4i+AUlIRJwPBt9sogwanMWbGqG/xe+yILP0
	 KT9bD0ZiMedM+nkW0Ehk6fsTODJz2Iagpx5YON/U=
Content-Type: multipart/mixed; boundary="------------L7ZriuapA8Hy7AZCrGrS2eMk"
Message-ID: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
Date: Fri, 3 Jun 2022 23:16:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, Jonathan McDowell <noodles@fb.com>,
 kexec@lists.infradead.org, Alasdair G Kergon <agk@redhat.com>
Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Tyler Hicks <tyhicks@linux.microsoft.com>,
 Tushar Sugandhi <tusharsu@linux.microsoft.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: need help: patches to capture events between kexec load and execute
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220603_231609_287646_CEB5F9D6 
X-CRM114-Status: GOOD (  33.59  )
X-Mailman-Approved-At: Mon, 06 Jun 2022 00:05:31 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------L7ZriuapA8Hy7AZCrGrS2eMk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
We believe we have found one gap in the IMA/kexec interaction.
And we need your inputs as Linux Kernel maintainers/experts to fix that
gap.

-------------
Problem:
-------------
The current Kernel behavior is IMA measurements are snapshotted at
'kexec load' and not at 'kexec execute'.  And IMA log is then carried
over to the new Kernel after 'kexec execute'.

Some systems can be configured to call 'kexec load' first, and followed
by 'kexec execute' after some time.  (as opposed to calling 'load' and
'execute' in one single kexec command).  In this scenario, if new IMA
measurements are added between 'kexec load' and 'kexec execute' - the
TPM PCRs are extended with the IMA events between load and execute, but
those IMA events are not carried over to the new kernel after kexec soft
reboot.  This results in mismatch between TPM PCR quotes and the actual
IMA measurements log post kexec.

===========================================================================
-------------
Scenario
-------------
Here is the order of operations I followed to confirm the issue.

(a) Call 'kexec load'

     #kexec -s -l /etc/ima/Image.kexec --reuse-cmdline


(b) Touch one of the files that would be measured by IMA

     #cat /run/systemd/journal/streams/8:16351


(c) Verify that this measurement event is part of the IMA log.

     #cat /sys/kernel/security/ima/ascii_runtime_measurements | grep 16351

     <returns the file entry in IMA log>

(d) Call 'kexec execute'

     #kexec -s -e


(e) After kexec soft reboot, the file measurement event is not present
     in the IMA log anymore.  Because this measurement in the previous
     kernel had happened after the IMA log was snapshotted in the
     previous kernel.

     #cat /sys/kernel/security/ima/ascii_runtime_measurements | grep 16351

     <does not return the file entry in IMA log>

===========================================================================
-------------
Solution
-------------
Tyler pointed me to the past work in this area.
(Please see references section below)

I used it to create the patches for capturing IMA events in between
"kexec load" and "kexec execute". (please find attached)

- 0001-kexec_file-Add-mechanism-to-update-kexec-segments.patch
- 0002-ima-update-kexec-buffer-before-executing-soft-reboot.patch
- 0003-ima-on-soft-reboot-save-the-measurement-list.patch

My patches are based on [1] and [2] in the References section below.
I also looked at [3].  It has a few kexec_*_handover_buffer().
I was not sure if they were needed.  As per my limited understanding in
kexec space [1] and [2] together seemed sufficient for the solution.
===========================================================================
------------------------------------------
Problems in the solution above
------------------------------------------
Earlier my solution patches were crashing the Kernel. After a few fixes,
the patches are not crashing the Kernel anymore, but they don't seem to 
be working to capture the events between 'kexec load' and 'kexec 
execute' either.

When I was debugging it using printks and gdb, I found one potential
location where it was failing.

test_0001-move-ima_add_kexec_buffer-from-kexec-load-to-execute.patch
has that location.


I would really appreciate if someone of you could help me provide
further guidance to make progress on this work.

==================================================================
----------------
References
----------------

[1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/

[2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
https://lkml.org/lkml/2016/8/16/577

[3] [PATCH 1/6] kexec_file: Add buffer hand-over support
https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/

~Tushar
--------------L7ZriuapA8Hy7AZCrGrS2eMk
Content-Type: text/x-patch; charset=UTF-8;
 name="test_0001-move-ima_add_kexec_buffer-from-kexec-load-to-execute.patch"
Content-Disposition: attachment;
 filename*0="test_0001-move-ima_add_kexec_buffer-from-kexec-load-to-execu";
 filename*1="te.patch"
Content-Transfer-Encoding: base64

RnJvbSA4N2ZkN2I3ZWY3YjM5MzZjZDQ1NDk5OWEyNmY1NDZkMmQxYzJmNWMwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVHVzaGFyIFN1Z2FuZGhpIDx0dXNoYXJzdUBsaW51
eC5taWNyb3NvZnQuY29tPg0KRGF0ZTogTW9uLCAzIEphbiAyMDIyIDEzOjU5OjAxIC0wODAw
DQpTdWJqZWN0OiBbUEFUQ0ggMS8xXSBtb3ZlIGltYV9hZGRfa2V4ZWNfYnVmZmVyKCkgZnJv
bSBrZXhlYyBsb2FkIHRvIGV4ZWN1dGUNCg0KRXhwZXJpbWVudCBtb3ZpbmcgaW1hX2FkZF9r
ZXhlY19idWZmZXIoKSBmcm9tIGtleGVjIGxvYWQgdG8gZXhlY3V0ZS4NClRoaXMgbG9naWMg
ZmFpbHMgaW4ga2V4ZWNfYWRkX2J1ZmZlcigpIC0gc2luY2UgdGhlIGNvbnRyb2wgcGFnZXMg
YXJlIA0KYWxyZWFkeSBhZGRlZCBpbiBraW1hZ2VfYWxsb2Nfbm9ybWFsX2NvbnRyb2xfcGFn
ZXMoKSwgd2hpY2ggZ2V0IGNhbGxlZA0KZHVyaW5nIGtleGVjIExPQUQuIA0KIEUuZy4gI2tl
eGVjIC1zIC1sIC9ldGMvaW1hL0ltYWdlLmtleGVjIC0tcmV1c2UtY21kbGluZQ0KDQpTaWdu
ZWQtb2ZmLWJ5OiBUdXNoYXIgU3VnYW5kaGkgPHR1c2hhcnN1QGxpbnV4Lm1pY3Jvc29mdC5j
b20+DQotLS0NCiBrZXJuZWwva2V4ZWNfY29yZS5jIHwgNSArKysrKw0KIGtlcm5lbC9rZXhl
Y19maWxlLmMgfCA3ICsrKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWNfY29yZS5j
IGIva2VybmVsL2tleGVjX2NvcmUuYw0KaW5kZXggNWE1ZDE5MmE4OWFjLi43YzA0MjAzZGVk
ZWYgMTAwNjQ0DQotLS0gYS9rZXJuZWwva2V4ZWNfY29yZS5jDQorKysgYi9rZXJuZWwva2V4
ZWNfY29yZS5jDQpAQCAtMzksNiArMzksNyBAQA0KICNpbmNsdWRlIDxsaW51eC9odWdldGxi
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L29ianRvb2wuaD4NCiAjaW5jbHVkZSA8bGludXgva21z
Z19kdW1wLmg+DQorI2luY2x1ZGUgPGxpbnV4L2ltYS5oPg0KIA0KICNpbmNsdWRlIDxhc20v
cGFnZS5oPg0KICNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4NCkBAIC0xMTY2LDYgKzExNjcs
MTAgQEAgaW50IGtlcm5lbF9rZXhlYyh2b2lkKQ0KICNlbmRpZg0KIAl7DQogCQlrZXhlY19p
bl9wcm9ncmVzcyA9IHRydWU7DQorDQorCQkvKiBJTUEgbmVlZHMgdG8gcGFzcyB0aGUgbWVh
c3VyZW1lbnQgbGlzdCB0byB0aGUgbmV4dCBrZXJuZWwuICovDQorCQlpbWFfYWRkX2tleGVj
X2J1ZmZlcihrZXhlY19pbWFnZSk7DQorDQogCQlrZXJuZWxfcmVzdGFydF9wcmVwYXJlKCJr
ZXhlYyByZWJvb3QiKTsNCiAJCW1pZ3JhdGVfdG9fcmVib290X2NwdSgpOw0KIA0KZGlmZiAt
LWdpdCBhL2tlcm5lbC9rZXhlY19maWxlLmMgYi9rZXJuZWwva2V4ZWNfZmlsZS5jDQppbmRl
eCA4MzQ3ZmMxNThkMmIuLmQ2ZmMyOGJlODI1YyAxMDA2NDQNCi0tLSBhL2tlcm5lbC9rZXhl
Y19maWxlLmMNCisrKyBiL2tlcm5lbC9rZXhlY19maWxlLmMNCkBAIC0yNzUsOCArMjc1LDYg
QEAga2ltYWdlX2ZpbGVfcHJlcGFyZV9zZWdtZW50cyhzdHJ1Y3Qga2ltYWdlICppbWFnZSwg
aW50IGtlcm5lbF9mZCwgaW50IGluaXRyZF9mZCwNCiAJCQkJICBpbWFnZS0+Y21kbGluZV9i
dWZfbGVuIC0gMSk7DQogCX0NCiANCi0JLyogSU1BIG5lZWRzIHRvIHBhc3MgdGhlIG1lYXN1
cmVtZW50IGxpc3QgdG8gdGhlIG5leHQga2VybmVsLiAqLw0KLQlpbWFfYWRkX2tleGVjX2J1
ZmZlcihpbWFnZSk7DQogDQogCS8qIENhbGwgYXJjaCBpbWFnZSBsb2FkIGhhbmRsZXJzICov
DQogCWxkYXRhID0gYXJjaF9rZXhlY19rZXJuZWxfaW1hZ2VfbG9hZChpbWFnZSk7DQpAQCAt
Njg5LDYgKzY4NywxMSBAQCBpbnQga2V4ZWNfYWRkX2J1ZmZlcihzdHJ1Y3Qga2V4ZWNfYnVm
ICprYnVmKQ0KIAkgKiBubyBkZXN0aW5hdGlvbiBvdmVybGFwcy4NCiAJICovDQogCWlmICgh
bGlzdF9lbXB0eSgma2J1Zi0+aW1hZ2UtPmNvbnRyb2xfcGFnZXMpKSB7DQorCQkvKiBUdXNo
YXI6IFRoaXMgcGF0Y2ggZmFpbHMgaGVyZSwNCisJCSAqIHNpbmNlIHRoZSBjb250cm9sIHBh
Z2VzIGdldCBhZGRlZCBpbiBraW1hZ2VfYWxsb2Nfbm9ybWFsX2NvbnRyb2xfcGFnZXMoKQ0K
KwkJICogd2hpY2ggZ2V0IGNhbGxlZCBkdXJpbmcga2V4ZWMgTE9BRC4gRS5nLg0KKwkJICog
ICAgIGtleGVjIC1zIC1sIC9ldGMvaW1hL0ltYWdlLmtleGVjIC0tcmV1c2UtY21kbGluZQ0K
KwkJICovDQogCQlXQVJOX09OKDEpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCi0tIA0K
Mi4yNS4xDQoNCg==
--------------L7ZriuapA8Hy7AZCrGrS2eMk
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-ima-on-soft-reboot-save-the-measurement-list.patch"
Content-Disposition: attachment;
 filename="0003-ima-on-soft-reboot-save-the-measurement-list.patch"
Content-Transfer-Encoding: base64

RnJvbSA3NWNmZmQ3MTAzYTgwMThkZWQwMjBiNWQyYTdhOWY5NWNiZjg0MjhmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVHVzaGFyIFN1Z2FuZGhpIDx0dXNoYXJzdUBsaW51
eC5taWNyb3NvZnQuY29tPg0KRGF0ZTogTW9uLCAzIEphbiAyMDIyIDE0OjA5OjU1IC0wODAw
DQpTdWJqZWN0OiBbUEFUQ0ggMy8zXSBpbWE6IG9uIHNvZnQgcmVib290LCBzYXZlIHRoZSBt
ZWFzdXJlbWVudCBsaXN0DQoNClRoaXMgcGF0Y2ggdXNlcyB0aGUga2V4ZWMgYnVmZmVyIHBh
c3NpbmcgbWVjaGFuaXNtIHRvIHBhc3MgdGhlDQpzZXJpYWxpemVkIElNQSBiaW5hcnlfcnVu
dGltZV9tZWFzdXJlbWVudHMgdG8gdGhlIG5leHQga2VybmVsLg0KDQpDby1kZXZlbG9wZWQt
Ynk6IFRoaWFnbyBKdW5nIEJhdWVybWFubiA8YmF1ZXJtYW5AbGludXgudm5ldC5pYm0uY29t
Pg0KU2lnbmVkLW9mZi1ieTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBsaW51
eC52bmV0LmlibS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgU3VnYW5kaGkgPHR1c2hh
cnN1QGxpbnV4Lm1pY3Jvc29mdC5jb20+DQotLS0NCiBzZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L2ltYV9rZXhlYy5jIHwgMTkgKysrKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYyBiL3NlY3VyaXR5L2ludGVncml0eS9p
bWEvaW1hX2tleGVjLmMNCmluZGV4IDU3NzQ2MmU5ZjljYy4uODRkZGNmMGQyNjczIDEwMDY0
NA0KLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYw0KKysrIGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYw0KQEAgLTEyLDkgKzEyLDE0IEBADQog
I2luY2x1ZGUgPGxpbnV4L2tleGVjLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L2ltYS5oPg0KKyNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4NCiAjaW5j
bHVkZSAiaW1hLmgiDQogDQogI2lmZGVmIENPTkZJR19JTUFfS0VYRUMNCisvKiBQaHlzaWNh
bCBhZGRyZXNzIG9mIHRoZSBtZWFzdXJlbWVudCBidWZmZXIgaW4gdGhlIG5leHQga2VybmVs
LiAqLw0KK3N0YXRpYyB1bnNpZ25lZCBsb25nIGtleGVjX2J1ZmZlcl9sb2FkX2FkZHI7DQor
c3RhdGljIHNpemVfdCBrZXhlY19zZWdtZW50X3NpemU7DQorDQogc3RhdGljIGludCBpbWFf
ZHVtcF9tZWFzdXJlbWVudF9saXN0KHVuc2lnbmVkIGxvbmcgKmJ1ZmZlcl9zaXplLCB2b2lk
ICoqYnVmZmVyLA0KIAkJCQkgICAgIHVuc2lnbmVkIGxvbmcgc2VnbWVudF9zaXplKQ0KIHsN
CkBAIC0xMjcsMTkgKzEzMiwyMCBAQCB2b2lkIGltYV9hZGRfa2V4ZWNfYnVmZmVyKHN0cnVj
dCBraW1hZ2UgKmltYWdlKQ0KIAkvKiB1c2UgbW9yZSB1bmRlcnN0YW5kYWJsZSB2YXJpYWJs
ZSBuYW1lcyB0aGFuIGRlZmluZWQgaW4ga2J1ZiAqLw0KIAl2b2lkICprZXhlY19idWZmZXIg
PSBOVUxMOw0KIAlzaXplX3Qga2V4ZWNfYnVmZmVyX3NpemU7DQotCXNpemVfdCBrZXhlY19z
ZWdtZW50X3NpemU7DQogCWludCByZXQ7DQogDQorCWJvb2wgZmlyc3Rfa2V4ZWNfbG9hZCA9
IGtleGVjX2J1ZmZlcl9sb2FkX2FkZHIgPT0gMDsNCisNCiAJLyoNCi0JICogUmVzZXJ2ZSBh
biBleHRyYSBoYWxmIHBhZ2Ugb2YgbWVtb3J5IGZvciBhZGRpdGlvbmFsIG1lYXN1cmVtZW50
cw0KLQkgKiBhZGRlZCBkdXJpbmcgdGhlIGtleGVjIGxvYWQuDQorCSAqIFJlc2VydmUgYW4g
ZXh0cmEgcGFnZSBvZiBtZW1vcnkgZm9yIGFkZGl0aW9uYWwgbWVhc3VyZW1lbnRzDQorCSAq
IGFkZGVkIGR1cmluZyB0aGUga2V4ZWMgbG9hZCArIGV4ZWN1dGUuDQogCSAqLw0KIAliaW5h
cnlfcnVudGltZV9zaXplID0gaW1hX2dldF9iaW5hcnlfcnVudGltZV9zaXplKCk7DQogCWlm
IChiaW5hcnlfcnVudGltZV9zaXplID49IFVMT05HX01BWCAtIFBBR0VfU0laRSkNCiAJCWtl
eGVjX3NlZ21lbnRfc2l6ZSA9IFVMT05HX01BWDsNCiAJZWxzZQ0KIAkJa2V4ZWNfc2VnbWVu
dF9zaXplID0gQUxJR04oaW1hX2dldF9iaW5hcnlfcnVudGltZV9zaXplKCkgKw0KLQkJCQkJ
ICAgUEFHRV9TSVpFIC8gMiwgUEFHRV9TSVpFKTsNCisJCQkJCSAgIFBBR0VfU0laRSwgUEFH
RV9TSVpFKTsNCiAJaWYgKChrZXhlY19zZWdtZW50X3NpemUgPT0gVUxPTkdfTUFYKSB8fA0K
IAkgICAgKChrZXhlY19zZWdtZW50X3NpemUgPj4gUEFHRV9TSElGVCkgPiB0b3RhbHJhbV9w
YWdlcygpIC8gMikpIHsNCiAJCXByX2VycigiQmluYXJ5IG1lYXN1cmVtZW50IGxpc3QgdG9v
IGxhcmdlLlxuIik7DQpAQCAtMTY3LDYgKzE3MywxMSBAQCB2b2lkIGltYV9hZGRfa2V4ZWNf
YnVmZmVyKHN0cnVjdCBraW1hZ2UgKmltYWdlKQ0KIAlpbWFnZS0+aW1hX2J1ZmZlcl9zaXpl
ID0ga2V4ZWNfc2VnbWVudF9zaXplOw0KIAlpbWFnZS0+aW1hX2J1ZmZlciA9IGtleGVjX2J1
ZmZlcjsNCiANCisJa2V4ZWNfYnVmZmVyX2xvYWRfYWRkciA9IGtidWYubWVtOw0KKw0KKwlp
ZiAoZmlyc3Rfa2V4ZWNfbG9hZCkNCisJCXJlZ2lzdGVyX3JlYm9vdF9ub3RpZmllcigmdXBk
YXRlX2J1ZmZlcl9uYik7DQorDQogCXByX2RlYnVnKCJrZXhlYyBtZWFzdXJlbWVudCBidWZm
ZXIgZm9yIHRoZSBsb2FkZWQga2VybmVsIGF0IDB4JWx4LlxuIiwNCiAJCSBrYnVmLm1lbSk7
DQogfQ0KLS0gDQoyLjI1LjENCg0K
--------------L7ZriuapA8Hy7AZCrGrS2eMk
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-ima-update-kexec-buffer-before-executing-soft-reboot.patch"
Content-Disposition: attachment;
 filename*0="0002-ima-update-kexec-buffer-before-executing-soft-reboot.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5MjgyZWFkNjNlYjdkY2NkY2U5NDMwMjc1ODg5Mzc2ZDE5ZGVhNTlkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVHVzaGFyIFN1Z2FuZGhpIDx0dXNoYXJzdUBsaW51
eC5taWNyb3NvZnQuY29tPg0KRGF0ZTogTW9uLCAzIEphbiAyMDIyIDE0OjIxOjE4IC0wODAw
DQpTdWJqZWN0OiBbUEFUQ0ggMi8zXSBpbWE6IHVwZGF0ZSBrZXhlYyBidWZmZXIgYmVmb3Jl
IGV4ZWN1dGluZyBzb2Z0IHJlYm9vdA0KDQppbWFfdXBkYXRlX2tleGVjX2J1ZmZlciB1cGRh
dGVzIElNQSBidWZmZXIgaW4ga2V4ZWNfaW1hZ2UgdG8gaGF2ZQ0KaXRzIGNvbnRlbnRzIHVw
ZGF0ZWQuIFRoaXMgZnVuY3Rpb24gc2hvdWxkIGJlIGNhbGxlZCBkdXJpbmcga2V4ZWMgZXhl
Y3V0ZQ0Kc28gdGhhdCBJTUEgY2FuIHNhdmUgdGhlIG1lYXN1cmVtZW50IGxpc3QuIFRoaXMg
aXMgdXNlZnVsIGlmIHRoZSBjdXJyZW50DQprZXJuZWwgd2FudHMgdG8gc2VuZCBpbmZvcm1h
dGlvbiB0byB0aGUgbmV4dCBrZXJuZWwgdGhhdCBpcyB1cC10by1kYXRlDQphdCB0aGUgdGlt
ZSBvZiByZWJvb3QuDQoNCkNvLWRldmVsb3BlZC1ieTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5u
IDxiYXVlcm1hbkBsaW51eC52bmV0LmlibS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUaGlhZ28g
SnVuZyBCYXVlcm1hbm4gPGJhdWVybWFuQGxpbnV4LnZuZXQuaWJtLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IFR1c2hhciBTdWdhbmRoaSA8dHVzaGFyc3VAbGludXgubWljcm9zb2Z0LmNvbT4N
Ci0tLQ0KIHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMgfCAzOCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9u
cygrKQ0KDQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMu
YyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMNCmluZGV4IGY3OTljYzI3
OGE5YS4uNTc3NDYyZTlmOWNjIDEwMDY0NA0KLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2lt
YS9pbWFfa2V4ZWMuYw0KKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMu
Yw0KQEAgLTczLDYgKzczLDQ0IEBAIHN0YXRpYyBpbnQgaW1hX2R1bXBfbWVhc3VyZW1lbnRf
bGlzdCh1bnNpZ25lZCBsb25nICpidWZmZXJfc2l6ZSwgdm9pZCAqKmJ1ZmZlciwNCiAJcmV0
dXJuIHJldDsNCiB9DQogDQorLyoNCisgKiBDYWxsZWQgZHVyaW5nIGtleGVjIGV4ZWN1dGUg
c28gdGhhdCBJTUEgY2FuIHNhdmUgdGhlIG1lYXN1cmVtZW50IGxpc3QuDQorICovDQorc3Rh
dGljIGludCBpbWFfdXBkYXRlX2tleGVjX2J1ZmZlcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sg
KnNlbGYsDQorCQkJCSAgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpkYXRhKQ0KK3sN
CisJdm9pZCAqa2V4ZWNfYnVmZmVyID0gTlVMTDsNCisJc2l6ZV90IGtleGVjX2J1ZmZlcl9z
aXplOw0KKwlpbnQgcmV0Ow0KKw0KKwlpZiAoIWtleGVjX2luX3Byb2dyZXNzKQ0KKwkJcmV0
dXJuIE5PVElGWV9PSzsNCisNCisJa2V4ZWNfYnVmZmVyX3NpemUgPSBpbWFfZ2V0X2JpbmFy
eV9ydW50aW1lX3NpemUoKTsNCisJaWYgKGtleGVjX2J1ZmZlcl9zaXplID4NCisJICAgIChr
ZXhlY19zZWdtZW50X3NpemUgLSBzaXplb2Yoc3RydWN0IGltYV9rZXhlY19oZHIpKSkgew0K
KwkJcHJfZXJyKCJCaW5hcnkgbWVhc3VyZW1lbnQgbGlzdCBncmV3IHRvbyBsYXJnZS5cbiIp
Ow0KKwkJZ290byBvdXQ7DQorCX0NCisNCisJaW1hX2R1bXBfbWVhc3VyZW1lbnRfbGlzdCgm
a2V4ZWNfYnVmZmVyX3NpemUsICZrZXhlY19idWZmZXIsDQorCQkJCSAga2V4ZWNfc2VnbWVu
dF9zaXplKTsNCisJaWYgKCFrZXhlY19idWZmZXIpIHsNCisJCXByX2VycigiTm90IGVub3Vn
aCBtZW1vcnkgZm9yIHRoZSBrZXhlYyBtZWFzdXJlbWVudCBidWZmZXIuXG4iKTsNCisJCWdv
dG8gb3V0Ow0KKwl9DQorCXJldCA9IGtleGVjX3VwZGF0ZV9zZWdtZW50KGtleGVjX2J1ZmZl
ciwga2V4ZWNfYnVmZmVyX3NpemUsDQorCQkJCSAgIGtleGVjX2J1ZmZlcl9sb2FkX2FkZHIs
IGtleGVjX3NlZ21lbnRfc2l6ZSk7DQorCWlmIChyZXQpDQorCQlwcl9lcnIoIkVycm9yIHVw
ZGF0aW5nIGtleGVjIGJ1ZmZlcjogJWRcbiIsIHJldCk7DQorb3V0Og0KKwlyZXR1cm4gTk9U
SUZZX09LOw0KK30NCisNCitzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgdXBkYXRlX2J1ZmZlcl9u
YiA9IHsNCisJLm5vdGlmaWVyX2NhbGwgPSBpbWFfdXBkYXRlX2tleGVjX2J1ZmZlciwNCit9
Ow0KKw0KIC8qDQogICogQ2FsbGVkIGR1cmluZyBrZXhlY19maWxlX2xvYWQgc28gdGhhdCBJ
TUEgY2FuIGFkZCBhIHNlZ21lbnQgdG8gdGhlIGtleGVjDQogICogaW1hZ2UgZm9yIHRoZSBt
ZWFzdXJlbWVudCBsaXN0IGZvciB0aGUgbmV4dCBrZXJuZWwuDQotLSANCjIuMjUuMQ0KDQo=

--------------L7ZriuapA8Hy7AZCrGrS2eMk
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-kexec_file-Add-mechanism-to-update-kexec-segments.patch"
Content-Disposition: attachment;
 filename*0="0001-kexec_file-Add-mechanism-to-update-kexec-segments.patch"
Content-Transfer-Encoding: base64

RnJvbSAwMTMzYjE5Y2VkNDFhMTAxMzQ5NzNjMzc0YWRiMzQyOTMyM2IyMGU0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVHVzaGFyIFN1Z2FuZGhpIDx0dXNoYXJzdUBsaW51
eC5taWNyb3NvZnQuY29tPg0KRGF0ZTogTW9uLCAzIEphbiAyMDIyIDE0OjA4OjU2IC0wODAw
DQpTdWJqZWN0OiBbUEFUQ0ggMS8zXSBrZXhlY19maWxlOiBBZGQgbWVjaGFuaXNtIHRvIHVw
ZGF0ZSBrZXhlYyBzZWdtZW50cw0KDQprZXhlY191cGRhdGVfc2VnbWVudCBhbGxvd3MgYSBn
aXZlbiBzZWdtZW50IGluIGtleGVjX2ltYWdlIHRvIGhhdmUNCml0cyBjb250ZW50cyB1cGRh
dGVkLiBUaGlzIGlzIHVzZWZ1bCBpZiB0aGUgY3VycmVudCBrZXJuZWwgd2FudHMgdG8NCnNl
bmQgaW5mb3JtYXRpb24gdG8gdGhlIG5leHQga2VybmVsIHRoYXQgaXMgdXAtdG8tZGF0ZSBh
dCB0aGUgdGltZSBvZg0KcmVib290Lg0KDQpDby1kZXZlbG9wZWQtYnk6IFRoaWFnbyBKdW5n
IEJhdWVybWFubiA8YmF1ZXJtYW5AbGludXgudm5ldC5pYm0uY29tPg0KU2lnbmVkLW9mZi1i
eTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBsaW51eC52bmV0LmlibS5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgU3VnYW5kaGkgPHR1c2hhcnN1QGxpbnV4Lm1pY3Jv
c29mdC5jb20+DQotLS0NCiBpbmNsdWRlL2xpbnV4L2tleGVjLmggfCAgIDIgKw0KIGtlcm5l
bC9rZXhlY19jb3JlLmMgICB8IDEwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2tleGVjLmggYi9pbmNsdWRlL2xpbnV4L2tleGVj
LmgNCmluZGV4IDBjOTk0YWUzNzcyOS4uZDE0YzliZTdmYWEzIDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9saW51eC9rZXhlYy5oDQorKysgYi9pbmNsdWRlL2xpbnV4L2tleGVjLmgNCkBAIC0x
ODIsNiArMTgyLDggQEAgaW50IGtleGVjX3B1cmdhdG9yeV9nZXRfc2V0X3N5bWJvbChzdHJ1
Y3Qga2ltYWdlICppbWFnZSwgY29uc3QgY2hhciAqbmFtZSwNCiAJCQkJICAgdm9pZCAqYnVm
LCB1bnNpZ25lZCBpbnQgc2l6ZSwNCiAJCQkJICAgYm9vbCBnZXRfdmFsdWUpOw0KIHZvaWQg
KmtleGVjX3B1cmdhdG9yeV9nZXRfc3ltYm9sX2FkZHIoc3RydWN0IGtpbWFnZSAqaW1hZ2Us
IGNvbnN0IGNoYXIgKm5hbWUpOw0KK2ludCBrZXhlY191cGRhdGVfc2VnbWVudChjb25zdCBj
aGFyICpidWZmZXIsIHVuc2lnbmVkIGxvbmcgYnVmc3osDQorCQkJIHVuc2lnbmVkIGxvbmcg
bG9hZF9hZGRyLCB1bnNpZ25lZCBsb25nIG1lbXN6KTsNCiANCiAvKiBBcmNoaXRlY3R1cmVz
IG1heSBvdmVycmlkZSB0aGUgYmVsb3cgZnVuY3Rpb25zICovDQogaW50IGFyY2hfa2V4ZWNf
a2VybmVsX2ltYWdlX3Byb2JlKHN0cnVjdCBraW1hZ2UgKmltYWdlLCB2b2lkICpidWYsDQpk
aWZmIC0tZ2l0IGEva2VybmVsL2tleGVjX2NvcmUuYyBiL2tlcm5lbC9rZXhlY19jb3JlLmMN
CmluZGV4IDVhNWQxOTJhODlhYy4uYWY4ZWE3YmYwMjUxIDEwMDY0NA0KLS0tIGEva2VybmVs
L2tleGVjX2NvcmUuYw0KKysrIGIva2VybmVsL2tleGVjX2NvcmUuYw0KQEAgLTc3OSw2ICs3
NzksMTA4IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqa2ltYWdlX2FsbG9jX3BhZ2Uoc3RydWN0
IGtpbWFnZSAqaW1hZ2UsDQogCXJldHVybiBwYWdlOw0KIH0NCiANCisvKioNCisgKiBrZXhl
Y191cGRhdGVfc2VnbWVudCAtIHVwZGF0ZSB0aGUgY29udGVudHMgb2YgYSBraW1hZ2Ugc2Vn
bWVudA0KKyAqIEBidWZmZXI6CU5ldyBjb250ZW50cyBvZiB0aGUgc2VnbWVudC4NCisgKiBA
YnVmc3o6CUBidWZmZXIgc2l6ZS4NCisgKiBAbG9hZF9hZGRyOglTZWdtZW50J3MgcGh5c2lj
YWwgYWRkcmVzcyBpbiB0aGUgbmV4dCBrZXJuZWwuDQorICogQG1lbXN6OglTZWdtZW50IHNp
emUuDQorICoNCisgKiBUaGlzIGZ1bmN0aW9uIGFzc3VtZXMga2V4ZWNfbXV0ZXggaXMgaGVs
ZC4NCisgKg0KKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJubyBvbiBl
cnJvci4NCisgKi8NCitpbnQga2V4ZWNfdXBkYXRlX3NlZ21lbnQoY29uc3QgY2hhciAqYnVm
ZmVyLCB1bnNpZ25lZCBsb25nIGJ1ZnN6LA0KKwkJCSB1bnNpZ25lZCBsb25nIGxvYWRfYWRk
ciwgdW5zaWduZWQgbG9uZyBtZW1zeikNCit7DQorCWludCBpOw0KKwl1bnNpZ25lZCBsb25n
IGVudHJ5Ow0KKwl1bnNpZ25lZCBsb25nICpwdHIgPSBOVUxMOw0KKwl2b2lkICpkZXN0ID0g
TlVMTDsNCisNCisJaWYgKGtleGVjX2ltYWdlID09IE5VTEwpIHsNCisJCXByX2VycigiQ2Fu
J3QgdXBkYXRlIHNlZ21lbnQ6IG5vIGtleGVjIGltYWdlIGxvYWRlZC5cbiIpOw0KKwkJcmV0
dXJuIC1FSU5WQUw7DQorCX0NCisNCisJLyoNCisJICoga2V4ZWNfYWRkX2J1ZmZlciByb3Vu
ZHMgdXAgc2VnbWVudCBzaXplcyB0byBQQUdFX1NJWkUsIHNvDQorCSAqIHdlIGhhdmUgdG8g
ZG8gaXQgaGVyZSBhcyB3ZWxsLg0KKwkgKi8NCisJbWVtc3ogPSBBTElHTihtZW1zeiwgUEFH
RV9TSVpFKTsNCisNCisJZm9yIChpID0gMDsgaSA8IGtleGVjX2ltYWdlLT5ucl9zZWdtZW50
czsgaSsrKQ0KKwkJLyogV2Ugb25seSBzdXBwb3J0IHVwZGF0aW5nIHdob2xlIHNlZ21lbnRz
LiAqLw0KKwkJaWYgKGxvYWRfYWRkciA9PSBrZXhlY19pbWFnZS0+c2VnbWVudFtpXS5tZW0g
JiYNCisJCSAgICBtZW1zeiA9PSBrZXhlY19pbWFnZS0+c2VnbWVudFtpXS5tZW1zeikgew0K
KwkJCS8qDQorCQkJICogVHVzaGFyU3U6IE5vdCBkb2luZyB0aGUgY2hlY2tzdW0gdGVzdCBm
b3IgdGhlIHRpbWUgYmVpbmcuDQorCQkJICogaWYgKGtleGVjX2ltYWdlLT5zZWdtZW50W2ld
LmRvX2NoZWNrc3VtKSB7DQorCQkJICogICAgIHByX2VycigiVHJ5aW5nIHRvIHVwZGF0ZSBu
b24tbW9kaWZpYWJsZSBzZWdtZW50LlxuIik7DQorCQkJICogICAgIHJldHVybiAtRUlOVkFM
Ow0KKwkJCSAqIH0NCisJCQkgKi8NCisJCQlicmVhazsNCisJCX0NCisNCisJaWYgKGkgPT0g
a2V4ZWNfaW1hZ2UtPm5yX3NlZ21lbnRzKSB7DQorCQlwcl9lcnIoIkNvdWxkbid0IGZpbmQg
c2VnbWVudCB0byB1cGRhdGU6IDB4JWx4LCBzaXplIDB4JWx4XG4iLA0KKwkJICAgICAgIGxv
YWRfYWRkciwgbWVtc3opOw0KKwkJcmV0dXJuIC1FSU5WQUw7DQorCX0NCisNCisJZm9yIChl
bnRyeSA9IGtleGVjX2ltYWdlLT5oZWFkOyAhKGVudHJ5ICYgSU5EX0RPTkUpICYmIG1lbXN6
Ow0KKwkgICAgIGVudHJ5ID0gKnB0cisrKSB7DQorCQl2b2lkICphZGRyID0gKHZvaWQgKikg
KGVudHJ5ICYgUEFHRV9NQVNLKTsNCisNCisJCXN3aXRjaCAoZW50cnkgJiBJTkRfRkxBR1Mp
IHsNCisJCWNhc2UgSU5EX0RFU1RJTkFUSU9OOg0KKwkJCWRlc3QgPSBhZGRyOw0KKwkJCWJy
ZWFrOw0KKwkJY2FzZSBJTkRfSU5ESVJFQ1RJT046DQorCQkJcHRyID0gX192YShhZGRyKTsN
CisJCQlicmVhazsNCisJCWNhc2UgSU5EX1NPVVJDRToNCisJCQkvKiBTaG91bGRuJ3QgaGFw
cGVuLCBidXQgdmVyaWZ5IGp1c3QgdG8gYmUgc2FmZS4gKi8NCisJCQlpZiAoZGVzdCA9PSBO
VUxMKSB7DQorCQkJCXByX2VycigiSW52YWxpZCBrZXhlYyBlbnRyaWVzIGxpc3QuIik7DQor
CQkJCXJldHVybiAtRUlOVkFMOw0KKwkJCX0NCisNCisJCQlpZiAoZGVzdCA9PSAodm9pZCAq
KSBsb2FkX2FkZHIpIHsNCisJCQkJc3RydWN0IHBhZ2UgKnBhZ2U7DQorCQkJCWNoYXIgKnB0
cjsNCisJCQkJc2l6ZV90IHVjaHVuaywgbWNodW5rOw0KKw0KKwkJCQlwYWdlID0ga21hcF90
b19wYWdlKGFkZHIpOw0KKw0KKwkJCQlwdHIgPSBrbWFwX2F0b21pYyhwYWdlKTsNCisJCQkJ
cHRyICs9IGxvYWRfYWRkciAmIH5QQUdFX01BU0s7DQorCQkJCW1jaHVuayA9IG1pbl90KHNp
emVfdCwgbWVtc3osDQorCQkJCQkgICAgICAgUEFHRV9TSVpFIC0gKGxvYWRfYWRkciAmIH5Q
QUdFX01BU0spKTsNCisJCQkJdWNodW5rID0gbWluKGJ1ZnN6LCBtY2h1bmspOw0KKwkJCQlt
ZW1jcHkocHRyLCBidWZmZXIsIHVjaHVuayk7DQorDQorCQkJCWt1bm1hcF9hdG9taWMocHRy
KTsNCisNCisJCQkJYnVmc3ogLT0gdWNodW5rOw0KKwkJCQlsb2FkX2FkZHIgKz0gbWNodW5r
Ow0KKwkJCQlidWZmZXIgKz0gbWNodW5rOw0KKwkJCQltZW1zeiAtPSBtY2h1bms7DQorCQkJ
fQ0KKwkJCWRlc3QgKz0gUEFHRV9TSVpFOw0KKwkJfQ0KKw0KKwkJLyogU2hvdWxkbid0IGhh
cHBlbiwgYnV0IHZlcmlmeSBqdXN0IHRvIGJlIHNhZmUuICovDQorCQlpZiAocHRyID09IE5V
TEwpIHsNCisJCQlwcl9lcnIoIkludmFsaWQga2V4ZWMgZW50cmllcyBsaXN0LiIpOw0KKwkJ
CXJldHVybiAtRUlOVkFMOw0KKwkJfQ0KKwl9DQorDQorCXJldHVybiAwOw0KK30NCisNCiBz
dGF0aWMgaW50IGtpbWFnZV9sb2FkX25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgKmlt
YWdlLA0KIAkJCQkJIHN0cnVjdCBrZXhlY19zZWdtZW50ICpzZWdtZW50KQ0KIHsNCi0tIA0K
Mi4yNS4xDQoNCg==

--------------L7ZriuapA8Hy7AZCrGrS2eMk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------L7ZriuapA8Hy7AZCrGrS2eMk--


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DA1E677FF
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Mime-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LECYLnqCb405TUq3W9ksXgBDUc5tt5CGXGJFBvuN7S0=; b=Zo1Q31kOdo5mj6WhyUZTcAedhv
	2j9VTUiI0TIRatnZXdFBkGEyZV9FiJfgrxeh53mnZ41/weDCpcpZFSAPbkettFx7wIqKQqGVW8iJE
	qCq/OzmSf1YQyLKHtggDpmPahjcMXORXQcr6UvRzirGub+JIrCJr8IMUjXdAOn6RarUeLrP5KZzhg
	FatVoZ+tsR1mLNwY6gefk9cwk/l4WP8j0Z2O/oNRJFOUVVv4egia4HyFoLW+JTbbPnkWDTH11nVl+
	j7R3ZkgYFZbWSYH45BiJwz2KXAQhG4p73RHwb7Q/flQx1F4kToernSHDnabUNxYMkAHFGSesdqKTP
	dPf2Rxww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7F52-00000009qpD-1bCB;
	Sat, 02 Nov 2024 14:26:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7F4y-00000009qo4-44k8
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 14:26:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C49315C10E0;
	Sat,  2 Nov 2024 14:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96244C4CEC3;
	Sat,  2 Nov 2024 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730557575;
	bh=ExNNc/F5UO1JUVBaiGGCw7c3A43cKS2+lAROsZ10LyM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nQql5lkZBVmH0d0x+iIN7RERdTxT1VWSNVDUNv8yOm6lxykCMTQaPSKL5ooahHWEh
	 DO9hUBWiL2XXmRcF4qcJrSyqSn820XiBXUyRoquxsj06Jf5S3nT+QnhKRH1C5c1QNk
	 5d/EMzCmbjKgYG22kTOvkdAe8PzSJyR1A3g3QlSiCBgmWbf4rbwR/qvhlGdIiVYILZ
	 yfxj71bHnf6z4NylyUUnbCfNLq2keFTDaldLkSYRJPh/DjVYvFa7QuH9yDiLp6xnlC
	 26LHKjYvVl1haIY3dk69tsRCmHKdkgl142SBypxM+Vii5DYnKUHfQ+VWQbLC3lXaI9
	 NL3thq++CmtUg==
Content-Type: multipart/mixed;
 boundary=73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 16:26:11 +0200
Message-Id: <D5BRGKZLI186.20G9U85Q2XRPP@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 16/20] tpm: Make locality requests return consistent
 values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-17-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-17-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_072617_106620_A8CFDAE4 
X-CRM114-Status: GOOD (  21.96  )
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

--73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539
Content-Type: multipart/alternative;
 boundary=7188c54ccba4660edec87ffb8413ca5ac7c0fcf2c19a242a478fa4dddcf0

--7188c54ccba4660edec87ffb8413ca5ac7c0fcf2c19a242a478fa4dddcf0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The function tpm_tis_request_locality() is expected to return the localit=
y
> value that was requested, or a negative error code upon failure. If it is=
 called
> while locality_count of struct tis_data is non-zero, no actual locality r=
equest
> will be sent. Because the ret variable is initially set to 0, the
> locality_count will still get increased, and the function will return 0. =
For a
> caller, this would indicate that locality 0 was successfully requested an=
d not
> the state changes just mentioned.
>
> Additionally, the function __tpm_tis_request_locality() provides inconsis=
tent
> error codes. It will provide either a failed IO write or a -1 should it h=
ave
> timed out waiting for locality request to succeed.
>
> This commit changes __tpm_tis_request_locality() to return valid negative=
 error
> codes to reflect the reason it fails. It then adjusts the return value ch=
eck in
> tpm_tis_request_locality() to check for a non-negative return value befor=
e
> incrementing locality_cout. In addition, the initial value of the ret val=
ue is
> set to a negative error to ensure the check does not pass if
> __tpm_tis_request_locality() is not called.

Tweaked version attached with cruft removed and story cleared.

BR, Jarkko

--7188c54ccba4660edec87ffb8413ca5ac7c0fcf2c19a242a478fa4dddcf0--

--73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-tpm-Support-multiple-localities-in-tpm_tis_request_l.patch
Content-Type: text/x-patch; charset=utf-8;
 name=0001-tpm-Support-multiple-localities-in-tpm_tis_request_l.patch

RnJvbSBmZDMwN2ZkYTU3OGUwNGU0ZGVmYjZlMGZmNDdmOGZlMjhhOTk5ZDRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiRGFuaWVsIFAuIFNtaXRoIiA8ZHBzbWl0aEBhcGVydHVzc29s
dXRpb25zLmNvbT4KRGF0ZTogRnJpLCAxMyBTZXAgMjAyNCAxMzowNToxMyAtMDcwMApTdWJqZWN0
OiBbUEFUQ0hdIHRwbTogU3VwcG9ydCBtdWx0aXBsZSBsb2NhbGl0aWVzIGluCiB0cG1fdGlzX3Jl
cXVlc3RfbG9jYWxpdHkoKQoKVmFsaWRhdGUgdGhhdCB0aGUgaW5wdXQgbG9jYWxpdHkgaXMgd2l0
aGluIHRoZSBjb3JyZWN0IHJhbmdlLCBhcyBzcGVjaWZpZWQKYnkgVENHIHN0YW5kYXJkcywgYW5k
IGluY3JlYXNlIHRoZSBsb2NhbGl0eSBjb3VudCBhbHNvIGZvciB0aGUgcG9zaXRpdmUKcmV0dXJu
IHZhbHVlcy4KClNpZ25lZC1vZmYtYnk6IERhbmllbCBQLiBTbWl0aCA8ZHBzbWl0aEBhcGVydHVz
c29sdXRpb25zLmNvbT4KU2lnbmVkLW9mZi1ieTogUm9zcyBQaGlsaXBzb24gPHJvc3MucGhpbGlw
c29uQG9yYWNsZS5jb20+ClNpZ25lZC1vZmYtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtl
cm5lbC5vcmc+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDUgKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuYwppbmRleCAzNTE3ZGI3MTA0MjMuLjc1ZmI1OWRmNzVhMyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBt
L3RwbV90aXNfY29yZS5jCkBAIC0yMzQsMTAgKzIzNCwxMyBAQCBzdGF0aWMgaW50IHRwbV90aXNf
cmVxdWVzdF9sb2NhbGl0eShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIGludCBsKQogCXN0cnVjdCB0
cG1fdGlzX2RhdGEgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoJmNoaXAtPmRldik7CiAJaW50IHJl
dCA9IDA7CiAKKwlpZiAobCA8IDAgfHwgbCA+IFRQTV9NQVhfTE9DQUxJVFkpCisJCXJldHVybiAt
RUlOVkFMOworCiAJbXV0ZXhfbG9jaygmcHJpdi0+bG9jYWxpdHlfY291bnRfbXV0ZXgpOwogCWlm
IChwcml2LT5sb2NhbGl0eV9jb3VudCA9PSAwKQogCQlyZXQgPSBfX3RwbV90aXNfcmVxdWVzdF9s
b2NhbGl0eShjaGlwLCBsKTsKLQlpZiAoIXJldCkKKwlpZiAocmV0ID49IDApCiAJCXByaXYtPmxv
Y2FsaXR5X2NvdW50Kys7CiAJbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NhbGl0eV9jb3VudF9tdXRl
eCk7CiAJcmV0dXJuIHJldDsKLS0gCjIuNDcuMAoK
--73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539--


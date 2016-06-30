Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIcbt-0006hi-Tp
 for kexec@lists.infradead.org; Thu, 30 Jun 2016 14:06:30 +0000
Date: Thu, 30 Jun 2016 10:05:58 -0400
From: Dave Young <dyoung@redhat.com>
Subject: kexec_file_load signature verification failure
Message-ID: <20160630140558.GA5142@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Howells <dhowells@redhat.com>
Cc: pjones@redhat.com, kexec@lists.infradead.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, David

kexec_file_load fails with a Bad Message error with recent kernel:

kexec_file_load failed: Bad message

Debug messages:

[ 3463.794391] PEFILE: checksum @ da
[ 3463.794395] PEFILE: header size = 200
[ 3463.794397] PEFILE: cert = 898 @4a5370 [97 08 00 00 00 02 02 00 30 82
08 8b 06 09 2a 86 48 86 f7 0d 01 07 02 a0 82 08 7c 30 82 08 78 02 01 01
31 0f 30 0d 06 09 60 86 48 01 65 03 04 02 01 05 00 30 5c 06 0a 2b 06 01
04 01 82 37 02 01]
[ 3463.794399] PEFILE: sig wrapper = { 897, 200, 2 }
[ 3463.794404] PKCS7: Got data
[ 3463.794407] X.509: PubKey Algo: 9
[ 3463.794411] X.509: Extension: 53
[ 3463.794412] X.509: Extension: 50
[ 3463.794413] X.509: Extension: 49
[ 3463.794414] X.509: subjkeyid 9d5c9a70fe6578e1ba171ba2ab9f3449d6688559
[ 3463.794415] X.509: Extension: 56
[ 3463.794417] X.509: x509_note_tbs_certificate(,4,04,8,780)!
[ 3463.794418] X.509: Signature type: 9 size 513
[ 3463.794419] X.509: AKID: keyid:
9d5c9a70fe6578e1ba171ba2ab9f3449d6688559
[ 3463.794420] X.509: authkeyid 9d5c9a70fe6578e1ba171ba2ab9f3449d6688559
[ 3463.795236] PKCS7: Got cert 1 for dyoung kernel test key
[ 3463.795238] PKCS7: - fingerprint
00d4a0934d161cab68311f301d06035504030c1664796f756e67206b65726e656c2074657374206b6579
[ 3463.795950] PKCS7: verify dyoung kernel test key: 00d4a0934d161cab68
[ 3463.795951] PKCS7: - issuer dyoung kernel test key
[ 3463.795952] PKCS7: - authkeyid.skid
9d5c9a70fe6578e1ba171ba2ab9f3449d6688559
[ 3463.795952] PKCS7: - self-signed
[ 3463.795954] Look up:
"ex:00d4a0934d161cab68311f301d06035504030c1664796f756e67206b65726e656c2074657374206b6579"
[ 3463.796642] PEFILE: Digest: 0 []
[ 3463.796644] PEFILE: Digest size mismatch (20 != 0)

Bisect results:

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[e68503bd6836ba765dc8e0ee77ea675fedc07e41] KEYS: Generalise
system_verify_data() to provide access to internal content

I can not revert this comment only to test, seems there are a lot of
dependencies.

Could you please help on this issue?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

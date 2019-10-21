Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMaFG-00071R-VU
 for kexec@lists.infradead.org; Mon, 21 Oct 2019 16:09:24 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LG4dHD149596
 for <kexec@lists.infradead.org>; Mon, 21 Oct 2019 16:09:20 GMT
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2vqswt8utk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 21 Oct 2019 16:09:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LG84VZ096894
 for <kexec@lists.infradead.org>; Mon, 21 Oct 2019 16:09:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2vrcmndpj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 21 Oct 2019 16:09:20 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LG9JUZ014641
 for <kexec@lists.infradead.org>; Mon, 21 Oct 2019 16:09:19 GMT
From: John Donnelly <john.p.donnelly@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Mon, 21 Oct 2019 11:09:17 -0500
Subject: Makedumpfile help for 5.4.0.rc3 :  Arm 
Message-Id: <1C379272-3B10-432C-8A83-8F3008CEE87F@oracle.com>
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
To: kexec@lists.infradead.org

CgpIZWxsbywKCgpLYXp1aGl0byBIYWdpbyBhc2tlZCBtZSB0byBzaGFyZSBteSB0ZXN0IHJlc3Vs
dHMgb24gdGhpcyBwYXRjaCBmb3IgbWFrZWR1bXBmaWxlIDoKCgpodHRwczovL3NvdXJjZWZvcmdl
Lm5ldC9wL21ha2VkdW1wZmlsZS9jb2RlL2NpLzdiZGI0NjhjMmM5OWRkNzgwYzlhNTMyMWY5M2M3
OWNiZmRjZTI1MjcvCgpBbmQgSSB3YXMgc3VjY2Vzc2Z1bGx5IGFibGUgdG8gZ2V0IHZtY29yZSBk
dW1wcyBvbiB2bWxpbnV6LTUuMy42IGFuZCA1LjQuMC1yYzMgSW50ZWwgKCB4ODYtNjQpIGtlcm5l
bHMuCgpJIGFtIHN0aWxsIGhhdmluZyBkaWZmaWN1bHRpZXMgZ2V0dGluZyB2bWNvcmVzIG9uIDUu
NC4wLnJjMyAgIEFybSBrZXJuZWxzIHdpdGggdGhpcyB1cGRhdGUgdG8gbWFrZWR1bXBmaWxlLiAK
CkkgZ2V0IHRoaXMgbWVzc2FnZTsKCgpCdWZmZXIgc2l6ZSBmb3IgdGhlIGN5Y2xpYyBtb2RlOiAz
MTQ1NzI4CnZhX2JpdHMgICAgICA6IDQ3CnBhZ2Vfb2Zmc2V0ICA6IGZmZmZjMDAwMDAwMDAwMDAK
Y2FsY3VsYXRlX3BsYXRfY29uZmlnOiBQQUdFIFNJWkUgMHgxMDAwMCBhbmQgVkEgQml0cyA0NyBu
b3Qgc3VwcG9ydGVkCmdldF9tYWNoZGVwX2luZm9fYXJtNjQ6IENhbid0IGRldGVybWluZSBwbGF0
Zm9ybSBjb25maWcgdmFsdWVzCgptYWtlZHVtcGZpbGUgRmFpbGVkLgoKCkFueSBzdWdnZXN0aW9u
cyB3ZWxjb21lZAoKCuKAlAoKCgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

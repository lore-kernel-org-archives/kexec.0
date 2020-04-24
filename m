Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRyjy-00080P-J4
 for kexec@lists.infradead.org; Fri, 24 Apr 2020 13:51:40 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ODnYjD178219
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 13:49:34 GMT
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 30k7qe6xb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 13:49:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ODfcrR155850
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 13:49:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 30k7qx6fse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 13:49:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03ODnXvE023630
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 13:49:33 GMT
From: John Donnelly <john.p.donnelly@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Fri, 24 Apr 2020 08:49:31 -0500
Subject: [crash - Question ] mod -s <module>   not working with compressed
 modules 
Message-Id: <4FA43F2A-C118-4102-BC03-19B55A5AFEA9@oracle.com>
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
To: kexec mailing list <kexec@lists.infradead.org>

SGkgCgogSSBvYnNlcnZlZCB0aGF0ICBsb2FkaW5nIG1vZHVsZSBzeW1ib2xzIGZyb20gYSBjb21w
cmVzc2VkIGtvLnh6ICAoIGNyYXNoIDcuMi4zLTEwLmVsNyApIGRvZXMgbm90IHdvcmssCmFuZCB0
aGUgZGVzaXJlZCBtb2R1bGUgaGFzIHRvIGJlIHVuLWNvbXByZXNzZWQgLiBEb2VzIGFueW9uZSBr
bm93IGlmIHRoZXJlIGlzIGEgcmVjZW50IHBhdGNoIHRoYXQgYWRkcmVzc2VzIHRoaXMgPwoKCkV4
YW1wbGU6CgpNb2R1bGVzIGFyZSBsb2NhdGVkIGF0IHRoZSDigJRtb2QgcGF0aCA6CgpjcmFzaCAg
IC1zICBgZmluZCBrZXJuZWwtdWVrLWRlYnVnaW5mby00LjE0LjM1LTE5MDIuMzAyLjEuMDEuZWw3
dWVrLnJjMSAtbmFtZSB2bWxpbnV4IGAgdm1jb3JlIC0tbW9kIC4va2VybmVsLXVlay00LjE0LjM1
LTE5MDIuMzAyLjEuMDEudHN0MTcwNTlfdTMuZWw3dWVrLnJjMS9saWIvbW9kdWxlcy80LjE0LjM1
LTE5MDIuMzAyLjEuMDEuZWw3dWVrLnJjMS54ODZfNjQva2VybmVsLwoKCmNyYXNoPiBtb2QgLVMK
bW9kOiBjYW5ub3QgZmluZCBvciBsb2FkIG9iamVjdCBmaWxlIGZvciB1c2Jfc3RvcmFnZSBtb2R1
bGUKbW9kOiBjYW5ub3QgZmluZCBvciBsb2FkIG9iamVjdCBmaWxlIGZvciBkY2EgbW9kdWxlCm1v
ZDogY2Fubm90IGZpbmQgb3IgbG9hZCBvYmplY3QgZmlsZSBmb3IgZmJfc3lzX2ZvcHMgbW9kdWxl
Cm1vZDogY2Fubm90IGZpbmQgb3IgbG9hZCBvYmplY3QgZmlsZSBmb3IgdWFzIG1vZHVsZQogICAg
IE1PRFVMRSAgICAgICBOQU1FICAgICAgICAgICAgICAgICAgICAgU0laRSAgT0JKRUNUIEZJTEUK
ZmZmZmZmZmZjMDc0MDBjMCAgcWxhMnh4eCAgICAgICAgICAgICAgICA3OTQ2MjQgIC4va2VybmVs
LXVlay00LjE0LjM1LTE5MDIuMzAyLjEuMDEuZWw3dWVrLnJjMS9saWIvbW9kdWxlcy80LjE0LjM1
LTE5MDIuMzAyLjEuMDEuZWw3dWVrLnJjMS54ODZfNjQva2VybmVsL2RyaXZlcnMvc2NzaS9xbGEy
eHh4L3FsYTJ4eHgua28gCgpJIHVuLWNvbXByZXNzZWQgcWxhMnh4eC5rby54eiAgc28gaXQgd2Fz
IGZvdW5kLiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

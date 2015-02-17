Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-x22f.google.com ([2607:f8b0:4003:c01::22f])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YNnFa-0004Hy-S2
 for kexec@lists.infradead.org; Tue, 17 Feb 2015 18:52:03 +0000
Received: by mail-ob0-f175.google.com with SMTP id va2so56673682obc.6
 for <kexec@lists.infradead.org>; Tue, 17 Feb 2015 10:51:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1423730418-5173-1-git-send-email-2ameya@gmail.com>
References: <1423730418-5173-1-git-send-email-2ameya@gmail.com>
Date: Tue, 17 Feb 2015 10:51:40 -0800
Message-ID: <CAFAJAEyMNZLJspRZKFyOc5GCDqcok47Joaa-f_aiMU3dFZ48-Q@mail.gmail.com>
Subject: Re: [PATCH] i386: bzImage: Fix -Wunused-but-set-variable compilation
 warning
From: Ameya Palande <2ameya@gmail.com>
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
Cc: Simon Horman <horms@verge.net.au>

T24gVGh1LCBGZWIgMTIsIDIwMTUgYXQgMTI6NDAgQU0sIEFtZXlhIFBhbGFuZGUgPDJhbWV5YUBn
bWFpbC5jb20+IHdyb3RlOgo+IGtleGVjL2FyY2gvaTM4Ni9rZXhlYy1iekltYWdlLmM6MTExOjg6
IHdhcm5pbmc6IHZhcmlhYmxlCj4g4oCYa2VybmVsX3ZlcnNpb27igJkgc2V0IGJ1dCBub3QgdXNl
ZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPgo+IFNpZ25lZC1vZmYtYnk6IEFtZXlhIFBh
bGFuZGUgPDJhbWV5YUBnbWFpbC5jb20+CgpBbnkgdXBkYXRlPwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
